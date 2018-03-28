Received: from eggs.gnu.org ([2001:4830:134:3::10]:39002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1Hsa-000445-3s
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1f1HsZ-0000XG-0h
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:08 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:41502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1f1HsY-0000Wx-Qp
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 16:41:06 -0400
Received: by mail-pg0-x243.google.com with SMTP id t10so1552496pgv.8
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 13:41:06 -0700 (PDT)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 28 Mar 2018 13:40:19 -0700
Message-Id: <1522269619-48636-3-git-send-email-mjc@sifive.com>
In-Reply-To: <1522269619-48636-1-git-send-email-mjc@sifive.com>
References: <1522269619-48636-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] RISC-V: Fix incorrect disassembly for addiw
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 3c17501..74ad16e 100644
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
