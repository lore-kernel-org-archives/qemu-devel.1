Received: from eggs.gnu.org ([2001:4830:134:3::10]:51775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXtx-0007qZ-JT
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:04:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjXtw-0005o6-C4
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:04:41 -0500
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjXtw-0005nd-6h
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:04:40 -0500
Received: by mail-wm0-x235.google.com with SMTP id t193so1387059wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 13:04:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<6b70a9dfe56c3a0dc8e874c45d70612aff7b8e3a.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 21:04:18 +0000
Message-ID: <CAFEAcA9FL-sshVzKewf+rCs6-5_c2Y86Qy0b=3DMog4MrVOpwA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 07/14] sm501: Fix device endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>

On 25 February 2017 at 18:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v2: Split off small clean up to other patch
>
>  hw/display/sm501.c          |  6 +++---
>  hw/display/sm501_template.h | 23 ++++++++++++++---------
>  2 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index b977094..2694081 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -849,7 +849,7 @@ static const MemoryRegionOps sm501_system_config_ops = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
>  static uint32_t sm501_palette_read(void *opaque, hwaddr addr)
> @@ -1085,7 +1085,7 @@ static const MemoryRegionOps sm501_disp_ctrl_ops = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
>  static uint64_t sm501_2d_engine_read(void *opaque, hwaddr addr,
> @@ -1173,7 +1173,7 @@ static const MemoryRegionOps sm501_2d_engine_ops = {
>          .min_access_size = 4,
>          .max_access_size = 4,
>      },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
>  /* draw line functions for all console modes */
> diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
> index 832ee61..6e56baf 100644
> --- a/hw/display/sm501_template.h
> +++ b/hw/display/sm501_template.h
> @@ -64,10 +64,16 @@ static void glue(draw_line16_, PIXEL_NAME)(
>      uint8_t r, g, b;
>
>      do {
> -        rgb565 = lduw_p(s);
> -        r = ((rgb565 >> 11) & 0x1f) << 3;
> -        g = ((rgb565 >>  5) & 0x3f) << 2;
> -        b = ((rgb565 >>  0) & 0x1f) << 3;
> +        rgb565 = lduw_le_p(s);
> +#if defined(TARGET_WORDS_BIGENDIAN)
> +        r = (rgb565 >> 8) & 0xf8;
> +        g = (rgb565 >> 3) & 0xfc;
> +        b = (rgb565 << 3) & 0xf8;
> +#else
> +        b = (rgb565 >> 8) & 0xf8;
> +        g = (rgb565 >> 3) & 0xfc;
> +        r = (rgb565 << 3) & 0xf8;
> +#endif
>          *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
>          s += 2;
>          d += BPP;
> @@ -80,15 +86,14 @@ static void glue(draw_line32_, PIXEL_NAME)(
>      uint8_t r, g, b;
>
>      do {
> -        ldub_p(s);
>  #if defined(TARGET_WORDS_BIGENDIAN)
> +        r = s[0];
> +        g = s[1];
> +        b = s[2];
> +#else
>          r = s[1];
>          g = s[2];
>          b = s[3];
> -#else
> -        b = s[0];
> -        g = s[1];
> -        r = s[2];
>  #endif
>          *(PIXEL_TYPE *)d = glue(rgb_to_pixel, PIXEL_NAME)(r, g, b);
>          s += 4;

I still suspect this is not correct. In particular, if you
look at the Linux driver:

http://lxr.free-electrons.com/source/drivers/video/fbdev/sm501fb.c#L341

we have for 32 bit two layouts within a 32-bit word:
 BGRX (if "swap fb endian" is set)
 XRGB (the usual)
(plus the cross-product with "32-bit load is BE or LE",
since we've coded this as byte accesses rather than a ldl_*_p()).

and for 16 bit we have either RGB or BGR ordering.
I'm not completely sure this lines up with the code you have.

Looking at how the SWAP_FB_ENDIAN flag gets set:
 * for the r2d board it is set always
 * for PCI devices, it is set only if big-endian

I suspect that what we actually have here is something
like:
 * for the PCI device it's always little endian (and the
   code ought not to need to depend on TARGET_WORDS_BIGENDIAN)
 * sysbus device may be more complicated

Also I note there's an SM501_ENDIAN_CONTROL register on the
device, which presumably if written changes the behaviour.

Plus for the sysbus device if we change the settings to
DEVICE_LITTLE_ENDIAN for the various control register
regions that suggests we should be consistent about the
serial_mm_init() endian order and also the USB controller.

It's late evening here though so I can't investigate any
further right now.

thanks
-- PMM
