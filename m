Received: from eggs.gnu.org ([2001:4830:134:3::10]:48839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1emGUP-00065P-OY
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:10:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1emGUK-0001uy-Om
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:10:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48892 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1emGUK-0001uq-Hd
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 05:10:00 -0500
Date: Thu, 15 Feb 2018 11:09:57 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180215100957.3rn67i7fhg7vm4ds@kamzik.brq.redhat.com>
References: <1518674845-6517-1-git-send-email-wei@redhat.com>
	<1518674845-6517-3-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518674845-6517-3-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V3 2/2] tests: Add migration test for
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

On Thu, Feb 15, 2018 at 01:07:25AM -0500, Wei Huang wrote:
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
> In addition to providing the binary, this patch also includes the source
> code and the build script in tests/migration/. So users can change the
> source and/or re-compile the binary as they wish.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/Makefile.include               |  1 +
>  tests/migration-test.c               | 39 ++++++++++++++++---
>  tests/migration/Makefile             | 12 +++++-
>  tests/migration/aarch64-a-b-kernel.h | 19 +++++++++
>  tests/migration/aarch64-a-b-kernel.s | 74 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 137 insertions(+), 8 deletions(-)
>  create mode 100644 tests/migration/aarch64-a-b-kernel.h
>  create mode 100644 tests/migration/aarch64-a-b-kernel.s
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 278c13a..5b1605a 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -372,6 +372,7 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>  
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 97fdb19..0b6ab5c 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -23,8 +23,8 @@
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
> @@ -81,12 +81,13 @@ static const char *tmpfs;
>   * outputting a 'B' every so often if it's still running.
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
> @@ -392,7 +393,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>      got_stop = false;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        init_bootfile_x86(bootpath);
> +        init_bootfile(bootpath, x86_bootsect);
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
> @@ -421,6 +422,32 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>                                    " -serial file:%s/dest_serial"
>                                    " -incoming %s",
>                                    accel, tmpfs, uri);
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        const char *cpu;
> +
> +        if (access("/dev/kvm", F_OK)) {
> +            accel = "kvm";
> +            cpu = "host";

This won't work. I have /dev/kvm on my x86 notebook, but I can't
run aarch64 kvm guests there. You also need to check if the host
is aarch64. You can do that with uname(3), checking uname.machine.

> +        } else {
> +            accel = "tcg";
> +            cpu = "cortex-a57";
> +        }
> +
> +        init_bootfile(bootpath, aarch64_kernel);
> +        cmd_src = g_strdup_printf("-machine virt,accel=%s -m 150M "

You should also add ,gic-version=%s, where %s is either 'host' when kvm
is in use, or 2 or 3 (whichever) when tcg is in use.

> +                                  "-name vmsource,debug-threads=on -cpu %s "
> +                                  "-serial file:%s/src_serial "
> +                                  "-kernel %s ",
> +                                  accel, cpu, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine virt,accel=%s -m 150M "
> +                                  "-name vmdest,debug-threads=on -cpu %s "
> +                                  "-serial file:%s/dest_serial "
> +                                  "-kernel %s "
> +                                  "-incoming %s ",
> +                                  accel, cpu, tmpfs, bootpath, uri);
> +        /* aarch64 virt machine physical memory starts at 0x40000000 */
> +        start_address += 0x40000000;
> +        end_address += 0x40000000;
>      } else {
>          g_assert_not_reached();
>      }
> @@ -502,7 +529,7 @@ static void test_deprecated(void)
>  {
>      QTestState *from;
>  
> -    from = qtest_start("");
> +    from = qtest_start("-machine none");
>  
>      deprecated_set_downtime(from, 0.12345);
>      deprecated_set_speed(from, "12345");
> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> index e8e6026..00f854b 100644
> --- a/tests/migration/Makefile
> +++ b/tests/migration/Makefile
> @@ -15,6 +15,7 @@ cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call cross-ld,$(1)))))
>  find-cross-prefix = $(subst gcc,,$(notdir $(call cross-gcc,$(1))))
>  
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> +aarch64_cross_prefix := $(call find-cross-prefix,aarch64)
>  
>  export __note
>  override define __note
> @@ -25,7 +26,7 @@ override define __note
>   */
>  endef
>  
> -all: x86-a-b-bootblock.h
> +all: x86-a-b-bootblock.h aarch64-a-b-kernel.h
>  
>  x86-a-b-bootblock.h: x86-a-b-bootblock.s
>  	$(x86_64_cross_prefix)as --32 -march=i486 $< -o x86.o
> @@ -34,5 +35,12 @@ x86-a-b-bootblock.h: x86-a-b-bootblock.s
>  	echo "$$__note" > $@
>  	xxd -i x86.bootsect | sed -e 's/.*int.*//' >> $@
>  
> +aarch64-a-b-kernel.h: aarch64-a-b-kernel.s
> +	$(aarch64_cross_prefix)gcc -o aarch64.elf -nostdlib \
> +		-Wl,--build-id=none,-Ttext=40080000 $<
> +	$(aarch64_cross_prefix)objcopy -O binary aarch64.elf aarch64.kernel
> +	echo "$$__note" > $@
> +	xxd -i aarch64.kernel | sed -e 's/.*int.*//' >> $@
> +
>  clean:
> -	rm -rf *.bootsect *.boot *.o
> +	rm -rf *.bootsect *.boot *.o *.elf *.kernel

I'm not sure you want the '-r' in this 'rm'.

> diff --git a/tests/migration/aarch64-a-b-kernel.h b/tests/migration/aarch64-a-b-kernel.h
> new file mode 100644
> index 0000000..d294cf8
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.h
> @@ -0,0 +1,19 @@
> +/* This file is automatically generated from
> + * tests/migration/aarch64-a-b-kernel.s, edit that and then run
> + * "make aarch64-a-b-kernel.h" inside tests/migration to update,
> + * and then remember to send both in your patch submission.
> + */
> +unsigned char aarch64_kernel[] = {
> +  0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
> +  0xdf, 0x3f, 0x03, 0xd5, 0x00, 0x02, 0xa8, 0xd2, 0x01, 0xc8, 0xa8, 0xd2,
> +  0x23, 0x08, 0x80, 0x52, 0x02, 0x20, 0xa1, 0xd2, 0x43, 0x00, 0x00, 0x39,
> +  0x03, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x83, 0x00, 0x00, 0x39,
> +  0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb, 0xad, 0xff, 0xff, 0x54,
> +  0x05, 0x00, 0x80, 0x52, 0xe4, 0x03, 0x00, 0xaa, 0x24, 0x7e, 0x0b, 0xd5,
> +  0x83, 0x00, 0x40, 0x39, 0x63, 0x04, 0x00, 0x11, 0x63, 0x1c, 0x00, 0x12,
> +  0x83, 0x00, 0x00, 0x39, 0x84, 0x04, 0x40, 0x91, 0x9f, 0x00, 0x01, 0xeb,
> +  0x2b, 0xff, 0xff, 0x54, 0xa5, 0x04, 0x00, 0x11, 0xa5, 0x1c, 0x00, 0x12,
> +  0xbf, 0x00, 0x00, 0x71, 0x81, 0xfe, 0xff, 0x54, 0x43, 0x08, 0x80, 0x52,
> +  0x43, 0x00, 0x00, 0x39, 0xf1, 0xff, 0xff, 0x97
> +};
> +
> diff --git a/tests/migration/aarch64-a-b-kernel.s b/tests/migration/aarch64-a-b-kernel.s
> new file mode 100644
> index 0000000..713e7a8
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.s
> @@ -0,0 +1,74 @@
> +#
> +# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> +#
> +# Author:
> +#   Wei Huang <wei@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +
> +.set ARM_MACH_VIRT_UART, 0x09000000
> +.set ARM_MACH_VIRT_PHYS_BASE, 0x40000000
> +.set ARM_MACH_VIRT_A_B_START, (0x40000000 + 1*1024*1024)
> +.set ARM_MACH_VIRT_A_B_END, (0x40000000 + 100*1024*1024)

These make this file nicer, but it doesn't avoid scattering
0x40000000 in two instead of one new place. I was thinking
a header file that would be included by this file and 
tests/migration-test.c would be created.

> +
> +.section .text
> +
> +        .globl  _start
> +
> +_start:
> +        /* disable MMU to use phys mem address */
> +        mrs     x0, sctlr_el1
> +        bic     x0, x0, #(1<<0)
> +        msr     sctlr_el1, x0
> +        isb
> +
> +	/* traverse 1M-100M */
> +        mov     x0, ARM_MACH_VIRT_A_B_START
> +        mov     x1, ARM_MACH_VIRT_A_B_END
> +
> +        /* output char 'A' to PL011 */
> +        mov     w3, 'A'
> +        mov     x2, ARM_MACH_VIRT_UART
> +        strb    w3, [x2]
> +
> +        /* clean up memory */
> +        mov     w3, #0
> +        mov     x4, x0
> +clean:
> +        strb    w3, [x4]
> +        add     x4, x4, #(4096)
> +        cmp     x4, x1
> +        ble     clean
> +
> +        /* w5 keeps a counter so we can limit the output speed */
> +        mov     w5, #0
> +
> +        /* main body */
> +mainloop:
> +        mov     x4, x0
> +
> +innerloop:
> +        /* clean cache because el2 might still cache guest data under KVM */
> +        dc      civac, x4
> +
> +	/* increment the first byte of each 4KB page by 1 */
> +        ldrb    w3, [x4]
> +        add     w3, w3, #1
> +        and     w3, w3, #(0xff)
> +        strb    w3, [x4]
> +
> +        add     x4, x4, #(4096)
> +        cmp     x4, x1
> +        blt     innerloop
> +
> +        add     w5, w5, #1
> +        and     w5, w5, #(0xff)
> +        cmp     w5, #0
> +        bne     mainloop

nit: no need for the () in the immediates.

> +
> +        /* output char 'B' to PL011 */
> +        mov     w3, 'B'
> +        strb    w3, [x2]
> +
> +        bl      mainloop
> -- 
> 1.8.3.1
> 
>

Thanks,
drew 
