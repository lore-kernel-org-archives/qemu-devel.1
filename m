Received: from eggs.gnu.org ([2001:4830:134:3::10]:59030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckr6c-00070t-HT
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ckr6b-0005hV-Ac
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:47:10 -0500
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37955)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ckr6b-0005gk-28
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 06:47:09 -0500
Received: by mail-wm0-x22c.google.com with SMTP id t193so62018420wmt.1
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:47:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6003064214f099ab5ec9625e356543b22f01b9cf.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
	<6003064214f099ab5ec9625e356543b22f01b9cf.1488665935.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Mar 2017 11:46:47 +0000
Message-ID: <CAFEAcA9Ux+sLonQU+JWCExmDAt7BFzWWWGC08pKdo5RJWmhNRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v4 07/13] sm501: Fix device endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 25 February 2017 at 18:46, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> We only emulate the sysbus device in its default LE mode and PCI is LE
> as well so specify this for registers. Colors were also off on both
> SH4 and PPC which is also fixed here.

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

This says "the pixel in the framebuffer is little endian. If
the guest CPU is bigendian then the pixel format is RGB565;
otherwise it's BGR565". (This difference isn't a simple
endianness thing because the G pixel crosses the boundary
between two bytes.)

In the Linux kernel driver source, these two formats
correspond to "SWAP_FB_ENDIAN set" (BGR565) and not set
(RGB565), and the swap flag is set for BE PCI and for
(LE) embedded sh. I'm not convinced by that code though,
because the comment claims it's for handling an IO layer
swap that makes the PCI bus little endian, but that can't
make RGB565 turn into BGR565. See also kernel commit
fedbb3625b3c1644 which also says that code is wrong.
So I would not trust the kernel driver as a guide to the
right behaviour for 16 bit formats: it is clearly buggy.

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

This says "the pixel in the framebuffer is 32-bits always
little endian. If the guest CPU is bigendian then the
pixel format is XBGR; otherwise it's RGBX".

This is also saying the hardware behaves differently
for big and little endian guest CPUs, but in a different
way from 16 bit (both in whether big or little gets
the RGB order and in whether the other order is a
straight "all the fields in reverse order" or not).
That seems even less likely.

In the Linux kernel, "SWAP_FB_ENDIAN" flag set gets
us BGRX; not set gets us XRGB.

I think the correct behaviour here is for 16 bits:
        rgb565 = lduw_le_p(s);
        r = (rgb565 >> 8) & 0xf8;
        g = (rgb565 >> 3) & 0xfc;
        b = (rgb565 << 3) & 0xf8;

ie "always LE framebuffer, RGB565"
and for 32 bits:
        r = s[2];
        g = s[1];
        b = s[0];
ie "always LE framebuffer, XRGB8888".

That makes sense, and it matches what the hardware
claims it does. I would recommend implementing that, unless
it doesn't work for some bit of guest software that you can
100% guarantee does display correctly on real hardware.

If it doesn't work on a particular bit of guest software
then that is quite likely guest software error
because nobody really thoroughly tested the driver
code a decade ago and nobody has the hardware now
to test the driver against.

The sm501 x.org driver appears to have been independently
implemented, so might be an interesting thing to test.

(Yes, trying to sort out a model of ancient hardware so it's
accurate sucks. If you can find a real copy of the hardware
so you can cross-check what it really does that's about
the only way to be sure about things.)

thanks
-- PMM
