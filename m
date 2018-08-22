Received: from eggs.gnu.org ([2001:4830:134:3::10]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVeN-000695-OB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:06:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fsVeK-0008BG-BN
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:06:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48672 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fsVeK-0008Ae-0H
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:06:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6BE7240241C3
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 16:06:23 +0000 (UTC)
Date: Wed, 22 Aug 2018 17:06:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180822160614.GQ12750@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paul Moore <pmoore@redhat.com>, Eduardo Otubo <otubo@redhat.com>

On Wed, Aug 22, 2018 at 05:58:46PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> On Wed, Aug 22, 2018 at 5:46 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > On Wed, Aug 22, 2018 at 04:29:56PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >
> > At this point you might as well not bother using seccomp at all. The
> > thread that is confined merely needs to scribble something into the
> > stack of the unconfined thread and now it can do whatever it wants.
>=20
> Actually, that message is incorrect, it should rather be "not all
> threads will be filtered" (as described in commit message).
>=20
> > IMHO we need to find a way to get the policy to apply to those other
> > threads.
>=20
> That's what the patch is about ;)

It only does it in some scenarios, leaving other unfixed. We need
a solution (or choice of multiple solutions) that works all the time

>=20
> > The RCU thread is tricky as it is spawned from a __constructor__
> > function, which means it'll be active way before we setup seccomp.
> >
> > I think we need to figure out a way todo synchronization between
> > the RCU thread and the seccomp setup code. Could we have a global
> > variable 'int seccomp_initialized' that we check from the RCU
> > thread loop - when that toggles to non-zero, the RCU thread can
> > then call into the seccomp_start() method to activate policy in
> > its thread. We'd need a synchronous feedback mechansim back to
> > the main thread, as it must block startup until all the threads
> > have activated the seccomp filter.
>=20
> That's a bit like TSYNC, except we do it ourself with RCU thread. But
> what about other threads? For examples one that could be created by
> external libraries (like mesa)

Does mesa create threads from library constructors too, or somewhere
else *before* we do -seccomp setup ?

> >> diff --git a/qemu-options.hx b/qemu-options.hx
> >> index 5515dfaba5..dafacb60c6 100644
> >> --- a/qemu-options.hx
> >> +++ b/qemu-options.hx
> >> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
> >>  Disable *fork and execve
> >>  @item resourcecontrol=3D@var{string}
> >>  Disable process affinity and schedular priority
> >> +@item tsync=3D@var{bool}
> >> +Apply seccomp filter to all threads (default is auto, and will warn=
 if fail)
> >
> > IMHO this should never exist, as setting "tsync" to anything other
> > than "yes", is akin to just running without any sandbox.
>=20
> Then we should just fail -sandbox on those systems.

We would have to make libvirt probe for tsync support too, because it
now unconditionally uses -sandbox for new enough QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
