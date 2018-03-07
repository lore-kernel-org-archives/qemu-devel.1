Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS5-0005Xo-R8
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1etbS3-00018v-Pi
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:58:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43030 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1etbS3-00018f-JX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:57:59 -0500
From: marcandre.lureau@redhat.com
Date: Wed,  7 Mar 2018 16:57:43 +0100
Message-Id: <20180307155746.18526-6-marcandre.lureau@redhat.com>
In-Reply-To: <20180307155746.18526-1-marcandre.lureau@redhat.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 5/8] ovmf: add OvmfPkg Tcg2ConfigPei module
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
 OvmfPkg/OvmfPkgX64.dsc                   |  17 ++++
 OvmfPkg/OvmfPkgX64.fdf                   |   4 +
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf |  57 +++++++++++
 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c  | 124 +++++++++++++++++++++++
 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c    |  46 +++++++++
 5 files changed, 248 insertions(+)
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
 create mode 100644 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c

diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
index a8e89276c0b2..64bd6b6a9f08 100644
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
+!if $(TPM2_ENABLE)
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
index 000000000000..201e4f24d5f4
--- /dev/null
+++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
@@ -0,0 +1,57 @@
+## @file
+#  Set TPM device type
+#
+#  This module initializes TPM device type based on variable and detecti=
on.
+#  This OvmfPkg of SecurityPkg only does TPM2 detection.
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
+  TpmDetection.c
+
+[Packages]
+  MdePkg/MdePkg.dec
+  MdeModulePkg/MdeModulePkg.dec
+  SecurityPkg/SecurityPkg.dec
+
+[LibraryClasses]
+  PeimEntryPoint
+  DebugLib
+  Tpm2DeviceLib
+
+[Guids]
+  ## SOMETIMES_CONSUMES ## Variable:L"TCG2_CONFIGURATION"
+  ## SOMETIMES_CONSUMES ## Variable:L"TCG2_DEVICE_DETECTION"
+  gTcg2ConfigFormSetGuid
+  gEfiTpmDeviceSelectedGuid           ## PRODUCES             ## GUID   =
 # Used as a PPI GUID
+  gEfiTpmDeviceInstanceNoneGuid       ## SOMETIMES_CONSUMES   ## GUID   =
 # TPM device identifier
+
+[Ppis]
+  gPeiTpmInitializationDonePpiGuid    ## SOMETIMES_PRODUCES
+
+[Pcd]
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid                 ## PR=
ODUCES
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmAutoDetection                ## CO=
NSUMES
+  gEfiSecurityPkgTokenSpaceGuid.PcdTpmBaseAddress                  ## SO=
METIMES_CONSUMES
+
+[Depex]
+  gEfiPeiMasterBootModePpiGuid
diff --git a/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c b/OvmfPkg/Tcg/Tcg2Co=
nfig/Tcg2ConfigPeim.c
new file mode 100644
index 000000000000..31f27968401b
--- /dev/null
+++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
@@ -0,0 +1,124 @@
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
+#include <Library/BaseMemoryLib.h>
+#include <Library/DebugLib.h>
+#include <Library/PeiServicesLib.h>
+#include <Tcg/Tcg2Config/Tcg2ConfigNvData.h>
+
+TPM_INSTANCE_ID  mTpmInstanceId[] =3D TPM_INSTANCE_ID_LIST;
+
+CONST EFI_PEI_PPI_DESCRIPTOR gTpmSelectedPpi =3D {
+  (EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST),
+  &gEfiTpmDeviceSelectedGuid,
+  NULL
+};
+
+EFI_PEI_PPI_DESCRIPTOR  mTpmInitializationDonePpiList =3D {
+  EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST,
+  &gPeiTpmInitializationDonePpiGuid,
+  NULL
+};
+
+/**
+  This routine check both SetupVariable and real TPM device, and return =
final TpmDevice configuration.
+
+  @param  SetupTpmDevice  TpmDevice configuration in setup driver
+
+  @return TpmDevice configuration
+**/
+UINT8
+DetectTpmDevice (
+  IN UINT8 SetupTpmDevice
+  );
+
+/**
+  The entry point for Tcg2 configuration driver.
+
+  @param  FileHandle  Handle of the file being invoked.
+  @param  PeiServices Describes the list of possible PEI Services.
+
+  @retval EFI_SUCCES             Convert variable to PCD successfully.
+  @retval Others                 Fail to convert variable to PCD.
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
+  EFI_STATUS                      Status2;
+  TCG2_CONFIGURATION              Tcg2Configuration;
+  UINTN                           Index;
+  UINT8                           TpmDevice;
+
+  Tcg2Configuration.TpmDevice           =3D TPM_DEVICE_2_0_DTPM;
+
+  DEBUG ((EFI_D_INFO, "OvmfPkg Tcg2ConfigPeimEntryPoint"));
+
+  if (PcdGetBool (PcdTpmAutoDetection)) {
+    TpmDevice =3D DetectTpmDevice (Tcg2Configuration.TpmDevice);
+    DEBUG ((EFI_D_INFO, "TpmDevice final: %x\n", TpmDevice));
+    if (TpmDevice !=3D TPM_DEVICE_NULL) {
+      Tcg2Configuration.TpmDevice =3D TpmDevice;
+    }
+  } else {
+    TpmDevice =3D Tcg2Configuration.TpmDevice;
+  }
+
+  //
+  // Convert variable to PCD.
+  // This is work-around because there is no gurantee DynamicHiiPcd can =
return correct value in DXE phase.
+  // Using DynamicPcd instead.
+  //
+  // NOTE: Tcg2Configuration variable contains the desired TpmDevice typ=
e,
+  // while PcdTpmInstanceGuid PCD contains the real detected TpmDevice t=
ype
+  //
+  for (Index =3D 0; Index < sizeof(mTpmInstanceId)/sizeof(mTpmInstanceId=
[0]); Index++) {
+    if (TpmDevice =3D=3D mTpmInstanceId[Index].TpmDevice) {
+      Size =3D sizeof(mTpmInstanceId[Index].TpmInstanceGuid);
+      Status =3D PcdSetPtrS (PcdTpmInstanceGuid, &Size, &mTpmInstanceId[=
Index].TpmInstanceGuid);
+      ASSERT_EFI_ERROR (Status);
+      DEBUG ((EFI_D_INFO, "TpmDevice PCD: %g\n", &mTpmInstanceId[Index].=
TpmInstanceGuid));
+      break;
+    }
+  }
+
+  //
+  // Selection done
+  //
+  Status =3D PeiServicesInstallPpi (&gTpmSelectedPpi);
+  ASSERT_EFI_ERROR (Status);
+
+  //
+  // Even if no TPM is selected or detected, we still need intall TpmIni=
tializationDonePpi.
+  // Because TcgPei or Tcg2Pei will not run, but we still need a way to =
notify other driver.
+  // Other driver can know TPM initialization state by TpmInitializedPpi=
.
+  //
+  if (CompareGuid (PcdGetPtr(PcdTpmInstanceGuid), &gEfiTpmDeviceInstance=
NoneGuid)) {
+    Status2 =3D PeiServicesInstallPpi (&mTpmInitializationDonePpiList);
+    ASSERT_EFI_ERROR (Status2);
+  }
+
+  return Status;
+}
diff --git a/OvmfPkg/Tcg/Tcg2Config/TpmDetection.c b/OvmfPkg/Tcg/Tcg2Conf=
ig/TpmDetection.c
new file mode 100644
index 000000000000..df222cbff13d
--- /dev/null
+++ b/OvmfPkg/Tcg/Tcg2Config/TpmDetection.c
@@ -0,0 +1,46 @@
+/** @file
+  TPM2.0 auto detection.
+
+Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.<BR>
+Copyright (C) 2018, Red Hat, Inc.
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
+#include <Library/DebugLib.h>
+#include <Library/Tpm2DeviceLib.h>
+#include <Tcg/Tcg2Config/Tcg2ConfigNvData.h>
+
+/**
+  This routine check both SetupVariable and real TPM device, and return =
final TpmDevice configuration.
+
+  @param  SetupTpmDevice  TpmDevice configuration in setup driver
+
+  @return TpmDevice configuration
+**/
+UINT8
+DetectTpmDevice (
+  IN UINT8 SetupTpmDevice
+  )
+{
+  EFI_STATUS                        Status;
+
+  DEBUG ((EFI_D_INFO, "DetectTpmDevice:\n"));
+
+  Status =3D Tpm2RequestUseTpm ();
+  if (EFI_ERROR (Status)) {
+    return TPM_DEVICE_NULL;
+  }
+
+  return TPM_DEVICE_2_0_DTPM;
+}
--=20
2.16.2.346.g9779355e34
