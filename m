Received: from eggs.gnu.org ([2001:4830:134:3::10]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJG5k-0002nY-GU
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:25:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJG5g-0007Dw-G5
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:25:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJG5g-0007Dj-Aj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 06:24:56 -0400
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<20180515123007.10164-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1c61d02b-bd26-3eb7-239d-0f1458a649a3@redhat.com>
Date: Thu, 17 May 2018 12:24:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180515123007.10164-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 4/4] ovmf: process TPM PPI request
 in AfterConsole()
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
> Call Tcg2PhysicalPresenceLibProcessRequest() to process pending PPI
> requests from PlatformBootManagerAfterConsole().
>=20
> Laszlo understanding of edk2 is that the PPI operation processing was
> meant to occur *entirely* before End-Of-Dxe, so that 3rd party UEFI
> drivers couldn't interfere with PPI opcode processing *at all*.
>=20
> He suggested that we should *not* call
> Tcg2PhysicalPresenceLibProcessRequest() from BeforeConsole(). Because,
> an "auth" console, i.e. one that does not depend on a 3rd party
> driver, is *in general* impossible to guarantee. Instead we could opt
> to trust 3rd party drivers, and use the "normal" console(s) in
> AfterConsole(), in order to let the user confirm the PPI requests. It
> will depend on the user to enable Secure Boot, so that the
> trustworthiness of those 3rd party drivers is ensured. If an attacker
> roots the guest OS from within, queues some TPM2 PPI requests, and
> also modifies drivers on the EFI system partition and/or in GPU option
> ROMs (?), then those drivers will not load after guest reboot, and
> thus the dependent console(s) won't be used for confirming the PPI
> requests.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c      | 8 ++++++++
>  .../PlatformBootManagerLib/PlatformBootManagerLib.inf     | 2 ++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c b/Ovm=
fPkg/Library/PlatformBootManagerLib/BdsPlatform.c
> index 004b753f4d26..8b1beaa3e207 100644
> --- a/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c
> +++ b/OvmfPkg/Library/PlatformBootManagerLib/BdsPlatform.c
> @@ -16,6 +16,7 @@
>  #include <Guid/XenInfo.h>
>  #include <Guid/RootBridgesConnectedEventGroup.h>
>  #include <Protocol/FirmwareVolume2.h>
> +#include <Library/Tcg2PhysicalPresenceLib.h>
> =20
> =20
>  //
> @@ -1410,6 +1411,13 @@ PlatformBootManagerAfterConsole (
>    //
>    PciAcpiInitialization ();
> =20
> +
> +  //
> +  // Process TPM PPI request
> +  //
> +  Tcg2PhysicalPresenceLibProcessRequest (NULL);
> +
> +

Please just keep one empty line before and after the new code. With that
cleanup, for this patch:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

This series is a very nice work IMO, thank you both Stefan and
Marc-Andr=C3=A9. I hope v2 can be merged!

Thanks!
Laszlo

>    //
>    // Process QEMU's -kernel command line option
>    //
> diff --git a/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManager=
Lib.inf b/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.i=
nf
> index 27789b7377bc..4b72c44bcf0a 100644
> --- a/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
> +++ b/OvmfPkg/Library/PlatformBootManagerLib/PlatformBootManagerLib.inf
> @@ -38,6 +38,7 @@ [Packages]
>    IntelFrameworkModulePkg/IntelFrameworkModulePkg.dec
>    SourceLevelDebugPkg/SourceLevelDebugPkg.dec
>    OvmfPkg/OvmfPkg.dec
> +  SecurityPkg/SecurityPkg.dec
> =20
>  [LibraryClasses]
>    BaseLib
> @@ -56,6 +57,7 @@ [LibraryClasses]
>    LoadLinuxLib
>    QemuBootOrderLib
>    UefiLib
> +  Tcg2PhysicalPresenceLib
> =20
>  [Pcd]
>    gUefiOvmfPkgTokenSpaceGuid.PcdEmuVariableEvent
>=20
