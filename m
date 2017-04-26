Received: from eggs.gnu.org ([2001:4830:134:3::10]:50671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3QmG-0002FP-Co
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3QmD-0000eX-4l
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:30:56 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3QmC-0000eM-Uu
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 13:30:53 -0400
Received: by mail-wr0-x241.google.com with SMTP id v42so939556wrc.3
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:30:52 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 26 Apr 2017 19:30:44 +0200
Message-Id: <20170426173044.32525-2-rth@twiddle.net>
In-Reply-To: <20170426173044.32525-1-rth@twiddle.net>
References: <20170426173044.32525-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL] tcg: Initialize return value after exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
the output.  Even though this code is dead, it gets translated, and
without the initialization we encounter a tcg_error.

Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Tested-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 tcg/tcg-op.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 95a39b7..6b1f415 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2861,6 +2861,9 @@ void tcg_gen_atomic_cmpxchg_i64(TCGv_i64 retv, TCGv addr, TCGv_i64 cmpv,
 #endif
 #else
         gen_helper_exit_atomic(tcg_ctx.tcg_env);
+        /* Produce a result, so that we have a well-formed opcode stream
+           with respect to uses of the result in the (dead) code following.  */
+        tcg_gen_movi_i64(retv, 0);
 #endif /* CONFIG_ATOMIC64 */
     } else {
         TCGv_i32 c32 = tcg_temp_new_i32();
@@ -2966,6 +2969,9 @@ static void do_atomic_op_i64(TCGv_i64 ret, TCGv addr, TCGv_i64 val,
 #endif
 #else
         gen_helper_exit_atomic(tcg_ctx.tcg_env);
+        /* Produce a result, so that we have a well-formed opcode stream
+           with respect to uses of the result in the (dead) code following.  */
+        tcg_gen_movi_i64(ret, 0);
 #endif /* CONFIG_ATOMIC64 */
     } else {
         TCGv_i32 v32 = tcg_temp_new_i32();
-- 
2.9.3
