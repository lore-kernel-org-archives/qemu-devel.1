Received: from eggs.gnu.org ([2001:4830:134:3::10]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigQj-0002wz-CK
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1eigQe-0006Y5-EU
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:03:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1eigQe-0006Xo-6f
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 08:03:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 743CC486CD
	for <qemu-devel@nongnu.org>; Mon,  5 Feb 2018 13:03:23 +0000 (UTC)
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-4-berrange@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f401213e-cbe0-d089-cd3f-3dbc3e446a5e@redhat.com>
Date: Mon, 5 Feb 2018 14:03:14 +0100
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 02/05/18 12:49, Daniel P. Berrang=C3=A9 wrote:
> The 'vs->as.freq' value is a signed integer, which is read from an
> unsigned 32-bit int field on the wire. There is thus a risk of overflow
> on 32-bit platforms. Move the frequency limit checking to be done at
> time of read before casting to a signed integer.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
> +                 * upper bound for trustworthy clients, and this limit
> +                 * protects calculations involving 'vs->as.freq' later=
.
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

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
