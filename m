Received: from eggs.gnu.org ([209.51.188.92]:39947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqyIe-00056C-0q
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:49:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gqyIc-0000OG-Uq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 05:49:55 -0500
Date: Tue, 5 Feb 2019 10:49:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190205104935.GD20321@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190204211204.27321-1-philmd@redhat.com>
	<20190204211204.27321-3-philmd@redhat.com>
	<20190205113219.0c1311e0.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205113219.0c1311e0.cohuck@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/3] util/cutils: Move ctype macros to
 "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Fam Zheng <fam@euphon.net>, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>, Michael Clark <mjc@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Feb 05, 2019 at 11:32:19AM +0100, Cornelia Huck wrote:
> On Mon,  4 Feb 2019 22:12:03 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
> > Introduced in cd390083ad1, these macros don't need to be in
> > a generic header.
> > Add documentation to justify their use.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > v2: Fixed checkpatch warnings (tabs)
> > ---
> >  hw/core/bus.c              |  2 +-
> >  hw/core/qdev-properties.c  |  1 +
> >  hw/s390x/s390-virtio-ccw.c |  1 +
> >  hw/scsi/scsi-generic.c     |  2 +-
> >  include/qemu-common.h      | 16 ----------------
> >  include/qemu/cutils.h      | 25 +++++++++++++++++++++++++
> >  qapi/qapi-util.c           |  2 +-
> >  qobject/json-parser.c      |  1 -
> >  target/ppc/monitor.c       |  1 +
> >  target/riscv/cpu.c         |  1 +
> >  ui/keymaps.c               |  1 +
> >  util/id.c                  |  2 +-
> >  util/readline.c            |  1 -
> >  13 files changed, 34 insertions(+), 22 deletions(-)
>=20
> > diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
> > index 9ee40470e3..644f2d75bd 100644
> > --- a/include/qemu/cutils.h
> > +++ b/include/qemu/cutils.h
> > @@ -3,6 +3,31 @@
> > =20
> >  #include "qemu/fprintf-fn.h"
> > =20
> > +/**
> > + * unsigned ctype macros:
> > + *
> > + * The standards require that the argument for these functions
> > + * is either EOF or a value that is representable in the type
> > + * unsigned char. If the argument is of type char, it must be
> > + * cast to unsigned char. This is what these macros do,
> > + * avoiding 'signed to unsigned' conversion warnings.
>=20
> I'd add
>=20
> "Note that these macros are intended for use with char arguments only,
> they cannot handle EOF."
>=20
> > + */
> > +#define qemu_isalnum(c)     isalnum((unsigned char)(c))
> > +#define qemu_isalpha(c)     isalpha((unsigned char)(c))
> > +#define qemu_iscntrl(c)     iscntrl((unsigned char)(c))
> > +#define qemu_isdigit(c)     isdigit((unsigned char)(c))
> > +#define qemu_isgraph(c)     isgraph((unsigned char)(c))
> > +#define qemu_islower(c)     islower((unsigned char)(c))
> > +#define qemu_isprint(c)     isprint((unsigned char)(c))
> > +#define qemu_ispunct(c)     ispunct((unsigned char)(c))
> > +#define qemu_isspace(c)     isspace((unsigned char)(c))
> > +#define qemu_isupper(c)     isupper((unsigned char)(c))
> > +#define qemu_isxdigit(c)    isxdigit((unsigned char)(c))
> > +#define qemu_tolower(c)     tolower((unsigned char)(c))
> > +#define qemu_toupper(c)     toupper((unsigned char)(c))
> > +#define qemu_isascii(c)     isascii((unsigned char)(c))
> > +#define qemu_toascii(c)     toascii((unsigned char)(c))

Not a problem with your patch, since this is just code movement, but
I would note that some (many?) uses of these functions in QEMU are likely
wrong / bad. These functions all check according to the current locale
rules, while IME most developers assume these APIs are following ASCII
match rules. IOW, these may well be allowing more characters through
than expected.

We might want to consider whether some callers need switching to use
the glib provided APIs that explicitly match in ASCII rules:

  https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.h=
tml#g-ascii-isalnum

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
