Received: from eggs.gnu.org ([208.118.235.92]:38512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eznhg-0004b0-Cm
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ezngc-0003p7-CF
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:15:44 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ezngc-0003oe-54
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 14:14:38 -0400
Received: by mail-pl0-x241.google.com with SMTP id w15-v6so9385428plq.9
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 11:14:38 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Sat, 24 Mar 2018 11:13:39 -0700
Message-Id: <1521915220-65389-14-git-send-email-mjc@sifive.com>
In-Reply-To: <1521915220-65389-1-git-send-email-mjc@sifive.com>
References: <1521915220-65389-1-git-send-email-mjc@sifive.com>
Subject: [Qemu-devel] [PATCH v6 25/26] RISC-V: Fix incorrect disassembly for
 addiw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@groups.riscv.org, Michael Clark <mjc@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>

This fixes a bug in the disassembler constraints used
to lift instructions into pseudo-instructions, whereby
addiw instructions are always lifted to sext.w instead
of just lifting addiw with a zero immediate.

An associated fix has been made to the metadata used to
machine generate the disseasembler:

https://github.com/michaeljclark/riscv-meta/
commit/4a6b2f3898430768acfe201405224d2ea31e1477

Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael Clark <mjc@sifive.com>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 4580308..2cecf0d 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -600,7 +600,7 @@ static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
 static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_negw[] = { rvc_rs1_eq_x0, rvc_end };
-static const rvc_constraint rvcc_sext_w[] = { rvc_rs2_eq_x0, rvc_end };
+static const rvc_constraint rvcc_sext_w[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_seqz[] = { rvc_imm_eq_p1, rvc_end };
 static const rvc_constraint rvcc_snez[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_sltz[] = { rvc_rs2_eq_x0, rvc_end };
-- 
2.7.0
