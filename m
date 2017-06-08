Received: from eggs.gnu.org ([2001:4830:134:3::10]:54139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIlNU-0007NY-7R
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dIlNR-0002g6-5s
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dIlNQ-0002fy-Tw
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 20:32:41 -0400
Date: Thu, 8 Jun 2017 03:32:39 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170608033222-mutt-send-email-mst@kernel.org>
References: <20170602081519.15648-1-marcandre.lureau@redhat.com>
	<CAJ+F1C+fqVd2PDkaPCPS9ZsikZ841hT1wc7tNOj8=JnZOHFchg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+fqVd2PDkaPCPS9ZsikZ841hT1wc7tNOj8=JnZOHFchg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user-bridge: fix iov_restore_front()
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Wed, Jun 07, 2017 at 07:00:46PM +0000, Marc-Andr=E9 Lureau wrote:
> Hi, Michael, could you pick this patch?
>=20
> thanks

OK. Pls cc me on patches you want me to review.

> On Fri, Jun 2, 2017 at 12:26 PM Marc-Andr=E9 Lureau <
> marcandre.lureau@redhat.com> wrote:
>=20
> >   CC      tests/vhost-user-bridge.o
> > /home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warn=
ing:
> > variables 'front' and 'iov' used in loop condition not modified in lo=
op
> > body [-Wfor-loop-analysis]
> >     for (cur =3D front; front !=3D iov; cur++) {
> >                       ^~~~~    ~~~
> > 1 warning generated.
> >
> > Fix the loop, document the function, and fix some related assert().
> >
> > In practice, the loop bug was harmless because the front sg buffer is
> > enough to discard/restore the header size.
> >
> > Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/vhost-user-bridge.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
> > index 8618c20d53..1e5b5ca3da 100644
> > --- a/tests/vhost-user-bridge.c
> > +++ b/tests/vhost-user-bridge.c
> > @@ -220,12 +220,18 @@ vubr_handle_tx(VuDev *dev, int qidx)
> >      free(elem);
> >  }
> >
> > +
> > +/* this function reverse the effect of iov_discard_front() it must b=
e
> > + * called with 'front' being the original struct iovec and 'bytes'
> > + * being the number of bytes you shaved off
> > + */
> >  static void
> >  iov_restore_front(struct iovec *front, struct iovec *iov, size_t byt=
es)
> >  {
> >      struct iovec *cur;
> >
> > -    for (cur =3D front; front !=3D iov; cur++) {
> > +    for (cur =3D front; cur !=3D iov; cur++) {
> > +        assert(bytes >=3D cur->iov_len);
> >          bytes -=3D cur->iov_len;
> >      }
> >
> > @@ -302,7 +308,8 @@ vubr_backend_recv_cb(int sock, void *ctx)
> >              }
> >              iov_from_buf(sg, elem->in_num, 0, &hdr, sizeof hdr);
> >              total +=3D hdrlen;
> > -            assert(iov_discard_front(&sg, &num, hdrlen) =3D=3D hdrle=
n);
> > +            ret =3D iov_discard_front(&sg, &num, hdrlen);
> > +            assert(ret =3D=3D hdrlen);
> >          }
> >
> >          struct msghdr msg =3D {
> > --
> > 2.13.0.91.g00982b8dd
> >
> >
> > --
> Marc-Andr=E9 Lureau
