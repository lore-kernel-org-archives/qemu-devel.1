Received: from eggs.gnu.org ([209.51.188.92]:46563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1PiZ-0006p4-9Q
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h1PiX-0005uG-Ae
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:07:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h1PiW-0005sS-5M
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:07:48 -0500
Date: Wed, 6 Mar 2019 07:07:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190306060744.dxq75ak2knmzv4kv@sirius.home.kraxel.org>
References: <alpine.BSF.2.21.9999.1903041535050.72040@zero.eik.bme.hu>
	<20190305053842.m2u5ahgztybbzpaj@sirius.home.kraxel.org>
	<alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1903052357200.40521@zero.eik.bme.hu>
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

On Wed, Mar 06, 2019 at 12:48:59AM +0100, BALATON Zoltan wrote:
> On Tue, 5 Mar 2019, Gerd Hoffmann wrote:
> > On Mon, Mar 04, 2019 at 03:58:00PM +0100, BALATON Zoltan wrote:
> > > Hello,
> > > 
> > > I'm trying to implement hardware cursor for ati-vga before submitting the
> > > last version of it before the freeze.
> > 
> > Use dpy_cursor_define().
> 
> I've done that but it's not working very well. The mouse pointer is quite
> jumpy with this and there are some problems updating the pointer image when
> the guest changes image data in video ram without changing registers. (Like

When using a relative pointing device (i.e. mouse instead of tablet) you
also need dpy_mouse_set(), to update the host mouse position when the
guest moves the cursor sprite around.

Is it possible to figure where the cursor hotspot is?

> least doing hw cursor like this works somewhat but I note that the other
> version with cursor_invalidate and cursor_draw_line callbacks worked much
> smoother, alas I've found that cannot work with shared_surface.

There is a VGAComminState->force_shadow ...

> should be? (Also note that draw_line callback could do complement pixels but
> that's not possible with dpy_cursor_define.)

Yep, dpy_cursor_define is designed for the way modern hardware handles
hardware cursors, to allow it being used as hardware cursor on the host.
cirrus has a few modes which modern hardware can't do, thats why it
doesn't use dpy_cursor_define.

Has ati cursor a complement pixel mode too?

cheers,
  Gerd
