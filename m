Received: from eggs.gnu.org ([209.51.188.92]:59928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gmiYU-0007cJ-Pl
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:12:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gmiYU-0000sF-0e
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 12:12:42 -0500
MIME-Version: 1.0
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 24 Jan 2019 18:12:27 +0100
Message-ID: <CABoDooOvD_GWJovXjDSQY640seOCn+zLQzxehSgUmYQss9H83Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] AArch64: some missed undefined instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

Hello,

I did exhaustive comparisons against latest binutils and found the
following undefined instructions that QEMU fails to flag:

- in disas_b_exc_sys, before calling disas_system bits [23:22] should
be checked to be 0

- in disas_ldst_reg_imm9, PRFM is wrongly detected:  PRFM is for idx =
0, not for is_unpriv, the rest being undefined

- in disas_ldst_multiple_struct, if the instruction is not
post-indexed, then bits [20:16] should be checked to be 0

- in disas_ldst_single_struct, if the instruction is not post-indexed,
then bits [20:16] should be checked to be 0;  also bit [31] should be
0

- in disas_add_sub_ext_reg, bits [23:22] should be checked to be 0

- in disas_data_proc_1src, there's a missing default that would flag
undefined instructions

- in disas_fp_1src, disas_fp_2src, disas_fp_3src, and disas_fp_imm
bits,  [31:29] should be checked to be 0

- in disas_fp_imm, bits [9:5] should be checked to be 0

- in disas_simd_indexed, SDOT and UDOT are not scalar instructions.

That's all I found.  I hope I didn't make any transcription error :-)

Thanks,

Laurent
