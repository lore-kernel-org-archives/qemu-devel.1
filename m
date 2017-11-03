Received: from eggs.gnu.org ([2001:4830:134:3::10]:48437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX6-00029t-Og
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eAXX3-0002Q6-0Q
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:56 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:54219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eAXX2-0002PT-Q2
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:40:52 -0400
Received: by mail-wm0-x241.google.com with SMTP id r196so3507748wmf.2
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 01:40:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  3 Nov 2017 09:40:44 +0100
Message-Id: <20171103084046.12821-2-richard.henderson@linaro.org>
In-Reply-To: <20171103084046.12821-1-richard.henderson@linaro.org>
References: <20171103084046.12821-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 1/3] tcg: Allow constant pool entries in the
 prologue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Both ARMv6 and AArch64 currently may drop complex guest_base values
into the constant pool.  But generic code wasn't expecting that, and
the pool is not emitted.  Correct that.

Tested-by: Emilio G. Cota <cota@braap.org>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 683ff4abb7..c22f1c4441 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -771,12 +771,32 @@ void tcg_prologue_init(TCGContext *s)
 
     /* Put the prologue at the beginning of code_gen_buffer.  */
     buf0 = s->code_gen_buffer;
+    total_size = s->code_gen_buffer_size;
     s->code_ptr = buf0;
     s->code_buf = buf0;
+    s->data_gen_ptr = NULL;
     s->code_gen_prologue = buf0;
 
+    /* Compute a high-water mark, at which we voluntarily flush the buffer
+       and start over.  The size here is arbitrary, significantly larger
+       than we expect the code generation for any one opcode to require.  */
+    s->code_gen_highwater = s->code_gen_buffer + (total_size - TCG_HIGHWATER);
+
+#ifdef TCG_TARGET_NEED_POOL_LABELS
+    s->pool_labels = NULL;
+#endif
+
     /* Generate the prologue.  */
     tcg_target_qemu_prologue(s);
+
+#ifdef TCG_TARGET_NEED_POOL_LABELS
+    /* Allow the prologue to put e.g. guest_base into a pool entry.  */
+    {
+        bool ok = tcg_out_pool_finalize(s);
+        tcg_debug_assert(ok);
+    }
+#endif
+
     buf1 = s->code_ptr;
     flush_icache_range((uintptr_t)buf0, (uintptr_t)buf1);
 
@@ -785,21 +805,36 @@ void tcg_prologue_init(TCGContext *s)
     s->code_gen_ptr = buf1;
     s->code_gen_buffer = buf1;
     s->code_buf = buf1;
-    total_size = s->code_gen_buffer_size - prologue_size;
+    total_size -= prologue_size;
     s->code_gen_buffer_size = total_size;
 
-    /* Compute a high-water mark, at which we voluntarily flush the buffer
-       and start over.  The size here is arbitrary, significantly larger
-       than we expect the code generation for any one opcode to require.  */
-    s->code_gen_highwater = s->code_gen_buffer + (total_size - TCG_HIGHWATER);
-
     tcg_register_jit(s->code_gen_buffer, total_size);
 
 #ifdef DEBUG_DISAS
     if (qemu_loglevel_mask(CPU_LOG_TB_OUT_ASM)) {
         qemu_log_lock();
         qemu_log("PROLOGUE: [size=%zu]\n", prologue_size);
-        log_disas(buf0, prologue_size);
+        if (s->data_gen_ptr) {
+            size_t code_size = s->data_gen_ptr - buf0;
+            size_t data_size = prologue_size - code_size;
+            size_t i;
+
+            log_disas(buf0, code_size);
+
+            for (i = 0; i < data_size; i += sizeof(tcg_target_ulong)) {
+                if (sizeof(tcg_target_ulong) == 8) {
+                    qemu_log("0x%08" PRIxPTR ":  .quad  0x%016" PRIx64 "\n",
+                             (uintptr_t)s->data_gen_ptr + i,
+                             *(uint64_t *)(s->data_gen_ptr + i));
+                } else {
+                    qemu_log("0x%08" PRIxPTR ":  .long  0x%08x\n",
+                             (uintptr_t)s->data_gen_ptr + i,
+                             *(uint32_t *)(s->data_gen_ptr + i));
+                }
+            }
+        } else {
+            log_disas(buf0, prologue_size);
+        }
         qemu_log("\n");
         qemu_log_flush();
         qemu_log_unlock();
-- 
2.13.6
