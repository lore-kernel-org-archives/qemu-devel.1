Received: from eggs.gnu.org ([2001:4830:134:3::10]:41781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euLF4-00039f-CJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:51:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euLF0-0004YB-EJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:51:38 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euLF0-0004Y2-8M
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:51:34 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
	<20180309130918.734-8-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4f6e9d19-0f11-4132-c9a2-7ad96597e35d@redhat.com>
Date: Fri, 9 Mar 2018 17:51:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 7/7] OvmfPkg: plug DxeTpm2MeasureBootLib
 into SecurityStubDxe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/09/18 14:09, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The library registers a security management handler, to measure images
> that are not measure in PEI phase. For example with the qemu PXE rom:
>=20
> Loading driver at 0x0003E6C2000 EntryPoint=3D0x0003E6C9076 8086100e.efi
>=20
> And the following binary_bios_measurements log entry seems to be
> added:
>=20
> PCR: 2	type: EV_EFI_BOOT_SERVICES_DRIVER     	size: 0x4e	digest: 70a224=
75e9f18806d2ed9193b48d80d26779d9a4
>=20
> The following order of operations ensures that 3rd party UEFI modules,
> such as PCI option ROMs and other modules possibly loaded from outside
> of firmware volumes, are measured into the TPM:
>=20
> (1) Tcg2Dxe is included in DXEFV, therefore it produces the TCG2
>     protocol sometime in the DXE phase (assuming a TPM2 chip is present=
,
>     reported via PcdTpmInstanceGuid).
>=20
> (2) The DXE core finds that no more drivers are left to dispatch from
>     DXEFV, and we enter the BDS phase.
>=20
> (3) OVMF's PlatformBootManagerLib connects all PCI root bridges
>     non-recursively, producing PciIo instances and discovering PCI
>     oproms.
>=20
> (4) The dispatching of images that don't originate from FVs is deferred
>     at this point, by
>     "MdeModulePkg/Universal/SecurityStubDxe/Defer3rdPartyImageLoad.c".
>=20
> (5) OVMF's PlatformBootManagerLib signals EndOfDxe.
>=20
> (6) OVMF's PlatformBootManagerLib calls
>     EfiBootManagerDispatchDeferredImages() -- the images deferred in
>     step (4) are now dispatched.
>=20
> (7) Image dispatch invokes the Security / Security2 Arch protocols
>     (produced by SecurityStubDxe). In this patch, we hook
>     DxeTpm2MeasureBootLib into SecurityStubDxe, therefore image dispatc=
h
>     will try to locate the TCG2 protocol, and measure the image into th=
e
>     TPM2 chip with the protocol. Because of step (1), the TCG2 protocol
>     will always be found and used (assuming a TPM2 chip is present).
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgIa32.dsc    | 3 +++
>  OvmfPkg/OvmfPkgIa32X64.dsc | 3 +++
>  OvmfPkg/OvmfPkgX64.dsc     | 3 +++
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/OvmfPkg/OvmfPkgIa32.dsc b/OvmfPkg/OvmfPkgIa32.dsc
> index f80fb50d4a38..92c8c560a067 100644
> --- a/OvmfPkg/OvmfPkgIa32.dsc
> +++ b/OvmfPkg/OvmfPkgIa32.dsc
> @@ -644,6 +644,9 @@ [Components]
>      <LibraryClasses>
>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> +!endif
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBoo=
tLib.inf
>  !endif
>    }
> =20
> diff --git a/OvmfPkg/OvmfPkgIa32X64.dsc b/OvmfPkg/OvmfPkgIa32X64.dsc
> index bc48b5b63c7a..6ecaa795b288 100644
> --- a/OvmfPkg/OvmfPkgIa32X64.dsc
> +++ b/OvmfPkg/OvmfPkgIa32X64.dsc
> @@ -653,6 +653,9 @@ [Components.X64]
>      <LibraryClasses>
>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> +!endif
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBoo=
tLib.inf
>  !endif
>    }
> =20
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index e89de093d6a2..c98a3657c6f6 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -651,6 +651,9 @@ [Components]
>      <LibraryClasses>
>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> +!endif
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBoo=
tLib.inf
>  !endif
>    }
> =20
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
