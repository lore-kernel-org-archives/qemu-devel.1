Received: from eggs.gnu.org ([209.51.188.92]:50933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gxG3R-0004L9-4u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 14:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gxFos-00055O-Dy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 13:45:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33618)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gxFos-0003nE-32
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 13:45:10 -0500
References: <20190222154454.30289-1-alex.bennee@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4181bf7b-a01e-20a1-cc04-61d2fecc5e39@redhat.com>
Date: Fri, 22 Feb 2019 19:44:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190222154454.30289-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, stappers@stappers.nl

Two trivial comments:

On 02/22/19 16:44, Alex Benn=C3=A9e wrote:
> It looks like there was going to be code to check we had some sort of
> alignment so lets replace it with an actual check. This is a bit more
> useful than the enigmatic "failed to read the initial flash content"
> when we attempt to read the number of bytes the device should have.
>=20
> This is a potential confusing stumbling block when you move from using
> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
> loading your firmware code. To mitigate that we automatically pad in
> the read-only case and warn the user when we have performed magic to
> enable things to Just Work (tm).
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
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
> ---
>  hw/block/pflash_cfi01.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 00c2efd0d7..c69ecc20a0 100644
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
> @@ -714,13 +715,6 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>      }
>      device_len =3D sector_len_per_device * blocks_per_device;
> =20
> -    /* XXX: to be fixed */
> -#if 0
> -    if (total_len !=3D (8 * 1024 * 1024) && total_len !=3D (16 * 1024 =
* 1024) &&
> -        total_len !=3D (32 * 1024 * 1024) && total_len !=3D (64 * 1024=
 * 1024))
> -        return NULL;
> -#endif
> -
>      memory_region_init_rom_device(
>          &pfl->mem, OBJECT(dev),
>          &pflash_cfi01_ops,
> @@ -747,6 +741,38 @@ static void pflash_cfi01_realize(DeviceState *dev,=
 Error **errp)
>      }
> =20
>      if (pfl->blk) {
> +        /*
> +         * Validate the backing store is the right size for pflash
> +         * devices. It should be padded to a multiple of the flash
> +         * block size. If the device is read-only we can elide the
> +         * check and just null pad the region first. If the user

(1) We no longer null-pad, but one-pad (bit-wise). I don't think it's
too confusing though.

> +         * supplies a larger file we ignore the tail.
> +         */
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
> +                memset((uint8_t*)pfl->storage + backing_len, 0xff, pad=
_bytes);
> +                warn_report("device needs %" PRIu64
> +                            " bytes, padded with %zd 0xff bytes",

(2) I think %zu would be more appropriate for size_t, but it's not a
showstopper.

> +                            total_len, pad_bytes);
> +                total_len =3D backing_len;
> +            } else {
> +                error_setg(errp, "device needs %" PRIu64 " bytes, "
> +                           "backing file provides only %" PRIu64 " byt=
es",
> +                           total_len, backing_len);
> +                return;
> +            }
> +        } else if (backing_len > total_len) {
> +            warn_report("device needs %" PRIu64 " bytes, rest ignored"=
, total_len);
> +        }
> +
>          /* read the initial flash content */
>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);
> =20
>=20

No need to repost just because of these.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo
