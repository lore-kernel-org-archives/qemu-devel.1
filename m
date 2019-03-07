Received: from eggs.gnu.org ([209.51.188.92]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pOu-00049O-Uy
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1pOt-00025m-8G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:33:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1pOr-00024s-8d
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 04:33:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190227111347.15063-1-alex.bennee@linaro.org>
Date: Thu, 07 Mar 2019 10:33:09 +0100
In-Reply-To: <20190227111347.15063-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Wed, 27 Feb 2019 11:13:47 +0000")
Message-ID: <87wolbt4fe.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

One more thing...

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> It looks like there was going to be code to check we had some sort of
> alignment so lets replace it with an actual check. This is a bit more
> useful than the enigmatic "failed to read the initial flash content"
> when we attempt to read the number of bytes the device should have.
>
> This is a potential confusing stumbling block when you move from using
> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
> loading your firmware code. To mitigate that we automatically pad in
> the read-only case and warn the user when we have performed magic to
> enable things to Just Work (tm).
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>
> ---
> v3
>   - tweak commit title/commentary
>   - use total_len instead of device_len for checks
>   - if the device is read-only do the padding for them
>   - accept baking_len > total_len (how to warn_report with NULL *errp?)
> v4
>   - error check blk_getlength
>   - optimise memset and use NOR erase pattern
>   - restore singular device (overly confusing)
>   - add warn_report for when we do magic
> v5
>   - remove mention of null padding
>   - use %zu for size_t fmt string
>   - add Laszlo r-b
> ---
>  hw/block/pflash_cfi01.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9d1c356eb6..d8cfa4789a 100644
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
>=20=20
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
> @@ -763,6 +757,38 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      }
>=20=20
>      if (pfl->blk) {
> +        /*
> +         * Validate the backing store is the right size for pflash
> +         * devices. It should be padded to a multiple of the flash
> +         * block size. If the device is read-only we can elide the
> +         * check and just pad the region first. If the user supplies a
> +         * larger file we ignore the tail.
> +         */

I can't see how "It should be padded to a multiple of the flash block
size" is related to the code you add.

> +        int64_t backing_len =3D blk_getlength(pfl->blk);
> +        if (backing_len < 0) {
> +            error_setg(errp, "unable to check size of backing file");
> +            return;
> +        }
> +
> +        if (backing_len < total_len) {
> +            if (pfl->ro) {
> +                size_t pad_bytes =3D total_len - backing_len;
> +                /* pad with NOR erase pattern */
> +                memset((uint8_t*)pfl->storage + backing_len, 0xff, pad_b=
ytes);
> +                warn_report("device needs %" PRIu64
> +                            " bytes, padded with %zu 0xff bytes",
> +                            total_len, pad_bytes);
> +                total_len =3D backing_len;
> +            } else {
> +                error_setg(errp, "device needs %" PRIu64 " bytes, "
> +                           "backing file provides only %" PRIu64 " bytes=
",
> +                           total_len, backing_len);
> +                return;
> +            }
> +        } else if (backing_len > total_len) {
> +            warn_report("device needs %" PRIu64 " bytes, rest ignored", =
total_len);
> +        }
> +
>          /* read the initial flash content */
>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
