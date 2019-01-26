Received: from eggs.gnu.org ([209.51.188.92]:46389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnPSQ-0001Kj-KG
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 10:01:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnPSO-0002YD-Fz
	for qemu-devel@nongnu.org; Sat, 26 Jan 2019 10:01:18 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sat, 26 Jan 2019 15:50:28 +0100
Message-Id: <20190126150102.7AABC74569F@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] target/ppc: Fix msync to do what hardware does
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

According to BookE docs, invalid bits (while undefined behaviour) should
not raise exception but be ignored. This seems to be implementation
dependent though and QEMU currently does what e500 CPUs do and raise
exception for invalid bits. Unfortunately some versions of libstdc++
(and so all programs compiled with it) have lwsync on PPC440 which is
invalid but on real hardware it's just executed as msync ignoring the
invalid bits (maybe that's why it got undetected) but they fail on QEMU.
This patch changes invalid mask of msync to allow these programs to run
but keep generating exception on e500 cores to follow what hardware does.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/translate.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e169c43643..5429ceb1ab 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6476,7 +6476,12 @@ static void gen_mbar(DisasContext *ctx)
 /* msync replaces sync on 440 */
 static void gen_msync_4xx(DisasContext *ctx)
 {
-    /* interpreted as no-op */
+    /* Only e500 seems to treat reserved bits as invalid */
+    if ((ctx->insns_flags2 & PPC2_BOOKE206) &&
+        (ctx->opcode & 0x03FFF801)) {
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
+    }
+    /* otherwise interpreted as no-op */
 }
 
 /* icbt */
@@ -7054,11 +7059,11 @@ GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
 GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
 GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
               PPC_BOOKE, PPC2_BOOKE206),
-GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
+GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x039FF801, PPC_BOOKE),
 GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
                PPC_BOOKE, PPC2_BOOKE206),
 GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
-               PPC_440_SPEC),
+             PPC_440_SPEC),
 GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
 GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),
-- 
2.13.7
