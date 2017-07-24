Received: from eggs.gnu.org ([2001:4830:134:3::10]:50658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6X-0000qZ-3Y
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6W-0005Z0-8f
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:39 -0300
Message-Id: <20170724182751.18261-24-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 23/35] m68k/translate: fix incorrect
 copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

db3d7945ae extended gen_cc_cond() for cond [6, 7, 9, 10] but misswrote [4, 5]

target/m68k/translate.c:1323:70: warning: identical expressions on both sides of logical operator
        if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
            ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~ ^

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/m68k/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ada2a91b64..1a2f421aab 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -1321,7 +1321,8 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
     case 5: /* CS (C) */
         /* Some cases fold C into X.  */
         if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
-            op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
+            op == CC_OP_SUBB || op == CC_OP_SUBW || op == CC_OP_SUBL ||
+            op == CC_OP_LOGIC) {
             tcond = TCG_COND_NE;
             c->v1 = QREG_CC_X;
             goto done;
-- 
2.13.3
