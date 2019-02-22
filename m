Received: from eggs.gnu.org ([209.51.188.92]:42441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx6jA-0000iT-I2
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gx6j4-0002NB-81
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:02:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gx6j3-00025R-Qi
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 04:02:34 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190221184857.22434-1-alex.bennee@linaro.org>
Date: Fri, 22 Feb 2019 10:02:12 +0100
In-Reply-To: <20190221184857.22434-1-alex.bennee@linaro.org> ("Alex
	=?utf-8?Q?Benn=C3=A9e=22's?=
	message of "Thu, 21 Feb 2019 18:48:57 +0000")
Message-ID: <87lg285h7v.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] hw/block: better reporting on pflash
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
Cc: qemu-devel@nongnu.org, stappers@stappers.nl, lersek@redhat.com, armbru@redhat.com

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> It looks like there was going to be code to check we had some sort of
> alignment so lets replace it with an actual check. This is a bit more
> useful than the enigmatic "failed to read the initial flash content"
> when we attempt to read the number of bytes the device should have.
>
> This is a potential confusing stumbling block when you move from using
> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
> loading your firmware code. To mitigate that we automatically pad in
> the read-only case.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> ---
> v3
>   - tweak commit title/commentary
>   - use total_len instead of device_len for checks
>   - if the device is read-only do the padding for them
>   - accept baking_len > total_len (how to warn_report with NULL *errp?)
> ---
>  hw/block/pflash_cfi01.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 00c2efd0d7..37d7513c45 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -714,13 +714,6 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
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
> @@ -747,6 +740,27 @@ static void pflash_cfi01_realize(DeviceState *dev, E=
rror **errp)
>      }
>=20=20
>      if (pfl->blk) {
> +        /*
> +         * Validate the backing store is the right size for pflash
> +         * devices. It should be padded to a multiple of the flash
> +         * block size. If the device is read-only we can elide the
> +         * check and just null pad the region first. If the user
> +         * supplies a larger file we silently accept it.
> +         */
> +        uint64_t backing_len =3D blk_getlength(pfl->blk);
> +
> +        if (backing_len < total_len) {
> +            if (pfl->ro) {
> +                memset(pfl->storage, 0, total_len);
> +                total_len =3D backing_len;
> +            } else {
> +                error_setg(errp, "device(s) needs %" PRIu64 " bytes, "
> +                           "backing file provides only %" PRIu64 " bytes=
",
> +                           total_len, backing_len);
> +                return;
> +            }
> +        }
> +
>          /* read the initial flash content */
>          ret =3D blk_pread(pfl->blk, 0, pfl->storage, total_len);

Cases:

* (MATCH) If the image size matches the device size: accept

  Good.

* (SHORT-RO): If the image is smaller than the device, and the device is
  read-only: accept, silently pad to device size.

  New convenience feature to save you the trouble of padding the image.
  Personally, I'm wary of such conveniences; I'd rather force users to
  be explicit about their intent.  Advice, not objection.

* (SHORT-RW): If the image is smaller than the device, and the device is
  read/write: reject.

  Good.  The alternative would be "padding, and writes to the padded
  area aren't actually persistent", but that would be awful.

* (LONG) If the image is larger than the device: accept, silently ignore
  the image's extra bytes.

  I know this is what we've always done, but that doesn't make it a good
  idea.  What's the use case for silently truncating firmware images?
  Other than giving users yet another way to create guests that
  perplexingly fail to boot.
