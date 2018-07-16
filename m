Received: from eggs.gnu.org ([2001:4830:134:3::10]:34385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ff0MV-00059Y-9H
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ff0MU-0002pu-4Z
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:11 -0400
Received: from ozlabs.org ([203.11.71.1]:39093)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ff0MS-0002ny-L2
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 06:04:10 -0400
Date: Mon, 16 Jul 2018 19:44:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716094423.GM2599@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-14-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="P9KQiUGMzYCFwWCN"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-14-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 13/14] timer: ds-rtc model ds1375
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--P9KQiUGMzYCFwWCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:20:00AM -0700, Michael Davidsaver wrote:
> differences from ds1338
>=20
> * Has alarms (not modeled)
> * different control register (not modeled)
> * smaller address space (0x20 vs. 0x40)
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/timer/ds-rtc.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 9abac38628..3a8ad1a00f 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -1,8 +1,9 @@
>  /*
> - * MAXIM DS1338 I2C RTC+NVRAM
> + * MAXIM/Dallas DS1338 and DS1375 I2C RTC+NVRAM
>   *
> + * Copyright (c) 2018 Michael Davidsaver
>   * Copyright (c) 2009 CodeSourcery.
> - * Written by Paul Brook
> + * Written by Paul Brook, Michael Davidsaver
>   *
>   * This code is licensed under the GNU GPL v2.
>   *
> @@ -41,6 +42,7 @@
>  #define R_YEAR  (0x6)
> =20
>  #define R_DS1338_CTRL (0x7)
> +#define R_DS1375_CTRL (0xe)
> =20
>  /* use 12 hour mode when set */
>  FIELD(HOUR, SET12, 6, 1)
> @@ -300,10 +302,34 @@ static const TypeInfo ds1338_info =3D {
>      .class_init    =3D ds1338_class_init,
>  };
> =20
> +static void ds1375_control_write(DSRTCState *s, uint8_t data)
> +{
> +    /* just store it, we don't model any features */
> +    s->nvram[R_DS1375_CTRL] =3D data;
> +}
> +
> +static void ds1375_class_init(ObjectClass *klass, void *data)
> +{
> +    DSRTCClass *k =3D DSRTC_CLASS(klass);
> +
> +    k->has_century =3D true;
> +    k->addr_size =3D 0x20;
> +    k->ctrl_offset =3D R_DS1375_CTRL;
> +    k->ctrl_write =3D ds1375_control_write;
> +}
> +
> +static const TypeInfo ds1375_info =3D {
> +    .name          =3D "ds1375",
> +    .parent        =3D TYPE_DSRTC,
> +    .class_size    =3D sizeof(DSRTCClass),
> +    .class_init    =3D ds1375_class_init,
> +};
> +
>  static void dsrtc_register_types(void)
>  {
>      type_register_static(&dsrtc_info);
>      type_register_static(&ds1338_info);
> +    type_register_static(&ds1375_info);
>  }
> =20
>  type_init(dsrtc_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--P9KQiUGMzYCFwWCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMaPcACgkQbDjKyiDZ
s5I4VQ//XieMg82DXfyIUfKMy5uetewyC/oRKZVJkBUECBe5G+ezmbPtDlOsa6yY
OhWLbPsaqDQum6eYgQwJcfDEmInQZGcX6pIFRklGwxF26qleZyNOoRJtoymI6/GG
ifuqwifjR+Al7m3hZc/XvwAdrhH5A70q54chPjzZAzYuBvTa6KmaUqjStlMK1B3H
/NsEAiR6+4FGLc64LaWcmP/CIvCVEZ8y8M5ivzwq4x2ZQRtS+4bhZGKCVh4zQFlE
9MGbi8lgO3nGnEWD02eRP/uTg9+J8nxjFZzhUpBWRqMY5S2P1uaE6vVV+HG/HFJ+
aD++kgplroi6mqVk77mzN4Pg/vsZoMa/J7ppsBv5lTJfRSliIb8acXLPxCEjN+9R
h5mtLfF1U5KxLMFR23TI8z9FzDoum418c7Kl1Tb9lyLu62TW8Ijy56v2QOYccVmV
7KtKrLTv+ZKTzVhOzxJgBU9DYt+vFDEmrjfQoEReprgL1VzGsvDhPOPs6ugm+9B9
hE2qDWYHzuOOMhAcUQSHtRyFHqu5FuniEtgp2KuhVHA23BZE4qcVAWbnCOyjpDID
Rob6eFJ0WGoE7MDITQPb3AUQOrJV6750resmVOvF+FFRN8z4QbJ6kmgBt1B46PWG
ny44hWZTdxguaFyPKIJcKT4LLPFzDRPcqbsUlCvbWkJvOKyEdB0=
=DuP5
-----END PGP SIGNATURE-----

--P9KQiUGMzYCFwWCN--
