Received: from eggs.gnu.org ([2001:4830:134:3::10]:43059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw3-0002ZN-Rv
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:05:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gRPw1-0000Gv-NX
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:59 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gRPw1-0000Gp-IL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 18:04:57 -0500
Received: by mail-pg1-x542.google.com with SMTP id w7so6858742pgp.13
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 15:04:57 -0800 (PST)
Received: from cloudburst.twiddle.net (97-113-170-180.tukw.qwest.net.
	[97.113.170.180]) by smtp.gmail.com with ESMTPSA id
	o13sm1798703pfk.57.2018.11.26.15.04.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 26 Nov 2018 15:04:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 26 Nov 2018 15:04:48 -0800
Message-Id: <20181126230450.672-3-richard.henderson@linaro.org>
In-Reply-To: <20181126230450.672-1-richard.henderson@linaro.org>
References: <20181126230450.672-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/4] tcg: Add TCG_CALL_NO_RETURN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remember which helpers have been marked noreturn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/helper-head.h | 13 +++++++++++++
 include/exec/helper-tcg.h  | 21 ++++++++++++++-------
 tcg/tcg.h                  |  2 ++
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 276dd5afce..ab4f8b6623 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -108,6 +108,19 @@
 #define dh_is_signed_env dh_is_signed_ptr
 #define dh_is_signed(t) dh_is_signed_##t
 
+#define dh_callflag_i32  0
+#define dh_callflag_s32  0
+#define dh_callflag_int  0
+#define dh_callflag_i64  0
+#define dh_callflag_s64  0
+#define dh_callflag_f16  0
+#define dh_callflag_f32  0
+#define dh_callflag_f64  0
+#define dh_callflag_ptr  0
+#define dh_callflag_void 0
+#define dh_callflag_noreturn TCG_CALL_NO_RETURN
+#define dh_callflag(t) glue(dh_callflag_, dh_alias(t))
+
 #define dh_sizemask(t, n) \
   ((dh_is_64bit(t) << (n*2)) | (dh_is_signed(t) << (n*2+1)))
 
diff --git a/include/exec/helper-tcg.h b/include/exec/helper-tcg.h
index b3bdb0c399..268e0f804b 100644
--- a/include/exec/helper-tcg.h
+++ b/include/exec/helper-tcg.h
@@ -11,36 +11,43 @@
 #define str(s) #s
 
 #define DEF_HELPER_FLAGS_0(NAME, FLAGS, ret) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) },
 
 #define DEF_HELPER_FLAGS_1(NAME, FLAGS, ret, t1) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) },
 
 #define DEF_HELPER_FLAGS_2(NAME, FLAGS, ret, t1, t2) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) },
 
 #define DEF_HELPER_FLAGS_3(NAME, FLAGS, ret, t1, t2, t3) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) },
 
 #define DEF_HELPER_FLAGS_4(NAME, FLAGS, ret, t1, t2, t3, t4) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) },
 
 #define DEF_HELPER_FLAGS_5(NAME, FLAGS, ret, t1, t2, t3, t4, t5) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) },
 
 #define DEF_HELPER_FLAGS_6(NAME, FLAGS, ret, t1, t2, t3, t4, t5, t6) \
-  { .func = HELPER(NAME), .name = str(NAME), .flags = FLAGS, \
+  { .func = HELPER(NAME), .name = str(NAME), \
+    .flags = FLAGS | dh_callflag(ret), \
     .sizemask = dh_sizemask(ret, 0) | dh_sizemask(t1, 1) \
     | dh_sizemask(t2, 2) | dh_sizemask(t3, 3) | dh_sizemask(t4, 4) \
     | dh_sizemask(t5, 5) | dh_sizemask(t6, 6) },
diff --git a/tcg/tcg.h b/tcg/tcg.h
index e94f805370..6b6bc75c82 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -469,6 +469,8 @@ typedef TCGv_ptr TCGv_env;
 #define TCG_CALL_NO_WRITE_GLOBALS   0x0002
 /* Helper can be safely suppressed if the return value is not used. */
 #define TCG_CALL_NO_SIDE_EFFECTS    0x0004
+/* Helper is QEMU_NORETURN.  */
+#define TCG_CALL_NO_RETURN          0x0008
 
 /* convenience version of most used call flags */
 #define TCG_CALL_NO_RWG         TCG_CALL_NO_READ_GLOBALS
-- 
2.17.2
