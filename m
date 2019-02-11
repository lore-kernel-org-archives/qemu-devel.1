Received: from eggs.gnu.org ([209.51.188.92]:48003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCC-0004lk-0R
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCA-0004NA-3g
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:43 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:50060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtGC2-00048a-2g
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:36 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 19:19:06 +0100
Message-Id: <20190211181907.2219-5-svens@stackframe.org>
In-Reply-To: <20190211181907.2219-2-svens@stackframe.org>
References: <20190211181907.2219-2-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] target/hppa: fix sed conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

Now that do_cond() uses sign overflow for some condition matches we
need to roll our own version without sign overflow checks.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index bce8773b1a..d858fabd3a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1029,20 +1029,32 @@ static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(unsigned orig, TCGv_reg res)
+static DisasCond do_sed_cond(unsigned c, TCGv_reg res)
 {
-    unsigned c, f;
+    DisasCond cond;
+    TCGv_reg tmp;
 
-    /* Convert the compressed condition codes to standard.
-       0-2 are the same as logicals (nv,<,<=), while 3 is OD.
-       4-7 are the reverse of 0-3.  */
-    c = orig & 3;
-    if (c == 3) {
-        c = 7;
+    switch(c & 3) {
+    case 0: /* never */
+        cond = cond_make_f();
+        break;
+    case 1: /* = all bits are zero */
+        cond = cond_make_0(TCG_COND_EQ, res);
+        break;
+    case 2: /* < leftmost bit is 1 */
+        cond = cond_make_0(TCG_COND_LT, res);
+        break;
+    case 3: /* OD rightmost bit is 1 */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_reg(tmp, res, 1);
+        cond = cond_make_0(TCG_COND_NE, tmp);
+        tcg_temp_free(tmp);
+        break;
     }
-    f = (orig & 4) / 4;
-
-    return do_log_cond(c * 2 + f, res);
+    if (c & 4) {
+        cond.c = tcg_invert_cond(cond.c);
+    }
+    return cond;
 }
 
 /* Similar, but for unit conditions.  */
-- 
2.20.1
