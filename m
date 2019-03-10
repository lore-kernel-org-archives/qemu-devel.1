Received: from eggs.gnu.org ([209.51.188.92]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQI-0003Nu-V5
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQI-0001GK-4U
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:38 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQH-0001FD-UI
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:38 -0500
Received: by mail-wr1-x442.google.com with SMTP id f14so1284413wrg.1
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:27 +0100
Message-Id: <20190310003428.11723-6-f4bug@amsat.org>
In-Reply-To: <20190310003428.11723-1-f4bug@amsat.org>
References: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/6] target/m68k: Optimize rotate_x() using
 extract_i32()
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

Optimize rotate_x() using tcg_gen_extract_i32(). We can now free the
'sz' tcg_temp earlier. Since it is allocated with tcg_const_i32(),
free it with tcg_temp_free_i32().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f43ac07b7f..b51b8a2a12 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -3686,6 +3686,7 @@ static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
         tcg_gen_sub_i32(shl, shl, shift); /* shl = size + 1 - shift */
         tcg_gen_sub_i32(shx, sz, shift); /* shx = size - shift */
     }
+    tcg_temp_free_i32(sz);
 
     /* reg = (reg << shl) | (reg >> shr) | (x << shx); */
 
@@ -3701,9 +3702,7 @@ static TCGv rotate_x(TCGv reg, TCGv shift, int left, int size)
     /* X = (reg >> size) & 1 */
 
     X = tcg_temp_new();
-    tcg_gen_shr_i32(X, reg, sz);
-    tcg_gen_andi_i32(X, X, 1);
-    tcg_temp_free(sz);
+    tcg_gen_extract_i32(X, reg, size, 1);
 
     return X;
 }
-- 
2.19.1
