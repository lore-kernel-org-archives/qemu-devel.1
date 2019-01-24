Received: from eggs.gnu.org ([209.51.188.92]:57480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmltg-0005ji-8V
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gmlne-0001pV-Pk
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:40:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gmlne-0001oc-GY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 15:40:34 -0500
From: Laszlo Ersek <lersek@redhat.com>
Date: Thu, 24 Jan 2019 21:39:57 +0100
Message-Id: <20190124203959.30875-4-lersek@redhat.com>
In-Reply-To: <20190124203959.30875-1-lersek@redhat.com>
References: <20190124203959.30875-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/5] tests: introduce "uefi-test-tools" with
 the BiosTablesTest UEFI app
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel list <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

The "bios-tables-test" program in QEMU's test suite locates the RSD PTR
ACPI table in guest RAM, and (chasing pointers to other ACPI tables)
performs various sanity checks on the QEMU-generated and
firmware-installed tables.

Currently this set of test cases doesn't work with UEFI guests. The ACPI
spec defines distinct methods for OSPM to locate the RSD PTR on
traditional BIOS vs. UEFI platforms, and the UEFI method is more difficul=
t
to implement from the hypervisor side with just raw guest memory access.

Add a UEFI application (to be booted in the UEFI guest) that populates a
small, MB-aligned structure in guest RAM. The structure begins with a
signature GUID. The hypervisor should loop over all MB-aligned pages in
guest RAM until one matches the signature GUID at offset 0, at which poin=
t
the hypervisor can fetch the RSDP address field(s) from the structure.

QEMU's test logic currently spins on a pre-determined guest address, unti=
l
that address assumes a magic value. The method described in this patch is
conceptually the same ("busy loop until match is found"), except there is
no hard-coded address. This plays a lot more nicely with UEFI guest
firmware (we'll be able to use the normal page allocation UEFI service).
Given the size of EFI_GUID (16 bytes -- 128 bits), mismatches should be
astronomically unlikely. In addition, given the typical guest RAM size fo=
r
such tests (128 MB), there are 128 locations to check in one iteration of
the "outer" loop, which shouldn't introduce an intolerable delay after th=
e
guest stores the RSDP address(es), and then the GUID.

The GUID that the hypervisor should search for is

  AB87A6B1-2034-BDA0-71BD-375007757785

Expressed as a byte array:

 {
   0xb1, 0xa6, 0x87, 0xab,
   0x34, 0x20,
   0xa0, 0xbd,
   0x71, 0xbd, 0x37, 0x50, 0x07, 0x75, 0x77, 0x85
 }

Note that in the patch, we define "gBiosTablesTestGuid" with all bits
inverted. This is a simple method to prevent the UEFI binary, which
incorporates "gBiosTablesTestGuid", from matching the actual GUID in gues=
t
RAM.

The UEFI application is written against the edk2 framework, which was
introduced earlier as a git submodule. The next patch will provide build
scripts for maintainers.

The source code follows the edk2 coding style, and is licensed under the
2-clause BSDL (in case someone would like to include UefiTestToolsPkg
content in a different edk2 platform).

The "UefiTestToolsPkg.dsc" platform description file resolves the used
edk2 library classes to instances (=3D library implementations) such that
the UEFI binaries inherit no platform dependencies. They are expected to
run on any system that conforms to the UEFI-2.3.1 spec (which was release=
d
in 2012). The arch-specific build options are carried over from edk2's
ArmVirtPkg and OvmfPkg platforms.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    v2:
    - no change
   =20
    v1:
    - If that's necessary, I'd be glad to be designated as Maintainer or
      Reviewer in "MAINTAINERS" for "tests/uefi-test-tools/", I just
      couldn't figure out under what subsystem I should add the magic lin=
es.
      "MAINTAINERS" needs a Table of Contents! :)

 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec             =
 |  27 ++++
 tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc             =
 |  69 +++++++++++
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf=
 |  41 ++++++
 tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h    =
 |  67 ++++++++++
 tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.c  =
 | 130 ++++++++++++++++++++
 tests/uefi-test-tools/LICENSE                                           =
 |  25 ++++
 6 files changed, 359 insertions(+)

diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec =
b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec
new file mode 100644
index 000000000000..ed3a2fe11084
--- /dev/null
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dec
@@ -0,0 +1,27 @@
+## @file
+# edk2 package declaration for the test helper UEFI applications that ru=
n in
+# guests.
+#
+# Copyright (C) 2019, Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+##
+
+[Defines]
+  DEC_SPECIFICATION =3D 1.27
+  PACKAGE_NAME      =3D UefiTestToolsPkg
+  PACKAGE_GUID      =3D 7b3f1794-0c85-4b27-a536-44dbf0b0669c
+  PACKAGE_VERSION   =3D 0.1
+
+[Includes]
+  Include
+
+[Guids]
+  gBiosTablesTestGuid =3D {0x5478594e, 0xdfcb, 0x425f, {0x8e, 0x42, 0xc8=
, 0xaf, 0xf8, 0x8a, 0x88, 0x7a}}
+
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc =
b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
new file mode 100644
index 000000000000..c8511cd732bc
--- /dev/null
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/UefiTestToolsPkg.dsc
@@ -0,0 +1,69 @@
+## @file
+# edk2 platform description for the test helper UEFI applications that r=
un in
+# guests.
+#
+# Copyright (C) 2019, Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+##
+
+[Defines]
+  DSC_SPECIFICATION       =3D 1.28
+  PLATFORM_GUID           =3D 6750ccc1-8365-49f0-8437-948e516a9f55
+  PLATFORM_VERSION        =3D 0.1
+  PLATFORM_NAME           =3D UefiTestTools
+  SKUID_IDENTIFIER        =3D DEFAULT
+  SUPPORTED_ARCHITECTURES =3D ARM|AARCH64|IA32|X64
+  BUILD_TARGETS           =3D DEBUG
+
+[BuildOptions.IA32]
+  GCC:*_*_IA32_CC_FLAGS =3D -mno-mmx -mno-sse
+
+[BuildOptions.X64]
+  GCC:*_*_X64_CC_FLAGS =3D -mno-mmx -mno-sse
+
+[BuildOptions.ARM.EDKII.UEFI_APPLICATION]
+  GCC:*_*_ARM_DLINK_FLAGS =3D -z common-page-size=3D0x1000
+
+[BuildOptions.AARCH64.EDKII.UEFI_APPLICATION]
+  GCC:*_*_AARCH64_DLINK_FLAGS =3D -z common-page-size=3D0x1000
+
+[BuildOptions]
+  GCC:*_*_*_CC_FLAGS =3D -D DISABLE_NEW_DEPRECATED_INTERFACES
+
+[SkuIds]
+  0|DEFAULT
+
+[LibraryClasses]
+  BaseLib|MdePkg/Library/BaseLib/BaseLib.inf
+  DebugLib|MdePkg/Library/UefiDebugLibConOut/UefiDebugLibConOut.inf
+  DebugPrintErrorLevelLib|MdePkg/Library/BaseDebugPrintErrorLevelLib/Bas=
eDebugPrintErrorLevelLib.inf
+  DevicePathLib|MdePkg/Library/UefiDevicePathLibDevicePathProtocol/UefiD=
evicePathLibDevicePathProtocol.inf
+  MemoryAllocationLib|MdePkg/Library/UefiMemoryAllocationLib/UefiMemoryA=
llocationLib.inf
+  PcdLib|MdePkg/Library/BasePcdLibNull/BasePcdLibNull.inf
+  PrintLib|MdePkg/Library/BasePrintLib/BasePrintLib.inf
+  UefiApplicationEntryPoint|MdePkg/Library/UefiApplicationEntryPoint/Uef=
iApplicationEntryPoint.inf
+  UefiBootServicesTableLib|MdePkg/Library/UefiBootServicesTableLib/UefiB=
ootServicesTableLib.inf
+  UefiLib|MdePkg/Library/UefiLib/UefiLib.inf
+  UefiRuntimeServicesTableLib|MdePkg/Library/UefiRuntimeServicesTableLib=
/UefiRuntimeServicesTableLib.inf
+
+[LibraryClasses.ARM, LibraryClasses.AARCH64]
+  BaseMemoryLib|MdePkg/Library/BaseMemoryLibOptDxe/BaseMemoryLibOptDxe.i=
nf
+  NULL|ArmPkg/Library/CompilerIntrinsicsLib/CompilerIntrinsicsLib.inf
+  NULL|MdePkg/Library/BaseStackCheckLib/BaseStackCheckLib.inf
+
+[LibraryClasses.IA32, LibraryClasses.X64]
+  BaseMemoryLib|MdePkg/Library/BaseMemoryLibRepStr/BaseMemoryLibRepStr.i=
nf
+
+[PcdsFixedAtBuild]
+  gEfiMdePkgTokenSpaceGuid.PcdDebugPrintErrorLevel|0x8040004F
+  gEfiMdePkgTokenSpaceGuid.PcdDebugPropertyMask|0x2F
+
+[Components]
+  UefiTestToolsPkg/BiosTablesTest/BiosTablesTest.inf
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.inf b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/Bios=
TablesTest.inf
new file mode 100644
index 000000000000..924d8a80d00b
--- /dev/null
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.inf
@@ -0,0 +1,41 @@
+## @file
+# Populate the BIOS_TABLES_TEST structure.
+#
+# Copyright (C) 2019, Red Hat, Inc.
+#
+# This program and the accompanying materials are licensed and made avai=
lable
+# under the terms and conditions of the BSD License that accompanies thi=
s
+# distribution. The full text of the license may be found at
+# <http://opensource.org/licenses/bsd-license.php>.
+#
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+# WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+##
+
+[Defines]
+  INF_VERSION                =3D 1.27
+  BASE_NAME                  =3D BiosTablesTest
+  UEFI_SPECIFICATION_VERSION =3D 2.31
+  FILE_GUID                  =3D 87f00433-3b7c-45c3-ae78-a56495bd4e62
+  MODULE_TYPE                =3D UEFI_APPLICATION
+  ENTRY_POINT                =3D BiosTablesTestMain
+
+[Sources]
+  BiosTablesTest.c
+
+[LibraryClasses]
+  BaseLib
+  BaseMemoryLib
+  MemoryAllocationLib
+  UefiApplicationEntryPoint
+  UefiBootServicesTableLib
+  UefiLib
+
+[Guids]
+  gBiosTablesTestGuid
+  gEfiAcpi10TableGuid
+  gEfiAcpi20TableGuid
+
+[Packages]
+  MdePkg/MdePkg.dec
+  UefiTestToolsPkg/UefiTestToolsPkg.dec
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTabl=
esTest.h b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTables=
Test.h
new file mode 100644
index 000000000000..0b72c61254af
--- /dev/null
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.=
h
@@ -0,0 +1,67 @@
+/** @file
+  Expose the address(es) of the ACPI RSD PTR table(s) in a MB-aligned st=
ructure
+  to the hypervisor.
+
+  The hypervisor locates the MB-aligned structure based on the signature=
 GUID
+  that is at offset 0 in the structure. Once the RSD PTR address(es) are
+  retrieved, the hypervisor may perform various ACPI checks.
+
+  This feature is a development aid, for supporting ACPI table unit test=
s in
+  hypervisors. Do not enable in production builds.
+
+  Copyright (C) 2019, Red Hat, Inc.
+
+  This program and the accompanying materials are licensed and made avai=
lable
+  under the terms and conditions of the BSD License that accompanies thi=
s
+  distribution. The full text of the license may be found at
+  <http://opensource.org/licenses/bsd-license.php>.
+
+  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+  WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+**/
+
+#ifndef __BIOS_TABLES_TEST_H__
+#define __BIOS_TABLES_TEST_H__
+
+#include <Uefi/UefiBaseType.h>
+
+#define BIOS_TABLES_TEST_GUID                          \
+  {                                                    \
+    0x5478594e,                                        \
+    0xdfcb,                                            \
+    0x425f,                                            \
+    { 0x8e, 0x42, 0xc8, 0xaf, 0xf8, 0x8a, 0x88, 0x7a } \
+  }
+
+extern EFI_GUID gBiosTablesTestGuid;
+
+//
+// The following structure must be allocated in Boot Services Data type =
memory,
+// aligned at a 1MB boundary.
+//
+#pragma pack (1)
+typedef struct {
+  //
+  // The signature GUID is written to the MB-aligned structure from
+  // gBiosTablesTestGuid, but with all bits inverted. That's the actual =
GUID
+  // value that the hypervisor should look for at each MB boundary, loop=
ing
+  // over all guest RAM pages with that alignment, until a match is foun=
d. The
+  // bit-flipping occurs in order not to store the actual GUID in any UE=
FI
+  // executable, which might confuse guest memory analysis. Note that EF=
I_GUID
+  // has little endian representation.
+  //
+  EFI_GUID             InverseSignatureGuid;
+  //
+  // The Rsdp10 and Rsdp20 fields may be read when the signature GUID ma=
tches.
+  // Rsdp10 is the guest-physical address of the ACPI 1.0 specification =
RSD PTR
+  // table, in 8-byte little endian representation. Rsdp20 is the same, =
for the
+  // ACPI 2.0 or later specification RSD PTR table. Each of these fields=
 may be
+  // zero (independently of the other) if the UEFI System Table does not
+  // provide the corresponding UEFI Configuration Table.
+  //
+  EFI_PHYSICAL_ADDRESS Rsdp10;
+  EFI_PHYSICAL_ADDRESS Rsdp20;
+} BIOS_TABLES_TEST;
+#pragma pack ()
+
+#endif // __BIOS_TABLES_TEST_H__
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.c b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTa=
blesTest.c
new file mode 100644
index 000000000000..b208e17fb00f
--- /dev/null
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/BiosTablesTest/BiosTablesTes=
t.c
@@ -0,0 +1,130 @@
+/** @file
+  Populate the BIOS_TABLES_TEST structure.
+
+  Copyright (C) 2019, Red Hat, Inc.
+
+  This program and the accompanying materials are licensed and made avai=
lable
+  under the terms and conditions of the BSD License that accompanies thi=
s
+  distribution. The full text of the license may be found at
+  <http://opensource.org/licenses/bsd-license.php>.
+
+  THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS, =
WITHOUT
+  WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
+**/
+
+#include <Guid/Acpi.h>
+#include <Guid/BiosTablesTest.h>
+#include <Library/BaseLib.h>
+#include <Library/BaseMemoryLib.h>
+#include <Library/MemoryAllocationLib.h>
+#include <Library/UefiBootServicesTableLib.h>
+#include <Library/UefiLib.h>
+
+/**
+  Wait for a keypress with a message that the application is about to ex=
it.
+**/
+STATIC
+VOID
+WaitForExitKeyPress (
+  VOID
+  )
+{
+  EFI_STATUS    Status;
+  UINTN         Idx;
+  EFI_INPUT_KEY Key;
+
+  if (gST->ConIn =3D=3D NULL) {
+    return;
+  }
+  AsciiPrint ("%a: press any key to exit\n", gEfiCallerBaseName);
+  Status =3D gBS->WaitForEvent (1, &gST->ConIn->WaitForKey, &Idx);
+  if (EFI_ERROR (Status)) {
+    return;
+  }
+  gST->ConIn->ReadKeyStroke (gST->ConIn, &Key);
+}
+
+EFI_STATUS
+EFIAPI
+BiosTablesTestMain (
+  IN EFI_HANDLE       ImageHandle,
+  IN EFI_SYSTEM_TABLE *SystemTable
+  )
+{
+  VOID                          *Pages;
+  volatile BIOS_TABLES_TEST     *BiosTablesTest;
+  CONST VOID                    *Rsdp10;
+  CONST VOID                    *Rsdp20;
+  CONST EFI_CONFIGURATION_TABLE *ConfigTable;
+  CONST EFI_CONFIGURATION_TABLE *ConfigTablesEnd;
+  volatile EFI_GUID             *InverseSignature;
+  UINTN                         Idx;
+
+  Pages =3D AllocateAlignedPages (EFI_SIZE_TO_PAGES (sizeof *BiosTablesT=
est),
+            SIZE_1MB);
+  if (Pages =3D=3D NULL) {
+    AsciiErrorPrint ("%a: AllocateAlignedPages() failed\n",
+      gEfiCallerBaseName);
+    //
+    // Assuming the application was launched by the boot manager as a bo=
ot
+    // loader, exiting with error will cause the boot manager to proceed=
 with
+    // the remaining boot options. If there are no other boot options, t=
he boot
+    // manager menu will be pulled up. Give the user a chance to read th=
e error
+    // message.
+    //
+    WaitForExitKeyPress ();
+    return EFI_OUT_OF_RESOURCES;
+  }
+
+  //
+  // Locate both gEfiAcpi10TableGuid and gEfiAcpi20TableGuid config tabl=
es in
+  // one go.
+  //
+  Rsdp10 =3D NULL;
+  Rsdp20 =3D NULL;
+  ConfigTable =3D gST->ConfigurationTable;
+  ConfigTablesEnd =3D gST->ConfigurationTable + gST->NumberOfTableEntrie=
s;
+  while ((Rsdp10 =3D=3D NULL || Rsdp20 =3D=3D NULL) && ConfigTable < Con=
figTablesEnd) {
+    if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi10TableGuid)) {
+      Rsdp10 =3D ConfigTable->VendorTable;
+    } else if (CompareGuid (&ConfigTable->VendorGuid, &gEfiAcpi20TableGu=
id)) {
+      Rsdp20 =3D ConfigTable->VendorTable;
+    }
+    ++ConfigTable;
+  }
+
+  AsciiPrint ("%a: BiosTablesTest=3D%p Rsdp10=3D%p Rsdp20=3D%p\n",
+    gEfiCallerBaseName, Pages, Rsdp10, Rsdp20);
+
+  //
+  // Store the RSD PTR address(es) first, then the signature second.
+  //
+  BiosTablesTest =3D Pages;
+  BiosTablesTest->Rsdp10 =3D (UINTN)Rsdp10;
+  BiosTablesTest->Rsdp20 =3D (UINTN)Rsdp20;
+
+  MemoryFence();
+
+  InverseSignature =3D &BiosTablesTest->InverseSignatureGuid;
+  InverseSignature->Data1  =3D gBiosTablesTestGuid.Data1;
+  InverseSignature->Data1 ^=3D MAX_UINT32;
+  InverseSignature->Data2  =3D gBiosTablesTestGuid.Data2;
+  InverseSignature->Data2 ^=3D MAX_UINT16;
+  InverseSignature->Data3  =3D gBiosTablesTestGuid.Data3;
+  InverseSignature->Data3 ^=3D MAX_UINT16;
+  for (Idx =3D 0; Idx < sizeof InverseSignature->Data4; ++Idx) {
+    InverseSignature->Data4[Idx]  =3D gBiosTablesTestGuid.Data4[Idx];
+    InverseSignature->Data4[Idx] ^=3D MAX_UINT8;
+  }
+
+  //
+  // The wait below has dual purpose. First, it blocks the application w=
ithout
+  // wasting VCPU cycles while the hypervisor is scanning guest RAM. Sec=
ond,
+  // assuming the application was launched by the boot manager as a boot
+  // loader, exiting the app with success causes the boot manager to pul=
l up
+  // the boot manager menu at once (regardless of other boot options); t=
he wait
+  // gives the user a chance to read the info printed above.
+  //
+  WaitForExitKeyPress ();
+  return EFI_SUCCESS;
+}
diff --git a/tests/uefi-test-tools/LICENSE b/tests/uefi-test-tools/LICENS=
E
new file mode 100644
index 000000000000..38b78aecdb0e
--- /dev/null
+++ b/tests/uefi-test-tools/LICENSE
@@ -0,0 +1,25 @@
+All the files in this directory and subdirectories are released under th=
e
+2-Clause BSD License (see header in each file).
+
+Copyright (C) 2019, Red Hat, Inc.
+
+Redistribution and use in source and binary forms, with or without
+modification, are permitted provided that the following conditions are m=
et:
+
+1. Redistributions of source code must retain the above copyright notice=
, this
+   list of conditions and the following disclaimer.
+
+2. Redistributions in binary form must reproduce the above copyright not=
ice,
+   this list of conditions and the following disclaimer in the documenta=
tion
+   and/or other materials provided with the distribution.
+
+THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS =
IS" AND
+ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IM=
PLIED
+WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LI=
ABLE
+FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI=
AL
+DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =
OR
+SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEV=
ER
+CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABI=
LITY,
+OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF TH=
E USE
+OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--=20
2.19.1.3.g30247aa5d201
