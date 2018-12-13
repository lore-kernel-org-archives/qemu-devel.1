Received: from eggs.gnu.org ([2001:4830:134:3::10]:52283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXO3e-0003wt-JC
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXO3b-0005BB-4X
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:17:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40671)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXO3a-00059y-Qv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:17:27 -0500
Date: Thu, 13 Dec 2018 10:17:21 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213101721.GB5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<154468427058.9757.15261216341451632615@02a1dbf831e2>
	<CAFEAcA_=Xn3KBhKwXG0_=iGtEZ56dK3TyLMcSnPafPZ8nL1zZg@mail.gmail.com>
	<CAKXe6SJdkTuBGD1x3Q3xa411KM=9MPB+-SB_yis3jD9u4nHbbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKXe6SJdkTuBGD1x3Q3xa411KM=9MPB+-SB_yis3jD9u4nHbbg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util: check the return value of fcntl in
 qemu_set_{block, noblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, fam@euphon.net, marcandre lureau <marcandre.lureau@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 13, 2018 at 05:56:24PM +0800, Li Qiang wrote:
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2018=E5=B9=B412=E6=9C=
=8813=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:31=E5=86=99=E9=81=93=
=EF=BC=9A
>=20
> > On Thu, 13 Dec 2018 at 06:58, <no-reply@patchew.org> wrote:
> > >
> > > Patchew URL:
> > https://patchew.org/QEMU/1544666977-4816-1-git-send-email-liq3ea@gmai=
l.com/
> > >
> > >
> > >
> > > Hi,
> > >
> > > This series failed the docker-quick@centos7 build test. Please find=
 the
> > testing commands and
> > > their output below. If you have Docker installed, you can probably
> > reproduce it
> > > locally.
> > >
> > > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > > #!/bin/bash
> > > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D8
> > > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> > >
> > > libpmem support   no
> > > libudev           no
> > >
> > > WARNING: Use of SDL 1.2 is deprecated and will be removed in
> > > WARNING: future releases. Please switch to using SDL 2.0
> > >
> > > NOTE: cross-compilers enabled:  'cc'
> > >   GEN     x86_64-softmmu/config-devices.mak.tmp
> > >
> > >
> > > The full log is available at
> > >
> > http://patchew.org/logs/1544666977-4816-1-git-send-email-liq3ea@gmail=
.com/testing.docker-quick@centos7/?type=3Dmessage
> > .
> >
> > Patchew's attempt to limit the log to only the section with
> > the errors/warnings seems to have misfired here -- it looks
> > like it's picked the first bit of the log with a warning/error
> > rather than extracting all of them, which in this case happens
> > to be the harmless complaint that this build setup doesn't
> > have SDL2 installed.
> >
> > The actual cause of the failure is much lower down:
> >
> >
> Indeed.
>=20
>=20
> >   GTESTER check-qtest-aarch64
> > vhost-user-test: /tmp/qemu-test/src/util/oslib-posix.c:245:
> > qemu_set_nonblock: Assertion `f !=3D -1' failed.
> >
>=20
> So here means the fcntl call returns '-1'.
> Seems this test have some bugs?

Not neccessarily. It means that some code is caller qemu_set_nonblock
with a file descriptor for this which is not valid. You'll have to
debug what caller is triggering this to understand why

It might be as simple as something passing in an FD =3D=3D -1, and indeed
I fear this is quite likely as we've been ignoring errors from
qemu_set_nonblock forever.   IOW, your change may well break existing
code that is in fact working just fine today.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
