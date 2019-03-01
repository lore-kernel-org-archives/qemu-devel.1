Received: from eggs.gnu.org ([209.51.188.92]:46679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzcem-0002k1-Sl
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:32:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzcel-0000W3-Ly
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:32:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzcel-0000VC-D0
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 02:32:31 -0500
Received: by mail-wm1-x344.google.com with SMTP id x7so11463609wmj.0
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 23:32:31 -0800 (PST)
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-9-alex.bennee@linaro.org>
	<8f8d9193-14f9-4fda-2f68-cf04b4d9cd8c@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <8f8d9193-14f9-4fda-2f68-cf04b4d9cd8c@redhat.com>
Date: Fri, 01 Mar 2019 07:32:28 +0000
Message-ID: <87va13jbhv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 08/16] tests/tcg/arm: add ARMv6-M
 UNDEFINED 32-bit instruction test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, jcmvbkbc@gmail.com


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/28/19 9:25 PM, Alex Benn=C3=A9e wrote:
>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> Test that 32-bit instructions declared UNDEFINED in the ARMv6-M
>> Reference Manual really do raise an exception.  Also test that the 6
>> 32-bit instructions defined in the ARMv6-M Reference Manual do not raise
>> an exception.
>>
>> Based-on: <20181029194519.15628-1-stefanha@redhat.com>
>
> ^ cut 'Based-on' from git history?

Yeah - we really only need the Message ID.

>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Message-Id: <20181129185113.30353-1-stefanha@redhat.com>
>> [AJB: integrated into system tests]
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> ---
>> v2
>>   - added to series
>>   - used softmmu-target Makefile with single compile/link step
>>   - launches with -kernel
>>   - drop .hex file
>> ---
>>  tests/tcg/arm/Makefile.softmmu-target |  29 +++++
>>  tests/tcg/arm/test-armv6m-undef.S     | 154 ++++++++++++++++++++++++++
>>  tests/tcg/arm/test-armv6m-undef.ld    |  21 ++++
>>  3 files changed, 204 insertions(+)
>>  create mode 100644 tests/tcg/arm/Makefile.softmmu-target
>>  create mode 100644 tests/tcg/arm/test-armv6m-undef.S
>>  create mode 100644 tests/tcg/arm/test-armv6m-undef.ld
>>
>> diff --git a/tests/tcg/arm/Makefile.softmmu-target b/tests/tcg/arm/Makef=
ile.softmmu-target
>> new file mode 100644
>> index 0000000000..49d48d8a1c
>> --- /dev/null
>> +++ b/tests/tcg/arm/Makefile.softmmu-target
>> @@ -0,0 +1,29 @@
>> +# -*- Mode: makefile -*-
>> +#
>> +# ARM SoftMMU tests - included from tests/tcg/Makefile
>> +#
>> +
>> +ifeq ($(TARGET_ABI_DIR),arm)
>> +
>> +ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
>> +
>> +# Set search path for all sources
>> +VPATH 		+=3D $(ARM_SRC)
>> +
>> +ARM_TESTS=3Dtest-armv6m-undef
>> +
>> +TESTS +=3D $(ARM_TESTS)
>> +
>> +CFLAGS+=3D-Wl,--build-id=3Dnone -x assembler-with-cpp
>> +LDFLAGS+=3D-nostdlib -N -static
>> +
>> +%: %.S %.ld
>> +	$(CC) $(CFLAGS) $(ASFLAGS) $< -o $@ $(LDFLAGS) -T $(ARM_SRC)/$@.ld
>> +
>> +# Specific Test Rules
>> +
>> +test-armv6m-undef: EXTRA_CFLAGS+=3D-mcpu=3Dcortex-m0
>> +
>> +run-test-armv6m-undef: QEMU_OPTS+=3D-semihosting -M microbit -kernel
>> +
>> +endif
>> diff --git a/tests/tcg/arm/test-armv6m-undef.S b/tests/tcg/arm/test-armv=
6m-undef.S
>> new file mode 100644
>> index 0000000000..d18ca56b4a
>> --- /dev/null
>> +++ b/tests/tcg/arm/test-armv6m-undef.S
>> @@ -0,0 +1,154 @@
>> +/*
>> + * Test ARMv6-M UNDEFINED 32-bit instructions
>> + *
>> + * Copyright 2018 Red Hat Inc.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2
>> + * or later. See the COPYING file in the top-level directory.
>> + */
>> +
>> +/*
>> + * Test that UNDEFINED 32-bit instructions fault as expected.  This is =
an
>> + * interesting test because ARMv6-M shares code with its more fully-fea=
tured
>> + * siblings and it's necessary to verify that its limited instruction s=
et is
>> + * emulated correctly.
>> + *
>> + * The emulator must be invoked with -semihosting so that the test case=
 can
>> + * terminate with exit code 0 on success or 1 on failure.
>> + *
>> + * Failures can be debugged with -d in_asm,int,exec,cpu and the
>> + * gdbstub (-S -s).
>> + */
>> +
>> +.syntax unified
>> +.cpu cortex-m0
>> +.thumb
>> +
>> +/*
>> + * Memory map
>> + */
>> +#define SRAM_BASE 0x20000000
>> +#define SRAM_SIZE (16 * 1024)
>> +
>> +/*
>> + * Semihosting interface on ARM T32
>> + * See "Semihosting for AArch32 and AArch64 Version 2.0 Documentation" =
by ARM
>> + */
>> +#define semihosting_call bkpt 0xab
>> +#define SYS_EXIT 0x18
>> +
>> +vector_table:
>> +    .word SRAM_BASE + SRAM_SIZE /* 0. SP_main */
>> +    .word exc_reset_thumb       /* 1. Reset */
>> +    .word 0                     /* 2. NMI */
>> +    .word exc_hard_fault_thumb  /* 3. HardFault */
>> +    .rept 7
>> +    .word 0                     /* 4-10. Reserved */
>> +    .endr
>> +    .word 0                     /* 11. SVCall */
>> +    .word 0                     /* 12. Reserved */
>> +    .word 0                     /* 13. Reserved */
>> +    .word 0                     /* 14. PendSV */
>> +    .word 0                     /* 15. SysTick */
>> +    .rept 32
>> +    .word 0                     /* 16-47. External Interrupts */
>> +    .endr
>> +
>> +exc_reset:
>> +.equ exc_reset_thumb, exc_reset + 1
>> +.global exc_reset_thumb
>> +    /* The following 32-bit UNDEFINED instructions are tested by execut=
ing
>> +     * them.  The HardFault exception handler should execute and return=
 to
>> +     * the next test case.  If no exception is raised the test fails.
>> +     */
>> +
>> +    /* Table A5-9 32-bit Thumb encoding */
>> +    .short 0b1110100000000000
>> +    .short 0b0000000000000000
>> +    b not_reached
>> +    .short 0b1110100000000000
>> +    .short 0b1000000000000000
>> +    b not_reached
>> +    .short 0b1111100000000000
>> +    .short 0b0000000000000000
>> +    b not_reached
>> +    .short 0b1111100000000000
>> +    .short 0b1000000000000000
>> +    b not_reached
>> +    .short 0b1111000000000000
>> +    .short 0b0000000000000000
>> +    b not_reached
>> +
>> +    /* Table A5-10 Branch and miscellaneous control instructions */
>> +    .short 0b1111011111110000
>> +    .short 0b1010000000000000
>> +    b not_reached
>> +
>> +    /* The following are valid 32-bit instructions that must not raise a
>> +     * HardFault.
>> +     */
>> +
>> +    /* B4.2.3 Move to Special Register (moves to IPSR are ignored) */
>> +    msr ipsr, r0
>> +    b 1f
>> +    b not_reached
>> +1:
>> +    /* B4.2.2 Move from Special Register */
>> +    mrs r0, ipsr
>> +    b 1f
>> +    b not_reached
>> +1:
>> +    /* A6.7.13 Branch with Link (immediate) */
>> +    bl 1f
>> +1:
>> +    b 1f
>> +    b not_reached
>> +1:
>> +    /* A6.7.21 Data Memory Barrier */
>> +    dmb
>> +    b 1f
>> +    b not_reached
>> +1:
>> +    /* A6.7.22 Data Synchronization Barrier */
>> +    dsb
>> +    b 1f
>> +    b not_reached
>> +1:
>> +    /* A6.7.24 Instruction Memory Barrier */
>> +    isb
>> +    b 1f
>> +    b not_reached
>> +1:
>> +
>> +    /* Success! */
>> +    movs r0, 1
>> +    b exit
>> +
>> +not_reached: /* Failure :( */
>> +    movs r0, 0
>> +    b exit
>> +
>> +/* When a HardFault occurs, return to pc+6 (test cases are 3 halfwords =
long) */
>> +exc_hard_fault:
>> +.equ exc_hard_fault_thumb, exc_hard_fault + 1
>> +.global exc_hard_fault_thumb
>> +    ldr r0, [sp, 0x18]
>> +    adds r0, 6
>> +    str r0, [sp, 0x18]
>> +    bx lr
>> +
>> +/*
>> + * exit: Terminate emulator
>> + * @r0: 0 - failure, 1 - success
>> + */
>> +exit:
>> +    movs r1, 0
>> +    cmp r0, 1
>> +    bne 1f
>> +    ldr r1, ADP_Stopped_ApplicationExit
>> +1:
>> +    movs r0, SYS_EXIT
>> +    semihosting_call
>> +.align 2
>> +ADP_Stopped_ApplicationExit:
>> +    .word 0x20026
>> diff --git a/tests/tcg/arm/test-armv6m-undef.ld b/tests/tcg/arm/test-arm=
v6m-undef.ld
>> new file mode 100644
>> index 0000000000..43dbbf17d5
>> --- /dev/null
>> +++ b/tests/tcg/arm/test-armv6m-undef.ld
>> @@ -0,0 +1,21 @@
>> +ENTRY(exc_reset_thumb)
>> +
>> +SECTIONS
>> +{
>> +    . =3D 0x0;
>> +    .text : {
>> +        *(.text)
>> +    }
>> +    .data : {
>> +        *(.data)
>> +    }
>> +    .rodata : {
>> +        *(.rodata)
>> +    }
>> +    .bss : {
>> +        *(.bss)
>> +    }
>> +    /DISCARD/ : {
>> +        *(.ARM.attributes)
>> +    }
>> +}
>>


--
Alex Benn=C3=A9e
