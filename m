Received: from eggs.gnu.org ([2001:4830:134:3::10]:57463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1ejt9l-0006e8-7Z
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1ejt9h-0006K1-14
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:50:57 -0500
Received: from iserv.reactos.org ([2a01:4f8:221:4c5::3]:58381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hpoussin@reactos.org>)
	id 1ejt9g-0006GP-NM
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 15:50:52 -0500
References: <20180208182223.2562-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <53ecaccb-ef00-4ace-c52b-7408a94e2cd6@reactos.org>
Date: Thu, 8 Feb 2018 21:50:37 +0100
MIME-Version: 1.0
In-Reply-To: <20180208182223.2562-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] g364fb: switch to using DirtyBitmapSnapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

Le 08/02/2018 à 19:22, Paolo Bonzini a écrit :
> This removes the last user of memory_region_test_and_clear_dirty
> outside memory.c.
> 
> Cc: Hervé Poussineau <hpoussin@reactos.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Tested-by: Hervé Poussineau <hpoussin@reactos.org>
Tested with Windows NT 4.0

> ---
>          Untested... not sure where to get mips_bios.bin, or a kernel
>          that works with -M magnum.  Can anybody help?  I'd like to
>          get rid of memory_region_test_and_clear_dirty.
> 
>   hw/display/g364fb.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
> index 86557d14a9..86452de780 100644
> --- a/hw/display/g364fb.c
> +++ b/hw/display/g364fb.c
> @@ -62,15 +62,15 @@ typedef struct G364State {
>   
>   #define G364_PAGE_SIZE 4096
>   
> -static inline int check_dirty(G364State *s, ram_addr_t page)
> +static inline int check_dirty(G364State *s, DirtyBitmapSnapshot *snap, ram_addr_t page)
>   {
> -    return memory_region_test_and_clear_dirty(&s->mem_vram, page, G364_PAGE_SIZE,
> -                                              DIRTY_MEMORY_VGA);
> +    return memory_region_snapshot_get_dirty(&s->mem_vram, snap, page, G364_PAGE_SIZE);
>   }
>   
>   static void g364fb_draw_graphic8(G364State *s)
>   {
>       DisplaySurface *surface = qemu_console_surface(s->con);
> +    DirtyBitmapSnapshot *snap;
>       int i, w;
>       uint8_t *vram;
>       uint8_t *data_display, *dd;
> @@ -122,8 +122,10 @@ static void g364fb_draw_graphic8(G364State *s)
>       vram = s->vram + s->top_of_screen;
>       /* XXX: out of range in vram? */
>       data_display = dd = surface_data(surface);
> +    snap = memory_region_snapshot_and_clear_dirty(&s->mem_vram, 0, s->vram_size,
> +                                                  DIRTY_MEMORY_VGA);
>       while (y < s->height) {
> -        if (check_dirty(s, page)) {
> +        if (check_dirty(s, snap, page)) {
>               if (y < ymin)
>                   ymin = ymax = y;
>               if (x < xmin)
> 
