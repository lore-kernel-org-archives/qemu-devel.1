Received: from eggs.gnu.org ([2001:4830:134:3::10]:52349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8ZGl-00041F-Sx
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1g8ZGk-0002Eu-OO
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:12:27 -0400
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-8-git-send-email-edgar.iglesias@gmail.com>
From: Alistair <alistair23@gmail.com>
Message-ID: <86063442-84a7-c546-a05e-fc4eb50edccc@gmail.com>
Date: Fri, 5 Oct 2018 16:12:18 -0700
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-8-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 07/12] net: cadence_gem: Implement
 support for 64bit descriptor addresses
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
> Implement support for 64bit descriptor addresses.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>   hw/net/cadence_gem.c | 47 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index ab02515..f93cd8e 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -153,6 +153,9 @@
>   #define GEM_RECEIVE_Q1_PTR              (0x00000480 / 4)
>   #define GEM_RECEIVE_Q7_PTR              (GEM_RECEIVE_Q1_PTR + 6)
>   
> +#define GEM_TBQPH                       (0x000004C8 / 4)
> +#define GEM_RBQPH                       (0x000004D4 / 4)
> +
>   #define GEM_INT_Q1_ENABLE               (0x00000600 / 4)
>   #define GEM_INT_Q7_ENABLE               (GEM_INT_Q1_ENABLE + 6)
>   
> @@ -832,18 +835,42 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>       return 0;
>   }
>   
> +static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)
> +{
> +    hwaddr desc_addr = 0;
> +
> +    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
> +        desc_addr = s->regs[tx ? GEM_TBQPH : GEM_RBQPH];
> +    }
> +    desc_addr <<= 32;
> +    desc_addr |= tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
> +    return desc_addr;
> +}
> +
> +static hwaddr gem_get_tx_desc_addr(CadenceGEMState *s, int q)
> +{
> +    return gem_get_desc_addr(s, true, q);
> +}
> +
> +static hwaddr gem_get_rx_desc_addr(CadenceGEMState *s, int q)
> +{
> +    return gem_get_desc_addr(s, false, q);
> +}
> +
>   static void gem_get_rx_desc(CadenceGEMState *s, int q)
>   {
> -    DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
> +    hwaddr desc_addr = gem_get_rx_desc_addr(s, q);
> +
> +    DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", desc_addr);
> +
>       /* read current descriptor */
> -    address_space_read(s->dma_as, s->rx_desc_addr[q], MEMTXATTRS_UNSPECIFIED,
> +    address_space_read(s->dma_as, desc_addr, MEMTXATTRS_UNSPECIFIED,
>                          (uint8_t *)s->rx_desc[q],
>                          sizeof(uint32_t) * gem_get_desc_len(s, true));
>   
>       /* Descriptor owned by software ? */
>       if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
> -        DB_PRINT("descriptor 0x%x owned by sw.\n",
> -                 (unsigned)s->rx_desc_addr[q]);
> +        DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n", desc_addr);
>           s->regs[GEM_RXSTATUS] |= GEM_RXSTATUS_NOBUF;
>           s->regs[GEM_ISR] |= GEM_INT_RXUSED & ~(s->regs[GEM_IMR]);
>           /* Handle interrupt consequences */
> @@ -947,6 +974,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>       q = get_queue_from_screen(s, rxbuf_ptr, rxbufsize);
>   
>       while (bytes_to_copy) {
> +        hwaddr desc_addr;
> +
>           /* Do nothing if receive is not enabled. */
>           if (!gem_can_receive(nc)) {
>               assert(!first_desc);
> @@ -994,7 +1023,8 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>           }
>   
>           /* Descriptor write-back.  */
> -        address_space_write(s->dma_as, s->rx_desc_addr[q],
> +        desc_addr = gem_get_rx_desc_addr(s, q);
> +        address_space_write(s->dma_as, desc_addr,
>                               MEMTXATTRS_UNSPECIFIED,
>                               (uint8_t *)s->rx_desc[q],
>                               sizeof(uint32_t) * gem_get_desc_len(s, true));
> @@ -1098,7 +1128,7 @@ static void gem_transmit(CadenceGEMState *s)
>   
>       for (q = s->num_priority_queues - 1; q >= 0; q--) {
>           /* read current descriptor */
> -        packet_desc_addr = s->tx_desc_addr[q];
> +        packet_desc_addr = gem_get_tx_desc_addr(s, q);
>   
>           DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
>           address_space_read(s->dma_as, packet_desc_addr,
> @@ -1144,16 +1174,17 @@ static void gem_transmit(CadenceGEMState *s)
>               /* Last descriptor for this packet; hand the whole thing off */
>               if (tx_desc_get_last(desc)) {
>                   uint32_t desc_first[DESC_MAX_NUM_WORDS];
> +                hwaddr desc_addr = gem_get_tx_desc_addr(s, q);
>   
>                   /* Modify the 1st descriptor of this packet to be owned by
>                    * the processor.
>                    */
> -                address_space_read(s->dma_as, s->tx_desc_addr[q],
> +                address_space_read(s->dma_as, desc_addr,
>                                      MEMTXATTRS_UNSPECIFIED,
>                                      (uint8_t *)desc_first,
>                                      sizeof(desc_first));
>                   tx_desc_set_used(desc_first);
> -                address_space_write(s->dma_as, s->tx_desc_addr[q],
> +                address_space_write(s->dma_as, desc_addr,
>                                     MEMTXATTRS_UNSPECIFIED,
>                                     (uint8_t *)desc_first,
>                                      sizeof(desc_first));
> 
