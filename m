Received: from eggs.gnu.org ([2001:4830:134:3::10]:35677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWIeC-00072n-Hv
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fWIe7-0007MY-Oz
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:46:28 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:45127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fWIe7-0007M9-Bt
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:46:23 -0400
Date: Fri, 22 Jun 2018 11:46:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <db277399c09b9b10c3bdc97722f2fb7b0bdfc733.1529568501.git.balaton@eik.bme.hu>
Message-ID: <alpine.BSF.2.21.1806221140350.3062@zero.eik.bme.hu>
References: <cover.1529568501.git.balaton@eik.bme.hu>
	<db277399c09b9b10c3bdc97722f2fb7b0bdfc733.1529568501.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 5/5] sm501: Fix support for non-zero frame
 buffer start address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Sebastian Bauer <mail@sebastianbauer.info>, Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 21 Jun 2018, BALATON Zoltan wrote:
> Display updates and drawing hardware cursor did not work when frame
> buffer address was non-zero. Fix this by taking the frame buffer
> address into account in these cases. This fixes screen dragging on
> AmigaOS. Based on patch by Sebastian Bauer.
>
> Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/display/sm501.c | 13 ++++++++++---
> 1 file changed, 10 insertions(+), 3 deletions(-)

I've just noticed this seems to break Linux frambuffer for some reason. I 
got this backtrace:

#0  raise () from /lib64/libc.so.6
#1  abort () from /lib64/libc.so.6
#2  qemu_get_ram_block (addr=2685665280) at exec.c:1296
#3  tlb_reset_dirty_range_all (start=2685665280, length=256000) at exec.c:1330
#4  cpu_physical_memory_snapshot_and_clear_dirty (start=2685665280, length=256000, client=0) at exec.c:1420
#5  memory_region_snapshot_and_clear_dirty (mr=0x555556b42f20, addr=2147483648, size=256000, client=0)
     at memory.c:2017
#6  sm501_update_display (opaque=0x555556b42f00) at hw/display/sm501.c:1644
#7  graphic_hw_update (con=0x555556c3e660) at ui/console.c:267
#8  sdl2_2d_refresh (dcl=0x555557076120) at ui/sdl2-2d.c:128
#9  dpy_refresh (s=0x555556c3e5f0) at ui/console.c:1658
#10 gui_update (opaque=0x555556c3e5f0) at ui/console.c:205
#11 timerlist_run_timers (timer_list=0x55555691a7e0) at util/qemu-timer.c:536
#12 qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME) at util/qemu-timer.c:547
#13 qemu_clock_run_all_timers () at util/qemu-timer.c:674
#14 main_loop_wait (nonblocking=0) at util/main-loop.c:503
#15 main_loop () at vl.c:1848
#16 main (argc=17, argv=0x7fffffffdf68, envp=0x7fffffffdff8) at vl.c:4600

with this error:

Bad ram offset a0140000

after sm501 driver in Linux is set up. Any ideas? Maybe something is not 
initialised correctly?

Regards,
BALATON Zoltan

> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
> index e426d2f..acc26f6 100644
> --- a/hw/display/sm501.c
> +++ b/hw/display/sm501.c
> @@ -578,6 +578,11 @@ static uint32_t get_local_mem_size_index(uint32_t size)
>     return index;
> }
>
> +static ram_addr_t get_fb_addr(SM501State *s, int crt)
> +{
> +    return crt ? s->dc_crt_fb_addr : s->dc_panel_fb_addr;
> +}
> +
> static inline int get_width(SM501State *s, int crt)
> {
>     int width = crt ? s->dc_crt_h_total : s->dc_panel_h_total;
> @@ -680,7 +685,8 @@ static inline void hwc_invalidate(SM501State *s, int crt)
>     start *= w * bpp;
>     end *= w * bpp;
>
> -    memory_region_set_dirty(&s->local_mem_region, start, end - start);
> +    memory_region_set_dirty(&s->local_mem_region,
> +                            get_fb_addr(s, crt) + start, end - start);
> }
>
> static void sm501_2d_operation(SM501State *s)
> @@ -1577,7 +1583,7 @@ static void sm501_update_display(void *opaque)
>     draw_hwc_line_func *draw_hwc_line = NULL;
>     int full_update = 0;
>     int y_start = -1;
> -    ram_addr_t offset = 0;
> +    ram_addr_t offset;
>     uint32_t *palette;
>     uint8_t hwc_palette[3 * 3];
>     uint8_t *hwc_src = NULL;
> @@ -1634,9 +1640,10 @@ static void sm501_update_display(void *opaque)
>     }
>
>     /* draw each line according to conditions */
> +    offset = get_fb_addr(s, crt);
>     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
>               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
> -    for (y = 0, offset = 0; y < height; y++, offset += width * src_bpp) {
> +    for (y = 0; y < height; y++, offset += width * src_bpp) {
>         int update, update_hwc;
>
>         /* check if hardware cursor is enabled and we're within its range */
>
