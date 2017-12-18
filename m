Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eQsHD-0004Py-UX
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eQsH7-0001C6-MK
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:04:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eQsH7-0001Bg-CY
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 05:03:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 741C54A6EB
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 10:03:56 +0000 (UTC)
Date: Mon, 18 Dec 2017 10:03:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171218100349.GB2440@work-vm>
References: <1513370232-25515-1-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1513370232-25515-1-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] tests: Add migration test for
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Wei Huang (wei@redhat.com) wrote:
> This patch adds the migration test support for aarch64. The test code,
> which implements the same functionality as x86, is compiled into a binary
> and booted as a kernel to qemu. Here are the design ideas:
> 
> * We choose this -kernel design because aarch64 QEMU doesn't provide a
>   built-in fw like x86 does. So instead of relying on a boot loader, we
>   use -kernel approach for aarch64.
> * The serial output is sent to PL011 directly.
> * The physical memory base for mach-virt machine is 0x40000000. We have
>   to change the start_address and end_address for aarch64.
> * The downtime is changed from 0.001 to 0.1. Without this change, we saw
>   migration stalled. This problem is still under analysis and needs to be
>   resolved before removing RFC for this patch.

Where does the stall happen and what state is it in?
That downtime is set really small so that migration does *not* complete
without entering postcopy, so you should see it enter postcopy and then
complete.

Dave

> The test code is as the following:
> 
> .section .text
> 
>         .globl  start
> 
> start:
>         /* disable MMU to use phys mem address, just in case */
>         mrs     x0, sctlr_el1
>         bic     x0, x0, #(1<<0)
>         msr     sctlr_el1, x0
>         isb
> 
>         /* output char 'A' to PL011 */
>         mov     w4, #65
>         mov     x5, #0x9000000
>         strb    w4, [x5]
> 
>         /* w6 keeps a counter so we limit the output speed */
>         mov     w6, #0
> 
>         mov     x3, #(0x40000000 + 100 * 1024 * 1024)
> mainloop:
>         mov     x2, #(0x40000000 + 1024*1024) /* base addr = 0x40000000 */
> 
> innerloop:
>         ldrb    w1, [x2]
>         add     w1, w1, #1
>         strb    w1, [x2]
> 
>         add     x2, x2, #(4096)
>         cmp     x2, x3
>         blt     innerloop
> 
>         add     w6, w6, #1
>         and     w6, w6, #(0xff)
>         cmp     w6, #0
>         bne     mainloop
> 
>         /* output char 'B' to PL011 */
>         mov     w4, #66
>         mov     x5, #0x9000000
>         strb    w4, [x5]
> 
>         bl      mainloop
> 
> The code is compiled with the following command:
>  * gcc -c -o fill.o fill.s
>  * gcc -O2 -o fill.elf -Wl,-T,/tmp/flat.lds,--build-id=none,-Ttext=40080000 \
>    -nostdlib fill.o
>  * objcopy -O binary fill.elf fill.flat
>  * xxd -i fill.flat
> 
> The linker file (borrowed from KVM unit test) is defined as:
> 
> SECTIONS
> {
>     .text : { *(.init) *(.text) *(.text.*) }
>     . = ALIGN(64K);
>     etext = .;
>     .data : {
>         *(.data)
>     }
>     . = ALIGN(16);
>     .rodata : { *(.rodata) }
>     . = ALIGN(16);
>     .bss : { *(.bss) }
>     . = ALIGN(64K);
>     edata = .;
>     . += 64K;
>     . = ALIGN(64K);
>     /*
>      * stack depth is 16K for arm and PAGE_SIZE for arm64, see THREAD_SIZE
>      * sp must be 16 byte aligned for arm64, and 8 byte aligned for arm
>      * sp must always be strictly less than the true stacktop
>      */
>     stackptr = . - 16;
>     stacktop = .;
> }
> 
> ENTRY(start)
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/Makefile.include |  1 +
>  tests/migration-test.c | 43 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index c002352..d5828c4 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -357,6 +357,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
>  gcov-files-arm-y += hw/timer/arm_mptimer.c
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
>  
>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
>  
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index be598d3..b0dd365 100644
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
> @@ -125,6 +125,18 @@ unsigned char bootsect[] = {
>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
>  };
>  
> +unsigned char aarch64_kernel[] = {
> +    0x00, 0x10, 0x38, 0xd5, 0x00, 0xf8, 0x7f, 0x92, 0x00, 0x10, 0x18, 0xd5,
> +    0xdf, 0x3f, 0x03, 0xd5, 0x24, 0x08, 0x80, 0x52, 0x05, 0x20, 0xa1, 0xd2,
> +    0xa4, 0x00, 0x00, 0x39, 0x06, 0x00, 0x80, 0x52, 0x03, 0xc8, 0xa8, 0xd2,
> +    0x02, 0x02, 0xa8, 0xd2, 0x41, 0x00, 0x40, 0x39, 0x21, 0x04, 0x00, 0x11,
> +    0x41, 0x00, 0x00, 0x39, 0x42, 0x04, 0x40, 0x91, 0x5f, 0x00, 0x03, 0xeb,
> +    0x6b, 0xff, 0xff, 0x54, 0xc6, 0x04, 0x00, 0x11, 0xc6, 0x1c, 0x00, 0x12,
> +    0xdf, 0x00, 0x00, 0x71, 0xc1, 0xfe, 0xff, 0x54, 0x44, 0x08, 0x80, 0x52,
> +    0x05, 0x20, 0xa1, 0xd2, 0xa4, 0x00, 0x00, 0x39, 0xf2, 0xff, 0xff, 0x97
> +};
> +unsigned int aarch64_kernel_len = 96;
> +
>  static void init_bootfile_x86(const char *bootpath)
>  {
>      FILE *bootfile = fopen(bootpath, "wb");
> @@ -163,6 +175,15 @@ static void init_bootfile_ppc(const char *bootpath)
>      fclose(bootfile);
>  }
>  
> +static void init_bootfile_aarch64(const char *bootpath)
> +{
> +    FILE *kernelfile = fopen(bootpath, "wb");
> +
> +    g_assert_cmpint(fwrite(aarch64_kernel, aarch64_kernel_len, 1, kernelfile),
> +                    ==, 1);
> +    fclose(kernelfile);
> +}
> +
>  /*
>   * Wait for some output in the serial output file,
>   * we get an 'A' followed by an endless string of 'B's
> @@ -470,6 +491,22 @@ static void test_migrate_start(QTestState **from, QTestState **to,
>                                    " -serial file:%s/dest_serial"
>                                    " -incoming %s",
>                                    accel, tmpfs, uri);
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +        init_bootfile_aarch64(bootpath);
> +        cmd_src = g_strdup_printf("-machine virt,accel=kvm:cg -m 1024M"
> +                                  " -name vmsource,debug-threads=on -cpu host"
> +                                  " -serial file:%s/src_serial "
> +                                  " -kernel %s ",
> +                                  tmpfs, bootpath);
> +        cmd_dst = g_strdup_printf("-machine virt,accel=kvm:tcg -m 1024M"
> +                                  " -name vmdest,debug-threads=on -cpu host"
> +                                  " -serial file:%s/dest_serial"
> +                                  " -kernel %s"
> +                                  " -incoming %s",
> +                                  tmpfs, bootpath, uri);
> +        /* aarch64 virt machine physical mem started from 0x40000000 */
> +        start_address += 0x40000000;
> +        end_address += 0x40000000;
>      } else {
>          g_assert_not_reached();
>      }
> @@ -530,7 +567,7 @@ static void test_migrate(void)
>       * machine, so also set the downtime.
>       */
>      migrate_set_speed(from, "100000000");
> -    migrate_set_downtime(from, 0.001);
> +    migrate_set_downtime(from, 0.1);
>  
>      /* Wait for the first serial output from the source */
>      wait_for_serial("src_serial");
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
