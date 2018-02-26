Received: from eggs.gnu.org ([2001:4830:134:3::10]:60327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqFYW-00084a-Fx
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eqFYR-0002pU-Ld
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:58:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eqFYR-0002pI-Gp
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:58:43 -0500
References: <20180223132311.26555-1-marcandre.lureau@redhat.com>
	<20180223132311.26555-7-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4dc45713-b15d-0db5-d72e-ccb007cd2487@redhat.com>
Date: Mon, 26 Feb 2018 10:58:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180223132311.26555-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 6/7] ovmf: link with Tcg2ConfigDxe
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
> The module allows to tweak and interact with the TPM. Note that many
> actions are broken due to implementation of qemu TPM (providing it's
> own ACPI table), and the lack of PPI implementation.
>=20
> CC: Laszlo Ersek <lersek@redhat.com>
> CC: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgX64.dsc | 2 ++
>  OvmfPkg/OvmfPkgX64.fdf | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/OvmfPkg/OvmfPkgX64.dsc b/OvmfPkg/OvmfPkgX64.dsc
> index 9bd0709f98..2281bd5ff8 100644
> --- a/OvmfPkg/OvmfPkgX64.dsc
> +++ b/OvmfPkg/OvmfPkgX64.dsc
> @@ -669,6 +669,8 @@
>        NULL|SecurityPkg/Library/HashInstanceLibSha1/HashInstanceLibSha1=
.inf
>        NULL|SecurityPkg/Library/HashInstanceLibSha256/HashInstanceLibSh=
a256.inf
>    }
> +
> +  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>  !endif
> =20
>  !if $(SECURE_BOOT_ENABLE) =3D=3D TRUE
> diff --git a/OvmfPkg/OvmfPkgX64.fdf b/OvmfPkg/OvmfPkgX64.fdf
> index b8dd7ecae4..985404850f 100644
> --- a/OvmfPkg/OvmfPkgX64.fdf
> +++ b/OvmfPkg/OvmfPkgX64.fdf
> @@ -399,6 +399,7 @@ INF  MdeModulePkg/Universal/Variable/RuntimeDxe/Var=
iableRuntimeDxe.inf
> =20
>  !if $(TPM2_ENABLE) =3D=3D TRUE
>  INF  SecurityPkg/Tcg/Tcg2Dxe/Tcg2Dxe.inf
> +INF  SecurityPkg/Tcg/Tcg2Config/Tcg2ConfigDxe.inf
>  !endif
> =20
>  ######################################################################=
##########
>=20

Please drop this patch.

In my earlier investigation I wrote, Tcg2ConfigDxe "[p]rovides a Setup
TUI interface to configure the TPM. IIUC, it can also save the
configured TPM type for subsequent boots (see Tcg2ConfigPei.inf above)".

The INF file itself says "This module is only for reference only, each
platform should have its own setup page."

And Jiewen wrote earlier, "Tcg2ConfigPei/Dxe are platform sample driver.
A platform may have its own version based upon platform requirement. For
example, if a platform supports fTPM, it may use another Tcg2Config drive=
r."

Given that OVMF lacks PEI-phase variable access, and that I consequently
suggested cloning, and seriously trimming, Tcg2ConfigPei, it makes no
sense to include an HII dialog that sets a variable for PEI phase
consumption. Also, as you say, many of the exposed operations are broken
due to lack of PPI support. So let's just postpone the inclusion of this
driver, for now.

Thanks
Laszlo
