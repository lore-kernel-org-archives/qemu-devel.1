Received: from eggs.gnu.org ([2001:4830:134:3::10]:47734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXQHP-0001t5-Rv
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXQHL-0001DG-N3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXQHL-0008W9-Ad
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:39:47 -0500
Date: Thu, 13 Dec 2018 12:39:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213123908.GI5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544666977-4816-1-git-send-email-liq3ea@gmail.com>
	<20181213101940.GC5171@redhat.com>
	<CAFEAcA_rBakXJZuPGgcsvC9m75oeTbg=q-=mOCFJuungF-VR8g@mail.gmail.com>
	<87o99pa9w8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o99pa9w8.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 13, 2018 at 01:28:23PM +0100, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> > On Thu, 13 Dec 2018 at 10:19, Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >>
> >> On Wed, Dec 12, 2018 at 06:09:37PM -0800, Li Qiang wrote:
> >> > Assert that the return value is not an error. This is like commit
> >> > 7e6478e7d4f for qemu_set_cloexec.
> >> >
> >> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> >> > ---
> >> >  util/oslib-posix.c | 8 ++++++--
> >> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> >> > index c1bee2a581..4ce1ba9ca4 100644
> >> > --- a/util/oslib-posix.c
> >> > +++ b/util/oslib-posix.c
> >> > @@ -233,14 +233,18 @@ void qemu_set_block(int fd)
> >> >  {
> >> >      int f;
> >> >      f =3D fcntl(fd, F_GETFL);
> >> > -    fcntl(fd, F_SETFL, f & ~O_NONBLOCK);
> >> > +    assert(f !=3D -1);
> >>
> >> This leads to *awful* diagnostics. We need to print something
> >> useful when it fails so we stand a chance of understanding what
> >> is wrong.
> >
> > It's the same thing we do in qemu_set_cloexec(), though,
> > and nobody's complained about that that I know of. I think
> > we need to understand whether we're getting asserts in
> > vhost_user_test because of something silly like passing -1
> > as the fd, or because the fcntl() can legitimately fail.
> > If the former, the assert isn't a big deal because when
> > we hit it in newly developed code the problem is going
> > to be obvious when run under a debugger. If the latter,
> > we need to actually pass out the error status and fix
> > all the callers to check it...
>=20
> Yes.
>=20
> Assertions are not expected to fail *by definition*.  When they do,
> there's a bug in the code, and having to look at the code to see what's
> wrong is totally fine.

The problem with this assertion is that there's many places which
call qemu_set_nonblock, so you don't know which code to look at,
as we don't know the caller.=20

> When you feel you have to print something fancy when an assertion fails=
,
> either your feelings are misguided, or the assertion is wrong.

Honestly I'd probably prefer these methods to take an "Error **errp"
and propagate to the caller but that's alot more work.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
