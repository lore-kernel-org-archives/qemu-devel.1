Received: from eggs.gnu.org ([2001:4830:134:3::10]:44565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZtb-0006T3-EI
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZtX-0008Mc-ET
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:23 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cbZtX-0008MS-An
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 16:35:19 -0500
Received: by mail-qt0-x241.google.com with SMTP id n13so25136777qtc.0
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 13:35:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1486561893-26470-1-git-send-email-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4db2f908-31bb-a97d-e704-044e62b1b260@gmail.com>
Date: Wed, 8 Feb 2017 18:35:15 -0300
MIME-Version: 1.0
In-Reply-To: <1486561893-26470-1-git-send-email-kraxel@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] vga: replace debug printf with trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>



On 02/08/2017 10:51 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>  hw/display/trace-events |  6 ++++++
>  hw/display/vga.c        | 27 ++++-----------------------
>  2 files changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/hw/display/trace-events b/hw/display/trace-events
> index aadb612..26910e2 100644
> --- a/hw/display/trace-events
> +++ b/hw/display/trace-events
> @@ -119,3 +119,9 @@ qxl_set_client_capabilities_unsupported_by_revision(int qid, int revision) "%d r
>  qxl_render_blit(int32_t stride, int32_t left, int32_t right, int32_t top, int32_t bottom) "stride=%d [%d, %d, %d, %d]"
>  qxl_render_guest_primary_resized(int32_t width, int32_t height, int32_t stride, int32_t bytes_pp, int32_t bits_pp) "%dx%d, stride %d, bpp %d, depth %d"
>  qxl_render_update_area_done(void *cookie) "%p"
> +
> +# hw/display/vga.c
> +vga_std_read_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
> +vga_std_write_io(uint32_t addr, uint32_t val) "addr 0x%x, val 0x%x"
> +vga_vbe_read(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
> +vga_vbe_write(uint32_t index, uint32_t val) "index 0x%x, val 0x%x"
> diff --git a/hw/display/vga.c b/hw/display/vga.c
> index 2a88b3c..69c3e1d 100644
> --- a/hw/display/vga.c
> +++ b/hw/display/vga.c
> @@ -34,12 +34,9 @@
>  #include "hw/xen/xen.h"
>  #include "trace.h"
>
> -//#define DEBUG_VGA
>  //#define DEBUG_VGA_MEM
>  //#define DEBUG_VGA_REG
>
> -//#define DEBUG_BOCHS_VBE
> -
>  /* 16 state changes per vertical frame @60 Hz */
>  #define VGA_TEXT_CURSOR_PERIOD_MS       (1000 * 2 * 16 / 60)
>
> @@ -428,9 +425,7 @@ uint32_t vga_ioport_read(void *opaque, uint32_t addr)
>              break;
>          }
>      }
> -#if defined(DEBUG_VGA)
> -    printf("VGA: read addr=0x%04x data=0x%02x\n", addr, val);
> -#endif
> +    trace_vga_std_read_io(addr, val);
>      return val;
>  }
>
> @@ -443,9 +438,7 @@ void vga_ioport_write(void *opaque, uint32_t addr, uint32_t val)
>      if (vga_ioport_invalid(s, addr)) {
>          return;
>      }
> -#ifdef DEBUG_VGA
> -    printf("VGA: write addr=0x%04x data=0x%02x\n", addr, val);
> -#endif
> +    trace_vga_std_write_io(addr, val);
>
>      switch(addr) {
>      case VGA_ATT_W:
> @@ -733,9 +726,7 @@ uint32_t vbe_ioport_read_data(void *opaque, uint32_t addr)
>      } else {
>          val = 0;
>      }
> -#ifdef DEBUG_BOCHS_VBE
> -    printf("VBE: read index=0x%x val=0x%x\n", s->vbe_index, val);
> -#endif
> +    trace_vga_vbe_read(s->vbe_index, val);
>      return val;
>  }
>
> @@ -750,9 +741,7 @@ void vbe_ioport_write_data(void *opaque, uint32_t addr, uint32_t val)
>      VGACommonState *s = opaque;
>
>      if (s->vbe_index <= VBE_DISPI_INDEX_NB) {
> -#ifdef DEBUG_BOCHS_VBE
> -        printf("VBE: write index=0x%x val=0x%x\n", s->vbe_index, val);
> -#endif
> +        trace_vga_vbe_write(s->vbe_index, val);
>          switch(s->vbe_index) {
>          case VBE_DISPI_INDEX_ID:
>              if (val == VBE_DISPI_ID0 ||
> @@ -1543,17 +1532,9 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
>                      height, format, s->line_offset,
>                      s->vram_ptr + (s->start_addr * 4));
>              dpy_gfx_replace_surface(s->con, surface);
> -#ifdef DEBUG_VGA
> -            printf("VGA: Using shared surface for depth=%d swap=%d\n",
> -                   depth, byteswap);
> -#endif
>          } else {
>              qemu_console_resize(s->con, disp_width, height);
>              surface = qemu_console_surface(s->con);
> -#ifdef DEBUG_VGA
> -            printf("VGA: Using shadow surface for depth=%d swap=%d\n",
> -                   depth, byteswap);
> -#endif
>          }
>          s->last_scr_width = disp_width;
>          s->last_scr_height = height;
>
