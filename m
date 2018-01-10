Received: from eggs.gnu.org ([2001:4830:134:3::10]:44660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ77-0006CD-A7
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1eZQ73-0000Iw-8n
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:57 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:45135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1eZQ72-0000IP-Mc
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 18:48:52 -0500
Received: by mail-pg0-x241.google.com with SMTP id c194so1087469pga.12
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 15:48:52 -0800 (PST)
From: Michael Clark <mjc@sifive.com>
Date: Wed, 10 Jan 2018 15:46:19 -0800
Message-Id: <1515628000-93285-1-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/21] RISC-V QEMU Port Submission v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches+subscribe@groups.riscv.org>

QEMU RISC-V Emulation Support (RV64GC, RV32GC)

This patch series has major clean ups to target/riscv. There may be
some feedback that has been missed however the changelog is growing
quite large so we have decided to respin the patch series. No new
features have been added however a number of bugs have been fixed.

The git tree for this v2 patch series (squashed and rebased):

- https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v2

The git tree for the v1 patch series with full review commit history:

- https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v1

We're adding Palmer Dabbelt as a maintainer so that we have at least
two full-time RISC-V developers available to work on the port.

*** Known Issues ***

- Disassembler has some checkpatch warnings for the sake of code brevity
- scripts/qemu-binfmt-conf.sh has checkpatch warnings due to line length
- PMP (Physical Memory Protection) is as-of-yet unused and needs testing

*** Changelog ***

v2

- Remove redundant NULL terminators from disassembler register arrays
- Change disassembler register name arrays to const
- Refine disassembler internal function names
- Update dates in disassembler copyright message
- Remove #ifdef CONFIG_USER_ONLY version of cpu_has_work
- Use ULL suffix on 64-bit constants
- Move riscv_cpu_mmu_index from cpu.h to helper.c
- Move riscv_cpu_hw_interrupts_pending from cpu.h to helper.c
- Remove redundant TARGET_HAS_ICE from cpu.h
- Use qemu_irq instead of void* for irq definition in cpu.h
- Remove duplicate typedef from struct CPURISCVState
- Remove redundant g_strdup from cpu_register
- Remove redundant tlb_flush from riscv_cpu_reset
- Remove redundant mode calculation from get_physical_address
- Remove redundant debug mode printf and dcsr comment
- Remove redundant clearing of MSB for bare physical addresses
- Use g_assert_not_reached for invalid mode in get_physical_address
- Use g_assert_not_reached for unreachable checks in get_physical_address
- Use g_assert_not_reached for unreachable type in raise_mmu_exception
- Return exception instead of aborting for misaligned fetches
- Move exception defines from cpu.h to cpu_bits.h
- Remove redundant breakpoint control definitions from cpu_bits.h
- Implement riscv_cpu_unassigned_access exception handling
- Log and raise exceptions for unimplemented CSRs
- Match Spike HTIF exit behavior - don’t print TEST-PASSED
- Make frm,fflags,fcsr writes trap when mstatus.FS is clear
- Use g_assert_not_reached for unreachable invalid mode
- Make hret,uret,dret generate illegal instructions
- Move riscv_cpu_dump_state and int/fpr regnames to cpu.c
- Lift interrupt flag and mask into constants in cpu_bits.h
- Change trap debugging to use qemu_log_mask LOG_TRACE 
- Change CSR debugging to use qemu_log_mask LOG_TRACE
- Change PMP debugging to use qemu_log_mask LOG_TRACE
- Remove commented code from pmp.c
- Change CpuInfoRISCV qapi schema docs to Since 2.12
- Change RV feature macro to use target_ulong cast
- Remove riscv_feature and instead use misa extension flags
- Make riscv_flush_icache_syscall a no-op
- Undo checkpatch whitespace fixes in unrelated linux-user code
- Remove redudant constants and tidy up cpu_bits.h
- Make helper_fence_i a no-op
- Move include "exec/cpu-all" to end of cpu.h
- Rename set_privilege to riscv_set_mode
- Move redundant forward declaration for cpu_riscv_translate_address
- Remove TCGV_UNUSED from riscv_translate_init
- Add comment to pmp.c stating the code is untested and currently unused
- Use ctz to simplify decoding of PMP NAPOT address ranges
- Change pmp_is_in_range to use than equal for end addresses
- Fix off by one error in pmp_update_rule
- Rearrange PMP_DEBUG so that formatting is compile-time checked
- Rearrange trap debugging so that formatting is compile-time checked
- Rearrange PLIC debugging so that formatting is compile-time checked
- Use qemu_log/qemu_log_mask for HTIF logging and debugging
- Move exception and interrupt names into cpu.c
- Add Palmer Dabbelt as a RISC-V Maintainer
- Rebase against current qemu master branch

v1

- initial version based on forward port from riscv-qemu repository

*** Background ***

"RISC-V is an open, free ISA enabling a new era of processor innovation
through open standard collaboration. Born in academia and research,
RISC-V ISA delivers a new level of free, extensible software and
hardware freedom on architecture, paving the way for the next 50 years
of computing design and innovation."

The QEMU RISC-V port has been developed and maintained out-of-tree for
several years by Sagar Karandikar and Bastian Koppelmann. The RISC-V
Privileged specification has evolved substantially over this period but
has recently been solidifying. The RISC-V Base ISA has been frozon for
some time and the Privileged ISA, GCC toolchain and Linux ABI are now
quite stable. I have recently joined Sagar and Bastian as a RISC-V QEMU
Maintainer and hope to support upstreaming the port. 

There are multiple vendors taping out, preparing to ship, or shipping
silicon that implements the RISC-V Privileged ISA Version 1.10. There
are also several RISC-V Soft-IP cores implementing Privileged ISA
Version 1.10 that run on FPGA such as SiFive's Freedom U500 Platform
and the U54‑MC RISC-V Core IP, among many more implementations from a
variety of vendors. See https://riscv.org/ for more details.

RISC-V support was upstreamed in binutils 2.28 and GCC 7.1 in the first
half of 2016. RISC-V support is now available in LLVM top-of-tree and
the RISC-V Linux port was accepted into Linux 4.15-rc1 late last year
and will be available in the upcoming Linux 4.15 release. RISC-V GLIBC
patches are currently under review and it is hoped that RISC-V support
will be added in the GLIBC 2.27 release.  We believe it is timely to
submit the RISC-V QEMU port for upstream review with the goal of
incorporating RISC-V support into the upcoming QEMU 2.12 release.

The RISC-V QEMU port is still under active development, mostly with
respect to device emulation, the addition of Hypervisor support as
specified in the RISC-V Draft Privileged ISA Version 1.11, and Vector
support once the first draft is finalized later this year. We believe
now is the appropriate time for RISC-V QEMU development to be carried
out in the main QEMU repository as the code will benefit from more
rigorous review. The RISC-V QEMU port currently supports all the ISA
extensions that have been finalized and frozen in the Base ISA.

Blog post about recent additions to RISC-V QEMU: https://goo.gl/fJ4zgk

The RISC-V QEMU wiki: https://github.com/riscv/riscv-qemu/wiki

Instructions for building a busybox+dropbear root image, BBL (Berkeley
Boot Loader) and linux kernel image for use with the RISC-V QEMU
'virt' machine: https://github.com/michaeljclark/busybear-linux

*** Overview ***

The RISC-V QEMU port implements the following specifications:

- RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
- RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
- RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10

The RISC-V QEMU port supports the following instruction set extensions:

- RV32GC with Supervisor-mode and User-mode (RV32IMAFDCSU)
- RV64GC with Supervisor-mode and User-mode (RV64IMAFDCSU)

The RISC-V QEMU port adds the following targets to QEMU:

- riscv32-softmmu
- riscv64-softmmu
- riscv32-linux-user
- riscv64-linux-user

The RISC-V QEMU port supports the following hardware:

- HTIF Console (Host Target Interface)
- SiFive CLINT (Core Local Interruptor) for Timer interrupts and IPIs
- SiFive PLIC (Platform Level Interrupt Controller)
- SiFive UART, PRCI, AON, PWM, QSPI support is partially implemented
- VirtIO MMIO (GPEX PCI support will be added in a future patch)
- Generic 16550A UART emulation using 'hw/char/serial.c'
- Experimental SMP support (PLIC and CLINT) on the 'virt' machine

The RISC-V QEMU full system emulator supports 5 machines:

- 'spike_v1.9';  CLINT, PLIC, HTIF console, config-string, Priv v1.9.1
- 'spike_v1.10'; CLINT, PLIC, HTIF console, device-tree, Priv v1.10
- 'virt'; CLINT, PLIC, 16550A UART, VirtIO, device-tree, Priv v1.10
- 'sifive_e300'; CLINT, PLIC, SiFive UART, HiFive1 compat, Priv v1.10
- 'sifive_u500'; CLINT, PLIC, SiFive UART, device-tree, Priv v1.10

This is a list of RISC-V QEMU Port Contributors:

- Alex Suykov
- Antony Pavlov
- Bastian Koppelmann
- Bruce Hoult
- Chih-Min Chao
- Daire McNamara
- David Abdurachmanov
- Ivan Griffin
- Kito Cheng
- Michael Clark
- Palmer Dabbelt
- Sagar Karandikar
- Stefan O'Rear

Notes:

- contributor email addresses available off-list on request.
- checkpatch has been run on all 21 patches.
- checkpatch exceptions are noted in 2 patches that have errors.
- tested linux on 'spike_v1.9', 'spike_v1.10' and 'virt' machines
- passes "make check" on full build for all targets

This patch series includes the following patches:

Michael Clark (21):
  RISC-V Maintainers
  RISC-V ELF Machine Definition
  RISC-V CPU Core Definition
  RISC-V Disassembler
  RISC-V CPU Helpers
  RISC-V FPU Support
  RISC-V GDB Stub
  RISC-V TCG Code Generation
  RISC-V Physical Memory Protection
  RISC-V Linux User Emulation
  RISC-V HTIF Console
  RISC-V HART Array
  SiFive RISC-V CLINT Block
  SiFive RISC-V PLIC Block
  RISC-V Spike Machines
  RISC-V VirtIO Machine
  SiFive RISC-V UART Device
  SiFive RISC-V PRCI Block
  SiFive Freedom E300 RISC-V Machine
  SiFive Freedom U500 RISC-V Machine
  RISC-V Build Infrastructure

 MAINTAINERS                            |   11 +
 Makefile.objs                          |    1 +
 arch_init.c                            |    2 +
 configure                              |   11 +
 cpus.c                                 |    6 +
 default-configs/riscv32-linux-user.mak |    1 +
 default-configs/riscv32-softmmu.mak    |    4 +
 default-configs/riscv64-linux-user.mak |    1 +
 default-configs/riscv64-softmmu.mak    |    4 +
 disas.c                                |    2 +
 disas/Makefile.objs                    |    1 +
 disas/riscv.c                          | 3005 ++++++++++++++++++++++++++++++++
 fpu/softfloat-specialize.h             |    7 +-
 hw/riscv/Makefile.objs                 |   12 +
 hw/riscv/riscv_elf.c                   |  244 +++
 hw/riscv/riscv_hart.c                  |   95 +
 hw/riscv/riscv_htif.c                  |  373 ++++
 hw/riscv/sifive_clint.c                |  312 ++++
 hw/riscv/sifive_e300.c                 |  232 +++
 hw/riscv/sifive_plic.c                 |  554 ++++++
 hw/riscv/sifive_prci.c                 |  107 ++
 hw/riscv/sifive_u500.c                 |  338 ++++
 hw/riscv/sifive_uart.c                 |  182 ++
 hw/riscv/spike_v1_09.c                 |  207 +++
 hw/riscv/spike_v1_10.c                 |  281 +++
 hw/riscv/virt.c                        |  364 ++++
 include/disas/bfd.h                    |    2 +
 include/elf.h                          |    2 +
 include/hw/riscv/riscv_elf.h           |   69 +
 include/hw/riscv/riscv_hart.h          |   45 +
 include/hw/riscv/riscv_htif.h          |   62 +
 include/hw/riscv/sifive_clint.h        |   56 +
 include/hw/riscv/sifive_e300.h         |   79 +
 include/hw/riscv/sifive_plic.h         |   91 +
 include/hw/riscv/sifive_prci.h         |   43 +
 include/hw/riscv/sifive_u500.h         |   69 +
 include/hw/riscv/sifive_uart.h         |   76 +
 include/hw/riscv/spike.h               |   51 +
 include/hw/riscv/virt.h                |   73 +
 include/sysemu/arch_init.h             |    1 +
 linux-user/elfload.c                   |   22 +
 linux-user/main.c                      |  114 ++
 linux-user/riscv/syscall_nr.h          |  275 +++
 linux-user/riscv/target_cpu.h          |   18 +
 linux-user/riscv/target_signal.h       |   23 +
 linux-user/riscv/target_structs.h      |   46 +
 linux-user/riscv/target_syscall.h      |   56 +
 linux-user/riscv/termbits.h            |  220 +++
 linux-user/signal.c                    |  203 ++-
 linux-user/syscall.c                   |    2 +
 linux-user/syscall_defs.h              |   13 +-
 qapi-schema.json                       |   14 +-
 scripts/qemu-binfmt-conf.sh            |   13 +-
 target/riscv/Makefile.objs             |    2 +
 target/riscv/cpu.c                     |  391 +++++
 target/riscv/cpu.h                     |  271 +++
 target/riscv/cpu_bits.h                |  417 +++++
 target/riscv/cpu_user.h                |   26 +
 target/riscv/fpu_helper.c              |  591 +++++++
 target/riscv/gdbstub.c                 |   59 +
 target/riscv/helper.c                  |  499 ++++++
 target/riscv/helper.h                  |   78 +
 target/riscv/instmap.h                 |  377 ++++
 target/riscv/op_helper.c               |  682 ++++++++
 target/riscv/pmp.c                     |  386 ++++
 target/riscv/pmp.h                     |   70 +
 target/riscv/trace-events              |    1 +
 target/riscv/translate.c               | 1982 +++++++++++++++++++++
 target/riscv/user_atomic.c             |  291 ++++
 69 files changed, 14207 insertions(+), 11 deletions(-)
 create mode 100644 default-configs/riscv32-linux-user.mak
 create mode 100644 default-configs/riscv32-softmmu.mak
 create mode 100644 default-configs/riscv64-linux-user.mak
 create mode 100644 default-configs/riscv64-softmmu.mak
 create mode 100644 disas/riscv.c
 create mode 100644 hw/riscv/Makefile.objs
 create mode 100644 hw/riscv/riscv_elf.c
 create mode 100644 hw/riscv/riscv_hart.c
 create mode 100644 hw/riscv/riscv_htif.c
 create mode 100644 hw/riscv/sifive_clint.c
 create mode 100644 hw/riscv/sifive_e300.c
 create mode 100644 hw/riscv/sifive_plic.c
 create mode 100644 hw/riscv/sifive_prci.c
 create mode 100644 hw/riscv/sifive_u500.c
 create mode 100644 hw/riscv/sifive_uart.c
 create mode 100644 hw/riscv/spike_v1_09.c
 create mode 100644 hw/riscv/spike_v1_10.c
 create mode 100644 hw/riscv/virt.c
 create mode 100644 include/hw/riscv/riscv_elf.h
 create mode 100644 include/hw/riscv/riscv_hart.h
 create mode 100644 include/hw/riscv/riscv_htif.h
 create mode 100644 include/hw/riscv/sifive_clint.h
 create mode 100644 include/hw/riscv/sifive_e300.h
 create mode 100644 include/hw/riscv/sifive_plic.h
 create mode 100644 include/hw/riscv/sifive_prci.h
 create mode 100644 include/hw/riscv/sifive_u500.h
 create mode 100644 include/hw/riscv/sifive_uart.h
 create mode 100644 include/hw/riscv/spike.h
 create mode 100644 include/hw/riscv/virt.h
 create mode 100644 linux-user/riscv/syscall_nr.h
 create mode 100644 linux-user/riscv/target_cpu.h
 create mode 100644 linux-user/riscv/target_signal.h
 create mode 100644 linux-user/riscv/target_structs.h
 create mode 100644 linux-user/riscv/target_syscall.h
 create mode 100644 linux-user/riscv/termbits.h
 create mode 100644 target/riscv/Makefile.objs
 create mode 100644 target/riscv/cpu.c
 create mode 100644 target/riscv/cpu.h
 create mode 100644 target/riscv/cpu_bits.h
 create mode 100644 target/riscv/cpu_user.h
 create mode 100644 target/riscv/fpu_helper.c
 create mode 100644 target/riscv/gdbstub.c
 create mode 100644 target/riscv/helper.c
 create mode 100644 target/riscv/helper.h
 create mode 100644 target/riscv/instmap.h
 create mode 100644 target/riscv/op_helper.c
 create mode 100644 target/riscv/pmp.c
 create mode 100644 target/riscv/pmp.h
 create mode 100644 target/riscv/trace-events
 create mode 100644 target/riscv/translate.c
 create mode 100644 target/riscv/user_atomic.c

-- 
2.7.0
