Received: from eggs.gnu.org ([2001:4830:134:3::10]:48374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hz-0006Us-QT
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dR1Hy-00036j-Md
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:11 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dR1Hy-000363-Ho
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 15:09:10 -0400
Received: by mail-qk0-x243.google.com with SMTP id v143so3780410qkb.3
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 12:09:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 30 Jun 2017 12:09:02 -0700
Message-Id: <20170630190903.9886-3-rth@twiddle.net>
In-Reply-To: <20170630190903.9886-1-rth@twiddle.net>
References: <20170630190903.9886-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 2/3] gen-icount: use tcg_ctx.tcg_env instead of
 cpu_env
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

We are relying on cpu_env being defined as a global, yet most
targets (i.e. all but arm/a64) have it defined as a local variable.
Luckily all of them use the same "cpu_env" name, but really
compilation shouldn't break if the name of that local variable
changed.

Fix it by using tcg_ctx.tcg_env, which all targets set in their
translate_init function. This change also helps paving the way
for the upcoming "translation loop common to all targets" work.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1497639397-19453-3-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 include/exec/gen-icount.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 547c979..9b3cb14 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -19,7 +19,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
         count = tcg_temp_new_i32();
     }
 
-    tcg_gen_ld_i32(count, cpu_env,
+    tcg_gen_ld_i32(count, tcg_ctx.tcg_env,
                    -ENV_OFFSET + offsetof(CPUState, icount_decr.u32));
 
     if (tb->cflags & CF_USE_ICOUNT) {
@@ -37,7 +37,7 @@ static inline void gen_tb_start(TranslationBlock *tb)
     tcg_gen_brcondi_i32(TCG_COND_LT, count, 0, exitreq_label);
 
     if (tb->cflags & CF_USE_ICOUNT) {
-        tcg_gen_st16_i32(count, cpu_env,
+        tcg_gen_st16_i32(count, tcg_ctx.tcg_env,
                          -ENV_OFFSET + offsetof(CPUState, icount_decr.u16.low));
     }
 
@@ -62,14 +62,16 @@ static inline void gen_tb_end(TranslationBlock *tb, int num_insns)
 static inline void gen_io_start(void)
 {
     TCGv_i32 tmp = tcg_const_i32(1);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
-    tcg_gen_st_i32(tmp, cpu_env, -ENV_OFFSET + offsetof(CPUState, can_do_io));
+    tcg_gen_st_i32(tmp, tcg_ctx.tcg_env,
+                   -ENV_OFFSET + offsetof(CPUState, can_do_io));
     tcg_temp_free_i32(tmp);
 }
 
-- 
2.9.4
