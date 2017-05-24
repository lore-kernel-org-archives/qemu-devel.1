Received: from eggs.gnu.org ([2001:4830:134:3::10]:60749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dDPGq-0001aS-RG
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1dDPGp-0000Ky-Vm
	for qemu-devel@nongnu.org; Wed, 24 May 2017 01:55:44 -0400
Message-ID: <1495605328.7794.3.camel@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 24 May 2017 15:55:28 +1000
In-Reply-To: <041887dc-c613-2bf3-e927-0381a7221b54@amsat.org>
References: <20170520002653.20213-1-andrew@aj.id.au>
	<20170520002653.20213-2-andrew@aj.id.au>
	<59538b3b-2936-cdc7-f582-9d473c72ce09@amsat.org>
	<1495412633.23485.3.camel@aj.id.au>
	<660ee5968bc04bc7a318835d53f331ba@TWMBX01.aspeed.com>
	<1495430041.22806.1.camel@aj.id.au>
	<041887dc-c613-2bf3-e927-0381a7221b54@amsat.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-hMJJ43Iy3/D2foi/+KiE"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] hw/adc: Add basic Aspeed
 ADC model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, Alistair Francis <alistair@alistair23.me>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Joel Stanley <joel@jms.id.au>


--=-hMJJ43Iy3/D2foi/+KiE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2017-05-24 at 02:15 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Andrew,
>=20
> On 05/22/2017 02:14 AM, Andrew Jeffery wrote:
> > On Mon, 2017-05-22 at 03:15 +0000, Ryan Chen wrote:
> > > In ASPEED SoC chip, all register access have following rule.
> > > Most of controller write access is only support 32bit access.
> > > Read is support 8bits/16bits/32bits.
>=20
> This makes sens thinking about how a DMA controller can take advantage=C2=
=A0
> of the ADC.
>=20
> >=20
> > Thanks for clearing that up Ryan.
> >=20
> > Phil: I'll rework the model so the reads are 16-bits.
>=20
> This shouldn't be necessary, QEMU is supposed to supports different=C2=A0
> access size for different implemented size, so you can declare your=C2=A0
> implementation as 32-bit and valid accesses from 8 to 32:
>=20
> =C2=A0 static const MemoryRegionOps aspeed_adc_ops =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.read =3D aspeed_adc_read,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.write =3D aspeed_adc_write,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.endianness =3D DEVICE_LITTLE_ENDIAN,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valid.min_access_size =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valid.max_access_size =3D 4,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.valid.unaligned =3D false,
> +=C2=A0=C2=A0=C2=A0=C2=A0.impl.min_access_size =3D 4,
> +=C2=A0=C2=A0=C2=A0=C2=A0.impl.max_access_size =3D 4,
> =C2=A0 };
>=20
> This way an I/O access from the CPU or a DMA could use 8/16-bit while=C2=
=A0
> you keep a 32-bit implementation. The adjustment is done by=C2=A0
> access_with_adjusted_size() from memory.c.
>=20
> Afaik there is, however, no distinction between read/write different=C2=
=A0
> access size in current QEMU MemoryRegionOps model.

Yep, I realised all of the above when I went to implement it. Thanks
for pointing it out though!

Andrew
--=-hMJJ43Iy3/D2foi/+KiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZJSBQAAoJEJ0dnzgO5LT5kgUP/2+e7qs/EkSOump7W5F45c1C
zP03FPzohgsAQ1n17QoWbaKahgGgFtE1zsHT8/5vZ7YRSH6lL68jYW0idYAF4aLL
Yw4D32qV7oPrfz0Y0hKNzmNN7brPsGxjseQIg0z0nSHp4yJCKyImEBD/ckVKBvB/
mS1T+3yT2Mxzd92YwbtIGe3+s4pfGH7FAPg7GxJAVsVwc27SM62LBEl3FOx0Y8bD
vcwT0AH1IgKulxmdyc8jfTq21JY7rcXdTaQzCpvwcK27ccQc2vCK0yi90/wnsx6q
vAiJP507qeKgPWDkbUmxXJvFAsYJR3ZS8PYgelw9pf5vM42Jp2DkMFFd5FDXnlMJ
zmS/WYHcdAiTqws10HhXXTq5dLXz12PFEFulhT93NodftkDZq3TQPKTZ4OX4AsWF
YDIgmjtuh1YGECm8nEU6tLpINXvRVCv+vv+digchu9KyZLYgo9BsbWqoPz+SRGdC
i9EA+X29L0Y84jKwB5mNbcWBqEMYppj4vAjSMgl9NK//Hm6txfDTQgBQtMIx8Fks
+rEc/VK0C8l3/HKAhkZaCKAENEldFLpM9gbmcKQlrG11Tlmkf1TEfBMYMAymdFuY
fN61wJwePnYsXUwy6+qDkTxxx8Pxr0aaxHuOFsYygqJ6qBTk8KuSQSndCejKFBP/
ebm4Sx3shiCn2t/5oE6j
=aMRW
-----END PGP SIGNATURE-----

--=-hMJJ43Iy3/D2foi/+KiE--
