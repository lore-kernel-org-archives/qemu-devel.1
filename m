Received: from eggs.gnu.org ([2001:4830:134:3::10]:37595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejbQk-0007iq-43
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:55:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1ejbQf-00060j-DI
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:55:18 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:46639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1ejbQf-00060N-28
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 20:55:13 -0500
Received: by mail-ot0-x22a.google.com with SMTP id f56so2731827otj.13
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 17:55:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518053328-34687-1-git-send-email-mjc@sifive.com>
References: <1518053328-34687-1-git-send-email-mjc@sifive.com>
From: Michael Clark <mjc@sifive.com>
Date: Thu, 8 Feb 2018 14:55:11 +1300
Message-ID: <CAHNT7Ntr2iEb2g_ZK_T6VfG3WNkjm4LR7+zYi2wiCTjJcaw14g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/23] RISC-V QEMU Port Submission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, RISC-V Patches <patches@groups.riscv.org>

We are now passing all but one of the set of tests cases in riscv-tests.
The one failing set of tests relates to support for "9.2 NaN Boxing of
Narrower Values" as per the RISC-V ISA Specification v2.2. The remaining
case is where we try to use a single-precision operation on an input that
doesn't have bits 63:32 all 1s, the input is treated as if it were a quiet
NaN, rather than as the embedded single, as using a wider value (i.e.
double) as an input to a single precision operation is defined to be NaN.
The NaN Boxing of Narrower Values was added to the specification to specify
the binary format for single precision values in memory
when fsd/fld (load/store double fp value) is used to save/restore them.
Indeed, the mechanism is generic and is designed to also handle boxing of
singles and doubles within quad precision floating point values. The
implication of supporting NaN Boxing completely (i.e. 100% test passing)
will require tests for canonical NaN-boxing in all single precision
floating point operations, and it may be worthwhile having a switch for
compliance vs performance?

QEMU=3D./riscv64-softmmu/qemu-system-riscv64
ALL_TESTS=3D$(find ../riscv-tools/riscv-tests/build/isa -name 'rv64*-v-*' -=
a
! -name '*.dump'  | sort)

for i in ${ALL_TESTS}; do
        test=3D$(basename $i)
        echo ${test}
        ${QEMU} -nographic -machine spike_v1.10 -kernel $i
done

rv64ua-v-amoadd_d
rv64ua-v-amoadd_w
rv64ua-v-amoand_d
rv64ua-v-amoand_w
rv64ua-v-amomax_d
rv64ua-v-amomax_w
rv64ua-v-amomaxu_d
rv64ua-v-amomaxu_w
rv64ua-v-amomin_d
rv64ua-v-amomin_w
rv64ua-v-amominu_d
rv64ua-v-amominu_w
rv64ua-v-amoor_d
rv64ua-v-amoor_w
rv64ua-v-amoswap_d
rv64ua-v-amoswap_w
rv64ua-v-amoxor_d
rv64ua-v-amoxor_w
rv64ua-v-lrsc
rv64uc-v-rvc
rv64ud-v-fadd
rv64ud-v-fclass
rv64ud-v-fcmp
rv64ud-v-fcvt
rv64ud-v-fcvt_w
rv64ud-v-fdiv
rv64ud-v-fmadd
rv64ud-v-fmin
rv64ud-v-ldst
rv64ud-v-move
*** FAILED *** (tohost =3D 40)
rv64ud-v-recoding
rv64ud-v-structural
rv64uf-v-fadd
rv64uf-v-fclass
rv64uf-v-fcmp
rv64uf-v-fcvt
rv64uf-v-fcvt_w
rv64uf-v-fdiv
rv64uf-v-fmadd
rv64uf-v-fmin
rv64uf-v-ldst
rv64uf-v-move
rv64uf-v-recoding
rv64ui-v-add
rv64ui-v-addi
rv64ui-v-addiw
rv64ui-v-addw
rv64ui-v-and
rv64ui-v-andi
rv64ui-v-auipc
rv64ui-v-beq
rv64ui-v-bge
rv64ui-v-bgeu
rv64ui-v-blt
rv64ui-v-bltu
rv64ui-v-bne
rv64ui-v-fence_i
rv64ui-v-jal
rv64ui-v-jalr
rv64ui-v-lb
rv64ui-v-lbu
rv64ui-v-ld
rv64ui-v-lh
rv64ui-v-lhu
rv64ui-v-lui
rv64ui-v-lw
rv64ui-v-lwu
rv64ui-v-or
rv64ui-v-ori
rv64ui-v-sb
rv64ui-v-sd
rv64ui-v-sh
rv64ui-v-simple
rv64ui-v-sll
rv64ui-v-slli
rv64ui-v-slliw
rv64ui-v-sllw
rv64ui-v-slt
rv64ui-v-slti
rv64ui-v-sltiu
rv64ui-v-sltu
rv64ui-v-sra
rv64ui-v-srai
rv64ui-v-sraiw
rv64ui-v-sraw
rv64ui-v-srl
rv64ui-v-srli
rv64ui-v-srliw
rv64ui-v-srlw
rv64ui-v-sub
rv64ui-v-subw
rv64ui-v-sw
rv64ui-v-xor
rv64ui-v-xori
rv64um-v-div
rv64um-v-divu
rv64um-v-divuw
rv64um-v-divw
rv64um-v-mul
rv64um-v-mulh
rv64um-v-mulhsu
rv64um-v-mulhu
rv64um-v-mulw
rv64um-v-rem
rv64um-v-remu
rv64um-v-remuw
rv64um-v-remw


On Thu, Feb 8, 2018 at 2:28 PM, Michael Clark <mjc@sifive.com> wrote:

> QEMU RISC-V Emulation Support (RV64GC, RV32GC)
>
> This version of the RISC-V patch series "lucky number five" contains
> cleanups to the FPU code, fixes several FPU related test failures in
> riscv-tests and updates the syscalls for RISC-V linux-user emulation.
>
> The git tree for this v5 patch series (squashed and rebased):
>
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v5
>
> The git tree for the v1-v4 patch series with review commit history:
>
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v4
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v3
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v2
> - https://github.com/riscv/riscv-qemu/tree/qemu-upstream-v1
>
> *** Known Issues ***
>
> - FPU code needs further work to handle NaN-Boxing of Narrower Values
> - Disassembler has some checkpatch warnings for the sake of code brevity
> - scripts/qemu-binfmt-conf.sh has checkpatch warnings due to line length
> - PMP (Physical Memory Protection) is as-of-yet unused and needs testing
>
> *** Changelog ***
>
> v5
>
> - Fixed 4 test failures in riscv-tests, only one set to go...
> - Use float_muladd_negate_* flags to floatXX_muladd
> - Use IEEE 754-201x minimumNumber/maximumNumber for fmin/fmax
> - Fix TARGET_NR_syscalls
> - Update linux-user/riscv/syscall_nr.h
> - Fix FENCE.I, needs to terminate translation block
> - Adjust unusual convention for interruptno >=3D 0
>
> v4
>
> - Add @riscv: since 2.12 to CpuInfoArch
> - Remove misleading little-endian comment from load_kernel
> - Rename cpu-model property to cpu-type
> - Drop some unnecessary inline function attributes
> - Don't allow GDB to set value of x0 register
> - Remove unnecessary empty property lists
> - Add Test Finisher device to implement poweroff in virt machine
> - Implement priv ISA v1.10 trap and sret/mret xPIE/xIE behavior
> - Store fflags data in fp_status
> - Purge runtime users of helper_raise_exception
> - Fix validate_csr
> - Tidy gen_jalr
> - Tidy immediate shifts
> - Add gen_exception_inst_addr_mis
> - Add gen_exception_debug
> - Add gen_exception_illegal
> - Tidy helper_fclass_*
> - Split rounding mode setting to a new function
> - Enforce MSTATUS_FS via TB flags
> - Implement acquire/release barrier semantics
> - Use atomic operations as required
> - Fix FENCE and FENCE_I
> - Remove commented code from spike machines
> - PAGE_WRITE permissions can be set on loads if page is already dirty
> - The result of format conversion on an NaN must be a quiet NaN
> - Add missing process_queued_cpu_work to riscv linux-user
> - Remove float(32|64)_classify from cpu.h
> - Removed nonsensical unions aliasing the same type
> - Use uintN_t instead of uintN_fast_t in fpu_helper.c
> - Use macros for FPU exception values in softfloat_flags_to_riscv
> - Move code to set round mode into set_fp_round_mode function
> - Convert set_fp_exceptions from a macro to an inline function
> - Convert round mode helper into an inline function
> - Make fpu_helper ieee_rm array static const
> - Include cpu_mmu_index in cpu_get_tb_cpu_state flags
> - Eliminate MPRV influence on mmu_index
> - Remove unrecoverable do_unassigned_access function
> - Only update PTE accessed and dirty bits if necessary
> - Remove unnecessary tlb_flush in set_mode as mode is in mmu_idx
> - Remove buggy support for misa writes. misa writes are optional
>   and are not implemented in any known hardware
> - Always set PTE read or execute permissions during page walk
> - Reorder helper function declarations to match order in helper.c
> - Remove redundant variable declaration in get_physical_address
> - Remove duplicated code from get_physical_address
> - Use mmu_idx instead of mem_idx in riscv_cpu_get_phys_page_debug
>
> v3
>
> - Fix indentation in PMP and HTIF debug macros
> - Fix disassembler checkpatch open brace '{' on next line errors
> - Fix trailing statements on next line in decode_inst_decompress
> - NOTE: the other checkpatch issues have been reviewed previously
>
> v2
>
> - Remove redundant NULL terminators from disassembler register arrays
> - Change disassembler register name arrays to const
> - Refine disassembler internal function names
> - Update dates in disassembler copyright message
> - Remove #ifdef CONFIG_USER_ONLY version of cpu_has_work
> - Use ULL suffix on 64-bit constants
> - Move riscv_cpu_mmu_index from cpu.h to helper.c
> - Move riscv_cpu_hw_interrupts_pending from cpu.h to helper.c
> - Remove redundant TARGET_HAS_ICE from cpu.h
> - Use qemu_irq instead of void* for irq definition in cpu.h
> - Remove duplicate typedef from struct CPURISCVState
> - Remove redundant g_strdup from cpu_register
> - Remove redundant tlb_flush from riscv_cpu_reset
> - Remove redundant mode calculation from get_physical_address
> - Remove redundant debug mode printf and dcsr comment
> - Remove redundant clearing of MSB for bare physical addresses
> - Use g_assert_not_reached for invalid mode in get_physical_address
> - Use g_assert_not_reached for unreachable checks in get_physical_address
> - Use g_assert_not_reached for unreachable type in raise_mmu_exception
> - Return exception instead of aborting for misaligned fetches
> - Move exception defines from cpu.h to cpu_bits.h
> - Remove redundant breakpoint control definitions from cpu_bits.h
> - Implement riscv_cpu_unassigned_access exception handling
> - Log and raise exceptions for unimplemented CSRs
> - Match Spike HTIF exit behavior - don=E2=80=99t print TEST-PASSED
> - Make frm,fflags,fcsr writes trap when mstatus.FS is clear
> - Use g_assert_not_reached for unreachable invalid mode
> - Make hret,uret,dret generate illegal instructions
> - Move riscv_cpu_dump_state and int/fpr regnames to cpu.c
> - Lift interrupt flag and mask into constants in cpu_bits.h
> - Change trap debugging to use qemu_log_mask LOG_TRACE
> - Change CSR debugging to use qemu_log_mask LOG_TRACE
> - Change PMP debugging to use qemu_log_mask LOG_TRACE
> - Remove commented code from pmp.c
> - Change CpuInfoRISCV qapi schema docs to Since 2.12
> - Change RV feature macro to use target_ulong cast
> - Remove riscv_feature and instead use misa extension flags
> - Make riscv_flush_icache_syscall a no-op
> - Undo checkpatch whitespace fixes in unrelated linux-user code
> - Remove redudant constants and tidy up cpu_bits.h
> - Make helper_fence_i a no-op
> - Move include "exec/cpu-all" to end of cpu.h
> - Rename set_privilege to riscv_set_mode
> - Move redundant forward declaration for cpu_riscv_translate_address
> - Remove TCGV_UNUSED from riscv_translate_init
> - Add comment to pmp.c stating the code is untested and currently unused
> - Use ctz to simplify decoding of PMP NAPOT address ranges
> - Change pmp_is_in_range to use than equal for end addresses
> - Fix off by one error in pmp_update_rule
> - Rearrange PMP_DEBUG so that formatting is compile-time checked
> - Rearrange trap debugging so that formatting is compile-time checked
> - Rearrange PLIC debugging so that formatting is compile-time checked
> - Use qemu_log/qemu_log_mask for HTIF logging and debugging
> - Move exception and interrupt names into cpu.c
> - Add Palmer Dabbelt as a RISC-V Maintainer
> - Rebase against current qemu master branch
>
> v1
>
> - initial version based on forward port from riscv-qemu repository
>
> *** Background ***
>
> "RISC-V is an open, free ISA enabling a new era of processor innovation
> through open standard collaboration. Born in academia and research,
> RISC-V ISA delivers a new level of free, extensible software and
> hardware freedom on architecture, paving the way for the next 50 years
> of computing design and innovation."
>
> The QEMU RISC-V port has been developed and maintained out-of-tree for
> several years by Sagar Karandikar and Bastian Koppelmann. The RISC-V
> Privileged specification has evolved substantially over this period but
> has recently been solidifying. The RISC-V Base ISA has been frozon for
> some time and the Privileged ISA, GCC toolchain and Linux ABI are now
> quite stable. I have recently joined Sagar and Bastian as a RISC-V QEMU
> Maintainer and hope to support upstreaming the port.
>
> There are multiple vendors taping out, preparing to ship, or shipping
> silicon that implements the RISC-V Privileged ISA Version 1.10. There
> are also several RISC-V Soft-IP cores implementing Privileged ISA
> Version 1.10 that run on FPGA such as SiFive's Freedom U500 Platform
> and the U54=E2=80=91MC RISC-V Core IP, among many more implementations fr=
om a
> variety of vendors. See https://riscv.org/ for more details.
>
> RISC-V support was upstreamed in binutils 2.28 and GCC 7.1 in the first
> half of 2016. RISC-V support is now available in LLVM top-of-tree and
> the RISC-V Linux port was accepted into Linux 4.15-rc1 late last year
> and is available in the Linux 4.15 release. GLIBC 2.27 added support
> for the RISC-V ISA running on Linux (requires at least binutils-2.30,
> gcc-7.3.0, and linux-4.15). We believe it is timely to submit the
> RISC-V QEMU port for upstream review with the goal of incorporating
> RISC-V support into the upcoming QEMU 2.12 release.
>
> The RISC-V QEMU port is still under active development, mostly with
> respect to device emulation, the addition of Hypervisor support as
> specified in the RISC-V Draft Privileged ISA Version 1.11, and Vector
> support once the first draft is finalized later this year. We believe
> now is the appropriate time for RISC-V QEMU development to be carried
> out in the main QEMU repository as the code will benefit from more
> rigorous review. The RISC-V QEMU port currently supports all the ISA
> extensions that have been finalized and frozen in the Base ISA.
>
> Blog post about recent additions to RISC-V QEMU: https://goo.gl/fJ4zgk
>
> The RISC-V QEMU wiki: https://github.com/riscv/riscv-qemu/wiki
>
> Instructions for building a busybox+dropbear root image, BBL (Berkeley
> Boot Loader) and linux kernel image for use with the RISC-V QEMU
> 'virt' machine: https://github.com/michaeljclark/busybear-linux
>
> *** Overview ***
>
> The RISC-V QEMU port implements the following specifications:
>
> - RISC-V Instruction Set Manual Volume I: User-Level ISA Version 2.2
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.9.1
> - RISC-V Instruction Set Manual Volume II: Privileged ISA Version 1.10
>
> The RISC-V QEMU port supports the following instruction set extensions:
>
> - RV32GC with Supervisor-mode and User-mode (RV32IMAFDCSU)
> - RV64GC with Supervisor-mode and User-mode (RV64IMAFDCSU)
>
> The RISC-V QEMU port adds the following targets to QEMU:
>
> - riscv32-softmmu
> - riscv64-softmmu
> - riscv32-linux-user
> - riscv64-linux-user
>
> The RISC-V QEMU port supports the following hardware:
>
> - HTIF Console (Host Target Interface)
> - SiFive CLINT (Core Local Interruptor) for Timer interrupts and IPIs
> - SiFive PLIC (Platform Level Interrupt Controller)
> - SiFive Test (Test Finisher) for exiting simulation
> - SiFive UART, PRCI, AON, PWM, QSPI support is partially implemented
> - VirtIO MMIO (GPEX PCI support will be added in a future patch)
> - Generic 16550A UART emulation using 'hw/char/serial.c'
> - Experimental SMP support (PLIC and CLINT) on the 'virt' machine
>
> The RISC-V QEMU full system emulator supports 5 machines:
>
> - 'spike_v1.9';  CLINT, PLIC, HTIF console, config-string, Priv v1.9.1
> - 'spike_v1.10'; CLINT, PLIC, HTIF console, device-tree, Priv v1.10
> - 'sifive_e300'; CLINT, PLIC, SiFive UART, HiFive1 compat, Priv v1.10
> - 'sifive_u500'; CLINT, PLIC, SiFive UART, device-tree, Priv v1.10
> - 'virt'; CLINT, PLIC, 16550A UART, VirtIO, device-tree, Priv v1.10
>
> This is a list of RISC-V QEMU Port Contributors:
>
> - Alex Suykov
> - Andreas Schwab
> - Antony Pavlov
> - Bastian Koppelmann
> - Bruce Hoult
> - Chih-Min Chao
> - Daire McNamara
> - Darius Rad
> - David Abdurachmanov
> - Ivan Griffin
> - Jim Wilson
> - Kito Cheng
> - Michael Clark
> - Palmer Dabbelt
> - Richard Henderon
> - Sagar Karandikar
> - Stefan O'Rear
>
> Notes:
>
> - contributor email addresses available off-list on request.
> - checkpatch has been run on all 22 patches.
> - checkpatch exceptions are noted in 2 patches that have errors.
> - tested linux on 'spike_v1.9', 'spike_v1.10' and 'virt' machines
> - passes "make check" on full build for all targets
>
> This patch series includes the following patches:
>
> Michael Clark (23):
>   RISC-V Maintainers
>   RISC-V ELF Machine Definition
>   RISC-V CPU Core Definition
>   RISC-V Disassembler
>   RISC-V CPU Helpers
>   Softfloat support for IEEE 754-201x minimumNumber/maximumNumber
>   RISC-V FPU Support
>   RISC-V GDB Stub
>   RISC-V TCG Code Generation
>   RISC-V Physical Memory Protection
>   RISC-V Linux User Emulation
>   RISC-V HTIF Console
>   RISC-V HART Array
>   SiFive RISC-V CLINT Block
>   SiFive RISC-V PLIC Block
>   RISC-V Spike Machines
>   RISC-V VirtIO Machine
>   SiFive RISC-V UART Device
>   SiFive RISC-V PRCI Block
>   SiFive RISC-V Test Finisher
>   SiFive Freedom E300 RISC-V Machine
>   SiFive Freedom U500 RISC-V Machine
>   RISC-V Build Infrastructure
>
>  MAINTAINERS                            |   11 +
>  Makefile.objs                          |    1 +
>  arch_init.c                            |    2 +
>  configure                              |   11 +
>  cpus.c                                 |    6 +
>  default-configs/riscv32-linux-user.mak |    1 +
>  default-configs/riscv32-softmmu.mak    |    4 +
>  default-configs/riscv64-linux-user.mak |    1 +
>  default-configs/riscv64-softmmu.mak    |    4 +
>  disas.c                                |    2 +
>  disas/Makefile.objs                    |    1 +
>  disas/riscv.c                          | 3054
> ++++++++++++++++++++++++++++++++
>  fpu/softfloat-specialize.h             |    7 +-
>  fpu/softfloat.c                        |   41 +-
>  hw/riscv/Makefile.objs                 |   13 +
>  hw/riscv/riscv_elf.c                   |  244 +++
>  hw/riscv/riscv_hart.c                  |   95 +
>  hw/riscv/riscv_htif.c                  |  373 ++++
>  hw/riscv/sifive_clint.c                |  312 ++++
>  hw/riscv/sifive_e300.c                 |  232 +++
>  hw/riscv/sifive_plic.c                 |  554 ++++++
>  hw/riscv/sifive_prci.c                 |   95 +
>  hw/riscv/sifive_test.c                 |   99 ++
>  hw/riscv/sifive_u500.c                 |  338 ++++
>  hw/riscv/sifive_uart.c                 |  182 ++
>  hw/riscv/spike_v1_09.c                 |  204 +++
>  hw/riscv/spike_v1_10.c                 |  278 +++
>  hw/riscv/virt.c                        |  375 ++++
>  include/disas/bfd.h                    |    2 +
>  include/elf.h                          |    2 +
>  include/fpu/softfloat.h                |    4 +
>  include/hw/riscv/riscv_elf.h           |   69 +
>  include/hw/riscv/riscv_hart.h          |   45 +
>  include/hw/riscv/riscv_htif.h          |   62 +
>  include/hw/riscv/sifive_clint.h        |   56 +
>  include/hw/riscv/sifive_e300.h         |   79 +
>  include/hw/riscv/sifive_plic.h         |   91 +
>  include/hw/riscv/sifive_prci.h         |   43 +
>  include/hw/riscv/sifive_test.h         |   48 +
>  include/hw/riscv/sifive_u500.h         |   69 +
>  include/hw/riscv/sifive_uart.h         |   76 +
>  include/hw/riscv/spike.h               |   51 +
>  include/hw/riscv/virt.h                |   74 +
>  include/sysemu/arch_init.h             |    1 +
>  linux-user/elfload.c                   |   22 +
>  linux-user/main.c                      |   97 +
>  linux-user/riscv/syscall_nr.h          |  287 +++
>  linux-user/riscv/target_cpu.h          |   18 +
>  linux-user/riscv/target_signal.h       |   23 +
>  linux-user/riscv/target_structs.h      |   46 +
>  linux-user/riscv/target_syscall.h      |   56 +
>  linux-user/riscv/termbits.h            |  220 +++
>  linux-user/signal.c                    |  203 ++-
>  linux-user/syscall.c                   |    2 +
>  linux-user/syscall_defs.h              |   13 +-
>  qapi-schema.json                       |   16 +-
>  scripts/qemu-binfmt-conf.sh            |   13 +-
>  target/riscv/Makefile.objs             |    1 +
>  target/riscv/cpu.c                     |  385 ++++
>  target/riscv/cpu.h                     |  256 +++
>  target/riscv/cpu_bits.h                |  417 +++++
>  target/riscv/cpu_user.h                |   16 +
>  target/riscv/fpu_helper.c              |  375 ++++
>  target/riscv/gdbstub.c                 |   60 +
>  target/riscv/helper.c                  |  464 +++++
>  target/riscv/helper.h                  |   78 +
>  target/riscv/instmap.h                 |  366 ++++
>  target/riscv/op_helper.c               |  644 +++++++
>  target/riscv/pmp.c                     |  386 ++++
>  target/riscv/pmp.h                     |   70 +
>  target/riscv/trace-events              |    1 +
>  target/riscv/translate.c               | 1970 ++++++++++++++++++++
>  72 files changed, 13800 insertions(+), 17 deletions(-)
>  create mode 100644 default-configs/riscv32-linux-user.mak
>  create mode 100644 default-configs/riscv32-softmmu.mak
>  create mode 100644 default-configs/riscv64-linux-user.mak
>  create mode 100644 default-configs/riscv64-softmmu.mak
>  create mode 100644 disas/riscv.c
>  create mode 100644 hw/riscv/Makefile.objs
>  create mode 100644 hw/riscv/riscv_elf.c
>  create mode 100644 hw/riscv/riscv_hart.c
>  create mode 100644 hw/riscv/riscv_htif.c
>  create mode 100644 hw/riscv/sifive_clint.c
>  create mode 100644 hw/riscv/sifive_e300.c
>  create mode 100644 hw/riscv/sifive_plic.c
>  create mode 100644 hw/riscv/sifive_prci.c
>  create mode 100644 hw/riscv/sifive_test.c
>  create mode 100644 hw/riscv/sifive_u500.c
>  create mode 100644 hw/riscv/sifive_uart.c
>  create mode 100644 hw/riscv/spike_v1_09.c
>  create mode 100644 hw/riscv/spike_v1_10.c
>  create mode 100644 hw/riscv/virt.c
>  create mode 100644 include/hw/riscv/riscv_elf.h
>  create mode 100644 include/hw/riscv/riscv_hart.h
>  create mode 100644 include/hw/riscv/riscv_htif.h
>  create mode 100644 include/hw/riscv/sifive_clint.h
>  create mode 100644 include/hw/riscv/sifive_e300.h
>  create mode 100644 include/hw/riscv/sifive_plic.h
>  create mode 100644 include/hw/riscv/sifive_prci.h
>  create mode 100644 include/hw/riscv/sifive_test.h
>  create mode 100644 include/hw/riscv/sifive_u500.h
>  create mode 100644 include/hw/riscv/sifive_uart.h
>  create mode 100644 include/hw/riscv/spike.h
>  create mode 100644 include/hw/riscv/virt.h
>  create mode 100644 linux-user/riscv/syscall_nr.h
>  create mode 100644 linux-user/riscv/target_cpu.h
>  create mode 100644 linux-user/riscv/target_signal.h
>  create mode 100644 linux-user/riscv/target_structs.h
>  create mode 100644 linux-user/riscv/target_syscall.h
>  create mode 100644 linux-user/riscv/termbits.h
>  create mode 100644 target/riscv/Makefile.objs
>  create mode 100644 target/riscv/cpu.c
>  create mode 100644 target/riscv/cpu.h
>  create mode 100644 target/riscv/cpu_bits.h
>  create mode 100644 target/riscv/cpu_user.h
>  create mode 100644 target/riscv/fpu_helper.c
>  create mode 100644 target/riscv/gdbstub.c
>  create mode 100644 target/riscv/helper.c
>  create mode 100644 target/riscv/helper.h
>  create mode 100644 target/riscv/instmap.h
>  create mode 100644 target/riscv/op_helper.c
>  create mode 100644 target/riscv/pmp.c
>  create mode 100644 target/riscv/pmp.h
>  create mode 100644 target/riscv/trace-events
>  create mode 100644 target/riscv/translate.c
>
> --
> 2.7.0
>
>
