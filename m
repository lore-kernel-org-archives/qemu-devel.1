Received: from eggs.gnu.org ([2001:4830:134:3::10]:42577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNoW-0003X9-7L
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:44:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cvNoR-00062s-6t
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:44:00 -0400
Received: from chuckie.co.uk ([82.165.15.123]:40260
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cvNoQ-00062H-RI
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:43:55 -0400
References: <20170404102315.24923-1-kraxel@redhat.com>
	<20170404102315.24923-10-kraxel@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <3d4c9473-5f08-e9a3-4653-54e1d3f4eeb9@ilande.co.uk>
Date: Tue, 4 Apr 2017 13:43:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170404102315.24923-10-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/10] tcx: make display updates thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 04/04/17 11:23, Gerd Hoffmann wrote:

> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/display/tcx.c | 85 +++++++++++++++++++-------------------------------------
>  1 file changed, 29 insertions(+), 56 deletions(-)
> 
> diff --git a/hw/display/tcx.c b/hw/display/tcx.c
> index 15172f0..a890e49 100644
> --- a/hw/display/tcx.c
> +++ b/hw/display/tcx.c
> @@ -98,44 +98,28 @@ static void tcx_set_dirty(TCXState *s)
>      memory_region_set_dirty(&s->vram_mem, 0, MAXX * MAXY);
>  }
>  
> -static inline int tcx_check_dirty(TCXState *s, ram_addr_t page)
> +static inline int tcx_check_dirty(TCXState *s, DirtyBitmapSnapshot *snap,
> +                                  ram_addr_t page)
>  {
> -    return memory_region_get_dirty(&s->vram_mem, page, TARGET_PAGE_SIZE,
> -                                   DIRTY_MEMORY_VGA);
> +    return memory_region_snapshot_get_dirty(&s->vram_mem, snap, page,
> +                                            TARGET_PAGE_SIZE - 1);
>  }

Again the patch preceding this is correct, however this should be left
as "TARGET_PAGE_SIZE" rather than "TARGET_PAGE SIZE - 1" since this was
also before the assert() fixes.

> -static inline int tcx24_check_dirty(TCXState *s, ram_addr_t page,
> -                                    ram_addr_t page24, ram_addr_t cpage)
> +static inline int tcx24_check_dirty(TCXState *s, DirtyBitmapSnapshot *snap,
> +                                    ram_addr_t page, ram_addr_t page24,
> +                                    ram_addr_t cpage)
>  {
>      int ret;
>  
> -    ret = memory_region_get_dirty(&s->vram_mem, page, TARGET_PAGE_SIZE,
> -                                  DIRTY_MEMORY_VGA);
> -    ret |= memory_region_get_dirty(&s->vram_mem, page24, TARGET_PAGE_SIZE * 4,
> -                                   DIRTY_MEMORY_VGA);
> -    ret |= memory_region_get_dirty(&s->vram_mem, cpage, TARGET_PAGE_SIZE * 4,
> -                                   DIRTY_MEMORY_VGA);
> +    ret = memory_region_snapshot_get_dirty(&s->vram_mem, snap, page,
> +                                           TARGET_PAGE_SIZE);
> +    ret |= memory_region_snapshot_get_dirty(&s->vram_mem, snap, page24,
> +                                            TARGET_PAGE_SIZE * 4);
> +    ret |= memory_region_snapshot_get_dirty(&s->vram_mem, snap, cpage,
> +                                            TARGET_PAGE_SIZE * 4);
>      return ret;
>  }
>  
> -static inline void tcx24_reset_dirty(TCXState *ts, ram_addr_t page_min,
> -                               ram_addr_t page_max, ram_addr_t page24,
> -                              ram_addr_t cpage)
> -{
> -    memory_region_reset_dirty(&ts->vram_mem,
> -                              page_min,
> -                              (page_max - page_min) + TARGET_PAGE_SIZE,
> -                              DIRTY_MEMORY_VGA);
> -    memory_region_reset_dirty(&ts->vram_mem,
> -                              page24 + page_min * 4,
> -                              (page_max - page_min) * 4 + TARGET_PAGE_SIZE,
> -                              DIRTY_MEMORY_VGA);
> -    memory_region_reset_dirty(&ts->vram_mem,
> -                              cpage + page_min * 4,
> -                              (page_max - page_min) * 4 + TARGET_PAGE_SIZE,
> -                              DIRTY_MEMORY_VGA);
> -}
> -
>  static void update_palette_entries(TCXState *s, int start, int end)
>  {
>      DisplaySurface *surface = qemu_console_surface(s->con);
> @@ -325,7 +309,8 @@ static void tcx_update_display(void *opaque)
>  {
>      TCXState *ts = opaque;
>      DisplaySurface *surface = qemu_console_surface(ts->con);
> -    ram_addr_t page, page_min, page_max;
> +    ram_addr_t page;
> +    DirtyBitmapSnapshot *snap = NULL;
>      int y, y_start, dd, ds;
>      uint8_t *d, *s;
>      void (*f)(TCXState *s1, uint8_t *dst, const uint8_t *src, int width);
> @@ -337,8 +322,6 @@ static void tcx_update_display(void *opaque)
>  
>      page = 0;
>      y_start = -1;
> -    page_min = -1;
> -    page_max = 0;
>      d = surface_data(surface);
>      s = ts->vram;
>      dd = surface_stride(surface);
> @@ -364,14 +347,14 @@ static void tcx_update_display(void *opaque)
>      }
>  
>      memory_region_sync_dirty_bitmap(&ts->vram_mem);
> +    snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
> +                                                  memory_region_size(&ts->vram_mem),
> +                                                  DIRTY_MEMORY_VGA);
> +
>      for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE) {
> -        if (tcx_check_dirty(ts, page)) {
> +        if (tcx_check_dirty(ts, snap, page)) {
>              if (y_start < 0)
>                  y_start = y;
> -            if (page < page_min)
> -                page_min = page;
> -            if (page > page_max)
> -                page_max = page;
>  
>              f(ts, d, s, ts->width);
>              if (y >= ts->cursy && y < ts->cursy + 32 && ts->cursx < ts->width) {
> @@ -421,20 +404,15 @@ static void tcx_update_display(void *opaque)
>          dpy_gfx_update(ts->con, 0, y_start,
>                         ts->width, y - y_start);
>      }
> -    /* reset modified pages */
> -    if (page_max >= page_min) {
> -        memory_region_reset_dirty(&ts->vram_mem,
> -                                  page_min,
> -                                  (page_max - page_min) + TARGET_PAGE_SIZE,
> -                                  DIRTY_MEMORY_VGA);
> -    }
> +    g_free(snap);
>  }
>  
>  static void tcx24_update_display(void *opaque)
>  {
>      TCXState *ts = opaque;
>      DisplaySurface *surface = qemu_console_surface(ts->con);
> -    ram_addr_t page, page_min, page_max, cpage, page24;
> +    ram_addr_t page, cpage, page24;
> +    DirtyBitmapSnapshot *snap = NULL;
>      int y, y_start, dd, ds;
>      uint8_t *d, *s;
>      uint32_t *cptr, *s24;
> @@ -447,8 +425,6 @@ static void tcx24_update_display(void *opaque)
>      page24 = ts->vram24_offset;
>      cpage = ts->cplane_offset;
>      y_start = -1;
> -    page_min = -1;
> -    page_max = 0;
>      d = surface_data(surface);
>      s = ts->vram;
>      s24 = ts->vram24;
> @@ -457,15 +433,15 @@ static void tcx24_update_display(void *opaque)
>      ds = 1024;
>  
>      memory_region_sync_dirty_bitmap(&ts->vram_mem);
> +    snap = memory_region_snapshot_and_clear_dirty(&ts->vram_mem, 0x0,
> +                                                  memory_region_size(&ts->vram_mem),
> +                                                  DIRTY_MEMORY_VGA);
> +
>      for (y = 0; y < ts->height; page += TARGET_PAGE_SIZE,
>              page24 += TARGET_PAGE_SIZE, cpage += TARGET_PAGE_SIZE) {
> -        if (tcx24_check_dirty(ts, page, page24, cpage)) {
> +        if (tcx24_check_dirty(ts, snap, page, page24, cpage)) {
>              if (y_start < 0)
>                  y_start = y;
> -            if (page < page_min)
> -                page_min = page;
> -            if (page > page_max)
> -                page_max = page;
>              tcx24_draw_line32(ts, d, s, ts->width, cptr, s24);
>              if (y >= ts->cursy && y < ts->cursy+32 && ts->cursx < ts->width) {
>                  tcx_draw_cursor32(ts, d, y, ts->width);
> @@ -521,10 +497,7 @@ static void tcx24_update_display(void *opaque)
>          dpy_gfx_update(ts->con, 0, y_start,
>                         ts->width, y - y_start);
>      }
> -    /* reset modified pages */
> -    if (page_max >= page_min) {
> -        tcx24_reset_dirty(ts, page_min, page_max, page24, cpage);
> -    }
> +    g_free(snap);
>  }
>  
>  static void tcx_invalidate_display(void *opaque)

ATB,

Mark.
