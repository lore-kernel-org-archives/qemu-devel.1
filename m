Received: from eggs.gnu.org ([209.51.188.92]:56131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1uat-0002lP-VQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:06:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h1uas-0006a9-0F
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:05:59 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:34587)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h1uaq-0006Wg-2I
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:05:56 -0500
Received: by mail-wr1-x442.google.com with SMTP id f14so17819324wrg.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:05:54 -0800 (PST)
References: <20190307093723.655-1-armbru@redhat.com>
	<20190307093723.655-2-armbru@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190307093723.655-2-armbru@redhat.com>
Date: Thu, 07 Mar 2019 15:05:52 +0000
Message-ID: <87pnr2g1wv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 1/4] hw/block: better reporting on
 pflash backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, lersek@redhat.com, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org


Markus Armbruster <armbru@redhat.com> writes:

> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> It looks like there was going to be code to check we had some sort of
> alignment so let's replace it with an actual check.  Reject undersized
> images with "device needs N bytes, backing file provides only M
> bytes".  This is a bit more useful than the enigmatic "failed to read
> the initial flash content" when we attempt to read the number of bytes
> the device should have.  Continue to accept oversized images, but warn
> "device needs N bytes, rest ignored".
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9d1c356eb6..75ce8ef489 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -45,6 +45,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/host-utils.h"
>  #include "qemu/log.h"
> +#include "qemu/error-report.h"
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> @@ -730,13 +731,6 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      }
>      device_len =3D sector_len_per_device * blocks_per_device;
>
> -    /* XXX: to be fixed */
> -#if 0
> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 * =
1024) &&
> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024 *=
 1024))
> -        return NULL;
> -#endif
> -
>      memory_region_init_rom_device(
>          &pfl->mem, OBJECT(dev),
>          &pflash_cfi01_ops,
> @@ -763,6 +757,27 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      }
>
>      if (pfl->blk) {
> +        /*
> +         * Validate the backing store is the right size for pflash
> +         * devices. If the user supplies a larger file we ignore the
> +         * tail.
> +         */
> +        int64_t backing_len =3D blk_getlength(pfl->blk);
> +        if (backing_len < 0) {
> +            error_setg(errp, "unable to check size of backing file");
> +            return;
> +        }
> +
> +        if (backing_len < total_len) {
> +            error_setg(errp, "device needs %" PRIu64 " bytes, "
> +                       "backing file provides only %" PRIu64 " bytes",
> +                       total_len, backing_len);
> +            return;
> +        } else if (backing_len > total_len) {
> +            warn_report("device needs %" PRIu64 " bytes, rest ignored",
> +                        total_len);
> +        }

As discussed elsewhere I'm happy for this just to error out with a
useful error message.

> +
>          /* read the initial flash content */
>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);


--
Alex Benn=C3=A9e
