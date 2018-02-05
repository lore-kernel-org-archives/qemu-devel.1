Received: from eggs.gnu.org ([2001:4830:134:3::10]:45824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimV7-0007DR-9B
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimV2-0006YU-MK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:24 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:40536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimV2-0006Y6-FY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:20 -0500
Received: by mail-qk0-x243.google.com with SMTP id d18so34058511qke.7
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:32:20 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1fa28338-5173-e247-b1d4-c2ff95b30f82@amsat.org>
Date: Mon, 5 Feb 2018 16:32:16 -0300
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="yK5e5XXEWSvI6bCTxD6kI7DWsyCbEyuUJ"
Subject: Re: [Qemu-devel] [PATCH 3/4] ui: check VNC audio frequency limit at
 time of reading from client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yK5e5XXEWSvI6bCTxD6kI7DWsyCbEyuUJ
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <1fa28338-5173-e247-b1d4-c2ff95b30f82@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/4] ui: check VNC audio frequency limit at
 time of reading from client
References: <20180205114938.15784-1-berrange@redhat.com>
 <20180205114938.15784-4-berrange@redhat.com>
In-Reply-To: <20180205114938.15784-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 08:49 AM, Daniel P. Berrang=C3=A9 wrote:
> The 'vs->as.freq' value is a signed integer, which is read from an
> unsigned 32-bit int field on the wire. There is thus a risk of overflow=

> on 32-bit platforms. Move the frequency limit checking to be done at
> time of read before casting to a signed integer.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  ui/vnc.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>=20
> diff --git a/ui/vnc.c b/ui/vnc.c
> index e14e524764..79ac9eccde 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -982,14 +982,7 @@ static void vnc_update_throttle_offset(VncState *v=
s)
>          vs->client_width * vs->client_height * vs->client_pf.bytes_per=
_pixel;
> =20
>      if (vs->audio_cap) {
> -        int freq =3D vs->as.freq;
> -        /* We don't limit freq when reading settings from client, so
> -         * it could be upto MAX_INT in size. 48khz is a sensible
> -         * upper bound for trustworthy clients */
>          int bps;
> -        if (freq > 48000) {
> -            freq =3D 48000;
> -        }
>          switch (vs->as.fmt) {
>          default:
>          case  AUD_FMT_U8:
> @@ -1005,7 +998,7 @@ static void vnc_update_throttle_offset(VncState *v=
s)
>              bps =3D 4;
>              break;
>          }
> -        offset +=3D freq * bps * vs->as.nchannels;
> +        offset +=3D vs->as.freq * bps * vs->as.nchannels;
>      }
> =20
>      /* Put a floor of 1MB on offset, so that if we have a large pendin=
g
> @@ -2279,6 +2272,7 @@ static int protocol_client_msg(VncState *vs, uint=
8_t *data, size_t len)
>  {
>      int i;
>      uint16_t limit;
> +    uint32_t freq;
>      VncDisplay *vd =3D vs->vd;
> =20
>      if (data[0] > 3) {
> @@ -2398,7 +2392,17 @@ static int protocol_client_msg(VncState *vs, uin=
t8_t *data, size_t len)
>                      vnc_client_error(vs);
>                      break;
>                  }
> -                vs->as.freq =3D read_u32(data, 6);
> +                freq =3D read_u32(data, 6);
> +                /* No official limit for protocol, but 48khz is a sens=
ible
> +                 * upper bound for trustworthy clients, and this limit=

> +                 * protects calculations involving 'vs->as.freq' later=
=2E
> +                 */
> +                if (freq > 48000) {
> +                    VNC_DEBUG("Invalid audio frequency %u > 48000", fr=
eq);
> +                    vnc_client_error(vs);
> +                    break;
> +                }
> +                vs->as.freq =3D freq;
>                  break;
>              default:
>                  VNC_DEBUG("Invalid audio message %d\n", read_u8(data, =
4));
>=20


--yK5e5XXEWSvI6bCTxD6kI7DWsyCbEyuUJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4sUAACgkQ4+MsLN6t
wN5uTw//cq0T7GDn6fHDXbW8E2rnpiQ4eeodOoAhDGQ6h2P+uQ1siUSNFXZOkW8I
opIYKcR7nU2KDslwpJZ0iqP2cVZd1QgQf4WH1IkXhZ35xXa1Sf0iFFP1xAV6Grb1
gYyjEX24ytgEjTK15zDWdHTC05YtNA0Hu28scpXdO9cH2uJfelsJYomHmHtTDwxK
k8C9/THXEMo7zZUGaM/kjVG2CVDPrhWIn87leQL/Qgy0uxJBasQKK0X0TC49g32W
zeb8qZjZ7Ogn4YzU1IYP1/pVXJQ78HMQVtFxzBSXU/HJ3ENcS7FacNr/7krlunDF
zW3pvdVJd+YrGkUuIMkT7tOwYU512DlRNcD/90P9rw+wJOFno6KvSsv2E1PI+yEL
F6UreY5aWCwLR0l9QPZ8ECNnpZuWQcppk9xviDdOonszHtgHcyOhTPHAA6PF5EQ0
mosjyzV3dkfCwMLmJisaiO2xR4LeY8+FIUVe3M4jDKiVu2HlTYQD+Z8FUGq65w5l
m/T+AxB2HC/dHasliOHTdTM710NMxrlebGtxYu7TFtB9z6RI0MJvIJ9JfdvP2P7T
oyCkJPSelC+x80DsmpsXer6/cuv2ilL+GBdlVMCjZE1XO1X0IQfGsMMSoe6zGLTd
Fb56JZwohv6EO+6HMvPXZcIIlRPLvCEEVedEpN/gFTIjoSebXHc=
=6vyp
-----END PGP SIGNATURE-----

--yK5e5XXEWSvI6bCTxD6kI7DWsyCbEyuUJ--
