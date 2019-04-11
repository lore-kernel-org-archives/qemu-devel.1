Received: from eggs.gnu.org ([209.51.188.92]:48097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWOB-00037Y-P6
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWOA-0006fv-I9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:52:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWOA-0006fI-8m
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:52:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id q1so6513475wrp.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:52:58 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <86c380e4-de29-2ab7-1107-74b8ab2a5b34@redhat.com>
Date: Thu, 11 Apr 2019 11:52:56 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 18/23] hw/misc/bcm2835_rng: Use
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
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.  Use the *_nofail routine
> instead of rolling our own error handling locally.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/bcm2835_rng.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> index 4d62143b24..fe59c868f5 100644
> --- a/hw/misc/bcm2835_rng.c
> +++ b/hw/misc/bcm2835_rng.c
> @@ -9,30 +9,26 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> -#include "qapi/error.h"
> -#include "crypto/random.h"
> +#include "qemu/guest-random.h"
>  #include "hw/misc/bcm2835_rng.h"
>  
>  static uint32_t get_random_bytes(void)
>  {
>      uint32_t res;
> -    Error *err = NULL;
>  
> -    if (qcrypto_random_bytes((uint8_t *)&res, sizeof(res), &err) < 0) {
> -        /* On failure we don't want to return the guest a non-random
> -         * value in case they're really using it for cryptographic
> -         * purposes, so the best we can do is die here.
> -         * This shouldn't happen unless something's broken.
> -         * In theory we could implement this device's full FIFO
> -         * and interrupt semantics and then just stop filling the
> -         * FIFO. That's a lot of work, though, so we assume any
> -         * errors are systematic problems and trust that if we didn't
> -         * fail as the guest inited then we won't fail later on
> -         * mid-run.
> -         */
> -        error_report_err(err);
> -        exit(1);
> -    }
> +    /*
> +     * On failure we don't want to return the guest a non-random
> +     * value in case they're really using it for cryptographic
> +     * purposes, so the best we can do is die here.
> +     * This shouldn't happen unless something's broken.
> +     * In theory we could implement this device's full FIFO
> +     * and interrupt semantics and then just stop filling the
> +     * FIFO. That's a lot of work, though, so we assume any
> +     * errors are systematic problems and trust that if we didn't
> +     * fail as the guest inited then we won't fail later on
> +     * mid-run.
> +     */
> +    qemu_guest_getrandom_nofail(&res, sizeof(res));
>      return res;
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
