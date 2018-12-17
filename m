Received: from eggs.gnu.org ([2001:4830:134:3::10]:37324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrx3-0001sL-74
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYrx1-00053n-92
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 07:24:49 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 17 Dec 2018 12:24:00 +0000
Message-Id: <20181217122405.18732-5-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH v2 4/9] target/ppc: delay writeback of
 avr{l, h} during lvx instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, richard.henderson@linaro.org, lvivier@redhat.com

During review of the previous patch, Richard pointed out an existing bug that
the writeback to the avr{l,h} registers should be delayed until after any
exceptions have been raised.

Perform both 64-bit loads into separate temporaries and then write them into
the avr{l,h} registers together to ensure that this is always the case.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate/vmx-impl.inc.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 30046c6e31..cd7d12265c 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -18,33 +18,35 @@ static inline TCGv_ptr gen_avr_ptr(int reg)
 static void glue(gen_, name)(DisasContext *ctx)                                       \
 {                                                                             \
     TCGv EA;                                                                  \
-    TCGv_i64 avr;                                                             \
+    TCGv_i64 avr1, avr2;                                                      \
     if (unlikely(!ctx->altivec_enabled)) {                                    \
         gen_exception(ctx, POWERPC_EXCP_VPU);                                 \
         return;                                                               \
     }                                                                         \
     gen_set_access_type(ctx, ACCESS_INT);                                     \
-    avr = tcg_temp_new_i64();                                                 \
+    avr1 = tcg_temp_new_i64();                                                \
+    avr2 = tcg_temp_new_i64();                                                \
     EA = tcg_temp_new();                                                      \
     gen_addr_reg_index(ctx, EA);                                              \
     tcg_gen_andi_tl(EA, EA, ~0xf);                                            \
     /* We only need to swap high and low halves. gen_qemu_ld64_i64 does       \
        necessary 64-bit byteswap already. */                                  \
     if (ctx->le_mode) {                                                       \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
+        gen_qemu_ld64_i64(ctx, avr1, EA);                                     \
         tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
+        gen_qemu_ld64_i64(ctx, avr2, EA);                                     \
+        set_avr64(rD(ctx->opcode), avr1, false);                              \
+        set_avr64(rD(ctx->opcode), avr2, true);                               \
     } else {                                                                  \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, true);                                \
+        gen_qemu_ld64_i64(ctx, avr1, EA);                                     \
         tcg_gen_addi_tl(EA, EA, 8);                                           \
-        gen_qemu_ld64_i64(ctx, avr, EA);                                      \
-        set_avr64(rD(ctx->opcode), avr, false);                               \
+        gen_qemu_ld64_i64(ctx, avr2, EA);                                     \
+        set_avr64(rD(ctx->opcode), avr1, true);                               \
+        set_avr64(rD(ctx->opcode), avr2, false);                              \
     }                                                                         \
     tcg_temp_free(EA);                                                        \
-    tcg_temp_free_i64(avr);                                                   \
+    tcg_temp_free_i64(avr1);                                                  \
+    tcg_temp_free_i64(avr2);                                                  \
 }
 
 #define GEN_VR_STX(name, opc2, opc3)                                          \
-- 
2.11.0
