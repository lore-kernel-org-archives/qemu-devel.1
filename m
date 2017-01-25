Received: from eggs.gnu.org ([2001:4830:134:3::10]:53260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWNWy-0003cy-Ob
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <w.bumiller@proxmox.com>) id 1cWNWw-0006nQ-43
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:32 -0500
Received: from proxmox.maurer-it.com ([212.186.127.180]:30923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <w.bumiller@proxmox.com>)
	id 1cWNWv-0006mP-S1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:22:30 -0500
Date: Wed, 25 Jan 2017 14:22:26 +0100 (CET)
From: Wolfgang Bumiller <w.bumiller@proxmox.com>
Message-ID: <1649081132.25.1485350546249@webmail.proxmox.com>
In-Reply-To: <2ca4bdcc-cd12-f640-60f2-85f31dad32ad@redhat.com>
References: <1485346353-23814-1-git-send-email-w.bumiller@proxmox.com>
	<2ca4bdcc-cd12-f640-60f2-85f31dad32ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cirrus: handle negative pitch in
 cirrus_invalidate_region()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Li Qiang <liqiang6-s@360.cn>, Gerd Hoffmann <kraxel@redhat.com>


> On January 25, 2017 at 1:35 PM Laszlo Ersek <lersek@redhat.com> wrote:
> 
> 
> On 01/25/17 13:12, Wolfgang Bumiller wrote:
> > cirrus_invalidate_region() calls memory_region_set_dirty()
> > on a per-line basis, always ranging from off_begin to
> > off_begin+bytesperline. With a negative pitch off_begin
> > marks the top most used address and thus we need to do an
> > initial shift backwards by bytesperline for negative
> > pitches of backward blits, otherwise the first iteration
> > covers the line going from the start offset forwards instead
> > of backwards.
> > 
> > Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> > ---
> > I bumped the patch context to 4 lines to get it to include the
> > memory_region_set_dirty() call which takes an unsigned length (`hwaddr
> > size`) because I'm also not too happy about the masking going on there
> > since it means off_cur_end may be less than off_cur, but if the range
> > checks are finnaly correct I don't think this case could happen
> > anymore? (A check shouldn't hurt though, or maybe an assert()?)
> > 
> >  hw/display/cirrus_vga.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> > index b1a0773..af61981 100644
> > --- a/hw/display/cirrus_vga.c
> > +++ b/hw/display/cirrus_vga.c
> > @@ -669,8 +669,12 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
> >      int y;
> >      int off_cur;
> >      int off_cur_end;
> >  
> > +    if (off_pitch < 0) {
> > +        off_begin -= bytesperline;
> > +    }
> > +
> >      for (y = 0; y < lines; y++) {
> >  	off_cur = off_begin;
> >  	off_cur_end = (off_cur + bytesperline) & s->cirrus_addr_mask;
> >          memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
> > 
> 
> I think the adjustment is off by one. The loop body inherently considers
> "off_cur" inclusive, and "off_cur_end" exclusive.
> 
> When "off_pitch" is negative, and the initial "off_begin" value is an
> "inclusive end", then by subtracting a full "bytesperline", you just go
> to the "inclusive end" of the previous line. Whereas, you should go to
> the address right above it, to the "inclusive start" of the *same* line.
> (From bottom right to bottom left corner.)

Right, this again.

> Therefore the decrement should be (bytesperline - bytesperpixel), IMO.

At this point we don't operate in a pixel byte group basis though, and
as far as I can see the backward blit functions are always byte-based
operations, so I think `bytesperpixel` can just be 1 here?

> Regarding assert(off_cur_end >= off_cur): not a bad idea, IMO.

I'll include it in v2.
