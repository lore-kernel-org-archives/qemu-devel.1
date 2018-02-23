Received: from eggs.gnu.org ([2001:4830:134:3::10]:38199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epHC6-0004Wp-MY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1epHC5-0002cJ-3X
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36032 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1epHC4-0002bV-Um
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:31:37 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-3-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <080742f0-0f3c-bf8e-83d7-e473417cc172@redhat.com>
Date: Fri, 23 Feb 2018 18:31:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 2/7] ovmf: link with Tcg2ConfigPei
 module
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

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> This module initializes TPM device type based on variable and
> detection.

(1) I suggest we say the following here:

"The Tcg2ConfigPei module informs the firmware globally about the TPM
device type, by setting the PcdTpmInstanceGuid PCD to the appropriate
GUID value. The original module under SecurityPkg can perform device
detection, or read a cached value from a non-volatile UEFI variable.
OvmfPkg's clone of the module always performs the hardware detection."

Becase...

> The module requires VariablePei, which is built with
> MEM_VARSTORE_EMU_ENABLE=3DFALSE.

(2) ... as I hinted in my response to your blurb, and also as suggested
by "Tcg2ConfigPei.inf", we should clone Tcg2ConfigPei for OVMF, and
*trim it* quite a bit.

- The new location should be "OvmfPkg/Tcg/Tcg2Config/".

- We need not copy the ".uni" file (also drop MODULE_UNI_FILE from the
INF file)

- Re-generate FILE_GUID in the INF file with "uuidgen"

- Remove all PEI-phase variable access; always perform the hw detection.

- I would even suggest removing support for TPM1.2. Just check whether
TPM2 is available or not.


(3) Ultimately, this is what the module should do:

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


(4) Regarding the TPM detection itself. It looks like DetectTpmDevice()
[SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c] calls a number of TPM1.2
functions. If the earliest one fails, it assumes "no TPM" at all, but if
only a later call fails, it deduces, from the 1.2 failure, that TPM2 exis=
ts.

I think we can do better than this, in our Tcg2ConfigPei clone:

- We should call Tpm2RequestUseTpm() directly, from
"SecurityPkg/Include/Library/Tpm2DeviceLib.h".

- And, Tpm2Startup(), from
"SecurityPkg/Include/Library/Tpm2CommandLib.h", will be called by Tcg2Pei=
.


(5) Finally, there's no need to set "PcdTpmInitializationPolicy" to
anything. I don't see it consumed by any module that we should include
in OVMF. (More on this below.)


(6) Now, I realize Tcg2Pei *apparently* depends on
gEfiPeiReadOnlyVariable2PpiGuid (i.e., read-only variable access in the
PEI phase) as well. That's a bug in the INF file (the [depex] section).
If you grep the Tcg2Pei module source for the GUID, the [depex] section
is the only hit. Can you please submit a separate patch that removes it
from the depex?


> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc | 20 ++++++++++++++++++++
>  OvmfPkg/OvmfPkgX64.fdf |  3 +++
>  2 files changed, 23 insertions(+)

Is there any particular reason to exclude the Ia32 and Ia32X64 builds?

If not, then please modify all three sets of dsc/fdf files identically.

> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 32c57b04e1..b5cbe8430f 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -40,6 +40,7 @@

(7) Please implement the following git settings in your edk2 clone:

https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt-gi=
t-guide-for-edk2-contributors-and-maintainers#contrib-05

(in particular "xfuncname")

and

https://github.com/tianocore/tianocore.github.io/wiki/Laszlo's-unkempt-gi=
t-guide-for-edk2-contributors-and-maintainers#contrib-09

This will help reviewers see what section of the DSC / FDF / INI / DEC
files are modified by a patch hunk.

>    DEFINE SMM_REQUIRE             =3D FALSE
>    DEFINE TLS_ENABLE              =3D FALSE
>    DEFINE MEM_VARSTORE_EMU_ENABLE =3D TRUE
> +  DEFINE TPM2_ENABLE             =3D FALSE
> =20
>    #
>    # Flash size selection. Setting FD_SIZE_IN_KB on the command line di=
rectly to
> @@ -209,6 +210,11 @@
>    OrderedCollectionLib|MdePkg/Library/BaseOrderedCollectionRedBlackTre=
eLib/BaseOrderedCollectionRedBlackTreeLib.inf
>    XenHypercallLib|OvmfPkg/Library/XenHypercallLib/XenHypercallLib.inf
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  Tpm12CommandLib|SecurityPkg/Library/Tpm12CommandLib/Tpm12CommandLib.=
inf
> +  Tpm2CommandLib|SecurityPkg/Library/Tpm2CommandLib/Tpm2CommandLib.inf
> +!endif
> +

(8) For the patch, as posted, resolving Tpm2CommandLib looks unneeded,
because "SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf" doesn't seem to
depend on that lib class.

However, for the OvmfPkg clone of Tcg2ConfigPei that I'm suggesting
here, *only* the Tpm2CommandLib resolution will be necessary.

>  [LibraryClasses.common]
>    BaseCryptLib|CryptoPkg/Library/BaseCryptLib/BaseCryptLib.inf
> =20
> @@ -272,6 +278,10 @@
>    QemuFwCfgS3Lib|OvmfPkg/Library/QemuFwCfgS3Lib/PeiQemuFwCfgS3LibFwCfg=
.inf
>    PcdLib|MdePkg/Library/PeiPcdLib/PeiPcdLib.inf
>    QemuFwCfgLib|OvmfPkg/Library/QemuFwCfgLib/QemuFwCfgPeiLib.inf
> +!if $(TPM2_ENABLE)
> +  Tpm12DeviceLib|SecurityPkg/Library/Tpm12DeviceLibDTpm/Tpm12DeviceLib=
DTpm.inf
> +  Tpm2DeviceLib|SecurityPkg/Library/Tpm2DeviceLibDTpm/Tpm2DeviceLibDTp=
m.inf
> +!endif

(9) Again, only the Tpm2DeviceLib resolution should be necessary (for
our clone).

(10) Furthermore, is there any particular reason you add this resolution
only for PEIMs? Are you going to add different resolutions later, for
different module types?

> =20
>  [LibraryClasses.common.DXE_CORE]
>    HobLib|MdePkg/Library/DxeCoreHobLib/DxeCoreHobLib.inf
> @@ -558,6 +568,12 @@
> =20
>    gEfiSecurityPkgTokenSpaceGuid.PcdOptionRomImageVerificationPolicy|0x=
00
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInstanceGuid|{0xb6, 0xe5, 0x01, =
0x8b, 0x19, 0x4f, 0xe8, 0x46, 0xab, 0x93, 0x1c, 0x53, 0x67, 0x1b, 0x90, 0=
xcc}

(11) This is wrong, IMO. The value you set here is
"gEfiTpmDeviceInstanceTpm12Guid", which I can't explain.

In order for the PCD to behave dynamically, we should indeed provide a
dynamic default. But that default value should be all-bits-zero (put
differently, "gEfiTpmDeviceInstanceNoneGuid"). The actual value (based
on hardware detection) should be set by our Tcg2ConfigPei clone (see
near the top).

> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpm2InitializationPolicy|1
> +  gEfiSecurityPkgTokenSpaceGuid.PcdTpmInitializationPolicy|1
> +!endif

(12) There is no need to set PcdTpmInitializationPolicy, it should not
be used (either set or read) by any module we include in OVMF.

(13) There is also no need to set PcdTpm2InitializationPolicy. While we
*will* include Tcg2Pei, that module only consumes the PCD, so actual
dynamic behavior is not needed. Furthermore, the top-level default in
"SecurityPkg/SecurityPkg.dsc" is already 1, so we can simply inherit
that. It should cause Tcg2Pei to perform a full init on the TPM2 chip.

> +
>  ######################################################################=
##########
>  #
>  # Components Section - list of all EDK II Modules needed by this Platf=
orm.
> @@ -629,6 +645,10 @@
> =20
>    MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
> =20
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
> +!endif
> +

(14) Please move this addition higher up in the DSC file, so that it
lands at the end of:

  #
  # PEI Phase modules
  #

just above

  #
  # DXE Phase modules
  #

>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
> index bb46a409d9..dc35d0a1f7 100644
> --- a/OvmfPkg/OvmfPkgX64.fdf
> +++ b/OvmfPkg/OvmfPkgX64.fdf
> @@ -168,6 +168,9 @@ INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf
>  INF  MdeModulePkg/Universal/FaultTolerantWritePei/FaultTolerantWritePe=
i.inf
>  INF  MdeModulePkg/Universal/Variable/Pei/VariablePei.inf
>  !endif
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
> +!endif
> =20
>  ######################################################################=
##########
> =20
>=20

(15) This seems correct, yes; with the remark that once you drop the
dependence on PEI phase variable access, the addition should follow

INF  UefiCpuPkg/CpuMpPei/CpuMpPei.inf

directly.

Thanks!
Laszlo
