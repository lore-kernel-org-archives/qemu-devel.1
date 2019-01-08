Received: from eggs.gnu.org ([209.51.188.92]:47977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8h-0004Er-SU
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggu8e-0000a3-7n
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggu8d-0000Rc-Uh
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:22:00 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so4663626wrw.5
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:21:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  8 Jan 2019 16:21:50 +0000
Message-Id: <20190108162154.22259-3-alex.bennee@linaro.org>
In-Reply-To: <20190108162154.22259-1-alex.bennee@linaro.org>
References: <20190108162154.22259-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/6] fp-bench: remove wrong exponent raise
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
Cc: cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

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
