Received: from eggs.gnu.org ([2001:4830:134:3::10]:57942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft897-0003u6-D4
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:12:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ft894-0008TN-3h
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:12:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38382 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ft893-0008T4-UK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:12:42 -0400
Date: Fri, 24 Aug 2018 17:12:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180824091236.GB3020@xz-x1>
References: <20180823143125.16767-1-marcandre.lureau@redhat.com>
	<20180824034517.GF24044@xz-x1>
	<CAMxuvayHnOM1_iGPqg5MBxhYa_Mz=S-jC5z_Tp_UmwvLo0Zu-Q@mail.gmail.com>
	<20180824084454.GA3020@xz-x1>
	<CAJ+F1CLBGcc0B+BQTZh8KLhqPr7PAf4mDLb81nQSVmiZxK7Anw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLBGcc0B+BQTZh8KLhqPr7PAf4mDLb81nQSVmiZxK7Anw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Fix socket chardev regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Fri, Aug 24, 2018 at 10:51:18AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Aug 24, 2018 at 10:45 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 24, 2018 at 10:32:58AM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >
> > > On Fri, Aug 24, 2018 at 5:45 AM, Peter Xu <peterx@redhat.com> wrote=
:
> > > > On Thu, Aug 23, 2018 at 04:31:20PM +0200, Marc-Andr=C3=A9 Lureau =
wrote:
> > > >> Hi,
> > > >>
> > > >> In commit 25679e5d58e "chardev: tcp: postpone async connection s=
etup"
> > > >> (and its follow up 99f2f54174a59), Peter moved chardev socket
> > > >> connection to machine_done event. However, chardev created later=
 will
> > > >> no longer attempt to connect, and chardev created in tests do no=
t have
> > > >> machine_done event (breaking some of vhost-user-test).
> > > >>
> > > >> The goal was to move the "connect" source to the chardev fronten=
d
> > > >> context (the monitor thread context in his case). chr->gcontext =
is set
> > > >> with qemu_chr_fe_set_handlers(). But there is no guarantee that =
the
> > > >> function will be called in general, so we can't delay connection=
 until
> > > >> then: the chardev should still attempt to connect during open(),=
 using
> > > >> the main context.
> > > >>
> > > >> An alternative would be to specify the iothread during chardev
> > > >> creation. Setting up monitor OOB would be quite different too, i=
t
> > > >> would take the same iothread as argument.
> > > >>
> > > >> 99f2f54174a595e is also a bit problematic, since it will behave
> > > >> differently before and after machine_done (the first case gives =
a
> > > >> chance to use a different context reliably, the second looks rac=
y)
> > > >>
> > > >> In the end, I am not sure this is all necessary, as chardev call=
backs
> > > >> are called after qemu_chr_fe_set_handlers(), at which point the
> > > >> context of sources are updated. In "char-socket: update all ioc
> > > >> handlers when changing context", I moved also the hup handler to=
 the
> > > >> updated context. So unless the main thread is already stuck, we =
can
> > > >> setup a different context for the chardev at that time. Or not?
> > > >>
> > > >> v2:
> > > >> - fix a random socket chardev test failure
> > > >
> > > > I have no problem on patch 3-5, but aren't patch 1-2 still breaki=
ng
> > > > the context switch of chardev?  Or did I misunderstood?
> > >
> > > Switching context is broken/racy regardless. My current plan is to
> > > suspend the context to switch to, and update all sources before
> > > thawing the target context.
> > >
> > > If you prefer we can delay the revert, but I would rather have them
> > > because the regression seems much worse to me.
> >
> > Have you started working on above?  I started to code up some RFC
> > patch to let the chardev maintain the iothreads (now it'll only have =
a
> > monitor iothread) then we don't need to switch context for chardev an=
y
> > more.  I plan to post it today for a quick look.  With that, this
> > series will not break anything then.
>=20
> No, I haven't really started the code, but spent some time thinking...
>=20
> Ok, if you manage to put together that proposal, that sounds interestin=
g.

Not really your iothread proposal; I tried to keep the interface
unchanged, but move the iothread ownership from the monitor code to
chardev code.  Please have a look at:

  [RFC 0/3] chardev: introduce chardev contexts

>=20
> Nevertheless, I can work on improving/fixing the race when switching
> contexts (already used by colo)

Ouch, is colo changing context too?  I hope that series won't break it.

(Ok if so I believe it'll very possible to break it...)

Regards,

--=20
Peter Xu
