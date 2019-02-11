Received: from eggs.gnu.org ([209.51.188.92]:48128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCL-0004tV-3y
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCI-0004XU-Um
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:52 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:59183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtGCI-00048A-Ku
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:50 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 19:19:05 +0100
Message-Id: <20190211181907.2219-4-svens@stackframe.org>
In-Reply-To: <20190211181907.2219-2-svens@stackframe.org>
References: <20190211181907.2219-2-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/5] target/hppa: fix log conditions
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
 target/hppa/translate.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 0e8cc8117a..bce8773b1a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -996,12 +996,35 @@ static DisasCond do_sub_cond(unsigned cf, TCGv_reg res,
 
 static DisasCond do_log_cond(unsigned cf, TCGv_reg res)
 {
+    DisasCond cond;
+    TCGv_reg tmp;
+
     switch (cf >> 1) {
-    case 4: case 5: case 6:
-        cf &= 1;
+    case 0: /* never */
+        cond = cond_make_f();
+        break;
+    case 1: /* = all bits are zero */
+        cond = cond_make_0(TCG_COND_EQ, res);
+        break;
+    case 2: /* < leftmost bit is 1 */
+        cond = cond_make_0(TCG_COND_LT, res);
+        break;
+    case 3: /* <= leftmost bit is 1 or all bits 0 */
+        cond = cond_make_0(TCG_COND_LE, res);
+        break;
+    case 7: /* OD rightmost bit is 1 */
+        tmp = tcg_temp_new();
+        tcg_gen_andi_reg(tmp, res, 1);
+        cond = cond_make_0(TCG_COND_NE, tmp);
+        tcg_temp_free(tmp);
+        break;
+    default:
         break;
     }
-    return do_cond(cf, res, res, res);
+    if (cf & 1) {
+        cond.c = tcg_invert_cond(cond.c);
+    }
+    return cond;
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
-- 
2.20.1
