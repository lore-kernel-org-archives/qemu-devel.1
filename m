Received: from eggs.gnu.org ([2001:4830:134:3::10]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fuggA-0001Ea-2D
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:17:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fugX3-00055F-Bc
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:07:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fugWx-00050G-Ig
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 12:07:50 -0400
Received: by mail-wr1-x443.google.com with SMTP id m27-v6so2115372wrf.3
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 09:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
	<20180713130916.4153-22-marcandre.lureau@redhat.com>
	<20180828155925.GG31005@redhat.com>
In-Reply-To: <20180828155925.GG31005@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Aug 2018 18:07:33 +0200
Message-ID: <CAJ+F1CKfjO-57Li4=MdAB4=QidFYDv0UKWqsZ8U-EZyCkBvWPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: David Airlie <airlied@redhat.com>, QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Tue, Aug 28, 2018 at 6:01 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Fri, Jul 13, 2018 at 03:09:08PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > According to Daniel Berrange, fcntl() locks have better portable
> > semantics than lockf().
>
> Specifically I was referring to this from 'man lockf':
>
>    On Linux, lockf() is just an interface  on  top  of  fcntl(2)  locking=
.
>    Many other systems implement lockf() in this way, but note that POSIX.=
1
>    leaves the relationship between lockf() and fcntl(2) locks unspecified=
.
>    A  portable  application  should  probably  avoid mixing calls to thes=
e
>    interfaces.
>
> IOW, if its just a shim around fcntl() on many systems, it is clearer
> if we just use fcntl() directly, as we then know how fcntl() locks will
> behave if they're on a network filesystem like NFS.
>
> > Use an exclusive lock on the first byte with fcntl().
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  util/oslib-posix.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index da1d4a3201..26b11490b9 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -92,6 +92,11 @@ bool qemu_write_pidfile(const char *pidfile, Error *=
*errp)
> >  {
> >      int pidfd;
> >      char pidstr[32];
> > +    struct flock lock =3D {
> > +        .l_type =3D F_WRLCK,
> > +        .l_whence =3D SEEK_SET,
> > +        .l_len =3D 1,
> > +    };
>
> For the same semantics as lockf we should use  len =3D=3D 0 (ie infinity)
>

ok

>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>


--=20
Marc-Andr=C3=A9 Lureau
