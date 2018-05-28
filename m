Received: from eggs.gnu.org ([2001:4830:134:3::10]:46054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fNJ6A-0002fa-3j
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fNJ68-0007zt-Tq
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:26:10 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fNJ68-0007wl-Kf
	for qemu-devel@nongnu.org; Mon, 28 May 2018 10:26:08 -0400
Received: by mail-wr0-x22b.google.com with SMTP id d2-v6so5123990wrm.10
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 07:26:07 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 28 May 2018 15:26:05 +0100
Message-ID: <CAJSP0QURm0Y6FBByzY=kgf7JmDDyt5PLkkxk+ODi21uQKUGq5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Cortex M0 emulation tasks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>
Cc: =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Jim Mussared <jim@groklearning.com>, qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi,
I took a look at what's required for ARM Cortex M0 emulation that we
need for the micro:bit ARM board.  The following notes are based on
Appendix D3 of the ARMv6-M Architecture Reference Manual that Peter
Maydell recommended.

Several people can work on this since there are many smaller tasks.

The general approach for each task:
1. Look at Appendix D3 to understand the architecture differences.
2. Look at QEMU source code (mainly target/arm/translate.c) to
understand the current status.
3. Implement a ARMv6-M-specific code path, if necessary.
4. Implement a test case that exercises the instruction or register to
prove it works.

Before we can tackle these tasks a Cortex M0 CPU needs to be defined.
Adding the Cortex M0 involves a new element in
target/arm/cpu.c:arm_cpus[].  The CPU needs ARM_FEATURE_V6 and
ARM_FEATURE_M.  Once that is in place most of these tasks can be done
independently and by multiple people.

How to collaborate:
Pick something you want to do from this list and reply-all to announce
you are working on it.

Tasks:

D3.3 Instruction Support
Each of the listed instructions needs to be audited.  For example,
"32-bit DMB, DSB and ISB barrier instructions" will not work because
disas_thumb2_insn() won't run for ARM_FEATURE_V6 without
ARM_FEATURE_THUMB2:

    /* The only 32 bit insn that's allowed for Thumb1 is the combined
     * BL/BLX prefix and suffix.
     */
    if ((insn & 0xf800e800) != 0xf000e800) {
        ARCH(6T2);  <-- this will fail on ARMv6-M
    }

The 32-bit Thumb2 DMB, DSB, and ISB instructions need to be added as
special cases for ARMv6-M.

And there is a second check that will fail:

  case 3: /* Special control operations.  */
    ARCH(7);  <-- this is too restrictive!
    op = (insn >> 4) & 0xf;
    switch (op) {
    case 2: /* clrex */
        gen_clrex(s);  <--- not supported on ARMv6-M
        break;
    case 4: /* dsb */  <--- supported on ARMv6-M
    case 5: /* dmb */  <--- supported on ARMv6-M
        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
        break;
    case 6: /* isb */  <--- supported on ARMv6-M
        /* We need to break the TB after this insn
         * to execute self-modifying code correctly
         * and also to take any pending interrupts
         * immediately.
         */
        gen_goto_tb(s, 0, s->pc & ~1);
        break;
    default:
        goto illegal_op;
    }

These instructions must be tested to prove they do not fault and
behave properly.  I recommend a similar approach to
tests/boot-serial-test.c consisting of a tiny instruction sequence.

D3.4 Programmer's model
Lot's of details to check here.  I haven't investigated it.  Comments
appreciated.

D3.5 Memory model
This can probably be ignored, it's very similar to ARMv7-M.

D3.5.1 Alignment support
ARMv7-M supports unaligned accesses but ARMv6-M does not.  Check code
to ensure alignment checks are being made.

D3.5.2 Endian support
Nothing to do here.

D3.5.3 Exclusive access support
Each of the listed instructions must be checked.  For example, STREX
is not supported ARMv6-M but QEMU seems to allow it.

D3.5.4 Cache support
Nothing to do here.

D3.5.5 PMSA support
I think we can ignore this.  QEMU implements PMSA.  It would be best
to check if Cortex M0 wants PMSAv6.

D3.6.1 Reserved registers in ARMv6-M
Listed registers must be emulated "Read-as-Zero, Write Ignored" for
ARMv6-M.  This means guest memory load instructions produce 0 and
store instructions have no effect.

D3.6.2 General Fault Status Registers
ARMv6-M has a coarser fault handling architecture, the code needs to
be audited to check that HardFault is raised under all conditions.

D3.6.3 System timer support
No changes necessary.  My interpretation is that SysTick is optional
for Cortex M0 but the nRF51 implements it.  It is mandatory for
ARMv7-M, so let's just keep it.

D3.6.4 NVIC support
Some registers are reserved on ARMv6-M and there are fewer priority levels.

D3.7 Debug support
I think we can ignore this because debugging is handled by QEMU via the gdbstub.

Stefan
