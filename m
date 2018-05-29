Received: from eggs.gnu.org ([2001:4830:134:3::10]:51862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNeh6-0000sw-Qu
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNeh3-0003J4-Jd
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:29:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529062838.20556-1-clg@kaod.org>
	<20180529062838.20556-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1a35d77a-2a3f-9925-5064-eba22a802ade@amsat.org>
Date: Tue, 29 May 2018 10:29:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180529062838.20556-2-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/6] ftgmac100: compute maximum
 frame size depending on the protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 05/29/2018 03:28 AM, Cédric Le Goater wrote:
> The maximum frame size includes the CRC and depends if a VLAN tag is
> inserted or not. Adjust the frame size limit in the transmit handler
> using on the FTGMAC100State buffer size and in the receive handler use
> the packet protocol.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  include/hw/net/ftgmac100.h |  7 ++++++-
>  hw/net/ftgmac100.c         | 23 ++++++++++++-----------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
> index d9bc589fbf72..94cfe0533297 100644
> --- a/include/hw/net/ftgmac100.h
> +++ b/include/hw/net/ftgmac100.h
> @@ -16,6 +16,11 @@
>  #include "hw/sysbus.h"
>  #include "net/net.h"
>  
> +/*
> + * Max frame size for the receiving buffer
> + */
> +#define FTGMAC100_MAX_FRAME_SIZE    9220
> +
>  typedef struct FTGMAC100State {
>      /*< private >*/
>      SysBusDevice parent_obj;
> @@ -26,7 +31,7 @@ typedef struct FTGMAC100State {
>      qemu_irq irq;
>      MemoryRegion iomem;
>  
> -    uint8_t *frame;
> +    uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
>  
>      uint32_t irq_state;
>      uint32_t isr;
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index a6d27a7b01df..7598d08c9cb9 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -207,16 +207,18 @@ typedef struct {
>  /*
>   * Max frame size for the receiving buffer
>   */
> -#define FTGMAC100_MAX_FRAME_SIZE    10240
> +#define FTGMAC100_MAX_FRAME_SIZE    9220

Sounds correct, (MAX(1518, 9216) + 4 /* vlan */ ).

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  
>  /* Limits depending on the type of the frame
>   *
>   *   9216 for Jumbo frames (+ 4 for VLAN)
>   *   1518 for other frames (+ 4 for VLAN)
>   */
> -static int ftgmac100_max_frame_size(FTGMAC100State *s)
> +static int ftgmac100_max_frame_size(FTGMAC100State *s, uint16_t proto)
>  {
> -    return (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518) + 4;
> +    int max = (s->maccr & FTGMAC100_MACCR_JUMBO_LF ? 9216 : 1518);
> +
> +    return max + (proto == ETH_P_VLAN ? 4 : 0);
>  }
>  
>  static void ftgmac100_update_irq(FTGMAC100State *s)
> @@ -408,7 +410,6 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>      uint8_t *ptr = s->frame;
>      uint32_t addr = tx_descriptor;
>      uint32_t flags = 0;
> -    int max_frame_size = ftgmac100_max_frame_size(s);
>  
>      while (1) {
>          FTGMAC100Desc bd;
> @@ -427,11 +428,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
>              flags = bd.des1;
>          }
>  
> -        len = bd.des0 & 0x3FFF;
> -        if (frame_size + len > max_frame_size) {
> +        len = FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
> +        if (frame_size + len > sizeof(s->frame)) {
>              qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
>                            __func__, len);
> -            len = max_frame_size - frame_size;
> +            s->isr |= FTGMAC100_INT_XPKT_LOST;
> +            len =  sizeof(s->frame) - frame_size;
>          }
>  
>          if (dma_memory_read(&address_space_memory, bd.des3, ptr, len)) {
> @@ -788,7 +790,8 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>      uint32_t buf_len;
>      size_t size = len;
>      uint32_t first = FTGMAC100_RXDES0_FRS;
> -    int max_frame_size = ftgmac100_max_frame_size(s);
> +    uint16_t proto = be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
> +    int max_frame_size = ftgmac100_max_frame_size(s, proto);
>  
>      if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN))
>           != (FTGMAC100_MACCR_RXDMA_EN | FTGMAC100_MACCR_RXMAC_EN)) {
> @@ -814,9 +817,9 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>  
>      /* Huge frames are truncated.  */
>      if (size > max_frame_size) {
> -        size = max_frame_size;
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %zd bytes\n",
>                        __func__, size);
> +        size = max_frame_size;
>          flags |= FTGMAC100_RXDES0_FTL;
>      }
>  
> @@ -934,8 +937,6 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
>                            object_get_typename(OBJECT(dev)), DEVICE(dev)->id,
>                            s);
>      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
> -
> -    s->frame = g_malloc(FTGMAC100_MAX_FRAME_SIZE);
>  }
>  
>  static const VMStateDescription vmstate_ftgmac100 = {
> 
