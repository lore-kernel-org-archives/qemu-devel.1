Received: from eggs.gnu.org ([2001:4830:134:3::10]:50516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTn-0007yC-TY
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlTm-0002da-VL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:11 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlTm-0002d0-Pe
	for qemu-devel@nongnu.org; Tue, 16 May 2017 19:02:10 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 01:01:58 +0200
Message-Id: <20170516230159.4195-4-aurelien@aurel32.net>
In-Reply-To: <20170516230159.4195-1-aurelien@aurel32.net>
References: <20170516230159.4195-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 3/4] target/cris: optimize swap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

Use the same mask to avoid having to load two different constants, as
suggest by Richard Henderson. Also use one less temp.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/cris/translate.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0ee05ca02d..103b214233 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -433,20 +433,19 @@ static inline void t_gen_subx_carry(DisasContext *dc, TCGv d)
    T0 = ((T0 << 8) & 0xff00ff00) | ((T0 >> 8) & 0x00ff00ff)  */
 static inline void t_gen_swapb(TCGv d, TCGv s)
 {
-    TCGv t, org_s;
+    TCGv t, m;
 
     t = tcg_temp_new();
-    org_s = tcg_temp_new();
+    m = tcg_const_tl(0x00ff00ff);
 
     /* d and s may refer to the same object.  */
-    tcg_gen_mov_tl(org_s, s);
-    tcg_gen_shli_tl(t, org_s, 8);
-    tcg_gen_andi_tl(d, t, 0xff00ff00);
-    tcg_gen_shri_tl(t, org_s, 8);
-    tcg_gen_andi_tl(t, t, 0x00ff00ff);
+    tcg_gen_shri_tl(t, s, 8);
+    tcg_gen_and_tl(t, t, m);
+    tcg_gen_and_tl(d, s, m);
+    tcg_gen_shli_tl(d, d, 8);
     tcg_gen_or_tl(d, d, t);
+    tcg_temp_free(m);
     tcg_temp_free(t);
-    tcg_temp_free(org_s);
 }
 
 /* Swap the halfwords of the s operand.  */
-- 
2.11.0
