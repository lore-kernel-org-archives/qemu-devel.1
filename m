Received: from eggs.gnu.org ([2001:4830:134:3::10]:34433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNIUe-0006fr-Fi
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNIUZ-0008Al-Fb
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:47:24 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNIUZ-00089W-8j
	for qemu-devel@nongnu.org; Mon, 28 May 2018 09:47:19 -0400
Received: from player729.ha.ovh.net (unknown [10.109.108.70])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 7A2BE1B999A
	for <qemu-devel@nongnu.org>; Mon, 28 May 2018 15:47:16 +0200 (CEST)
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20180528124621.22977-1-joel@jms.id.au>
Message-ID: <9959794d-6d3b-b797-bfc8-b548d54378ad@kaod.org>
Date: Mon, 28 May 2018 15:47:11 +0200
MIME-Version: 1.0
In-Reply-To: <20180528124621.22977-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] aspeed_scu: Implement RNG register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>

Hello Joel, 

On 05/28/2018 02:46 PM, Joel Stanley wrote:
> The ASPEED SoCs contain a single register that returns random data when
> read. This models that register so that guests can use it.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/misc/aspeed_scu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 5e6d5744eeca..8fa0cecf0fa1 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,6 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "crypto/random.h"
>  #include "trace.h"
>  
>  #define TO_REG(offset) ((offset) >> 2)
> @@ -154,6 +155,18 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
>       [BMC_DEV_ID]      = 0x00002402U
>  };
>  
> +static uint32_t aspeed_scu_get_random(void)
> +{
> +    Error *err = NULL;
> +    uint32_t num;
> +
> +    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
> +        error_report_err(err);
> +    }
> +
> +    return num;
> +}
> +
>  static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      AspeedSCUState *s = ASPEED_SCU(opaque);
> @@ -167,6 +180,9 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
>      }
>  
>      switch (reg) {
> +    case RNG_DATA:
> +        return aspeed_scu_get_random();

may be we could test bit 1 of RNG_CTRL to check if it is enabled or not.

> +        break;
>      case WAKEUP_EN:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Read of write-only offset 0x%" HWADDR_PRIx "\n",
> @@ -287,6 +303,9 @@ static void aspeed_scu_realize(DeviceState *dev, Error **errp)
>                            TYPE_ASPEED_SCU, SCU_IO_REGION_SIZE);
>  
>      sysbus_init_mmio(sbd, &s->iomem);
> +
> +    if (qcrypto_random_init(errp))
> +        return;
>  }

Isn't this routine called from main() already ? 

C. 

>  
>  static const VMStateDescription vmstate_aspeed_scu = {
> 
