Received: from eggs.gnu.org ([209.51.188.92]:52909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glTtl-0005Aw-5k
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glTtk-0005bC-8H
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33686)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glTtd-0005Xo-QY
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 02:21:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56E89C0467DF
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 07:21:24 +0000 (UTC)
Date: Mon, 21 Jan 2019 08:21:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190121072121.rid3fmx3i2a7s5gu@sirius.home.kraxel.org>
References: <20190118223152.24183-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190118223152.24183-1-lersek@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] fw_cfg: fix the life cycle and the name of
 "qemu_extra_params_fw"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Fri, Jan 18, 2019 at 11:31:52PM +0100, Laszlo Ersek wrote:
> Commit 19bcc4bc3213 ("fw_cfg: Make qemu_extra_params_fw locally",
> 2019-01-04) changed the storage duration of the "qemu_extra_params_fw"
> array from static to automatic. This broke the interface contract on th=
e
> fw_cfg_add_file() function, which is documented as follows, in
> "include/hw/nvram/fw_cfg.h":
>=20
> > [...] The data referenced by the starting pointer is only linked, NOT
> > copied, into the data structure of the fw_cfg device. [...]
>=20
> As a result, when guest firmware fetches the "etc/boot-menu-wait" fw_cf=
g
> file, it now sees garbage. Fix the regression by changing the storage
> duration to allocated. (The call is reached at most once, on the realiz=
e
> path of the board-specific fw_cfg sysbus device.)
>=20
> While at it, clean up the name and the assignment of the object as well=
.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

>=20
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Fixes: 19bcc4bc3213e78c303ad480a7a578f62258252d
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 53e8e010a8b7..7fdf04adc97f 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -118,7 +118,6 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>  {
>      const char *boot_splash_filename =3D NULL;
>      const char *boot_splash_time =3D NULL;
> -    uint8_t qemu_extra_params_fw[2];
>      char *filename, *file_data;
>      gsize file_size;
>      int file_type;
> @@ -132,6 +131,8 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>      /* insert splash time if user configurated */
>      if (boot_splash_time) {
>          int64_t bst_val =3D qemu_opt_get_number(opts, "splash-time", -=
1);
> +        uint16_t bst_le16;
> +
>          /* validate the input */
>          if (bst_val < 0 || bst_val > 0xffff) {
>              error_report("splash-time is invalid,"
> @@ -139,9 +140,9 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>              exit(1);
>          }
>          /* use little endian format */
> -        qemu_extra_params_fw[0] =3D (uint8_t)(bst_val & 0xff);
> -        qemu_extra_params_fw[1] =3D (uint8_t)((bst_val >> 8) & 0xff);
> -        fw_cfg_add_file(s, "etc/boot-menu-wait", qemu_extra_params_fw,=
 2);
> +        bst_le16 =3D cpu_to_le16(bst_val);
> +        fw_cfg_add_file(s, "etc/boot-menu-wait",
> +                        g_memdup(&bst_le16, sizeof bst_le16), sizeof b=
st_le16);
>      }
> =20
>      /* insert splash file if user configurated */
> --=20
> 2.19.1.3.g30247aa5d201
>=20
