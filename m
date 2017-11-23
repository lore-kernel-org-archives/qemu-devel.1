Received: from eggs.gnu.org ([2001:4830:134:3::10]:42535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHq16-0004CD-NK
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHq15-00050M-3l
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:50:04 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHq14-0004zl-S9
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:50:03 -0500
Received: by mail-oi0-x241.google.com with SMTP id z143so538418oia.10
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 03:50:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171113161446.2862-3-michael.nawrocki@gtri.gatech.edu>
References: <20171113161446.2862-1-michael.nawrocki@gtri.gatech.edu>
	<20171113161446.2862-3-michael.nawrocki@gtri.gatech.edu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 11:49:41 +0000
Message-ID: <CAFEAcA8w2PCKyGfPZyoQ1LLiMkEHpyDQv6-nz8voNsVJ_0Fv-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/3] Enable 8-byte wide access to AMD
 CFI devices
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

On 13 November 2017 at 16:14, Mike Nawrocki
<michael.nawrocki@gtri.gatech.edu> wrote:
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  hw/block/pflash_cfi02.c | 143 ++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 102 insertions(+), 41 deletions(-)
>
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index a81df913f6..29eb0429a3 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -18,7 +18,7 @@
>   */
>
>  /*
> - * For now, this code can emulate flashes of 1, 2 or 4 bytes width.
> + * For now, this code can emulate flashes of 1, 2, 4, or 8 bytes width.
>   * Supported commands/modes are:
>   * - flash read
>   * - flash write
> @@ -138,11 +138,72 @@ static void pflash_timer (void *opaque)
>      pfl->cmd = 0;
>  }
>
> +static uint64_t _flash_read(pflash_t *pfl, hwaddr offset,
> +                            int width, int be)

Don't use leading underscores in function names, please --
they are reserved for the system (C library, etc).

> +{
> +    /* Flash area read */
> +    uint64_t ret = 0;
> +    uint8_t *p = pfl->storage;
> +
> +    switch (width) {
> +    case 1:
> +        ret = p[offset];
> +        /* DPRINTF("%s: data offset %08x %02x\n", __func__, offset, ret); */
> +        break;
> +    case 2:
> +        if (be) {
> +            ret = p[offset] << 8;
> +            ret |= p[offset + 1];
> +        } else {
> +            ret = p[offset];
> +            ret |= p[offset + 1] << 8;
> +        }
> +        /* DPRINTF("%s: data offset %08x %04x\n", __func__, offset, ret); */
> +        break;
> +    case 4:
> +        if (be) {
> +            ret = p[offset] << 24;
> +            ret |= p[offset + 1] << 16;
> +            ret |= p[offset + 2] << 8;
> +            ret |= p[offset + 3];
> +        } else {
> +            ret = p[offset];
> +            ret |= p[offset + 1] << 8;
> +            ret |= p[offset + 2] << 16;
> +            ret |= p[offset + 3] << 24;
> +        }
> +        /* DPRINTF("%s: data offset %08x %08x\n", __func__, offset, ret); */
> +        break;
> +    case 8:
> +        if (be) {
> +            ret = (uint64_t)p[offset] << 56;
> +            ret |= (uint64_t)p[offset + 1] << 48;
> +            ret |= (uint64_t)p[offset + 2] << 40;
> +            ret |= (uint64_t)p[offset + 3] << 32;
> +            ret |= (uint64_t)p[offset + 4] << 24;
> +            ret |= (uint64_t)p[offset + 5] << 16;
> +            ret |= (uint64_t)p[offset + 6] << 8;
> +            ret |= (uint64_t)p[offset + 7];
> +        } else {
> +            ret = (uint64_t)p[offset];
> +            ret |= (uint64_t)p[offset + 1] << 8;
> +            ret |= (uint64_t)p[offset + 2] << 16;
> +            ret |= (uint64_t)p[offset + 3] << 24;
> +            ret |= (uint64_t)p[offset + 4] << 32;
> +            ret |= (uint64_t)p[offset + 5] << 40;
> +            ret |= (uint64_t)p[offset + 6] << 48;
> +            ret |= (uint64_t)p[offset + 7] << 56;
> +        }
> +        break;
> +    }

This can be rewritten in a shorter and clearer way using
the ld*_le_p() and ld*_be_p() functions, eg case 4 is

    ret = be ? ldl_be_p(p + offset) : ldl_le_p(p + offset);


case 2 uses lduw_be_p() and lduw_le_p(), case 8 uses
ldq_be_p() and ldq_le_p().

case 1 is just
    ret = ldub_p(p + offset);
because there's no endianness issue for 1 byte.


> +
> +    return ret;
> +}
> +
>  static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
>                              int width, int be)
>  {
>      hwaddr boff;
> -    uint8_t *p;
>      uint64_t ret;
>
>      DPRINTF("%s: offset " TARGET_FMT_plx "\n", __func__, offset);
> @@ -158,6 +219,8 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
>          boff = boff >> 1;
>      else if (pfl->width == 4)
>          boff = boff >> 2;
> +    else if (pfl->width == 8)
> +        boff = boff >> 3;

If you run this patch through scripts/checkpatch.pl it should tell
you that our coding style would like you to put braces on this if.
Our usual practice is that if you're touching an existing statement
that isn't in line with our coding style you should fix at least the
parts checkpatch complains about (ie add {} to all the arms of the
if, here).

>      switch (pfl->cmd) {
>      default:
>          /* This should never happen : reset state & treat it as a read*/
> @@ -170,37 +233,7 @@ static uint64_t pflash_read(pflash_t *pfl, hwaddr offset,
>      case 0x00:
>      flash_read:
>          /* Flash area read */
> -        p = pfl->storage;
> -        switch (width) {
> -        case 1:
> -            ret = p[offset];
> -//            DPRINTF("%s: data offset %08x %02x\n", __func__, offset, ret);
> -            break;
> -        case 2:
> -            if (be) {
> -                ret = p[offset] << 8;
> -                ret |= p[offset + 1];
> -            } else {
> -                ret = p[offset];
> -                ret |= p[offset + 1] << 8;
> -            }
> -//            DPRINTF("%s: data offset %08x %04x\n", __func__, offset, ret);
> -            break;
> -        case 4:
> -            if (be) {
> -                ret = p[offset] << 24;
> -                ret |= p[offset + 1] << 16;
> -                ret |= p[offset + 2] << 8;
> -                ret |= p[offset + 3];
> -            } else {
> -                ret = p[offset];
> -                ret |= p[offset + 1] << 8;
> -                ret |= p[offset + 2] << 16;
> -                ret |= p[offset + 3] << 24;
> -            }
> -//            DPRINTF("%s: data offset %08x %08x\n", __func__, offset, ret);
> -            break;
> -        }
> +        ret = _flash_read(pfl, offset, width, be);
>          break;
>      case 0x90:
>          /* flash ID read */
> @@ -260,8 +293,8 @@ static void pflash_update(pflash_t *pfl, int offset,
>      }
>  }
>
> -static void pflash_write (pflash_t *pfl, hwaddr offset,
> -                          uint64_t value, int width, int be)
> +static void pflash_write(pflash_t *pfl, hwaddr offset,
> +                         uint64_t value, int width, int be)
>  {
>      hwaddr boff;
>      uint8_t *p;
> @@ -275,17 +308,19 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>  #endif
>          goto reset_flash;
>      }
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d %d\n", __func__,
> -            offset, value, width, pfl->wcycle);
> +    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d %d\n",
> +            __func__, offset, value, width, pfl->wcycle);
>      offset &= pfl->chip_len - 1;
>
> -    DPRINTF("%s: offset " TARGET_FMT_plx " %08x %d\n", __func__,
> -            offset, value, width);
> +    DPRINTF("%s: offset " TARGET_FMT_plx " %08" PRIx64 " %d\n",
> +            __func__, offset, value, width);
>      boff = offset & (pfl->sector_len - 1);
>      if (pfl->width == 2)
>          boff = boff >> 1;
>      else if (pfl->width == 4)
>          boff = boff >> 2;
> +    else if (pfl->width == 8)
> +        boff = boff >> 3;
>      switch (pfl->wcycle) {
>      case 0:
>          /* Set the device in I/O access mode if required */
> @@ -346,8 +381,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              /* We need another unlock sequence */
>              goto check_unlock0;
>          case 0xA0:
> -            DPRINTF("%s: write data offset " TARGET_FMT_plx " %08x %d\n",
> -                    __func__, offset, value, width);
> +            DPRINTF("%s: write data offset " TARGET_FMT_plx
> +                    " %08" PRIx64 " %d\n", __func__, offset, value, width);
>              p = pfl->storage;
>              if (!pfl->ro) {
>                  switch (width) {
> @@ -379,6 +414,28 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>                      }
>                      pflash_update(pfl, offset, 4);
>                      break;
> +                case 8:
> +                    if (be) {
> +                        p[offset] &= value >> 56;
> +                        p[offset + 1] &= value >> 48;
> +                        p[offset + 2] &= value >> 40;
> +                        p[offset + 3] &= value >> 32;
> +                        p[offset + 4] &= value >> 24;
> +                        p[offset + 5] &= value >> 16;
> +                        p[offset + 6] &= value >> 8;
> +                        p[offset + 7] &= value;
> +                    } else {
> +                        p[offset] &= value;
> +                        p[offset + 1] &= value >> 8;
> +                        p[offset + 2] &= value >> 16;
> +                        p[offset + 3] &= value >> 24;
> +                        p[offset + 4] &= value >> 32;
> +                        p[offset + 5] &= value >> 40;
> +                        p[offset + 6] &= value >> 48;
> +                        p[offset + 7] &= value >> 56;
> +                    }
> +                    pflash_update(pfl, offset, 8);
> +                    break;
>                  }

Similarly here we can use
   if (be) {
       uint64_t oldv = ldq_be_p(p + offset);
       stq_be_p(p + offset, oldv & value);
   } else {
       ...ditto with _le_
   }

Other than those minor issues, patch looks good.

thanks
-- PMM
