Received: from eggs.gnu.org ([2001:4830:134:3::10]:35385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-00016I-9a
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002TE-7o
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:21679)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNN-0002Rt-2E
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:25 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:08 +0100
Message-ID: <1501771515-22847-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 1/8] target-mips: Don't stop on [d]mtc0
 DESAVE/KScratch
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

Writing to the MIPS DESAVE register (and now the KScratch registers)
will stop translation, supposedly due to risk of execution mode
switches. However these registers are basically RW scratch registers
with no side effects so there is no risk of them triggering execution
mode changes.

Drop the bstate = BS_STOP for these registers for both mtc0 and dmtc0.

Fixes: 7a387fffce50 ("Add MIPS32R2 instructions, and generally straighten out the instruction decoding. This is also the first percent towards MIPS64 support.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51626ae..0bca700 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -6386,8 +6386,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         default:
             goto cp0_unimplemented;
         }
-        /* Stop translation as we may have switched the execution mode */
-        ctx->bstate = BS_STOP;
         break;
     default:
        goto cp0_unimplemented;
@@ -7714,8 +7712,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
         default:
             goto cp0_unimplemented;
         }
-        /* Stop translation as we may have switched the execution mode */
-        ctx->bstate = BS_STOP;
         break;
     default:
         goto cp0_unimplemented;
-- 
2.7.4
