Received: from eggs.gnu.org ([2001:4830:134:3::10]:34493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhK-0002ya-UP
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhJ-0006qX-Bq
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:38 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50622)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWhI-0006pa-Qh
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:54:37 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:54:34 +0300
Message-ID: <154401447439.8440.5765466463496877485.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 27/39] windbg: implement
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    2 +
 target/i386/windbgstub.c        |   90 ++++++++++++++++++++++++++++++++++++---
 windbgstub.c                    |    8 +++
 3 files changed, 93 insertions(+), 7 deletions(-)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index a88e013de9..6936fd0ffb 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -71,6 +71,8 @@ void kd_api_read_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_write_virtual_memory(CPUState *cs, PacketData *pd);
 void kd_api_get_context(CPUState *cs, PacketData *pd);
 void kd_api_set_context(CPUState *cs, PacketData *pd);
+void kd_api_get_context_ex(CPUState *cs, PacketData *pd);
+void kd_api_set_context_ex(CPUState *cs, PacketData *pd);
 void kd_api_unsupported(CPUState *cs, PacketData *pd);
 
 DBGKD_ANY_WAIT_STATE_CHANGE *kd_state_change_exc(CPUState *cs);
diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 900950495f..76cdc1d9a7 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -884,18 +884,57 @@ static int fun_name(CPUState *cs, uint8_t *buf, int buf_size,                  \
     return 0;                                                                  \
 }
 
-__attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_CONTEXT_RW(windbg_read_context, false)
-
-__attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_CONTEXT_RW(windbg_write_context, true)
-
-__attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_KSPEC_REGS_RW(windbg_read_ks_regs, false)
-
-__attribute__ ((unused)) /* unused yet */
 GEN_WINDBG_KSPEC_REGS_RW(windbg_write_ks_regs, true)
 
+static int windbg_rw_context_ex(CPUState *cs, uint8_t *buf, int buf_size,
+                                int offset, int len, bool is_read)
+{
+    int context_len;
+    int ks_regs_len;
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
+                err = windbg_read_context(cs, buf, context_len, offset,
+                                          context_len);
+            } else {
+                err = windbg_write_context(cs, buf, context_len, offset,
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
+                err = windbg_read_ks_regs(cs, buf + context_len, ks_regs_len,
+                                          offset, ks_regs_len);
+            } else {
+                err = windbg_write_ks_regs(cs, buf + context_len, ks_regs_len,
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
 void kd_api_get_context(CPUState *cs, PacketData *pd)
 {
     int err;
@@ -923,6 +962,43 @@ void kd_api_set_context(CPUState *cs, PacketData *pd)
     }
 }
 
+void kd_api_get_context_ex(CPUState *cs, PacketData *pd)
+{
+    DBGKD_CONTEXT_EX *ctx = &pd->m64.u.ContextEx;
+    uint32_t offset = ldl_p(&ctx->Offset);
+    uint32_t len = MIN(ldl_p(&ctx->ByteCount),
+                       PACKET_MAX_SIZE - sizeof(DBGKD_MANIPULATE_STATE64));
+    int err;
+
+    err = windbg_rw_context_ex(cs, pd->extra, len, offset, len, true);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+
+    pd->extra_size = len;
+    stl_p(&ctx->BytesCopied, len);
+}
+
+void kd_api_set_context_ex(CPUState *cs, PacketData *pd)
+{
+    DBGKD_CONTEXT_EX *ctx = &pd->m64.u.ContextEx;
+    uint32_t offset = ldl_p(&ctx->Offset);
+    uint32_t len = MIN(ldl_p(&ctx->ByteCount), pd->extra_size);
+    int err;
+
+    err = windbg_rw_context_ex(cs, pd->extra, len, offset, len, false);
+
+    if (err) {
+        len = 0;
+        pd->m64.ReturnStatus = STATUS_UNSUCCESSFUL;
+    }
+
+    pd->extra_size = 0;
+    stl_p(&ctx->BytesCopied, len);
+}
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
diff --git a/windbgstub.c b/windbgstub.c
index 70ebf3c0ad..e9d759cddf 100644
--- a/windbgstub.c
+++ b/windbgstub.c
@@ -165,6 +165,14 @@ static void windbg_process_manipulate_packet(WindbgState *state)
         kd_api_set_context(cs, data);
         break;
 
+    case DbgKdGetContextExApi:
+        kd_api_get_context_ex(cs, data);
+        break;
+
+    case DbgKdSetContextExApi:
+        kd_api_set_context_ex(cs, data);
+        break;
+
     default:
         kd_api_unsupported(cs, data);
         break;
