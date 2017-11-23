Received: from eggs.gnu.org ([2001:4830:134:3::10]:56322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrqQ-0007MZ-Jz
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:47:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHrqP-0002rr-Hm
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:47:10 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:39374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHrqP-0002rJ-Bl
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:47:09 -0500
Received: by mail-ot0-x241.google.com with SMTP id v15so16359354ote.6
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 05:47:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113173120.3686-1-michael.nawrocki@gtri.gatech.edu>
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113173120.3686-1-michael.nawrocki@gtri.gatech.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 13:46:48 +0000
Message-ID: <CAFEAcA8fA3VMCdVwZ84vRUVvBt0RbYiKZb2cxjyV9S3QrCmD6w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] Add partial flash interleaving to
 AMD CFI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 13 November 2017 at 17:31, Mike Nawrocki
<michael.nawrocki@gtri.gatech.edu> wrote:
> This mirrors the interleaving support already in place in
> pflash_cfi01.c, using the max_device_width and device_width properties.
>
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/block/pflash_cfi02.c | 244 +++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 209 insertions(+), 35 deletions(-)

Thanks for this patch. There is some code duplication from cfi01.c,
but I think it's ok not to worry about trying to share code.

>      case 0xA0:
>      case 0x10:
>      case 0x30:
>          /* Status register read */
>          ret = pfl->status;
> -        DPRINTF("%s: status %x\n", __func__, ret);
> +        for (i = pfl->device_width;
> +             i < pfl->bank_width; i += pfl->device_width) {
> +            ret = deposit64(ret, 8 * i, 8 * pfl->device_width, ret);
> +        }

This will loop forever in the legacy "device_width == 0" case,
won't it?

> +        DPRINTF("%s: status %" PRIx64 "\n", __func__, ret);
>          /* Toggle bit 6 */
>          pfl->status ^= 0x40;
>          break;
> @@ -745,7 +901,25 @@ static Property pflash_cfi02_properties[] = {
>      DEFINE_PROP_DRIVE("drive", struct pflash_t, blk),
>      DEFINE_PROP_UINT32("num-blocks", struct pflash_t, nb_blocs, 0),
>      DEFINE_PROP_UINT32("sector-length", struct pflash_t, sector_len, 0),
> -    DEFINE_PROP_UINT8("width", struct pflash_t, width, 0),
> +    /* width here is the overall width of this QEMU device in bytes.
> +     * The QEMU device may be emulating a number of flash devices
> +     * wired up in parallel; the width of each individual flash
> +     * device should be specified via device-width. If the individual
> +     * devices have a maximum width which is greater than the width
> +     * they are being used for, this maximum width should be set via
> +     * max-device-width (which otherwise defaults to device-width).
> +     * So for instance a 32-bit wide QEMU flash device made from four
> +     * 16-bit flash devices used in 8-bit wide mode would be configured
> +     * with width = 4, device-width = 1, max-device-width = 2.
> +     *
> +     * If device-width is not specified we default to backwards
> +     * compatible behaviour which is a bad emulation of two
> +     * 16 bit devices making up a 32 bit wide QEMU device. This
> +     * is deprecated for new uses of this device.

Is this correct for pflash_cfi02 ? In cfi01 you can see that our
legacy behaviour does things like jamming two ID values
together into one response because it's doing this "bad emulation
of two 16 bit devices", but I don't see similar code in cfi02,
so maybe the legacy default is something different ?

In particular, if the legacy default is actually "just looks like
a single device" and the old code's behaviour is identical to
the new code with device_width 1, we may be able to simply set
the default width to 1 and avoid the nasty back-compat hacks.
(I had to put the hacks in for cfi01 because they really are
different behaviour, and we didn't want to potentially break
the use in the pc platform.)

thanks
-- PMM
