Received: from eggs.gnu.org ([2001:4830:134:3::10]:43000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmG-0002Nx-WF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1euHmE-0006PP-KW
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1euHmE-0006Ok-E7
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:09:38 -0500
From: marcandre.lureau@redhat.com
Date: Fri,  9 Mar 2018 14:09:15 +0100
Message-Id: <20180309130918.734-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180309130918.734-1-marcandre.lureau@redhat.com>
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/7] OvmfPkg: add customized Tcg2ConfigPei
 clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, lersek@redhat.com, qemu-devel@nongnu.org, javierm@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The Tcg2ConfigPei module informs the firmware globally about the TPM
device type, by setting the PcdTpmInstanceGuid PCD to the appropriate
GUID value. The original module under SecurityPkg can perform device
detection, or read a cached value from a non-volatile UEFI variable.

OvmfPkg's clone of the module only performs the TPM2 hardware detection.

This is what the module does:

- Check the QEMU hardware for TPM2 availability only

- If found, set the dynamic PCD "PcdTpmInstanceGuid" to
  &gEfiTpmDeviceInstanceTpm20DtpmGuid. This is what informs the rest of
  the firmware about the TPM type.

- Install the gEfiTpmDeviceSelectedGuid PPI. This action permits the
  PEI_CORE to dispatch the Tcg2Pei module, which consumes the above PCD.
  In effect, the gEfiTpmDeviceSelectedGuid PPI serializes the setting
  and the consumption of the "TPM type" PCD.

- If no TPM2 was found, install gPeiTpmInitializationDonePpiGuid.
  (Normally this is performed by Tcg2Pei, but Tcg2Pei doesn't do it if
  no TPM2 is available. So in that case our Tcg2ConfigPei must do it.)

Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 OvmfPkg/OvmfPkgIa32.dsc                  | 17 +++++
 OvmfPkg/OvmfPkgIa32.fdf                  |  4 ++
 OvmfPkg/OvmfPkgIa32X64.dsc               | 17 +++++
 OvmfPkg/OvmfPkgIa32X64.fdf               |  4 ++
 OvmfPkg/OvmfPkgX64.dsc                   | 17 +++++
 OvmfPkg/OvmfPkgX64.fdf                   |  4 ++
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf | 53 +++++++++++++++
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c  | 84 ++++++++++++++++++++++++
 8 files changed, 200 insertions(+)
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c

diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
index 5bd3f4f977df..ef25e5037028 100644
--- a/OvmfPkg/OvmfPkgIa32.dsc
+++ b/OvmfPkg/OvmfPkgIa32.dsc
@@ -39,6 +39,7 @@ [Defines]
   DEFINE HTTP_BOOT_ENABLE        =3D FALSE
   DEFINE SMM_REQUIRE             =3D FALSE
   DEFINE TLS_ENABLE              =3D FALSE
+  DEFINE TPM2_ENABLE             =3D FALSE
=20
   #
   # Flash size selection. Setting FD_SIZE_IN_KB on the command line dire=
ctly to
@@ -203,6 +204,10 @@ [LibraryClasses]
   OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTreeL=
ib/BaseOrderedCollectionRedBlackTreeLib.inf
   XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
+!endif
+
 [LibraryClasses.common]
   BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
=20
@@ -267,6 +272,10 @@ [LibraryClasses.common.PEIM]
   PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
+!endif
+
 [LibraryClasses.common.DXE_CORE]
   HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
   DxeCoreEntryPoint|MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint.i=
nf
@@ -547,6 +556,10 @@ [PcdsDynamicDefault]
=20
   gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x00
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0}
+!endif
+
 ########################################################################=
########
 #
 # Components Section - list of all EDK II Modules needed by this Platfor=
m.
@@ -593,6 +606,10 @@ [Components]
 !endif
   UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
   #
   # DXE Phase modules
   #
diff --git a/OvmfPkg/OvmfPkgIa32.fdf b/OvmfPkg/OvmfPkgIa32.fdf
index ba980834d720..76f35e859eca 100644
--- a/OvmfPkg/OvmfPkgIa32.fdf
+++ b/OvmfPkg/OvmfPkgIa32.fdf
@@ -165,6 +165,10 @@ [FV.PEIFV]
 !endif
 INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
 ########################################################################=
########
=20
 [FV.DXEFV]
diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
index 7dded86c4940..0364dafdcb3a 100644
--- a/OvmfPkg/OvmfPkgIa32X64.dsc
+++ b/OvmfPkg/OvmfPkgIa32X64.dsc
@@ -39,6 +39,7 @@ [Defines]
   DEFINE HTTP_BOOT_ENABLE        =3D FALSE
   DEFINE SMM_REQUIRE             =3D FALSE
   DEFINE TLS_ENABLE              =3D FALSE
+  DEFINE TPM2_ENABLE             =3D FALSE
=20
   #
   # Flash size selection. Setting FD_SIZE_IN_KB on the command line dire=
ctly to
@@ -208,6 +209,10 @@ [LibraryClasses]
   OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTreeL=
ib/BaseOrderedCollectionRedBlackTreeLib.inf
   XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
+!endif
+
 [LibraryClasses.common]
   BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
=20
@@ -272,6 +277,10 @@ [LibraryClasses.common.PEIM]
   PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
+!endif
+
 [LibraryClasses.common.DXE_CORE]
   HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
   DxeCoreEntryPoint|MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint.i=
nf
@@ -555,6 +564,10 @@ [PcdsDynamicDefault]
=20
   gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x00
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0}
+!endif
+
 ########################################################################=
########
 #
 # Components Section - list of all EDK II Modules needed by this Platfor=
m.
@@ -601,6 +614,10 @@ [Components.IA32]
 !endif
   UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
 [Components.X64]
   #
   # DXE Phase modules
diff --git a/OvmfPkg/OvmfPkgIa32X64.fdf b/OvmfPkg/OvmfPkgIa32X64.fdf
index 72ac82e76b7b..16c67fa90c75 100644
--- a/OvmfPkg/OvmfPkgIa32X64.fdf
+++ b/OvmfPkg/OvmfPkgIa32X64.fdf
@@ -165,6 +165,10 @@ [FV.PEIFV]
 !endif
 INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
 ########################################################################=
########
=20
 [FV.DXEFV]
diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index a8e89276c0b2..a2845804fc4b 100644
--- a/OvmfPkg/OvmfPkgX64.dsc
+++ b/OvmfPkg/OvmfPkgX64.dsc
@@ -39,6 +39,7 @@ [Defines]
   DEFINE HTTP_BOOT_ENABLE        =3D FALSE
   DEFINE SMM_REQUIRE             =3D FALSE
   DEFINE TLS_ENABLE              =3D FALSE
+  DEFINE TPM2_ENABLE             =3D FALSE
=20
   #
   # Flash size selection. Setting FD_SIZE_IN_KB on the command line dire=
ctly to
@@ -208,6 +209,10 @@ [LibraryClasses]
   OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTreeL=
ib/BaseOrderedCollectionRedBlackTreeLib.inf
   XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
+!endif
+
 [LibraryClasses.common]
   BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
=20
@@ -272,6 +277,10 @@ [LibraryClasses.common.PEIM]
   PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
   QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTpm.=
inf
+!endif
+
 [LibraryClasses.common.DXE_CORE]
   HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
   DxeCoreEntryPoint|MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint.i=
nf
@@ -554,6 +563,10 @@ [PcdsDynamicDefault]
=20
   gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x00
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0x00, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0=
0}
+!endif
+
 ########################################################################=
########
 #
 # Components Section - list of all EDK II Modules needed by this Platfor=
m.
@@ -600,6 +613,10 @@ [Components]
 !endif
   UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
   #
   # DXE Phase modules
   #
diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
index 2fc17810eb23..dbafada5226b 100644
--- a/OvmfPkg/OvmfPkgX64.fdf
+++ b/OvmfPkg/OvmfPkgX64.fdf
@@ -165,6 +165,10 @@ [FV.PEIFV]
 !endif
 INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
=20
+!if $(TPM2_ENABLE) =3D=3D TRUE
+INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
+!endif
+
 ########################################################################=
########
=20
 [FV.DXEFV]
diff --git a/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf b/OvmfPkg/Tcg/Tcg2C=
onfig/Tcg2ConfigPei.inf
new file mode 100644
index 000000000000..234cdd6cb40c
--- /dev/null
+++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
@@ -0,0 +1,53 @@
+## @file
+#  Set TPM device type
+#
+#  In SecurityPkg, this module initializes the TPM device type based on
+#  a UEFI variable and/or hardware detection. In OvmfPkg, the module
+#  only performs TPM2 hardware detection.
+#
+# Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.<BR>
+# Copyright (C) 2018, Red Hat, Inc.
+#
+# This program and the accompanying materials
+# are licensed and made available under the terms and conditions of the =
BSD License
+# which accompanies this distribution. The full text of the license may =
be found at
+# http://opensource.org/licenses/bsd-license.php
+# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
+# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR I=
MPLIED.
+#
+##
+
+[Defines]
+  INF_VERSION                    =3D 0x00010005
+  BASE_NAME                      =3D Tcg2ConfigPei
+  FILE_GUID                      =3D BF7F2B0C-9F2F-4889-AB5C-12460022BE8=
7
+  MODULE_TYPE                    =3D PEIM
+  VERSION_STRING                 =3D 1.0
+  ENTRY_POINT                    =3D Tcg2ConfigPeimEntryPoint
+
+[Sources]
+  Tcg2ConfigPeim.c
+
+[Packages]
+  MdePkg/MdePkg.dec
+  MdeModulePkg/MdeModulePkg.dec
+  SecurityPkg/SecurityPkg.dec
+
+[LibraryClasses]
+  PeimEntryPoint
+  DebugLib
+  PeiServicesLib
+  Tpm2DeviceLib
+
+[Guids]
+  gEfiTpmDeviceSelectedGuid           ## PRODUCES             ## GUID   =
 # Used as a PPI GUID
+  gEfiTpmDeviceInstanceTpm20DtpmGuid  ## SOMETIMES_CONSUMES
+
+[Ppis]
+  gPeiTpmInitializationDonePpiGuid    ## SOMETIMES_PRODUCES
+
+[Pcd]
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid                 ## PR=
ODUCES
+
+[Depex]
+  TRUE
diff --git a/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c b/OvmfPkg/Tcg/Tcg2Co=
nfig/Tcg2ConfigPeim.c
new file mode 100644
index 000000000000..8bee1926b3c4
--- /dev/null
+++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
@@ -0,0 +1,84 @@
+/** @file
+  The module entry point for Tcg2 configuration module.
+
+Copyright (c) 2018, Red Hat, Inc.
+Copyright (c) 2015, Intel Corporation. All rights reserved.<BR>
+
+This program and the accompanying materials
+are licensed and made available under the terms and conditions of the BS=
D License
+which accompanies this distribution.  The full text of the license may b=
e found at
+http://opensource.org/licenses/bsd-license.php
+
+THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
+WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMP=
LIED.
+
+**/
+
+
+#include <PiPei.h>
+
+#include <Guid/TpmInstance.h>
+#include <Library/DebugLib.h>
+#include <Library/PeiServicesLib.h>
+#include <Library/Tpm2DeviceLib.h>
+#include <Ppi/TpmInitialized.h>
+
+STATIC CONST EFI_PEI_PPI_DESCRIPTOR mTpmSelectedPpi =3D {
+  (EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST),
+  &gEfiTpmDeviceSelectedGuid,
+  NULL
+};
+
+STATIC CONST EFI_PEI_PPI_DESCRIPTOR  mTpmInitializationDonePpiList =3D {
+  EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST,
+  &gPeiTpmInitializationDonePpiGuid,
+  NULL
+};
+
+/**
+  The entry point for Tcg2 configuration driver.
+
+  @param  FileHandle  Handle of the file being invoked.
+  @param  PeiServices Describes the list of possible PEI Services.
+**/
+EFI_STATUS
+EFIAPI
+Tcg2ConfigPeimEntryPoint (
+  IN       EFI_PEI_FILE_HANDLE  FileHandle,
+  IN CONST EFI_PEI_SERVICES     **PeiServices
+  )
+{
+  UINTN                           Size;
+  EFI_STATUS                      Status;
+
+  DEBUG ((DEBUG_INFO, "%a\n", __FUNCTION__));
+
+  Status =3D Tpm2RequestUseTpm ();
+  if (!EFI_ERROR (Status)) {
+      DEBUG ((DEBUG_INFO, "%a: TPM2 detected\n", __FUNCTION__));
+      Size =3D sizeof(gEfiTpmDeviceInstanceTpm20DtpmGuid);
+      Status =3D PcdSetPtrS (
+          PcdTpmInstanceGuid,
+          &Size,
+          &gEfiTpmDeviceInstanceTpm20DtpmGuid
+          );
+      ASSERT_EFI_ERROR (Status);
+  } else {
+      DEBUG ((DEBUG_INFO, "%a: no TPM2 detected\n", __FUNCTION__));
+      // If no TPM2 was detected, we still need to install
+      // TpmInitializationDonePpi. Namely, Tcg2Pei will exit early upon
+      // seeing the default (all-bits-zero) contents of
+      // PcdTpmInstanceGuid, thus we have to install the PPI in its plac=
e,
+      // in order to unblock any dependent PEIMs.
+      Status =3D PeiServicesInstallPpi (&mTpmInitializationDonePpiList);
+      ASSERT_EFI_ERROR (Status);
+  }
+
+  //
+  // Selection done
+  //
+  Status =3D PeiServicesInstallPpi (&mTpmSelectedPpi);
+  ASSERT_EFI_ERROR (Status);
+
+  return Status;
+}
--=20
2.16.2.346.g9779355e34
