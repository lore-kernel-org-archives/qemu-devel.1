Received: from eggs.gnu.org ([2001:4830:134:3::10]:33654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1etzcc-0004Z4-Ui
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1etzcY-0003GX-Vx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:30 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1etzcY-0003GG-N9
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:46:26 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <c0c34117-2ca8-33dc-9aa8-e6e3d0154620@redhat.com>
Date: Thu, 8 Mar 2018 18:46:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180307155746.18526-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 5/8] ovmf: add OvmfPkg
 Tcg2ConfigPei module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 03/07/18 16:57, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The Tcg2ConfigPei module informs the firmware globally about the TPM
> device type, by setting the PcdTpmInstanceGuid PCD to the appropriate
> GUID value. The original module under SecurityPkg can perform device
> detection, or read a cached value from a non-volatile UEFI variable.
>=20
> OvmfPkg's clone of the module only performs the TPM2 hardware detection=
.
>=20
> This is what the module does:
>=20
> - Check the QEMU hardware for TPM2 availability only
>=20
> - If found, set the dynamic PCD "PcdTpmInstanceGuid" to
>   &gEfiTpmDeviceInstanceTpm20DtpmGuid. This is what informs the rest of
>   the firmware about the TPM type.
>=20
> - Install the gEfiTpmDeviceSelectedGuid PPI. This action permits the
>   PEI_CORE to dispatch the Tcg2Pei module, which consumes the above PCD=
.
>   In effect, the gEfiTpmDeviceSelectedGuid PPI serializes the setting
>   and the consumption of the "TPM type" PCD.
>=20
> - If no TPM2 was found, install gPeiTpmInitializationDonePpiGuid.
>   (Normally this is performed by Tcg2Pei, but Tcg2Pei doesn't do it if
>   no TPM2 is available. So in that case our Tcg2ConfigPei must do it.)
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc                   |  17 ++++
>  OvmfPkg/OvmfPkgX64.fdf                   |   4 +
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf |  57 +++++++++++
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c  | 124 +++++++++++++++++++++++
>  OvmfPkg/Tcg/Tcg2Config/TpmDetection.c    |  46 +++++++++
>  5 files changed, 248 insertions(+)
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c

(1) Please change the subject line to:

OvmfPkg: add customized Tcg2ConfigPei clone

> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index a8e89276c0b2..64bd6b6a9f08 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -39,6 +39,7 @@ [Defines]
>    DEFINE HTTP_BOOT_ENABLE        =3D FALSE
>    DEFINE SMM_REQUIRE             =3D FALSE
>    DEFINE TLS_ENABLE              =3D FALSE
> +  DEFINE TPM2_ENABLE             =3D FALSE
> =20
>    #
>    # Flash size selection. Setting FD_SIZE_IN_KB on the command line di=
rectly to
> @@ -208,6 +209,10 @@ [LibraryClasses]
>    OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTre=
eLib/BaseOrderedCollectionRedBlackTreeLib.inf
>    XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +!endif
> +
>  [LibraryClasses.common]
>    BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
> =20
> @@ -272,6 +277,10 @@ [LibraryClasses.common.PEIM]
>    PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
>    QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
> =20
> +!if $(TPM2_ENABLE)

(2) Please be consistent with the other "!if" checks for the same
define; this should be

!if $(TPM2_ENABLE) =3D=3D TRUE

> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTp=
m.inf
> +!endif
> +
>  [LibraryClasses.common.DXE_CORE]
>    HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
>    DxeCoreEntryPoint|MdePkg/Library/DxeCoreEntryPoint/DxeCoreEntryPoint=
.inf
> @@ -554,6 +563,10 @@ [PcdsDynamicDefault]
> =20
>    gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x=
00
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0=
x00}
> +!endif
> +
>  ######################################################################=
##########
>  #
>  # Components Section - list of all EDK II Modules needed by this Platf=
orm.
> @@ -600,6 +613,10 @@ [Components]
>  !endif
>    UefiCpuPkg/CpuMpPei/CpuMpPei.inf
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
> +!endif
> +
>    #
>    # DXE Phase modules
>    #
> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
> index 2fc17810eb23..dbafada5226b 100644
> --- a/OvmfPkg/OvmfPkgX64.fdf
> +++ b/OvmfPkg/OvmfPkgX64.fdf
> @@ -165,6 +165,10 @@ [FV.PEIFV]
>  !endif
>  INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +INF  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
> +!endif
> +
>  ######################################################################=
##########
> =20
>  [FV.DXEFV]
> diff --git a/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf b/OvmfPkg/Tcg/Tcg=
2Config/Tcg2ConfigPei.inf
> new file mode 100644
> index 000000000000..201e4f24d5f4
> --- /dev/null
> +++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
> @@ -0,0 +1,57 @@
> +## @file
> +#  Set TPM device type
> +#
> +#  This module initializes TPM device type based on variable and detec=
tion.
> +#  This OvmfPkg of SecurityPkg only does TPM2 detection.

(3) Thanks for updating this, relative to SecurityPkg -- can you please
clean it up a little? The second sentence looks malformed. I suggest
something like:

#  In SecurityPkg, this module initializes the TPM device type based on
#  a UEFI variable and/or hardware detection. In OvmfPkg, the module
#  only performs TPM2 hardware detection.

> +#
> +# Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.<B=
R>
> +# Copyright (C) 2018, Red Hat, Inc.
> +#
> +# This program and the accompanying materials
> +# are licensed and made available under the terms and conditions of th=
e BSD License
> +# which accompanies this distribution. The full text of the license ma=
y be found at
> +# http://opensource.org/licenses/bsd-license.php
> +# THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS=
,
> +# WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR=
 IMPLIED.
> +#
> +##

(4) Hmm these lines are a bit too long:

$ wc -L OvmfPkg/Tcg/Tcg2Config/*
  96 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
 106 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
 102 OvmfPkg/Tcg/Tcg2Config/TpmDetection.c
 106 total

Can you please rewrap the source files so they don't exceed 80
characters per line?

Well, actually, don't bother with that. If you do that, some of the line
breaks might force you to break function calls to multiple lines, and
then we'll likely need yet another round of review, because the edk2
"multiline function call" style is pretty idiosyncratic. It goes like
this (note the indentation!):

- variant 1:

    SmartFunction (
      Argument1OnASeparateLine,
      Argument2OnASeparateLine,
      Argument3OnASeparateLine
      ); // closing paren on a separate line, aligned exactly like this

- variant 2:

    SmartFunction2 (Argument1, Argument2, Argument3, Argument4,
      Argument5, Argument6);

So, I guess I'll leave it up to you. :) If you don't feel like messing
with this, I can rewrap the source in a separate patchset.

> +
> +[Defines]
> +  INF_VERSION                    =3D 0x00010005
> +  BASE_NAME                      =3D Tcg2ConfigPei
> +  FILE_GUID                      =3D BF7F2B0C-9F2F-4889-AB5C-12460022B=
E87
> +  MODULE_TYPE                    =3D PEIM
> +  VERSION_STRING                 =3D 1.0
> +  ENTRY_POINT                    =3D Tcg2ConfigPeimEntryPoint
> +
> +[Sources]
> +  Tcg2ConfigPeim.c
> +  TpmDetection.c
> +
> +[Packages]
> +  MdePkg/MdePkg.dec
> +  MdeModulePkg/MdeModulePkg.dec
> +  SecurityPkg/SecurityPkg.dec
> +
> +[LibraryClasses]
> +  PeimEntryPoint
> +  DebugLib
> +  Tpm2DeviceLib
> +
> +[Guids]
> +  ## SOMETIMES_CONSUMES ## Variable:L"TCG2_CONFIGURATION"
> +  ## SOMETIMES_CONSUMES ## Variable:L"TCG2_DEVICE_DETECTION"
> +  gTcg2ConfigFormSetGuid

(5) Can you please drop these three lines? These lines are related to
the UEFI variable(s), but we don't use those.

> +  gEfiTpmDeviceSelectedGuid           ## PRODUCES             ## GUID =
   # Used as a PPI GUID
> +  gEfiTpmDeviceInstanceNoneGuid       ## SOMETIMES_CONSUMES   ## GUID =
   # TPM device identifier

(6) I'll comment more on this later; just a short request here: please
drop "gEfiTpmDeviceInstanceNoneGuid".

The dynamic default that you set in the DSC file is
gEfiTpmDeviceInstanceNoneGuid (all bits zero), and that's sufficient for =
us.

(7) On the other hand, please list "gEfiTpmDeviceInstanceTpm20DtpmGuid",
as SOMETIMES_CONSUMES.

> +
> +[Ppis]
> +  gPeiTpmInitializationDonePpiGuid    ## SOMETIMES_PRODUCES
> +
> +[Pcd]
> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid                 ## =
PRODUCES
> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmAutoDetection                ## =
CONSUMES

(8) Please drop PcdTpmAutoDetection, we never want to set that to FALSE
in our DSCs.

> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmBaseAddress                  ## =
SOMETIMES_CONSUMES

(9) Please drop this as well. This module does not *directly* consume
this PCD. If one of the library instances pulled into the module
consumes the PCD, then it should be spelled out in the INF file of that
library instance.

> +
> +[Depex]
> +  gEfiPeiMasterBootModePpiGuid

(10) Please drop the DEPEX (the entire section). This depex exists in
the SecurityPkg original because that module behaves differently (wrt.
detection / cached value) according to the boot mode, and so it has a
dependency on some other PEIM detecting and exposing the boot mode.

Higher up, you correctly removed the S3_RESUME references, and indeed
OVMF's clone of the source ignores the boot mode (also correctly). But
that implies we have no dependency on this PPI.

> diff --git a/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c b/OvmfPkg/Tcg/Tcg2=
Config/Tcg2ConfigPeim.c
> new file mode 100644
> index 000000000000..31f27968401b
> --- /dev/null
> +++ b/OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c
> @@ -0,0 +1,124 @@
> +/** @file
> +  The module entry point for Tcg2 configuration module.
> +
> +Copyright (c) 2018, Red Hat, Inc.
> +Copyright (c) 2015, Intel Corporation. All rights reserved.<BR>
> +
> +This program and the accompanying materials
> +are licensed and made available under the terms and conditions of the =
BSD License
> +which accompanies this distribution.  The full text of the license may=
 be found at
> +http://opensource.org/licenses/bsd-license.php
> +
> +THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
> +WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR I=
MPLIED.
> +
> +**/
> +
> +
> +#include <PiPei.h>
> +
> +#include <Guid/TpmInstance.h>
> +#include <Library/BaseMemoryLib.h>
> +#include <Library/DebugLib.h>
> +#include <Library/PeiServicesLib.h>

(11) Please make sure that

(11a) whatever <Library/...> headers are included in any *.c or *.h file
are synched with the [LibraryClasses] section in the INF file,

(11b) ditto for <Guid/...> and [Guids] -- already covered by my remarks
(6) and (7) above

(11c) ditto for <Ppi/...> and [Ppis] -- for example, I think we need to
#include <Ppi/TpmInitialized.h> for "gPeiTpmInitializationDonePpiGuid".

> +#include <Tcg/Tcg2Config/Tcg2ConfigNvData.h>

(12) Please drop this, we don't need it.

> +
> +TPM_INSTANCE_ID  mTpmInstanceId[] =3D TPM_INSTANCE_ID_LIST;

(13) Please drop this.

> +
> +CONST EFI_PEI_PPI_DESCRIPTOR gTpmSelectedPpi =3D {
> +  (EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST)=
,
> +  &gEfiTpmDeviceSelectedGuid,
> +  NULL
> +};

(14) Can you please rename this to "mTpmSelectedPpiList"?

> +
> +EFI_PEI_PPI_DESCRIPTOR  mTpmInitializationDonePpiList =3D {
> +  EFI_PEI_PPI_DESCRIPTOR_PPI | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST,
> +  &gPeiTpmInitializationDonePpiGuid,
> +  NULL
> +};

(15) Please make both of these global variables STATIC CONST.

> +
> +/**
> +  This routine check both SetupVariable and real TPM device, and retur=
n final TpmDevice configuration.
> +
> +  @param  SetupTpmDevice  TpmDevice configuration in setup driver
> +
> +  @return TpmDevice configuration
> +**/
> +UINT8
> +DetectTpmDevice (
> +  IN UINT8 SetupTpmDevice
> +  );

(16a) Please remove this function declaration,

(16b) Please remove the DetectTpmDevice() function definition, together
with the "TpmDetection.c" source file,

(16c) Please fold the contents of DetectTpmDevice() -- basically a call
to Tpm2RequestUseTpm() -- into Tcg2ConfigPeimEntryPoint().


> +
> +/**
> +  The entry point for Tcg2 configuration driver.
> +
> +  @param  FileHandle  Handle of the file being invoked.
> +  @param  PeiServices Describes the list of possible PEI Services.
> +
> +  @retval EFI_SUCCES             Convert variable to PCD successfully.
> +  @retval Others                 Fail to convert variable to PCD.
> +**/
> +EFI_STATUS
> +EFIAPI
> +Tcg2ConfigPeimEntryPoint (
> +  IN       EFI_PEI_FILE_HANDLE  FileHandle,
> +  IN CONST EFI_PEI_SERVICES     **PeiServices
> +  )
> +{
> +  UINTN                           Size;
> +  EFI_STATUS                      Status;
> +  EFI_STATUS                      Status2;
> +  TCG2_CONFIGURATION              Tcg2Configuration;
> +  UINTN                           Index;
> +  UINT8                           TpmDevice;
> +
> +  Tcg2Configuration.TpmDevice           =3D TPM_DEVICE_2_0_DTPM;
> +
> +  DEBUG ((EFI_D_INFO, "OvmfPkg Tcg2ConfigPeimEntryPoint"));

Just some side comments here:

(17a) Nowadays we use DEBUG_xxxx macros, not EFI_D_xxx macros. So this
should be DEBUG_INFO.

(17b) Please don't forget the terminating "\n" for the debug message.

(17c) No need to print "OvmfPkg".

(17d) The preferred method of printing the containing function name is:

  DEBUG ((DEBUG_INFO, "%a\n", __FUNCTION__));

The "%s" format specifier prints UCS2-encoded wide char strings (arrays
of CHAR16 elements), while the "%a" format specifier prints ASCII
strings (CHAR8 arrays). __FUNCTION__ is expanded to the latter.

> +
> +  if (PcdGetBool (PcdTpmAutoDetection)) {
> +    TpmDevice =3D DetectTpmDevice (Tcg2Configuration.TpmDevice);
> +    DEBUG ((EFI_D_INFO, "TpmDevice final: %x\n", TpmDevice));
> +    if (TpmDevice !=3D TPM_DEVICE_NULL) {
> +      Tcg2Configuration.TpmDevice =3D TpmDevice;
> +    }
> +  } else {
> +    TpmDevice =3D Tcg2Configuration.TpmDevice;
> +  }
> +
> +  //
> +  // Convert variable to PCD.
> +  // This is work-around because there is no gurantee DynamicHiiPcd ca=
n return correct value in DXE phase.
> +  // Using DynamicPcd instead.
> +  //
> +  // NOTE: Tcg2Configuration variable contains the desired TpmDevice t=
ype,
> +  // while PcdTpmInstanceGuid PCD contains the real detected TpmDevice=
 type
> +  //
> +  for (Index =3D 0; Index < sizeof(mTpmInstanceId)/sizeof(mTpmInstance=
Id[0]); Index++) {
> +    if (TpmDevice =3D=3D mTpmInstanceId[Index].TpmDevice) {
> +      Size =3D sizeof(mTpmInstanceId[Index].TpmInstanceGuid);
> +      Status =3D PcdSetPtrS (PcdTpmInstanceGuid, &Size, &mTpmInstanceI=
d[Index].TpmInstanceGuid);
> +      ASSERT_EFI_ERROR (Status);
> +      DEBUG ((EFI_D_INFO, "TpmDevice PCD: %g\n", &mTpmInstanceId[Index=
].TpmInstanceGuid));
> +      break;
> +    }
> +  }

(18) So basically all this logic should be simplified to:

- call Tpm2RequestUseTpm()

- if Tpm2RequestUseTpm() succeeds:
  - set "PcdTpmInstanceGuid" to "gEfiTpmDeviceInstanceTpm20DtpmGuid"
  - install "gEfiTpmDeviceSelectedGuid" via "mTpmSelectedPpiList"

- if Tpm2RequestUseTpm() fails:
  - don't touch the PCD, our dynamic default from the DSC is fine
  - install "gEfiTpmDeviceSelectedGuid" via "mTpmSelectedPpiList"
  - install "gPeiTpmInitializationDonePpiGuid" via
    "mTpmInitializationDonePpiList"

(19) DEBUG messages are nice to keep, just please update EFI_D_xxx to
DEBUG_xxx.

(20) I think all of the above "//" comments can be dropped, the
resultant code will be simple enough, and our commit message is detailed.

> +
> +  //
> +  // Selection done
> +  //
> +  Status =3D PeiServicesInstallPpi (&gTpmSelectedPpi);
> +  ASSERT_EFI_ERROR (Status);
> +
> +  //
> +  // Even if no TPM is selected or detected, we still need intall TpmI=
nitializationDonePpi.
> +  // Because TcgPei or Tcg2Pei will not run, but we still need a way t=
o notify other driver.
> +  // Other driver can know TPM initialization state by TpmInitializedP=
pi.
> +  //

(21) This comment block is nice to keep (under the "Tpm2RequestUseTpm()
fails" branch); I suggest the following variant:

  // If no TPM2 was detected, we still need to install
  // TpmInitializationDonePpi. Namely, Tcg2Pei will exit early upon
  // seeing the default (all-bits-zero) contents of PcdTpmInstanceGuid,
  // thus we have to install the PPI in its place, in order to unblock
  // any dependent PEIMs.

Thank you!
Laszlo

> +  if (CompareGuid (PcdGetPtr(PcdTpmInstanceGuid), &gEfiTpmDeviceInstan=
ceNoneGuid)) {
> +    Status2 =3D PeiServicesInstallPpi (&mTpmInitializationDonePpiList)=
;
> +    ASSERT_EFI_ERROR (Status2);
> +  }
> +
> +  return Status;
> +}
> diff --git a/OvmfPkg/Tcg/Tcg2Config/TpmDetection.c b/OvmfPkg/Tcg/Tcg2Co=
nfig/TpmDetection.c
> new file mode 100644
> index 000000000000..df222cbff13d
> --- /dev/null
> +++ b/OvmfPkg/Tcg/Tcg2Config/TpmDetection.c
> @@ -0,0 +1,46 @@
> +/** @file
> +  TPM2.0 auto detection.
> +
> +Copyright (c) 2015 - 2016, Intel Corporation. All rights reserved.<BR>
> +Copyright (C) 2018, Red Hat, Inc.
> +
> +This program and the accompanying materials
> +are licensed and made available under the terms and conditions of the =
BSD License
> +which accompanies this distribution.  The full text of the license may=
 be found at
> +http://opensource.org/licenses/bsd-license.php
> +
> +THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASIS,
> +WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR I=
MPLIED.
> +
> +**/
> +
> +
> +#include <PiPei.h>
> +
> +#include <Library/DebugLib.h>
> +#include <Library/Tpm2DeviceLib.h>
> +#include <Tcg/Tcg2Config/Tcg2ConfigNvData.h>
> +
> +/**
> +  This routine check both SetupVariable and real TPM device, and retur=
n final TpmDevice configuration.
> +
> +  @param  SetupTpmDevice  TpmDevice configuration in setup driver
> +
> +  @return TpmDevice configuration
> +**/
> +UINT8
> +DetectTpmDevice (
> +  IN UINT8 SetupTpmDevice
> +  )
> +{
> +  EFI_STATUS                        Status;
> +
> +  DEBUG ((EFI_D_INFO, "DetectTpmDevice:\n"));
> +
> +  Status =3D Tpm2RequestUseTpm ();
> +  if (EFI_ERROR (Status)) {
> +    return TPM_DEVICE_NULL;
> +  }
> +
> +  return TPM_DEVICE_2_0_DTPM;
> +}
>=20
