Received: from eggs.gnu.org ([209.51.188.92]:47632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWN1-0002Dc-N4
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWN0-0006Dm-Jb
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWN0-0006DR-BP
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so5862410wmi.5
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:51:46 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd584bda-744e-f25f-a35d-cda8dcbeec09@redhat.com>
Date: Thu, 11 Apr 2019 11:51:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/23] aspeed/scu: Use
 qemu_guest_getrandom_nofail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Joel Stanley <joel@jms.id.au>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.  Use the *_nofail routine
> instead of rolling our own error handling locally.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/aspeed_scu.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index c8217740ef..ab1e18ed4b 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -16,7 +16,7 @@
>  #include "qapi/visitor.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> -#include "crypto/random.h"
> +#include "qemu/guest-random.h"
>  #include "trace.h"
>  
>  #define TO_REG(offset) ((offset) >> 2)
> @@ -157,14 +157,8 @@ static const uint32_t ast2500_a1_resets[ASPEED_SCU_NR_REGS] = {
>  
>  static uint32_t aspeed_scu_get_random(void)
>  {
> -    Error *err = NULL;
>      uint32_t num;
> -
> -    if (qcrypto_random_bytes((uint8_t *)&num, sizeof(num), &err)) {
> -        error_report_err(err);
> -        exit(1);
> -    }
> -
> +    qemu_guest_getrandom_nofail(&num, sizeof(num));
>      return num;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
