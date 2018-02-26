Received: from eggs.gnu.org ([2001:4830:134:3::10]:39469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqG23-0000og-La
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqG22-0003Sw-HJ
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:29:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eqG22-0003S3-B8
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 05:29:18 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-8-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f4ea4878-658c-6047-0901-6edc16827ab7@redhat.com>
Date: Mon, 26 Feb 2018 11:29:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] ovmf: add DxeTpm2MeasureBootLib
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

On 02/23/18 14:23, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The library registers a security management handler, to measure images
> that are not measure in PEI phase.
>
> This seems to work for example with the qemu PXE rom:
>
> Loading driver at 0x0003E6C2000 EntryPoint=3D0x0003E6C9076 8086100e.efi
>
> And the following binary_bios_measurements log entry seems to be
> added:
>
> PCR: 2	type: EV_EFI_BOOT_SERVICES_DRIVER     	size: 0x4e	digest: 70a224=
75e9f18806d2ed9193b48d80d26779d9a4
>
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 2281bd5ff8..92ed9f3b0c 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -677,7 +677,10 @@
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> -	}
> +!if $(TPM2_ENABLE) =3D=3D TRUE
> +      NULL|SecurityPkg/Library/DxeTpm2MeasureBootLib/DxeTpm2MeasureBoo=
tLib.inf
> +!endif
> +  }
>  !else
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
>  !endif
>

This looks OK to me.

First, can you please clean up the SecurityStubDxe stanza as follows (as
a separate patch):

> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 96fc7b82e708..f4288b625cba 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -634,14 +634,12 @@ [Components]
>
>    MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
>
> -!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>    MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf {
>      <LibraryClasses>
> +!if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
>        NULL|SecurityPkg/Library/DxeImageVerificationLib/DxeImageVerific=
ationLib.inf
> -       }
> -!else
> -  MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
>  !endif
> +  }
>
>    MdeModulePkg/Universal/EbcDxe/EbcDxe.inf
>    PcAtChipsetPkg/8259InterruptControllerDxe/8259.inf

The idea is that "SecurityStubDxe.inf" should be included
unconditionally; only its plug-in libs should be conditional on various
build flags. While the current (pre-patch) code does that -- in effect
-- for SECURE_BOOT_ENABLE already, your patch (as-is) can only add
TPM2_ENABLE *within* SECURE_BOOT_ENABLE.

I don't think that's for the best -- first we should make
DxeImageVerificationLib the *only* bit that's conditional on
SECURE_BOOT_ENABLE, and then we can add DxeTpm2MeasureBootLib
independently. (If neither build option is specified, we'll have a
<LibraryClasses> list that's empty, but that's perfectly fine.)

Thanks!
Laszlo
