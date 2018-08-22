Received: from eggs.gnu.org ([2001:4830:134:3::10]:33877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsW96-0001Uy-QT
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fsW95-0007uH-Vq
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:38:12 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:37606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fsW95-0007qg-MS
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 12:38:11 -0400
Received: by mail-wm0-x243.google.com with SMTP id n11-v6so2840362wmc.2
	for <qemu-devel@nongnu.org>; Wed, 22 Aug 2018 09:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180822142956.6859-1-marcandre.lureau@redhat.com>
	<20180822142956.6859-4-marcandre.lureau@redhat.com>
	<20180822154611.GN12750@redhat.com>
	<CAMxuvawr-ooy91ZHTHx+aLYhgpH5gBoAKQz_pvF=kcHzadjLog@mail.gmail.com>
	<20180822160614.GQ12750@redhat.com>
In-Reply-To: <20180822160614.GQ12750@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Aug 2018 18:37:56 +0200
Message-ID: <CAJ+F1CK65vU4pkX9w8gbMfJdMfEXv5OZyXv6yRJbJjG1J1OYmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: pmoore@redhat.com, Eduardo Otubo <otubo@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Aug 22, 2018 at 6:08 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Wed, Aug 22, 2018 at 05:58:46PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > On Wed, Aug 22, 2018 at 5:46 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > > On Wed, Aug 22, 2018 at 04:29:56PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > >
> > > At this point you might as well not bother using seccomp at all. The
> > > thread that is confined merely needs to scribble something into the
> > > stack of the unconfined thread and now it can do whatever it wants.
> >
> > Actually, that message is incorrect, it should rather be "not all
> > threads will be filtered" (as described in commit message).
> >
> > > IMHO we need to find a way to get the policy to apply to those other
> > > threads.
> >
> > That's what the patch is about ;)
>
> It only does it in some scenarios, leaving other unfixed. We need
> a solution (or choice of multiple solutions) that works all the time
>
> >
> > > The RCU thread is tricky as it is spawned from a __constructor__
> > > function, which means it'll be active way before we setup seccomp.
> > >
> > > I think we need to figure out a way todo synchronization between
> > > the RCU thread and the seccomp setup code. Could we have a global
> > > variable 'int seccomp_initialized' that we check from the RCU
> > > thread loop - when that toggles to non-zero, the RCU thread can
> > > then call into the seccomp_start() method to activate policy in
> > > its thread. We'd need a synchronous feedback mechansim back to
> > > the main thread, as it must block startup until all the threads
> > > have activated the seccomp filter.
> >
> > That's a bit like TSYNC, except we do it ourself with RCU thread. But
> > what about other threads? For examples one that could be created by
> > external libraries (like mesa)
>
> Does mesa create threads from library constructors too, or somewhere
> else *before* we do -seccomp setup ?

That was an example, I don't think mesa creates threads before
-seccomp. But what about the other 100 dependencies, or if we
introduce other threads without the seccomp sync by mistake? I think
we are better off using tsync.

>
> > >> diff --git a/qemu-options.hx b/qemu-options.hx
> > >> index 5515dfaba5..dafacb60c6 100644
> > >> --- a/qemu-options.hx
> > >> +++ b/qemu-options.hx
> > >> @@ -3864,6 +3864,8 @@ Disable set*uid|gid system calls
> > >>  Disable *fork and execve
> > >>  @item resourcecontrol=3D@var{string}
> > >>  Disable process affinity and schedular priority
> > >> +@item tsync=3D@var{bool}
> > >> +Apply seccomp filter to all threads (default is auto, and will warn=
 if fail)
> > >
> > > IMHO this should never exist, as setting "tsync" to anything other
> > > than "yes", is akin to just running without any sandbox.
> >
> > Then we should just fail -sandbox on those systems.
>
> We would have to make libvirt probe for tsync support too, because it
> now unconditionally uses -sandbox for new enough QEMU.

sigh :( that's where the -sandbox tsync option could have been helpful
keeping the compatibility.


--=20
Marc-Andr=C3=A9 Lureau
