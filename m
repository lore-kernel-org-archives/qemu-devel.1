Received: from eggs.gnu.org ([209.51.188.92]:52019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1mki-0000x4-LI
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1mkh-0002JG-Rs
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1mkh-0002Ik-Iz
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 01:43:35 -0500
Date: Thu, 7 Mar 2019 07:43:32 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190307064332.mvxhuaopgpdtp3za@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
	<20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903061440270.30260@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1903061440270.30260@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] Question about hardware cursor in VGA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On Wed, Mar 06, 2019 at 02:50:36PM +0100, BALATON Zoltan wrote:
> On Wed, 6 Mar 2019, Gerd Hoffmann wrote:
> > On Wed, Mar 06, 2019 at 12:48:59AM +0100, BALATON Zoltan wrote:
> > > On Tue, 5 Mar 2019, Gerd Hoffmann wrote:
> > > > Use dpy_cursor_define().
> > > 
> > > I've done that but it's not working very well. The mouse pointer is quite
> > > jumpy with this and there are some problems updating the pointer image when
> > > the guest changes image data in video ram without changing registers. (Like
> > 
> > When using a relative pointing device (i.e. mouse instead of tablet) you
> > also need dpy_mouse_set(), to update the host mouse position when the
> > guest moves the cursor sprite around.
> 
> Sure, I figured that out otherwise the mouse pointer would not move.
> 
> > Is it possible to figure where the cursor hotspot is?
> 
> Not sure what you mean. I call dpy_mouse_set() on writing the reg that
> contains mouse position. Hot spot is always top left of sprite (or I don't
> know where it's set). I'll submit a v5 after adding some more checks to make
> it a bit safer then you can have a look.

Well, paravirtual graphics devices propagate the hot-spot information
from the guest to the host.  But on real hardware you typically don't
have registers for that information as the GPU doesn't need to know the
hotspot for cursor display.  The guest driver can simply take the
hotspot location into account when programming the cursor position into
the hardware registers.

So, the suggestion to use dpy_cursor_define() wasn't a good one after
all.  I totally forgot about the hotspot issue as I work with
paravirtual graphics devices most of the time.  Sorry for that.

> > > least doing hw cursor like this works somewhat but I note that the other
> > > version with cursor_invalidate and cursor_draw_line callbacks worked much
> > > smoother, alas I've found that cannot work with shared_surface.
> > 
> > There is a VGAComminState->force_shadow ...
> 
> Yes, but that would also make things slower so I like to keep advantage of
> shared_surface and try to fix the jumpy mouse we get with define_cursor
> instead if possible.

Its not so much a performance issue.  But you need a round-trip to the
guest to update the cursor position, which adds noticeable latency to
mouse moves ...

Either that, or live with the offset due to the missing hotspot
location.  Which typically isn't that much of a problem with the left
pointer where the hotspot is close to the upper left corner.  With the
caret (typically used in text fields) the offset is very noticable
though.

cheers,
  Gerd
