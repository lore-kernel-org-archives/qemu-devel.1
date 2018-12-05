Received: from eggs.gnu.org ([2001:4830:134:3::10]:34581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhP-00033n-Mo
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhO-0006tf-O9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:43 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50648)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhO-0006tR-BL
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:42 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:54:40 +0300
Message-ID: <154401447994.8440.12847275639716493111.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 28/39] windbg: implement
 kd_api_read_control_space and kd_api_write_control_space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 target/i386/windbgstub.c        |   81 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++
 3 files changed, 91 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 6936fd0ffb..2781a54044 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -71,6 +71,8 @@ void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_context(CPUState *cs, PacketData *pd);
 void kd_api_set_context(CPUState *cs, PacketData *pd);
+void kd_api_read_control_space(CPUState *cs, PacketData *pd);
+void kd_api_write_control_space(CPUState *cs, PacketData *pd);
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 76cdc1d9a7..6d2e7de746 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -962,6 +962,87 @@ void kd_api_set_context(CPUState *cs, PacketData *pd)
     }
 }
 
+void kd_api_read_control_space(CPUState *cs, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    target_ulong addr = ldtul_p(&mem->TargetBaseAddress);
+    uint32_t len = MIN(ldl_p(&mem->TransferCount),
+                       PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    int err = 0;
+
+#ifdef TARGET_X86_64
+
+    switch (addr) {
+    case AMD64_DEBUG_CONTROL_SPACE_KPCR:
+        addr = KPCR.addr;
+        len = sizeof(target_ulong);
+        err = cpu_memory_rw_debug(cs, addr, pd->extra, len, 0);
+        break;
+
+    case AMD64_DEBUG_CONTROL_SPACE_KPRCB:
+        addr = VMEM_ADDR(cs, KPCR.addr + OFFSET_KPRCB);
+        len = sizeof(target_ulong);
+        err = cpu_memory_rw_debug(cs, addr, pd->extra, len, 0);
+        break;
+
+    case AMD64_DEBUG_CONTROL_SPACE_KSPECIAL:
+        len = MIN(len, sizeof(CPU_KSPECIAL_REGISTERS));
+        err = windbg_read_ks_regs(cs, pd->extra, len, 0, len);
+        break;
+
+    case AMD64_DEBUG_CONTROL_SPACE_KTHREAD:
+        addr = VMEM_ADDR(cs, addr + OFFSET_KPRCB_CURRTHREAD);
+        len = sizeof(target_ulong);
+        err = cpu_memory_rw_debug(cs, addr, pd->extra, len, 0);
+        break;
+    }
+
+#else /* TARGET_I386 */
+
+    err = windbg_rw_context_ex(cs, pd->extra, len, addr, len, true);
+
+#endif /* TARGET_I386 */
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+
+    pd->extra_size = len;
+    stl_p(&mem->ActualBytesRead, len);
+}
+
+void kd_api_write_control_space(CPUState *cs, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    target_ulong addr = ldtul_p(&mem->TargetBaseAddress);
+    uint32_t len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    int err = 0;
+
+#ifdef TARGET_X86_64
+
+    if (addr == AMD64_DEBUG_CONTROL_SPACE_KSPECIAL) {
+        len = MIN(len, sizeof(CPU_KSPECIAL_REGISTERS));
+        err = windbg_write_ks_regs(cs, pd->extra, len, 0, len);
+    } else {
+        err = 1;
+    }
+
+#else /* TARGET_I386 */
+
+    err = windbg_rw_context_ex(cs, pd->extra, len, addr, len, false);
+
+#endif /* TARGET_I386 */
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+
+    pd->extra_size = 0;
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
 void kd_api_get_context_ex(CPUState *cs, PacketData *pd)
 {
     DBGKD_CONTEXT_EX *ctx = &pd->m64.u.ContextEx;
diff --git a/windbgstub.c b/windbgstub.c
index e9d759cddf..328a04735f 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -165,6 +165,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_set_context(cs, data);
         break;
 
+    case DbgKdReadControlSpaceApi:
+        kd_api_read_control_space(cs, data);
+        break;
+
+    case DbgKdWriteControlSpaceApi:
+        kd_api_write_control_space(cs, data);
+        break;
+
     case DbgKdGetContextExApi:
         kd_api_get_context_ex(cs, data);
         break;
