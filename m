Received: from eggs.gnu.org ([2001:4830:134:3::10]:33339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVu-0008S7-Cd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXyVr-0006z9-9d
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:18 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXyVr-0006yn-4q
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 19:36:15 -0400
Received: by mail-qt0-x242.google.com with SMTP id 50so1793295qtz.0
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 16:36:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 19 Jul 2017 13:34:53 -1000
Message-Id: <20170719233455.8740-13-rth@twiddle.net>
In-Reply-To: <20170719233455.8740-1-rth@twiddle.net>
References: <20170719233455.8740-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 12/14] target/alpha: optimize gen_cvtlq()
 using deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20170718045540.16322-10-f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/alpha/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 90e6d5285f..744d8bbf12 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -783,11 +783,9 @@ static void gen_cvtlq(TCGv vc, TCGv vb)
 
     /* The arithmetic right shift here, plus the sign-extended mask below
        yields a sign-extended result without an explicit ext32s_i64.  */
-    tcg_gen_sari_i64(tmp, vb, 32);
-    tcg_gen_shri_i64(vc, vb, 29);
-    tcg_gen_andi_i64(tmp, tmp, (int32_t)0xc0000000);
-    tcg_gen_andi_i64(vc, vc, 0x3fffffff);
-    tcg_gen_or_i64(vc, vc, tmp);
+    tcg_gen_shri_i64(tmp, vb, 29);
+    tcg_gen_sari_i64(vc, vb, 32);
+    tcg_gen_deposit_i64(vc, vc, tmp, 0, 30);
 
     tcg_temp_free(tmp);
 }
-- 
2.13.3
