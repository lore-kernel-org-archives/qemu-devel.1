Received: from eggs.gnu.org ([2001:4830:134:3::10]:54354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNeqn-0004Tb-8f
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fNeqm-0005AU-G2
	for qemu-devel@nongnu.org; Tue, 29 May 2018 09:39:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180529041946.9481-1-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c953d1dd-8e43-c781-9c4e-434ad1f9c084@amsat.org>
Date: Tue, 29 May 2018 10:39:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180529041946.9481-1-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3] aspeed_scu: Implement RNG
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 05/29/2018 01:19 AM, Joel Stanley wrote:
> The ASPEED SoCs contain a single register that returns random data when
> read. This models that register so that guests can use it.
> 
> The random number data register has a corresponding control register,
> however it returns data regardless of the state of the enabled bit, so
> the model follows this behaviour.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v2:
>  - Remove call to qcrypto_random_init as this is done in main()
> v3:
>  - Add Cédric's reviewed-by
>  - Add a comment about why we don't check for the rng enable bit
> ---
>  hw/misc/aspeed_scu.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 5e6d5744eeca..96db052389cc 100644
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
> @@ -167,6 +180,12 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
>      }
>  
>      switch (reg) {
> +    case RNG_DATA:
> +        /* On hardware, RNG_DATA works regardless of
> +         * the state of the enable bit in RNG_CTRL
> +         */
> +        s->regs[RNG_DATA] = aspeed_scu_get_random();
> +        break;
>      case WAKEUP_EN:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Read of write-only offset 0x%" HWADDR_PRIx "\n",
> 
