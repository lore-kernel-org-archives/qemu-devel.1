Received: from eggs.gnu.org ([2001:4830:134:3::10]:41687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3s-0003k8-A2
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXh3r-0002Fd-H7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:12 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXh3r-0002FI-BQ
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:58:11 -0400
Received: by mail-pf0-x244.google.com with SMTP id o88so5095190pfk.1
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 21:58:11 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 18 Jul 2017 18:57:20 -1000
Message-Id: <20170719045722.25492-13-rth@twiddle.net>
In-Reply-To: <20170719045722.25492-1-rth@twiddle.net>
References: <20170719045722.25492-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/14] target/alpha: optimize gen_cvtlq() using
 deposit op
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
index 232af9e..2bffbae 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -756,11 +756,9 @@ static void gen_cvtlq(TCGv vc, TCGv vb)
 
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
2.9.4
