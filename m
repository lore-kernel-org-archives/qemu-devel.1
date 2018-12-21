Received: from eggs.gnu.org ([2001:4830:134:3::10]:53886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQvd-00040W-7t
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gaQva-0002L3-1p
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:49 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gaQvZ-0002JE-Qg
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:57:45 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 21 Dec 2018 14:52:00 -0500
Message-Id: <20181221195200.6544-3-cota@braap.org>
In-Reply-To: <20181221195200.6544-1-cota@braap.org>
References: <20181221195200.6544-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH 2/2] fp-bench: remove wrong exponent raise in
 fill_random
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

At this point random_ops[] only contains normals, so there's
no need to do anything to them. In fact, raising the exponent
here can make the output !normal, which is precisely
what the comment says we want to avoid.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 tests/fp/fp-bench.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index 546bac9c9c..4ba5e1d2d4 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -176,8 +176,6 @@ static void fill_random(union fp *ops, int n_ops, enum precision prec,
             if (no_neg && float32_is_neg(ops[i].f32)) {
                 ops[i].f32 = float32_chs(ops[i].f32);
             }
-            /* raise the exponent to limit the frequency of denormal results */
-            ops[i].f32 |= 0x40000000;
             break;
         case PREC_DOUBLE:
         case PREC_FLOAT64:
@@ -185,8 +183,6 @@ static void fill_random(union fp *ops, int n_ops, enum precision prec,
             if (no_neg && float64_is_neg(ops[i].f64)) {
                 ops[i].f64 = float64_chs(ops[i].f64);
             }
-            /* raise the exponent to limit the frequency of denormal results */
-            ops[i].f64 |= LIT64(0x4000000000000000);
             break;
         default:
             g_assert_not_reached();
-- 
2.17.1
