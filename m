Received: from eggs.gnu.org ([2001:4830:134:3::10]:40381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTNmL-0002FZ-DP
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTNmI-0002Yq-A3
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:49 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:45480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTNmI-0002YZ-0m
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:38:46 -0400
Received: by mail-wr0-x243.google.com with SMTP id o12-v6so5435463wrm.12
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 01:38:45 -0700 (PDT)
References: <20180614081610.12092-1-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180614081610.12092-1-stefanha@redhat.com>
Date: Thu, 14 Jun 2018 09:38:43 +0100
Message-ID: <87zhzxzrsc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2] target/arm: add ARMv6-M UNDEFINED 32-bit
 instruction test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: jusual@mail.ru, joel@jms.id.au, qemu.ml@steffen-goertz.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, jim@groklearning.com


Stefan Hajnoczi <stefanha@redhat.com> writes:

> Test that 32-bit instructions declared UNDEFINED in the ARMv6-M
> Reference Manual really do raise an exception.  Also test that the 6
> 32-bit instructions defined in the ARMv6-M Reference Manual do not raise
> an exception.
>
> The Intel HEX (.hex) file is included to save people the trouble of
> installing a cross-compiler toolchain.
>
> To run the test (make sure qemu-system-arm is in your $PATH):
>
>   $ cd tests/tcg/arm
>   $ make run-test-armv6m-undef
>
> Based-on: <20180612204632.28780-1-jusual@mail.ru>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> This patch tests instruction space that Julia's patch exposes on ARMv6-m
> CPUs.
>
>  tests/tcg/arm/Makefile              |  21 ++++
>  tests/tcg/arm/test-armv6m-undef.S   | 154 ++++++++++++++++++++++++++++
>  tests/tcg/arm/test-armv6m-undef.hex |  22 ++++
>  tests/tcg/arm/test-armv6m-undef.ld  |  21 ++++
>  4 files changed, 218 insertions(+)
>  create mode 100644 tests/tcg/arm/Makefile
>  create mode 100644 tests/tcg/arm/test-armv6m-undef.S
>  create mode 100644 tests/tcg/arm/test-armv6m-undef.hex
>  create mode 100644 tests/tcg/arm/test-armv6m-undef.ld
>
> diff --git a/tests/tcg/arm/Makefile b/tests/tcg/arm/Makefile
> new file mode 100644
> index 0000000000..c43049ca10
> --- /dev/null
> +++ b/tests/tcg/arm/Makefile
> @@ -0,0 +1,21 @@
> +CC =3D arm-linux-gnu-gcc
> +OBJCOPY =3D arm-linux-gnu-objcopy
> +
> +SOURCES =3D $(wildcard *.S)
> +BINARIES =3D $(patsubst %.S,%.hex,$(SOURCES))
> +
> +.PHONY: clean
> +
> +all: $(BINARIES)
> +
> +clean:
> +	rm -f $(BINARIES) *.o
> +
> +%.o: %.S %.ld
> +	$(CC) -nostdlib -Wl,--build-id=3Dnone -x assembler-with-cpp -T $(patsub=
st %.S,%.ld,$<) -x assembler-with-cpp -o $@ $<
> +
> +%.hex: %.o
> +	$(OBJCOPY) -O ihex $< $@
> +
> +run-test-armv6m-undef: test-armv6m-undef.hex
> +	qemu-system-arm -semihosting -M microbit -kernel $<

I'm hoping to have my TCG testing merged before this but it would clash:

  https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02002.html

Any chance you could re-base on that tree and use the cross-compiler
infrastructure it provides?

I don't see a problem shipping the hex files for those that don't have
docker/cross-compiler setups though.


> diff --git a/tests/tcg/arm/test-armv6m-undef.S b/tests/tcg/arm/test-armv6=
m-undef.S
> new file mode 100644
> index 0000000000..d18ca56b4a
> --- /dev/null
> +++ b/tests/tcg/arm/test-armv6m-undef.S
> @@ -0,0 +1,154 @@
> +/*
> + * Test ARMv6-M UNDEFINED 32-bit instructions
> + *
> + * Copyright 2018 Red Hat Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2
> + * or later. See the COPYING file in the top-level directory.
> + */
> +
> +/*
> + * Test that UNDEFINED 32-bit instructions fault as expected.  This is an
> + * interesting test because ARMv6-M shares code with its more fully-feat=
ured
> + * siblings and it's necessary to verify that its limited instruction se=
t is
> + * emulated correctly.
> + *
> + * The emulator must be invoked with -semihosting so that the test case =
can
> + * terminate with exit code 0 on success or 1 on failure.
> + *
> + * Failures can be debugged with -d in_asm,int,exec,cpu and the
> + * gdbstub (-S -s).
> + */
> +
> +.syntax unified
> +.cpu cortex-m0
> +.thumb
> +
> +/*
> + * Memory map
> + */
> +#define SRAM_BASE 0x20000000
> +#define SRAM_SIZE (16 * 1024)
> +
> +/*
> + * Semihosting interface on ARM T32
> + * See "Semihosting for AArch32 and AArch64 Version 2.0 Documentation" b=
y ARM
> + */
> +#define semihosting_call bkpt 0xab
> +#define SYS_EXIT 0x18
> +
> +vector_table:
> +    .word SRAM_BASE + SRAM_SIZE /* 0. SP_main */
> +    .word exc_reset_thumb       /* 1. Reset */
> +    .word 0                     /* 2. NMI */
> +    .word exc_hard_fault_thumb  /* 3. HardFault */
> +    .rept 7
> +    .word 0                     /* 4-10. Reserved */
> +    .endr
> +    .word 0                     /* 11. SVCall */
> +    .word 0                     /* 12. Reserved */
> +    .word 0                     /* 13. Reserved */
> +    .word 0                     /* 14. PendSV */
> +    .word 0                     /* 15. SysTick */
> +    .rept 32
> +    .word 0                     /* 16-47. External Interrupts */
> +    .endr
> +
> +exc_reset:
> +.equ exc_reset_thumb, exc_reset + 1
> +.global exc_reset_thumb
> +    /* The following 32-bit UNDEFINED instructions are tested by executi=
ng
> +     * them.  The HardFault exception handler should execute and return =
to
> +     * the next test case.  If no exception is raised the test fails.
> +     */
> +
> +    /* Table A5-9 32-bit Thumb encoding */
> +    .short 0b1110100000000000
> +    .short 0b0000000000000000
> +    b not_reached
> +    .short 0b1110100000000000
> +    .short 0b1000000000000000
> +    b not_reached
> +    .short 0b1111100000000000
> +    .short 0b0000000000000000
> +    b not_reached
> +    .short 0b1111100000000000
> +    .short 0b1000000000000000
> +    b not_reached
> +    .short 0b1111000000000000
> +    .short 0b0000000000000000
> +    b not_reached
> +
> +    /* Table A5-10 Branch and miscellaneous control instructions */
> +    .short 0b1111011111110000
> +    .short 0b1010000000000000
> +    b not_reached
> +
> +    /* The following are valid 32-bit instructions that must not raise a
> +     * HardFault.
> +     */
> +
> +    /* B4.2.3 Move to Special Register (moves to IPSR are ignored) */
> +    msr ipsr, r0
> +    b 1f
> +    b not_reached
> +1:
> +    /* B4.2.2 Move from Special Register */
> +    mrs r0, ipsr
> +    b 1f
> +    b not_reached
> +1:
> +    /* A6.7.13 Branch with Link (immediate) */
> +    bl 1f
> +1:
> +    b 1f
> +    b not_reached
> +1:
> +    /* A6.7.21 Data Memory Barrier */
> +    dmb
> +    b 1f
> +    b not_reached
> +1:
> +    /* A6.7.22 Data Synchronization Barrier */
> +    dsb
> +    b 1f
> +    b not_reached
> +1:
> +    /* A6.7.24 Instruction Memory Barrier */
> +    isb
> +    b 1f
> +    b not_reached
> +1:
> +
> +    /* Success! */
> +    movs r0, 1
> +    b exit
> +
> +not_reached: /* Failure :( */
> +    movs r0, 0
> +    b exit
> +
> +/* When a HardFault occurs, return to pc+6 (test cases are 3 halfwords l=
ong) */
> +exc_hard_fault:
> +.equ exc_hard_fault_thumb, exc_hard_fault + 1
> +.global exc_hard_fault_thumb
> +    ldr r0, [sp, 0x18]
> +    adds r0, 6
> +    str r0, [sp, 0x18]
> +    bx lr
> +
> +/*
> + * exit: Terminate emulator
> + * @r0: 0 - failure, 1 - success
> + */
> +exit:
> +    movs r1, 0
> +    cmp r0, 1
> +    bne 1f
> +    ldr r1, ADP_Stopped_ApplicationExit
> +1:
> +    movs r0, SYS_EXIT
> +    semihosting_call
> +.align 2
> +ADP_Stopped_ApplicationExit:
> +    .word 0x20026
> diff --git a/tests/tcg/arm/test-armv6m-undef.hex b/tests/tcg/arm/test-arm=
v6m-undef.hex
> new file mode 100644
> index 0000000000..6a32548e3c
> --- /dev/null
> +++ b/tests/tcg/arm/test-armv6m-undef.hex
> @@ -0,0 +1,22 @@
> +:1000000000400020C1000000000000001D010000B1
> +:1000100000000000000000000000000000000000E0
> +:1000200000000000000000000000000000000000D0
> +:1000300000000000000000000000000000000000C0
> +:1000400000000000000000000000000000000000B0
> +:1000500000000000000000000000000000000000A0
> +:100060000000000000000000000000000000000090
> +:100070000000000000000000000000000000000080
> +:100080000000000000000000000000000000000070
> +:100090000000000000000000000000000000000060
> +:1000A0000000000000000000000000000000000050
> +:1000B0000000000000000000000000000000000040
> +:1000C00000E8000028E000E8008025E000F80000DB
> +:1000D00022E000F800801FE000F000001CE0F0F7D4
> +:1000E00000A019E080F3058800E015E0EFF305803B
> +:1000F00000E011E000F000F800E00DE0BFF35F8FDA
> +:1001000000E009E0BFF34F8F00E005E0BFF36F8F21
> +:1001100000E001E0012005E0002003E00698063041
> +:10012000069070470021012800D101491820ABBE7C
> +:0401300026000200A3
> +:04000003000000C138
> +:00000001FF
> diff --git a/tests/tcg/arm/test-armv6m-undef.ld b/tests/tcg/arm/test-armv=
6m-undef.ld
> new file mode 100644
> index 0000000000..43dbbf17d5
> --- /dev/null
> +++ b/tests/tcg/arm/test-armv6m-undef.ld
> @@ -0,0 +1,21 @@
> +ENTRY(exc_reset_thumb)
> +
> +SECTIONS
> +{
> +    . =3D 0x0;
> +    .text : {
> +        *(.text)
> +    }
> +    .data : {
> +        *(.data)
> +    }
> +    .rodata : {
> +        *(.rodata)
> +    }
> +    .bss : {
> +        *(.bss)
> +    }
> +    /DISCARD/ : {
> +        *(.ARM.attributes)
> +    }
> +}


--
Alex Benn=C3=A9e
