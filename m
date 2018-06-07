Received: from eggs.gnu.org ([2001:4830:134:3::10]:35569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpbb-0005kb-QG
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQpbW-0001cc-Oz
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:45:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49208 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQpbW-0001bh-Ie
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 03:45:06 -0400
Date: Thu, 7 Jun 2018 15:44:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607074456.GC750@xz-mi>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
	<CAFEAcA-_e7mMB07fOCN6qmm-9YTPG2HSMJ3-z=0wRHaa+uTteA@mail.gmail.com>
	<20180607035805.GH7815@xz-mi> <878t7r3wlj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878t7r3wlj.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] util: remove redundant include of
 glib.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Jun 07, 2018 at 09:05:28AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Wed, Jun 06, 2018 at 07:31:53PM +0100, Peter Maydell wrote:
> >> On 6 June 2018 at 18:32, Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
> >> > Code must only ever include glib.h indirectly via the glib-compat.=
h
> >> > header file, because we will need some macros set before glib.h is
> >> > pulled in. Adding extra includes of glib.h will (soon) cause compi=
le
> >> > failures such as:
> >> >
> >> > In file included from /home/berrange/src/virt/qemu/include/qemu/os=
dep.h:107,
> >> >                  from /home/berrange/src/virt/qemu/include/qemu/io=
va-tree.h:26,
> >> >                  from util/iova-tree.c:13:
> >> > /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLI=
B_VERSION_MIN_REQUIRED" redefined [-Werror]
> >> >  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> >> >
> >> > In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
> >> >                  from /usr/include/glib-2.0/glib/galloca.h:32,
> >> >                  from /usr/include/glib-2.0/glib.h:30,
> >> >                  from util/iova-tree.c:12:
> >> > /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the=
 location of the previous definition
> >> >  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
> >> >
> >> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> > ---
> >> >  util/iova-tree.c | 1 -
> >> >  1 file changed, 1 deletion(-)
> >> >
> >> > diff --git a/util/iova-tree.c b/util/iova-tree.c
> >> > index 2d9cebfc89..d39cd8bb29 100644
> >> > --- a/util/iova-tree.c
> >> > +++ b/util/iova-tree.c
> >> > @@ -9,7 +9,6 @@
> >> >   * This work is licensed under the terms of the GNU GPL, version =
2 or later.
> >> >   */
> >> >
> >> > -#include <glib.h>
> >> >  #include "qemu/iova-tree.h"
> >>=20
> >> While we're fixing up the headers in this file:
> >> it should start with an include of qemu/osdep.h,
> >> and qemu/iova-tree.h should not include osdep.h...
> >
> > Sorry to messed this up.  It was used for hwaddr definition.
> >
> > Maybe we can just replace hwaddr usage in iova-tree.[ch] with
> > something like uint64_t?  Then I think we can drop the osdep.h.
>=20
> Every compilation unit must include "osdep.h" first.  Its file comment
> explains why.  If it's insufficiently convincing, we should fix it :)

Ah... :)

Then maybe also we can let iova-tree.c to include osdep.h (instead of
glib.h), and remove that line in iova-tree.h

Thanks,

--=20
Peter Xu
