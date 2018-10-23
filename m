Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEkA7-0000cA-Lr
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 20:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gEkA4-0006xz-DH
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 20:03:07 -0400
MIME-Version: 1.0
References: <20181018182856.28001-1-mark.cave-ayland@ilande.co.uk>
	<20181018182856.28001-11-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20181018182856.28001-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Oct 2018 02:02:52 +0200
Message-ID: <CAAdtpL75BvRBRToHWaEvTWBoCopBfYBRMy_fnTc9R=SuWXbKjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 10/11] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Laurent Vivier <laurent@vivier.eu>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On Thu, Oct 18, 2018 at 8:43 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> From: Laurent Vivier <laurent@vivier.eu>
>
> This is needed by Quadra 800, this card can run on little-endian
> or big-endian bus.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/net/dp8393x.c | 88 ++++++++++++++++++++++++++++++++++++--------------=
------
>  1 file changed, 57 insertions(+), 31 deletions(-)
>
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index b53fcaa8bc..1cf348aea1 100644
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
>          DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
>              s->cam[index][0], s->cam[index][1], s->cam[index][2],
>              s->cam[index][3], s->cam[index][4], s->cam[index][5]);
> @@ -269,7 +293,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>      /* Read CAM enable */
>      address_space_rw(&s->as, dp8393x_cdp(s),
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -    s->regs[SONIC_CE] =3D data[0 * width];
> +    s->regs[SONIC_CE] =3D dp8393x_get(s, width, data, 0);
>      DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]=
);
>
>      /* Done */
> @@ -290,10 +314,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
>
>      /* Update SONIC registers */
> -    s->regs[SONIC_CRBA0] =3D data[0 * width];
> -    s->regs[SONIC_CRBA1] =3D data[1 * width];
> -    s->regs[SONIC_RBWC0] =3D data[2 * width];
> -    s->regs[SONIC_RBWC1] =3D data[3 * width];
> +    s->regs[SONIC_CRBA0] =3D dp8393x_get(s, width, data, 0);
> +    s->regs[SONIC_CRBA1] =3D dp8393x_get(s, width, data, 1);
> +    s->regs[SONIC_RBWC0] =3D dp8393x_get(s, width, data, 2);
> +    s->regs[SONIC_RBWC1] =3D dp8393x_get(s, width, data, 3);
>      DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
>          s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
>          s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
> @@ -408,12 +432,12 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
>          tx_len =3D 0;
>
>          /* Update registers */
> -        s->regs[SONIC_TCR] =3D data[0 * width] & 0xf000;
> -        s->regs[SONIC_TPS] =3D data[1 * width];
> -        s->regs[SONIC_TFC] =3D data[2 * width];
> -        s->regs[SONIC_TSA0] =3D data[3 * width];
> -        s->regs[SONIC_TSA1] =3D data[4 * width];
> -        s->regs[SONIC_TFS] =3D data[5 * width];
> +        s->regs[SONIC_TCR] =3D dp8393x_get(s, width, data, 0) & 0xf000;
> +        s->regs[SONIC_TPS] =3D dp8393x_get(s, width, data, 1);
> +        s->regs[SONIC_TFC] =3D dp8393x_get(s, width, data, 2);
> +        s->regs[SONIC_TSA0] =3D dp8393x_get(s, width, data, 3);
> +        s->regs[SONIC_TSA1] =3D dp8393x_get(s, width, data, 4);
> +        s->regs[SONIC_TFS] =3D dp8393x_get(s, width, data, 5);
>
>          /* Handle programmable interrupt */
>          if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
> @@ -439,9 +463,9 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>                  address_space_rw(&s->as,
>                      dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * w=
idth,
>                      MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -                s->regs[SONIC_TSA0] =3D data[0 * width];
> -                s->regs[SONIC_TSA1] =3D data[1 * width];
> -                s->regs[SONIC_TFS] =3D data[2 * width];
> +                s->regs[SONIC_TSA0] =3D dp8393x_get(s, width, data, 0);
> +                s->regs[SONIC_TSA1] =3D dp8393x_get(s, width, data, 1);
> +                s->regs[SONIC_TFS] =3D dp8393x_get(s, width, data, 2);
>              }
>          }
>
> @@ -468,7 +492,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>          s->regs[SONIC_TCR] |=3D SONIC_TCR_PTX;
>
>          /* Write status */
> -        data[0 * width] =3D s->regs[SONIC_TCR] & 0x0fff; /* status */
> +        dp8393x_put(s, width, data, 0,
> +                    s->regs[SONIC_TCR] & 0x0fff); /* status */
>          size =3D sizeof(uint16_t) * width;
>          address_space_rw(&s->as,
>              dp8393x_ttda(s),
> @@ -482,8 +507,8 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
>                               sizeof(uint16_t) *
>                               (4 + 3 * s->regs[SONIC_TFC]) * width,
>                  MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -            s->regs[SONIC_CTDA] =3D data[0 * width] & ~0x1;
> -            if (data[0 * width] & 0x1) {
> +            s->regs[SONIC_CTDA] =3D dp8393x_get(s, width, data, 0) & ~0x=
1;
> +            if (dp8393x_get(s, width, data, 0) & 0x1) {
>                  /* EOL detected */
>                  break;
>              }
> @@ -746,7 +771,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
>          address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
>          address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
>                           (uint8_t *)data, size, 0);
> -        if (data[0 * width] & 0x1) {
> +        if (dp8393x_get(s, width, data, 0) & 0x1) {
>              /* Still EOL ; stop reception */
>              return -1;
>          } else {
> @@ -790,11 +815,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>
>      /* Write status to memory */
>      DPRINTF("Write status at %08x\n", dp8393x_crda(s));
> -    data[0 * width] =3D s->regs[SONIC_RCR]; /* status */
> -    data[1 * width] =3D rx_len; /* byte count */
> -    data[2 * width] =3D s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
> -    data[3 * width] =3D s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
> -    data[4 * width] =3D s->regs[SONIC_RSC]; /* seq_no */
> +    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
> +    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
> +    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
> +    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
> +    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
>      size =3D sizeof(uint16_t) * 5 * width;
>      address_space_rw(&s->as, dp8393x_crda(s),
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
> @@ -803,12 +828,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
>      size =3D sizeof(uint16_t) * width;
>      address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * wi=
dth,
>          MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -    s->regs[SONIC_LLFA] =3D data[0 * width];
> +    s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, data, 0);
>      if (s->regs[SONIC_LLFA] & 0x1) {
>          /* EOL detected */
>          s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
>      } else {
> -        data[0 * width] =3D 0; /* in_use */
> +        dp8393x_put(s, width, data, 0, 0); /* in_use */
>          address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 =
* width,
>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1=
);
>          s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
> @@ -921,6 +946,7 @@ static Property dp8393x_properties[] =3D {
>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
>      DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
> +    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>
> --
> 2.11.0
>
>
