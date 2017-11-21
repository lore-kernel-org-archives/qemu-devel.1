Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9F8-0001be-RX
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9F6-0002ud-5V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:42 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38250)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9F5-0002uQ-Ng
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:40 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:09:37 +0300
Message-ID: <151127337679.6888.4561921111146653923.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 25/45] windbg: implemented
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
 target/i386/windbgstub.c        |   89 +++++++++++++++++++++++++++++++++++++++
 windbgstub.c                    |    8 ++++
 3 files changed, 99 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index 65be4793d3..5e5893bac8 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -90,6 +90,8 @@ void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cpu, PacketData *pd);
 void kd_api_get_context(CPUState *cpu, PacketData *pd);
 void kd_api_set_context(CPUState *cpu, PacketData *pd);
+void kd_api_read_control_space(CPUState *cpu, PacketData *pd);
+void kd_api_write_control_space(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index be8fc21374..bf1afab1f8 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -285,6 +285,18 @@ static int windbg_write_context(CPUState *cpu, uint8_t *buf, int buf_size,
     return 0;
 }
 
+static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
+                               int offset, int len)
+{
+    return 0;
+}
+
+static int windbg_write_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
+                                int offset, int len)
+{
+    return 0;
+}
+
 void kd_api_get_context(CPUState *cpu, PacketData *pd)
 {
     int err;
@@ -312,6 +324,83 @@ void kd_api_set_context(CPUState *cpu, PacketData *pd)
     }
 }
 
+void kd_api_read_control_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
+    uint32_t len;
+    uint32_t context_len;
+    uint32_t ks_regs_len;
+    target_ulong addr;
+    int err = -1;
+
+    len = MIN(ldl_p(&mem->TransferCount),
+              PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
+        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
+
+        context_len = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
+        ks_regs_len = len - context_len;
+
+        if (context_len > 0) {
+            err = windbg_read_context(cpu, pd->extra, context_len, addr,
+                                      context_len);
+        }
+        if (ks_regs_len > 0) {
+            addr = addr - sizeof(CPU_CONTEXT) + context_len;
+            err = windbg_read_ks_regs(cpu, pd->extra + context_len,
+                                      ks_regs_len, addr, ks_regs_len);
+        }
+    }
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
+void kd_api_write_control_space(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
+    uint32_t len;
+    uint32_t context_len;
+    uint32_t ks_regs_len;
+    target_ulong addr;
+    int err = -1;
+
+    len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
+    addr = ldtul_p(&mem->TargetBaseAddress);
+
+    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
+        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
+
+        context_len = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
+        ks_regs_len = len - context_len;
+
+        if (context_len > 0) {
+            err = windbg_write_context(cpu, pd->extra, context_len, addr,
+                                       context_len);
+        }
+        if (ks_regs_len > 0) {
+            addr = addr - sizeof(CPU_CONTEXT) + context_len;
+            err = windbg_write_ks_regs(cpu, pd->extra + context_len,
+                                       ks_regs_len, addr, ks_regs_len);
+        }
+    }
+
+    if (err) {
+        mem->ActualBytesWritten = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+
+    pd->extra_size = 0;
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
 bool windbg_on_load(void)
 {
     CPUState *cpu = qemu_get_cpu(0);
diff --git a/windbgstub.c b/windbgstub.c
index ad8638b793..5b0a15ea4e 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -156,6 +156,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
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
