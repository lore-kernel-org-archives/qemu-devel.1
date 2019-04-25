Received: from eggs.gnu.org ([209.51.188.92]:36215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcje-0002cp-Hs
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJcjc-000270-Gk
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:40:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJcjb-00024y-5Z
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:40:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so10088946wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 04:40:10 -0700 (PDT)
References: <20190425104326.12835-1-lersek@redhat.com>
	<20190425104326.12835-2-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4587ee04-9b08-f616-3d2e-3fa2d6dfcac3@redhat.com>
Date: Thu, 25 Apr 2019 13:40:07 +0200
MIME-Version: 1.0
In-Reply-To: <20190425104326.12835-2-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu devel list <qemu-devel@nongnu.org>
Cc: Igor Mammedov <imammedo@redhat.com>

On 4/25/19 12:43 PM, Laszlo Ersek wrote:
> On UEFI systems, the SMBIOS entry point (a.k.a. anchor) structures are
> found similarly to the ACPI RSD PTR table(s): by scanning the
> ConfigurationTable array in the EFI system table for well-known GUIDs.
> 
> Locate the SMBIOS 2.1 (32-bit) and 3.0 (64-bit) anchors in the
> BiosTablesTest UEFI application, and report the addresses in new fields
> appended to the BIOS_TABLES_TEST structure.
> 
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h     | 25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf |  2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c   | 23 ++++++++++++++----
>  3 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> index 0b72c61254af..7a74c121d596 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> @@ -1,13 +1,14 @@
>  /** @file
> -  Expose the address(es) of the ACPI RSD PTR table(s) in a MB-aligned structure
> -  to the hypervisor.
> +  Expose the address(es) of the ACPI RSD PTR table(s) and the SMBIOS entry
> +  point(s) in a MB-aligned structure to the hypervisor.
>  
>    The hypervisor locates the MB-aligned structure based on the signature GUID
> -  that is at offset 0 in the structure. Once the RSD PTR address(es) are
> -  retrieved, the hypervisor may perform various ACPI checks.
> +  that is at offset 0 in the structure. Once the RSD PTR and SMBIOS anchor
> +  address(es) are retrieved, the hypervisor may perform various ACPI and SMBIOS
> +  checks.
>  
> -  This feature is a development aid, for supporting ACPI table unit tests in
> -  hypervisors. Do not enable in production builds.
> +  This feature is a development aid, for supporting ACPI and SMBIOS table unit
> +  tests in hypervisors. Do not enable in production builds.
>  
>    Copyright (C) 2019, Red Hat, Inc.
>  
> @@ -61,6 +62,18 @@ typedef struct {
>    //
>    EFI_PHYSICAL_ADDRESS Rsdp10;
>    EFI_PHYSICAL_ADDRESS Rsdp20;
> +  //
> +  // The Smbios21 and Smbios30 fields may be read when the signature GUID
> +  // matches. Smbios21 is the guest-physical address of the SMBIOS 2.1 (32-bit)
> +  // Entry Point Structure from the SMBIOS v3.2.0 specification, in 8-byte
> +  // little endian representation. Smbios30 is the guest-physical address of
> +  // the SMBIOS 3.0 (64-bit) Entry Point Structure from the same specification,
> +  // in the same representation. Each of these fields may be zero
> +  // (independently of the other) if the UEFI System Table does not provide the
> +  // corresponding UEFI Configuration Table.
> +  //
> +  EFI_PHYSICAL_ADDRESS Smbios21;
> +  EFI_PHYSICAL_ADDRESS Smbios30;
>  } BIOS_TABLES_TEST;
>  #pragma pack ()
>  
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf
> index 924d8a80d00b..708bc1e7982b 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf
> @@ -35,6 +35,8 @@
>    gBiosTablesTestGuid
>    gEfiAcpi10TableGuid
>    gEfiAcpi20TableGuid
> +  gEfiSmbios3TableGuid
> +  gEfiSmbiosTableGuid
>  
>  [Packages]
>    MdePkg/MdePkg.dec
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
> index b208e17fb00f..75891e68ec20 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c
> @@ -14,6 +14,7 @@
>  
>  #include <Guid/Acpi.h>
>  #include <Guid/BiosTablesTest.h>
> +#include <Guid/SmBios.h>
>  #include <Library/BaseLib.h>
>  #include <Library/BaseMemoryLib.h>
>  #include <Library/MemoryAllocationLib.h>
> @@ -55,6 +56,8 @@ BiosTablesTestMain (
>    volatile BIOS_TABLES_TEST     *BiosTablesTest;
>    CONST VOID                    *Rsdp10;
>    CONST VOID                    *Rsdp20;
> +  CONST VOID                    *Smbios21;
> +  CONST VOID                    *Smbios30;
>    CONST EFI_CONFIGURATION_TABLE *ConfigTable;
>    CONST EFI_CONFIGURATION_TABLE *ConfigTablesEnd;
>    volatile EFI_GUID             *InverseSignature;
> @@ -77,31 +80,43 @@ BiosTablesTestMain (
>    }
>  
>    //
> -  // Locate both gEfiAcpi10TableGuid and gEfiAcpi20TableGuid config tables in
> -  // one go.
> +  // Locate all the gEfiAcpi10TableGuid, gEfiAcpi20TableGuid,
> +  // gEfiSmbiosTableGuid, gEfiSmbios3TableGuid config tables in one go.
>    //
>    Rsdp10 = NULL;
>    Rsdp20 = NULL;
> +  Smbios21 = NULL;
> +  Smbios30 = NULL;
>    ConfigTable = gST->ConfigurationTable;
>    ConfigTablesEnd = gST->ConfigurationTable + gST->NumberOfTableEntries;
> -  while ((Rsdp10 == NULL || Rsdp20 == NULL) && ConfigTable < ConfigTablesEnd) {
> +  while ((Rsdp10 == NULL || Rsdp20 == NULL ||
> +          Smbios21 == NULL || Smbios30 == NULL) &&
> +         ConfigTable < ConfigTablesEnd) {
>      if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi10TableGuid)) {
>        Rsdp10 = ConfigTable->VendorTable;
>      } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi20TableGuid)) {
>        Rsdp20 = ConfigTable->VendorTable;
> +    } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiSmbiosTableGuid)) {
> +      Smbios21 = ConfigTable->VendorTable;
> +    } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiSmbios3TableGuid)) {
> +      Smbios30 = ConfigTable->VendorTable;
>      }
>      ++ConfigTable;
>    }
>  
>    AsciiPrint ("%a: BiosTablesTest=%p Rsdp10=%p Rsdp20=%p\n",
>      gEfiCallerBaseName, Pages, Rsdp10, Rsdp20);
> +  AsciiPrint ("%a: Smbios21=%p Smbios30=%p\n", gEfiCallerBaseName, Smbios21,
> +    Smbios30);
>  
>    //
> -  // Store the RSD PTR address(es) first, then the signature second.
> +  // Store the config table addresses first, then the signature second.
>    //
>    BiosTablesTest = Pages;
>    BiosTablesTest->Rsdp10 = (UINTN)Rsdp10;
>    BiosTablesTest->Rsdp20 = (UINTN)Rsdp20;
> +  BiosTablesTest->Smbios21 = (UINTN)Smbios21;
> +  BiosTablesTest->Smbios30 = (UINTN)Smbios30;
>  
>    MemoryFence();
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
