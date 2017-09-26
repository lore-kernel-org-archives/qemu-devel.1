Received: from eggs.gnu.org ([2001:4830:134:3::10]:59714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh7-0004qe-Rc
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh6-0001Ff-Mw
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:29 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52116)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnh6-0001FR-Au
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:28 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:26 +0300
Message-ID: <150642398608.3900.11026705123393046138.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 25/43] windbg: implemented
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

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 windbgstub-utils.c              |   81 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++
 3 files changed, 91 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 0b683f95ac..e368b2e85d 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -106,6 +106,8 @@ void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
+void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
+void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index b15d84c8d0..c3ae2ddf5b 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -289,6 +289,18 @@ static int windbg_write_context(CPUState *cpu, uint8_t *buf, int len,
     return 0;
 }
 
+static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int len,
+                               int offset)
+{
+    return 0;
+}
+
+static int windbg_write_ks_regs(CPUState *cpu, uint8_t *buf, int len,
+                                int offset)
+{
+    return 0;
+}
+
 void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
 {
     DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
@@ -361,6 +373,75 @@ void kd_api_set_context(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_read_control_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err = -1;
+
+    len = MIN(ldl_p(&mem->TransferCount), PACKET_MAX_SIZE - M64_SIZE);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
+        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
+
+        uint32_t from_context = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
+        uint32_t from_ks_regs = len - from_context;
+
+        if (from_context > 0) {
+            err = windbg_read_context(cpu, pd->extra, from_context, addr);
+        }
+        if (from_ks_regs > 0) {
+            err = windbg_read_ks_regs(cpu, pd->extra + from_context,
+                                      from_ks_regs, addr -
+                                      sizeof(CPU_CONTEXT) + from_context);
+        }
+    }
+
+    if (!err) {
+        pd->extra_size = len;
+        mem->ActualBytesRead = ldl_p(&len);
+    } else {
+        pd->extra_size = mem->ActualBytesRead = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
+void kd_api_write_control_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    uint32_t len;
+    target_ulong addr;
+    int err = -1;
+
+    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
+        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
+
+        uint32_t to_context = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
+        uint32_t to_ks_regs = len - to_context;
+
+        if (to_context > 0) {
+            err = windbg_write_context(cpu, pd->extra, to_context, addr);
+        }
+        if (to_ks_regs > 0) {
+            err = windbg_write_ks_regs(cpu, pd->extra + to_context, to_ks_regs,
+                                       addr - sizeof(CPU_CONTEXT) + to_context);
+        }
+    }
+
+    pd->extra_size = 0;
+    if (!err) {
+        mem->ActualBytesWritten = ldl_p(&len);
+    } else {
+        mem->ActualBytesWritten = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+}
+
 void kd_api_unsupported(CPUState *cpu, PacketData *pd)
 {
     WINDBG_ERROR("Catched unimplemented api %s",
diff --git a/windbgstub.c b/windbgstub.c
index 23930d195e..24d0031167 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -149,6 +149,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_set_context(cpu, &ctx->data);
         break;
 
+    case DbgKdReadControlSpaceApi:
+        kd_api_read_control_space(cpu, &ctx->data);
+        break;
+
+    case DbgKdWriteControlSpaceApi:
+        kd_api_write_control_space(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
