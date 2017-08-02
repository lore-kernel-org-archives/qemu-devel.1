Received: from eggs.gnu.org ([2001:4830:134:3::10]:36164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRH-0003Kc-HW
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRG-0002gb-LR
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:39 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:36182)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcqRG-0002Zu-Fq
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 05:59:38 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Wed, 2 Aug 2017 10:59:16 +0100
Message-ID: <de6d5c5610c6b5887e72e60a999963c9d414742b.1501667615.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
References: <cover.7fbcecb0d0061824a32985f26b9c1b7f816203b0.1501667615.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH for-2.10 2/3] target/mips: Drop redundant
 gen_io_start/stop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

DMTC0 CP0_Cause does a redundant gen_io_start() and gen_io_end() pair,
even though this is done for all DMTC0 operations outside of the switch
statement. Remove these redundant calls.

Fixes: 5dc5d9f055c5 ("mips: more fixes to the MIPS interrupt glue logic")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/translate.c | 8 --------
 1 file changed, 0 insertions(+), 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 6b41f7b65e00..6e724ac71dcd 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7403,15 +7403,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         switch (sel) {
         case 0:
             save_cpu_state(ctx, 1);
-            /* Mark as an IO operation because we may trigger a software
-               interrupt.  */
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_start();
-            }
             gen_helper_mtc0_cause(cpu_env, arg);
-            if (ctx->tb->cflags & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
             /* Stop translation as we may have triggered an intetrupt. BS_STOP
              * isn't sufficient, we need to ensure we break out of translated
              * code to check for pending interrupts.  */
-- 
git-series 0.8.10
