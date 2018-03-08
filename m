Received: from eggs.gnu.org ([2001:4830:134:3::10]:45997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu1cZ-0000SL-Ve
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eu1cW-0003dz-U7
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:54:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50552 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eu1cW-0003dW-NP
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:54:32 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-9-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a62073a3-cc41-ca4b-4822-e28ebcf5204b@redhat.com>
Date: Thu, 8 Mar 2018 20:54:11 +0100
MIME-Version: 1.0
In-Reply-To: <20180307155746.18526-9-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 8/8] ovmf: add DxeTpm2MeasureBootLib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org, jiewen.yao@intel.com
Cc: pjones@redhat.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

(Jiewen, below I have a question for you as well; please help with that.)

On 03/07/18 16:57, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The library registers a security management handler, to measure images
> that are not measure in PEI phase.
>=20
> This seems to work for example with the qemu PXE rom:
>=20
> Loading driver at 0x0003E6C2000 EntryPoint=3D0x0003E6C9076 8086100e.efi
>=20
> And the following binary_bios_measurements log entry seems to be
> added:
>=20
> PCR: 2	type: EV_EFI_BOOT_SERVICES_DRIVER     	size: 0x4e	digest: 70a224=
75e9f18806d2ed9193b48d80d26779d9a4
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 7753852144fb..9db1712e3623 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -662,6 +662,9 @@ [Components]
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

(1) Marc-Andr=C3=A9, please change the subject line to:

OvmfPkg: plug DxeTpm2MeasureBootLib into SecurityStubDxe


(2) I have a question for Jiewen:

DxeTpm2MeasureBootLib consumes the TCG2 protocol, but it does not depend
on it with a DEPEX. Instead, DxeTpm2MeasureBootHandler() tries to locate
the protocol on every invocation.

This means that SecurityStubDxe may produce the Security and Security2
Architectural Protocols before measurements into the TPM2 device are
possible. Therefore, UEFI_DRIVER modules (which depend on all of the
Arch protocols) may be started before they can be measured into the TPM.

Now, this is likely no problem for UEFI_DRIVER modules that are built
into the firmware volume(s), because those are measured by Tcg2Pei
anyway. However, it would be a problem for UEFI_DRIVER modules / apps
that come from external media (disk, network, PCI oprom, etc).

However, such are loaded only in the BDS phase, and BDS is only entered
after all of the DXE drivers are dispatched from the firmware volumes.
In other words, the ordering between Tcg2Dxe and external UEFI_DRIVER /
UEFI_APPLICATION modules is ensured that Tcg2Dxe will be dispatched in
the DXE phase, while the latter will only be loaded in BDS.

Is this intentional? Is my understanding correct?


(3) If that's the case, then Marc-Andr=C3=A9, please add the following to=
 the
commit message:

--------
Hooking DxeTpm2MeasureBootLib into SecurityStubDxe ensures that the
Security and Security2 Arch protocols will entail, by the time of
entering the BDS phase, the measuring of UEFI binaries into the TPM.
Thus, external UEFI_DRIVER and UEFI_APPLICATION modules (which are
loaded in the BDS phase, from disk, network, PCI oprom, etc) will be
measured.

Drivers dispatched in the DXE phase before Tcg2Dxe will not be measured
individually; however such drivers come from the firmware volume(s), and
those are measured in the PEI phase by Tcg2Pei.
--------

Thanks!
Laszlo
