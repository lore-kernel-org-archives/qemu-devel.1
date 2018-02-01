Received: from eggs.gnu.org ([2001:4830:134:3::10]:39816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehL3t-0001r8-6D
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ehL2p-00025n-6m
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:02:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ehL2o-00025M-OA
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 15:01:15 -0500
Date: Thu, 1 Feb 2018 20:01:09 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180201200108.GP2457@work-vm>
References: <20180124212246.2352-1-wei@redhat.com>
	<20180125200525.GC2442@work-vm>
	<6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e27688f-1350-62f5-23ff-7855ea502be9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V1 1/1] tests: Add migration test for
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, quintela@redhat.com, drjones@redhat.com

* Wei Huang (wei@redhat.com) wrote:
> 
> 
> On 01/25/2018 02:05 PM, Dr. David Alan Gilbert wrote:
> > * Wei Huang (wei@redhat.com) wrote:
> >> This patch adds the migration test support for aarch64. The test code,
> >> which implements the same functionality as x86, is compiled into a binary
> >> and booted as a kernel in qemu. Here are the design ideas:
> >>
> >>  * We choose this -kernel design because aarch64 QEMU doesn't provide a
> >>    built-in fw like x86 does. So instead of relying on a boot loader, we
> >>    use -kernel approach for aarch64.
> >>  * The serial output is sent to PL011 directly.
> >>  * The physical memory base for mach-virt machine is 0x40000000. We change
> >>    the start_address and end_address for aarch64.
> >>
> >> RFC->V1:
> >>  * aarch64 kernel blob is defined as an uint32_t array
> >>  * The test code is re-written to address a data caching issue under KVM.
> >>    Tests passed under both x86 and aarch64.
> >>  * Re-use init_bootfile_x86() for both x86 and aarch64
> >>  * Other minor fixes
> >>
> >> Note that the test code is as the following:
> >>
> >> .section .text
> >>
> >>         .globl  start
> >>         
> >> start:
> >>         /* disable MMU to use phys mem address */
> >>         mrs     x0, sctlr_el1
> >>         bic     x0, x0, #(1<<0)
> >>         msr     sctlr_el1, x0
> >>         isb
> >>
> >>         /* output char 'A' to PL011 */
> >>         mov     w4, #65
> >>         mov     x5, #0x9000000
> >>         strb    w4, [x5]
> >>
> >>         /* w6 keeps a counter so we can limit the output speed */
> >>         mov     w6, #0
> >>
> >>         /* phys mem base addr = 0x40000000 */
> >>         mov     x3, #(0x40000000 + 100 *1024*1024) /* traverse 1M-100M */
> >>         mov     x2, #(0x40000000 + 1 * 1024*1024)
> >>
> >>         /* clean up memory first */
> >>         mov     w1, #0  
> >> clean:
> >>         strb    w1, [x2]
> >>         add     x2, x2, #(4096)
> >>         cmp     x2, x3
> >>         ble     clean
> >>
> >>         /* main body */
> >> mainloop:
> >>         mov     x2, #(0x40000000 + 1 * 1024*1024)
> >>         
> >> innerloop:
> >>         /* clean cache because el2 might still cache guest data under KVM */
> >>         dc      civac, x2
> > 
> > Can you explain a bit more about that please;  if it's guest
> > visible acorss migration, doesn't that suggest we need the cache clear
> > in KVM or QEMU?
> 
> I think this is ARM specific. This is caused by the inconsistency
> between guest VM's data accesses and userspace's accesses (in
> check_guest_ram) at the destination:
> 
> 1) Because uncacheable (guest) + cacheable (host) ==> uncacheable. So
> the data accesses from guest VM go directly into memory.
> 2) QEMU user space will use the cacheable version. So it is possible
> that data can come from cache, instead of RAM. The difference between
> (1) and (2) obviously can cause check_guest_ram() to fail sometimes.
> 
> x86's EPT has the capability to ignore guest-provided memory type. So it
> is possible to have consistent data views between guest and QEMU user-space.

I'll admit to not quite understanding where this thread ended up;
it seems to have fallen into other ARM consistency questions.
Other than that it looks fine to me, but see the separate patch I posted
yesterday that includes the x86 source.

Peter: What's your view on the ight fix for hte memory consistency?

Dave

> 
> > 
> > Dave
> > 
> >>         ldrb    w1, [x2]
> >>         add     w1, w1, #1
> >>         and     w1, w1, #(0xff)
> >>         strb    w1, [x2]
> >>
> >>         add     x2, x2, #(4096)
> >>         cmp     x2, x3
> >>         blt     innerloop
> >>
> >>         add     w6, w6, #1
> >>         and     w6, w6, #(0xff)
> >>         cmp     w6, #0
> >>         bne     mainloop
> >>         
> >>         /* output char 'B' to PL011 */
> >>         mov     w4, #66
> >>         mov     x5, #0x9000000
> >>         strb    w4, [x5]
> >>
> >>         bl      mainloop
> >>
> >> The code is compiled with the following commands:
> >>  > gcc -c -o fill.o fill.s
> >>  > gcc -O2 -o fill.elf -Wl,-T,/tmp/flat.lds,--build-id=none,-Ttext=40080000 \
> >>    -nostdlib fill.o
> >>  > objcopy -O binary fill.elf fill.flat
> >>  > truncate -c -s 144 ./fill.flat
> >>  > xxd -g 4 -c 24 -e fill.flat | awk '{print "0x"$2 ", " "0x"$3 ", " "0x"C$4 ", " "0x"C$5 ", " "0x"$6 ", " "0x"C$7 "," }'
> >>
> >> The linker file (borrowed from KVM unit test) is defined as:
> >>
> >> SECTIONS
> >> {
> >>     .text : { *(.init) *(.text) *(.text.*) }
> >>     . = ALIGN(64K);
> >>     etext = .;
> >>     .data : {
> >>         *(.data)
> >>     }
> >>     . = ALIGN(16);
> >>     .rodata : { *(.rodata) }
> >>     . = ALIGN(16);
> >>     .bss : { *(.bss) }
> >>     . = ALIGN(64K);
> >>     edata = .;
> >>     . += 64K;
> >>     . = ALIGN(64K);
> >>     /*
> >>      * stack depth is 16K for arm and PAGE_SIZE for arm64, see THREAD_SIZE
> >>      * sp must be 16 byte aligned for arm64, and 8 byte aligned for arm
> >>      * sp must always be strictly less than the true stacktop
> >>      */
> >>     stackptr = . - 16;
> >>     stacktop = .;
> >> }
> >>
> >> ENTRY(start)
> >>
> >> Signed-off-by: Wei Huang <wei@redhat.com>
> >> ---
> >>  tests/Makefile.include |  1 +
> >>  tests/migration-test.c | 37 +++++++++++++++++++++++++++++++------
> >>  2 files changed, 32 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tests/Makefile.include b/tests/Makefile.include
> >> index b4bcc872f2..2a520e53ab 100644
> >> --- a/tests/Makefile.include
> >> +++ b/tests/Makefile.include
> >> @@ -357,6 +357,7 @@ check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
> >>  gcov-files-arm-y += hw/timer/arm_mptimer.c
> >>  
> >>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
> >> +check-qtest-aarch64-y += tests/migration-test$(EXESUF)
> >>  
> >>  check-qtest-microblazeel-y = $(check-qtest-microblaze-y)
> >>  
> >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> >> index be598d3257..3237fe93b2 100644
> >> --- a/tests/migration-test.c
> >> +++ b/tests/migration-test.c
> >> @@ -22,8 +22,8 @@
> >>  
> >>  #define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> >>  
> >> -const unsigned start_address = 1024 * 1024;
> >> -const unsigned end_address = 100 * 1024 * 1024;
> >> +unsigned start_address = 1024 * 1024;
> >> +unsigned end_address = 100 * 1024 * 1024;
> >>  bool got_stop;
> >>  
> >>  #if defined(__linux__)
> >> @@ -79,7 +79,7 @@ static const char *tmpfs;
> >>  /* A simple PC boot sector that modifies memory (1-100MB) quickly
> >>   * outputing a 'B' every so often if it's still running.
> >>   */
> >> -unsigned char bootsect[] = {
> >> +unsigned char x86_bootsect[] = {
> >>    0xfa, 0x0f, 0x01, 0x16, 0x74, 0x7c, 0x66, 0xb8, 0x01, 0x00, 0x00, 0x00,
> >>    0x0f, 0x22, 0xc0, 0x66, 0xea, 0x20, 0x7c, 0x00, 0x00, 0x08, 0x00, 0x00,
> >>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xe4, 0x92, 0x0c, 0x02,
> >> @@ -125,11 +125,20 @@ unsigned char bootsect[] = {
> >>    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x55, 0xaa
> >>  };
> >>  
> >> -static void init_bootfile_x86(const char *bootpath)
> >> +uint32_t aarch64_kernel[] = {
> >> +    0xd5381000, 0x927ff800, 0xd5181000, 0xd5033fdf, 0x52800824, 0xd2a12005,
> >> +    0x390000a4, 0x52800006, 0xd2a8c803, 0xd2a80202, 0x52800001, 0x39000041,
> >> +    0x91400442, 0xeb03005f, 0x54ffffad, 0xd2a80202, 0xd50b7e22, 0x39400041,
> >> +    0x11000421, 0x12001c21, 0x39000041, 0x91400442, 0xeb03005f, 0x54ffff2b,
> >> +    0x110004c6, 0x12001cc6, 0x710000df, 0x54fffe81, 0x52800844, 0xd2a12005,
> >> +    0x390000a4, 0x97fffff0, 0x00000000, 0x00000000, 0x00000000, 0x00000000,
> >> +};
> >> +
> >> +static void init_bootfile(const char *bootpath, void *content)
> >>  {
> >>      FILE *bootfile = fopen(bootpath, "wb");
> >>  
> >> -    g_assert_cmpint(fwrite(bootsect, 512, 1, bootfile), ==, 1);
> >> +    g_assert_cmpint(fwrite(content, 512, 1, bootfile), ==, 1);
> >>      fclose(bootfile);
> >>  }
> >>  
> >> @@ -442,7 +451,7 @@ static void test_migrate_start(QTestState **from, QTestState **to,
> >>      got_stop = false;
> >>  
> >>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> >> -        init_bootfile_x86(bootpath);
> >> +        init_bootfile(bootpath, x86_bootsect);
> >>          cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
> >>                                    " -name pcsource,debug-threads=on"
> >>                                    " -serial file:%s/src_serial"
> >> @@ -470,6 +479,22 @@ static void test_migrate_start(QTestState **from, QTestState **to,
> >>                                    " -serial file:%s/dest_serial"
> >>                                    " -incoming %s",
> >>                                    accel, tmpfs, uri);
> >> +    } else if (strcmp(arch, "aarch64") == 0) {
> >> +        init_bootfile(bootpath, aarch64_kernel);
> >> +        cmd_src = g_strdup_printf("-machine virt,accel=kvm:tcg -m 150M "
> >> +                                  "-name vmsource,debug-threads=on -cpu host "
> >> +                                  "-serial file:%s/src_serial "
> >> +                                  "-kernel %s ",
> >> +                                  tmpfs, bootpath);
> >> +        cmd_dst = g_strdup_printf("-machine virt,accel=kvm:tcg -m 150M "
> >> +                                  "-name vmdest,debug-threads=on -cpu host "
> >> +                                  "-serial file:%s/dest_serial "
> >> +                                  "-kernel %s "
> >> +                                  "-incoming %s ",
> >> +                                  tmpfs, bootpath, uri);
> >> +        /* aarch64 virt machine physical mem started from 0x40000000 */
> >> +        start_address += 0x40000000;
> >> +        end_address += 0x40000000;
> >>      } else {
> >>          g_assert_not_reached();
> >>      }
> >> -- 
> >> 2.14.3
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
