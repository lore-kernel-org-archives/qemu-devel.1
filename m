Received: from eggs.gnu.org ([209.51.188.92]:57418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMDRp-00015b-0A
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xuwei5@huawei.com>) id 1hMDRn-0006q1-Hn
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:16:32 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:45395 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xuwei5@huawei.com>) id 1hMDRn-0006pa-BR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:16:31 -0400
References: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
From: Wei Xu <xuwei5@hisilicon.com>
Message-ID: <2d736e9a-25e8-164c-9a90-5b24cc83ac17@hisilicon.com>
Date: Thu, 2 May 2019 16:16:17 +0100
MIME-Version: 1.0
In-Reply-To: <1556808723-226478-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/15] tests: acpi: add UEFI (ARM)
 testing support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>, xuwei5@huawei.com, linuxarm@huawei.com

Hi Ignor,

On 5/2/2019 3:51 PM, Igor Mammedov wrote:
> Changelog:
>   - from v3:
>       * reshaffle patch order a bit
>       * move out acpi_parse_rsdp_table() hunk to
>           "tests: acpi: make pointer to RSDP  64bit"
>         where it belongs
>       * move acpi_fetch_rsdp_table(s/uint32_t addr/uint64_t addr/) to
>         this patch where it belongs from:
>            "tests: acpi: make RSDT test routine handle XSDT"
>       * dropping Reviewed-bys due to acpi_fetch_table() change
>         introduced by earlier patch:
>           "tests: acpi: make acpi_fetch_table() take size of fetched ta=
ble pointer"
>       * update [8/15] commit message to point to commit which introduce=
d
>         signature_guid value.
>       * get rid of test_acpi_rsdp_address() in [9/15]
>       * added new patch
>          tests: acpi: allow to override default accelerator
>       * force arm/virt test to use TCG accelerator
>   - from v2:
>       * rebase on top current master (with UEFI blobs merged)
>       * added a Makefile rule to include bios-tables-test to aarch64 te=
sts by
>         default into 11/13 (kept Reviewed-bys)
>       * other trivial fixes and cleanups (see per patch changelogs)
>   =20
>   - from v1:
>       * rebase on top
>          (1) [PATCH for-4.1 v3 00/12] bundle edk2 platform firmware  wi=
th QEMU
>         let me to drop edk2 images and drop Makefile magic to unpack th=
em,
>         Laszlo's series conveniently does it all for me.
>       * use new path/names for firmware images as supplied by [1]
>       * reorder patches a bit so that UEFI parts would go after generic=
 changes
>=20
> Series adds support for ACPI tables located above 4G. It adds 64-bit ha=
ndling
> necessary for testing arm/virt board (i.e. might be not complete wrt sp=
ec) and
> uses recently merged UEFI (AVMF) firmware/test disk image which provide=
s
> an entry point[1] for fetching ACPI tables (RSDP pointer).
>=20
> Git tree for testing:
>    https://github.com/imammedo/qemu.git acpi_arm_tests_v4
>=20
> Ref to previos vesrsion:
>    [PATCH v3 00/13] tests: acpi: add UEFI (ARM) testing support
>    https://www.mail-archive.com/qemu-devel@nongnu.org/msg612679.html
>=20
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: "Michael S. Tsirkin" <mst@redhat.com>
> CC: Gonglei <arei.gonglei@huawei.com>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> CC: Shannon Zhao <shannon.zhaosl@gmail.com>
> CC: Wei Yang <richardw.yang@linux.intel.com>
> CC: Andrew Jones <drjones@redhat.com>
> CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> CC: Ben Warren <ben@skyportsystems.com>
> CC: <xuwei5@hisilicon.com>
> CC: <xuwei5@huawei.com>
> CC: <shameerali.kolothum.thodi@huawei.com>
> CC: <linuxarm@huawei.com>
>=20
> Igor Mammedov (15):
>   tests: acpi: rename acpi_parse_rsdp_table() into
>     acpi_fetch_rsdp_table()
>   tests: acpi: make acpi_fetch_table() take size of fetched table
>     pointer
>   tests: acpi: make RSDT test routine handle XSDT
>   tests: acpi: make pointer to RSDP 64bit
>   tests: acpi: fetch X_DSDT if pointer to DSDT is 0
>   tests: acpi: skip FACS table if board uses hw reduced ACPI profile
>   tests: acpi: move boot_sector_init() into x86 tests branch
>   tests: acpi: add acpi_find_rsdp_address_uefi() helper
>   tests: acpi: add a way to start tests with UEFI firmware
>   tests: acpi: ignore SMBIOS tests when UEFI firmware is used
>   tests: acpi: allow to override default accelerator
>   tests: add expected ACPI tables for arm/virt board
>   tests: acpi: add simple arm/virt testcase
>   tests: acpi: refactor rebuild-expected-aml.sh to dump ACPI tables for
>     a specified list of targets
>   tests: acpi: print error unable to dump ACPI table during rebuild
>=20
>  tests/acpi-utils.h                      |   7 +-
>  tests/Makefile.include                  |   1 +
>  tests/acpi-utils.c                      |  68 +++++++++++----
>  tests/bios-tables-test.c                | 148 +++++++++++++++++++++++-=
--------
>  tests/data/acpi/rebuild-expected-aml.sh |  23 +++--
>  tests/data/acpi/virt/APIC               | Bin 0 -> 168 bytes
>  tests/data/acpi/virt/DSDT               | Bin 0 -> 18476 bytes
>  tests/data/acpi/virt/FACP               | Bin 0 -> 268 bytes
>  tests/data/acpi/virt/GTDT               | Bin 0 -> 96 bytes
>  tests/data/acpi/virt/MCFG               | Bin 0 -> 60 bytes
>  tests/data/acpi/virt/SPCR               | Bin 0 -> 80 bytes
>  tests/vmgenid-test.c                    |   6 +-
>  12 files changed, 178 insertions(+), 75 deletions(-)
>  create mode 100644 tests/data/acpi/virt/APIC
>  create mode 100644 tests/data/acpi/virt/DSDT
>  create mode 100644 tests/data/acpi/virt/FACP
>  create mode 100644 tests/data/acpi/virt/GTDT
>  create mode 100644 tests/data/acpi/virt/MCFG
>  create mode 100644 tests/data/acpi/virt/SPCR
>=20

Tested the series on the hisilicon D05 board(arm64 based), so FWIW:

Tested-by: Wei Xu <xuwei5@hisilicon.com>

Thanks!

Best Regards,
Wei
