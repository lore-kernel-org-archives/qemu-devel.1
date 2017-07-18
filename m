Received: from eggs.gnu.org ([2001:4830:134:3::10]:46802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7F-0003qn-3U
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7B-00059g-Ty
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:37 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:5519)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7B-00058p-Ln
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:33 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:45 +0100
Message-ID: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 0/14] target/mips: Add Enhanced Virtual
 Addressing (EVA) support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <petar.jovanovic@imgtec.com>

This patchset implements MIPS Enhanced Virtual Addressing (EVA) support
in QEMU.

The patches are grouped as follows:

 - Patches 1-3: Preliminary fixes.
   A few fixes are made for issues spotted during development.

 - Patch 4: CP0_EBase.WG (write gate).
   This allows more bits of CP0_EBase to be written, which allows the
   exception vector to be moved into a different segment than
   kseg0/kseg1. The related CP0_Config5.CV allows cache error exceptions
   not to be forced to get handled by KSeg1.

 - Patches 5-8: EVA user memory access instructions (CP0_Config5.EVA).
   These allow kernel code to access the user mode view of memory, which
   can no longer be done reliably with normal memory access instructions
   for MUSUK segment access mode (see below).

 - Patches 9-12: Segmentation control (CP0_Config3.SC).
   New cop0 registers are added to reconfigure the virtual memory
   segments. This allows the traditionally fixed virtual memory segments
   to be rearranged, and also allows segments to appear differently
   based on execution mode, for example the access mode MUSUK (Mapped
   User Supervisor, Unmapped Kernel) makes a segment TLB mapped to user
   mode and cached unmapped (direct window to physical) to kernel mode,
   and if EU=1 it is also uncached unmapped to error level (which
   requires the addition of a new MMU mode).

 - Patch 13: P5600 EVA support.
   We add the required capabilities to the P5600 CPU type to allow a
   Malta EVA kernel to be executed.

 - Patch 14: I6400 & MIPS64R2-generic CP0_Ebase.WG support.
   We add WG bit support to these MIPS64 CPUs so the guest kernel can
   run KVM T&E.

Notable limitations:

 - Neither CACHEE (the new EVA instruction) or CACHE (the pre-existing
   non-EVA instruction) generate TLB exceptions for bad addresses, as
   QEMU implements them only with a Cop0 privilege check.

 - No attempt has been made to implement BEV overlays yet, which would
   allow non-standard boot exception vector addresses to be accessed in
   kernel mode, even if the underlying segment is changed. This should
   be done at some point, but wasn't necessary for my purposes.

 - MIPS64 segmentation control (for XKPhys) is functional, however there
   are still a few corner cases that need resolving:
    - EntryHi writability on r6 (you can't write an XKPhys address).
    - R6 style Status.KX,SX,UX writability (KX=0 => SX=0, and SX=0 =>
      UX=0).
    - R6 style addressing special cases & sign extension.
   so I wouldn't recommend enabling it for any CPUs yet. P6600 is the
   only real core that implements it anyway.

Changes in v2:

 - Rebased on 2.9.0
 - New patches 1-3, with some misc fixes
 - CP0_EBase.WG (patch 4):
    - Fix CP0_EBase.WG to be read only when WG is not set in
      CP0_EBase_rw_bitmask, otherwise it will be wrongly probed as
      present.
    - Make cache error exception vector conditional on Config3.SC as
      well as Config5.CV, as per the PRA, and take the CP0C3_SC
      definition from patch 7 (Yongbok).
    - Rename CP0_EBase_rw_bitmask to CP0_EBaseWG_rw_bitmask (Yongbok).
 - Decode EVA load & stores (patch 6)
    - Fix typo in commit message (Yongbok).
    - Use sextract32 (Yongbok).
 - New patch 7, to decode microMIPS EVA loads & stores (Yongbok).
 - Abstract mmu_idx from hflags (patch 9):
    - Also convert reference to hflags & MIPS_HFLAG_KSU in op_helper.c
      to cpu_mmu_index (Yongbok).
 - Add an MMU mode for ERL (patch 10):
    - Add ERL case to log output where cpu_mmu_index() is now used in
      op_helper.c
 - Add segmentation control registers (Patch 11):
    - Use ld_tl and ext32s_tl rather than ld32s_tl to avoid big endian
      host, MIPS64 target issues (Yongbok).
    - Add missing break in DMFC0 CP0_SegCtl2 case.
 - Implement segmentation control (Patch 12):
    - Use hwaddr instead of target_ulong for physical addresses in
      get_seg[ctl]_physical_address() (Yongbok).
    - Fix xkphys privilege control based on access mode (am) (Yongbok).
    - Fix xkphys TLB faults to use XTLB.
 - New patch 14.

Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>

James Hogan (14):
  target/mips: Fix MIPS64 MFC0 UserLocal on BE host
  target/mips: Fix TLBWI shadow flush for EHINV,XI,RI
  target/mips: Weaken TLB flush on UX,SX,KX,ASID changes
  target/mips: Add CP0_Ebase.WG (write gate) support
  target/mips: Prepare loads/stores for EVA
  target/mips: Decode MIPS32 EVA load & store instructions
  target/mips: Decode microMIPS EVA load & store instructions
  target/mips: Check memory permissions with mem_idx
  target/mips: Abstract mmu_idx from hflags
  target/mips: Add an MMU mode for ERL
  target/mips: Add segmentation control registers
  target/mips: Implement segmentation control
  target/mips: Add EVA support to P5600
  target/mips: Enable CP0_EBase.WG on MIPS64 CPUs

 target/mips/cpu.h            |  58 ++++-
 target/mips/helper.c         | 210 ++++++++++++++-----
 target/mips/helper.h         |   3 +-
 target/mips/machine.c        |   9 +-
 target/mips/op_helper.c      |  58 ++++-
 target/mips/translate.c      | 405 ++++++++++++++++++++++++++++++++----
 target/mips/translate_init.c |  17 +-
 7 files changed, 644 insertions(+), 116 deletions(-)

-- 
git-series 0.8.10
