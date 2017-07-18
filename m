Received: from eggs.gnu.org ([2001:4830:134:3::10]:43407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYY-0004tj-DG
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYX-0004S4-Pc
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:22 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYX-0004Rq-Kv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:21 -0400
Received: by mail-qt0-x242.google.com with SMTP id p25so117199qtp.2
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 21:56:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:39 -0300
Message-Id: <20170718045540.16322-10-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 09/10] target/alpha: optimize gen_cvtlq()
 using deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/alpha/translate.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 232af9e177..2bffbae92f 100644
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
2.13.2
