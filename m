Received: from eggs.gnu.org ([2001:4830:134:3::10]:52709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2xwi-0006pm-Ly
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2xwg-00082w-3B
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:43:48 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d2xwf-00082k-Rm
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 06:43:46 -0400
Received: by mail-wm0-x244.google.com with SMTP id y10so12895998wmh.0
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 03:43:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 25 Apr 2017 12:43:38 +0200
Message-Id: <20170425104338.31984-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH] tcg: Initialize return value after exit_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Users of tcg_gen_atomic_cmpxchg and do_atomic_op rightfully utilize
the output.  Even though this code is dead, it gets translated, and
without the initialization we encounter a tcg_error.

Reported-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
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
