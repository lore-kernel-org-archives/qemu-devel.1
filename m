Received: from eggs.gnu.org ([2001:4830:134:3::10]:59783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <onursahin08@gmail.com>) id 1ezUTJ-000657-TH
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:43:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <onursahin08@gmail.com>) id 1ezUTG-00066K-PT
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 17:43:37 -0400
From: Onur Sahin <onursahin08@gmail.com>
Date: Fri, 23 Mar 2018 17:43:06 -0400
Message-Id: <1521841386-27498-1-git-send-email-onursahin08@gmail.com>
In-Reply-To: <CAFEAcA9G3xVjmjys2R4-NXRHiZwLVLRO7ZQDZ0AhNMHHFhHV8A@mail.gmail.com>
References: <CAFEAcA9G3xVjmjys2R4-NXRHiZwLVLRO7ZQDZ0AhNMHHFhHV8A@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v2] target-arm: Check undefined opcodes for SWP
 in A32 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, Onur Sahin <onursahin08@gmail.com>

Thanks for the feedback Peter. Removing the redundant check on bit
23 and adding checks for the "should be" bits as well (bits [11:8]).

The following patch should make sure we are not treating
architecturally Undefined instructions as a SWP, by verifying
the opcodes as per section A8.8.229 of ARMv7-A specification.

Best,
Onur

Signed-off-by: Onur Sahin <onursahin08@gmail.com>
---
 target/arm/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ba6ab7d..1fb0b8f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9227,11 +9227,14 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
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
@@ -9249,6 +9252,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                                                 get_mem_index(s), opc);
                         tcg_temp_free(taddr);
                         store_reg(s, rd, tmp);
+                    } else {
+                        goto illegal_op;
                     }
                 }
             } else {
-- 
1.8.3.1
