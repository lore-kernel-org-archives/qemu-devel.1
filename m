Received: from eggs.gnu.org ([2001:4830:134:3::10]:38599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fc3IY-0006u7-R5
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:35:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fc3IX-0003B2-M0
	for qemu-devel@nongnu.org; Sun, 08 Jul 2018 02:35:54 -0400
References: <20180627232334.14142-1-laurent@vivier.eu>
	<20180627232334.14142-10-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <a0579c16-2270-cd5c-04fe-c89da7503c79@tuxfamily.org>
Date: Sun, 8 Jul 2018 08:35:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180627232334.14142-10-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [C v2 09/10] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 28.06.2018 01:23, Laurent Vivier wrote:
> This is needed by Quadra 800, this card can run on little-endian
> or big-endian bus.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Tested-by: Hervé Poussineau <hpoussin@reactos.org>
> ---
>  hw/net/dp8393x.c | 88 ++++++++++++++++++++++++++++++++++++--------------------
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
> +        val = be16_to_cpu(base[offset * width + width - 1]);
> +    } else {
> +        val = le16_to_cpu(base[offset * width]);
> +    }
> +    return val;
> +}
> +
> +static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
> +                        uint16_t val)
> +{
> +    if (s->big_endian) {
> +        base[offset * width + width - 1] = cpu_to_be16(val);
> +    } else {
> +        base[offset * width] = cpu_to_le16(val);
> +    }
> +}
> +
>  static void dp8393x_update_irq(dp8393xState *s)
>  {
>      int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
> @@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
>          /* Fill current entry */
>          address_space_rw(&s->as, dp8393x_cdp(s),
>              MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
> -        s->cam[index][0] = data[1 * width] & 0xff;
> -        s->cam[index][1] = data[1 * width] >> 8;
> -        s->cam[index][2] = data[2 * width] & 0xff;
> -        s->cam[index][3] = data[2 * width] >> 8;
> -        s->cam[index][4] = data[3 * width] & 0xff;
> -        s->cam[index][5] = data[3 * width] >> 8;
> +        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
> +        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
> +        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
> +        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
> +        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
> +        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;

So if the device is used with a little endian bus, but on a big endian
host, there is now an additional byte swap operation for all the values
now, right? Was this a bug in the previous implementation? If so, it
might be worth to mention that in the patch description?

 Thomas
