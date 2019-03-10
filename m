Received: from eggs.gnu.org ([209.51.188.92]:46986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQG-0003Lr-LS
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQF-0001DN-Vl
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:36 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:45060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQF-0001Bs-P3
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id o7so1246755wrp.12
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:35 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:25 +0100
Message-Id: <20190310003428.11723-4-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/6] target/m68k: Fix a tcg_temp leak
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

The function gen_get_ccr() returns a tcg_temp created with
tcg_temp_new(). Free it with tcg_temp_free().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Laurent/Richard, feel free to squash this with the next patch, but
IMHO having it split as a previous step makes the next patch easier
to review.
---
 target/m68k/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 55766fd7ef..ea95d55a11 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -2224,6 +2224,7 @@ static TCGv gen_get_sr(DisasContext *s)
     sr = tcg_temp_new();
     tcg_gen_andi_i32(sr, QREG_SR, 0xffe0);
     tcg_gen_or_i32(sr, sr, ccr);
+    tcg_temp_free(ccr);
     return sr;
 }
 
-- 
2.19.1
