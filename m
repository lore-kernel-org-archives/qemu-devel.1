Received: from eggs.gnu.org ([2001:4830:134:3::10]:46035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8Yhd-0004XN-0l
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 18:36:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8Yhb-0006g1-Hc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 18:36:08 -0400
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <1732b6b4-d943-a690-b554-e84c1e74b897@gmail.com>
Date: Fri, 5 Oct 2018 15:35:58 -0700
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-7-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/12] net: cadence_gem: Add support for
 selecting the DMA MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, frasse.iglesias@gmail.com, alistair@alistair23.me, richard.henderson@linaro.org, frederic.konrad@adacore.com

On 10/03/2018 08:07 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add support for selecting the Memory Region that the GEM
> will do DMA to.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/net/cadence_gem.c         | 63 ++++++++++++++++++++++++++++----------------
>   include/hw/net/cadence_gem.h |  2 ++
>   2 files changed, 43 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 759c1d7..ab02515 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -28,6 +28,7 @@
>   #include "hw/net/cadence_gem.h"
>   #include "qapi/error.h"
>   #include "qemu/log.h"
> +#include "sysemu/dma.h"
>   #include "net/checksum.h"
>   
>   #ifdef CADENCE_GEM_ERR_DEBUG
> @@ -835,9 +836,9 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
>   {
>       DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
>       /* read current descriptor */
> -    cpu_physical_memory_read(s->rx_desc_addr[q],
> -                             (uint8_t *)s->rx_desc[q],
> -                             sizeof(uint32_t) * gem_get_desc_len(s, true));
> +    address_space_read(s->dma_as, s->rx_desc_addr[q], MEMTXATTRS_UNSPECIFIED,
> +                       (uint8_t *)s->rx_desc[q],
> +                       sizeof(uint32_t) * gem_get_desc_len(s, true));
>   
>       /* Descriptor owned by software ? */
>       if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
> @@ -956,10 +957,10 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>                   rx_desc_get_buffer(s->rx_desc[q]));
>   
>           /* Copy packet data to emulated DMA buffer */
> -        cpu_physical_memory_write(rx_desc_get_buffer(s, s->rx_desc[q]) +
> +        address_space_write(s->dma_as, rx_desc_get_buffer(s, s->rx_desc[q]) +
>                                                                     rxbuf_offset,
> -                                  rxbuf_ptr,
> -                                  MIN(bytes_to_copy, rxbufsize));
> +                            MEMTXATTRS_UNSPECIFIED, rxbuf_ptr,
> +                            MIN(bytes_to_copy, rxbufsize));
>           rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
>           bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
>   
> @@ -993,9 +994,10 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>           }
>   
>           /* Descriptor write-back.  */
> -        cpu_physical_memory_write(s->rx_desc_addr[q],
> -                                  (uint8_t *)s->rx_desc[q],
> -                                  sizeof(uint32_t) * gem_get_desc_len(s, true));
> +        address_space_write(s->dma_as, s->rx_desc_addr[q],
> +                            MEMTXATTRS_UNSPECIFIED,
> +                            (uint8_t *)s->rx_desc[q],
> +                            sizeof(uint32_t) * gem_get_desc_len(s, true));
>   
>           /* Next descriptor */
>           if (rx_desc_get_wrap(s->rx_desc[q])) {
> @@ -1099,9 +1101,9 @@ static void gem_transmit(CadenceGEMState *s)
>           packet_desc_addr = s->tx_desc_addr[q];
>   
>           DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
> -        cpu_physical_memory_read(packet_desc_addr,
> -                                 (uint8_t *)desc,
> -                                 sizeof(uint32_t) * gem_get_desc_len(s, false));
> +        address_space_read(s->dma_as, packet_desc_addr,
> +                           MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
> +                           sizeof(uint32_t) * gem_get_desc_len(s, false));
>           /* Handle all descriptors owned by hardware */
>           while (tx_desc_get_used(desc) == 0) {
>   
> @@ -1133,8 +1135,9 @@ static void gem_transmit(CadenceGEMState *s)
>               /* Gather this fragment of the packet from "dma memory" to our
>                * contig buffer.
>                */
> -            cpu_physical_memory_read(tx_desc_get_buffer(s, desc), p,
> -                                     tx_desc_get_length(desc));
> +            address_space_read(s->dma_as, tx_desc_get_buffer(s, desc),
> +                               MEMTXATTRS_UNSPECIFIED,
> +                               p, tx_desc_get_length(desc));
>               p += tx_desc_get_length(desc);
>               total_bytes += tx_desc_get_length(desc);
>   
> @@ -1145,13 +1148,15 @@ static void gem_transmit(CadenceGEMState *s)
>                   /* Modify the 1st descriptor of this packet to be owned by
>                    * the processor.
>                    */
> -                cpu_physical_memory_read(s->tx_desc_addr[q],
> -                                         (uint8_t *)desc_first,
> -                                         sizeof(desc_first));
> +                address_space_read(s->dma_as, s->tx_desc_addr[q],
> +                                   MEMTXATTRS_UNSPECIFIED,
> +                                   (uint8_t *)desc_first,
> +                                   sizeof(desc_first));
>                   tx_desc_set_used(desc_first);
> -                cpu_physical_memory_write(s->tx_desc_addr[q],
> -                                          (uint8_t *)desc_first,
> -                                          sizeof(desc_first));
> +                address_space_write(s->dma_as, s->tx_desc_addr[q],
> +                                  MEMTXATTRS_UNSPECIFIED,
> +                                  (uint8_t *)desc_first,
> +                                   sizeof(desc_first));
>                   /* Advance the hardware current descriptor past this packet */
>                   if (tx_desc_get_wrap(desc)) {
>                       s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
> @@ -1204,8 +1209,9 @@ static void gem_transmit(CadenceGEMState *s)
>                   packet_desc_addr += 4 * gem_get_desc_len(s, false);
>               }
>               DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
> -            cpu_physical_memory_read(packet_desc_addr, (uint8_t *)desc,
> -                                sizeof(uint32_t) * gem_get_desc_len(s, false));
> +            address_space_read(s->dma_as, packet_desc_addr,
> +                              MEMTXATTRS_UNSPECIFIED, (uint8_t *)desc,
> +                              sizeof(uint32_t) * gem_get_desc_len(s, false));
>           }
>   
>           if (tx_desc_get_used(desc)) {
> @@ -1500,6 +1506,13 @@ static void gem_realize(DeviceState *dev, Error **errp)
>       CadenceGEMState *s = CADENCE_GEM(dev);
>       int i;
>   
> +    if (s->dma_mr) {
> +        s->dma_as = g_malloc0(sizeof(AddressSpace));
> +        address_space_init(s->dma_as, s->dma_mr, NULL);
> +    } else {
> +        s->dma_as = &address_space_memory;
> +    }
> +
>       if (s->num_priority_queues == 0 ||
>           s->num_priority_queues > MAX_PRIORITY_QUEUES) {
>           error_setg(errp, "Invalid num-priority-queues value: %" PRIx8,
> @@ -1537,6 +1550,12 @@ static void gem_init(Object *obj)
>                             "enet", sizeof(s->regs));
>   
>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
> +
> +    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
> +                             (Object **)&s->dma_mr,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG,
> +                             &error_abort);
>   }
>   
>   static const VMStateDescription vmstate_cadence_gem = {
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index 00dbf4f..c8f0751 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -45,6 +45,8 @@ typedef struct CadenceGEMState {
>   
>       /*< public >*/
>       MemoryRegion iomem;
> +    MemoryRegion *dma_mr;
> +    AddressSpace *dma_as;
>       NICState *nic;
>       NICConf conf;
>       qemu_irq irq[MAX_PRIORITY_QUEUES];
> 
