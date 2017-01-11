Received: from eggs.gnu.org ([2001:4830:134:3::10]:35380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V1-0006Nu-IM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8V0-0003LZ-Mq
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:51 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35062)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8V0-0003LF-Gv
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:50 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so12525558pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:50 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:48 -0800
Message-Id: <20170111021820.24416-34-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 33/65] target-s390x: Use clz opcode
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
 target/s390x/helper.h     | 1 -
 target/s390x/int_helper.c | 6 ------
 target/s390x/translate.c  | 2 +-
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/target/s390x/helper.h b/target/s390x/helper.h
index 207a6e7..9102071 100644
--- a/target/s390x/helper.h
+++ b/target/s390x/helper.h
@@ -70,7 +70,6 @@ DEF_HELPER_FLAGS_4(msdb, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_3(tceb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_3(tcdb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64)
 DEF_HELPER_FLAGS_4(tcxb, TCG_CALL_NO_RWG_SE, i32, env, i64, i64, i64)
-DEF_HELPER_FLAGS_1(clz, TCG_CALL_NO_RWG_SE, i64, i64)
 DEF_HELPER_FLAGS_2(sqeb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_2(sqdb, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(sqxb, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
index 370c94d..5bc470b 100644
--- a/target/s390x/int_helper.c
+++ b/target/s390x/int_helper.c
@@ -117,12 +117,6 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
     return ret;
 }
 
-/* count leading zeros, for find leftmost one */
-uint64_t HELPER(clz)(uint64_t v)
-{
-    return clz64(v);
-}
-
 uint64_t HELPER(cvd)(int32_t reg)
 {
     /* positive 0 */
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 6cebb7e..01c6217 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -2249,7 +2249,7 @@ static ExitStatus op_flogr(DisasContext *s, DisasOps *o)
     gen_op_update1_cc_i64(s, CC_OP_FLOGR, o->in2);
 
     /* R1 = IN ? CLZ(IN) : 64.  */
-    gen_helper_clz(o->out, o->in2);
+    tcg_gen_clzi_i64(o->out, o->in2, 64);
 
     /* R1+1 = IN & ~(found bit).  Note that we may attempt to shift this
        value by 64, which is undefined.  But since the shift is 64 iff the
-- 
2.9.3
