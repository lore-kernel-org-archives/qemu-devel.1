Received: from eggs.gnu.org ([2001:4830:134:3::10]:52936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fs0B0-0003Kt-HM
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fs0Av-0001aP-Hs
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:30:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39880 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fs0Av-0001Zq-AN
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 02:29:57 -0400
Date: Tue, 21 Aug 2018 14:29:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180821062951.GE19915@xz-mi>
References: <20180817135224.22971-1-marcandre.lureau@redhat.com>
	<20180820024504.GA7953@xz-mi>
	<CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+J1mUeP8YbsCg=-VU15adxKZoM2acxEJUVtEBUTJsuBQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] Fix socket chardev regression
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

On Mon, Aug 20, 2018 at 05:37:55PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Aug 20, 2018 at 4:48 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Aug 17, 2018 at 03:52:20PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi,
> > >
> > > In commit 25679e5d58e "chardev: tcp: postpone async connection setu=
p"
> > > (and its follow up 99f2f54174a59), Peter moved chardev socket
> > > connection to machine_done event. However, chardev created later wi=
ll
> > > no longer attempt to connect, and chardev created in tests do not h=
ave
> > > machine_done event (breaking some of vhost-user-test).
> > >
> > > The goal was to move the "connect" source to the chardev frontend
> > > context (the monitor thread context in his case). chr->gcontext is =
set
> > > with qemu_chr_fe_set_handlers(). But there is no guarantee that the
> > > function will be called in general,
> >
> > Could you hint a case where we didn't use qemu_chr_fe_set_handlers()
> > upon a chardev backend?  I thought it was always used in chardev
> > frontends, and what the backend could do if without a frontend?
>=20
> Well, you don't have to have a front-end to have side effects. Connect
> will be attempted even without frontend. We may have users expecting
> that behaviour, that might be considered a break if we change it.
>=20
> (and unlikely, there might be frontends that are write only)

My understanding is that qemu_chr_fe_set_handlers() is not only for
port read, but also for the rest.  For example, we need to pass in the
correct IOEventHandler* to handle chardev backend events even if the
frontend only writes.

>=20
> >
> > [1]
> >
> > > so we can't delay connection until
> > > then: the chardev should still attempt to connect during open(), us=
ing
> > > the main context.
> > >
> > > An alternative would be to specify the iothread during chardev
> > > creation. Setting up monitor OOB would be quite different too, it
> > > would take the same iothread as argument.
> > >
> > > 99f2f54174a595e is also a bit problematic, since it will behave
> > > differently before and after machine_done (the first case gives a
> > > chance to use a different context reliably, the second looks racy)
> > >
> > > In the end, I am not sure this is all necessary, as chardev callbac=
ks
> > > are called after qemu_chr_fe_set_handlers(), at which point the
> > > context of sources are updated. In "char-socket: update all ioc
> > > handlers when changing context", I moved also the hup handler to th=
e
> > > updated context. So unless the main thread is already stuck, we can
> > > setup a different context for the chardev at that time. Or not?
> >
> > IMHO the two patches that you reverted are special-cases for reasons.
> >
> > The TLS handshake is carried out with an TLS internal GSource which i=
s
> > not owned by the chardev code, so the qemu_chr_fe_set_handlers() won'=
t
> > update that GSource (please refer to qio_channel_tls_handshake_task).
>=20
> What can go wrong by using the default context for initial connection
> and TLS handshake?
>=20
> Presumably, you have a case where the mainloop is no longer processed
> and that will hang the chardev?

Yeah I don't see a big problem now, but I'm not sure. Actually it
should not be very hard to even migrate this one just like other
GSources, however the async one below should be a bit harder.

>=20
> > The async connection is carried out in a standalone thread that calls
> > connect().  IMHO we'd better not update the gcontext bound to the
> > async task since otherwise there'll be a race (IIRC I proposed
> > something before using a mutex to update the gcontext, but Dan would
> > prefer not to, and I followed with the suggestion which makes sense t=
o
> > me).
> >
> > Could we just postpone these machine done tasks into
> > qemu_chr_fe_set_handlers() (or say, chr_update_read_handler() hook,
> > just like what I mentioned in the other thread)?  Though we'll be sur=
e
> > qemu_chr_fe_set_handlers() will be called for all chardev backends
> > hence I asked question [1] above.
>=20
> I would rather not to, if possible. unless we take the risk of
> breaking current behaviour and review chardev usage in qemu.

Yeah, I'd be glad to know any of the behavior breakage if there is,
but I can't figure any out.  AFAIU there should be none since we
should always be pairing a backend with a frontend.

I fully agree that current way is not ideal since basically the
backend should not depend on the frontend, but now we have the
gcontext as an exception then the backend will somehow depend on the
frontend.  If you don't like the way I proposed, another thing I am
thinking is that whether we can assign the gcontext for the chardev
backend before initialization of it (or by parsing the backend &
frontend relationships before init of backends), then we assure that
we never change the gcontext of any chardev backends.  Though that
will require that we need to setup all possible gcontexts before hand
(e.g., the monitor gcontext).  Then we can drop all these dynamic
binding magics (but just to hope we will never need the flexibility in
the future).

Regards,

--=20
Peter Xu
