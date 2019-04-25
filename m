Received: from eggs.gnu.org ([209.51.188.92]:35081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8x-0006fq-J9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJi8w-0003A2-4L
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43692)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJi8v-00039g-Oz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:26:42 -0400
Received: by mail-pf1-x441.google.com with SMTP id e67so234050pfe.10
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 10:26:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 25 Apr 2019 10:26:36 -0700
Message-Id: <20190425172636.11128-3-richard.henderson@linaro.org>
In-Reply-To: <20190425172636.11128-1-richard.henderson@linaro.org>
References: <20190425172636.11128-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/riscv: Add checks for several RVC
 reserved operands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: palmer@sifive.com

C.ADDI16SP, C.LWSP, C.JR, C.ADDIW, C.LDSP all have reserved
operands that were not diagnosed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/insn16-64.decode | 10 ++++++++--
 target/riscv/insn16.decode    |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
index 055859d29f..672e1e916f 100644
--- a/target/riscv/insn16-64.decode
+++ b/target/riscv/insn16-64.decode
@@ -21,10 +21,16 @@ ld                011  ... ... .. ... 00 @cl_d
 sd                111  ... ... .. ... 00 @cs_d
 
 # *** RV64C Standard Extension (Quadrant 1) ***
-addiw             001 .  .....  ..... 01 @ci
+{
+  illegal         001 -  00000  ----- 01 # c.addiw, RES rd=0
+  addiw           001 .  .....  ..... 01 @ci
+}
 subw              100 1 11 ... 00 ... 01 @cs_2
 addw              100 1 11 ... 01 ... 01 @cs_2
 
 # *** RV64C Standard Extension (Quadrant 2) ***
-ld                011 .  .....  ..... 10 @c_ldsp
+{
+  illegal         011 -  00000  ----- 10 # c.ldsp, RES rd=0
+  ld              011 .  .....  ..... 10 @c_ldsp
+}
 sd                111 .  .....  ..... 10 @c_sdsp
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 433c0e8c68..c06073ee72 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -96,6 +96,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  illegal         011 0  -----  00000 01 # c.addi16sp, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
 }
@@ -113,8 +114,12 @@ bne               111  ... ...  ..... 01 @cb_z
 # *** RV32/64C Standard Extension (Quadrant 2) ***
 slli              000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ldsp
-lw                010 .  .....  ..... 10 @c_lwsp
 {
+  illegal         010 -  00000  ----- 10 # c.lwsp, RES rd=0
+  lw              010 .  .....  ..... 10 @c_lwsp
+}
+{
+  illegal         100 0  00000  00000 10 # c.jr, RES rs1=0
   jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
   addi            100 0  .....  ..... 10 @c_mv
 }
-- 
2.17.1
