Received: from eggs.gnu.org ([2001:4830:134:3::10]:56968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDU-0007vc-Bs
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDT-0000kr-GY
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDT-0000iH-9X
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDI-0007aN-PO
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:28 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:15 +0100
Message-Id: <20180410121724.8549-4-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/12] target-arm: Check undefined opcodes for
 SWP in A32 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Onur Sahin <onursahin08@gmail.com>

Make sure we are not treating architecturally Undefined instructions
as a SWP, by verifying the opcodes as per section A8.8.229 of ARMv7-A
specification. Bits [21:20] must be zero for this to be a SWP or SWPB.
We also choose to UNDEF for the architecturally UNPREDICTABLE case of
bits [11:8] not being zero.

Signed-off-by: Onur Sahin <onursahin08@gmail.com>
[PMM: tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index fc03b5b8c8..db1ce6510a 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9237,11 +9237,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             }
                         }
                         tcg_temp_free_i32(addr);
-                    } else {
+                    } else if ((insn & 0x00300f00) == 0) {
+                        /* 0bcccc_0001_0x00_xxxx_xxxx_0000_1001_xxxx
+                        *  - SWP, SWPB
+                        */
+
                         TCGv taddr;
                         TCGMemOp opc = s->be_data;
 
-                        /* SWP instruction */
                         rm = (insn) & 0xf;
 
                         if (insn & (1 << 22)) {
@@ -9259,6 +9262,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                                                 get_mem_index(s), opc);
                         tcg_temp_free(taddr);
                         store_reg(s, rd, tmp);
+                    } else {
+                        goto illegal_op;
                     }
                 }
             } else {
-- 
2.16.2
