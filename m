Received: from eggs.gnu.org ([209.51.188.92]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0001uH-Bi
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AQ-0000YN-TT
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:34936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AP-0000J7-TG
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id t200so4534296wmt.0
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.12
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:04:48 +0000
Message-Id: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/22] target-arm queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Arm stuff, mostly patches from RTH.

thanks
-- PMM

The following changes since commit 01a9a51ffaf4699827ea6425cb2b834a356e159d:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20190205-pull-request' into staging (2019-02-05 14:01:29 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190205

for you to fetch changes up to a15945d98d3a3390c3da344d1b47218e91e49d8b:

  target/arm: Make FPSCR/FPCR trapped-exception bits RAZ/WI (2019-02-05 16:52:42 +0000)

----------------------------------------------------------------
target-arm queue:
 * Implement Armv8.5-BTI extension for system emulation mode
 * Implement the PR_PAC_RESET_KEYS prctl() for linux-user mode's Armv8.3-PAuth support
 * Support TBI (top-byte-ignore) properly for linux-user mode
 * gdbstub: allow killing QEMU via vKill command
 * hw/arm/boot: Support DTB autoload for firmware-only boots
 * target/arm: Make FPSCR/FPCR trapped-exception bits RAZ/WI

----------------------------------------------------------------
Max Filippov (1):
      gdbstub: allow killing QEMU via vKill command

Peter Maydell (7):
      target/arm: Compute TB_FLAGS for TBI for user-only
      hw/arm/boot: Fix block comment style in arm_load_kernel()
      hw/arm/boot: Factor out "direct kernel boot" code into its own function
      hw/arm/boot: Factor out "set up firmware boot" code
      hw/arm/boot: Clarify why arm_setup_firmware_boot() doesn't set env->boot_info
      hw/arm/boot: Support DTB autoload for firmware-only boots
      target/arm: Make FPSCR/FPCR trapped-exception bits RAZ/WI

Richard Henderson (14):
      target/arm: Introduce isar_feature_aa64_bti
      target/arm: Add PSTATE.BTYPE
      target/arm: Add BT and BTYPE to tb->flags
      exec: Add target-specific tlb bits to MemTxAttrs
      target/arm: Cache the GP bit for a page in MemTxAttrs
      target/arm: Default handling of BTYPE during translation
      target/arm: Reset btype for direct branches
      target/arm: Set btype for indirect branches
      target/arm: Enable BTI for -cpu max
      linux-user: Implement PR_PAC_RESET_KEYS
      tests/tcg/aarch64: Add pauth smoke test
      target/arm: Add TBFLAG_A64_TBID, split out gen_top_byte_ignore
      target/arm: Clean TBI for data operations in the translator
      target/arm: Enable TBI for user-only

 tests/tcg/aarch64/Makefile.target   |   6 +-
 include/exec/memattrs.h             |  10 +
 linux-user/aarch64/target_syscall.h |   7 +
 target/arm/cpu.h                    |  27 +-
 target/arm/internals.h              |  27 +-
 target/arm/translate.h              |  12 +-
 gdbstub.c                           |   4 +
 hw/arm/boot.c                       | 166 +++++++------
 linux-user/syscall.c                |  36 +++
 target/arm/cpu.c                    |   6 +
 target/arm/cpu64.c                  |   4 +
 target/arm/helper.c                 |  80 +++---
 target/arm/translate-a64.c          | 476 +++++++++++++++++++++++++-----------
 tests/tcg/aarch64/pauth-1.c         |  23 ++
 14 files changed, 623 insertions(+), 261 deletions(-)
 create mode 100644 tests/tcg/aarch64/pauth-1.c
