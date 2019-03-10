Received: from eggs.gnu.org ([209.51.188.92]:46997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQH-0003Mh-Rt
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQH-0001F4-4l
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQG-0001DX-U4
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id n19so1050877wmi.1
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:36 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:26 +0100
Message-Id: <20190310003428.11723-5-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/6] target/m68k: Optimize get_sr() using
 deposit_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Doing so we free one tcg_temp.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ea95d55a11..f43ac07b7f 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2217,15 +2217,11 @@ static TCGv gen_get_ccr(DisasContext *s)
 
 static TCGv gen_get_sr(DisasContext *s)
 {
-    TCGv ccr;
-    TCGv sr;
+    TCGv dest;
 
-    ccr = gen_get_ccr(s);
-    sr = tcg_temp_new();
-    tcg_gen_andi_i32(sr, QREG_SR, 0xffe0);
-    tcg_gen_or_i32(sr, sr, ccr);
-    tcg_temp_free(ccr);
-    return sr;
+    dest = gen_get_ccr(s);
+    tcg_gen_deposit_i32(dest, dest, QREG_SR, 5, 11);
+    return dest;
 }
 
 static void gen_set_sr_im(DisasContext *s, uint16_t val, int ccr_only)
-- 
2.19.1
