Received: from eggs.gnu.org ([2001:4830:134:3::10]:54868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOg-0000eM-A6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fEAOc-0004vi-A2
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:30 -0400
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:45439)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fEAOc-0004vM-1T
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:19:26 -0400
Received: by mail-lf0-x244.google.com with SMTP id y14-v6so24547619lfy.12
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 02:19:25 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu,  3 May 2018 11:18:53 +0200
Message-Id: <20180503091922.28733-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 00/29] target-microblaze: Add support for
 Extended Addressing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, sai.pavan.boddu@xilinx.com, alistair@alistair23.me, frasse.iglesias@gmail.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

This series adds support for Extended Addressing to our MicroBlaze
models. It adds both the non-MMU load/store EA and the extended MMU
addressing.

There are several ways to implement this but since there are further
64-bit extensions in the pipe, I've chosen to convert the cpu_SR
special regs to 64-bit. Both non-EA and EA enabled cores run out of
the same build with TARGET_LONG_BITS=64.

Comments?

Thanks & Best regards,
Edgar


Edgar E. Iglesias (29):
  target-microblaze: dec_load: Use bool instead of unsigned int
  target-microblaze: dec_store: Use bool instead of unsigned int
  target-microblaze: compute_ldst_addr: Use bool instead of int
  target-microblaze: Fallback to our latest CPU version
  target-microblaze: Correct special register array sizes
  target-microblaze: Correct the PVR array size
  target-microblaze: Tighten up TCGv_i32 vs TCGv type usage
  target-microblaze: Remove USE_MMU PVR checks
  target-microblaze: Conditionalize setting of PVR11_USE_MMU
  target-microblaze: Bypass MMU with MMU_NOMMU_IDX
  target-microblaze: Make compute_ldst_addr always use a temp
  target-microblaze: Remove pointer indirection for ld/st addresses
  target-microblaze: Use TCGv for load/store addresses
  target-microblaze: Name special registers we support
  target-microblaze: Break out trap_userspace()
  target-microblaze: Break out trap_illegal()
  target-microblaze: dec_msr: Use bool and extract32
  target-microblaze: dec_msr: Reuse more code when reg-decoding
  target-microblaze: dec_msr: Fix MTS to FSR
  target-microblaze: Make special registers 64-bit
  target-microblaze: Setup for 64bit addressing
  target-microblaze: Add Extended Addressing
  target-microblaze: Implement MFSE EAR
  target-microblaze: mmu: Add R_TBLX_MISS macros
  target-microblaze: mmu: Remove unused register state
  target-microblaze: mmu: Prepare for 64-bit addresses
  target-microblaze: mmu: Add a configurable output address mask
  target-microblaze: Add support for extended access to TLBLO
  target-microblaze: Allow address sizes between 32 and 64 bits

 configure                        |   1 +
 linux-user/microblaze/cpu_loop.c |   4 +-
 target/microblaze/cpu.c          |  30 +-
 target/microblaze/cpu.h          |  16 +-
 target/microblaze/helper.c       |  30 +-
 target/microblaze/helper.h       |   8 +-
 target/microblaze/mmu.c          |  48 ++-
 target/microblaze/mmu.h          |  17 +-
 target/microblaze/op_helper.c    |  28 +-
 target/microblaze/translate.c    | 874 +++++++++++++++++++--------------------
 10 files changed, 534 insertions(+), 522 deletions(-)

-- 
2.14.1
