Received: from eggs.gnu.org ([2001:4830:134:3::10]:40749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coUC9-0006gz-Aw
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:07:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coUC3-0007bX-2m
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:07:53 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coUC2-0007Ze-PU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:07:46 -0400
Received: by mail-wm0-x22d.google.com with SMTP id n11so110163784wma.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:07:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316120110.11677-2-iwona260909@gmail.com>
References: <20170316120110.11677-1-iwona260909@gmail.com>
	<20170316120110.11677-2-iwona260909@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 12:07:25 +0000
Message-ID: <CAFEAcA8ZBAAqYNbh_3J69W5SMXRsbW4S367Xe8ceF1C0M-RNnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Dead code removal: removing code for
 unsupported DEPTH.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: iwona260909@gmail.com
Cc: QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On 16 March 2017 at 12:01,  <iwona260909@gmail.com> wrote:
> From: Iwona Kotlarska <iwona260909@gmail.com>
>
> Signed-off-by: Iwona Kotlarska <iwona260909@gmail.com>

Thanks -- cc'ing Gerd who's just done some cirrus patches and
is probably best placed to review this.

PS: if you put "cirrus_vga:" in your patch subject then it
helps people to know what part of QEMU your patch is affecting.

-- PMM

> ---
>  hw/display/cirrus_vga.c      |  3 ---
>  hw/display/cirrus_vga_rop.h  |  9 ---------
>  hw/display/cirrus_vga_rop2.h | 46 ++------------------------------------------
>  3 files changed, 2 insertions(+), 56 deletions(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index b9e7cb1df1..efa9609ccd 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -478,9 +478,6 @@ static const cirrus_bitblt_rop_t cirrus_bkwd_transp_rop[16][2] = {
>  };
>
>  #define ROP2(name) {\
> -    name ## _8,\
> -    name ## _16,\
> -    name ## _24,\
>      name ## _32,\
>          }
>
> diff --git a/hw/display/cirrus_vga_rop.h b/hw/display/cirrus_vga_rop.h
> index 0925a009fe..f175c808cc 100644
> --- a/hw/display/cirrus_vga_rop.h
> +++ b/hw/display/cirrus_vga_rop.h
> @@ -189,15 +189,6 @@ glue(glue(cirrus_bitblt_rop_bkwd_transp_, ROP_NAME),_16)(CirrusVGAState *s,
>      }
>  }
>
> -#define DEPTH 8
> -#include "cirrus_vga_rop2.h"
> -
> -#define DEPTH 16
> -#include "cirrus_vga_rop2.h"
> -
> -#define DEPTH 24
> -#include "cirrus_vga_rop2.h"
> -
>  #define DEPTH 32
>  #include "cirrus_vga_rop2.h"
>
> diff --git a/hw/display/cirrus_vga_rop2.h b/hw/display/cirrus_vga_rop2.h
> index d28bcc6f25..adf0f30a94 100644
> --- a/hw/display/cirrus_vga_rop2.h
> +++ b/hw/display/cirrus_vga_rop2.h
> @@ -22,15 +22,8 @@
>   * THE SOFTWARE.
>   */
>
> -#if DEPTH == 8
> -#define PUTPIXEL()    ROP_OP(&d[0], col)
> -#elif DEPTH == 16
> -#define PUTPIXEL()    ROP_OP_16((uint16_t *)&d[0], col)
> -#elif DEPTH == 24
> -#define PUTPIXEL()    ROP_OP(&d[0], col);        \
> -                      ROP_OP(&d[1], (col >> 8)); \
> -                      ROP_OP(&d[2], (col >> 16))
> -#elif DEPTH == 32
> +
> +#if DEPTH == 32
>  #define PUTPIXEL()    ROP_OP_32(((uint32_t *)&d[0]), col)
>  #else
>  #error unsupported DEPTH
> @@ -47,41 +40,16 @@ glue(glue(glue(cirrus_patternfill_, ROP_NAME), _),DEPTH)
>      int x, y, pattern_y, pattern_pitch, pattern_x;
>      unsigned int col;
>      const uint8_t *src1;
> -#if DEPTH == 24
> -    int skipleft = s->vga.gr[0x2f] & 0x1f;
> -#else
>      int skipleft = (s->vga.gr[0x2f] & 0x07) * (DEPTH / 8);
> -#endif
> -
> -#if DEPTH == 8
> -    pattern_pitch = 8;
> -#elif DEPTH == 16
> -    pattern_pitch = 16;
> -#else
>      pattern_pitch = 32;
> -#endif
>      pattern_y = s->cirrus_blt_srcaddr & 7;
>      for(y = 0; y < bltheight; y++) {
>          pattern_x = skipleft;
>          d = dst + skipleft;
>          src1 = src + pattern_y * pattern_pitch;
>          for (x = skipleft; x < bltwidth; x += (DEPTH / 8)) {
> -#if DEPTH == 8
> -            col = src1[pattern_x];
> -            pattern_x = (pattern_x + 1) & 7;
> -#elif DEPTH == 16
> -            col = ((uint16_t *)(src1 + pattern_x))[0];
> -            pattern_x = (pattern_x + 2) & 15;
> -#elif DEPTH == 24
> -            {
> -                const uint8_t *src2 = src1 + pattern_x * 3;
> -                col = src2[0] | (src2[1] << 8) | (src2[2] << 16);
> -                pattern_x = (pattern_x + 1) & 7;
> -            }
> -#else
>              col = ((uint32_t *)(src1 + pattern_x))[0];
>              pattern_x = (pattern_x + 4) & 31;
> -#endif
>              PUTPIXEL();
>              d += (DEPTH / 8);
>          }
> @@ -104,13 +72,8 @@ glue(glue(glue(cirrus_colorexpand_transp_, ROP_NAME), _),DEPTH)
>      unsigned int col;
>      unsigned bitmask;
>      unsigned index;
> -#if DEPTH == 24
> -    int dstskipleft = s->vga.gr[0x2f] & 0x1f;
> -    int srcskipleft = dstskipleft / 3;
> -#else
>      int srcskipleft = s->vga.gr[0x2f] & 0x07;
>      int dstskipleft = srcskipleft * (DEPTH / 8);
> -#endif
>
>      if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
>          bits_xor = 0xff;
> @@ -187,13 +150,8 @@ glue(glue(glue(cirrus_colorexpand_pattern_transp_, ROP_NAME), _),DEPTH)
>      int x, y, bitpos, pattern_y;
>      unsigned int bits, bits_xor;
>      unsigned int col;
> -#if DEPTH == 24
> -    int dstskipleft = s->vga.gr[0x2f] & 0x1f;
> -    int srcskipleft = dstskipleft / 3;
> -#else
>      int srcskipleft = s->vga.gr[0x2f] & 0x07;
>      int dstskipleft = srcskipleft * (DEPTH / 8);
> -#endif
>
>      if (s->cirrus_blt_modeext & CIRRUS_BLTMODEEXT_COLOREXPINV) {
>          bits_xor = 0xff;
> --
> 2.12.0
>
>
