Received: from eggs.gnu.org ([2001:4830:134:3::10]:50173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d84hk-0004L3-7Y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1d84hg-0004FL-AQ
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:57:28 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1d84hg-0004Dv-3z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:57:24 -0400
Received: by mail-ua0-f178.google.com with SMTP id e28so7439883uah.0
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 05:57:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170421091632.30900-5-kraxel@redhat.com>
References: <20170421091632.30900-1-kraxel@redhat.com>
	<20170421091632.30900-5-kraxel@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Tue, 9 May 2017 14:57:22 +0200
Message-ID: <CABdb736fuqG1LhZYmxaZ_GMXXjTwKrQGs4M2h1Juwo=ObdyWNA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 4/9] vga: make display updates thread safe.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Hi Gerd,

On Fri, Apr 21, 2017 at 11:16 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The vga code clears the dirty bits *after* reading the framebuffer
> memory.  So if the guest framebuffer updates hits the race window
> between vga reading the framebuffer and vga clearing the dirty bits
> vga will miss that update
>
> Fix it by using the new memory_region_copy_and_clear_dirty()
> memory_region_copy_get_dirty() functions.  That way we clear the
> dirty bitmap before reading the framebuffer.  Any guest display
> updates happening in parallel will be properly tracked in the
> dirty bitmap then and the next display refresh will pick them up.
>
> Problem triggers with mttcg only.  Before mttcg was merged tcg
> never ran in parallel to vga emulation.  Using kvm will hide the
> problem too, due to qemu operating on a userspace copy of the
> kernel's dirty bitmap.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/vga.c | 36 +++++++++++++++++-------------------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 3991b88aac..b2516c8d21 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -1465,7 +1465,8 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>      DisplaySurface *surface = qemu_console_surface(s->con);
>      int y1, y, update, linesize, y_start, double_scan, mask, depth;
>      int width, height, shift_control, line_offset, bwidth, bits;
> -    ram_addr_t page0, page1, page_min, page_max;
> +    ram_addr_t page0, page1;
> +    DirtyBitmapSnapshot *snap = NULL;
>      int disp_width, multi_scan, multi_run;
>      uint8_t *d;
>      uint32_t v, addr1, addr;
> @@ -1480,9 +1481,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>
>      full_update |= update_basic_params(s);
>
> -    if (!full_update)
> -        vga_sync_dirty_bitmap(s);
> -
>      s->get_resolution(s, &width, &height);
>      disp_width = width;
>
> @@ -1625,11 +1623,17 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>      addr1 = (s->start_addr * 4);
>      bwidth = (width * bits + 7) / 8;
>      y_start = -1;
> -    page_min = -1;
> -    page_max = 0;
>      d = surface_data(surface);
>      linesize = surface_stride(surface);
>      y1 = 0;
> +
> +    if (!full_update) {
> +        vga_sync_dirty_bitmap(s);
> +        snap = memory_region_snapshot_and_clear_dirty(&s->vram, addr1,
> +                                                      bwidth * height,
> +                                                      DIRTY_MEMORY_VGA);
> +    }
> +
>      for(y = 0; y < height; y++) {
>          addr = addr1;
>          if (!(s->cr[VGA_CRTC_MODE] & 1)) {
> @@ -1644,17 +1648,17 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>          update = full_update;
>          page0 = addr;
>          page1 = addr + bwidth - 1;
> -        update |= memory_region_get_dirty(&s->vram, page0, page1 - page0,
> -                                          DIRTY_MEMORY_VGA);
> +        if (full_update) {
> +            update = 1;
> +        } else {
> +            update = memory_region_snapshot_get_dirty(&s->vram, snap,
> +                                                      page0, page1 - page0);
> +        }

This seems to have broken Windows. I am getting a sporadic assert on
boot at the following callstack:

#4 cpu_physical_memory_snapshot_get_dirty (snap=0x555556a3b3d0,
start=2148532224, length=511)
#5 memory_region_snapshot_get_dirty (mr=0x555558007ad0,
snap=0x555556a3b3d0, addr=393216, size=511)
#6 vga_draw_graphic (s=0x555558007ac0, full_update=0)
#7 vga_update_display (opaque=0x555558007ac0)
#8 graphic_hw_update (con=0x55555820f6e0)
#9 qemu_spice_display_refresh (ssd=0x555558007700)
#10 display_refresh (dcl=0x555558007708)
#11 dpy_refresh (s=0x55555820f670)
#12 gui_update (opaque=0x55555820f670)
#13 timerlist_run_timers (timer_list=0x555556836630)
#14 qemu_clock_run_timers (type=QEMU_CLOCK_REALTIME)
#15 qemu_clock_run_all_timers ()
#16 main_loop_wait (nonblocking=0)
#17 main_loop ()
#18 main (argc=83, argv=0x7fffffffdac8, envp=0x7fffffffdd68)

(gdb)
#4  0x000055555576984d in cpu_physical_memory_snapshot_get_dirty
(snap=0x555556a3b3d0, start=2148532224, length=511) at
/home/lprosek/qemu/exec.c:1129
1129        assert(start + length <= snap->end);
(gdb) p *snap
$1 = {start = 2148007936, end = 2148532224, dirty = 0x555556a3b3e0}
(gdb) p start
$2 = 2148532224
(gdb) p length
$3 = 511

'snap->end' is equal to 'start', so:

qemu-system-x86_64: /home/lprosek/qemu/exec.c:1129:
cpu_physical_memory_snapshot_get_dirty: Assertion `start + length <=
snap->end' failed.

Is this enough information to figure out what's going on or would you
like me to take a closer look?

Thanks!
Ladi

>          /* explicit invalidation for the hardware cursor (cirrus only) */
>          update |= vga_scanline_invalidated(s, y);
>          if (update) {
>              if (y_start < 0)
>                  y_start = y;
> -            if (page0 < page_min)
> -                page_min = page0;
> -            if (page1 > page_max)
> -                page_max = page1;
>              if (!(is_buffer_shared(surface))) {
>                  vga_draw_line(s, d, s->vram_ptr + addr, width);
>                  if (s->cursor_draw_line)
> @@ -1687,13 +1691,7 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>          dpy_gfx_update(s->con, 0, y_start,
>                         disp_width, y - y_start);
>      }
> -    /* reset modified pages */
> -    if (page_max >= page_min) {
> -        memory_region_reset_dirty(&s->vram,
> -                                  page_min,
> -                                  page_max - page_min,
> -                                  DIRTY_MEMORY_VGA);
> -    }
> +    g_free(snap);
>      memset(s->invalidated_y_table, 0, sizeof(s->invalidated_y_table));
>  }
>
> --
> 2.9.3
>
>
