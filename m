Received: from eggs.gnu.org ([209.51.188.92]:43388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDk0r-0001yg-9v
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDk0q-0005aq-5j
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:13:41 -0400
References: <cover.1554755001.git.stephen.checkoway@oberlin.edu>
	<c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9409d9bf-c513-d82b-d438-9173fc582d7f@redhat.com>
Date: Tue, 9 Apr 2019 08:13:33 +0200
MIME-Version: 1.0
In-Reply-To: <c03b48badb28e3c98bcbaed092b5c40e7284db08.1554755001.git.stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] block/pflash_cfi02: Add test for
 supported commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stephen Checkoway <s@pahtak.org>, qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 08/04/2019 22.55, Stephen Checkoway wrote:
> From: Stephen Checkoway <s@pahtak.org>
> 
> Test the AMD command set for parallel flash chips. This test uses an
> ARM musicpal board with a pflash drive to test the following list of
> currently-supported commands.
> - Autoselect
> - CFI
> - Sector erase
> - Chip erase
> - Program
> - Unlock bypass
> - Reset
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  tests/Makefile.include    |   2 +
>  tests/pflash-cfi02-test.c | 224 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 tests/pflash-cfi02-test.c
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 6b904d7430..0a26eacce0 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -263,6 +263,7 @@ check-qtest-arm-y += tests/m25p80-test$(EXESUF)
>  check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
>  check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
>  check-qtest-arm-y += tests/hexloader-test$(EXESUF)
> +check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
>  
>  check-qtest-aarch64-y = tests/numa-test$(EXESUF)
>  check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
> @@ -773,6 +774,7 @@ tests/device-introspect-test$(EXESUF): tests/device-introspect-test.o
>  tests/rtc-test$(EXESUF): tests/rtc-test.o
>  tests/m48t59-test$(EXESUF): tests/m48t59-test.o
>  tests/hexloader-test$(EXESUF): tests/hexloader-test.o
> +tests/pflash-cfi02$(EXESUF): tests/pflash-cfi02-test.o
>  tests/endianness-test$(EXESUF): tests/endianness-test.o
>  tests/prom-env-test$(EXESUF): tests/prom-env-test.o $(libqos-obj-y)
>  tests/rtas-test$(EXESUF): tests/rtas-test.o $(libqos-spapr-obj-y)
> diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
> new file mode 100644
> index 0000000000..d349b2cc22
> --- /dev/null
> +++ b/tests/pflash-cfi02-test.c
> @@ -0,0 +1,224 @@
> +/*
> + * QTest testcase for parallel flash with AMD command set
> + *
> + * Copyright (c) 2018 Stephen Checkoway
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <err.h>
> +#include <unistd.h>
> +#include "libqtest.h"
> +
> +/*
> + * To test the pflash_cfi02 device, we run QEMU with the musicpal machine with
> + * a pflash drive. This enables us to test some flash configurations, but not
> + * all. In particular, we're limited to a 16-bit wide flash device.
> + */
> +
> +#define MP_FLASH_SIZE_MAX (32*1024*1024)
> +#define BASE_ADDR (0x100000000ULL-MP_FLASH_SIZE_MAX)
> +
> +#define FLASH_WIDTH 2
> +#define CFI_ADDR (FLASH_WIDTH*0x55)
> +#define UNLOCK0_ADDR (FLASH_WIDTH*0x5555)
> +#define UNLOCK1_ADDR (FLASH_WIDTH*0x2AAA)
> +
> +#define CFI_CMD 0x98
> +#define UNLOCK0_CMD 0xAA
> +#define UNLOCK1_CMD 0x55
> +#define AUTOSELECT_CMD 0x90
> +#define RESET_CMD 0xF0
> +#define PROGRAM_CMD 0xA0
> +#define SECTOR_ERASE_CMD 0x30
> +#define CHIP_ERASE_CMD 0x10
> +#define UNLOCK_BYPASS_CMD 0x20
> +#define UNLOCK_BYPASS_RESET_CMD 0x00
> +
> +static char image_path[] = "/tmp/qtest.XXXXXX";
> +
> +static inline void flash_write(uint64_t byte_addr, uint16_t data)
> +{
> +    qtest_writew(global_qtest, BASE_ADDR + byte_addr, data);
> +}
> +
> +static inline uint16_t flash_read(uint64_t byte_addr)
> +{
> +    return qtest_readw(global_qtest, BASE_ADDR + byte_addr);
> +}

We'd like to get rid of global_qtest in the long run (since it is
causing trouble for tests that run multiple instances of QEMU in
parallel, e.g. migration tests)... so if it is feasible, please don't
use it in new code anymore. Try to use a local variable in the function
that call qtest_initf() and pass the test state around via a parameter
to the functions that need it.

 Thanks,
  Thomas
