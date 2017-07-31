Received: from eggs.gnu.org ([2001:4830:134:3::10]:48734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAsi-0007B1-4c
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:37:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAse-0006Kn-WD
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:37:12 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:7206)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dcAse-0006Ig-QV
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 09:37:08 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Mon, 31 Jul 2017 14:36:45 +0100
Message-ID: <1b88a351b0c447a2a4045a7d6979f62b4af96604.1501508116.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] target-mips: Don't stop on [d]mtc0
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
Cc: James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>

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
---
Changes in v2:
- Resend based on v2.10.0-rc0
---
 target/mips/translate.c | 4 ----
 1 file changed, 0 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 51626aead32c..0bca700fb380 100644
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
git-series 0.8.10
