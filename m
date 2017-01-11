Received: from eggs.gnu.org ([2001:4830:134:3::10]:54810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNr-0006Jp-Uh
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1cRPNn-0000u2-Vd
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:35 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1cRPNn-0000tb-Lo
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 15:20:31 -0500
Received: by mail-wm0-x241.google.com with SMTP id c85so573736wmi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:20:31 -0800 (PST)
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Wed, 11 Jan 2017 21:19:31 +0100
Message-Id: <cover.1484165352.git.atar4qemu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/30] target-sparc: add niagara OpenSPARC
 T1 sun4v emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>

This patch series adds a Niagara OpenSPARC T1 sun4v machine.
The most important new feature: it can boot Solaris 10 / sparc64.
The machine uses a firmware released by Sun as a part of the OpenSPARC project.

The series are available under:
https://github.com/artyom-tarasenko/qemu/tree/sun4v-v2

The command line for booting Solaris 10 / sparc:

sparc64-softmmu/qemu-system-sparc64 -M niagara -L /path/to/S10image/ -nographic -m 256 -drive if=pflash,readonly=on,file=/path/to/S10image/disk.s10hw2

More info under
http://tyom.blogspot.de/2016/10/qemu-sun4vniagara-target-went-public.html

v1 -> v2:
Rebased on top of current master
Update Niagara target in qemu-doc.texi

v0 -> v1:
Rebased on top of current master
Use lowercase machine name (Mark)
Fixed build on i686
Fixed user-mode build (Richard)
Fixed per review comments from Richard
Added Reviewed-by to the unmodified patches reviewed in the previous round


Artyom Tarasenko (30):
  target-sparc: ignore MMU-faults if MMU is disabled in hypervisor mode
  target-sparc: store cpu super- and hypervisor flags in TB
  target-sparc: use explicit mmu register pointers
  target-sparc: add UA2005 TTE bit #defines
  target-sparc: add UltraSPARC T1 TLB #defines
  target-sparc: on UA2005 don't deliver Interrupt_level_n IRQs in
    hypervisor mode
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

-- 
1.8.3.1
