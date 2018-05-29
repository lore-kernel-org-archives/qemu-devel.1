Received: from eggs.gnu.org ([2001:4830:134:3::10]:43291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj43-0004iJ-Uf
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNj42-0006CG-8o
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:09:43 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:43130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNj41-0006Bg-Pu
	for qemu-devel@nongnu.org; Tue, 29 May 2018 14:09:42 -0400
Received: by mail-oi0-x233.google.com with SMTP id t133-v6so10303909oif.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 11:09:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
References: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 19:09:20 +0100
Message-ID: <CAFEAcA_cuf4ZXcwK9+z26wFTb0L28cDuT3_xaJAFy5ijt=ZskQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>

On 28 May 2018 at 15:26, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Hi,
> I took a look at what's required for ARM Cortex M0 emulation that we
> need for the micro:bit ARM board.  The following notes are based on
> Appendix D3 of the ARMv6-M Architecture Reference Manual that Peter
> Maydell recommended.
>
> Several people can work on this since there are many smaller tasks.
>
> The general approach for each task:
> 1. Look at Appendix D3 to understand the architecture differences.
> 2. Look at QEMU source code (mainly target/arm/translate.c) to
> understand the current status.

Rough guide to where things are:
 * target/arm/translate.c has the decoder for instructions
 * target/arm/helper.c has out-of-line handling for complicated
   instructions like MSR/MRS, and also exception entry/exit code
   and the MPU implementation
 * hw/intc/armv7m_nvic.c has the NVIC interrupt controller; this is
   also where we've put the implementation of memory mapped system
   registers

> 3. Implement a ARMv6-M-specific code path, if necessary.
> 4. Implement a test case that exercises the instruction or register to
> prove it works.
>
> Before we can tackle these tasks a Cortex M0 CPU needs to be defined.
> Adding the Cortex M0 involves a new element in
> target/arm/cpu.c:arm_cpus[].  The CPU needs ARM_FEATURE_V6 and
> ARM_FEATURE_M.  Once that is in place most of these tasks can be done
> independently and by multiple people.

Note that this is the first thing you need for development
but the last thing that should go upstream...

> How to collaborate:
> Pick something you want to do from this list and reply-all to announce
> you are working on it.
>
> Tasks:
>
> D3.3 Instruction Support
> Each of the listed instructions needs to be audited.  For example,
> "32-bit DMB, DSB and ISB barrier instructions" will not work because
> disas_thumb2_insn() won't run for ARM_FEATURE_V6 without
> ARM_FEATURE_THUMB2:
>
>     /* The only 32 bit insn that's allowed for Thumb1 is the combined
>      * BL/BLX prefix and suffix.
>      */
>     if ((insn & 0xf800e800) != 0xf000e800) {
>         ARCH(6T2);  <-- this will fail on ARMv6-M
>     }
>
> The 32-bit Thumb2 DMB, DSB, and ISB instructions need to be added as
> special cases for ARMv6-M.

We also need to permit the 32-bit MSR and MRS instructions.
Section A5.3 of the v6M ARM ARM has the decode tables for
the 32-bit insns: we should allow through the bit patterns
in those tables and forbid everything else.

The thumb_insn_is_16bit() function also needs updating: this
check:

    if (arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
        /* Thumb2 cores (including all M profile ones) always treat
         * 32-bit insns as 32-bit.
         */
        return false;
    }

should also return false for a v6M core. (v6M is like Thumb2
in that the BL instruction is always 32 bit and is not handled
as two 16-bit halves -- see the Note in the v6M ARM ARM for
the definition of the BL insn in A6.7.13.) Simplest way to
do that is just add "|| arm_dc_feature(ARM_FEATURE_M)" to the if.

> And there is a second check that will fail:
>
>   case 3: /* Special control operations.  */
>     ARCH(7);  <-- this is too restrictive!
>     op = (insn >> 4) & 0xf;
>     switch (op) {
>     case 2: /* clrex */
>         gen_clrex(s);  <--- not supported on ARMv6-M
>         break;
>     case 4: /* dsb */  <--- supported on ARMv6-M
>     case 5: /* dmb */  <--- supported on ARMv6-M
>         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>         break;
>     case 6: /* isb */  <--- supported on ARMv6-M
>         /* We need to break the TB after this insn
>          * to execute self-modifying code correctly
>          * and also to take any pending interrupts
>          * immediately.
>          */
>         gen_goto_tb(s, 0, s->pc & ~1);
>         break;
>     default:
>         goto illegal_op;
>     }
>
> These instructions must be tested to prove they do not fault and
> behave properly.  I recommend a similar approach to
> tests/boot-serial-test.c consisting of a tiny instruction sequence.
>
> D3.4 Programmer's model
> Lot's of details to check here.  I haven't investigated it.  Comments
> appreciated.

The most notable thing here is that the unprivileged/privileged
support is an optional extension for v6M, and is not implemented
in the Cortex-M0. Handling this probably mostly amounts to making
sure that the system registers which let you transition from
priv to unpriv (ie CONTROL.nPRIV) can't be modified, either directly
using MSR or indirectly in an exception return.

We should use a new feature bit ARM_FEATURE_M_MAIN for this,
I think (which is set for v7M in arm_cpu_realizefn() but not for v6M).
This is because I'm looking ahead to v8M, which provides the
successor to both the cut-down v6M ("v8M Baseline implementation")
and the full-fat v7M ("v8M Mainline implementation").

> D3.5 Memory model
> This can probably be ignored, it's very similar to ARMv7-M.

Yes. We don't implement LDM/STM being interruptible for v7M
(an interrupt always appears to the guest as if it were taken
either just before the insn started or immediately after it
finished), so no change required for v6M.

> D3.5.1 Alignment support
> ARMv7-M supports unaligned accesses but ARMv6-M does not.  Check code
> to ensure alignment checks are being made.

This should mostly involve adding MO_ALIGN to the memory accesses
where required. (This is also a check for !ARM_FEATURE_M_MAIN).

> D3.5.2 Endian support
> Nothing to do here.
>
> D3.5.3 Exclusive access support
> Each of the listed instructions must be checked.  For example, STREX
> is not supported ARMv6-M but QEMU seems to allow it.

All the exclusive insns are 32-bit, so if we get our check right
in disas_thumb2_insn() this should automatically result in these
insns not being allowed for v6M.

> D3.5.4 Cache support
> Nothing to do here.
>
> D3.5.5 PMSA support
> I think we can ignore this.  QEMU implements PMSA.  It would be best
> to check if Cortex M0 wants PMSAv6.

The Cortex-M0 does not implement an MPU, so we can just have it
not set ARM_FEATURE_MPU, and ignore this for the moment.

To implement PMSA for the v6M we would need to figure out the
differences between PMSAv6 and PMSAv7 and handle them (either
by parameterizing get_phys_addr_psmav7 or by adding a new
get_phys_addr_pmsav6).

> D3.6.1 Reserved registers in ARMv6-M
> Listed registers must be emulated "Read-as-Zero, Write Ignored" for
> ARMv6-M.  This means guest memory load instructions produce 0 and
> store instructions have no effect.

Note that these registers are implemented in hw/intc/armv7_nvic.c.

Other registers are present in v6M but don't have as much functionality
as their v7M equivalents (some bits will be RAZ/WI or RAO/WI):
somebody needs to go through the list of v6M registers and check
that the relevant parts of the register functionality are gated
behind suitable arm_feature checks.

> D3.6.2 General Fault Status Registers
> ARMv6-M has a coarser fault handling architecture, the code needs to
> be audited to check that HardFault is raised under all conditions.

This should more or less just work as long as we arrange that the
missing exceptions (MemManage, BusFault, UsageFault) can't be enabled
via the NVIC register interface, because the v7M behaviour is that
disabled exceptions escalate to HardFault.

> D3.6.3 System timer support
> No changes necessary.  My interpretation is that SysTick is optional
> for Cortex M0 but the nRF51 implements it.  It is mandatory for
> ARMv7-M, so let's just keep it.

Agreed.

> D3.6.4 NVIC support
> Some registers are reserved on ARMv6-M and there are fewer priority levels.

Again, this is mostly going through the specs for the registers and
ensuring things are gated properly.

For the reduced priority levels, we should handle this by having
the NVIC be configurable for the number of supported priority levels.
(For v7M this is IMPDEF, and at the moment we've chosen to always
provide 256 priority levels, but we should make it be generally
settable rather than hardwiring v6M == 4, v7M == 256.)

> D3.7 Debug support
> I think we can ignore this because debugging is handled by QEMU via the gdbstub.

Yes; we don't implement the architectural Debug Extensions.

thanks
-- PMM
