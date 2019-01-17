Received: from eggs.gnu.org ([209.51.188.92]:58293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7mK-0000Ae-NB
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gk7hP-0002Yi-4R
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:16 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gk7hM-0002Rv-RK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:27:10 -0500
Received: by mail-wm1-x336.google.com with SMTP id p6so1062201wmc.1
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 05:27:07 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Jan 2019 13:26:57 +0000
Message-Id: <20190117132703.17790-2-alex.bennee@linaro.org>
In-Reply-To: <20190117132703.17790-1-alex.bennee@linaro.org>
References: <20190117132703.17790-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/7] fp-bench: fix update_random_ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

The second test in the branches is wrong; fix while converting
to a switch statement, which is easier to get right.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/fp/fp-bench.c b/tests/fp/fp-bench.c
index f5bc5edebf..546bac9c9c 100644
--- a/tests/fp/fp-bench.c
+++ b/tests/fp/fp-bench.c
@@ -143,15 +143,20 @@ static void update_random_ops(int n_ops, enum precision prec)
     for (i = 0; i < n_ops; i++) {
         uint64_t r = random_ops[i];
 
-        if (prec == PREC_SINGLE || PREC_FLOAT32) {
+        switch (prec) {
+        case PREC_SINGLE:
+        case PREC_FLOAT32:
             do {
                 r = xorshift64star(r);
             } while (!float32_is_normal(r));
-        } else if (prec == PREC_DOUBLE || PREC_FLOAT64) {
+            break;
+        case PREC_DOUBLE:
+        case PREC_FLOAT64:
             do {
                 r = xorshift64star(r);
             } while (!float64_is_normal(r));
-        } else {
+            break;
+        default:
             g_assert_not_reached();
         }
         random_ops[i] = r;
-- 
2.17.1
