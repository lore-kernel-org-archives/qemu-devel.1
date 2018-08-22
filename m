Received: from eggs.gnu.org ([2001:4830:134:3::10]:38416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWLm-0004OY-7Q
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsWLj-0006ae-1P
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:51:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55084 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsWLi-0006a2-GR
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:51:14 -0400
Date: Wed, 22 Aug 2018 17:51:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822165106.GU12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<20180822160614.GQ12750@redhat.com>
	<CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] seccomp: set the seccomp filter to
 all threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Aug 22, 2018 at 06:37:56PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Aug 22, 2018 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Wed, Aug 22, 2018 at 05:58:46PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > On Wed, Aug 22, 2018 at 5:46 PM, Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
> > > > On Wed, Aug 22, 2018 at 04:29:56PM +0200, Marc-Andr=C3=A9 Lureau =
wrote:
> > > >
> > > > At this point you might as well not bother using seccomp at all. =
The
> > > > thread that is confined merely needs to scribble something into t=
he
> > > > stack of the unconfined thread and now it can do whatever it want=
s.
> > >
> > > Actually, that message is incorrect, it should rather be "not all
> > > threads will be filtered" (as described in commit message).
> > >
> > > > IMHO we need to find a way to get the policy to apply to those ot=
her
> > > > threads.
> > >
> > > That's what the patch is about ;)
> >
> > It only does it in some scenarios, leaving other unfixed. We need
> > a solution (or choice of multiple solutions) that works all the time
> >
> > >
> > > > The RCU thread is tricky as it is spawned from a __constructor__
> > > > function, which means it'll be active way before we setup seccomp=
.
> > > >
> > > > I think we need to figure out a way todo synchronization between
> > > > the RCU thread and the seccomp setup code. Could we have a global
> > > > variable 'int seccomp_initialized' that we check from the RCU
> > > > thread loop - when that toggles to non-zero, the RCU thread can
> > > > then call into the seccomp_start() method to activate policy in
> > > > its thread. We'd need a synchronous feedback mechansim back to
> > > > the main thread, as it must block startup until all the threads
> > > > have activated the seccomp filter.
> > >
> > > That's a bit like TSYNC, except we do it ourself with RCU thread. B=
ut
> > > what about other threads? For examples one that could be created by
> > > external libraries (like mesa)
> >
> > Does mesa create threads from library constructors too, or somewhere
> > else *before* we do -seccomp setup ?
>=20
> That was an example, I don't think mesa creates threads before
> -seccomp. But what about the other 100 dependencies, or if we
> introduce other threads without the seccomp sync by mistake? I think
> we are better off using tsync.

Yeah we would have to actively check whether any unexpected threads
existed or not.

> > > > IMHO this should never exist, as setting "tsync" to anything othe=
r
> > > > than "yes", is akin to just running without any sandbox.
> > >
> > > Then we should just fail -sandbox on those systems.
> >
> > We would have to make libvirt probe for tsync support too, because it
> > now unconditionally uses -sandbox for new enough QEMU.
>=20
> sigh :( that's where the -sandbox tsync option could have been helpful
> keeping the compatibility.

Probably if a distro knows they have a kernel which doesn't support
it, then should just biuld QEMU with seccomp disabled, at which point
the -sandbox arg stops being reported and libvirt "does the right thing"

IOW, most people probably won't hit the runtime check.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
