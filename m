Received: from eggs.gnu.org ([2001:4830:134:3::10]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwiL-000514-2N
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwiJ-00073N-TJ
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:25:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
	<1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <12647bf7-eb9f-889a-76e0-32fb1f799160@amsat.org>
Date: Tue, 9 Jan 2018 13:25:11 -0300
MIME-Version: 1.0
In-Reply-To: <1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="KFWgVohLgrfxgZzrfyDrDiLz8GFgk66YX"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/4] hw/sd/ssi-sd: Reset SD card
 on controller reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KFWgVohLgrfxgZzrfyDrDiLz8GFgk66YX
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org
Message-ID: <12647bf7-eb9f-889a-76e0-32fb1f799160@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 3/4] hw/sd/ssi-sd: Reset SD card on controller
 reset
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
 <1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-4-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 01/09/2018 11:01 AM, Peter Maydell wrote:
> Since ssi-sd is still using the legacy SD card API, the SD
> card created by sd_init() is not plugged into any bus. This
> means that the controller has to reset it manually.
>=20
> Failing to do this mostly didn't affect the guest since the
> guest typically does a programmed SD card reset as part of
> its SD controller driver initialization, but meant that
> migration failed because it's only in sd_reset() that we
> set up the wpgrps_size field.
>=20
> In the case of sd-ssi, we have to implement an entire
> reset function since there wasn't one previously, and
> that requires a QOM cast macro that got omitted when this
> device was QOMified.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/sd/ssi-sd.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 24001dc..30d2a87 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -50,6 +50,9 @@ typedef struct {
>      SDState *sd;
>  } ssi_sd_state;
> =20
> +#define TYPE_SSI_SD "ssi-sd"
> +#define SSI_SD(obj) OBJECT_CHECK(ssi_sd_state, (obj), TYPE_SSI_SD)
> +
>  /* State word bits.  */
>  #define SSI_SDR_LOCKED          0x0001
>  #define SSI_SDR_WP_ERASE        0x0002
> @@ -251,6 +254,24 @@ static void ssi_sd_realize(SSISlave *d, Error **er=
rp)
>      }
>  }
> =20
> +static void ssi_sd_reset(DeviceState *dev)
> +{
> +    ssi_sd_state *s =3D SSI_SD(dev);
> +
> +    s->mode =3D SSI_SD_CMD;

> +    s->cmd =3D 0;

Not necessary/useful since s->mode =3D SSI_SD_CMD.

> +    memset(s->cmdarg, 0, sizeof(s->cmdarg));
> +    memset(s->response, 0, sizeof(s->response));

This might be cleaner to move it in ssi_sd_transfer() case SSI_SD_CMD.

> +    s->arglen =3D 0;

Not necessary/useful since s->mode =3D SSI_SD_CMD.

> +    s->response_pos =3D 0;

This might be safer to move this in ssi_sd_transfer() case SSI_SD_CMD.

> +    s->stopping =3D 0;

This might be cleaner to move it in ssi_sd_transfer() entry "Special
case else s->stopping =3D 0;"

Since none of this comments are important, I can add a patch in my
series previous to convert to SDBus.

> +
> +    /* Since we're still using the legacy SD API the card is not plugg=
ed
> +     * into any bus, and we must reset it manually.
> +     */
> +    device_reset(DEVICE(s->sd));
> +}
> +
>  static void ssi_sd_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -260,10 +281,11 @@ static void ssi_sd_class_init(ObjectClass *klass,=
 void *data)
>      k->transfer =3D ssi_sd_transfer;
>      k->cs_polarity =3D SSI_CS_LOW;
>      dc->vmsd =3D &vmstate_ssi_sd;
> +    dc->reset =3D ssi_sd_reset;
>  }
> =20
>  static const TypeInfo ssi_sd_info =3D {
> -    .name          =3D "ssi-sd",
> +    .name          =3D TYPE_SSI_SD,
>      .parent        =3D TYPE_SSI_SLAVE,
>      .instance_size =3D sizeof(ssi_sd_state),
>      .class_init    =3D ssi_sd_class_init,
>=20


--KFWgVohLgrfxgZzrfyDrDiLz8GFgk66YX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpU7OcACgkQ4+MsLN6t
wN4V7w//c1J0t9Xeb5ybiDgpDUgJD5aqcoziknX35Xs/eBXi7JI7+2p8bLaMtTRZ
CJ5L9SpC985ADctDLAw5cBLDZilqAvokh57Hd9/n5+2/WrrUKcfWPO8dkojQdGWy
xVgkzh1oZ4YaNolyMUHOTWxS3JIYqFXrY92Nkaqu5ZL3ppYZYMeakhVYu47Ds3gn
kH3bSoBxLfjrue8GWP7hah4PhgiZuCDKMU8OnyKfd1et7FW6RYqEZy3NILKYtChl
mFASG8GUzn5UV7l69JNs04UiwQbTtwboxPxcbFKY4dZDx8vEr7LBigp/abm6wA47
dnnk+DnbUA+te0tsyPq6D9I2fHkXr9RQ/fYwVB78lqP6Al5Lobj/PTPZgNyhDQra
h/VQyBZo7OInU+YRi0HBPB3EtiIMXBfb1c4MSI8q4C87QfhQDn5Ncacywg61IBR9
IczF2hs9y2NE3J4sEOJJ87P8Ci2hNxPqJom65SSmXin3lRXhTByXShLHEhIAu/5D
aTgS9vRFN+khYQk7RgdccbEf3bkxnHCJ1o5AMG11UNHxS1UXxvIW8B5u5x9ttqAk
/tualoATIKRWspCQJka86ZpLwqW/imFRC/L7MgFcsPtcvcMtRCo7cOb02C5kSGAa
H9cO9tJEnjTnBj7XDfa0huiHYs9DV8xwiWTKcAZshkbGBFlOlhw=
=oAsI
-----END PGP SIGNATURE-----

--KFWgVohLgrfxgZzrfyDrDiLz8GFgk66YX--
