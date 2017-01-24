Received: from eggs.gnu.org ([2001:4830:134:3::10]:43074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cW2Sp-0003dz-C3
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cW2Sk-0002QR-Lc
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:51 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:23243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cW2Sk-0002PG-8x
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:46 -0500
Date: Tue, 24 Jan 2017 15:52:38 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20170124145238.GA4677@olga.wb>
References: <1485183295-10242-1-git-send-email-w.bumiller@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485183295-10242-1-git-send-email-w.bumiller@proxmox.com>
Subject: Re: [Qemu-devel] [PATCH] cirrus: allow zero source pitch in pattern
 fill rops
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

Actually this is wrong, sorry, I'll need to send a v2.

On Mon, Jan 23, 2017 at 03:54:55PM +0100, Wolfgang Bumiller wrote:
> The rops used by cirrus_bitblt_common_patterncopy only use
> the destination pitch, so the source pitch shoul allowed to
> be zero.
> 
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
> Resent as requested as non-inline reply; was originally a reply to
> thread: [PATCH] display: cirrus: check vga bits per pixel(bpp) value
>  hw/display/cirrus_vga.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 379910d..c2fce8c 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -272,9 +272,6 @@ static void cirrus_update_memory_access(CirrusVGAState *s);
>  static bool blit_region_is_unsafe(struct CirrusVGAState *s,
>                                    int32_t pitch, int32_t addr)
>  {
> -    if (!pitch) {
> -        return true;
> -    }
>      if (pitch < 0) {
>          int64_t min = addr
>              + ((int64_t)s->cirrus_blt_height-1) * pitch;
> @@ -294,7 +291,7 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
>      return false;
>  }
>  
> -static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
> +static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only, bool zero_src_pitch_ok)
>  {
>      /* should be the case, see cirrus_bitblt_start */
>      assert(s->cirrus_blt_width > 0);
> @@ -304,6 +301,10 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
>          return true;
>      }
>  
> +    if (!s->cirrus_blt_dstpitch) {
> +        return true;
> +    }
> +
>      if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
>                                s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {
>          return true;
> @@ -311,6 +312,11 @@ static bool blit_is_unsafe(struct CirrusVGAState *s, bool dst_only)
>      if (dst_only) {
>          return false;
>      }
> +
> +    if (!zero_src_pitch_ok && !s->cirrus_blt_srcpitch) {
> +        return true;
> +    }
> +
>      if (blit_region_is_unsafe(s, s->cirrus_blt_srcpitch,
>                                s->cirrus_blt_srcaddr & s->cirrus_addr_mask)) {
>          return true;
> @@ -676,8 +682,9 @@ static int cirrus_bitblt_common_patterncopy(CirrusVGAState * s,
>  
>      dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);
>  
> -    if (blit_is_unsafe(s, false))
> +    if (blit_is_unsafe(s, false, true)) {
>          return 0;
> +    }
>  
>      (*s->cirrus_rop) (s, dst, src,
>                        s->cirrus_blt_dstpitch, 0,
> @@ -694,7 +701,7 @@ static int cirrus_bitblt_solidfill(CirrusVGAState *s, int blt_rop)
>  {
>      cirrus_fill_t rop_func;
>  
> -    if (blit_is_unsafe(s, true)) {
> +    if (blit_is_unsafe(s, true, true)) {
>          return 0;
>      }
>      rop_func = cirrus_fill[rop_to_index[blt_rop]][s->cirrus_blt_pixelwidth - 1];
> @@ -798,7 +805,7 @@ static int cirrus_do_copy(CirrusVGAState *s, int dst, int src, int w, int h)
>  
>  static int cirrus_bitblt_videotovideo_copy(CirrusVGAState * s)
>  {
> -    if (blit_is_unsafe(s, false))
> +    if (blit_is_unsafe(s, false, false))
>          return 0;
>  
>      return cirrus_do_copy(s, s->cirrus_blt_dstaddr - s->vga.start_addr,
> -- 
> 2.1.4
> 
> 
> 
> 
