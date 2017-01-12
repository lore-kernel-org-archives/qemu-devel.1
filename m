Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYj-0007fo-Av
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRVYi-0006gx-8Y
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:13 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cRVYi-0006gj-2b
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 21:56:12 -0500
Received: by mail-qk0-x242.google.com with SMTP id 11so959989qkl.0
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 18:56:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 11 Jan 2017 18:55:36 -0800
Message-Id: <20170112025606.27332-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/30] target-sparc sun4v support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com, mark.cave-ayland@ilande.co.uk, peter.maydell@linaro.org

Mark Cave-Ayland asked me to handle the merge of this patch set
while he is traveling.

This is the v2 that Artyom posted today.  I had reviewed the majority
of v1 earlier.  I re-read through the rebase and saw nothing amiss.
It passes my tests for sparc32, and does run the OpenSolaris image
to which Artyom links.


r~


The following changes since commit 41a0e54756a9ae6b60be34bb33302a7e085fdb07:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-01-10 10:46:21 +0000)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-sparc-20170111

for you to fetch changes up to 224be7cc93a37ccd38342811a8925de889de1a49:

  target-sparc: fix up niagara machine (2017-01-11 12:23:58 -0800)

----------------------------------------------------------------
Sun4v support

----------------------------------------------------------------
Artyom Tarasenko (30):
      target-sparc: ignore MMU-faults if MMU is disabled in hypervisor mode
      target-sparc: store cpu super- and hypervisor flags in TB
      target-sparc: use explicit mmu register pointers
      target-sparc: add UA2005 TTE bit #defines
      target-sparc: add UltraSPARC T1 TLB #defines
      target-sparc: on UA2005 don't deliver Interrupt_level_n IRQs in hypervisor mode
      target-sparc: simplify replace_tlb_entry by using TTE_PGSIZE
      target-sparc: implement UA2005 scratchpad registers
      target-sparc: implement UltraSPARC-T1 Strand status ASR
      target-sparc: hypervisor mode takes over nucleus mode
      target-sparc: implement UA2005 hypervisor traps
      target-sparc: implement UA2005 GL register
      target-sparc: implement UA2005 rdhpstate and wrhpstate instructions
      target-sparc: fix immediate UA2005 traps
      target-sparc: use direct address translation in hyperprivileged mode
      target-sparc: allow priveleged ASIs in hyperprivileged mode
      target-sparc: ignore writes to UA2005 CPU mondo queue register
      target-sparc: replace the last tlb entry when no free entries left
      target-sparc: use SparcV9MMU type for sparc64 I/D-MMUs
      target-sparc: implement UA2005 TSB Pointers
      target-sparc: simplify ultrasparc_tsb_pointer
      target-sparc: allow 256M sized pages
      target-sparc: implement auto-demapping for UA2005 CPUs
      target-sparc: add more registers to dump_mmu
      target-sparc: implement UA2005 ASI_MMU (0x21)
      target-sparc: store the UA2005 entries in sun4u format
      target-sparc: add ST_BLKINIT_ ASIs for UA2005+ CPUs
      target-sparc: implement sun4v RTC
      target-sparc: move common cpu initialisation routines to sparc64.c
      target-sparc: fix up niagara machine

 MAINTAINERS                         |   7 +
 default-configs/sparc64-softmmu.mak |   2 +
 hw/sparc64/Makefile.objs            |   2 +
 hw/sparc64/niagara.c                | 177 +++++++++++++++++
 hw/sparc64/sparc64.c                | 378 +++++++++++++++++++++++++++++++++++
 hw/sparc64/sun4u.c                  | 379 +----------------------------------
 hw/timer/Makefile.objs              |   2 +
 hw/timer/sun4v-rtc.c                | 102 ++++++++++
 include/hw/sparc/sparc64.h          |   5 +
 include/hw/timer/sun4v-rtc.h        |   1 +
 linux-user/main.c                   |   2 +-
 qemu-doc.texi                       |  14 +-
 target/sparc/asi.h                  |   1 +
 target/sparc/cpu.c                  |  13 +-
 target/sparc/cpu.h                  | 105 +++++++---
 target/sparc/helper.h               |   1 +
 target/sparc/int64_helper.c         |  43 +++-
 target/sparc/ldst_helper.c          | 385 ++++++++++++++++++++++++++++--------
 target/sparc/machine.c              |   4 +-
 target/sparc/mmu_helper.c           |  20 +-
 target/sparc/translate.c            |  64 ++++--
 target/sparc/win_helper.c           |  46 ++++-
 22 files changed, 1225 insertions(+), 528 deletions(-)
 create mode 100644 hw/sparc64/niagara.c
 create mode 100644 hw/sparc64/sparc64.c
 create mode 100644 hw/timer/sun4v-rtc.c
 create mode 100644 include/hw/sparc/sparc64.h
 create mode 100644 include/hw/timer/sun4v-rtc.h
