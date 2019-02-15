Received: from eggs.gnu.org ([209.51.188.92]:55049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gueAZ-0000hn-IA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gueAY-00009K-Md
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1gueAY-00008W-E2
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:08:46 -0500
References: <20190215122808.22301-1-alex.bennee@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <60e020d0-ad5d-6b86-e492-1d3c91c48a13@redhat.com>
Date: Fri, 15 Feb 2019 15:08:39 +0100
MIME-Version: 1.0
In-Reply-To: <20190215122808.22301-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/block: report when pflash backing
 file isn't aligned
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

On 02/15/19 13:28, Alex Benn=C3=A9e wrote:
> It looks like there was going to be code to check we had some sort of
> alignment so lets replace it with an actual check. This is a bit more
> useful than the enigmatic "failed to read the initial flash content"
> when we attempt to read the number of bytes the device should have.
>=20
> This is a potential confusing stumbling block when you move from using
> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
> loading your firmware code.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> ---
> v2
>   - use PRIu64 instead of PRId64
>   - tweaked message output
> ---
>  hw/block/pflash_cfi01.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index bffb4c40e7..7532c8d8e8 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -722,12 +722,20 @@ static void pflash_cfi01_realize(DeviceState *dev=
, Error **errp)
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
> +    /*
> +     * Validate the backing store is the right size for pflash
> +     * devices. It has to be padded to a multiple of the flash block
> +     * size.
> +     */
> +    if (pfl->blk) {
> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
> +        if (device_len !=3D backing_len) {
> +            error_setg(errp, "device needs %" PRIu64 " bytes, "
> +                       "backing file provides only %" PRIu64 " bytes",
> +                       device_len, backing_len);
> +            return;
> +        }
> +    }
> =20
>      memory_region_init_rom_device(
>          &pfl->mem, OBJECT(dev),
>=20

The word "only" implies that the file is too small. It could be too
large as well (the C expression is right, but the message doesn't
reflect it).

With the word "only" dropped, I think the message looks fine.


Also, now I've checked blk_getlength(). First, it can directly return
(-ENOMEDIUM). Second, it delegates the job to bdrv_getlength(), which
itself can return (-EFBIG). Third, bdrv_nb_sectors(), used internally,
can itself return (-ENOMEDIUM).

For me this is pretty much impossible to follow. Can we:

- use type "int64_t" for "backing_len" in the new code, AND

  - either prove (from the rest of pflash_cfi01_realize()) that
    "backing_len" is nonnegative, and then *assert* it, plus cast
    "backing_len" to uint64_t for the comparison;

  - or check for a negative "backing_len" explicitly, and if that
    happens, fail pflash_cfi01_realize() with an error message that
    reports *that* failure?

Sorry about the pedantry; I've got no clue what's happening in
blk_getlength() for real.

Thanks!
Laszlo
