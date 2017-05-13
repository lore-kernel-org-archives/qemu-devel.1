Received: from eggs.gnu.org ([2001:4830:134:3::10]:35606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9Kvx-0008Pa-Lq
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9Kvt-000803-Ox
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:29:21 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:32771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d9Kvt-0007yp-Lm
	for qemu-devel@nongnu.org; Fri, 12 May 2017 20:29:17 -0400
Received: by mail-qt0-x244.google.com with SMTP id a46so8795209qte.0
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 17:29:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 12 May 2017 21:29:06 -0300
Message-Id: <20170513002906.31201-1-f4bug@amsat.org>
In-Reply-To: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
References: <a98c67f8-3c5c-b68d-beea-f1972bb3dc0d@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] tcg: optimize gen_extr_i64_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Inspired by Richard Henderson comment:

    http://lists.nongnu.org/archive/html/qemu-devel/2017-05/msg02277.html

Patch applied mechanically with this coccinelle semantic patch:

    @@
    expression lo, hi,arg;
    @@
    -tcg_gen_extrl_i64_i32(lo, arg);
    -tcg_gen_extrh_i64_i32(hi, arg);
    +tcg_gen_extr_i64_i32(lo, hi, arg);

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tcg/tcg-op.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 6b1f41500c..f3d556c21a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2562,8 +2562,7 @@ void tcg_gen_extr_i64_i32(TCGv_i32 lo, TCGv_i32 hi, TCGv_i64 arg)
         tcg_gen_mov_i32(lo, TCGV_LOW(arg));
         tcg_gen_mov_i32(hi, TCGV_HIGH(arg));
     } else {
-        tcg_gen_extrl_i64_i32(lo, arg);
-        tcg_gen_extrh_i64_i32(hi, arg);
+        tcg_gen_extr_i64_i32(lo, hi, arg);
     }
 }
 
-- 
2.11.0
