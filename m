Received: from eggs.gnu.org ([2001:4830:134:3::10]:44196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHonh-0004gr-Hw
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cHone-00035j-Dp
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:27:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cHone-00035F-8G
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:27:34 -0500
Date: Fri, 16 Dec 2016 10:27:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20161216092730.GB4434@noname.redhat.com>
References: <20161214142518.10504-1-stefanha@redhat.com>
	<20161215063226-mutt-send-email-mst@kernel.org>
	<20161215075028.GD26169@stefanha-x1.localdomain>
	<1481793479.21413.6.camel@redhat.com>
	<20161215170523-mutt-send-email-mst@kernel.org>
	<1481819150.21413.21.camel@redhat.com>
	<20161216002706-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216002706-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] regression in 2.8: unable to exit screen grab in
 SDL mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Cole Robinson <crobinso@redhat.com>

Am 15.12.2016 um 23:30 hat Michael S. Tsirkin geschrieben:
> On Thu, Dec 15, 2016 at 05:25:50PM +0100, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > > > > > The problem always reproduces for me:
> > > > > > - start qemu with -sdl
> > > > > > - wait for guest to boot
> > > > > > - click anywhere within guest screen
> > > > > > - message "press ctrl+alt to exit capture" appears on screen,
> > > > > >   but pressing that immediately restarts capture again
> > 
> > [ 2.6 good, 2.7, 2.8 bad ]
> > 
> > > I'd say SDL is mostly useless with this bug.
> > > 
> > > Do we fix this or disable SDL altogether?
> > 
> > Well, it can't be *that* bad, otherwise it would not went unnoticed for
> > a whole release cycle.
> > 
> > It doesn't reproduce here.  There must be some other factor which is
> > needed to trigger this.  What desktop you are using?  gnome?  kde?
> > something else?  Xorg or wayland?
> > 
> > Can you try to bisect it?
> 
> Looks like 2.6 does not work either :( Gerd, are you using F25?
> Steps
> - launch fedora guest with kvm, default pc graphics and SDL ui
> - wait until graphical login prompt starts
> - click within window
> 
> afterwards, clicking Ctrl-Alt exits and immediately restarts grab.

I'm seeing two different behaviours depending on the guest:

The first is the traditional behaviour where you click in the window, it
grabs and you control the guest's mouse cursor, and here ctrl+alt works
fine to ungrab.

The second one is much like with the tablet in that it shared the mouse
cursor between host and guest. In this one, when I ungrab with ctrl+alt,
it automatically grabs again as soon as I move the mouse cursor (i.e. it
is actually ungrabbed if I only use the keyboard). But as the mouse
cursor is shared with the host, I can simply move it out of the VM
window and then the capture ends, so that's fine.

So for me that's exactly what I want it to do (RHEL 7 host with qemu.git
master). Is what you got the second behaviour, but without the shared
mouse cursor?

Kevin
