Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cRh4u-0001AF-CN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cRh4r-0003Vq-6u
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:14:12 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:45225)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cRh4q-0003VS-UY
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:14:09 -0500
Date: Thu, 12 Jan 2017 10:14:08 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1598397673.1924006.1484234048346.JavaMail.zimbra@redhat.com>
In-Reply-To: <9c4d7bfd-ee95-6a14-0240-82e90008a520@redhat.com>
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-13-marcandre.lureau@redhat.com>
	<9c4d7bfd-ee95-6a14-0240-82e90008a520@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/40] char-win: do not override chr_free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com



----- Original Message -----
> On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> > For some unclear reason to me, char-file does not have chr_free on
> > win32. Since we want to switch to instance finalizer instead of class
> > chr_free, we should be able to run the base WinChardev class finalizer
> > in any case. Use a boolean to skip free to ease the transition to
> > instance finalizer.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qemu-char.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/qemu-char.c b/qemu-char.c
> > index ad8e5e7ebf..1954dec9b8 100644
> > --- a/qemu-char.c
> > +++ b/qemu-char.c
> > @@ -2122,6 +2122,8 @@ typedef struct {
> > =20
> >      /* Protected by the Chardev chr_write_lock.  */
> >      OVERLAPPED osend;
> > +    /* FIXME: file/console do not finalize */
> > +    BOOL skip_free;
>=20
> Do we really need the glib type, or is bool sufficient?

It's windows type actually, but bool is sufficient (there is a BOOL fpipe b=
efore, probably not needed either)

ok

>=20
> >  } WinChardev;
> > =20
> >  #define TYPE_CHARDEV_WIN "chardev-win"
> > @@ -2152,6 +2154,10 @@ static void win_chr_free(Chardev *chr)
> >  {
> >      WinChardev *s =3D WIN_CHARDEV(chr);
> > =20
> > +    if (s->skip_free) {
> > +        return;
> > +    }
> > +
> >      if (s->hsend) {
> >          CloseHandle(s->hsend);
> >          s->hsend =3D NULL;
> > @@ -2432,6 +2438,7 @@ static void qemu_chr_open_win_file(Chardev *chr,
> > HANDLE fd_out)
> >  {
> >      WinChardev *s =3D WIN_CHARDEV(chr);
> > =20
> > +    s->skip_free =3D true;
>=20
> Particularly since you assign it the bool true, rather than the glib TRUE=
.
>=20
> With that fixed,
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
