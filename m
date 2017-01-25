Received: from eggs.gnu.org ([2001:4830:134:3::10]:46489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWLAM-0006d9-SR
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWLAI-0008J1-VF
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:51:02 -0500
Date: Wed, 25 Jan 2017 11:50:50 +0100
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <20170125105050.GA20813@olga.wb>
References: <1485328025-3783-1-git-send-email-kraxel@redhat.com>
	<20170125083005.GA12762@olga.wb>
	<1485337815.29826.103.camel@redhat.com>
	<5322aaff-c5c6-694b-6206-d6bf729ae6f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5322aaff-c5c6-694b-6206-d6bf729ae6f9@redhat.com>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Li Qiang <liqiang6-s@360.cn>, qemu-stable@nongnu.org, P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Jan 25, 2017 at 11:35:44AM +0100, Laszlo Ersek wrote:
> On 01/25/17 10:50, Gerd Hoffmann wrote:
> > On Mi, 2017-01-25 at 09:30 +0100, Wolfgang Bumiller wrote:
> >> On Wed, Jan 25, 2017 at 08:07:05AM +0100, Gerd Hoffmann wrote:
> >>> From: Li Qiang <liqiang6-s@360.cn>
> >>>
> >>> When doing bitblt copy in backward mode, we should minus the
> >>> blt width first just like the adding in the forward mode. This
> >>> can avoid the oob access of the front of vga's vram.
> >>>
> >>> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> >>> Message-id: 5887254f.863a240a.2c122.5500@mx.google.com
> >>>
> >>> { kraxel: with backward blits (negative pitch) addr is the topmost
> >>>           address, so check it as-is against vram size ]
> >>>
> >>> Cc: qemu-stable@nongnu.org
> >>> Cc: P J P <ppandit@redhat.com>
> >>> Cc: Laszlo Ersek <lersek@redhat.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>
> >>> Fixes: d3532a0db02296e687711b8cdc7791924efccea0 (CVE-2014-8106)
> >>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> >>> ---
> >>>  hw/display/cirrus_vga.c | 7 +++----
> >>>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> >>> index 379910d..b8c29a6 100644
> >>> --- a/hw/display/cirrus_vga.c
> >>> +++ b/hw/display/cirrus_vga.c
> >>> @@ -277,10 +277,9 @@ static bool blit_region_is_unsafe(struct CirrusVGAState *s,
> >>>      }
> >>>      if (pitch < 0) {
> >>>          int64_t min = addr
> >>> -            + ((int64_t)s->cirrus_blt_height-1) * pitch;
> >>> -        int32_t max = addr
> >>> -            + s->cirrus_blt_width;
> >>> -        if (min < 0 || max > s->vga.vram_size) {
> >>> +            + ((int64_t)s->cirrus_blt_height - 1) * pitch
> >>> +            - s->cirrus_blt_width;
> >>> +        if (min < 0 || addr > s->vga.vram_size) {
> >>
> >> Call me paranoid, but shouldn't this be '>='? Missed this yesterday
> >> apparently, correct me if I'm wrong:
> >> If VRAM goes from 0..7 it has a size of 8, and this would accept
> >> address 8 as it's not > size.
> > 
> > I think you are right.  The bkwd ops first execute the op, then
> > decrement, so addr is inclusive and the check is off by one.
> 
> That's right IMO; however, in that case we also have to posit that "min"
> is exclusive. Assume that we have 16 pixels in the VGA memory (4x4), and
> that we are massaging the bottom right quadrant:
> 
>    0  1  2  3
>    4  5  6  7
>    8  9 10 11
>   12 13 14 15
> 
>   addr   =  15
>   height =   2
>   width  =   2
>   pitch  =  -4
> 
> Then
> 
>   min = addr + (height - 1) * pitch - width
>       =   15 + (     2 - 1) * (-4)  - 2
>       = 9
> 
> Which is the address right before the top left pixel; that is, it marks
> the first pixel *not* accessed.
> 
> If that value was (-1), then the operation would still be valid.
> 
> So we should accept (min == -1) -- this is dictated by plain symmetry.
> If "max" -- here, "addr" -- is inclusive, then "min" becomes exclusive.

You're right.

You'd think it wouldn't take so many different people to notice these
things :(. It was right there, I should have noticed it.
