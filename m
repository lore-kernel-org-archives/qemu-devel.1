Received: from eggs.gnu.org ([2001:4830:134:3::10]:56323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWIyB-0001D5-Hh
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWIy8-0002yE-DY
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:30:19 -0500
Date: Wed, 25 Jan 2017 09:30:05 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20170125083005.GA12762@olga.wb>
References: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] cirrus: fix oob access issue
 (CVE-2017-TODO)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 25, 2017 at 08:07:05AM +0100, Gerd Hoffmann wrote:
> From: Li Qiang <liqiang6-s@360.cn>
> 
> When doing bitblt copy in backward mode, we should minus the
> blt width first just like the adding in the forward mode. This
> can avoid the oob access of the front of vga's vram.
> 
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> Message-id: 5887254f.863a240a.2c122.5500@mx.google.com
> 
> { kraxel: with backward blits (negative pitch) addr is the topmost
>           address, so check it as-is against vram size ]
> 
> Cc: qemu-stable@nongnu.org
> Cc: P J P <ppandit@redhat.com>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/display/cirrus_vga.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 379910d..b8c29a6 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -277,10 +277,9 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
>      }
>      if (pitch < 0) {
>          int64_t min = addr
> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> -        int32_t max = addr
> -            + s->cirrus_blt_width;
> -        if (min < 0 || max > s->vga.vram_size) {
> +            + ((int64_t)s->cirrus_blt_height - 1) * pitch
> +            - s->cirrus_blt_width;
> +        if (min < 0 || addr > s->vga.vram_size) {

Call me paranoid, but shouldn't this be '>='? Missed this yesterday
apparently, correct me if I'm wrong:
If VRAM goes from 0..7 it has a size of 8, and this would accept
address 8 as it's not > size.

Note that for the blit functions themselves as well as
blit_region_is_unsafe() the addresses are masked with cirrus_addr_mask.
Like:

    if (blit_region_is_unsafe(s, s->cirrus_blt_dstpitch,
                              s->cirrus_blt_dstaddr & s->cirrus_addr_mask)) {

And eg. cirrus_bitblt_common_patterncopy() does:

    dst = s->vga.vram_ptr + (s->cirrus_blt_dstaddr & s->cirrus_addr_mask);

But it seems this is not always the case? (Also adding a negative pitch
to this would then move in the wrong direction...)

Also in cirrus_bitblt_common_patterncopy() there is a call:

    cirrus_invalidate_region(s, s->cirrus_blt_dstaddr,
                             s->cirrus_blt_dstpitch, s->cirrus_blt_width,
                             s->cirrus_blt_height);

This in turn takes the dstaddr's beginning as is and only masks the
dst+pitch address like this:

        off_cur = off_begin;
        off_cur_end = (off_cur + bytesperline) & s->cirrus_addr_mask;
        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
        off_begin += off_pitch;

So the first memory_region_set_dirty() call would if I'm not mistaken
get a bad address?

Would it make sense to apply the masks in cirrus_bitblt_start() right
after extracting them from s->vga.gr? Or to not mask the address inside
blit_is_unafe()?

>              return true;
>          }
>      } else {
> -- 
> 1.8.3.1
