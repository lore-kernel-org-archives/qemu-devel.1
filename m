Received: from eggs.gnu.org ([2001:4830:134:3::10]:57077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ej9IO-0004cG-0D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ej9IK-0004ga-Oi
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:52:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48800)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ej9IK-0004gC-FL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:52:44 -0500
Date: Tue, 6 Feb 2018 17:52:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206195217.GG3291@localhost.localdomain>
References: <CAFEAcA8ges1g2TOGKYBG+xtjxGHWsg+Hr81eSxcQrLNPV4CUNg@mail.gmail.com>
	<20180206190432.GF3291@localhost.localdomain>
	<CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8gwSqNpVD5xfk_yEz0OUMwa2rrfKaEhBXq5KravJmOag@mail.gmail.com>
Subject: Re: [Qemu-devel] how to handle QOM 'container' objects whose
 contents depend on QOM properties?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Tue, Feb 06, 2018 at 07:27:17PM +0000, Peter Maydell wrote:
> On 6 February 2018 at 19:04, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Tue, Feb 06, 2018 at 06:18:25PM +0000, Peter Maydell wrote:
> >> One current approach to that is that instead of init'ing those
> >> child objects in the container init, we postpone that to
> >> container realize. This looks pretty ugly, and it also means
> >> that you can't do "forward this property" using add_alias if the
> >> target is the late-inited child (instead you have to have a
> >> real property on the container and set the property on the child
> >> manually after it's inited). You can see an example of this kind
> >> of thing in hw/arm/armv7m.c.
> >
> > My rule of thumb is: if something is configurable (even if it's
> > just slightly), it belongs to realize.  instance_init is reserved
> > for stuff that don't take any external input.  If your container
> > contents are not static, creating the contents is not a task for
> > instance_init.
> >
> > But I would like to understand the drawbacks of this approach
> > better.  So, if the object didn't have any "forward this
> > property" aliases, would you see other problems with this
> > approach?
> >
> > Why exactly those boards need the aliases?  Who sets those alias
> > properties?  Can we provide helpers that make this task easier?
> 
> The "forwarding properties" bit is the one I'm hitting at the
> moment. armv7m creates the CPU object, but it's really the
> SoC which creates armv7m that wants to set various properties
> on the CPU. (The CPU properties being set are things like
> "initial vector address" which in real hardware are set by
> the SoC hard-wiring various config signals on the core to 1 or 0.)
> So I'd end up needing to manually forward a lot of properties
> which are implemented in the cpu object but exposed to the
> rest of the system via the armv7m wrapper.
> 
> It's also a bit weird because in the limit case you end up
> doing nothing in init and postponing it all to realize,
> at which point we're back to single-phase init. [...]

I disagree.  A single-phase init inside realize would be able to
take external input, and that's a huge difference from
instance_init (which can't take any input).

>                                           [...] I don't
> much like the "needed to configure this thing" design looking
> different from the "simple nonconfigurable thing" design.
> If nothing else, it makes it harder to convert from one to
> the other when we add a new SoC or whatever.

instance_init can't take any external input, so it can't be used
by configurable things.  So if we really want both configurable
and non-configurable cases to look alike, it would mean not using
instance_init on the non-configurable cases.

If doing everything on realize is not practical, we need to
understand why and fix the limitations on our APIs.

---

Just for clarity, the assumptions I have here are:

A) Initialization has 3 steps:
   1) telling QEMU what's the input we can get (registering
      properties);
   2) get input from the outside (setting properties); and
   3) act on input set by (2).

B) Step (2) needs to be done after instance_init.

C) Step (3) can't be done on instance_init because of (B).

D) realize is the only opportunity we have to perform step (3)
   today (but this can be changed).


-- 
Eduardo
