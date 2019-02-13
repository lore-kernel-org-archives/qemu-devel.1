Received: from eggs.gnu.org ([209.51.188.92]:56311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwiy-00027C-KM
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gtwiw-0006pg-O7
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:24 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38305)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gtwiq-0006SY-P1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:45:20 -0500
Received: by mail-pg1-x542.google.com with SMTP id g189so1300765pgc.5
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 07:45:03 -0800 (PST)
Date: Wed, 13 Feb 2019 07:44:39 -0800
Message-Id: <20190213154450.14749-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL] RISC-V Patches for the 4.0 Soft Freeze, Part 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

merged tag 'pull-tcg-20190211'
Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF 38E8 AF7E 215F
The following changes since commit 22c5f446514a2a4bb0dbe1fea26713da92fc85fa:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190211' into staging (2019-02-11 17:04:57 +0000)

are available in the Git repository at:

  git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.0-sf1

for you to fetch changes up to 40e46e516d90c2dfe8e8de3741c1c65f1b526502:

  riscv: Ensure the kernel start address is correctly cast (2019-02-11 15:56:22 -0800)

----------------------------------------------------------------
RISC-V Patches for the 4.0 Soft Freeze, Part 1

This patch set contains a handful of patches I've collected over the
last few weeks.  There's nothing really fundamental, but I thought it
would be good to send these out now as there are some other patch sets
on the mailing list that are getting ready to go.

As far as the actual patches, there's:

* A set that cleans up our FS dirty-mode handling.
* Support for writing MISA.
* The removal of Michael as a maintainer.
* A fix to {m,s}counteren handling.
* A fix to make sure the kernel's start address is computed correctly on
  32-bit targets.

This makes my "RISC-V Patches for 3.2, Part 3" pull request defunct, as
it contains the same patches but based on a newer master.  As usual,
I've tested this using a Fedora boot on the latest Linux.  This patch
set does not include Bastian's decodetree patches because there were
some merge conflicts and while I've cleaned them up I want to get a
round of review first.

----------------------------------------------------------------
Alistair Francis (2):
      RISC-V: Add priv_ver to DisasContext
      riscv: Ensure the kernel start address is correctly cast

Michael Clark (5):
      RISC-V: Implement mstatus.TSR/TW/TVM
      RISC-V: Use riscv prefix consistently on cpu helpers
      RISC-V: Add misa to DisasContext
      RISC-V: Add misa.MAFD checks to translate
      RISC-V: Add misa runtime write support

Palmer Dabbelt (1):
      MAINTAINERS: Remove Michael Clark as a RISC-V Maintainer

Richard Henderson (2):
      RISC-V: Split out mstatus_fs from tb_flags
      RISC-V: Mark mstatus.fs dirty

Xi Wang (1):
      target/riscv: fix counter-enable checks in ctr()

 MAINTAINERS               |   1 -
 hw/riscv/sifive_e.c       |   2 +-
 hw/riscv/sifive_u.c       |   2 +-
 hw/riscv/spike.c          |   2 +-
 hw/riscv/virt.c           |   2 +-
 linux-user/riscv/signal.c |   4 +-
 target/riscv/cpu.c        |   2 +-
 target/riscv/cpu.h        |  31 ++---
 target/riscv/cpu_bits.h   |  11 ++
 target/riscv/cpu_helper.c |  10 +-
 target/riscv/csr.c        | 103 ++++++++++++----
 target/riscv/fpu_helper.c |   6 +-
 target/riscv/op_helper.c  |  47 +++++---
 target/riscv/translate.c  | 290 +++++++++++++++++++++++++++++++++++++++-------
 14 files changed, 400 insertions(+), 113 deletions(-)
