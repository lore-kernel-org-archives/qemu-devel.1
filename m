Received: from eggs.gnu.org ([2001:4830:134:3::10]:57906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZerp-0002Jm-Gk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:38:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZerm-0000NI-EV
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:38:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZerm-0000Mu-8J
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:38:38 -0500
Date: Wed, 19 Dec 2018 11:38:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219113611-mutt-send-email-mst@kernel.org>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/9] tests: apci: consolidate and cleanup
 ACPI test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Dec 10, 2018 at 07:10:06PM +0100, Igor Mammedov wrote:
> While working on adding tests for virt/arm board (uefi/XSDT/64-bit table pointers),
> I found it's rather difficult to deal with mixed ACPI testing code that we've
> collected so far. So instead of just adding a pile of XSDT hacks on top, here
> goes small refactoring series:
>    * that removes dead code
>    * replaces reading tables with a fetch per table everywhere instead of
>      mix of field by field and whole table
>    * consolidates the way tables are read (reduces code duplication)
>    * test no longer depends on ACPI structures from QEMU (i.e. doesn't affected
>      by mistakes there) 
>    * fixiex FACS not beint compared against reference tables
> Overall test is reduced on ~170LOC and hopefully it makes easier to add more
> stuff on top.

So this was posted outside the merge window - do you still want
it merged? If yes pls repost.

Another idea I had for a while is to compare against expected
files before iasl. Only disassemble on comparison failure.

This will
- speed the good path up
- allow testing on systems without iasl (though debugging will be
  harder)

> PS:
> Series depends on '[PATCH v3 0/8] hw: acpi: RSDP fixes and refactoring'
> to avoid nontrivial conflicts
> 
> PS2:
> arm/virt test patches fill follow up a separate series on top of this one
> for not to mix things up
> 
> 
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Laurent Vivier <lvivier@redhat.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> 
> 
> Igor Mammedov (9):
>   tests: acpi: remove not used ACPI_READ_GENERIC_ADDRESS macro
>   tests: acpi: use AcpiSdtTable::aml in consistent way
>   tests: acpi: make sure FADT is fetched only once
>   tests: acpi: simplify rsdt handling
>   tests: acpi: reuse fetch_table() for fetching FACS and DSDT
>   tests: acpi: reuse fetch_table() in vmgenid-test
>   tests: smbios: fetch whole table in one step instead of reading it
>     step by step
>   tests: acpi: squash sanitize_fadt_ptrs() into test_acpi_fadt_table()
>   tests: acpi: use AcpiSdtTable::aml instead of
>     AcpiSdtTable::header::signature
> 
>  tests/acpi-utils.h       |  51 ++--------
>  tests/acpi-utils.c       |  33 ++++--
>  tests/bios-tables-test.c | 257 ++++++++++++-----------------------------------
>  tests/vmgenid-test.c     |  63 ++++--------
>  4 files changed, 116 insertions(+), 288 deletions(-)
> 
> -- 
> 2.7.4
