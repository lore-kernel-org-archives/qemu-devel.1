Received: from eggs.gnu.org ([2001:4830:134:3::10]:33309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcGyX-0000pO-6G
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 17:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcGyW-0002I8-0r
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 17:12:09 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcGyV-0002He-Jm
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 17:12:07 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so32322970oih.11
	for <qemu-devel@nongnu.org>; Sun, 08 Jul 2018 14:12:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180627232951.14725-10-laurent@vivier.eu>
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-10-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Jul 2018 22:11:46 +0100
Message-ID: <CAFEAcA-T4+fc62yOL4mGd=_v_0vPLcCR94apqWf=k3DA9HkLuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v3 09/10] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 28 June 2018 at 00:29, Laurent Vivier <laurent@vivier.eu> wrote:
> This is needed by Quadra 800, this card can run on little-endian
> or big-endian bus.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> ---
>  hw/net/dp8393x.c | 88 ++++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 57 insertions(+), 31 deletions(-)
>
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index f2d2ce344c..62adff9ba3 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -150,6 +150,7 @@ typedef struct dp8393xState {
>
>      /* Hardware */
>      uint8_t it_shift;
> +    bool big_endian;
>      qemu_irq irq;
>  #ifdef DEBUG_SONIC
>      int irq_level;
> @@ -220,6 +221,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
>      return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
>  }
>
> +static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
> +                            int offset)
> +{
> +    uint16_t val;
> +
> +    if (s->big_endian) {
> +        val =3D be16_to_cpu(base[offset * width + width - 1]);
> +    } else {
> +        val =3D le16_to_cpu(base[offset * width]);
> +    }
> +    return val;
> +}
> +
> +static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int =
offset,
> +                        uint16_t val)
> +{
> +    if (s->big_endian) {
> +        base[offset * width + width - 1] =3D cpu_to_be16(val);
> +    } else {
> +        base[offset * width] =3D cpu_to_le16(val);
> +    }
> +}
> +
>  static void dp8393x_update_irq(dp8393xState *s)
>  {
>      int level =3D (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
> @@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>          /* Fill current entry */
>          address_space_rw(&s->as, dp8393x_cdp(s),
>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -        s->cam[index][0] =3D data[1 * width] & 0xff;
> -        s->cam[index][1] =3D data[1 * width] >> 8;
> -        s->cam[index][2] =3D data[2 * width] & 0xff;
> -        s->cam[index][3] =3D data[2 * width] >> 8;
> -        s->cam[index][4] =3D data[3 * width] & 0xff;
> -        s->cam[index][5] =3D data[3 * width] >> 8;
> +        s->cam[index][0] =3D dp8393x_get(s, width, data, 1) & 0xff;
> +        s->cam[index][1] =3D dp8393x_get(s, width, data, 1) >> 8;
> +        s->cam[index][2] =3D dp8393x_get(s, width, data, 2) & 0xff;
> +        s->cam[index][3] =3D dp8393x_get(s, width, data, 2) >> 8;
> +        s->cam[index][4] =3D dp8393x_get(s, width, data, 3) & 0xff;
> +        s->cam[index][5] =3D dp8393x_get(s, width, data, 3) >> 8;

The general pattern with the code in this device seems to be
"load sizeof(uint16_t) * width * N bytes; then look at
data[i * width], possibly with an endianness flip", where
width is either 1 or 2 depending on a config register.

Maybe it would be clearer if the data was loaded by doing a
loop of N iterations of address_space_ldl_le / address_space_ldw_le /
address_space_ldl_be / address_space_ldw_be ? Then you're doing
something more like what the device is doing (ie a series of
bus accesses of a particular width and endianness), and the
handling of width and endianness is in the code doing the data
loads rather than in the code that is manipulating the loaded
data.

Incidentally, the only other use of this device is in
the mips 'jazz' boards. Those seem to be compiled for both
mips64el and mips64 -- does anybody know if it actually
works correctly in both those configurations ?

thanks
-- PMM
