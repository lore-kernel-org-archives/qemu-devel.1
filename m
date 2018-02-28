Received: from eggs.gnu.org ([2001:4830:134:3::10]:37944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqx9H-0007BK-7i
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqx9A-0001ip-PA
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:31:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eqx9A-0001id-Ig
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:31:32 -0500
Date: Wed, 28 Feb 2018 09:31:16 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180228083116.h5jwksly2xqjdm32@kamzik.brq.redhat.com>
References: <20180226181758.26922-1-wei@redhat.com>
	<20180226181758.26922-4-wei@redhat.com>
	<20180227115740.GD2847@work-vm>
	<8673e197-11d7-107f-8dea-5167f35f3d69@redhat.com>
	<20180227162732.GG2847@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227162732.GG2847@work-vm>
Subject: Re: [Qemu-devel] [PATCH V6 3/4] tests/migration: Add migration-test
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Huang <wei@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com

On Tue, Feb 27, 2018 at 04:27:33PM +0000, Dr. David Alan Gilbert wrote:
> * Wei Huang (wei@redhat.com) wrote:
> > 
> > 
> > On 02/27/2018 05:57 AM, Dr. David Alan Gilbert wrote:
> > > * Wei Huang (wei@redhat.com) wrote:
> > >> This patch moves the settings related migration-test from the
> > >> migration-test.c file to a seperate header file. It also renames the
> > >> x86-a-b-bootblock.s file extension from .s to .S, allowing gcc
> > >> pre-processor to include the C-style header file correctly.
> > >>
> > >> Signed-off-by: Wei Huang <wei@redhat.com>
> > >> Reviewed-by: Andrew Jones <drjones@redhat.com>
> > >> ---
> > >>  tests/migration-test.c                             | 28 +++++++++++-----------
> > >>  tests/migration/Makefile                           |  4 ++--
> > >>  tests/migration/migration-test.h                   | 18 ++++++++++++++
> > >>  .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}   |  7 +++---
> > >>  tests/migration/x86-a-b-bootblock.h                |  2 +-
> > >>  5 files changed, 39 insertions(+), 20 deletions(-)
> > >>  create mode 100644 tests/migration/migration-test.h
> > >>  rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (94%)
> > >>
> > >> diff --git a/tests/migration-test.c b/tests/migration-test.c
> > >> index 74f9361bdd..c88b7e7a19 100644
> > >> --- a/tests/migration-test.c
> > >> +++ b/tests/migration-test.c
> > >> @@ -21,10 +21,10 @@
> > >>  #include "sysemu/sysemu.h"
> > >>  #include "hw/nvram/chrp_nvram.h"
> > >>  
> > >> -#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> > >> +#include "migration/migration-test.h"
> > >>  
> > >> -const unsigned start_address = 1024 * 1024;
> > >> -const unsigned end_address = 100 * 1024 * 1024;
> > >> +const unsigned start_address = TEST_MEM_START;
> > >> +const unsigned end_address = TEST_MEM_END;
> > >>  bool got_stop;
> > >>  
> > >>  #if defined(__linux__)
> > >> @@ -77,8 +77,8 @@ static bool ufd_version_check(void)
> > >>  
> > >>  static const char *tmpfs;
> > >>  
> > >> -/* A simple PC boot sector that modifies memory (1-100MB) quickly
> > >> - * outputting a 'B' every so often if it's still running.
> > >> +/* The boot file modifies memory area in [start_address, end_address)
> > >> + * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
> > >>   */
> > >>  #include "tests/migration/x86-a-b-bootblock.h"
> > >>  
> > >> @@ -104,9 +104,8 @@ static void init_bootfile_ppc(const char *bootpath)
> > >>      memcpy(header->name, "common", 6);
> > >>      chrp_nvram_finish_partition(header, MIN_NVRAM_SIZE);
> > >>  
> > >> -    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB,
> > >> -     * so let's modify memory between 1MB and 100MB
> > >> -     * to do like PC bootsector
> > >> +    /* FW_MAX_SIZE is 4MB, but slof.bin is only 900KB. So it is OK to modify
> > >> +     * memory between start_address and end_address like PC bootsector does.
> > >>       */
> > >>  
> > >>      sprintf(buf + 16,
> > >> @@ -263,11 +262,11 @@ static void wait_for_migration_pass(QTestState *who)
> > >>  static void check_guests_ram(QTestState *who)
> > >>  {
> > >>      /* Our ASM test will have been incrementing one byte from each page from
> > >> -     * 1MB to <100MB in order.
> > >> -     * This gives us a constraint that any page's byte should be equal or less
> > >> -     * than the previous pages byte (mod 256); and they should all be equal
> > >> -     * except for one transition at the point where we meet the incrementer.
> > >> -     * (We're running this with the guest stopped).
> > >> +     * start_address to < end_address in order. This gives us a constraint
> > >> +     * that any page's byte should be equal or less than the previous pages
> > >> +     * byte (mod 256); and they should all be equal except for one transition
> > >> +     * at the point where we meet the incrementer. (We're running this with
> > >> +     * the guest stopped).
> > > 
> > > No, please don't modify the other architectures.
> > > 
> > > It's OK for you to get the start/end value from the define in the header
> > > but we can't assume they're movable; they're architecture specific
> > > values that are chosen to fit where we know we have RAM.
> > 
> > Drew didn't like the idea of having #define TEST_MEM_START/TEST_MEM_END
> > in headerfile, and in the meanwhile, we still use 1MB/100MB in comments.
> > Anyway we didn't modify the underneath semantic for other architectures.
> 
> The problem is you have to be VERY careful; because while it might make
> sense to move the start for one architecture it might break on another.

We should make the addreses explicitly arch-specific. In the header create
arch-specific defines like below. In the code don't initialize
start/end_address to anything. Instead only set them to their arch-
specific defines in their arch-specific blocks of test_migrate_start().

#define X86_TEST_MEM_START (1024*1024)
#define X86_TEST_MEM_END   (100*1024*1024)
#define ARM_TEST_MEM_START (0x40000000 + 1024*1024)
#define ARM_TEST_MEM_END   (0x40000000 + 100*1024*1024)

Thanks,
drew

> 
> Dave
> 
> > > 
> > > Dave
> > > 
> > >>       */
> > >>      unsigned address;
> > >>      uint8_t first_byte;
> > >> @@ -278,7 +277,8 @@ static void check_guests_ram(QTestState *who)
> > >>      qtest_memread(who, start_address, &first_byte, 1);
> > >>      last_byte = first_byte;
> > >>  
> > >> -    for (address = start_address + 4096; address < end_address; address += 4096)
> > >> +    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
> > >> +         address += TEST_MEM_PAGE_SIZE)
> > >>      {
> > >>          uint8_t b;
> > >>          qtest_memread(who, address, &b, 1);
> > >> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> > >> index 8fbedaa8b8..013b8d1f44 100644
> > >> --- a/tests/migration/Makefile
> > >> +++ b/tests/migration/Makefile
> > >> @@ -25,8 +25,8 @@ include $(SRC_PATH)/rules.mak
> > >>  
> > >>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> > >>  
> > >> -x86-a-b-bootblock.h: x86-a-b-bootblock.s
> > >> -	$(x86_64_cross_prefix)as --32 -march=i486 $< -o x86.o
> > >> +x86-a-b-bootblock.h: x86-a-b-bootblock.S
> > >> +	$(x86_64_cross_prefix)gcc -m32 -march=i486 -c $< -o x86.o
> > >>  	$(x86_64_cross_prefix)objcopy -O binary x86.o x86.boot
> > >>  	dd if=x86.boot of=x86.bootsect bs=256 count=2 skip=124
> > >>  	echo "$$__note" > $@
> > >> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> > >> new file mode 100644
> > >> index 0000000000..48b59b3281
> > >> --- /dev/null
> > >> +++ b/tests/migration/migration-test.h
> > >> @@ -0,0 +1,18 @@
> > >> +/*
> > >> + * Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> > >> + *
> > >> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > >> + * See the COPYING file in the top-level directory.
> > >> + */
> > >> +#ifndef _TEST_MIGRATION_H_
> > >> +#define _TEST_MIGRATION_H_
> > >> +
> > >> +/* Common */
> > >> +#define TEST_MEM_START      (1 * 1024 * 1024)
> > >> +#define TEST_MEM_END        (100 * 1024 * 1024)
> > >> +#define TEST_MEM_PAGE_SIZE  4096
> > >> +
> > >> +/* PPC */
> > >> +#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> > >> +
> > >> +#endif /* _TEST_MIGRATION_H_ */
> > >> diff --git a/tests/migration/x86-a-b-bootblock.s b/tests/migration/x86-a-b-bootblock.S
> > >> similarity index 94%
> > >> rename from tests/migration/x86-a-b-bootblock.s
> > >> rename to tests/migration/x86-a-b-bootblock.S
> > >> index 98dbfab084..08b51f9e7f 100644
> > >> --- a/tests/migration/x86-a-b-bootblock.s
> > >> +++ b/tests/migration/x86-a-b-bootblock.S
> > >> @@ -12,6 +12,7 @@
> > >>  #
> > >>  # Author: dgilbert@redhat.com
> > >>  
> > >> +#include "migration-test.h"
> > >>  
> > >>  .code16
> > >>  .org 0x7c00
> > >> @@ -45,11 +46,11 @@ start:             # at 0x7c00 ?
> > >>          mov $0, %bl
> > >>  mainloop:
> > >>          # Start from 1MB
> > >> -        mov $(1024*1024),%eax
> > >> +        mov $TEST_MEM_START,%eax
> > >>  innerloop:
> > >>          incb (%eax)
> > >> -        add $4096,%eax
> > >> -        cmp $(100*1024*1024),%eax
> > >> +        add $TEST_MEM_PAGE_SIZE,%eax
> > >> +        cmp $TEST_MEM_END,%eax
> > >>          jl innerloop
> > >>  
> > >>          inc %bl
> > >> diff --git a/tests/migration/x86-a-b-bootblock.h b/tests/migration/x86-a-b-bootblock.h
> > >> index 9e8e2e028b..44e4b99506 100644
> > >> --- a/tests/migration/x86-a-b-bootblock.h
> > >> +++ b/tests/migration/x86-a-b-bootblock.h
> > >> @@ -1,5 +1,5 @@
> > >>  /* This file is automatically generated from
> > >> - * tests/migration/x86-a-b-bootblock.s, edit that and then run
> > >> + * tests/migration/x86-a-b-bootblock.S, edit that and then run
> > >>   * "make x86-a-b-bootblock.h" inside tests/migration to update,
> > >>   * and then remember to send both in your patch submission.
> > >>   */
> > >> -- 
> > >> 2.14.3
> > >>
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
