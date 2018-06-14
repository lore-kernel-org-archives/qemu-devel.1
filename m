Received: from eggs.gnu.org ([2001:4830:134:3::10]:45812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fTQNg-0007dA-CO
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 07:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgari@xilinx.com>) id 1fTQNd-0004mm-7b
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 07:25:32 -0400
Received: from mail-eopbgr690041.outbound.protection.outlook.com
	([40.107.69.41]:11392
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgari@xilinx.com>) id 1fTQNc-0004mP-Jv
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 07:25:29 -0400
Date: Thu, 14 Jun 2018 13:25:06 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180614112506.b7fj2pcsay35gvqg@toto>
References: <1528954027-7938-1-git-send-email-saipava@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1528954027-7938-1-git-send-email-saipava@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH] xilinx_spips: Make dma transactions as per
 dma_burst_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Francisco Iglesias <frasse.iglesias@gmail.com>

On Thu, Jun 14, 2018 at 10:57:04AM +0530, Sai Pavan Boddu wrote:
> Qspi dma has a burst length of 64 bytes, So limit transaction length to
> 64 max.

Hi Sai,

Is this a v2 or a resend?

> 
> Signed-off-by: Sai Pavan Boddu <saipava@xilinx.com>
> ---
>  hw/ssi/xilinx_spips.c         | 18 +++++++++++++++---
>  include/hw/ssi/xilinx_spips.h |  3 ++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 03f5fae..ea006c4 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -851,12 +851,17 @@ static void xlnx_zynqmp_qspips_notify(void *opaque)
>      {
>          size_t ret;
>          uint32_t num;
> -        const void *rxd = pop_buf(recv_fifo, 4, &num);
> +        const void *rxd;
> +        int len;
> +
> +        len = recv_fifo->num >= rq->dma_burst_size ? rq->dma_burst_size :
> +                                                   recv_fifo->num;
> +        rxd = pop_buf(recv_fifo, len, &num);
>  
>          memcpy(rq->dma_buf, rxd, num);
>  
> -        ret = stream_push(rq->dma, rq->dma_buf, 4);
> -        assert(ret == 4);
> +        ret = stream_push(rq->dma, rq->dma_buf, num);
> +        assert(ret == num);
>          xlnx_zynqmp_qspips_check_flush(rq);
>      }
>  }
> @@ -1337,6 +1342,7 @@ static void xlnx_zynqmp_qspips_realize(DeviceState *dev, Error **errp)
>      fifo8_create(&s->rx_fifo_g, xsc->rx_fifo_size);
>      fifo8_create(&s->tx_fifo_g, xsc->tx_fifo_size);
>      fifo32_create(&s->fifo_g, 32);
> +    s->dma_buf = g_new0(uint8_t, s->dma_burst_size);


This would need to be free'd somewhere.
But I think you should put a reasonably small limit on the burst size that users can
configure and then you can allocate this as an array in XlnxZynqMPQSPIPS.



>  }
>  
>  static void xlnx_zynqmp_qspips_init(Object *obj)
> @@ -1411,6 +1417,11 @@ static const VMStateDescription vmstate_xlnx_zynqmp_qspips = {
>      }
>  };
>  
> +static Property xilinx_zynqmp_qspips_properties[] = {
> +    DEFINE_PROP_UINT32("dma-burst-size", XlnxZynqMPQSPIPS, dma_burst_size, 64),

You need to limit this so users dont pick 4G. Perhaps 2 or 4K max.

Cheers,
Edgar


> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>  static Property xilinx_qspips_properties[] = {
>      /* We had to turn this off for 2.10 as it is not compatible with migration.
>       * It can be enabled but will prevent the device to be migrated.
> @@ -1463,6 +1474,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
>      dc->realize = xlnx_zynqmp_qspips_realize;
>      dc->reset = xlnx_zynqmp_qspips_reset;
>      dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
> +    dc->props = xilinx_zynqmp_qspips_properties;
>      xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
>      xsc->rx_fifo_size = RXFF_A_Q;
>      xsc->tx_fifo_size = TXFF_A_Q;
> diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
> index d398a4e..cca1813 100644
> --- a/include/hw/ssi/xilinx_spips.h
> +++ b/include/hw/ssi/xilinx_spips.h
> @@ -95,7 +95,8 @@ typedef struct {
>      XilinxQSPIPS parent_obj;
>  
>      StreamSlave *dma;
> -    uint8_t dma_buf[4];
> +    uint8_t *dma_buf;
> +    uint32_t dma_burst_size;
>      int gqspi_irqline;
>  
>      uint32_t regs[XLNX_ZYNQMP_SPIPS_R_MAX];
> -- 
> 2.7.4
> 
