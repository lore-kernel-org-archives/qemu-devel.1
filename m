Received: from eggs.gnu.org ([209.51.188.92]:60372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grsNy-00045m-Be
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1grsNx-0004xe-JY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:43:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:45138
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1grsNx-0004wp-DN
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 17:43:09 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu,  7 Feb 2019 22:42:58 +0000
Message-Id: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] tcg/i386: fix unsigned vector saturating
 arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org

Due to a cut/paste error in the original implementation, the unsigned vector
saturating arithmetic was erroneously being calculated as signed vector saturating
arithmetic.

Fixes: 8ffafbcec2 ("tcg/i386: Implement vector saturating arithmetic")
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 tcg/i386/tcg-target.inc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 4d84aea3a9..e0670e5098 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -2615,7 +2615,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
     };
     static int const usadd_insn[4] = {
-        OPC_PADDSB, OPC_PADDSW, OPC_UD2, OPC_UD2
+        OPC_PADDUB, OPC_PADDUW, OPC_UD2, OPC_UD2
     };
     static int const sub_insn[4] = {
         OPC_PSUBB, OPC_PSUBW, OPC_PSUBD, OPC_PSUBQ
@@ -2624,7 +2624,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
     };
     static int const ussub_insn[4] = {
-        OPC_PSUBSB, OPC_PSUBSW, OPC_UD2, OPC_UD2
+        OPC_PSUBUB, OPC_PSUBUW, OPC_UD2, OPC_UD2
     };
     static int const mul_insn[4] = {
         OPC_UD2, OPC_PMULLW, OPC_PMULLD, OPC_UD2
-- 
2.11.0
