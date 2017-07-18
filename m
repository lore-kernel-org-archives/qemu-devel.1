Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYF-0004dJ-EY
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXKYC-0004DB-DK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 00:56:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 01:55:33 -0300
Message-Id: <20170718045540.16322-4-f4bug@amsat.org>
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
References: <20170718045540.16322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 03/10] target/arm: optimize aarch64 rev16()
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Aurelien Jarno denoted this function could be implemented more effectively using
the aarch32 rev16() pattern.
  [http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg03180.html]

Done with the Coccinelle semantic patch from commit 58daf05d07dd
    (see scripts/coccinelle/tcg_gen_extract.cocci)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Richard: maybe you need to update 58daf05d07dd to your commit...

 target/arm/translate-a64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e55547d95d..8ade865481 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4046,14 +4046,12 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
     tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
 
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
-    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
+    tcg_gen_extract_i64(tcg_tmp, tcg_rn, 16, 16);
     tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
     tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
 
     if (sf) {
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
-        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
+        tcg_gen_extract_i64(tcg_tmp, tcg_rn, 32, 16);
         tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
         tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
 
-- 
2.13.2
