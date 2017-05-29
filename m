Received: from eggs.gnu.org ([2001:4830:134:3::10]:41089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dFF3S-0002qX-Fx
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dFF3P-0007Bz-Ac
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:25:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dFF3P-0007B0-1D
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:25:27 -0400
Date: Mon, 29 May 2017 03:25:19 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1066117429.23192130.1496042719763.JavaMail.zimbra@redhat.com>
In-Reply-To: <7bb7effb-c111-3c7d-56f4-a5835a316900@amsat.org>
References: <20170509113332.4987-1-marcandre.lureau@redhat.com>
	<20170509113332.4987-6-marcandre.lureau@redhat.com>
	<7bb7effb-c111-3c7d-56f4-a5835a316900@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/13] char-win: close file handle except
 with console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

Hi

----- Original Message -----
> Hi Marc-Andr=C3=A9,
>=20
> On 05/09/2017 08:33 AM, Marc-Andr=C3=A9 Lureau wrote:
> > Only the console handle shouldn't be closed, however, the "file" handle
> > should.
>=20
> Correct.
>=20
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  chardev/char-win.h     |  5 ++---
> >  chardev/char-console.c |  2 +-
> >  chardev/char-file.c    |  2 +-
> >  chardev/char-win.c     | 12 ++++--------
> >  4 files changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/chardev/char-win.h b/chardev/char-win.h
> > index 888be2b3ca..9ed2ba998a 100644
> > --- a/chardev/char-win.h
> > +++ b/chardev/char-win.h
> > @@ -29,14 +29,13 @@
> >  typedef struct {
> >      Chardev parent;
> >
> > +    bool dont_close; /* console do not close file */
>=20
> That or "keep_open" to avoid negative thoughts ;)

agreed & changed, thanks

>=20
> Anyway:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> >      HANDLE file, hrecv, hsend;
> >      OVERLAPPED orecv;
> >      BOOL fpipe;
> >
> >      /* Protected by the Chardev chr_write_lock.  */
> >      OVERLAPPED osend;
> > -    /* FIXME: file/console do not finalize */
> > -    bool skip_free;
> >  } WinChardev;
> >
> >  #define NSENDBUF 2048
> > @@ -45,7 +44,7 @@ typedef struct {
> >  #define TYPE_CHARDEV_WIN "chardev-win"
> >  #define WIN_CHARDEV(obj) OBJECT_CHECK(WinChardev, (obj), TYPE_CHARDEV_=
WIN)
> >
> > -void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out);
> > +void win_chr_set_file(Chardev *chr, HANDLE file, bool dont_close);
> >  int win_chr_serial_init(Chardev *chr, const char *filename, Error **er=
rp);
> >  int win_chr_pipe_poll(void *opaque);
> >
> > diff --git a/chardev/char-console.c b/chardev/char-console.c
> > index c824937fe6..8d972c1506 100644
> > --- a/chardev/char-console.c
> > +++ b/chardev/char-console.c
> > @@ -29,7 +29,7 @@ static void qemu_chr_open_win_con(Chardev *chr,
> >                                    bool *be_opened,
> >                                    Error **errp)
> >  {
> > -    qemu_chr_open_win_file(chr, GetStdHandle(STD_OUTPUT_HANDLE));
> > +    win_chr_set_file(chr, GetStdHandle(STD_OUTPUT_HANDLE), true);
> >  }
> >
> >  static void char_console_class_init(ObjectClass *oc, void *data)
> > diff --git a/chardev/char-file.c b/chardev/char-file.c
> > index 8bae25350d..aed4ae1569 100644
> > --- a/chardev/char-file.c
> > +++ b/chardev/char-file.c
> > @@ -65,7 +65,7 @@ static void qmp_chardev_open_file(Chardev *chr,
> >          return;
> >      }
> >
> > -    qemu_chr_open_win_file(chr, out);
> > +    win_chr_set_file(chr, out, false);
> >  #else
> >      int flags, in =3D -1, out;
> >
> > diff --git a/chardev/char-win.c b/chardev/char-win.c
> > index a7e3296909..24cf364947 100644
> > --- a/chardev/char-win.c
> > +++ b/chardev/char-win.c
> > @@ -192,17 +192,13 @@ static void char_win_finalize(Object *obj)
> >      Chardev *chr =3D CHARDEV(obj);
> >      WinChardev *s =3D WIN_CHARDEV(chr);
> >
> > -    if (s->skip_free) {
> > -        return;
> > -    }
> > -
> >      if (s->hsend) {
> >          CloseHandle(s->hsend);
> >      }
> >      if (s->hrecv) {
> >          CloseHandle(s->hrecv);
> >      }
> > -    if (s->file) {
> > +    if (!s->dont_close && s->file) {
> >          CloseHandle(s->file);
> >      }
> >      if (s->fpipe) {
> > @@ -214,12 +210,12 @@ static void char_win_finalize(Object *obj)
> >      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> >  }
> >
> > -void qemu_chr_open_win_file(Chardev *chr, HANDLE fd_out)
> > +void win_chr_set_file(Chardev *chr, HANDLE file, bool dont_close)
> >  {
> >      WinChardev *s =3D WIN_CHARDEV(chr);
> >
> > -    s->skip_free =3D true;
> > -    s->file =3D fd_out;
> > +    s->dont_close =3D dont_close;
> > +    s->file =3D file;
> >  }
> >
> >  static void char_win_class_init(ObjectClass *oc, void *data)
> >
>=20
