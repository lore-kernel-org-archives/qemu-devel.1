Received: from eggs.gnu.org ([209.51.188.92]:42782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrj8-0006tO-Bb
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gjrj7-0005yI-BS
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:54 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gjrj6-0005li-DN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 15:23:53 -0500
Received: by mail-wm1-x343.google.com with SMTP id b11so3461048wmj.1
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 12:23:52 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 16 Jan 2019 20:23:44 +0000
Message-Id: <20190116202349.29272-3-alex.bennee@linaro.org>
In-Reply-To: <20190116202349.29272-1-alex.bennee@linaro.org>
References: <20190116202349.29272-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/7] fp-bench: remove wrong exponent raise
 in fill_random
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

From: "Emilio G. Cota" <cota@braap.org>

At this point random_ops[] only contains normals, so there's
no need to do anything to them. In fact, raising the exponent
here can make the output !normal, which is precisely
what the comment says we want to avoid.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
