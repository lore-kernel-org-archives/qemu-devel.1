Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1elHwX-0000Aw-Iw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1elHwV-0002hX-O9
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1elHwV-0002gC-IQ
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:03 -0500
Date: Mon, 12 Feb 2018 18:31:00 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180212173100.wmt2ouak6b3thnxd@kamzik.brq.redhat.com>
References: <1518212562-21606-1-git-send-email-wei@redhat.com>
	<1518212562-21606-2-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518212562-21606-2-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2 1/1] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, quintela@redhat.com

On Fri, Feb 09, 2018 at 04:42:42PM -0500, Wei Huang wrote:
> This patch adds migration test support for aarch64. The test code, which
> implements the same functionality as x86, is booted as a kernel in qemu.
> Here are the design choices we make for aarch64:
> 
>  * We choose this -kernel approach because aarch64 QEMU doesn't provide a
>    built-in fw like x86 does. So instead of relying on a boot loader, we
>    use -kernel approach for aarch64.
>  * The serial output is sent to PL011 directly.
>  * The physical memory base for mach-virt machine is 0x40000000. We change
>    the start_address and end_address for aarch64.
> 
> In addition to providing the binary, this patch also includes the test source
> and the build script in tests/migration. So users can change/re-compile
> the binary as they wish.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/Makefile.include                    |  1 +
>  tests/migration-test.c                    | 29 ++++++++++---
>  tests/migration/aarch64-a-b-kernel.h      | 19 +++++++++
>  tests/migration/aarch64-a-b-kernel.s      | 67 +++++++++++++++++++++++++++++++
>  tests/migration/rebuild-aarch64-kernel.sh | 67 +++++++++++++++++++++++++++++++
>  5 files changed, 177 insertions(+), 6 deletions(-)
>  create mode 100644 tests/migration/aarch64-a-b-kernel.h
>  create mode 100644 tests/migration/aarch64-a-b-kernel.s
>  create mode 100755 tests/migration/rebuild-aarch64-kernel.sh
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f41da23..0fd18fd 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -369,6 +369,7 @@ gcov-files-arm-y += hw/timer/arm_mptimer.c
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>  
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 85d4014..b16944c 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -22,8 +22,8 @@
>  
>  #define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
>  
> -const unsigned start_address = 1024 * 1024;
> -const unsigned end_address = 100 * 1024 * 1024;
> +unsigned start_address = 1024 * 1024;
> +unsigned end_address = 100 * 1024 * 1024;
>  bool got_stop;
>  
>  #if defined(__linux__)
> @@ -80,12 +80,13 @@ static const char *tmpfs;
>   * outputing a 'B' every so often if it's still running.
>   */
>  #include "tests/migration/x86-a-b-bootblock.h"
> +#include "tests/migration/aarch64-a-b-kernel.h"
>  
> -static void init_bootfile_x86(const char *bootpath)
> +static void init_bootfile(const char *bootpath, void *content)
>  {
>      FILE *bootfile = fopen(bootpath, "wb");
>  
> -    g_assert_cmpint(fwrite(x86_bootsect, 512, 1, bootfile), ==, 1);
> +    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
>      fclose(bootfile);
>  }
>  
> @@ -391,7 +392,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>      got_stop = false;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        init_bootfile_x86(bootpath);
> +        init_bootfile(bootpath, x86_bootsect);
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
> @@ -420,6 +421,22 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>                                    " -serial file:%s/dest_serial"
>                                    " -incoming %s",
>                                    accel, tmpfs, uri);
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        init_bootfile(bootpath, aarch64_kernel);
> +        cmd_src = g_strdup_printf("-machine virt,accel=kvm:tcg -m 150M "
> +                                  "-name vmsource,debug-threads=on -cpu host "

We can't use '-cpu host' with tcg, so the accel fallback won't work.

> +                                  "-serial file:%s/src_serial "
> +                                  "-kernel %s ",
> +                                  tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine virt,accel=kvm:tcg -m 150M "
> +                                  "-name vmdest,debug-threads=on -cpu host "
> +                                  "-serial file:%s/dest_serial "
> +                                  "-kernel %s "
> +                                  "-incoming %s ",
> +                                  tmpfs, bootpath, uri);
> +        /* aarch64 virt machine physical mem started from 0x40000000 */

s/mem started from/memory starts at/

> +        start_address += 0x40000000;
> +        end_address += 0x40000000;

Why is end_address == start_address?

>      } else {
>          g_assert_not_reached();
>      }
> @@ -501,7 +518,7 @@ static void test_deprecated(void)
>  {
>      QTestState *from;
>  
> -    from = qtest_start("");
> +    from = qtest_start("-machine none");
>  
>      deprecated_set_downtime(from, 0.12345);
>      deprecated_set_speed(from, "12345");
> diff --git a/tests/migration/aarch64-a-b-kernel.h b/tests/migration/aarch64-a-b-kernel.h
> new file mode 100644
> index 0000000..5bdc74b
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.h
> @@ -0,0 +1,19 @@
> +/* This file is automatically generated from
> + * tests/migration/aarch64-a-b-kernel.s, edit that and then run
> + * tests/migration/rebuild-aarch64-kernel.sh to update, and then
> + * remember to send both in your patch submission.
> + */
> +unsigned char aarch64_kernel[] = {
> +  0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
> +  0xdf, 0x3f, 0x03, 0xd5, 0x24, 0x08, 0x80, 0x52, 0x05, 0x20, 0xa1, 0xd2,
> +  0xa4, 0x00, 0x00, 0x39, 0x06, 0x00, 0x80, 0x52, 0x03, 0xc8, 0xa8, 0xd2,
> +  0x02, 0x02, 0xa8, 0xd2, 0x01, 0x00, 0x80, 0x52, 0x41, 0x00, 0x00, 0x39,
> +  0x42, 0x04, 0x40, 0x91, 0x5f, 0x00, 0x03, 0xeb, 0xad, 0xff, 0xff, 0x54,
> +  0x02, 0x02, 0xa8, 0xd2, 0x22, 0x7e, 0x0b, 0xd5, 0x41, 0x00, 0x40, 0x39,
> +  0x21, 0x04, 0x00, 0x11, 0x21, 0x1c, 0x00, 0x12, 0x41, 0x00, 0x00, 0x39,
> +  0x42, 0x04, 0x40, 0x91, 0x5f, 0x00, 0x03, 0xeb, 0x2b, 0xff, 0xff, 0x54,
> +  0xc6, 0x04, 0x00, 0x11, 0xc6, 0x1c, 0x00, 0x12, 0xdf, 0x00, 0x00, 0x71,
> +  0x81, 0xfe, 0xff, 0x54, 0x44, 0x08, 0x80, 0x52, 0x05, 0x20, 0xa1, 0xd2,
> +  0xa4, 0x00, 0x00, 0x39, 0xf0, 0xff, 0xff, 0x97
> +};
> +
> diff --git a/tests/migration/aarch64-a-b-kernel.s b/tests/migration/aarch64-a-b-kernel.s
> new file mode 100644
> index 0000000..bc20c81
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.s
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> +#
> +# Authors:
> +#   Wei Huang <wei@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +.section .text
> +
> +        .globl  start
> +
> +start:
> +        /* disable MMU to use phys mem address */
> +        mrs     x0, sctlr_el1
> +        bic     x0, x0, #(1<<0)
> +        msr     sctlr_el1, x0
> +        isb

The MMU is always initially off, so this isn't really necessary, but OK.

> +
> +        /* output char 'A' to PL011 */
> +        mov     w4, #65
> +        mov     x5, #0x9000000
> +        strb    w4, [x5]
> +
> +        /* w6 keeps a counter so we can limit the output speed */
> +        mov     w6, #0
> +
> +        /* phys mem base addr = 0x40000000 */
> +        mov     x3, #(0x40000000 + 100 *1024*1024) /* traverse 1M-100M */
> +        mov     x2, #(0x40000000 + 1 * 1024*1024)

How about creating a tests include file that contains this memory base
address so we don't have to scatter it around too many files? We can
throw in other defines too.

 tests/arm-mach-virt.h:
 #define ARM_MACH_VIRT_UART      0x09000000
 #define ARM_MACH_VIRT_PHYS_BASE 0x40000000
 #define ARM_MACH_VIRT_A_B_START 0x40000000
 #define ARM_MACH_VIRT_A_B_END   (0x40000000 * 100)

> +
> +        /* clean up memory first */
> +        mov     w1, #0
> +clean:
> +        strb    w1, [x2]
> +        add     x2, x2, #(4096)
> +        cmp     x2, x3
> +        ble     clean

Why are we only clearing the first byte of each 4K chunk? Anyway QEMU
always gives us clean memory, so this isn't really necessary.

> +
> +        /* main body */
> +mainloop:
> +        mov     x2, #(0x40000000 + 1 * 1024*1024)

nit: This reassignment of x2 would be unnecessary if you copied x2 into
     a scratch register (x7) prior to the clean loop, and then used the
     scratch register there. It's the same number of instructions, but
     less hard coded constants floating around.

> +
> +innerloop:
> +        /* clean cache because el2 might still cache guest data under KVM */
> +        dc      civac, x2

Blank line here and a comment introducing the next block would be nice.

> +        ldrb    w1, [x2]
> +        add     w1, w1, #1
> +        and     w1, w1, #(0xff)
> +        strb    w1, [x2]
> +
> +        add     x2, x2, #(4096)
> +        cmp     x2, x3
> +        blt     innerloop

OK, I guess we only care about the first byte of each 4K chunk.

> +
> +        add     w6, w6, #1
> +        and     w6, w6, #(0xff)
> +        cmp     w6, #0
> +        bne     mainloop

So we limit the output speed by doing the write loop 256 times? How was
the number 256 selected? If we want to delay the outputs we can use the
timer counter to ensure we only output every N us. I pulled together
some code that implements a 100 us delay:

 	mrs	x0, cntfrq_el0
 	mov	x1, #10000
 	udiv	x1, x0, x1
 	mrs	x0, cntvct_el0
 	add	x0, x0, x1
 1:	isb
 	mrs	x1, cntvct_el0
 	subs	x1, x0, x1
	b.gt	1b

> +
> +        /* output char 'B' to PL011 */
> +        mov     w4, #66
> +        mov     x5, #0x9000000

You never overwrote x5, so you don't need to rewrite the uart addr here.

> +        strb    w4, [x5]
> +
> +        bl      mainloop
> diff --git a/tests/migration/rebuild-aarch64-kernel.sh b/tests/migration/rebuild-aarch64-kernel.sh
> new file mode 100755
> index 0000000..0fbca99
> --- /dev/null
> +++ b/tests/migration/rebuild-aarch64-kernel.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> +#
> +# Authors:
> +#   Wei Huang <wei@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +ASMFILE=tests/migration/aarch64-a-b-kernel.s
> +HEADER=tests/migration/aarch64-a-b-kernel.h
> +
> +if [ ! -e "$ASMFILE" ]
> +then
> +  echo "Couldn't find $ASMFILE" >&2
> +  exit 1
> +fi
> +
> +ASM_WORK_DIR=/tmp/AARCH64BB$$

Same mktemp comment as in David's patch.

> +
> +mkdir $ASM_WORK_DIR &&
> +cat <<EOF > "$ASM_WORK_DIR/linker.lds" &&
> +SECTIONS
> +{
> +    .text : { *(.init) *(.text) *(.text.*) }
> +    . = ALIGN(64K);
> +    etext = .;
> +    .data : {
> +        *(.data)
> +    }
> +    . = ALIGN(16);
> +    .rodata : { *(.rodata) }
> +    . = ALIGN(16);
> +    .bss : { *(.bss) }
> +    . = ALIGN(64K);
> +    edata = .;
> +    . += 64K;
> +    . = ALIGN(64K);
> +    /*
> +     * stack depth is 16K for arm and PAGE_SIZE for arm64, see THREAD_SIZE
> +     * sp must be 16 byte aligned for arm64, and 8 byte aligned for arm
> +     * sp must always be strictly less than the true stacktop
> +     */
> +    stackptr = . - 16;
> +    stacktop = .;
> +}
> +ENTRY(start)
> +EOF
> +as -march="armv8-a" -c "$ASMFILE" -o $ASM_WORK_DIR/kernel.o &&
> +gcc -O2 -o $ASM_WORK_DIR/kernel.elf -nostdlib \
> +    -Wl,-T,$ASM_WORK_DIR/linker.lds,--build-id=none,-Ttext=40080000 \
> +    $ASM_WORK_DIR/kernel.o &&

You don't need the above linker script nor the 'as' line. Just do

 gcc -o $ASM_WORK_DIR/kernel.elf \
     -nostdlib -Wl,--build-id=none,-Ttext=40080000 $ASMFILE

> +objcopy -O binary $ASM_WORK_DIR/kernel.elf $ASM_WORK_DIR/kernel.flat &&

Shouldn't gcc and objcopy have a $CROSS_COMPILER prefix variable
prepended? Does the QEMU test build environment support cross
compiling? Can this script get build environment variables some how?

> +xxd -i $ASM_WORK_DIR/kernel.flat |
> +sed -e 's/_tmp.*_kernel_flat/aarch64_kernel/' -e 's/.*int.*//' > \
> +  $ASM_WORK_DIR/kernel.hex &&
> +cat - $ASM_WORK_DIR/kernel.hex <<EOF > "$HEADER"
> +/* This file is automatically generated from
> + * tests/migration/aarch64-a-b-kernel.s, edit that and then run
> + * tests/migration/rebuild-aarch64-kernel.sh to update, and then
> + * remember to send both in your patch submission.
> + */
> +EOF
> +
> +rm $ASM_WORK_DIR/kernel.hex $ASM_WORK_DIR/kernel.flat \
> +    $ASM_WORK_DIR/kernel.elf $ASM_WORK_DIR/kernel.o $ASM_WORK_DIR/linker.lds
> +rmdir $ASM_WORK_DIR
> -- 
> 1.8.3.1
> 
>

Thanks,
drew 
