Received: from eggs.gnu.org ([2001:4830:134:3::10]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eomqr-0008CT-Vj
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eomqn-000558-MG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:07:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eomqn-00054w-GV
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:07:37 -0500
Date: Thu, 22 Feb 2018 10:07:19 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180222090719.zmsyran534jaxbwg@kamzik.brq.redhat.com>
References: <20180222044417.15561-1-wei@redhat.com>
	<20180222044417.15561-3-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222044417.15561-3-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 2/3] tests/migration: Add migration-test
 header file
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

On Wed, Feb 21, 2018 at 10:44:16PM -0600, Wei Huang wrote:
> This patch moves the settings related migration-test from the
> migration-test.c file to a seperate header file. It also renames the
> x86-a-b-bootblock.s file extension from .s to .S, allowing gcc
> pre-processor to include the C-style header file correctly.
> 
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/migration-test.c                                |  9 +++++----
>  tests/migration/Makefile                              |  4 ++--
>  tests/migration/migration-test.h                      | 19 +++++++++++++++++++
>  .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}      |  7 ++++---
>  tests/migration/x86-a-b-bootblock.h                   |  2 +-
>  5 files changed, 31 insertions(+), 10 deletions(-)
>  create mode 100644 tests/migration/migration-test.h
>  rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (94%)
> 
> diff --git a/tests/migration-test.c b/tests/migration-test.c
> index 74f9361bdd..e2e06ed337 100644
> --- a/tests/migration-test.c
> +++ b/tests/migration-test.c
> @@ -21,10 +21,10 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/nvram/chrp_nvram.h"
>  
> -#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> +#include "migration/migration-test.h"
>  
> -const unsigned start_address = 1024 * 1024;
> -const unsigned end_address = 100 * 1024 * 1024;
> +const unsigned start_address = TEST_MEM_START;
> +const unsigned end_address = TEST_MEM_END;
>  bool got_stop;
>  
>  #if defined(__linux__)
> @@ -278,7 +278,8 @@ static void check_guests_ram(QTestState *who)
>      qtest_memread(who, start_address, &first_byte, 1);
>      last_byte = first_byte;
>  
> -    for (address = start_address + 4096; address < end_address; address += 4096)
> +    for (address = start_address + TEST_MEM_PAGE_SIZE; address < end_address;
> +         address += TEST_MEM_PAGE_SIZE)
>      {
>          uint8_t b;
>          qtest_memread(who, address, &b, 1);


There are several 1M / 100M comments in this file. Maybe not worth
changing, but now that we've defined those values, it seems they
should be rewritten more generically.

> diff --git a/tests/migration/Makefile b/tests/migration/Makefile
> index 1c07dd7be9..b768d0729d 100644
> --- a/tests/migration/Makefile
> +++ b/tests/migration/Makefile
> @@ -27,8 +27,8 @@ endef
>  
>  all: x86-a-b-bootblock.h
>  
> -x86-a-b-bootblock.h: x86-a-b-bootblock.s
> -	$(x86_64_cross_prefix)as --32 -march=i486 $< -o x86.o
> +x86-a-b-bootblock.h: x86-a-b-bootblock.S
> +	$(x86_64_cross_prefix)gcc -m32 -march=i486 -c $< -o x86.o
>  	$(x86_64_cross_prefix)objcopy -O binary x86.o x86.boot
>  	dd if=x86.boot of=x86.bootsect bs=256 count=2 skip=124
>  	echo "$$__note" > $@
> diff --git a/tests/migration/migration-test.h b/tests/migration/migration-test.h
> new file mode 100644
> index 0000000000..a618fe069e
> --- /dev/null
> +++ b/tests/migration/migration-test.h
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright (c) 2018 Red Hat, Inc. and/or its affiliates
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#ifndef _TEST_MIGRATION_H_
> +#define _TEST_MIGRATION_H_
> +
> +/* Common */
> +#define TEST_MEM_START      (1 * 1024 * 1024)
> +#define TEST_MEM_END        (100 * 1024 * 1024)
> +#define TEST_MEM_PAGE_SIZE  4096
> +
> +/* PPC */
> +#define MIN_NVRAM_SIZE 8192 /* from spapr_nvram.c */
> +
> +#endif /* _TEST_MIGRATION_H_ */
> +

trailing blank line

> diff --git a/tests/migration/x86-a-b-bootblock.s b/tests/migration/x86-a-b-bootblock.S
> similarity index 94%
> rename from tests/migration/x86-a-b-bootblock.s
> rename to tests/migration/x86-a-b-bootblock.S
> index 98dbfab084..08b51f9e7f 100644
> --- a/tests/migration/x86-a-b-bootblock.s
> +++ b/tests/migration/x86-a-b-bootblock.S
> @@ -12,6 +12,7 @@
>  #
>  # Author: dgilbert@redhat.com
>  
> +#include "migration-test.h"
>  
>  .code16
>  .org 0x7c00
> @@ -45,11 +46,11 @@ start:             # at 0x7c00 ?
>          mov $0, %bl
>  mainloop:
>          # Start from 1MB
> -        mov $(1024*1024),%eax
> +        mov $TEST_MEM_START,%eax
>  innerloop:
>          incb (%eax)
> -        add $4096,%eax
> -        cmp $(100*1024*1024),%eax
> +        add $TEST_MEM_PAGE_SIZE,%eax
> +        cmp $TEST_MEM_END,%eax
>          jl innerloop
>  
>          inc %bl
> diff --git a/tests/migration/x86-a-b-bootblock.h b/tests/migration/x86-a-b-bootblock.h
> index 9e8e2e028b..44e4b99506 100644
> --- a/tests/migration/x86-a-b-bootblock.h
> +++ b/tests/migration/x86-a-b-bootblock.h
> @@ -1,5 +1,5 @@
>  /* This file is automatically generated from
> - * tests/migration/x86-a-b-bootblock.s, edit that and then run
> + * tests/migration/x86-a-b-bootblock.S, edit that and then run
>   * "make x86-a-b-bootblock.h" inside tests/migration to update,
>   * and then remember to send both in your patch submission.
>   */
> -- 
> 2.14.3
> 
>

Otherwise,

Reviewed-by: Andrew Jones <drjones@redhat.com>
