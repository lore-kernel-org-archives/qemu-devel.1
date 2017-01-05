Received: from eggs.gnu.org ([2001:4830:134:3::10]:43480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPAmg-0004KZ-EK
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPAmb-00078g-Dc
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:20:58 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:58539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cPAmb-00077g-5b
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:20:53 -0500
Date: Thu, 5 Jan 2017 11:20:51 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1452150166.2351668.1483633251309.JavaMail.zimbra@redhat.com>
In-Reply-To: <8cee4fa4-26a0-551c-f351-4d00742f2eb1@redhat.com>
References: <20161212224325.20790-1-marcandre.lureau@redhat.com>
	<20161212224325.20790-16-marcandre.lureau@redhat.com>
	<8cee4fa4-26a0-551c-f351-4d00742f2eb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/54] chardev: qom-ify
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

Hi

----- Original Message -----
> On 12/12/2016 04:42 PM, Marc-Andr=C3=A9 Lureau wrote:
> > Turn Chardev into Object.
> >=20
> > qemu_chr_alloc() is replaced by the qemu_chardev_new() constructor. It
> > will call qemu_char_open() to open/intialize the chardev with the
> > ChardevCommon *backend settings.
>=20
> Review part 2:
>=20
> >  spice-qemu-char.c     |  144 +++---
> >  ui/console.c          |   73 +--
> >  ui/gtk.c              |   51 +-
> >  vl.c                  |    2 +
>=20
> > +++ b/spice-qemu-char.c
> > @@ -18,6 +18,12 @@ typedef struct SpiceChardev {
> >      QLIST_ENTRY(SpiceChardev) next;
> >  } SpiceChardev;
> > =20
> > +#define TYPE_CHARDEV_SPICE "chardev-spice"
> > +#define TYPE_CHARDEV_SPICEVMC "chardev-spicevmc"
> > +#define TYPE_CHARDEV_SPICEPORT "chardev-spiceport"
>=20
> Why do we have a lot of TYPE_CHARDEV_* in sysemu/char.h, but not these?
> Should they all live in the same place?

I think in general, we keep typename private, unless the type is being used=
 by some other file.

In this refactoring series, it's a bit tricky, because there are types such=
 as mux, memory and pty  that are shared with several units (when splitting=
).

Moving them back and forth in char.h introduces yet again code churning in =
my tree ;) It would be easier to clean that later in the series. So for thi=
s patch, all types and common helper macros for qemu-char.c are in char.h. =
I'll update commit message with this detail.

>=20
> > +++ b/ui/console.c
> > @@ -1040,9 +1040,12 @@ typedef struct VCChardev {
> >      QemuConsole *console;
> >  } VCChardev;
> > =20
> > -static int console_puts(Chardev *chr, const uint8_t *buf, int len)
> > +#define TYPE_CHARDEV_VC "chardev-vc"
> > +#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC=
)
> > +
> > +static int vc_chr_write(Chardev *chr, const uint8_t *buf, int len)
> ...
>=20
> > @@ -1951,9 +1954,9 @@ int qemu_console_get_height(QemuConsole *con, int
> > fallback)
> >      return con ? surface_height(con->surface) : fallback;
> >  }
> > =20
> > -static void text_console_set_echo(Chardev *chr, bool echo)
> > +static void vc_chr_set_echo(Chardev *chr, bool echo)
>=20
> Should these function renames be split to a separate patch?

ok

>=20
> > +++ b/ui/gtk.c
> > @@ -184,6 +184,9 @@ typedef struct VCChardev {
> >      bool echo;
> >  } VCChardev;
> > =20
> > +#define TYPE_CHARDEV_VC "chardev-vc"
> > +#define VC_CHARDEV(obj) OBJECT_CHECK(VCChardev, (obj), TYPE_CHARDEV_VC=
)
>=20
> Why do we have TYPE_CHARDEV_VC and VC_CHARDEV() defined in two different
> .c files?
>=20
> Overall the conversion looks good; as said elsewhere in the thread, I
> think you can post a v2 of 1-15 and get that merged first, while still
> hammering out the details of the rest of the series.

ok
