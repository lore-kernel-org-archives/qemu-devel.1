Received: from eggs.gnu.org ([2001:4830:134:3::10]:51762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8ZEs-0002lO-KJ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8ZEm-0007gL-S7
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:10:28 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8ZEl-0007bX-5s
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:10:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so4667211wmf.1
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 16:10:21 -0700 (PDT)
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
	<1538579266-8389-5-git-send-email-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a7f59a2b-91d6-49e3-e2c7-79d69043c514@redhat.com>
Date: Sat, 6 Oct 2018 01:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <1538579266-8389-5-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 04/12] net: cadence_gem: Add macro with
 max number of descriptor words
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

On 03/10/2018 17:07, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add macro with max number of DMA descriptor words.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/net/cadence_gem.c         | 4 ++--
>  include/hw/net/cadence_gem.h | 5 ++++-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 31f3fe0..4d769b0 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -1042,7 +1042,7 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
>   */
>  static void gem_transmit(CadenceGEMState *s)
>  {
> -    uint32_t desc[2];
> +    uint32_t desc[DESC_MAX_NUM_WORDS];
>      hwaddr packet_desc_addr;
>      uint8_t     tx_packet[2048];
>      uint8_t     *p;
> @@ -1108,7 +1108,7 @@ static void gem_transmit(CadenceGEMState *s)
>  
>              /* Last descriptor for this packet; hand the whole thing off */
>              if (tx_desc_get_last(desc)) {
> -                uint32_t desc_first[2];
> +                uint32_t desc_first[DESC_MAX_NUM_WORDS];
>  
>                  /* Modify the 1st descriptor of this packet to be owned by
>                   * the processor.
> diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
> index 633d564..b33ef65 100644
> --- a/include/hw/net/cadence_gem.h
> +++ b/include/hw/net/cadence_gem.h
> @@ -32,6 +32,9 @@
>  
>  #define CADENCE_GEM_MAXREG        (0x00000800 / 4) /* Last valid GEM address */
>  
> +/* Max number of words in a DMA descriptor.  */
> +#define DESC_MAX_NUM_WORDS              2
> +
>  #define MAX_PRIORITY_QUEUES             8
>  #define MAX_TYPE1_SCREENERS             16
>  #define MAX_TYPE2_SCREENERS             16
> @@ -74,7 +77,7 @@ typedef struct CadenceGEMState {
>  
>      uint8_t can_rx_state; /* Debug only */
>  
> -    uint32_t rx_desc[MAX_PRIORITY_QUEUES][2];
> +    uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
>  
>      bool sar_active[4];
>  } CadenceGEMState;
> 
