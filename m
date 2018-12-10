Received: from eggs.gnu.org ([2001:4830:134:3::10]:51374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWO21-0000KG-Jw
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gWO15-0002rw-Eo
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 11:02:44 -0500
References: <20181207170400.5129-1-philmd@redhat.com>
	<20181207170400.5129-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b7a09e97-093e-6e27-4c7f-cc5244d63726@redhat.com>
Date: Mon, 10 Dec 2018 17:02:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181207170400.5129-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/arm/virt: Remove null-check in
 virt_build_smbios()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Drew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 12/07/18 18:03, Philippe Mathieu-Daud=C3=A9 wrote:
> Since af1f60a4022, the fw_cfg field is always created in machvirt_init(=
).
> There is no need to null check it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/arm/virt.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f69e7eb399..36303ed59c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1279,10 +1279,6 @@ static void virt_build_smbios(VirtMachineState *=
vms)
>      size_t smbios_tables_len, smbios_anchor_len;
>      const char *product =3D "QEMU Virtual Machine";
> =20
> -    if (!vms->fw_cfg) {
> -        return;
> -    }
> -
>      if (kvm_enabled()) {
>          product =3D "KVM Virtual Machine";
>      }
>=20

This patch looks correct to me; however, the fact that fw_cfg is always
present on the virt board does not seem related to commit af1f60a4022
af1f60a40226 ("hw/arm/virt: remove VirtGuestInfo", 2017-01-09). Said
commit only flattened the contents of VirtGuestInfo into
VirtMachineState; the conditions under which fw_cfg would be created
were not changed.

As far as I can see (from a number of git-blame / git-show commands),
fw_cfg was added unconditionally to the virt board in commit
578f3c7b0835 ("arm: add fw_cfg to "virt" board", 2014-12-22). And the
check that you are now (correctly) removing has always been superfluous
-- it was superfluous already when it was first added in commit
c30e15658b1b ("smbios: implement smbios support for mach-virt", 2015-09-0=
7).

As far as I can tell, anyway.

If you agree, I suggest mentioning commit c30e15658b1b in the commit
message, rather than commit af1f60a4022.

With such an update:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks
Laszlo
