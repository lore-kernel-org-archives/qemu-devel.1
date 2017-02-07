Received: from eggs.gnu.org ([2001:4830:134:3::10]:32798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe4-0007ZY-88
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe3-0002lR-5q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:40 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe2-0002gg-VL
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:39 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdu-0005Uk-Gt
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:30 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:21 +0000
Message-Id: <1486492645-27803-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 09/13] target/arm: Abstract out pbit/wbit tests
 in ARM ldr/str decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

In the ARM ldr/str decode path, rather than directly testing
"insn & (1 << 21)" and "insn & (1 << 24)", abstract these
bits out into wbit and pbit local flags. (We will want to
do more tests against them to determine whether we need to
provide syndrome information.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/arm/translate.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 493c627..175b4c1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8782,6 +8782,8 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             } else {
                 int address_offset;
                 bool load = insn & (1 << 20);
+                bool wbit = insn & (1 << 21);
+                bool pbit = insn & (1 << 24);
                 bool doubleword = false;
                 /* Misc load/store */
                 rn = (insn >> 16) & 0xf;
@@ -8799,8 +8801,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 }
 
                 addr = load_reg(s, rn);
-                if (insn & (1 << 24))
+                if (pbit) {
                     gen_add_datah_offset(s, insn, 0, addr);
+                }
                 address_offset = 0;
 
                 if (doubleword) {
@@ -8849,10 +8852,10 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                    ensure correct behavior with overlapping index registers.
                    ldrd with base writeback is undefined if the
                    destination and index registers overlap.  */
-                if (!(insn & (1 << 24))) {
+                if (!pbit) {
                     gen_add_datah_offset(s, insn, address_offset, addr);
                     store_reg(s, rn, addr);
-                } else if (insn & (1 << 21)) {
+                } else if (wbit) {
                     if (address_offset)
                         tcg_gen_addi_i32(addr, addr, address_offset);
                     store_reg(s, rn, addr);
-- 
2.7.4
