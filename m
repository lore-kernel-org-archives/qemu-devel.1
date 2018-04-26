Received: from eggs.gnu.org ([2001:4830:134:3::10]:54274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBlXZ-0001DM-VY
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fBlXX-0000Mw-J7
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:22:45 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:32977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fBlXX-0000Lt-5O
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 14:22:43 -0400
Received: by mail-lf0-x241.google.com with SMTP id m18-v6so14843008lfb.0
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 11:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <1524699938-6764-1-git-send-email-mjc@sifive.com>
	<CAHNT7NsVNohpxfic=A30oAufaygPWFp1BoT+PUTcgPyhaVif6g@mail.gmail.com>
	<CAHNT7NtRi4qwqpR+SuU-ANXHEAAkp6TitkWFroJ54GsJowTXNg@mail.gmail.com>
In-Reply-To: <CAHNT7NtRi4qwqpR+SuU-ANXHEAAkp6TitkWFroJ54GsJowTXNg@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Apr 2018 18:22:15 +0000
Message-ID: <CAKmqyKMtO5JQ7GnpKU9E_MGeDRGHsb=c0ra0CnGX8vxKtKsunQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 00/35] QEMU 2.13 Privileged ISA
 emulation updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, suhang16@mails.ucas.ac.cn, msuozzo@google.com, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, palmer@sifive.com, Richard Henderson <richard.henderson@linaro.org>, "Emilio G. Cota" <cota@braap.org>, Alistair Francis <Alistair.Francis@wdc.com>, patches@groups.riscv.org

On Wed, Apr 25, 2018 at 7:01 PM Michael Clark <mjc@sifive.com> wrote:

> One last quick note.

> We are tracking RISC-V QEMU issues in the riscv.org repo:

> - https://github.com/riscv/riscv-qemu/issues

> We have tagged issues that are resolved in the 'qemu-2.13-for-upstream'
> branch (this branch can be rebased if we re-spin)

> - https://github.com/riscv/riscv-qemu/tree/qemu-2.13-for-upstream

> And we can now maintain a stable backport branch based on a major QEMU
> release (where we plan to avoid rebasing)

> - https://github.com/riscv/riscv-qemu/tree/riscv-qemu-2.12

> We can make a PR for the first 9 patches as they are already reviewed,
> however, the with this series is to gather review for the new baseline we
> have in the riscv repo.

I think it is worth sending a PR for the first 9 patches. The current
master doesn't boot the sifive_u board and those patches will fix that.
That also helps create a smaller patch series which is easier to review.

Alistair


> Note: the only conflicts in the current series we are likely to have are
> Emilio's changes to translate.c, and I'm happy if those changes go in
first
> and we can rebase against them. The changes in the riscv repo are
currently
> all restricted to target/riscv and hw/riscv so there is little risk of
> disruption to QEMU outside of the RISC-V ecosystem.

> We haven't gone and implemented anything like generic bswap functions
> generated using TCG, if TCG_TARGET_HAS_bswapnn_imm is not implemented by
> the target, or TCG generated setcond2 and brcond2 so that large guest
> support on 32-bit is transparent for targets that don't override the
> defaults, so no worries about regressing the core. Yet... :-D

> Michael.

> On Thu, Apr 26, 2018 at 1:42 PM, Michael Clark <mjc@sifive.com> wrote:

> > Hi All,
> >
> > As a first-time QEMU contributor, it was quite a challenge to get an
> > entire port accepted upstream into QEMU. As folk who have followed the
> > progress of the port will know; at moments my nerves got the better of
me
> > as we approached soft-freeze. In any case, I'd like to thank everyone
who
> > helped out with feedback and reviews.
> >
> > We now have quite a bit of RISC-V specific code targetting QEMU 2.13 and
> > are starting to plan development for QEMU 2.14. And when I say RISC-V, I
> > mean it, as this series focuses on spec conformance. We would like to
be to
> > get a little more SiFive code in QEMU 2.14 including a better model of
HiFive1
> > and HiFive Unleashed with the addition of more SiFive devices.
> >
> > Here are some of the future plans that we would like help with:
> >
> > - Add Cadence Ethernet to SiFive U for which there is already an
emulation
> > in QEMU.
> >  - This requires a device-tree dump from the HiFive Unleashed board
> > - Improve emulation accuracy of the SiFiveUART,
> >   - Need to add fifos and full RX/TX watemark interrupt support
> >   - Good documentation exists in the FE310G000 manual.
> >   - https://www.sifive.com/documentation/chips/freedom-e310-g000-manual/
> > - Implement GPIOs e.g. SiFiveGPIO
> >   - Good documentation for the SiFive GPIO exists in the FE310 manual
> >   - We would like to be able to playback VCD files (timestamp, pin) for
> > GPIO inputs
> >   - Potentially more advanced features where inputs are time synced or
> > state based on GPIO outputs
> >   - The intended application is interrupt controller and interrupt
service
> > routine test cases.
> > - Implement Watchdog e.g. SiFiveWatchdog
> >   - Good documentation for the SiFive Watchdog exists in the FE310
manual
> > - Add an option for Xilinx PCI to the sifive_u board (Freedom Unleashed
> > can by run on FPGA using Xilinx PCI)
> >   - The RTL for the Freedom on VC707 is here: https://github.com/
> > sifive/freedom/
> > - Change virt board to use the generic Linux based GPIO reset of
> > power-off device-tree nodes
> > - Add GPEX PCI host to the virt board so that we can use VirtIO PCI
> > - Improve the SOC object model for the RISC-V boards, with consideration
> > of the RISC-V ecosystem in general
> >   - We are trying to make the core generic so that any vendor can
> > implement custom CSRs
> >   - The SiFive E and SiFive U are generic boards that are intended to
> > emulate SiFive Core IP so should be configurable
> >   - We could add HiFive1 and HiFiveUnleashed boards but at the moment
> > SiFive E and SiFive U are binary compatible
> >   - i.e. this would ideally be implemented as subclassing a generic
> > heterogenous RISC-V Core Complex
> > - Add support for dynamic misa register changes and more spec
conformance
> > details
> >   - Requires a clean way to 'predicate' illegal instructions based on
> > presence of ISA extensions in translate.c
> >   - i.e. we don't what to add a who lot of if (!riscv_has_feature(ctx,
> > RVF)) ... raise exception
> >   - A metadata approach might be better so it can be handled
generically.
> > Need to study decode tree.
> > - Implement a prototype of the RISC-V Hypervisor specification as
outlined
> > in Privileged ISA v1.11
> > - Get our growing manual testing scenarios documented and then automated
> > to add to CI
> > - Lots more... this is just what comes to mind...
> >
> > Assuming the same development timeframe for QEMU 2.13, I guess we have
4-6
> > weeks to get our pending patches reviewed.
> >
> > As for the future plans, I guess given the time it takes for reviews
that
> > we would most likely target future development towards QEMU 2.14...
> > master and the riscv.org trees are now somewhat different so if other
> > major development is done in-tree then we'll need to port this to the
new
> > baseline in the riscv.org tree.
> >
> > If you are on the 'cc you've indicated interest in helping out with the
> > RISC-V or I'm thanking you on behalf of everyone involved in RISC-V and
> > QEMU with respect to past help with the port.
> >
> > I hope that we can conduct more development upstream and I encourage
folk
> > to review the code in this patch series.... time permitting. We have 4-6
> > weeks based on my experience with the last cycle.
> >
> > FYI - I wrote a little about getting the RISC-V QEMU port upstream:
> >
> > - https://www.sifive.com/blog/2018/04/25/risc-v-qemu-part-2-
> > the-risc-v-qemu-port-is-upstream/
> >
> > Thanks and Regards,
> > Michael
> >
> > On Thu, Apr 26, 2018 at 11:45 AM, Michael Clark <mjc@sifive.com> wrote:
> >
> >> This is a series of bug fixes, specification conformance
> >> fixes and CPU feature modularily updates to allow more
> >> precise modelling of the SiFive U Series CPUs (multi-core
> >> application processors with MMU, Supervisor and User modes)
> >> and SiFive E Series CPUs (embedded microcontroller cores
> >> without MMU or Supervisor mode). This series focuses on
> >> correct modelling of Privileged ISA v1.10. Earlier versions
> >> of the code had many unimplemented warnings in the control
> >> and status register code. The version submitted upstream
> >> replaced calls to exit with illegal instruction traps. The
> >> changes in this series focus on implementing correct
> >> behaviour, which in some cases is to ignore writes instead
> >> of trapping, and in other cases traps are generated based
> >> on the presence of CPU features or register settings such
> >> as misa.S and mstatus.TSR/TW/TVM. Several other bugs in
> >> the RISC-V QEMU issue tracker are addresssed.
> >>
> >> The branch for this patch series can be found here:
> >>
> >> - https://github.com/riscv/riscv-qemu/commits/qemu-2.13-for-upstream
> >>
> >> The RISC-V QEMU issues that are not yet resolved upstream:
> >>
> >> - https://github.com/riscv/riscv-qemu/issues
> >>
> >> Summary of changes
> >>
> >> * Implemented TSR, TW and TVM for privileged ISA v1.10
> >> * Update floating-point to correctly mark mstatus.FS dirty.
> >> * Implements WARL behavior for CSRs that don't support writes
> >>   * Past behavior of raising traps was non-conformant
> >>     with the RISC-V Privileged ISA Specition v1.10.
> >> * Sets mtval/stval to zero on exceptions without addresses
> >>   * Past behavior of leaving the last value was non-conformant
> >>     with the RISC-V Privileged ISA Specition v1.10. mtval/stval
> >>     must be set on all exceptions; to zero if not supported.
> >> * Made PMP (Physical Memory Protection) an optional CPU feature.
> >> * Disabled access to s* CSRs on cores without misa.S set.
> >> * Added CSR feature predicates to improve CPU emulation support
> >>   and to allow for easier CPU model differentiation.
> >>   * SiFive U series application processors (MMU, S-mode, U-mode)
> >>   * SiFive E series embedded microcontrollers (no MMU, U-mode)
> >> * Add non-trapping interface to CSRs so that gdbstub.c can
> >>   accesses CSRs without longjmp being called.
> >> * Implements an interface for atomic CSR accesses and convert
> >>   accesses to 'mip' and 'sip' to the atomic interface:
> >>   * The previous implementation using separate methods for
> >>     csr_read_helper and csr_write_helper was incompatible
> >>     with atomic CSR accesses. The previous implementation
> >>     used monolithic switch statements and was not modular.
> >>   * Add public API so that CPUs can implement custom CSRs.
> >> * Replaces locks with atomic lock-free updates for interrupt
> >>   * Reduce idle Linux SMP CPU usage by up to 35%.
> >>   * Increases CPU performance under load by up to 15%.
> >> * Honour privileged ISA v1.10 counter enable CSRs.
> >> * Improved specification conformance of the page table walker
> >>   * Change access checks from ternary operator to if statements.
> >>   * Checks for misaligned PPNs.
> >>   * Disallow M-mode or S-mode from fetching from User pages.
> >>   * Adds reserved PTE flag check: W or W|X.
> >>   * Set READ flag for PTE X flag if mstatus.mxr is in effect.
> >>   * Improves page walker comments and code readability .
> >> * Make ROMs read-only and implement device-tree size checks
> >>   * Uses memory_region_init_rom and rom_add_blob_fixed_as
> >> * Adds hexidecimal instruction bytes to disassembly output.
> >> * Several code cleanups
> >>   * Replacing hard-coded constants with enums
> >>   * Dead-code elimination
> >>
> >> Testing Coverage
> >>
> >> * Linux Fedora SMP mstatus.FS scheduler test: pass
> >> * Linux Fedora SMP MTTCG tests (~22 hr GCC bootstrap): pass
> >> * spike_v1.9.1 bbl/linux-4.6.2 board test: pass
> >> * spike_v1.10 bbl/linux-4.14 board test: pass
> >> * virt bbl/linux-4.16-rc2 board test: pass
> >> * sifive_e board test (HiFive1 binaries): pass
> >> * sifive_u board test (HiFive Unleashed): pending
> >> * riscv-tests: pass
> >> * checkpatch: pass
> >>
> >> Changelog
> >>
> >> v8
> >>
> >> * Use riscv prefix consistently on all cpu helpers
> >> * Add hartid and \n to qemu_log in interrupt logging
> >> * Add missing return statement in gdbstub.c
> >> * Implemented TSR, TW and TVM for privileged ISA v1.10
> >> * Merged Richard Henderson's mstatus.fs dirty fix
> >> * Dropped mstatus.FS workaround
> >> * Implemented traps for s* CSR access on CPUs without S mode
> >> * Implemented traps for pmp* CSR access for CPUs without PMP
> >> * Made local interrupt delivery use atomic updates
> >> * Implemented modular CSR interface supporting atomic accesses
> >> * Implemented privileged ISA v1.10 counter enable CSRs
> >> * Fixed mask for sstatus.mxr field when priv ISA <= v1.9.1
> >> * Fixed User/Supervisor access bug in page table walker refactor
> >> * Updated physical address bits to match the priv ISA specification
> >> * Use memory_region_init_rom and rom_add_blob_fixed_as for mask roms
> >>
> >> v7
> >>
> >> * Fix typo in mstatus.FS workaround comment
> >> * Remove privilege mode from mstatus.mxr page protection check
> >> * Shift class initialization boilerplate patch hunk to correct patch
> >> * Fix typo in include instruction hex in disassembly commit message
> >>
> >> v6
> >>
> >> * Added workaround for critical mstatus.FS MTTCG bug
> >> * Added fix for incorrect disassembly of addiw
> >>
> >> v5
> >>
> >> * Dropped fix for memory allocation bug in riscv_isa_string
> >> * Dropped Hold rcu_read_lock when accessing memory
> >>
> >> v4
> >>
> >> * Added fix for memory allocation bug in riscv_isa_string
> >> * Trivial fix to remove erroneous comment from translate.c
> >>
> >> v3
> >>
> >> * Refactor rcu_read_lock in PTE update to use single unlock
> >> * Make mstatus.mxr take effect regardless of privilege mode
> >> * Remove unnecessary class init from riscv_hart
> >> * Set mtval/stval to zero on exceptions without addresses
> >>
> >> v2
> >>
> >> * Remove unused class boilerplate retains qom parent_obj
> >> * Convert cpu definition towards future model
> >> * Honor mstatus.mxr flag in page table walker
> >>
> >> v1
> >>
> >> * Initial post merge cleanup patch series
> >>
> >> Michael Clark (33):
> >>   RISC-V: Replace hardcoded constants with enum values
> >>   RISC-V: Make virt board description match spike
> >>   RISC-V: Use ROM base address and size from memmap
> >>   RISC-V: Remove identity_translate from load_elf
> >>   RISC-V: Remove unused class definitions
> >>   RISC-V: Include instruction hex in disassembly
> >>   RISC-V: Make some header guards more specific
> >>   RISC-V: Make virt header comment title consistent
> >>   RISC-V: Remove EM_RISCV ELF_MACHINE indirection
> >>   RISC-V: Remove erroneous comment from translate.c
> >>   RISC-V: Mark ROM read-only after copying in code
> >>   RISC-V: Update address bits to support sv39 and sv48
> >>   RISC-V: Improve page table walker spec compliance
> >>   RISC-V: Update E order and I extension order
> >>   RISC-V: Hardwire satp to 0 for no-mmu case
> >>   RISC-V: Make mtvec/stvec ignore vectored traps
> >>   RISC-V: No traps on writes to misa,minstret,mcycle
> >>   RISC-V: Clear mtval/stval on exceptions without info
> >>   RISC-V: Allow S-mode mxr access when priv ISA >= v1.10
> >>   RISC-V: Use [ms]counteren CSRs when priv ISA >= v1.10
> >>   RISC-V: Add mcycle/minstret support for -icount auto
> >>   RISC-V: Use atomic_cmpxchg to update PLIC bitmaps
> >>   RISC-V: Simplify riscv_cpu_local_irqs_pending
> >>   RISC-V: Allow setting and clearing multiple irqs
> >>   RISC-V: Move non-ops from op_helper to cpu_helper
> >>   RISC-V: Update CSR and interrupt definitions
> >>   RISC-V: Implement modular CSR helper interface
> >>   RISC-V: Implement atomic mip/sip CSR updates
> >>   RISC-V: Implement existential predicates for CSRs
> >>   RISC-V: Implement mstatus.TSR/TW/TVM
> >>   RISC-V: Add public API for the CSR dispatch table
> >>   RISC-V: Add hartid and \n to interrupt logging
> >>   RISC-V: Use riscv prefix consistently on cpu helpers
> >>
> >> Richard Henderson (2):
> >>   RISC-V: Split out mstatus_fs from tb_flags
> >>   RISC-V: Mark mstatus.fs dirty
> >>
> >>  disas/riscv.c                           |  39 +-
> >>  hw/riscv/riscv_hart.c                   |   6 -
> >>  hw/riscv/sifive_clint.c                 |  17 +-
> >>  hw/riscv/sifive_e.c                     |  54 +-
> >>  hw/riscv/sifive_plic.c                  |  40 +-
> >>  hw/riscv/sifive_u.c                     |  86 ++--
> >>  hw/riscv/spike.c                        |  99 ++--
> >>  hw/riscv/virt.c                         |  80 +--
> >>  include/hw/riscv/sifive_clint.h         |   4 +
> >>  include/hw/riscv/sifive_e.h             |   5 -
> >>  include/hw/riscv/sifive_plic.h          |   1 -
> >>  include/hw/riscv/sifive_u.h             |   9 +-
> >>  include/hw/riscv/spike.h                |  15 +-
> >>  include/hw/riscv/virt.h                 |  13 +-
> >>  linux-user/signal.c                     |   4 +-
> >>  target/riscv/Makefile.objs              |   2 +-
> >>  target/riscv/cpu.c                      |   8 +-
> >>  target/riscv/cpu.h                      |  84 +--
> >>  target/riscv/cpu_bits.h                 | 690
+++++++++++++------------
> >>  target/riscv/{helper.c => cpu_helper.c} | 173 ++++---
> >>  target/riscv/csr.c                      | 871
> >> ++++++++++++++++++++++++++++++++
> >>  target/riscv/fpu_helper.c               |   6 +-
> >>  target/riscv/gdbstub.c                  |  10 +-
> >>  target/riscv/op_helper.c                | 613 ++--------------------
> >>  target/riscv/translate.c                |  53 +-
> >>  25 files changed, 1700 insertions(+), 1282 deletions(-)
> >>  rename target/riscv/{helper.c => cpu_helper.c} (73%)
> >>  create mode 100644 target/riscv/csr.c
> >>
> >> --
> >> 2.7.0
> >>
> >>
> >
