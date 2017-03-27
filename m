Received: from eggs.gnu.org ([2001:4830:134:3::10]:57356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csX8L-0001Ow-NU
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csX8K-0003iG-QP
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:41 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1csX8K-0003YE-KF
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:04:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Mar 2017 17:04:30 +0100
Message-Id: <1490630670-15818-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
References: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9 2/2] tcg/sparc: Zero extend address
 argument to ld/st helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

The C store helper functions take the address argument as a
target_ulong type; if this is 32 bit but the host is 64 bit
then the SPARC calling convention requires that the caller
must zero extend the value. We weren't doing this, which
meant we could pass values to the caller with high bits set
and QEMU would crash if it was compiled with optimizations.
In particular, the i386 BIOS would not start.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tcg/sparc/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
index 548bea2..a7c4d9b 100644
--- a/tcg/sparc/tcg-target.inc.c
+++ b/tcg/sparc/tcg-target.inc.c
@@ -1146,7 +1146,7 @@ static void tcg_out_qemu_ld(TCGContext *s, TCGReg data, TCGReg addr,
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;
     }
-    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
+    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
 
     /* We use the helpers to extend SB and SW data, leaving the case
        of SL needing explicit extending below.  */
@@ -1226,7 +1226,7 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data, TCGReg addr,
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;
     }
-    tcg_out_mov(s, TCG_TYPE_REG, param++, addr);
+    tcg_out_mov(s, TCG_TYPE_REG, param++, addrz);
     if (!SPARC64 && (memop & MO_SIZE) == MO_64) {
         /* Skip the high-part; we'll perform the extract in the trampoline.  */
         param++;
-- 
2.7.4
