Received: from eggs.gnu.org ([209.51.188.92]:48044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMCzE-00015R-Do
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:47:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMCzC-0000o9-Gg
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:47:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hMCzC-0000nj-8I
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:46:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FC9C30832C5
	for <qemu-devel@nongnu.org>; Thu,  2 May 2019 14:46:57 +0000 (UTC)
Date: Thu, 2 May 2019 16:46:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190502164652.30964a2b@Igors-MacBook-Pro>
In-Reply-To: <20190425104326.12835-2-lersek@redhat.com>
References: <20190425104326.12835-1-lersek@redhat.com>
	<20190425104326.12835-2-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Philippe =?UTF-8?Q?Mathieu-Da?= =?UTF-8?Q?ud=C3=A9?= <philmd@redhat.com>

On Thu, 25 Apr 2019 12:43:25 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On UEFI systems, the SMBIOS entry point (a.k.a. anchor) structures are
> found similarly to the ACPI RSD PTR table(s): by scanning the
> ConfigurationTable array in the EFI system table for well-known GUIDs.
>=20
> Locate the SMBIOS 2.1 (32-bit) and 3.0 (64-bit) anchors in the
> BiosTablesTest UEFI application, and report the addresses in new fields
> appended to the BIOS_TABLES_TEST structure.
>=20
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Launchpad: https://bugs.launchpad.net/qemu/+bug/1821884
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h    =
 | 25 +++++++++++++++-----
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf=
 |  2 ++
>  tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c  =
 | 23 ++++++++++++++----
>  3 files changed, 40 insertions(+), 10 deletions(-)
>=20
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTabl=
esTest.h b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTe=
st.h
> index 0b72c61254af..7a74c121d596 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
> @@ -1,13 +1,14 @@
>  /** @file
> -  Expose the address(es) of the ACPI RSD PTR table(s) in a MB-aligned st=
ructure
> -  to the hypervisor.
> +  Expose the address(es) of the ACPI RSD PTR table(s) and the SMBIOS ent=
ry
> +  point(s) in a MB-aligned structure to the hypervisor.
> =20
>    The hypervisor locates the MB-aligned structure based on the signature=
 GUID
> -  that is at offset 0 in the structure. Once the RSD PTR address(es) are
> -  retrieved, the hypervisor may perform various ACPI checks.
> +  that is at offset 0 in the structure. Once the RSD PTR and SMBIOS anch=
or
> +  address(es) are retrieved, the hypervisor may perform various ACPI and=
 SMBIOS
> +  checks.
> =20
> -  This feature is a development aid, for supporting ACPI table unit test=
s in
> -  hypervisors. Do not enable in production builds.
> +  This feature is a development aid, for supporting ACPI and SMBIOS tabl=
e unit
> +  tests in hypervisors. Do not enable in production builds.
> =20
>    Copyright (C) 2019, Red Hat, Inc.
> =20
> @@ -61,6 +62,18 @@ typedef struct {
>    //
>    EFI_PHYSICAL_ADDRESS Rsdp10;
>    EFI_PHYSICAL_ADDRESS Rsdp20;
> +  //
> +  // The Smbios21 and Smbios30 fields may be read when the signature GUID
> +  // matches. Smbios21 is the guest-physical address of the SMBIOS 2.1 (=
32-bit)
> +  // Entry Point Structure from the SMBIOS v3.2.0 specification, in 8-by=
te
> +  // little endian representation. Smbios30 is the guest-physical addres=
s of
> +  // the SMBIOS 3.0 (64-bit) Entry Point Structure from the same specifi=
cation,
> +  // in the same representation. Each of these fields may be zero
> +  // (independently of the other) if the UEFI System Table does not prov=
ide the
> +  // corresponding UEFI Configuration Table.
> +  //
> +  EFI_PHYSICAL_ADDRESS Smbios21;
> +  EFI_PHYSICAL_ADDRESS Smbios30;
>  } BIOS_TABLES_TEST;
>  #pragma pack ()
> =20
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.inf b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.inf
> index 924d8a80d00b..708bc1e7982b 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.inf
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.inf
> @@ -35,6 +35,8 @@
>    gBiosTablesTestGuid
>    gEfiAcpi10TableGuid
>    gEfiAcpi20TableGuid
> +  gEfiSmbios3TableGuid
> +  gEfiSmbiosTableGuid
> =20
>  [Packages]
>    MdePkg/MdePkg.dec
> diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.c b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTabl=
esTest.c
> index b208e17fb00f..75891e68ec20 100644
> --- a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.c
> +++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.c
> @@ -14,6 +14,7 @@
> =20
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
> =20
>    //
> -  // Locate both gEfiAcpi10TableGuid and gEfiAcpi20TableGuid config tabl=
es in
> -  // one go.
> +  // Locate all the gEfiAcpi10TableGuid, gEfiAcpi20TableGuid,
> +  // gEfiSmbiosTableGuid, gEfiSmbios3TableGuid config tables in one go.
>    //
>    Rsdp10 =3D NULL;
>    Rsdp20 =3D NULL;
> +  Smbios21 =3D NULL;
> +  Smbios30 =3D NULL;
>    ConfigTable =3D gST->ConfigurationTable;
>    ConfigTablesEnd =3D gST->ConfigurationTable + gST->NumberOfTableEntrie=
s;
> -  while ((Rsdp10 =3D=3D NULL || Rsdp20 =3D=3D NULL) && ConfigTable < Con=
figTablesEnd) {
> +  while ((Rsdp10 =3D=3D NULL || Rsdp20 =3D=3D NULL ||
> +          Smbios21 =3D=3D NULL || Smbios30 =3D=3D NULL) &&
> +         ConfigTable < ConfigTablesEnd) {
>      if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi10TableGuid)) {
>        Rsdp10 =3D ConfigTable->VendorTable;
>      } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi20TableGu=
id)) {
>        Rsdp20 =3D ConfigTable->VendorTable;
> +    } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiSmbiosTableGu=
id)) {
> +      Smbios21 =3D ConfigTable->VendorTable;
> +    } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiSmbios3TableG=
uid)) {
> +      Smbios30 =3D ConfigTable->VendorTable;
>      }
>      ++ConfigTable;
>    }
> =20
>    AsciiPrint ("%a: BiosTablesTest=3D%p Rsdp10=3D%p Rsdp20=3D%p\n",
>      gEfiCallerBaseName, Pages, Rsdp10, Rsdp20);
> +  AsciiPrint ("%a: Smbios21=3D%p Smbios30=3D%p\n", gEfiCallerBaseName, S=
mbios21,
> +    Smbios30);
> =20
>    //
> -  // Store the RSD PTR address(es) first, then the signature second.
> +  // Store the config table addresses first, then the signature second.
>    //
>    BiosTablesTest =3D Pages;
>    BiosTablesTest->Rsdp10 =3D (UINTN)Rsdp10;
>    BiosTablesTest->Rsdp20 =3D (UINTN)Rsdp20;
> +  BiosTablesTest->Smbios21 =3D (UINTN)Smbios21;
> +  BiosTablesTest->Smbios30 =3D (UINTN)Smbios30;
> =20
>    MemoryFence();
> =20
