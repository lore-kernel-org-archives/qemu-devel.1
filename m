Received: from eggs.gnu.org ([2001:4830:134:3::10]:33033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsC-0008Aw-Qc
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d8XsB-0006Sh-Mw
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:06:12 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 10 May 2017 17:05:30 -0300
Message-Id: <20170510200535.13268-4-f4bug@amsat.org>
In-Reply-To: <20170510200535.13268-1-f4bug@amsat.org>
References: <20170510200535.13268-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/8] target/arm: optimize rev16() using extract
 op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Applied using Coccinelle script.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/arm/translate-a64.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 24de30d92c..7ea130107e 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -4038,14 +4038,12 @@ static void handle_rev16(DisasContext *s, unsigned int sf,
     tcg_gen_andi_i64(tcg_tmp, tcg_rn, 0xffff);
     tcg_gen_bswap16_i64(tcg_rd, tcg_tmp);
 
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
-    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
+    tcg_gen_extract_i64(tcg_tmp, tcg_rn, 16, 0xffff);
     tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
     tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 16, 16);
 
     if (sf) {
-        tcg_gen_shri_i64(tcg_tmp, tcg_rn, 32);
-        tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
+        tcg_gen_extract_i64(tcg_tmp, tcg_rn, 32, 0xffff);
         tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp);
         tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, 32, 16);
 
-- 
2.11.0
