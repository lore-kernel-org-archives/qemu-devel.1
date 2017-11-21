Received: from eggs.gnu.org ([2001:4830:134:3::10]:40627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9H2-0003JV-Vp
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Gw-0003jt-KR
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:11:40 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38784)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9Gw-0003ij-5V
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:11:34 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:11:31 +0300
Message-ID: <151127349122.6888.9523124333246477608.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 45/45] windbg: implemented
 kd_api_get_context_ex and kd_api_set_context_ex
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
 target/i386/windbgstub.c        |  129 ++++++++++++++++++++++++++++-----------
 windbgstub.c                    |   14 +++-
 3 files changed, 105 insertions(+), 40 deletions(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index fa1ebbb6d2..ea6828b973 100755
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -106,6 +106,8 @@ void kd_api_search_memory(CPUState *cpu, PacketData *pd);
 void kd_api_fill_memory(CPUState *cpu, PacketData *pd);
 void kd_api_unsupported(CPUState *cpu, PacketData *pd);
 void kd_api_query_memory(CPUState *cpu, PacketData *pd);
+void kd_api_get_context_ex(CPUState *cpu, PacketData *pd);
+void kd_api_set_context_ex(CPUState *cpu, PacketData *pd);
 
 SizedBuf kd_gen_exception_sc(CPUState *cpu);
 SizedBuf kd_gen_load_symbols_sc(CPUState *cpu);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 735b2edd5f..aca4bfedec 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -899,6 +899,52 @@ static int windbg_write_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
     return 0;
 }
 
+static int windbg_rw_context_ex(CPUState *cpu, uint8_t *buf, int buf_size,
+                                int offset, int len, bool is_read)
+{
+    uint32_t context_len;
+    uint32_t ks_regs_len;
+    int err = -1;
+
+    if (offset < sizeof(CPU_KPROCESSOR_STATE)) {
+        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - offset);
+
+        context_len = MAX(0, (int) (sizeof(CPU_CONTEXT) - offset));
+        ks_regs_len = len - context_len;
+
+        if (context_len > 0) {
+            if (is_read) {
+                err = windbg_read_context(cpu, buf, context_len, offset,
+                                          context_len);
+            } else {
+                err = windbg_write_context(cpu, buf, context_len, offset,
+                                           context_len);
+            }
+
+            if (err) {
+                return err;
+            }
+        }
+
+        if (ks_regs_len > 0) {
+            offset += context_len - sizeof(CPU_CONTEXT);
+            if (is_read) {
+                err = windbg_read_ks_regs(cpu, buf + context_len, ks_regs_len,
+                                          offset, ks_regs_len);
+            } else {
+                err = windbg_write_ks_regs(cpu, buf + context_len, ks_regs_len,
+                                           offset, ks_regs_len);
+            }
+
+            if (err) {
+                return err;
+            }
+        }
+    }
+
+    return err;
+}
+
 void kd_api_get_context(CPUState *cpu, PacketData *pd)
 {
     int err;
@@ -930,31 +976,14 @@ void kd_api_read_control_space(CPUState *cpu, PacketData *pd)
 {
     DBGKD_READ_MEMORY64 *mem = &pd->m64.u.ReadMemory;
     uint32_t len;
-    uint32_t context_len;
-    uint32_t ks_regs_len;
     target_ulong addr;
-    int err = -1;
+    int err;
 
     len = MIN(ldl_p(&mem->TransferCount),
               PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
     addr = ldtul_p(&mem->TargetBaseAddress);
 
-    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
-        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
-
-        context_len = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
-        ks_regs_len = len - context_len;
-
-        if (context_len > 0) {
-            err = windbg_read_context(cpu, pd->extra, context_len, addr,
-                                      context_len);
-        }
-        if (ks_regs_len > 0) {
-            addr = addr - sizeof(CPU_CONTEXT) + context_len;
-            err = windbg_read_ks_regs(cpu, pd->extra + context_len,
-                                      ks_regs_len, addr, ks_regs_len);
-        }
-    }
+    err = windbg_rw_context_ex(cpu, pd->extra, len, addr, len, true);
 
     if (err) {
         len = 0;
@@ -969,38 +998,64 @@ void kd_api_write_control_space(CPUState *cpu, PacketData *pd)
 {
     DBGKD_WRITE_MEMORY64 *mem = &pd->m64.u.WriteMemory;
     uint32_t len;
-    uint32_t context_len;
-    uint32_t ks_regs_len;
     target_ulong addr;
-    int err = -1;
+    int err;
 
     len = MIN(ldl_p(&mem->TransferCount), pd->extra_size);
     addr = ldtul_p(&mem->TargetBaseAddress);
 
-    if (addr < sizeof(CPU_KPROCESSOR_STATE)) {
-        len = MIN(len, sizeof(CPU_KPROCESSOR_STATE) - addr);
+    err = windbg_rw_context_ex(cpu, pd->extra, len, addr, len, false);
 
-        context_len = MAX(0, (int) (sizeof(CPU_CONTEXT) - addr));
-        ks_regs_len = len - context_len;
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
 
-        if (context_len > 0) {
-            err = windbg_write_context(cpu, pd->extra, context_len, addr,
-                                       context_len);
-        }
-        if (ks_regs_len > 0) {
-            addr = addr - sizeof(CPU_CONTEXT) + context_len;
-            err = windbg_write_ks_regs(cpu, pd->extra + context_len,
-                                       ks_regs_len, addr, ks_regs_len);
-        }
+    pd->extra_size = 0;
+    stl_p(&mem->ActualBytesWritten, len);
+}
+
+void kd_api_get_context_ex(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_CONTEXT_EX *ctx = &pd->m64.u.ContextEx;
+    uint32_t offset;
+    uint32_t len;
+    int err;
+
+    len = MIN(ldl_p(&ctx->ByteCount),
+              PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    offset = ldl_p(&ctx->Offset);
+
+    err = windbg_rw_context_ex(cpu, pd->extra, len, offset, len, true);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
     }
 
+    pd->extra_size = len;
+    stl_p(&ctx->BytesCopied, len);
+}
+
+void kd_api_set_context_ex(CPUState *cpu, PacketData *pd)
+{
+    DBGKD_CONTEXT_EX *ctx = &pd->m64.u.ContextEx;
+    uint32_t offset;
+    uint32_t len;
+    int err;
+
+    len = MIN(ldl_p(&ctx->ByteCount), pd->extra_size);
+    offset = ldl_p(&ctx->Offset);
+
+    err = windbg_rw_context_ex(cpu, pd->extra, len, offset, len, false);
+
     if (err) {
-        mem->ActualBytesWritten = 0;
+        len = 0;
         pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
     }
 
     pd->extra_size = 0;
-    stl_p(&mem->ActualBytesWritten, len);
+    stl_p(&ctx->BytesCopied, len);
 }
 
 void kd_api_read_msr(CPUState *cpu, PacketData *pd)
diff --git a/windbgstub.c b/windbgstub.c
index 36372c0ea5..3bcf6a8cbb 100755
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -224,6 +224,14 @@ static void windbg_process_manipulate_packet(ParsingContext *ctx)
         kd_api_query_memory(cpu, &ctx->data);
         break;
 
+    case DbgKdGetContextExApi:
+        kd_api_get_context_ex(cpu, &ctx->data);
+        break;
+
+    case DbgKdSetContextExApi:
+        kd_api_set_context_ex(cpu, &ctx->data);
+        break;
+
     default:
         kd_api_unsupported(cpu, &ctx->data);
         break;
@@ -262,12 +270,12 @@ static void windbg_process_control_packet(ParsingContext *ctx)
 
     case PACKET_TYPE_KD_RESET:
     {
-        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
+        windbg_send_control_packet(ctx->packet.PacketType);
+        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;
 
+        SizedBuf buf = kd_gen_load_symbols_sc(qemu_get_cpu(0));
         windbg_send_data_packet(buf.data, buf.size,
                                 PACKET_TYPE_KD_STATE_CHANGE64);
-        windbg_send_control_packet(ctx->packet.PacketType);
-        windbg_state->ctrl_packet_id = INITIAL_PACKET_ID;
         SBUF_FREE(buf);
         break;
     }
