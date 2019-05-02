Received: from eggs.gnu.org ([209.51.188.92]:51705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFzq-0006dJ-O8
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMFzp-0007Fu-Lf
	for qemu-devel@nongnu.org; Thu, 02 May 2019 13:59:50 -0400
MIME-Version: 1.0
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<002f222d86322a66276de39cb29796acffe384c1.1556666645.git.alistair.francis@wdc.com>
	<20190501094140.GO29808@redhat.com>
In-Reply-To: <20190501094140.GO29808@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 May 2019 10:57:51 -0700
Message-ID: <CAKmqyKOOw5A24vmrv7x5z8jiRMRBYdqPL5udbUk4NHEbDTBksQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Wed, May 1, 2019 at 2:41 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Tue, Apr 30, 2019 at 11:28:22PM +0000, Alistair Francis wrote:
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:925:5:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3Dstr=
ingop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qem=
u-sockets.c:880:5:
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  util/qemu-sockets.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> > index 9705051690..8c3322958f 100644
> > --- a/util/qemu-sockets.c
> > +++ b/util/qemu-sockets.c
> > @@ -829,7 +829,7 @@ static int unix_listen_saddr(UnixSocketAddress *sad=
dr,
> >      struct sockaddr_un un;
> >      int sock, fd;
> >      char *pathbuf =3D NULL;
> > -    const char *path;
> > +    const char *path QEMU_NONSTRING;
> >
> >      sock =3D qemu_socket(PF_UNIX, SOCK_STREAM, 0);
> >      if (sock < 0) {
> > @@ -922,7 +922,7 @@ static int unix_connect_saddr(UnixSocketAddress *sa=
ddr, Error **errp)
> >
> >      memset(&un, 0, sizeof(un));
> >      un.sun_family =3D AF_UNIX;
> > -    strncpy(un.sun_path, saddr->path, sizeof(un.sun_path));
> > +    memcpy(un.sun_path, saddr->path, MIN(strlen(saddr->path), sizeof(u=
n.sun_path)));
> >
> >      /* connect to peer */
> >      do {
>
> I think my proposed fix for this file is preferrable as it avoids
> repeated strlen calls
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02124.html

That's fine with me, I have dropped this patch.

Alistair

>
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
