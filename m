Received: from eggs.gnu.org ([2001:4830:134:3::10]:35304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ux-0006If-Io
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Uw-0003Im-QI
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:47 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:33412)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uw-0003IN-L1
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:46 -0500
Received: by mail-pf0-x241.google.com with SMTP id 127so31458133pfg.0
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:46 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:43 -0800
Message-Id: <20170111021820.24416-29-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 28/65] target-cris: Use clz opcode
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

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/cris/helper.h    | 1 -
 target/cris/op_helper.c | 5 -----
 target/cris/translate.c | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/cris/helper.h b/target/cris/helper.h
index ff35956..20d21c4 100644
--- a/target/cris/helper.h
+++ b/target/cris/helper.h
@@ -7,7 +7,6 @@ DEF_HELPER_1(rfn, void, env)
 DEF_HELPER_3(movl_sreg_reg, void, env, i32, i32)
 DEF_HELPER_3(movl_reg_sreg, void, env, i32, i32)
 
-DEF_HELPER_FLAGS_1(lz, TCG_CALL_NO_SE, i32, i32)
 DEF_HELPER_FLAGS_4(btst, TCG_CALL_NO_SE, i32, env, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(evaluate_flags_muls, TCG_CALL_NO_SE, i32, env, i32, i32, i32)
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index 5043039..e92505c 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -230,11 +230,6 @@ void helper_rfn(CPUCRISState *env)
 	env->pregs[PR_CCS] |= M_FLAG_V32;
 }
 
-uint32_t helper_lz(uint32_t t0)
-{
-	return clz32(t0);
-}
-
 uint32_t helper_btst(CPUCRISState *env, uint32_t t0, uint32_t t1, uint32_t ccs)
 {
 	/* FIXME: clean this up.  */
diff --git a/target/cris/translate.c b/target/cris/translate.c
index b910427..0ee05ca 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -767,7 +767,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_LZ:
-        gen_helper_lz(dst, b);
+        tcg_gen_clzi_tl(dst, b, TARGET_LONG_BITS);
         break;
     case CC_OP_MULS:
         tcg_gen_muls2_tl(dst, cpu_PR[PR_MOF], a, b);
-- 
2.9.3
