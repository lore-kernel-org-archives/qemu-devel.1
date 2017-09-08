Received: from eggs.gnu.org ([2001:4830:134:3::10]:50500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqIiD-0002yo-Li
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dqIiC-0001CR-Bu
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dqIiC-0001BU-1w
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:48:44 -0400
Date: Fri, 8 Sep 2017 15:48:41 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170908154837-mutt-send-email-mst@kernel.org>
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-23-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901180340.30009-23-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 22/29] tests/boot-sector: Drop
 dependence on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, Ben Warren <ben@skyportsystems.com>

On Fri, Sep 01, 2017 at 01:03:33PM -0500, Eric Blake wrote:
> As a general rule, we prefer avoiding implicit global state
> because it makes code harder to safely copy and paste without
> thinking about the global state.  Adjust the helper code to
> use explicit state instead, and update all callers.
> 
> Fix some trailing whitespace while touching the file.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tests/boot-sector.h      | 6 ++++--
>  tests/bios-tables-test.c | 2 +-
>  tests/boot-sector.c      | 8 ++++----
>  tests/pxe-test.c         | 2 +-
>  tests/vmgenid-test.c     | 2 +-
>  5 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/tests/boot-sector.h b/tests/boot-sector.h
> index 35d61c7e2b..6ee6bb4d97 100644
> --- a/tests/boot-sector.h
> +++ b/tests/boot-sector.h
> @@ -5,7 +5,7 @@
>   *
>   * Authors:
>   *  Michael S. Tsirkin <mst@redhat.com>
> - *  Victor Kaplansky <victork@redhat.com>    
> + *  Victor Kaplansky <victork@redhat.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -14,11 +14,13 @@
>  #ifndef TEST_BOOT_SECTOR_H
>  #define TEST_BOOT_SECTOR_H
> 
> +#include "libqtest.h"
> +
>  /* Create boot disk file. fname must be a suitable string for mkstemp() */
>  int boot_sector_init(char *fname);
> 
>  /* Loop until signature in memory is OK.  */
> -void boot_sector_test(void);
> +void boot_sector_test(QTestState *qts);
> 
>  /* unlink boot disk file.  */
>  void boot_sector_cleanup(const char *fname);
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 564da45f65..bde62bf1cf 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -632,7 +632,7 @@ static void test_acpi_one(const char *params, test_data *data)
> 
>      qtest_start(args);
> 
> -    boot_sector_test();
> +    boot_sector_test(global_qtest);
> 
>      test_acpi_rsdp_address(data);
>      test_acpi_rsdp_table(data);
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index 9ee85370b0..8c8ac7f124 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -5,7 +5,7 @@
>   *
>   * Authors:
>   *  Michael S. Tsirkin <mst@redhat.com>
> - *  Victor Kaplansky <victork@redhat.com>    
> + *  Victor Kaplansky <victork@redhat.com>
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or later.
>   * See the COPYING file in the top-level directory.
> @@ -130,7 +130,7 @@ int boot_sector_init(char *fname)
>  }
> 
>  /* Loop until signature in memory is OK.  */
> -void boot_sector_test(void)
> +void boot_sector_test(QTestState *qts)
>  {
>      uint8_t signature_low;
>      uint8_t signature_high;
> @@ -146,8 +146,8 @@ void boot_sector_test(void)
>       * instruction.
>       */
>      for (i = 0; i < TEST_CYCLES; ++i) {
> -        signature_low = readb(SIGNATURE_ADDR);
> -        signature_high = readb(SIGNATURE_ADDR + 1);
> +        signature_low = qtest_readb(qts, SIGNATURE_ADDR);
> +        signature_high = qtest_readb(qts, SIGNATURE_ADDR + 1);
>          signature = (signature_high << 8) | signature_low;
>          if (signature == SIGNATURE) {
>              break;
> diff --git a/tests/pxe-test.c b/tests/pxe-test.c
> index 0d70afccd6..e2d3853534 100644
> --- a/tests/pxe-test.c
> +++ b/tests/pxe-test.c
> @@ -31,7 +31,7 @@ static void test_pxe_one(const char *params, bool ipv6)
>                             ipv6 ? "on" : "off", params);
> 
>      qtest_start(args);
> -    boot_sector_test();
> +    boot_sector_test(global_qtest);
>      qtest_quit(global_qtest);
>      g_free(args);
>  }
> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
> index 3d5c1c3615..4bdc8a15e7 100644
> --- a/tests/vmgenid-test.c
> +++ b/tests/vmgenid-test.c
> @@ -47,7 +47,7 @@ static uint32_t acpi_find_vgia(void)
>      int i;
> 
>      /* Wait for guest firmware to finish and start the payload. */
> -    boot_sector_test();
> +    boot_sector_test(global_qtest);
> 
>      /* Tables should be initialized now. */
>      rsdp_offset = acpi_find_rsdp_address();
> -- 
> 2.13.5
> 
