Received: from eggs.gnu.org ([209.51.188.92]:53823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwvPQ-0004MO-77
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gwvB2-00082m-Ci
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:42:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gwvB2-0007zc-4k
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 15:42:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so10546983wmh.3
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 12:42:34 -0800 (PST)
References: <20190221184857.22434-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ba41c9b-05a0-acfe-e621-10f43048c874@redhat.com>
Date: Thu, 21 Feb 2019 21:42:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190221184857.22434-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: stappers@stappers.nl, lersek@redhat.com, armbru@redhat.com

Hi Alex,

On 2/21/19 7:48 PM, Alex Bennée wrote:
> It looks like there was going to be code to check we had some sort of
> alignment so lets replace it with an actual check. This is a bit more
> useful than the enigmatic "failed to read the initial flash content"
> when we attempt to read the number of bytes the device should have.
> 
> This is a potential confusing stumbling block when you move from using
> -bios to using -drive if=pflash,file=blob,format=raw,readonly for
> loading your firmware code. To mitigate that we automatically pad in
> the read-only case.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
> @@ -714,13 +714,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      }
>      device_len = sector_len_per_device * blocks_per_device;
>  
> -    /* XXX: to be fixed */
> -#if 0
> -    if (total_len != (8 * 1024 * 1024) && total_len != (16 * 1024 * 1024) &&
> -        total_len != (32 * 1024 * 1024) && total_len != (64 * 1024 * 1024))
> -        return NULL;
> -#endif
> -
>      memory_region_init_rom_device(
>          &pfl->mem, OBJECT(dev),
>          &pflash_cfi01_ops,
> @@ -747,6 +740,27 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      }
>  
>      if (pfl->blk) {
> +        /*
> +         * Validate the backing store is the right size for pflash
> +         * devices. It should be padded to a multiple of the flash
> +         * block size. If the device is read-only we can elide the
> +         * check and just null pad the region first. If the user
> +         * supplies a larger file we silently accept it.
> +         */
> +        uint64_t backing_len = blk_getlength(pfl->blk);
> +
> +        if (backing_len < total_len) {
> +            if (pfl->ro) {
> +                memset(pfl->storage, 0, total_len);

When you erasing a NOR flash sector, all bits are set to 1.
Then you can program a word by setting its bits to 0.
It is not possible to set bits from 0 to 1 on a word boundary,
it is only possible to set bits to 1 by erasing a whole sector (sector
boundary).

The pflash QEMU models are of NOR type (is different for other flash
technologies).
If we want to set the padded area to the fabric blank state, we should
use the NOR flash erased value of 0xff.

> +                total_len = backing_len;
> +            } else {
> +                error_setg(errp, "device(s) needs %" PRIu64 " bytes, "
> +                           "backing file provides only %" PRIu64 " bytes",
> +                           total_len, backing_len);
> +                return;
> +            }
> +        }
> +
>          /* read the initial flash content */
>          ret = blk_pread(pfl->blk, 0, pfl->storage, total_len);
>  
> 
