Received: from eggs.gnu.org ([2001:4830:134:3::10]:35208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1evPaW-00013b-KP
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1evPZv-0003MR-Bg
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:42:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1evPZu-0003J9-OU
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 11:41:35 -0400
Date: Mon, 12 Mar 2018 16:41:21 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180312154121.c23neo6zvwhfebxt@kamzik.brq.redhat.com>
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-5-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228180215.25470-5-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V7 4/4] tests: Add migration test for
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peter.maydell@linaro.org, quintela@redhat.com

On Wed, Feb 28, 2018 at 12:02:15PM -0600, Wei Huang wrote:
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
>  tests/migration-test.c               | 44 +++++++++++++++++++--
>  tests/migration/Makefile             | 12 +++++-
>  tests/migration/aarch64-a-b-kernel.S | 75 ++++++++++++++++++++++++++++++++++++
>  tests/migration/aarch64-a-b-kernel.h | 19 +++++++++
>  tests/migration/migration-test.h     |  9 +++++
>  6 files changed, 154 insertions(+), 6 deletions(-)
>  create mode 100644 tests/migration/aarch64-a-b-kernel.S
>  create mode 100644 tests/migration/aarch64-a-b-kernel.h
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 577eb573a2..538173866c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -372,6 +372,7 @@ check-qtest-arm-y += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/sdhci-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>  
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 12c04a9648..ff424330a1 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include <sys/utsname.h>
>  
>  #include "libqtest.h"
>  #include "qapi/qmp/qdict.h"
> @@ -81,12 +82,13 @@ static const char *tmpfs;
>   * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
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
> @@ -392,7 +394,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>      got_stop = false;
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> -        init_bootfile_x86(bootpath);
> +        init_bootfile(bootpath, x86_bootsect);
>          cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
>                                    " -name source,debug-threads=on"
>                                    " -serial file:%s/src_serial"
> @@ -427,6 +429,40 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>  
>          start_address = PPC_TEST_MEM_START;
>          end_address = PPC_TEST_MEM_END;
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        const char *cpu;
> +        const char *gic_ver;
> +        struct utsname utsname;
> +
> +        /* kvm and tcg need different cpu and gic-version configs */
> +        if (access("/dev/kvm", F_OK) == 0 && uname(&utsname) == 0 &&
> +            strcmp(utsname.machine, "aarch64") == 0) {
> +            accel = "kvm";
> +            cpu = "host";
> +            gic_ver = "host";
> +        } else {
> +            accel = "tcg";
> +            cpu = "cortex-a57";
> +            gic_ver = "2";
> +        }
> +
> +        init_bootfile(bootpath, aarch64_kernel);
> +        cmd_src = g_strdup_printf("-machine virt,accel=%s,gic-version=%s "
> +                                  "-name vmsource,debug-threads=on -cpu %s "
> +                                  "-m 150M -serial file:%s/src_serial "
> +                                  "-kernel %s ",
> +                                  accel, gic_ver, cpu, tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine virt,accel=%s,gic-version=%s "
> +                                  "-name vmdest,debug-threads=on -cpu %s "
> +                                  "-m 150M -serial file:%s/dest_serial "
> +                                  "-kernel %s "
> +                                  "-incoming %s ",
> +                                  accel, gic_ver, cpu, tmpfs, bootpath, uri);

I know I'm the one that pointed out the need for uname() and
gic-version=host, but that was before '-cpu max' was introduced. The above
if-else could now be removed and the command line changed to have
'-machine virt,accel=kvm:tcg,gic-version=max -cpu max' instead. We'll
end up with gic-version=3 for TCG instead of 2, but that shouldn't matter.

Anyway, I won't insist on the change, as the above also works fine, but
I thought I'd point out this potential '-cpu max' use here.

Thanks,
drew

> +
> +        start_address = ARM_TEST_MEM_START;
> +        end_address = ARM_TEST_MEM_END;
> +
> +        g_assert(sizeof(aarch64_kernel) <= ARM_TEST_MAX_KERNEL_SIZE);
>      } else {
>          g_assert_not_reached();
>      }
> @@ -511,7 +547,7 @@ static void test_deprecated(void)
>  {
>      QTestState *from;
>  
> -    from = qtest_start("");
> +    from = qtest_start("-machine none");
>  
>      deprecated_set_downtime(from, 0.12345);
>      deprecated_set_speed(from, "12345");
> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> index 013b8d1f44..1324427a93 100644
> --- a/tests/migration/Makefile
> +++ b/tests/migration/Makefile
> @@ -16,7 +16,7 @@ override define __note
>   */
>  endef
>  
> -all: x86-a-b-bootblock.h
> +all: x86-a-b-bootblock.h aarch64-a-b-kernel.h
>  # Dummy command so that make thinks it has done something
>  	@true
>  
> @@ -24,6 +24,7 @@ SRC_PATH=../..
>  include $(SRC_PATH)/rules.mak
>  
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> +aarch64_cross_prefix := $(call find-cross-prefix,aarch64)
>  
>  x86-a-b-bootblock.h: x86-a-b-bootblock.S
>  	$(x86_64_cross_prefix)gcc -m32 -march=i486 -c $< -o x86.o
> @@ -32,5 +33,12 @@ x86-a-b-bootblock.h: x86-a-b-bootblock.S
>  	echo "$$__note" > $@
>  	xxd -i x86.bootsect | sed -e 's/.*int.*//' >> $@
>  
> +aarch64-a-b-kernel.h: aarch64-a-b-kernel.S
> +	$(aarch64_cross_prefix)gcc -o aarch64.elf -nostdlib \
> +		-Wl,--build-id=none $<
> +	$(aarch64_cross_prefix)objcopy -O binary aarch64.elf aarch64.kernel
> +	echo "$$__note" > $@
> +	xxd -i aarch64.kernel | sed -e 's/.*int.*//' >> $@
> +
>  clean:
> -	rm -f *.bootsect *.boot *.o
> +	rm -f *.bootsect *.boot *.o *.elf *.kernel
> diff --git a/tests/migration/aarch64-a-b-kernel.S b/tests/migration/aarch64-a-b-kernel.S
> new file mode 100644
> index 0000000000..eec8f44f16
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.S
> @@ -0,0 +1,75 @@
> +#
> +# Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> +#
> +# Author:
> +#   Wei Huang <wei@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
> +# See the COPYING file in the top-level directory.
> +#
> +# Note: Please make sure the compiler compiles the assembly code below with
> +# pc-relative address. Also the branch instructions should use relative
> +# addresses only.
> +
> +#include "migration-test.h"
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
> +        /* traverse test memory region */
> +        mov     x0, #ARM_TEST_MEM_START
> +        mov     x1, #ARM_TEST_MEM_END
> +
> +        /* output char 'A' to PL011 */
> +        mov     w3, 'A'
> +        mov     x2, #ARM_MACH_VIRT_UART
> +        strb    w3, [x2]
> +
> +        /* clean up memory */
> +        mov     w3, #0
> +        mov     x4, x0
> +clean:
> +        strb    w3, [x4]
> +        add     x4, x4, #TEST_MEM_PAGE_SIZE
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
> +        /* increment the first byte of each page by 1 */
> +        ldrb    w3, [x4]
> +        add     w3, w3, #1
> +        and     w3, w3, #0xff
> +        strb    w3, [x4]
> +
> +        add     x4, x4, #TEST_MEM_PAGE_SIZE
> +        cmp     x4, x1
> +        blt     innerloop
> +
> +        add     w5, w5, #1
> +        and     w5, w5, #0xff
> +        cmp     w5, #0
> +        bne     mainloop
> +
> +        /* output char 'B' to PL011 */
> +        mov     w3, 'B'
> +        strb    w3, [x2]
> +
> +        b       mainloop
> diff --git a/tests/migration/aarch64-a-b-kernel.h b/tests/migration/aarch64-a-b-kernel.h
> new file mode 100644
> index 0000000000..53b44d3e99
> --- /dev/null
> +++ b/tests/migration/aarch64-a-b-kernel.h
> @@ -0,0 +1,19 @@
> +/* This file is automatically generated from
> + * tests/migration/aarch64-a-b-kernel.S, edit that and then run
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
> +  0x43, 0x00, 0x00, 0x39, 0xf1, 0xff, 0xff, 0x17
> +};
> +
> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> index 06c46a2fe0..a55b74c98c 100644
> --- a/tests/migration/migration-test.h
> +++ b/tests/migration/migration-test.h
> @@ -19,4 +19,13 @@
>  #define PPC_TEST_MEM_END   (100 * 1024 * 1024)
>  #define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
>  
> +/* ARM */
> +#define ARM_TEST_MEM_START (0x40000000 + 1 * 1024 * 1024)
> +#define ARM_TEST_MEM_END   (0x40000000 + 100 * 1024 * 1024)
> +#define ARM_MACH_VIRT_UART 0x09000000
> +/* AArch64 kernel load address is 0x40080000, and the test memory starts at
> + * 0x40100000. So the maximum allowable kernel size is 512KB.
> + */
> +#define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
> +
>  #endif /* _TEST_MIGRATION_H_ */
> -- 
> 2.14.3
> 
