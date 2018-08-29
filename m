Received: from eggs.gnu.org ([2001:4830:134:3::10]:41847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuvb5-0000ME-Sm
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fuvb2-00079F-IV
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:13:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fuvb2-00078c-8Q
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:13:00 -0400
Date: Wed, 29 Aug 2018 09:12:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180829081253.GA4199@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-22-marcandre.lureau@redhat.com>
	<20180828155925.GG31005@redhat.com>
	<CAJ+F1CKfX+ZMxOh8114B=ypfeXF1t8XG5T65yzbWQVMvmP4uLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKfX+ZMxOh8114B=ypfeXF1t8XG5T65yzbWQVMvmP4uLQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 21/29] util: use fcntl() for
 qemu_write_pidfile() locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Wed, Aug 29, 2018 at 01:41:14AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Aug 28, 2018 at 6:01 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com> wrote:
> >
> > On Fri, Jul 13, 2018 at 03:09:08PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > According to Daniel Berrange, fcntl() locks have better portable
> > > semantics than lockf().
> >
> > Specifically I was referring to this from 'man lockf':
> >
> >    On Linux, lockf() is just an interface  on  top  of  fcntl(2)  loc=
king.
> >    Many other systems implement lockf() in this way, but note that PO=
SIX.1
> >    leaves the relationship between lockf() and fcntl(2) locks unspeci=
fied.
> >    A  portable  application  should  probably  avoid mixing calls to =
these
> >    interfaces.
> >
> > IOW, if its just a shim around fcntl() on many systems, it is clearer
> > if we just use fcntl() directly, as we then know how fcntl() locks wi=
ll
> > behave if they're on a network filesystem like NFS.
> >
> > > Use an exclusive lock on the first byte with fcntl().
> > >
> > > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  util/oslib-posix.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index da1d4a3201..26b11490b9 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -92,6 +92,11 @@ bool qemu_write_pidfile(const char *pidfile, Err=
or **errp)
> > >  {
> > >      int pidfd;
> > >      char pidstr[32];
> > > +    struct flock lock =3D {
> > > +        .l_type =3D F_WRLCK,
> > > +        .l_whence =3D SEEK_SET,
> > > +        .l_len =3D 1,
> > > +    };
> >
> > For the same semantics as lockf we should use  len =3D=3D 0 (ie infin=
ity)
>=20
> I went to look at how libvirt implements it. Interestingly, it uses
> start=3D0, len=3D1, and you added it in:

libvirt never used lockf though. Both are valid, I was just saying that
to be identical to what lockf did, it would use len =3D=3D 0.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
