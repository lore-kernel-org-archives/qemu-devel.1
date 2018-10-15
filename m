Received: from eggs.gnu.org ([2001:4830:134:3::10]:44513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBwT1-0001kc-1R
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBwSx-00013M-25
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:35:02 -0400
Received: from mail-yb1-f169.google.com ([209.85.219.169]:44360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBwSw-000137-Tg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 02:34:58 -0400
Received: by mail-yb1-f169.google.com with SMTP id x5-v6so7072773ybl.11
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 23:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181015055333.32030-1-kraxel@redhat.com>
In-Reply-To: <20181015055333.32030-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Oct 2018 08:20:59 +0200
Message-ID: <CAAdtpL7LZs4kM1p3T8DP-Q3eVKE4UpSS9eNft8RjWE17a0uCfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] edid: fix alignment issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Le lun. 15 oct. 2018 07:53, Gerd Hoffmann <kraxel@redhat.com> a =C3=A9crit =
:

> Use stl_le_p() & friends instead of casts.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/edid-generate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
> index 37e60fe42a..bdf5e1d4d4 100644
> --- a/hw/display/edid-generate.c
> +++ b/hw/display/edid-generate.c
> @@ -223,7 +223,7 @@ static void edid_desc_timing(uint8_t *desc,
>
>      uint32_t clock  =3D 75 * (xres + xblank) * (yres + yblank);
>
> -    *(uint32_t *)(desc) =3D cpu_to_le32(clock / 10000);
> +    stl_le_p(desc, clock / 10000);
>
>      desc[2] =3D xres   & 0xff;
>      desc[3] =3D xblank & 0xff;
> @@ -342,9 +342,9 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
>                            (((info->vendor[2] - '@') & 0x1f) <<  0));
>      uint16_t model_nr =3D 0x1234;
>      uint32_t serial_nr =3D info->serial ? atoi(info->serial) : 0;
> -    *(uint16_t *)(edid +  8) =3D cpu_to_be16(vendor_id);
> -    *(uint16_t *)(edid + 10) =3D cpu_to_le16(model_nr);
> -    *(uint32_t *)(edid + 12) =3D cpu_to_le32(serial_nr);
> +    stw_be_p(edid +  8, vendor_id);
> +    stw_le_p(edid + 10, model_nr);
> +    stl_le_p(edid + 12, serial_nr);
>
>      /* manufacture week and year */
>      edid[16] =3D 42;
> --
> 2.9.3
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>
