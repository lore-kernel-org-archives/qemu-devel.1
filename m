Received: from eggs.gnu.org ([2001:4830:134:3::10]:42159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5V-00029t-TA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:12:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyk5R-0000z4-77
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyk5R-0000xa-1J
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 16:11:53 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 21 Mar 2018 16:11:39 -0400
Message-Id: <1521663109-32262-5-git-send-email-cota@braap.org>
In-Reply-To: <1521663109-32262-1-git-send-email-cota@braap.org>
References: <1521663109-32262-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v1 04/14] fp-test: add muladd variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These are a few muladd-related operations that the original IBM syntax
does not specify; model files for these are in muladd.fptest.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp-test/fp-test.c     | 24 +++++++++++++++++++++
 tests/fp-test/muladd.fptest | 51 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 tests/fp-test/muladd.fptest

diff --git a/tests/fp-test/fp-test.c b/tests/fp-test/fp-test.c
index 27637c4..2200d40 100644
--- a/tests/fp-test/fp-test.c
+++ b/tests/fp-test/fp-test.c
@@ -53,6 +53,9 @@ enum op {
     OP_SUB,
     OP_MUL,
     OP_MULADD,
+    OP_MULADD_NEG_ADDEND,
+    OP_MULADD_NEG_PRODUCT,
+    OP_MULADD_NEG_RESULT,
     OP_DIV,
     OP_SQRT,
     OP_MINNUM,
@@ -69,6 +72,9 @@ static const struct op_desc ops[] = {
     [OP_SUB] =       { "-", 2 },
     [OP_MUL] =       { "*", 2 },
     [OP_MULADD] =    { "*+", 3 },
+    [OP_MULADD_NEG_ADDEND] =  { "*+nc", 3 },
+    [OP_MULADD_NEG_PRODUCT] = { "*+np", 3 },
+    [OP_MULADD_NEG_RESULT] =  { "*+nr", 3 },
     [OP_DIV] =       { "/", 2 },
     [OP_SQRT] =      { "V", 1 },
     [OP_MINNUM] =    { "<C", 2 },
@@ -463,6 +469,15 @@ static enum error soft_tester(struct test_op *t)
         case OP_MULADD:
             res = float32_muladd(a, b, c, 0, s);
             break;
+        case OP_MULADD_NEG_ADDEND:
+            res = float32_muladd(a, b, c, float_muladd_negate_c, s);
+            break;
+        case OP_MULADD_NEG_PRODUCT:
+            res = float32_muladd(a, b, c, float_muladd_negate_product, s);
+            break;
+        case OP_MULADD_NEG_RESULT:
+            res = float32_muladd(a, b, c, float_muladd_negate_result, s);
+            break;
         case OP_DIV:
             res = float32_div(a, b, s);
             break;
@@ -522,6 +537,15 @@ static enum error soft_tester(struct test_op *t)
         case OP_MULADD:
             res64 = float64_muladd(a, b, c, 0, s);
             break;
+        case OP_MULADD_NEG_ADDEND:
+            res64 = float64_muladd(a, b, c, float_muladd_negate_c, s);
+            break;
+        case OP_MULADD_NEG_PRODUCT:
+            res64 = float64_muladd(a, b, c, float_muladd_negate_product, s);
+            break;
+        case OP_MULADD_NEG_RESULT:
+            res64 = float64_muladd(a, b, c, float_muladd_negate_result, s);
+            break;
         case OP_DIV:
             res64 = float64_div(a, b, s);
             break;
diff --git a/tests/fp-test/muladd.fptest b/tests/fp-test/muladd.fptest
new file mode 100644
index 0000000..6cd48ff
--- /dev/null
+++ b/tests/fp-test/muladd.fptest
@@ -0,0 +1,51 @@
+# nc == negate addend
+b32*+nc =0 -Inf -Inf +Inf -> Q i
+b32*+nc =0 -1.7FFFFFP127 -Inf +Inf -> Q i
+b32*+nc =0 -1.6C9AE7P113 -Inf +Inf -> Q i
+b32*+nc =0 -1.000000P-126 -Inf +Inf -> Q i
+b32*+nc =0 -0.7FFFFFP-126 -Inf +Inf -> Q i
+b32*+nc =0 -0.1B977AP-126 -Inf +Inf -> Q i
+b32*+nc =0 -0.000001P-126 -Inf +Inf -> Q i
+b32*+nc =0 -1.000000P0 -Inf +Inf -> Q i
+b32*+nc =0 -Zero -Inf +Inf -> Q i
+b32*+nc =0 +Zero -Inf +Inf -> Q i
+b32*+nc =0 -Zero -1.000000P-126 +1.7FFFFFP127 -> -1.7FFFFFP127
+b32*+nc =0 +Zero -1.000000P-126 +1.7FFFFFP127 -> -1.7FFFFFP127
+b32*+nc =0 -1.000000P-126 -1.7FFFFFP127 -1.4B9156P109 -> +1.4B9156P109 x
+b32*+nc =0 -0.7FFFFFP-126 -1.7FFFFFP127 -1.51BA59P-113 -> +1.7FFFFDP1 x
+b32*+nc =0 -0.3D6B57P-126 -1.7FFFFFP127 -1.265398P-67 -> +1.75AD5BP0 x
+b32*+nc =0 -0.000001P-126 -1.7FFFFFP127 -1.677330P-113 -> +1.7FFFFFP-22 x
+
+# np == negate product
+b32*+np =0 +Inf -Inf -Inf -> Q i
+b32*+np =0 +1.7FFFFFP127 -Inf -Inf -> Q i
+b32*+np =0 +1.6C9AE7P113 -Inf -Inf -> Q i
+b32*+np =0 +1.000000P-126 -Inf -Inf -> Q i
+b32*+np =0 +0.7FFFFFP-126 -Inf -Inf -> Q i
+b32*+np =0 +0.1B977AP-126 -Inf -Inf -> Q i
+b32*+np =0 +0.000001P-126 -Inf -Inf -> Q i
+b32*+np =0 +1.000000P0 -Inf -Inf -> Q i
+b32*+np =0 +Zero -Inf -Inf -> Q i
+b32*+np =0 +Zero -Inf -Inf -> Q i
+b32*+np =0 -Zero -1.000000P-126 -1.7FFFFFP127 -> -1.7FFFFFP127
+b32*+np =0 +Zero -1.000000P-126 -1.7FFFFFP127 -> -1.7FFFFFP127
+b32*+np =0 -1.3A6A89P-18 +1.24E7AEP9 -0.7FFFFFP-126 -> +1.7029E9P-9 x
+
+# nr == negate result
+b32*+nr =0 -Inf -Inf -Inf -> Q i
+b32*+nr =0 -1.7FFFFFP127 -Inf -Inf -> Q i
+b32*+nr =0 -1.6C9AE7P113 -Inf -Inf -> Q i
+b32*+nr =0 -1.000000P-126 -Inf -Inf -> Q i
+b32*+nr =0 -0.7FFFFFP-126 -Inf -Inf -> Q i
+b32*+nr =0 -0.1B977AP-126 -Inf -Inf -> Q i
+b32*+nr =0 -0.000001P-126 -Inf -Inf -> Q i
+b32*+nr =0 -1.000000P0 -Inf -Inf -> Q i
+b32*+nr =0 -Zero -Inf -Inf -> Q i
+b32*+nr =0 -Zero -Inf -Inf -> Q i
+b32*+nr =0 +Zero -1.000000P-126 -1.7FFFFFP127 -> +1.7FFFFFP127
+b32*+nr =0 -Zero -1.000000P-126 -1.7FFFFFP127 -> +1.7FFFFFP127
+b32*+nr =0 -1.000000P-126 -1.7FFFFFP127 -1.4B9156P109 -> +1.4B9156P109 x
+b32*+nr =0 -0.7FFFFFP-126 -1.7FFFFFP127 -1.51BA59P-113 -> -1.7FFFFDP1 x
+b32*+nr =0 -0.3D6B57P-126 -1.7FFFFFP127 -1.265398P-67 -> -1.75AD5BP0 x
+b32*+nr =0 -0.000001P-126 -1.7FFFFFP127 -1.677330P-113 -> -1.7FFFFFP-22 x
+b32*+nr =0 +1.72E53AP-33 -1.7FFFFFP127 -1.5AA684P-2 -> +1.72E539P95 x
-- 
2.7.4
