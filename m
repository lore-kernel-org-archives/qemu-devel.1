Received: from eggs.gnu.org ([2001:4830:134:3::10]:37714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1drl0G-0002gJ-Kr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1drl0C-0006KE-DJ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:13:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1drl0C-0006JW-4f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:13:20 -0400
Date: Tue, 12 Sep 2017 09:13:16 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1091717998.13779657.1505221996382.JavaMail.zimbra@redhat.com>
In-Reply-To: <e8957d78-66ec-ffeb-fbcd-a35d60190dc2@amsat.org>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-3-marcandre.lureau@redhat.com>
	<e8957d78-66ec-ffeb-fbcd-a35d60190dc2@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/27] libvhost-user: drop dependency on
 glib
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, changpeng liu <changpeng.liu@intel.com>, felipe@nutanix.com

Hi

----- Original Message -----
> Hi Marc-Andr=C3=A9,
>=20
> On 08/23/2017 01:19 PM, Marc-Andr=C3=A9 Lureau wrote:
> > libvhost-user is meant to be free of glib dependency. Make sure it is
> > by droping qemu/osdep.h (which included glib.h)
> >=20
> > This fixes a bad malloc()/g_free() pair.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   contrib/libvhost-user/libvhost-user.c | 25 ++++++++++++++++++++++---
> >   1 file changed, 22 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/contrib/libvhost-user/libvhost-user.c
> > b/contrib/libvhost-user/libvhost-user.c
> > index 35fa0c5e56..bb294c6ef7 100644
> > --- a/contrib/libvhost-user/libvhost-user.c
> > +++ b/contrib/libvhost-user/libvhost-user.c
> > @@ -13,11 +13,22 @@
> >    * later.  See the COPYING file in the top-level directory.
> >    */
> >  =20
> > -#include <qemu/osdep.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <stdarg.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <assert.h>
> > +#include <inttypes.h>
> > +#include <sys/types.h>
> > +#include <sys/socket.h>
> >   #include <sys/eventfd.h>
> > +#include <sys/mman.h>
> >   #include <linux/vhost.h>
> >  =20
> >   #include "qemu/atomic.h"
> > +#include "qemu/compiler.h"
> >  =20
> >   #include "libvhost-user.h"
> >  =20
> > @@ -34,6 +45,14 @@
> >           }                                       \
> >       } while (0)
> >  =20
> > +#ifndef MIN
> > +#define MIN(x, y) ({                            \
> > +        typeof(x) _min1 =3D (x);                  \
> > +        typeof(y) _min2 =3D (y);                  \
> > +        (void) (&_min1 =3D=3D &_min2);              \
> > +        _min1 < _min2 ? _min1 : _min2; })
>=20
> why not add this in qemu/compiler.h instead?

It's a special case here, because libvhost-user doesn't depend on glib. The=
 rest of qemu does. Since MIN/MAX is defined by glib, I don't think qemu/co=
mpiler.h should define it.

>=20
> > +#endif
> > +
> >   static const char *
> >   vu_request_to_string(int req)
> >   {
> > @@ -81,7 +100,7 @@ vu_panic(VuDev *dev, const char *msg, ...)
> >       va_list ap;
> >  =20
> >       va_start(ap, msg);
> > -    buf =3D g_strdup_vprintf(msg, ap);
> > +    vasprintf(&buf, msg, ap);
> >       va_end(ap);
> >  =20
> >       dev->broken =3D true;
> > @@ -840,7 +859,7 @@ vu_dispatch(VuDev *dev)
> >       success =3D true;
> >  =20
> >   end:
> > -    g_free(vmsg.data);
> > +    free(vmsg.data);
> >       return success;
> >   }
> >  =20
> >=20
>=20
