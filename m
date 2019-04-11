Received: from eggs.gnu.org ([209.51.188.92]:48337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWP3-0003pz-Cn
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWP2-0007NG-Ek
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:53 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWP2-0007Mx-5y
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:53:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so5935036wmi.0
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:53:52 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2d327473-8763-f277-9bcf-4a77d2c3698b@redhat.com>
Date: Thu, 11 Apr 2019 11:53:50 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/23] hw/misc/exynos4210_rng: Use
 qemu_guest_getrandom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org

On 3/15/19 4:26 AM, Richard Henderson wrote:
> The random number is intended for use by the guest.  As such, we should
> honor the -seed argument for reproducibility.
> 
> Cc: qemu-arm@nongnu.org
> Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/misc/exynos4210_rng.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
> index 4ecbebd2d7..0e70ffb404 100644
> --- a/hw/misc/exynos4210_rng.c
> +++ b/hw/misc/exynos4210_rng.c
> @@ -18,10 +18,10 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "crypto/random.h"
>  #include "hw/sysbus.h"
>  #include "qapi/error.h"
>  #include "qemu/log.h"
> +#include "qemu/guest-random.h"
>  
>  #define DEBUG_EXYNOS_RNG 0
>  
> @@ -109,7 +109,6 @@ static void exynos4210_rng_set_seed(Exynos4210RngState *s, unsigned int i,
>  static void exynos4210_rng_run_engine(Exynos4210RngState *s)
>  {
>      Error *err = NULL;
> -    int ret;
>  
>      /* Seed set? */
>      if ((s->reg_status & EXYNOS4210_RNG_STATUS_SEED_SETTING_DONE) == 0) {
> @@ -127,13 +126,11 @@ static void exynos4210_rng_run_engine(Exynos4210RngState *s)
>      }
>  
>      /* Get randoms */
> -    ret = qcrypto_random_bytes((uint8_t *)s->randr_value,
> -                               sizeof(s->randr_value), &err);
> -    if (!ret) {
> +    if (qemu_guest_getrandom(s->randr_value, sizeof(s->randr_value), &err)) {
> +        error_report_err(err);
> +    } else {
>          /* Notify that PRNG is ready */
>          s->reg_status |= EXYNOS4210_RNG_STATUS_PRNG_DONE;
> -    } else {
> -        error_report_err(err);
>      }
>  
>  out:
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
