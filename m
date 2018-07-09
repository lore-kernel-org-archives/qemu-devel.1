Received: from eggs.gnu.org ([2001:4830:134:3::10]:46104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcOTI-0007zG-L6
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcOTH-0002Ef-Iw
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:12:24 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:45459)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fcOTG-0002E1-Qz
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:12:23 -0400
Date: Mon, 9 Jul 2018 15:12:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709051214.GG22363@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-5-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-5-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 04/14] timer: ds1338 clarify HOUR handling
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


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:51AM -0700, Michael Davidsaver wrote:
> Simplify and comment the translation between
> registers and struct tm.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

although..

[snip]
> @@ -101,7 +105,9 @@ static void capture_current_time(DS1338State *s)
>          } else {
>              s->nvram[R_HOUR] =3D R_HOUR_SET12_MASK | R_HOUR_AMPM_MASK | =
to_bcd(tmp - 12);
>          }
> +
>      } else {

I'm not real fond of blank lines before the ends of blocks.

> +        /* 24 hour mode. */
>          s->nvram[R_HOUR] =3D to_bcd(now.tm_hour);
>      }
>      s->nvram[R_WDAY] =3D (now.tm_wday + s->wday_offset) % 7 + 1;
> @@ -178,14 +184,13 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
>              break;
>          case R_HOUR:
>              if (FIELD_EX32(data, HOUR, SET12)) {
> -                int tmp =3D from_bcd(FIELD_EX32(data, HOUR, HOUR12));
> +                /* 12 hour (1-12) */
> +                /* read and wrap 1-12 -> 0-11 */
> +                now.tm_hour =3D from_bcd(FIELD_EX32(data, HOUR, HOUR12))=
 % 12u;
>                  if (FIELD_EX32(data, HOUR, AMPM)) {
> -                    tmp +=3D 12;
> +                    now.tm_hour +=3D 12;
>                  }
> -                if (tmp % 12 =3D=3D 0) {
> -                    tmp -=3D 12;
> -                }
> -                now.tm_hour =3D tmp;
> +
>              } else {
>                  now.tm_hour =3D from_bcd(FIELD_EX32(data, HOUR, HOUR24));
>              }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltC7q4ACgkQbDjKyiDZ
s5IiXw//Vfz2sbCQiak+NRoMprL4Nx0r3KfrPiXURUWB5fsbErzYgAGDpLf+uylK
P8fjYRIzZ8DZ+j6kvHkso4RYpQ88ZvZJqqHO5Oyv6MnL00AnwstzxAd3hA7AVDqN
k0aVv5BZ14ZunqESKNajV176BtbnJEwpzq8J7y5LOfh+jWMxrSG5w29Q3eFsVh/8
ArvHXeNMwKCwLhq0kwyDcFj3ttNqPF9vo464IF/WZdiWb8WeIVZwgccqBJmgOzfG
NJFWmSu1xs7TX9DJlvPwbTYFahNgyEUVwc4+1HYn7wnQDkL7OZGna8ZPOOUqGhcF
mx+GOkUXZBwhw2ydotIlzeD36BeIvHJFtNFgsyPEoafyCz79xGu0uBjtom7ENbtg
ylymYXFbs/86h/MeTmE0XCfx3lZRPcyVwIJrlmRipuByQQruOD9H79NdQlqWcUA0
zR4bdI/1m+RvbfWUA4Gw1zF9b76/W5bpnCdz/15IPSDV7Rip9DFcShUMdYv0JgaT
sXC78l4/CYtQZ50Ga2psA98WVVn6wwufrWc9PBQlXaUqcn6p4Fbtbl7zajwwIjUH
h+Tp+lIr376CE25FunYJKpwbbpEHTd0DqWabMWSetwrS9lLD/w4sxwZdGh0UvAQc
RFOjL+k0ANDPRXzQRdxFaR9rYmhXs9OrIew3SxQ65zP5lSB4XpU=
=nWtm
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
