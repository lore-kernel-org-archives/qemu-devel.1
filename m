Received: from eggs.gnu.org ([2001:4830:134:3::10]:35400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-00016o-Py
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNR-0002XG-O2
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:26811)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNR-0002X5-Ii
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:29 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:14 +0100
Message-ID: <1501771515-22847-8-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 7/8] target/mips: Drop redundant
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
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>

From: James Hogan <james.hogan@imgtec.com>

DMTC0 CP0_Cause does a redundant gen_io_start() and gen_io_end() pair,
even though this is done for all DMTC0 operations outside of the switch
statement. Remove these redundant calls.

Fixes: 5dc5d9f055c5 ("mips: more fixes to the MIPS interrupt glue logic")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index ba6b8f5..bcea2a1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7401,15 +7401,7 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
2.7.4
