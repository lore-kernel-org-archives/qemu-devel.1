Received: from eggs.gnu.org ([2001:4830:134:3::10]:59146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAJTs-00069y-RQ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eAJTl-0006bR-35
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:40:36 -0400
Date: Thu, 2 Nov 2017 17:40:22 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171102174022.GA32533@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171102171846.21445-1-lyan@suse.com>
	<CAFEAcA8JDVKBE1pFssTwFTybT=Kamc+_ra8qRF-DGSpb7=7QZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8JDVKBE1pFssTwFTybT=Kamc+_ra8qRF-DGSpb7=7QZA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] hw/display/xenfb: Simulate auto-repeat
 key events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Liang Yan <lyan@suse.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Nov 02, 2017 at 05:26:50PM +0000, Peter Maydell wrote:
> On 2 November 2017 at 17:18, Liang Yan <lyan@suse.com> wrote:
> > New tigervnc changes the way to send long pressed key,
> > from "down up down up ..." to "down down ... up", it only
> > affects xen pv console mode. I send a patch to latest
> > kernel side, but it may have a fix in qemu backend for
> > back compatible becase guest VMs may use very old kernel.
> > This patch inserts an up event after each regular key down
> > event to simulate an auto-repeat key event for xen keyboard
> > frontend driver.
> >
> > Signed-off-by: Liang Yan <lyan@suse.com>
> > ---
> > v2:
> > - exclude extended key
> > - change log comment
> >
> >  hw/display/xenfb.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
> > index 8e2547ac05..1bc5b41ab7 100644
> > --- a/hw/display/xenfb.c
> > +++ b/hw/display/xenfb.c
> > @@ -292,6 +292,11 @@ static void xenfb_key_event(void *opaque, int scancode)
> >      }
> >      trace_xenfb_key_event(opaque, scancode2linux[scancode], down);
> >      xenfb_send_key(xenfb, down, scancode2linux[scancode]);
> > +
> > +    /* insert an up event for regular down key event */
> > +    if (down && !xenfb->extended) {
> > +        xenfb_send_key(xenfb, 0, scancode2linux[scancode]);
> > +    }
> >  }
> 
> This doesn't look to me like the right place to fix this bug.
> The xenfb key event handler is just one QEMU keyboard backend
> (in a setup where there are many possible sources of keyboard
> events: vnc, gtk, SDL, cocoa UI frontends; and many possible
> sinks: xenfb's key handling, ps2 keyboard emulator, etc etc).
> 
> We need to be clear in our definition of generic QEMU key
> events how key repeat is supposed to be handled, and then
> every consumer and every producer needs to follow that.
> In the specific case of the vnc UI frontend, we need to
> also look at what the VNC protocol specifies for key repeat.
> That then tells us whether the bug to be fixed is in QEMU,
> or in a particular VNC client.

I'm somewhat inclined to say this is a Tigervnc bug. We fixed this
same issue in GTK-VNC ~10 years ago. While X11 would send a sequence
of press,release,press,release,  GTK would turn this into
press,press,press,press,release which broke some VNC servers.
So GTK-VNC undoes this optimization from GTK to ensure a full set
of press,release,press,release pairs is always sent.

The official RFC for VNC does not specify any auto-repeat behaviour

  https://tools.ietf.org/html/rfc6143#section-7.5.4

The unofficial community authored extension to the RFC suggests
taking the press,press,press,release approach to allow servers to
distinguish auto-repeat from manual repeat, but I'm not really
convinced by that justification really

  http://vncdotool.readthedocs.io/en/latest/rfbproto.html#keyevent

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
