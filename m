Received: from eggs.gnu.org ([2001:4830:134:3::10]:50375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlHUI-00054N-7I
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:29:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dlHUF-0007Wj-2z
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dlHUE-0007Ui-PG
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:29:34 -0400
Date: Fri, 25 Aug 2017 17:29:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170825162923.GN2090@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<1503471071-2233-3-git-send-email-peterx@redhat.com>
	<CAJ+F1CKvY9iMtTQSrM2xVUwXYb0pcHjtFf8x4xpxG5ke-FPf3g@mail.gmail.com>
	<20170825153304.GJ2090@work-vm>
	<CAJ+F1CJR3UWv4zaGg_6aAyC7WWsVd35=UiRWyWkbGm-gEN2O9A@mail.gmail.com>
	<20170825161221.GM2090@work-vm>
	<CAJ+F1CLURZ8JqRKzCHX+xgq6XW5GL=Th4m3CH2j6OYgupiRGbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLURZ8JqRKzCHX+xgq6XW5GL=Th4m3CH2j6OYgupiRGbw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 2/8] monitor: allow monitor to create
 thread to poll
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Fri, Aug 25, 2017 at 6:12 PM Dr. David Alan Gilbert <dgilbert@redhat=
.com>
> wrote:
>=20
> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > On Fri, Aug 25, 2017 at 5:33 PM Dr. David Alan Gilbert <
> > dgilbert@redhat.com>
> > > wrote:
> > >
> > > > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > > Hi
> > > > >
> > > > > On Wed, Aug 23, 2017 at 8:52 AM Peter Xu <peterx@redhat.com> wr=
ote:
> > > > >
> > > > > > Firstly, introduce Monitor.use_thread, and set it for monitor=
s
> > that are
> > > > > > using non-mux typed backend chardev.  We only do this for
> > monitors, so
> > > > > > mux-typed chardevs are not suitable (when it connects to, e.g=
.,
> > serials
> > > > > > and the monitor together).
> > > > > >
> > > > > > When use_thread is set, we create standalone thread to poll t=
he
> > monitor
> > > > > > events, isolated from the main loop thread.  Here we still ne=
ed to
> > take
> > > > > > the BQL before dispatching the tasks since some of the monito=
r
> > commands
> > > > > > are not allowed to execute without the protection of BQL.  Th=
en
> > this
> > > > > > gives us the chance to avoid taking the BQL for some monitor
> > commands
> > > > in
> > > > > > the future.
> > > > > >
> > > > > > * Why this change?
> > > > > >
> > > > > > We need these per-monitor threads to make sure we can have at
> > least one
> > > > > > monitor that will never stuck (that can receive further monit=
or
> > > > > > commands).
> > > > > >
> > > > > > * So when will monitors stuck?  And, how do they stuck?
> > > > > >
> > > > > > After we have postcopy and remote page faults, it's simple to
> > achieve a
> > > > > > stuck in the monitor (which is also a stuck in main loop thre=
ad):
> > > > > >
> > > > > > (1) Monitor deadlock on BQL
> > > > > >
> > > > > > As we may know, when postcopy is running on destination VM, t=
he
> > vcpu
> > > > > > threads can stuck merely any time as long as it tries to acce=
ss an
> > > > > > uncopied guest page.  Meanwhile, when the stuck happens, it i=
s
> > possible
> > > > > > that the vcpu thread is holding the BQL.  If the page fault i=
s not
> > > > > > handled quickly, you'll find that monitors stop working, whic=
h is
> > > > trying
> > > > > > to take the BQL.
> > > > > >
> > > > > > If the page fault cannot be handled correctly (one case is a =
paused
> > > > > > postcopy, when network is temporarily down), monitors will ha=
ng
> > > > > > forever.  Without current patch, that means the main loop han=
ged.
> > > > We'll
> > > > > > never find a way to talk to VM again.
> > > > > >
> > > > >
> > > > > Could the BQL be pushed down to the monitor commands level inst=
ead?
> > That
> > > > > way we wouldn't need a seperate thread to solve the hang on com=
mands
> > that
> > > > > do not need BQL.
> > > >
> > > > If the main thread is stuck though I don't see how that helps you=
; you
> > > > have to be able to run these commands on another thread.
> > > >
> > >
> > > Why would the main thread be stuck? In (1) If the vcpu thread takes=
 the
> > BQL
> > > and the command doesn't need it, it would work.
> >
> > True; assuming nothing else in the main loop is blocked;  which is a =
big
> > if - making sure no bh's etc could block on guest memory or the bql.
> >
> >
> > In (2),  info cpus
> > > shouldn't keep the BQL (my qapi-async series would probably help he=
re)
> >
> > How does that work?
> >
> >
> https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03626.html
>=20
> With the series, a command can be broken up in receive/start &
> finish/reply. This allows to reenter the loop, potentially freeing the =
BQL,
> and process other events. This allowed me to fix a screendump glitch bu=
g (
> http://lists.gnu.org/archive/html/qemu-devel/2017-01/msg03650.html). Th=
is
> also open the door to concurrent QMP commands (if the client turns on t=
he
> capability option).

Interesting.
I can see how that would work well for commands that know they're long
lived and do that work to split themselves into
receive/start/finish/reply.  However I'm worried that it means that
it's fragile in that if something accesses guest memory when they din't
realise they were doing, or code that forgot it's taking the lock, then
we've got a command that can occasionally block.  That's going to be a
lot of analysis and design on each command and if we were to do it
widely then we'd certainly miss some cases.  Having the monitors in
spearate threads means you only have to worry about the commands
you want to be lock-free.

Dave

> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
