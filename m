Received: from eggs.gnu.org ([2001:4830:134:3::10]:38285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fu7In-0005Zt-1g
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:30:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fu7Ij-0000rg-SR
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:30:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53686 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fu7Ij-0000qT-L6
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:30:45 -0400
Date: Mon, 27 Aug 2018 10:30:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180827023035.GE3020@xz-x1>
References: <20180824090826.21370-1-peterx@redhat.com>
	<CAJ+F1C+4rshvZ6wNLq0Lo95tPXm_iUxorgRYeNYqgyQCYvxBNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+4rshvZ6wNLq0Lo95tPXm_iUxorgRYeNYqgyQCYvxBNQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/3] chardev: introduce chardev contexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Aug 24, 2018 at 03:46:03PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> On Fri, Aug 24, 2018 at 11:10 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > This is a RFC series.  It majorly did these things:
> >
> > (1) move the monitor iothread management from monitor code to chardev
> >     code somehow,
> >
> > (2) decide which context/iothread to use for the chardev before
> >     chardev creates, by parsing monitor options earlier (not init, bu=
t
> >     only parsing) since monitor is the only exception now,
> >
> > (2) disallow chardev context to change for the whole lifecycle.
> >
> > Basically this work moves the only chardev iothread (the monitor
> > iothread) into chardev's management, then it's easy to setup the
> > iothread even before the chardev creates, hence no context switch for
> > chardev is needed any more.  In the future if we want to let any
> > chardev to run on some other threads, we just define a new
> > ChardevContext, then do qemu_opt_set_number(...) for the chardev.  Fo=
r
> > now, there is only a monitor context.
> >
> > It does not mean that this will let chardev depend on monitor code,
> > instead it'll totally remove the reverse dependency - before this
> > work, the chardev backend strangely depends on the frontend to setup
> > the context (which brought us many trouble).  Now this should be gone=
.
> >
> > This series should solve the potential issue raised here:
> >
> >   https://patchwork.kernel.org/patch/10122713/#22187395
> >
> > And also should let Marc-Andr=C3=A9's vhost-user reconnect series wor=
k
> > without breaking context switch of chardev (since it never switches
> > now hence no way to break):
> >
> >   http://patchwork.ozlabs.org/cover/961442/
> >
> > Only smoke test carried out with out-of-band, and make check.
> >
> > Please have a look on whether this is a workable solution,
>=20
> Clever hack!
>=20
> The code could be simplified somewhat:
> - it probably doesn't need ChardevContextMap

Is it because we only have monitor to use it?  If so, I suspect we
might still want it since I'm just thinking maybe we can add a second
one for COLO...

[2]

> - I would not typedef ChardevContext (took me a while to realize it was=
 an enum)

Maybe, ChardevContextType?

> - we should avoid the "context" option, perhaps during chardev
> parsing, check -mon usage.

[2]

> - more :)
>=20
> Other issues:
> - blend monitor code in chardev

As I mentioned in the cover letter, my intention is not to blend
monitor code into chardev.  For example, we can define the name as
CHR_CONTEXT_1 rather than CHR_CONTEXT_MONITOR and comment with

  /* CONTEXT_1 should only be used by monitor */

but it's just not that direct.  I'd say it's not "blending monitor
codes in chardev", but a pure naming.  Instead, actually I see [1]
tries to blend monitor code in chardev, which I would prefer not.
That's why I used the QemuOpts to pass and decide what context to use.

> - chardev cleanup is done after monitor cleanup, this may race iothread=
s

Will it?  My plan is that we only let frontend (monitor) depends on
the frontend (chardev), then cleaning monitor then chardev seems the
correct order for me without race, no?

> - breaks chardev context switching (colo)

I just had a glance at COLO, I'm not sure but... I think it's not
really using the "dynamic context switching".  IMHO it only needs a
separate context.  If so, it should be able to live with this series,
we might just need to define one more for COLO at [1].

> - not a very dynamic solution (doesn't help to create oob monitor dynam=
ically)

I never created monitors dynamically, but if we want that we might
need to expose this "context" property to user, then we can
dynamically create out-of-band monitors (as long as when we create the
chardev for the out-of-band monitor we pass in correct context
property).

>=20
> I'd continue to look for options, we might come back to this one eventu=
ally :)
>=20
> thanks!

Thanks for the very positive feedback! :) Yes, let's see whether we
have better alternatives.

Regards,

--=20
Peter Xu
