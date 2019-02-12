Received: from eggs.gnu.org ([209.51.188.92]:49428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8p-0002Yn-1Q
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8m-0001qB-Ew
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:54 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:35482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8l-0001l9-UR
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:52 -0500
Received: by mail-pl1-x62d.google.com with SMTP id p8so699870plo.2
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:18 -0800
Message-Id: <20190212045721.28041-22-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 21/24] target/hppa: Rearrange log conditions
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

We will be fixing do_cond vs signed overflow, which requires
that do_log_cond not rely on do_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 56 +++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 6836fb6245..aae5714235 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -432,6 +432,15 @@ static DisasCond cond_make_f(void)
     };
 }
 
+static DisasCond cond_make_t(void)
+{
+    return (DisasCond){
+        .c = TCG_COND_ALWAYS,
+        .a0 = NULL,
+        .a1 = NULL,
+    };
+}
+
 static DisasCond cond_make_n(void)
 {
     return (DisasCond){
@@ -930,17 +939,50 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
     return cond;
 }
 
-/* Similar, but for logicals, where the carry and overflow bits are not
-   computed, and use of them is undefined.  */
+/*
+ * Similar, but for logicals, where the carry and overflow bits are not
+ * computed, and use of them is undefined.
+ *
+ * Undefined or not, hardware does not trap.  It seems reasonable to
+ * assume hardware treats cases c={4,5,6} as if C=0 & V=0, since that's
+ * how cases c={2,3} are treated.
+ */
 
 static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 {
-    switch (cf >> 1) {
-    case 4: case 5: case 6:
-        cf &= 1;
-        break;
+    switch (cf) {
+    case 0:  /* never */
+    case 9:  /* undef, C */
+    case 11: /* undef, C & !Z */
+    case 12: /* undef, V */
+        return cond_make_f();
+
+    case 1:  /* true */
+    case 8:  /* undef, !C */
+    case 10: /* undef, !C | Z */
+    case 13: /* undef, !V */
+        return cond_make_t();
+
+    case 2:  /* == */
+        return cond_make_0(TCG_COND_EQ, res);
+    case 3:  /* <> */
+        return cond_make_0(TCG_COND_NE, res);
+    case 4:  /* < */
+        return cond_make_0(TCG_COND_LT, res);
+    case 5:  /* >= */
+        return cond_make_0(TCG_COND_GE, res);
+    case 6:  /* <= */
+        return cond_make_0(TCG_COND_LE, res);
+    case 7:  /* > */
+        return cond_make_0(TCG_COND_GT, res);
+
+    case 14: /* OD */
+    case 15: /* EV */
+        return do_cond(cf, res, NULL, NULL);
+
+    default:
+        g_assert_not_reached();
     }
-    return do_cond(cf, res, res, res);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
-- 
2.17.2
