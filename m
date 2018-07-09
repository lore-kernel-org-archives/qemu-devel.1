Received: from eggs.gnu.org ([2001:4830:134:3::10]:35672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fcZZU-0003hX-QU
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fcZZT-0004qS-OH
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:03:32 -0400
References: <20180627232951.14725-1-laurent@vivier.eu>
	<20180627232951.14725-5-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <8d1c30eb-1dc7-4ea9-08ea-660991044e5c@tuxfamily.org>
Date: Mon, 9 Jul 2018 19:03:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180627232951.14725-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 04/10] hw/m68k: add video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 28.06.2018 01:29, Laurent Vivier wrote:
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
[...]
> diff --git a/hw/display/macfb-template.h b/hw/display/macfb-template.h
> new file mode 100644
> index 0000000000..b6ae5d728f
> --- /dev/null
> +++ b/hw/display/macfb-template.h
> @@ -0,0 +1,158 @@
> +#if defined(READ_BITS)
> +#define PALETTE(i, r, g, b)                        \
> +    do {                                           \
> +        r =  s->color_palette[i * 3];              \
> +        g =  s->color_palette[i * 3 + 1];          \
> +        b =  s->color_palette[i * 3 + 2];          \
> +    } while (0)
> +
> +#if READ_BITS == 1
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = x & 7;                           \
> +        int idx = (*from >> (7 - bit)) & 1;        \
> +        r = g = b  = ((1 - idx) << 7);             \
> +        from += (bit == 7);                        \
> +    } while (0)
> +#elif READ_BITS == 2
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = (x & 3);                         \
> +        int idx = (*from >> ((3 - bit) << 1)) & 3; \
> +        PALETTE(idx, r, g, b);                     \
> +        from += (bit == 3);                        \
> +    } while (0)
> +#elif READ_BITS == 4
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        int bit = x & 1;                           \
> +        int idx = (*from >> ((1 - bit) << 2)) & 15; \
> +        PALETTE(idx, r, g, b);                     \
> +        from += (bit == 1);                        \
> +    } while (0)
> +#elif READ_BITS == 8
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        PALETTE(*from, r, g, b);                   \
> +        from++;                                    \
> +    } while (0)
> +#elif READ_BITS == 16
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        uint16_t pixel;                            \
> +        pixel = (from[0] << 8) | from[1];          \
> +        r = ((pixel >> 10) & 0x1f) << 3;           \
> +        g = ((pixel >> 5) & 0x1f) << 3;            \
> +        b = (pixel & 0x1f) << 3;                   \
> +        from += 2;                                 \
> +    } while (0)
> +#elif READ_BITS == 24
> +#define READ_PIXEL(from, x, r, g, b)               \
> +    do {                                           \
> +        r = *from++;                               \
> +        g = *from++;                               \
> +        b = *from++;                               \
> +    } while (0)
> +#else
> +#error unknown bit depth
> +#endif
> +
> +#if WRITE_BITS == 8
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *to = rgb_to_pixel8(r, g, b);              \
> +        to += 1;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 15
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint16_t *)to = rgb_to_pixel15(r, g, b); \
> +        to += 2;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 16
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint16_t *)to = rgb_to_pixel16(r, g, b); \
> +        to += 2;                                   \
> +    } while (0)
> +#elif WRITE_BITS == 24
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        uint32_t tmp = rgb_to_pixel24(r, g, b);    \
> +        *(to++) =         tmp & 0xff;              \
> +        *(to++) =  (tmp >> 8) & 0xff;              \
> +        *(to++) = (tmp >> 16) & 0xff;              \
> +    } while (0)
> +#elif WRITE_BITS == 32
> +#define WRITE_PIXEL(to, r, g, b)                   \
> +    do {                                           \
> +        *(uint32_t *)to = rgb_to_pixel32(r, g, b); \
> +        to += 4;                                   \
> +    } while (0)
> +#else
> +#error unknown bit depth
> +#endif
> +
> +static void glue(glue(glue(draw_line, READ_BITS), _), WRITE_BITS)
> +                          (MacfbState *s, uint8_t *to, uint8_t *from, int width)
> +{
> +    uint8_t r, g, b;
> +    int x;
> +    for (x = 0; x < width; x++) {
> +        READ_PIXEL(from, x, r, g, b);
> +        WRITE_PIXEL(to, r, g, b);
> +    }
> +}
> +#undef READ_BITS
> +#undef READ_PIXEL
> +#undef WRITE_PIXEL
> +
> +#elif defined(WRITE_BITS)
> +
> +#undef MACFB_RECLEVEL
> +#define MACFB_RECLEVEL 2
> +#define READ_BITS 1
> +#include "macfb-template.h"
> +#define READ_BITS 2
> +#include "macfb-template.h"
> +#define READ_BITS 4
> +#include "macfb-template.h"
> +#define READ_BITS 8
> +#include "macfb-template.h"
> +#define READ_BITS 16
> +#include "macfb-template.h"
> +#define READ_BITS 24
> +#include "macfb-template.h"
> +#undef WRITE_BITS
> +
> +#else
> +
> +#define WRITE_BITS 8
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 16
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 24
> +#include "macfb-template.h"
> +
> +#define WRITE_BITS 32
> +#include "macfb-template.h"

Not sure, but do we still need all these "destination" bit depth
nowadays? I thought QEMU only supports 32 bit depths these days?

 Thomas
