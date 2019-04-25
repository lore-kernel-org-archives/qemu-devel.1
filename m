Received: from eggs.gnu.org ([209.51.188.92]:46879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJddG-0002SV-Ml
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJddE-00021p-Oh
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:42 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJddC-00020H-S0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 08:37:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so9057415wml.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 05:37:38 -0700 (PDT)
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-10-git-send-email-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b0d3f541-ead5-830a-2536-4af67f5845da@redhat.com>
Date: Thu, 25 Apr 2019 14:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <1556170489-131927-10-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 09/13] tests: acpi: ignore SMBIOS tests
 when UEFI firmware is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>, Wei Yang <richardw.yang@linux.intel.com>, Andrew Jones <drjones@redhat.com>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Ben Warren <ben@skyportsystems.com>

Hi Igor,

On 4/25/19 7:34 AM, Igor Mammedov wrote:
> once FW provides a pointer to SMBIOS entry point like it does for
> RSDP it should be possible to enable this one the same way.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> ---
> v3:
>   - add ref to a uefi-test-tools feature req into comment (Laszlo)
> ---
>  tests/bios-tables-test.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 0f24540..1be55a1 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -573,8 +573,15 @@ static void test_acpi_one(const char *params, test_data *data)
>          }
>      }
>  
> -    test_smbios_entry_point(data);
> -    test_smbios_structs(data);
> +    /*
> +     * TODO: make SMBIOS tests work with UEFI firmware,
> +     * Bug on uefi-test-tools to provide entry point:
> +     * https://bugs.launchpad.net/qemu/+bug/1821884
> +     */
> +    if (!use_uefi) {
> +        test_smbios_entry_point(data);
> +        test_smbios_structs(data);
> +    }

Now that Laszlo resolved this bug, you can update the SMBIOS tests :)

Without this patch I get:

ERROR:/home/phil/source/qemu/tests/bios-tables-test.c:460:test_smbios_entry_point:
assertion failed (off < 0x100000): (0x00100000 < 0x00100000)

And the UEFI console shows:

BdsDxe: failed to load Boot0001 "UEFI Misc Device" from
VenHw(93E34C7E-B50E-11DF-9223-2443DFD72085,00): Not Found
FatDiskIo: Cache Page OutBound occurred!
add-symbol-file
/home/lacos/src/upstream/qemu/tests/uefi-test-tools/Build/UefiTestTools/DEBUG_GCC5/AARCH64/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest/DEBUG/BiosTablesTest.dll
0x442C3000
Loading driver at 0x000442C2000 EntryPoint=0x000442C47AC BiosTablesTest.efi
InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 4654EE18
ProtectUefiImageCommon - 0x451AA140
  - 0x00000000442C2000 - 0x0000000000006000
SetUefiImageMemoryAttributes - 0x00000000442C2000 - 0x0000000000001000
(0x0000000000004008)
SetUefiImageMemoryAttributes - 0x00000000442C3000 - 0x0000000000003000
(0x0000000000020008)
SetUefiImageMemoryAttributes - 0x00000000442C6000 - 0x0000000000002000
(0x0000000000004008)
BdsDxe: starting Boot0002 "UEFI Misc Device 2" from
PciRoot(0x0)/Pci(0x2,0x0)
BiosTablesTest: BiosTablesTest=45100000 Rsdp10=0 Rsdp20=44020000
BiosTablesTest: Smbios21=0 Smbios30=47640000
BiosTablesTest: press any key to exit

>  
>      assert(!global_qtest);
>      qtest_quit(data->qts);
> 
