Received: from eggs.gnu.org ([2001:4830:134:3::10]:33743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWtD-0004pJ-Dq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWtC-0005Ou-Gg
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:51 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWtC-0005Nd-AW
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:59:50 -0500
Received: by mail-wr0-x22e.google.com with SMTP id l37so60370021wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:59:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <379a9021607724194b457bf562df9900993788c0.1488068248.git.balaton@eik.bme.hu>
References: <cover.1488068248.git.balaton@eik.bme.hu>
	<379a9021607724194b457bf562df9900993788c0.1488068248.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:59:28 +0000
Message-ID: <CAFEAcA8pzuQ=TbOpDQaDLjyFSUygRQ0HC+ag3z_9=mBte5pb4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 11/14] sm501: Add some more missing
 registers
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

On 10 December 2016 at 02:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> Values are not used yet, only stored to allow clients to initialise
> these without failing as long as no 2D engine function is called that
> would use the written value.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>
> v2: Fixed mask of video_control register for a read only bit
>     Changed IRQ status register to write ignored as IRQ is not implemented
>
>  hw/display/sm501.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index caa7e5c..af5e4db 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -511,6 +511,8 @@ typedef struct SM501State {
>      uint32_t dc_panel_hwc_color_1_2;
>      uint32_t dc_panel_hwc_color_3;
>
> +    uint32_t dc_video_control;
> +
>      uint32_t dc_crt_control;
>      uint32_t dc_crt_fb_addr;
>      uint32_t dc_crt_fb_offset;
> @@ -530,13 +532,20 @@ typedef struct SM501State {
>      uint32_t twoD_control;
>      uint32_t twoD_pitch;
>      uint32_t twoD_foreground;
> +    uint32_t twoD_background;
>      uint32_t twoD_stretch;
> +    uint32_t twoD_color_compare;
>      uint32_t twoD_color_compare_mask;
>      uint32_t twoD_mask;
> +    uint32_t twoD_clip_tl;
> +    uint32_t twoD_clip_br;
> +    uint32_t twoD_mono_pattern_low;
> +    uint32_t twoD_mono_pattern_high;
>      uint32_t twoD_window_width;
>      uint32_t twoD_source_base;
>      uint32_t twoD_destination_base;
> -
> +    uint32_t twoD_alpha;
> +    uint32_t twoD_wrap;
>  } SM501State;

You're still implementing almost all of these as writes to structure
fields which can never be read. Either of these:

 (1) a write function case which writes to the struct field, plus
     a read function case which returns the value in the struct field
 (2) a write function which does nothing (and no read function case,
     or a read function case which returns 0)
     [you can usually bunch these up into a lot of case FOO: which
     share a /* unimplemented, ignore writes */ body]

are OK, but a write function which writes to the struct field but
nothing ever reading that field doesn't make sense.

(You can also LOG_UNIMP for dummy stuff like this if you like, but
that's not something we insist on.)


thanks
-- PMM
