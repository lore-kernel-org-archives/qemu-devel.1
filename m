Received: from eggs.gnu.org ([2001:4830:134:3::10]:42442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAyE-00031Q-5X
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAyB-0006br-01
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:34:38 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:41323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fWAyA-0006bc-RE
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:34:34 -0400
Received: by mail-qt0-x22d.google.com with SMTP id y20-v6so4688490qto.8
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 18:34:34 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<bbdbc993bc9e492916abce1f2a5857f0227e2720.1529568501.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d2dc29e-09b4-7d7e-493f-152613d0d0c0@amsat.org>
Date: Thu, 21 Jun 2018 22:34:30 -0300
MIME-Version: 1.0
In-Reply-To: <bbdbc993bc9e492916abce1f2a5857f0227e2720.1529568501.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>

On 06/21/2018 05:08 AM, BALATON Zoltan wrote:
> From: Sebastian Bauer <mail@sebastianbauer.info>
> 
> Changing the palette of a color index has as an immediate effect on
> all pixels with the corresponding index on real hardware. Performing a
> full update after a palette change is a simple way to emulate this
> effect.
> 
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> 
> Notes:
>     v4: Updated commit message
> 
>  hw/display/sm501.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index 0625cf5..a2ee6e3 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -479,6 +479,7 @@ typedef struct SM501State {
>      MemoryRegion twoD_engine_region;
>      uint32_t last_width;
>      uint32_t last_height;
> +    uint32_t do_full_update; /* perform a full update next time */

Can this be a bool?

>      I2CBus *i2c_bus;
>  
>      /* mmio registers */
> @@ -1032,6 +1033,7 @@ static void sm501_palette_write(void *opaque, hwaddr addr,
>  
>      assert(range_covers_byte(0, 0x400 * 3, addr));
>      *(uint32_t *)&s->dc_palette[addr] = value;
> +    s->do_full_update = 1;
>  }
>  
>  static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
> @@ -1620,6 +1622,12 @@ static void sm501_update_display(void *opaque)
>          full_update = 1;
>      }
>  
> +    /* someone else requested a full update */
> +    if (s->do_full_update) {
> +        s->do_full_update = 0;
> +        full_update = 1;
> +    }
> +
>      /* draw each line according to conditions */
>      snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
>                offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
> 
