Received: from eggs.gnu.org ([2001:4830:134:3::10]:60148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <onursahin08@gmail.com>) id 1ezDr3-00067l-UL
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <onursahin08@gmail.com>) id 1ezDr0-0003ky-Ti
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 23:59:02 -0400
From: Onur Sahin <onursahin08@gmail.com>
Date: Thu, 22 Mar 2018 23:58:29 -0400
Message-Id: <1521777509-22896-1-git-send-email-onursahin08@gmail.com>
Subject: [Qemu-devel] [PATCH] target-arm: Check undefined opcodes for SWP in
 A32 decoder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Onur Sahin <onursahin08@gmail.com>

Hi all,

I have noticed that the decoding part in ARM/A32 does not verify the
opcodes for SWP instructions. The opcode field ([23:20]) for SWP
instructions should be 0 or 4, and QEMU does not check against these
values.

Other opcode values less than 8 are Undefined within the encoding
space of sychronization primitives (e.g., SWP, LDREX*). See section
A5.2.10 of ARMv7-A manual for reference. Because of the missing opcode
check, QEMU happily executes these Undefined cases as a SWP instruction.

The following fix adds proper opcode checks before assuming a valid SWP.

Best,
Onur

Signed-off-by: Onur Sahin <onursahin08@gmail.com>
---
 target-arm/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target-arm/translate.c b/target-arm/translate.c
index bd5d5cb..fb31c12 100644
--- a/target-arm/translate.c
+++ b/target-arm/translate.c
@@ -8831,7 +8831,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             }
                         }
                         tcg_temp_free_i32(addr);
-                    } else {
+                    } else if (!(insn & 0x00B00000)) {
                         /* SWP instruction */
                         rm = (insn) & 0xf;
 
@@ -8852,6 +8852,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         tcg_temp_free_i32(addr);
                         store_reg(s, rd, tmp2);
                     }
+                    else {
+                        goto illegal_op;
+                    }
                 }
             } else {
                 int address_offset;
-- 
1.8.3.1
