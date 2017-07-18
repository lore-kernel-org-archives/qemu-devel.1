Received: from eggs.gnu.org ([2001:4830:134:3::10]:48123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOZ-0004ki-7y
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dXaOY-0003WL-7P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:07 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:48416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dXaOY-0003Us-1A
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 17:51:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 18 Jul 2017 23:50:21 +0200
Message-Id: <20170718215050.3812-3-aurelien@aurel32.net>
In-Reply-To: <20170718215050.3812-1-aurelien@aurel32.net>
References: <20170718215050.3812-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 02/31] target/sh4: fix FPU unorderered compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

In case of unordered compare, the fcmp instructions should either
trigger and invalid exception (if enabled) or set T=0. The existing code
left it unchanged.

LP: https://bugs.launchpad.net/qemu/+bug/1701821
Reported-by: Bruno Haible <bruno@clisp.org>
Message-Id: <20170702202814.27793-3-aurelien@aurel32.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/op_helper.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 5e3a3ba68c..f228daf125 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -274,11 +274,8 @@ void helper_fcmp_eq_FT(CPUSH4State *env, float32 t0, float32 t1)
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float32_compare(t0, t1, &env->fp_status);
-    if (unlikely(relation == float_relation_unordered)) {
-        update_fpscr(env, GETPC());
-    } else {
-        env->sr_t = (relation == float_relation_equal);
-    }
+    update_fpscr(env, GETPC());
+    env->sr_t = (relation == float_relation_equal);
 }
 
 void helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
@@ -287,11 +284,8 @@ void helper_fcmp_eq_DT(CPUSH4State *env, float64 t0, float64 t1)
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float64_compare(t0, t1, &env->fp_status);
-    if (unlikely(relation == float_relation_unordered)) {
-        update_fpscr(env, GETPC());
-    } else {
-        env->sr_t = (relation == float_relation_equal);
-    }
+    update_fpscr(env, GETPC());
+    env->sr_t = (relation == float_relation_equal);
 }
 
 void helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
@@ -300,11 +294,8 @@ void helper_fcmp_gt_FT(CPUSH4State *env, float32 t0, float32 t1)
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float32_compare(t0, t1, &env->fp_status);
-    if (unlikely(relation == float_relation_unordered)) {
-        update_fpscr(env, GETPC());
-    } else {
-        env->sr_t = (relation == float_relation_greater);
-    }
+    update_fpscr(env, GETPC());
+    env->sr_t = (relation == float_relation_greater);
 }
 
 void helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
@@ -313,11 +304,8 @@ void helper_fcmp_gt_DT(CPUSH4State *env, float64 t0, float64 t1)
 
     set_float_exception_flags(0, &env->fp_status);
     relation = float64_compare(t0, t1, &env->fp_status);
-    if (unlikely(relation == float_relation_unordered)) {
-        update_fpscr(env, GETPC());
-    } else {
-        env->sr_t = (relation == float_relation_greater);
-    }
+    update_fpscr(env, GETPC());
+    env->sr_t = (relation == float_relation_greater);
 }
 
 float64 helper_fcnvsd_FT_DT(CPUSH4State *env, float32 t0)
-- 
2.11.0
