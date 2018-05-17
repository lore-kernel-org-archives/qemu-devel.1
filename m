Received: from eggs.gnu.org ([2001:4830:134:3::10]:47860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJFw4-0007ta-4V
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJFvy-0002W0-Tg
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:15:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJFvy-0002Uj-M8
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:14:54 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<20180515123007.10164-4-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a9b1c4a8-fc18-295f-d5f6-4d04f376a008@redhat.com>
Date: Thu, 17 May 2018 12:14:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180515123007.10164-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 3/4] ovmf: replace SecurityPkg with
 OvfmPkg Tcg2PhysicalPresenceLibQemu
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

On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Cloned "SecurityPkg/Library/DxeTcg2PhysicalPresenceLib" and:
>=20
> - removed all the functions that are unreachable from
>   Tcg2PhysicalPresenceLibProcessRequest()
>=20
> - replaced everything that's related to the
>   TCG2_PHYSICAL_PRESENCE*_VARIABLE variables, with direct access to
>   the QEMU structures.
>=20
> This commit is based on initial experimental work from Stefan Berger.
> In particular, he wrote most of QEMU PPI support, and designed the
> qemu/firmware interaction. Initially, Stefan tried to reuse the
> existing SecurityPkg code, but we eventually decided to get rid of the
> variables and simplify the ovmf/qemu version.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .../DxeTcg2PhysicalPresenceLib.c              | 881 ++++++++++++++++++
>  .../DxeTcg2PhysicalPresenceLib.inf            |  67 ++
>  .../DxeTcg2PhysicalPresenceLib.uni            |  26 +

(1) Please drop the "DxeTcg2PhysicalPresenceLib.uni" file (also the
reference in the INF file).

We generally don't do MODULE_UNI_FILEs in OvmfPkg because OvmfPkg is not
distributed with UPT (UEFI Packaging Tool).

>  .../PhysicalPresenceStrings.uni               |  49 +
>  OvmfPkg/OvmfPkgIa32.dsc                       |   2 +-
>  OvmfPkg/OvmfPkgIa32X64.dsc                    |   2 +-
>  OvmfPkg/OvmfPkgX64.dsc                        |   2 +-
>  7 files changed, 1026 insertions(+), 3 deletions(-)
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2=
PhysicalPresenceLib.c
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2=
PhysicalPresenceLib.inf
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2=
PhysicalPresenceLib.uni
>  create mode 100644 OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/Physica=
lPresenceStrings.uni
>=20
> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Physica=
lPresenceLib.c b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Physi=
calPresenceLib.c
> new file mode 100644
> index 000000000000..da45f990369a
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresen=
ceLib.c
> @@ -0,0 +1,881 @@
> +/** @file
> +  Execute pending TPM2 requests from OS or BIOS.
> +
> +  Caution: This module requires additional review when modified.
> +  This driver will have external input - variable.
> +  This external input must be validated carefully to avoid security is=
sue.
> +
> +  Tcg2ExecutePendingTpmRequest() will receive untrusted input and do v=
alidation.
> +
> +Copyright (C) 2018, Red Hat, Inc.
> +Copyright (c) 2018, IBM Corporation. All rights reserved.<BR>
> +Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<BR>
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
> +#include <PiDxe.h>
> +
> +#include <Guid/Tcg2PhysicalPresenceData.h>
> +#include <IndustryStandard/QemuTpm.h>
> +#include <Protocol/Tcg2Protocol.h>
> +
> +#include <Library/BaseMemoryLib.h>
> +#include <Library/DebugLib.h>
> +#include <Library/HiiLib.h>
> +#include <Library/HobLib.h>
> +#include <Library/MemoryAllocationLib.h>
> +#include <Library/PrintLib.h>
> +#include <Library/QemuFwCfgLib.h>
> +#include <Library/Tpm2CommandLib.h>
> +#include <Library/UefiBootServicesTableLib.h>
> +#include <Library/UefiLib.h>
> +#include <Library/UefiRuntimeServicesTableLib.h>
> +
> +#include <Library/Tcg2PhysicalPresenceLib.h>
> +
> +#define CONFIRM_BUFFER_SIZE         4096
> +
> +EFI_HII_HANDLE mTcg2PpStringPackHandle;
> +
> +#define TPM_PPI_FLAGS (QEMU_TPM_PPI_FUNC_ALLOWED_USR_REQ)
> +
> +STATIC CONST UINT8 mTpm2PPIFuncs[] =3D {
> +  [TCG2_PHYSICAL_PRESENCE_NO_ACTION] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_CLEAR] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_CHANGE_EPS] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_LOG_ALL_DIGESTS] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_ENABLE_BLOCK_SID] =3D TPM_PPI_FLAGS,
> +  [TCG2_PHYSICAL_PRESENCE_DISABLE_BLOCK_SID] =3D TPM_PPI_FLAGS,
> +};

(2) Unfortunately, designated initializers cannot be used in edk2.
You'll have to

- either spell out the entire initial slice of the array (and use "//
TCG2_PHYSICAL_PRESENCE_NO_ACTION" style comments to help readers),

- or else drop the "CONST", introduce a CONSTRUCTOR function to the
library instance, and perform the assignments manually in the
constructor function, such as

  mTpm2PPIFuncs[TCG2_PHYSICAL_PRESENCE_NO_ACTION] =3D TPM_PPI_FLAGS;

> +
> +STATIC QEMU_TPM_PPI *mPpi;
> +
> +
> +/**
> +  Reads QEMU PPI config from fw_cfg.
> +**/
> +EFI_STATUS
> +QemuTpmReadConfig (

(3) Please make this STATIC.

Please make *all* functions STATIC that can be.

> +  IN QEMU_FWCFG_TPM_CONFIG *Config

(4) Should be decorated as OUT, not IN.

> +  )
> +{
> +  EFI_STATUS           Status;
> +  FIRMWARE_CONFIG_ITEM FwCfgItem;
> +  UINTN                FwCfgSize;
> +
> +  Status =3D QemuFwCfgFindFile ("etc/tpm/config", &FwCfgItem, &FwCfgSi=
ze);
> +  if (EFI_ERROR (Status)) {
> +    return Status;
> +  }
> +
> +  if (FwCfgSize !=3D sizeof (*Config)) {
> +      return EFI_PROTOCOL_ERROR;
> +  }

(5) indentation (please re-check everything for that)

> +
> +  QemuFwCfgSelectItem (FwCfgItem);
> +  QemuFwCfgReadBytes (sizeof (*Config), Config);
> +  return EFI_SUCCESS;
> +}
> +
> +
> +/**
> +  Initializes QEMU PPI memory region.
> +**/
> +EFI_STATUS
> +QemuTpmInitPPI (
> +  VOID
> +  )
> +{
> +  EFI_STATUS Status;
> +  QEMU_FWCFG_TPM_CONFIG Config;

(6) we tend to align the identifiers.

> +
> +  if (mPpi) {

(7) Please spell out

  if (mPpi !=3D NULL) {

> +      return EFI_SUCCESS;
> +  }
> +
> +  Status =3D QemuTpmReadConfig (&Config);
> +  if (EFI_ERROR (Status)) {
> +    return Status;
> +  }
> +
> +  mPpi =3D (QEMU_TPM_PPI *)(unsigned long)Config.PpiAddress;

(8) The idiomatic way to write this in edk2 is:

  mPpi =3D (QEMU_TPM_PPI *)(UINTN)Config.PpiAddress;

> +  if (!mPpi) {

(9) Please spell out (mPpi =3D=3D NULL)

> +      return EFI_INVALID_PARAMETER;

(10) EFI_PROTOCOL_ERROR would be more idiomatic, for fw_cfg errors that
shouldn't happen.

> +  }
> +
> +  DEBUG ((EFI_D_INFO, "[TPM2PP] mPpi=3D%x version=3D%d\n", mPpi, Confi=
g.TpmVersion));

(11) We no longer use EFI_D_* macros in new code; please use DEBUG_*
instead.

(12) mPpi is a pointer, please format it with the %p conversion
specifier. Or, you can keep %x and pass Config.PpiAddress instead (which
has type UINT32).

(13) I'd like to request a safety check here, before we dereference mPpi
(into MMIO):

(13a) Please verify that QEMU_FWCFG_TPM_CONFIG does not cross a page
boundary:

  EFI_PHYSICAL_ADDRESS PpiAddress64;

  PpiAddress64 =3D (UINTN)mPpi;
  if ((PpiAddress64 & ~(UINT64)EFI_PAGE_MASK) !=3D
      ((PpiAddress64 + sizeof *mPpi - 1) & ~(UINT64)EFI_PAGE_MASK)) {
    //
    // log DEBUG_ERROR, and return an error
    //
  }

(13b) If check (a) passes, please call gDS->GetMemorySpaceDescriptor()
on PpiAddress64. (See the interface under
EFI_GET_MEMORY_SPACE_DESCRIPTOR in "MdePkg/Include/Pi/PiDxeCis.h").
Verify that one of the following holds:

- the function returns EFI_NOT_FOUND,

- or Descriptor.GcdMemoryType is either EfiGcdMemoryTypeNonExistent or
EfiGcdMemoryTypeMemoryMappedIo.

(For bells and whistles, we should even add and allocate a GCD range
with EfiGcdMemoryTypeMemoryMappedIo, but I'll spare you that.)

> +  ZeroMem (&mPpi->Func, sizeof (mPpi->Func));
> +  switch (Config.TpmVersion) {
> +  case QEMU_TPM_VERSION_2:
> +    CopyMem (&mPpi->Func, mTpm2PPIFuncs, sizeof (mTpm2PPIFuncs));
> +    break;
> +  }

(14) Can you use an "if" here please?

(15) Also, jumping back to my comment (2) here; it seems that placing
the individual assignments here would be superior to a CONSTRUCTOR
function (in case the CONSTRUCTOR function were your choice for (2)).

> +
> +  if (!mPpi->In) {
> +    mPpi->In =3D 1;
> +    mPpi->Request =3D TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +    mPpi->LastRequest =3D TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +    mPpi->NextStep =3D TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +  }

(16) A more idiomatic way for accessing all entries in *mPpi would be
calling MmioWrite8() / MmioWrite32().

The *really* idiomatic way would be to locate the EFI_CPU_IO2_PROTOCOL
instance, and use its Mem.Read() and Mem.Write() functions.

However, given that this library instance is entirely platform- and
architecture-specific, it's not lost on me that such an update would
mostly be "busywork".

Namely, for IA32/X64, EFI_CPU_IO2_PROTOCOL is implemented in
"UefiCpuPkg/CpuIo2Dxe/CpuIo2Dxe.c", which turns the protocol member
function calls into those same MmioRead*() / MmioWrite*() calls. In
turn, in OVMF, MmioRead*() / MmioWrite*() are just naked de-references
of volatile-qualified pointers, guarded by MemoryFence() calls on both
sides.

Given that
- "volatile" will prevent the compiler from reordering the accesses, and
- every single such access will trap to QEMU because *mPpi is not backed
  by guest DRAM (hence the CPU can't reorder accesses either),

I think we can safely forego the MemoryFence() calls as well, and simply
modify the definition of mPpi as follows:

STATIC volatile QEMU_TPM_PPI *mPpi;

Now, this will (rightfully) trigger a number of compilation errors, for
example because ZeroMem() and CopyMem() would require you to cast away
"volatile". I suggest replacing ZeroMem() with an open-coded loop that
zeroes the area through a (volatile UINT32 *) pointer, and the CopyMem()
should be replaced by the individual assignments anyway, such as:

  mPpi->Func[TCG2_PHYSICAL_PRESENCE_NO_ACTION] =3D TPM_PPI_FLAGS;

> +
> +  return EFI_SUCCESS;
> +}
> +
> +
> +/**
> +  Get string by string id from HII Interface.
> +
> +  @param[in] Id          String ID.
> +
> +  @retval    CHAR16 *    String from ID.
> +  @retval    NULL        If error occurs.
> +
> +**/
> +CHAR16 *
> +Tcg2PhysicalPresenceGetStringById (
> +  IN  EFI_STRING_ID   Id
> +  )
> +{
> +  return HiiGetString (mTcg2PpStringPackHandle, Id, NULL);
> +}
> +
> +
> +/**
> +  Send ClearControl and Clear command to TPM.
> +
> +  @param[in]  PlatformAuth      platform auth value. NULL means no pla=
tform auth change.
> +
> +  @retval EFI_SUCCESS           Operation completed successfully.
> +  @retval EFI_TIMEOUT           The register can't run into the expect=
ed status in time.
> +  @retval EFI_BUFFER_TOO_SMALL  Response data buffer is too small.
> +  @retval EFI_DEVICE_ERROR      Unexpected device behavior.
> +
> +**/
> +EFI_STATUS
> +EFIAPI
> +Tpm2CommandClear (
> +  IN TPM2B_AUTH                *PlatformAuth  OPTIONAL
> +  )
> +{
> +  EFI_STATUS                Status;
> +  TPMS_AUTH_COMMAND         *AuthSession;
> +  TPMS_AUTH_COMMAND         LocalAuthSession;
> +
> +  if (PlatformAuth =3D=3D NULL) {
> +    AuthSession =3D NULL;
> +  } else {
> +    AuthSession =3D &LocalAuthSession;
> +    ZeroMem (&LocalAuthSession, sizeof (LocalAuthSession));
> +    LocalAuthSession.sessionHandle =3D TPM_RS_PW;
> +    LocalAuthSession.hmac.size =3D PlatformAuth->size;
> +    CopyMem (LocalAuthSession.hmac.buffer, PlatformAuth->buffer, Platf=
ormAuth->size);
> +  }
> +
> +  DEBUG ((EFI_D_INFO, "Tpm2ClearControl ... \n"));
> +  Status =3D Tpm2ClearControl (TPM_RH_PLATFORM, AuthSession, NO);
> +  DEBUG ((EFI_D_INFO, "Tpm2ClearControl - %r\n", Status));
> +  if (EFI_ERROR (Status)) {
> +    goto Done;
> +  }
> +  DEBUG ((EFI_D_INFO, "Tpm2Clear ... \n"));
> +  Status =3D Tpm2Clear (TPM_RH_PLATFORM, AuthSession);
> +  DEBUG ((EFI_D_INFO, "Tpm2Clear - %r\n", Status));
> +
> +Done:
> +  ZeroMem (&LocalAuthSession.hmac, sizeof (LocalAuthSession.hmac));
> +  return Status;
> +}
> +
> +
> +/**
> +  Change EPS.
> +
> +  @param[in]  PlatformAuth      platform auth value. NULL means no pla=
tform auth change.
> +
> +  @retval EFI_SUCCESS Operation completed successfully.
> +**/
> +EFI_STATUS
> +Tpm2CommandChangeEps (
> +  IN TPM2B_AUTH                *PlatformAuth  OPTIONAL
> +  )
> +{
> +  EFI_STATUS                Status;
> +  TPMS_AUTH_COMMAND         *AuthSession;
> +  TPMS_AUTH_COMMAND         LocalAuthSession;
> +
> +  if (PlatformAuth =3D=3D NULL) {
> +    AuthSession =3D NULL;
> +  } else {
> +    AuthSession =3D &LocalAuthSession;
> +    ZeroMem (&LocalAuthSession, sizeof (LocalAuthSession));
> +    LocalAuthSession.sessionHandle =3D TPM_RS_PW;
> +    LocalAuthSession.hmac.size =3D PlatformAuth->size;
> +    CopyMem (LocalAuthSession.hmac.buffer, PlatformAuth->buffer, Platf=
ormAuth->size);
> +  }
> +
> +  Status =3D Tpm2ChangeEPS (TPM_RH_PLATFORM, AuthSession);
> +  DEBUG ((EFI_D_INFO, "Tpm2ChangeEPS - %r\n", Status));
> +
> +  ZeroMem (&LocalAuthSession.hmac, sizeof(LocalAuthSession.hmac));
> +  return Status;
> +}
> +
> +
> +/**
> +  Execute physical presence operation requested by the OS.
> +
> +  @param[in]      PlatformAuth        platform auth value. NULL means =
no platform auth change.
> +  @param[in]      CommandCode         Physical presence operation valu=
e.
> +  @param[in]      CommandParameter    Physical presence operation para=
meter.
> +
> +  @retval TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE   Unknown physical pr=
esence operation.
> +  @retval TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE   Error occurred duri=
ng sending command to TPM or
> +                                                   receiving response =
from TPM.
> +  @retval Others                                   Return code from th=
e TPM device after command execution.
> +**/
> +UINT32
> +Tcg2ExecutePhysicalPresence (
> +  IN      TPM2B_AUTH                       *PlatformAuth,  OPTIONAL
> +  IN      UINT32                           CommandCode,
> +  IN      UINT32                           CommandParameter
> +  )
> +{
> +  EFI_STATUS                        Status;
> +  EFI_TCG2_EVENT_ALGORITHM_BITMAP   TpmHashAlgorithmBitmap;
> +  UINT32                            ActivePcrBanks;
> +
> +  switch (CommandCode) {
> +    case TCG2_PHYSICAL_PRESENCE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3:
> +      Status =3D Tpm2CommandClear (PlatformAuth);
> +      if (EFI_ERROR (Status)) {
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      } else {
> +        return TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +      }
> +
> +    case TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS:
> +      Status =3D Tpm2GetCapabilitySupportedAndActivePcrs (&TpmHashAlgo=
rithmBitmap, &ActivePcrBanks);
> +      ASSERT_EFI_ERROR (Status);
> +
> +      //
> +      // PP spec requirements:
> +      //    Firmware should check that all requested (set) hashing alg=
orithms are supported with respective PCR banks.
> +      //    Firmware has to ensure that at least one PCR banks is acti=
ve.
> +      // If not, an error is returned and no action is taken.
> +      //
> +      if (CommandParameter =3D=3D 0 || (CommandParameter & (~TpmHashAl=
gorithmBitmap)) !=3D 0) {
> +        DEBUG((DEBUG_ERROR, "PCR banks %x to allocate are not supporte=
d by TPM. Skip operation\n", CommandParameter));
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      }
> +
> +      Status =3D Tpm2PcrAllocateBanks (PlatformAuth, TpmHashAlgorithmB=
itmap, CommandParameter);
> +      if (EFI_ERROR (Status)) {
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      } else {
> +        return TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +      }
> +
> +    case TCG2_PHYSICAL_PRESENCE_CHANGE_EPS:
> +      Status =3D Tpm2CommandChangeEps (PlatformAuth);
> +      if (EFI_ERROR (Status)) {
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      } else {
> +        return TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +      }
> +
> +    case TCG2_PHYSICAL_PRESENCE_LOG_ALL_DIGESTS:
> +      Status =3D Tpm2GetCapabilitySupportedAndActivePcrs (&TpmHashAlgo=
rithmBitmap, &ActivePcrBanks);
> +      ASSERT_EFI_ERROR (Status);
> +      Status =3D Tpm2PcrAllocateBanks (PlatformAuth, TpmHashAlgorithmB=
itmap, TpmHashAlgorithmBitmap);
> +      if (EFI_ERROR (Status)) {
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      } else {
> +        return TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +      }
> +
> +    default:
> +      if (CommandCode <=3D TCG2_PHYSICAL_PRESENCE_NO_ACTION_MAX) {
> +        return TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +      } else {
> +        return TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +      }
> +  }
> +}
> +
> +
> +/**
> +  Read the specified key for user confirmation.
> +
> +  @param[in]  CautionKey  If true,  F12 is used as confirm key;
> +                          If false, F10 is used as confirm key.
> +
> +  @retval     TRUE        User confirmed the changes by input.
> +  @retval     FALSE       User discarded the changes.
> +**/
> +BOOLEAN
> +Tcg2ReadUserKey (
> +  IN     BOOLEAN                    CautionKey
> +  )
> +{
> +  EFI_STATUS                        Status;
> +  EFI_INPUT_KEY                     Key;
> +  UINT16                            InputKey;
> +
> +  InputKey =3D 0;
> +  do {
> +    Status =3D gBS->CheckEvent (gST->ConIn->WaitForKey);
> +    if (!EFI_ERROR (Status)) {
> +      Status =3D gST->ConIn->ReadKeyStroke (gST->ConIn, &Key);
> +      if (Key.ScanCode =3D=3D SCAN_ESC) {
> +        InputKey =3D Key.ScanCode;
> +      }
> +      if ((Key.ScanCode =3D=3D SCAN_F10) && !CautionKey) {
> +        InputKey =3D Key.ScanCode;
> +      }
> +      if ((Key.ScanCode =3D=3D SCAN_F12) && CautionKey) {
> +        InputKey =3D Key.ScanCode;
> +      }
> +    }
> +  } while (InputKey =3D=3D 0);
> +
> +  if (InputKey !=3D SCAN_ESC) {
> +    return TRUE;
> +  }
> +
> +  return FALSE;
> +}
> +
> +
> +/**
> +  Fill Buffer With BootHashAlg.
> +
> +  @param[in] Buffer               Buffer to be filled.
> +  @param[in] BufferSize           Size of buffer.
> +  @param[in] BootHashAlg          BootHashAlg.
> +
> +**/
> +VOID
> +Tcg2FillBufferWithBootHashAlg (
> +  IN UINT16  *Buffer,
> +  IN UINTN   BufferSize,
> +  IN UINT32  BootHashAlg
> +  )
> +{
> +  Buffer[0] =3D 0;
> +  if ((BootHashAlg & EFI_TCG2_BOOT_HASH_ALG_SHA1) !=3D 0) {
> +    if (Buffer[0] !=3D 0) {
> +      StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L", ", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +    }
> +    StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L"SHA1", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +  }
> +  if ((BootHashAlg & EFI_TCG2_BOOT_HASH_ALG_SHA256) !=3D 0) {
> +    if (Buffer[0] !=3D 0) {
> +      StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L", ", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +    }
> +    StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L"SHA256", (Buffer=
Size / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +  }
> +  if ((BootHashAlg & EFI_TCG2_BOOT_HASH_ALG_SHA384) !=3D 0) {
> +    if (Buffer[0] !=3D 0) {
> +      StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L", ", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +    }
> +    StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L"SHA384", (Buffer=
Size / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +  }
> +  if ((BootHashAlg & EFI_TCG2_BOOT_HASH_ALG_SHA512) !=3D 0) {
> +    if (Buffer[0] !=3D 0) {
> +      StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L", ", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +    }
> +    StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L"SHA512", (Buffer=
Size / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +  }
> +  if ((BootHashAlg & EFI_TCG2_BOOT_HASH_ALG_SM3_256) !=3D 0) {
> +    if (Buffer[0] !=3D 0) {
> +      StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L", ", (BufferSi=
ze / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +    }
> +    StrnCatS (Buffer, BufferSize / sizeof (CHAR16), L"SM3_256", (Buffe=
rSize / sizeof (CHAR16)) - StrLen (Buffer) - 1);
> +  }
> +}
> +
> +
> +/**
> +  Display the confirm text and get user confirmation.
> +
> +  @param[in] TpmPpCommand             The requested TPM physical prese=
nce command.
> +  @param[in] TpmPpCommandParameter    The requested TPM physical prese=
nce command parameter.
> +
> +  @retval    TRUE          The user has confirmed the changes.
> +  @retval    FALSE         The user doesn't confirm the changes.
> +**/
> +BOOLEAN
> +Tcg2UserConfirm (
> +  IN      UINT32                    TpmPpCommand,
> +  IN      UINT32                    TpmPpCommandParameter
> +  )
> +{
> +  CHAR16                            *ConfirmText;
> +  CHAR16                            *TmpStr1;
> +  CHAR16                            *TmpStr2;
> +  UINTN                             BufSize;
> +  BOOLEAN                           CautionKey;
> +  BOOLEAN                           NoPpiInfo;
> +  UINT16                            Index;
> +  CHAR16                            DstStr[81];
> +  CHAR16                            TempBuffer[1024];
> +  CHAR16                            TempBuffer2[1024];
> +  EFI_TCG2_PROTOCOL                 *Tcg2Protocol;
> +  EFI_TCG2_BOOT_SERVICE_CAPABILITY  ProtocolCapability;
> +  UINT32                            CurrentPCRBanks;
> +  EFI_STATUS                        Status;
> +
> +  TmpStr2     =3D NULL;
> +  CautionKey  =3D FALSE;
> +  NoPpiInfo   =3D FALSE;
> +  BufSize     =3D CONFIRM_BUFFER_SIZE;
> +  ConfirmText =3D AllocateZeroPool (BufSize);
> +  ASSERT (ConfirmText !=3D NULL);
> +
> +  mTcg2PpStringPackHandle =3D HiiAddPackages (&gEfiTcg2PhysicalPresenc=
eGuid, gImageHandle, DxeTcg2PhysicalPresenceLibStrings, NULL);
> +  ASSERT (mTcg2PpStringPackHandle !=3D NULL);
> +
> +  switch (TpmPpCommand) {
> +
> +    case TCG2_PHYSICAL_PRESENCE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3:
> +      CautionKey =3D TRUE;
> +      TmpStr2 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_CLEAR));
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_HEAD_STR));
> +      UnicodeSPrint (ConfirmText, BufSize, TmpStr1, TmpStr2);
> +      FreePool (TmpStr1);
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_WARNING_CLEAR));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), L" \n\n", (Buf=
Size / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      break;
> +
> +    case TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS:
> +      Status =3D gBS->LocateProtocol (&gEfiTcg2ProtocolGuid, NULL, (VO=
ID **) &Tcg2Protocol);
> +      ASSERT_EFI_ERROR (Status);
> +
> +      ProtocolCapability.Size =3D sizeof(ProtocolCapability);
> +      Status =3D Tcg2Protocol->GetCapability (
> +                               Tcg2Protocol,
> +                               &ProtocolCapability
> +                               );
> +      ASSERT_EFI_ERROR (Status);
> +
> +      Status =3D Tcg2Protocol->GetActivePcrBanks (
> +                               Tcg2Protocol,
> +                               &CurrentPCRBanks
> +                               );
> +      ASSERT_EFI_ERROR (Status);
> +
> +      CautionKey =3D TRUE;
> +      TmpStr2 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_SET_PCR_BANKS));
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_HEAD_STR));
> +      UnicodeSPrint (ConfirmText, BufSize, TmpStr1, TmpStr2);
> +      FreePool (TmpStr1);
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_WARNING_SET_PCR_BANKS_1));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_WARNING_SET_PCR_BANKS_2));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      Tcg2FillBufferWithBootHashAlg (TempBuffer, sizeof(TempBuffer), T=
pmPpCommandParameter);
> +      Tcg2FillBufferWithBootHashAlg (TempBuffer2, sizeof(TempBuffer2),=
 CurrentPCRBanks);
> +
> +      TmpStr1 =3D AllocateZeroPool (BufSize);
> +      ASSERT (TmpStr1 !=3D NULL);
> +      UnicodeSPrint (TmpStr1, BufSize, L"Current PCRBanks is 0x%x. (%s=
)\nNew PCRBanks is 0x%x. (%s)\n", CurrentPCRBanks, TempBuffer2, TpmPpComm=
andParameter, TempBuffer);
> +
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), L" \n", (BufSi=
ze / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      break;
> +
> +    case TCG2_PHYSICAL_PRESENCE_CHANGE_EPS:
> +      CautionKey =3D TRUE;
> +      TmpStr2 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_CHANGE_EPS));
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_HEAD_STR));
> +      UnicodeSPrint (ConfirmText, BufSize, TmpStr1, TmpStr2);
> +      FreePool (TmpStr1);
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_WARNING_CHANGE_EPS_1));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_WARNING_CHANGE_EPS_2));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +
> +      break;
> +
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_BLOCK_SID:
> +      TmpStr2 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_ENABLE_BLOCK_SID));
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_HEAD_STR));
> +      UnicodeSPrint (ConfirmText, BufSize, TmpStr1, TmpStr2);
> +      FreePool (TmpStr1);
> +      break;
> +
> +    case TCG2_PHYSICAL_PRESENCE_DISABLE_BLOCK_SID:
> +      TmpStr2 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_DISABLE_BLOCK_SID));
> +
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_HEAD_STR));
> +      UnicodeSPrint (ConfirmText, BufSize, TmpStr1, TmpStr2);
> +      FreePool (TmpStr1);
> +      break;
> +
> +    default:
> +      ;
> +  }
> +
> +  if (TmpStr2 =3D=3D NULL) {
> +    FreePool (ConfirmText);
> +    return FALSE;
> +  }
> +
> +  if (TpmPpCommand < TCG2_PHYSICAL_PRESENCE_STORAGE_MANAGEMENT_BEGIN) =
{
> +    if (CautionKey) {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_CAUTION_KEY));
> +    } else {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_ACCEPT_KEY));
> +    }
> +    StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufSiz=
e / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +    FreePool (TmpStr1);
> +
> +    if (NoPpiInfo) {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM=
_NO_PPI_INFO));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +    }
> +
> +    TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TPM_R=
EJECT_KEY));
> +  } else {
> +    if (CautionKey) {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_CAUTION_KEY));
> +    } else {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_ACCEPT_KEY));
> +    }
> +    StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufSiz=
e / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +    FreePool (TmpStr1);
> +
> +    if (NoPpiInfo) {
> +      TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG=
_STORAGE_NO_PPI_INFO));
> +      StrnCatS (ConfirmText, BufSize / sizeof (CHAR16), TmpStr1, (BufS=
ize / sizeof (CHAR16)) - StrLen (ConfirmText) - 1);
> +      FreePool (TmpStr1);
> +    }
> +
> +    TmpStr1 =3D Tcg2PhysicalPresenceGetStringById (STRING_TOKEN (TCG_S=
TORAGE_REJECT_KEY));
> +  }
> +  BufSize -=3D StrSize (ConfirmText);
> +  UnicodeSPrint (ConfirmText + StrLen (ConfirmText), BufSize, TmpStr1,=
 TmpStr2);
> +
> +  DstStr[80] =3D L'\0';
> +  for (Index =3D 0; Index < StrLen (ConfirmText); Index +=3D 80) {
> +    StrnCpyS (DstStr, sizeof (DstStr) / sizeof (CHAR16), ConfirmText +=
 Index, sizeof (DstStr) / sizeof (CHAR16) - 1);
> +    Print (DstStr);
> +  }
> +
> +  FreePool (TmpStr1);
> +  FreePool (TmpStr2);
> +  FreePool (ConfirmText);
> +  HiiRemovePackages (mTcg2PpStringPackHandle);
> +
> +  if (Tcg2ReadUserKey (CautionKey)) {
> +    return TRUE;
> +  }
> +
> +  return FALSE;
> +}
> +
> +
> +/**
> +  Check if there is a valid physical presence command request. Also up=
dates parameter value
> +  to whether the requested physical presence command already confirmed=
 by user
> +
> +   @param[out] RequestConfirmed          If the physical presence oper=
ation command required user confirm from UI.
> +                                           True, it indicates the comm=
and doesn't require user confirm, or already confirmed
> +                                                 in last boot cycle by=
 user.
> +                                           False, it indicates the com=
mand need user confirm from UI.
> +
> +   @retval  TRUE        Physical Presence operation command is valid.
> +   @retval  FALSE       Physical Presence operation command is invalid=
.
> +
> +**/
> +BOOLEAN
> +Tcg2HaveValidTpmRequest  (
> +  OUT     BOOLEAN                          *RequestConfirmed
> +  )
> +{
> +  EFI_TCG2_PROTOCOL                 *Tcg2Protocol;
> +  EFI_STATUS                        Status;
> +
> +  *RequestConfirmed =3D FALSE;
> +
> +  if (mPpi->Request <=3D TCG2_PHYSICAL_PRESENCE_NO_ACTION_MAX) {
> +    //
> +    // Need TCG2 protocol.
> +    //
> +    Status =3D gBS->LocateProtocol (&gEfiTcg2ProtocolGuid, NULL, (VOID=
 **) &Tcg2Protocol);
> +    if (EFI_ERROR (Status)) {
> +      return FALSE;
> +    }
> +  }
> +
> +  switch (mPpi->Request) {
> +    case TCG2_PHYSICAL_PRESENCE_NO_ACTION:
> +    case TCG2_PHYSICAL_PRESENCE_LOG_ALL_DIGESTS:
> +      *RequestConfirmed =3D TRUE;
> +      return TRUE;
> +
> +    case TCG2_PHYSICAL_PRESENCE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3:
> +    case TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS:
> +    case TCG2_PHYSICAL_PRESENCE_CHANGE_EPS:
> +    case TCG2_PHYSICAL_PRESENCE_ENABLE_BLOCK_SID:
> +    case TCG2_PHYSICAL_PRESENCE_DISABLE_BLOCK_SID:
> +      break;
> +
> +    default:
> +      //
> +      // Wrong Physical Presence command
> +      //
> +      return FALSE;
> +  }
> +
> +  //
> +  // Physical Presence command is correct
> +  //
> +  return TRUE;
> +}
> +
> +
> +/**
> +  Check and execute the requested physical presence command.
> +
> +  @param[in]      PlatformAuth      platform auth value. NULL means no=
 platform auth change.
> +**/
> +VOID
> +Tcg2ExecutePendingTpmRequest (
> +  IN      TPM2B_AUTH                       *PlatformAuth OPTIONAL
> +  )
> +{
> +  BOOLEAN                           RequestConfirmed;
> +
> +  if (mPpi->Request =3D=3D TCG2_PHYSICAL_PRESENCE_NO_ACTION) {
> +    //
> +    // No operation request
> +    //
> +    return;
> +  }
> +
> +  if (!Tcg2HaveValidTpmRequest (&RequestConfirmed)) {
> +    //
> +    // Invalid operation request.
> +    //
> +    if (mPpi->Request <=3D TCG2_PHYSICAL_PRESENCE_NO_ACTION_MAX) {
> +      mPpi->Response =3D TCG_PP_OPERATION_RESPONSE_SUCCESS;
> +    } else {
> +      mPpi->Response =3D TCG_PP_OPERATION_RESPONSE_BIOS_FAILURE;
> +    }
> +    mPpi->LastRequest =3D mPpi->Request;
> +    mPpi->Request =3D TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +    mPpi->RequestParameter =3D 0;
> +    return;
> +  }
> +
> +  if (!RequestConfirmed) {
> +    //
> +    // Print confirm text and wait for approval.
> +    //
> +    RequestConfirmed =3D Tcg2UserConfirm (mPpi->Request, mPpi->Request=
Parameter);
> +  }
> +
> +  //
> +  // Execute requested physical presence command
> +  //
> +  mPpi->Response =3D TCG_PP_OPERATION_RESPONSE_USER_ABORT;
> +  if (RequestConfirmed) {
> +    mPpi->Response =3D Tcg2ExecutePhysicalPresence (
> +                                                  PlatformAuth,
> +                                                  mPpi->Request,
> +                                                  mPpi->RequestParamet=
er
> +                                                  );
> +  }
> +
> +  //
> +  // Clear request
> +  //
> +  mPpi->LastRequest =3D mPpi->Request;
> +  mPpi->Request =3D TCG2_PHYSICAL_PRESENCE_NO_ACTION;
> +  mPpi->RequestParameter =3D 0;
> +
> +  if (mPpi->Response =3D=3D TCG_PP_OPERATION_RESPONSE_USER_ABORT) {
> +    return;
> +  }
> +
> +  //
> +  // Reset system to make new TPM settings in effect
> +  //
> +  switch (mPpi->LastRequest) {
> +  case TCG2_PHYSICAL_PRESENCE_CLEAR:
> +  case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR:
> +  case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_2:
> +  case TCG2_PHYSICAL_PRESENCE_ENABLE_CLEAR_3:
> +  case TCG2_PHYSICAL_PRESENCE_SET_PCR_BANKS:
> +  case TCG2_PHYSICAL_PRESENCE_CHANGE_EPS:
> +  case TCG2_PHYSICAL_PRESENCE_LOG_ALL_DIGESTS:
> +    break;
> +
> +  case TCG2_PHYSICAL_PRESENCE_ENABLE_BLOCK_SID:
> +  case TCG2_PHYSICAL_PRESENCE_DISABLE_BLOCK_SID:
> +    break;
> +
> +  default:
> +    if (mPpi->Request !=3D TCG2_PHYSICAL_PRESENCE_NO_ACTION) {
> +      break;
> +    }
> +    return;
> +  }
> +
> +  Print (L"Rebooting system to make TPM2 settings in effect\n");
> +  gRT->ResetSystem (EfiResetCold, EFI_SUCCESS, 0, NULL);
> +  ASSERT (FALSE);
> +}
> +
> +
> +/**
> +   Check and execute the pending TPM request.
> +
> +   The TPM request may come from OS or BIOS. This API will display req=
uest information and wait
> +   for user confirmation if TPM request exists. The TPM request will b=
e sent to TPM device after
> +   the TPM request is confirmed, and one or more reset may be required=
 to make TPM request to
> +   take effect.
> +
> +   This API should be invoked after console in and console out are all=
 ready as they are required
> +   to display request information and get user input to confirm the re=
quest.
> +
> +   @param[in]  PlatformAuth                   platform auth value. NUL=
L means no platform auth change.
> +**/
> +VOID
> +EFIAPI
> +Tcg2PhysicalPresenceLibProcessRequest (
> +  IN      TPM2B_AUTH                     *PlatformAuth  OPTIONAL
> +  )
> +{
> +  EFI_STATUS Status;
> +
> +  Status =3D QemuTpmInitPPI ();
> +  if (EFI_ERROR (Status)) {
> +    DEBUG ((EFI_D_INFO, "[TPM2PP] no TPM\n"));
> +    return ;
> +  }
> +
> +  //
> +  // Check S4 resume
> +  //
> +  if (GetBootModeHob () =3D=3D BOOT_ON_S4_RESUME) {
> +    DEBUG ((EFI_D_INFO, "S4 Resume, Skip TPM PP process!\n"));
> +    return ;
> +  }
> +
> +  DEBUG ((EFI_D_INFO, "[TPM2PP] PPRequest=3D%x (PPRequestParameter=3D%=
x)\n", mPpi->Request, mPpi->RequestParameter));
> +  Tcg2ExecutePendingTpmRequest (PlatformAuth);
> +}
> +
> +
> +/**
> +  The handler for TPM physical presence function:
> +  Return TPM Operation Response to OS Environment.
> +
> +  @param[out]     MostRecentRequest Most recent operation request.
> +  @param[out]     Response          Response to the most recent operat=
ion request.
> +
> +  @return Return Code for Return TPM Operation Response to OS Environm=
ent.
> +**/
> +UINT32
> +EFIAPI
> +Tcg2PhysicalPresenceLibReturnOperationResponseToOsFunction (
> +  OUT UINT32                *MostRecentRequest,
> +  OUT UINT32                *Response
> +  )
> +{
> +  EFI_STATUS Status;
> +
> +  DEBUG ((EFI_D_INFO, "[TPM2PP] ReturnOperationResponseToOsFunction\n"=
));
> +
> +  Status =3D QemuTpmInitPPI ();
> +  if (EFI_ERROR (Status)) {
> +      DEBUG ((EFI_D_INFO, "[TPM2PP] no TPM\n"));
> +      *MostRecentRequest =3D 0;
> +      *Response          =3D 0;
> +      return TCG_PP_RETURN_TPM_OPERATION_RESPONSE_FAILURE;
> +  }
> +
> +  *MostRecentRequest =3D mPpi->LastRequest;
> +  *Response          =3D mPpi->Response;
> +
> +  return TCG_PP_RETURN_TPM_OPERATION_RESPONSE_SUCCESS;
> +}
> +
> +
> +/**
> +  The handler for TPM physical presence function:
> +  Submit TPM Operation Request to Pre-OS Environment and
> +  Submit TPM Operation Request to Pre-OS Environment 2.
> +
> +  Caution: This function may receive untrusted input.
> +
> +  @param[in]      OperationRequest TPM physical presence operation req=
uest.
> +  @param[in]      RequestParameter TPM physical presence operation req=
uest parameter.
> +
> +  @return Return Code for Submit TPM Operation Request to Pre-OS Envir=
onment and
> +          Submit TPM Operation Request to Pre-OS Environment 2.
> +**/
> +UINT32
> +EFIAPI
> +Tcg2PhysicalPresenceLibSubmitRequestToPreOSFunction (
> +  IN UINT32                 OperationRequest,
> +  IN UINT32                 RequestParameter
> +  )
> +{
> +  EFI_STATUS Status;
> +
> +  DEBUG ((EFI_D_INFO, "[TPM2PP] SubmitRequestToPreOSFunction, Request =
=3D %x, %x\n", OperationRequest, RequestParameter));
> +
> +  Status =3D QemuTpmInitPPI ();
> +  if (EFI_ERROR (Status)) {
> +      DEBUG ((EFI_D_INFO, "[TPM2PP] no TPM\n"));
> +      return TCG_PP_SUBMIT_REQUEST_TO_PREOS_GENERAL_FAILURE;
> +  }
> +
> +  mPpi->Request =3D OperationRequest;
> +  mPpi->RequestParameter =3D RequestParameter;
> +
> +  return TCG_PP_SUBMIT_REQUEST_TO_PREOS_SUCCESS;
> +}

Right; the Tcg2PhysicalPresenceLib class is a bit tricky because it
provides two sets of interfaces.

The common trait between both sets is that all of these functions have
to call QemuTpmInitPPI() in this lib instance.

And the distinguishing factor is that
- the first set, namely ProcessRequest() alone, is provided to platform B=
DS,
- while the second set, consisting of SubmitRequestToPreOSFunction() and
 ReturnOperationResponseToOsFunction(), is required by the TCG2 protocol
implementation.

(17) Thus, my request here is that you please update the first bullet
point in the commit message:

  - remove all the functions that are unreachable from ProcessRequest()
    [called from platform BDS], or SubmitRequestToPreOSFunction() and
    ReturnOperationResponseToOsFunction() [called from Tcg2Dxe].

> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Physica=
lPresenceLib.inf b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Phy=
sicalPresenceLib.inf
> new file mode 100644
> index 000000000000..6b2d70c711fe
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresen=
ceLib.inf
> @@ -0,0 +1,67 @@
> +## @file
> +#  Executes TPM 2.0 requests from OS or BIOS
> +#
> +#  This library will check and execute TPM 2.0 request from OS or BIOS=
. The request may
> +#  ask for user confirmation before execution.

(18) Please append the two main bullet points from the commit message to
this comment as well (as updated according to (17)).

> +#
> +#  Caution: This module requires additional review when modified.
> +#  This driver will have external input - variable.
> +#  This external input must be validated carefully to avoid security i=
ssue.
> +#
> +# Copyright (C) 2018, Red Hat, Inc.
> +# Copyright (c) 2013 - 2016, Intel Corporation. All rights reserved.<B=
R>
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
> +
> +[Defines]
> +  INF_VERSION                    =3D 0x00010005
> +  BASE_NAME                      =3D DxeTcg2PhysicalPresenceLib

(19) This should say "Tcg2PhysicalPresenceLibQemu".

> +  MODULE_UNI_FILE                =3D DxeTcg2PhysicalPresenceLib.uni
> +  FILE_GUID                      =3D 41D3E698-9EEC-41FF-9CBB-5FE79A0CF=
326
> +  MODULE_TYPE                    =3D DXE_DRIVER
> +  VERSION_STRING                 =3D 1.0
> +  LIBRARY_CLASS                  =3D Tcg2PhysicalPresenceLib|DXE_DRIVE=
R DXE_RUNTIME_DRIVER DXE_SAL_DRIVER UEFI_APPLICATION UEFI_DRIVER
> +
> +#
> +# The following information is for reference only and not required by =
the build tools.
> +#
> +#  VALID_ARCHITECTURES           =3D IA32 X64 IPF EBC
> +#
> +
> +[Sources]
> +  DxeTcg2PhysicalPresenceLib.c
> +  PhysicalPresenceStrings.uni
> +
> +[Packages]
> +  MdePkg/MdePkg.dec
> +  MdeModulePkg/MdeModulePkg.dec
> +  OvmfPkg/OvmfPkg.dec
> +  SecurityPkg/SecurityPkg.dec
> +
> +[LibraryClasses]
> +  BaseMemoryLib
> +  DebugLib
> +  HiiLib
> +  HobLib
> +  MemoryAllocationLib
> +  PrintLib
> +  QemuFwCfgLib
> +  Tpm2CommandLib
> +  UefiBootServicesTableLib
> +  UefiLib
> +  UefiRuntimeServicesTableLib
> +
> +[Protocols]
> +  gEfiTcg2ProtocolGuid                 ## SOMETIMES_CONSUMES
> +
> +[Guids]
> +  ## SOMETIMES_CONSUMES ## HII
> +  ## SOMETIMES_PRODUCES ## Variable:L"Tcg2PhysicalPresence"
> +  ## SOMETIMES_CONSUMES ## Variable:L"Tcg2PhysicalPresence"

(20) Please drop the above two comment lines
('Variable:L"Tcg2PhysicalPresence"' is TCG2_PHYSICAL_PRESENCE_VARIABLE.)

> +  gEfiTcg2PhysicalPresenceGuid
> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Physica=
lPresenceLib.uni b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2Phy=
sicalPresenceLib.uni
> new file mode 100644
> index 000000000000..aaae8f5014e7
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/DxeTcg2PhysicalPresen=
ceLib.uni
> @@ -0,0 +1,26 @@
> +// /** @file
> +// Executes TPM 2.0 requests from OS or BIOS
> +//
> +// This library will check and execute TPM 2.0 request from OS or BIOS=
. The request may
> +// ask for user confirmation before execution.
> +//
> +// Caution: This module requires additional review when modified.
> +// This driver will have external input - variable.
> +// This external input must be validated carefully to avoid security i=
ssue.
> +//
> +// Copyright (c) 2013 - 2014, Intel Corporation. All rights reserved.<=
BR>
> +//
> +// This program and the accompanying materials
> +// are licensed and made available under the terms and conditions of t=
he BSD License
> +// which accompanies this distribution. The full text of the license m=
ay be found at
> +// http://opensource.org/licenses/bsd-license.php
> +// THE PROGRAM IS DISTRIBUTED UNDER THE BSD LICENSE ON AN "AS IS" BASI=
S,
> +// WITHOUT WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS O=
R IMPLIED.
> +//
> +// **/
> +
> +
> +#string STR_MODULE_ABSTRACT             #language en-US "Executes TPM =
2.0 requests from OS or BIOS"
> +
> +#string STR_MODULE_DESCRIPTION          #language en-US "This library =
will check and execute TPM 2.0 request from OS or BIOS. The request may a=
sk for user confirmation before execution.\n"
> +                                                        "Caution: This=
 module requires additional review when modified. This driver will have e=
xternal input - variable. This external input must be validated carefully=
 to avoid security issue."
> diff --git a/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/PhysicalPresen=
ceStrings.uni b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/PhysicalPrese=
nceStrings.uni
> new file mode 100644
> index 000000000000..1470286b4c3b
> --- /dev/null
> +++ b/OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/PhysicalPresenceStrin=
gs.uni
> @@ -0,0 +1,49 @@
> +/** @file
> +  String definitions for TPM 2.0 physical presence confirm text.
> +
> +Copyright (c) 2013 - 2014, Intel Corporation. All rights reserved.<BR>
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
> +#langdef en-US "English"
> +
> +#string TPM_HEAD_STR                  #language en-US    "A configurat=
ion change was requested to %s this computer's TPM (Trusted Platform Modu=
le)\n\n"
> +
> +#string TPM_ACCEPT_KEY                #language en-US    "Press F10 "
> +#string TPM_CAUTION_KEY               #language en-US    "Press F12 "
> +#string TPM_REJECT_KEY                #language en-US    "to %s the TP=
M \nPress ESC to reject this change request and continue\n"
> +
> +#string TPM_ENABLE                    #language en-US    "enable"
> +#string TPM_DISABLE                   #language en-US    "disable"

(21) I think you can remove these two

> +#string TPM_CLEAR                     #language en-US    "clear"
> +#string TPM_SET_PCR_BANKS                       #language en-US    "ch=
ange the boot measurements to use PCR bank(s) of"
> +#string TPM_CHANGE_EPS                          #language en-US    "cl=
ear and change identity of"
> +
> +#string TPM_NO_PPI_MAINTAIN           #language en-US    "maintain"
> +#string TPM_NO_PPI_TURN_ON            #language en-US    "turn on"
> +#string TPM_NO_PPI_TURN_OFF           #language en-US    "turn off"

(22) these three appear unused as well

The rest looks good. Thanks!
Laszlo

> +#string TPM_NO_PPI_INFO               #language en-US    "to approve f=
uture Operating System requests "
> +
> +#string TPM_WARNING_CLEAR             #language en-US    "WARNING: Cle=
aring erases information stored on the TPM. You will lose all created key=
s and access to data encrypted by these keys. "
> +#string TPM_WARNING_SET_PCR_BANKS_1                     #language en-U=
S    "WARNING: Changing the PCR bank(s) of the boot measurements may prev=
ent the Operating System from properly processing the measurements. Pleas=
e check if your Operating System supports the new PCR bank(s).\n\n"
> +#string TPM_WARNING_SET_PCR_BANKS_2                     #language en-U=
S    "WARNING: Secrets in the TPM that are bound to the boot state of you=
r machine may become unusable.\n\n"
> +#string TPM_WARNING_CHANGE_EPS_1                        #language en-U=
S    "WARNING: Clearing erases information stored on the TPM. You will lo=
se all created keys and access to data encrypted with these keys.\n\n"
> +#string TPM_WARNING_CHANGE_EPS_2                        #language en-U=
S    "WARNING: Changing the identity of the TPM may require additional st=
eps to establish trust into the new identity.\n\n"
> +
> +#string TCG_STORAGE_HEAD_STR                  #language en-US    "A co=
nfiguration change was requested to %s on subsequent boots\n\n"
> +
> +#string TCG_STORAGE_ACCEPT_KEY                #language en-US    "Pres=
s F10 "
> +#string TCG_STORAGE_CAUTION_KEY               #language en-US    "Pres=
s F12 "
> +#string TCG_STORAGE_REJECT_KEY                #language en-US    "to %=
s\nPress ESC to reject this change request and continue\n"
> +
> +#string TCG_STORAGE_NO_PPI_INFO               #language en-US    "to a=
pprove future Operating System requests "
> +
> +#string TCG_STORAGE_ENABLE_BLOCK_SID          #language en-US    "issu=
e a Block SID authentication command"
> +#string TCG_STORAGE_DISABLE_BLOCK_SID         #language en-US    "disa=
ble issuing a Block SID authentication command"
> diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
> index 6c361b73cd55..251434a9ff7c 100644
> --- a/OvmfPkg/OvmfPkgIa32.dsc
> +++ b/OvmfPkg/OvmfPkgIa32.dsc
> @@ -206,7 +206,7 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> -  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/=
DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !else
>    Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
> diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
> index 62a6075a671d..ce247a59d61a 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.dsc
> +++ b/OvmfPkg/OvmfPkgIa32X64.dsc
> @@ -211,7 +211,7 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> -  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/=
DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !else
>    Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index cbab1aa328c6..67f7e155ee3e 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -211,7 +211,7 @@ [LibraryClasses]
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>    Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> -  Tcg2PhysicalPresenceLib|SecurityPkg/Library/DxeTcg2PhysicalPresenceL=
ib/DxeTcg2PhysicalPresenceLib.inf
> +  Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibQemu/=
DxeTcg2PhysicalPresenceLib.inf
>    Tcg2PpVendorLib|SecurityPkg/Library/Tcg2PpVendorLibNull/Tcg2PpVendor=
LibNull.inf
>  !else
>    Tcg2PhysicalPresenceLib|OvmfPkg/Library/Tcg2PhysicalPresenceLibNull/=
DxeTcg2PhysicalPresenceLib.inf
>=20
