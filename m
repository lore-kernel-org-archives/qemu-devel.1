Received: from eggs.gnu.org ([2001:4830:134:3::10]:44090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cej9y-0007on-M0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cej9x-0005mK-3U
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 09:05:18 -0500
Date: Fri, 17 Feb 2017 14:05:05 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170217140505.GB11399@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1487334159-19664-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1487334159-19664-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] bcm2835_rng: Use qcrypto_random_bytes()
 rather than rand()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Marcin Chojnacki <marcinch7@gmail.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Fri, Feb 17, 2017 at 12:22:39PM +0000, Peter Maydell wrote:
> Switch to using qcrypto_random_bytes() rather than rand() as
> our source of randomness for the BCM2835 RNG.
> 
> If qcrypto_random_bytes() fails, we don't want to return the guest a
> non-random value in case they're really using it for cryptographic
> purposes, so the best we can do is a fatal error.  This shouldn't
> happen unless something's broken, though.
> 
> In theory we could implement this device's full FIFO and interrupt
> semantics and then just stop filling the FIFO.  That's a lot of work,
> though, and doesn't really give a very nice diagnostic to the user
> since the guest will just seem to hang.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This patch sits on top of http://patchwork.ozlabs.org/patch/726744/
> (though for review purposes I think it's pretty self explanatory).
> The interesting question here is the failure case handling, where
> we're a bit between a rock and a hard place because we don't have
> a nice way to report it to the guest, but we don't want to return
> a non-random value either...
> 
> We should probably improve crypto/random-platform.c to use
> getentropy() if available, which would fix the "BSD or OSX
> host and not using gcrypt or gnutls" case which I think is
> the most likely cause of qcrypto_random_bytes() failing.

randopm-platform.c currentl uses /dev/urandom or /dev/random,
so that should work when GNUTLS/gcrypt are both disabled at
build time.

What would fail, is uses it from a chroot with an empty /dev
of course.

So we should definitely try getentropy/getrandom as a preferred
approach, falling back to /dev nodes only if those syscalls don't
exist in the current kenrel. Looks like I already put a TODO
comment in the file to this effect.

> 
>  hw/misc/bcm2835_rng.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> index 2242bc5..bbe903d 100644
> --- a/hw/misc/bcm2835_rng.c
> +++ b/hw/misc/bcm2835_rng.c
> @@ -9,8 +9,32 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "crypto/random.h"
>  #include "hw/misc/bcm2835_rng.h"
>  
> +static uint32_t get_random_bytes(void)
> +{
> +    uint32_t res;
> +    Error *err = NULL;
> +
> +    if (qcrypto_random_bytes((uint8_t *)&res, sizeof(res), &err) < 0) {
> +        /* On failure we don't want to return the guest a non-random
> +         * value in case they're really using it for cryptographic
> +         * purposes, so the best we can do is die here.
> +         * This shouldn't happen unless something's broken.
> +         * In theory we could implement this device's full FIFO
> +         * and interrupt semantics and then just stop filling the
> +         * FIFO. That's a lot of work, though, so we assume any
> +         * errors are systematic problems and trust that the check
> +         * on init is sufficient.
> +         */
> +        error_report_err(err);
> +        exit(1);
> +    }
> +    return res;
> +}
> +
>  static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
>                                   unsigned size)
>  {
> @@ -27,7 +51,7 @@ static uint64_t bcm2835_rng_read(void *opaque, hwaddr offset,
>          res = s->rng_status | (1 << 24);
>          break;
>      case 0x8:    /* rng_data */
> -        res = rand();
> +        res = get_random_bytes();
>          break;
>  
>      default:

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
