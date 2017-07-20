Received: from eggs.gnu.org ([2001:4830:134:3::10]:60175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qN-00016U-1A
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qJ-0005qm-Ps
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45613)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qJ-0005pM-IA
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:04 -0400
Message-Id: <1500520169-23367-19-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 18/43] target/sh4: check CF_PARALLEL instead
 of parallel_cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

Thereby decoupling the resulting translated code from the current state
of the system.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 9fcaefd..52fabb3 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -528,7 +528,7 @@ static void _decode_opc(DisasContext * ctx)
         /* Detect the start of a gUSA region.  If so, update envflags
            and end the TB.  This will allow us to see the end of the
            region (stored in R0) in the next TB.  */
-        if (B11_8 == 15 && B7_0s < 0 && parallel_cpus) {
+        if (B11_8 == 15 && B7_0s < 0 && (tb_cflags(ctx->tb) & CF_PARALLEL)) {
             ctx->envflags = deposit32(ctx->envflags, GUSA_SHIFT, 8, B7_0s);
             ctx->bstate = BS_STOP;
         }
-- 
2.7.4
