Received: from eggs.gnu.org ([2001:4830:134:3::10]:34013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQm42-0000f7-LL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fQm3x-0002IF-Qj
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:58:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53386 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fQm3x-0002Hs-LK
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 23:58:13 -0400
Date: Thu, 7 Jun 2018 11:58:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180607035805.GH7815@xz-mi>
References: <20180606173233.28080-1-berrange@redhat.com>
	<20180606173233.28080-4-berrange@redhat.com>
	<CAFEAcA-_e7mMB07fOCN6qmm-9YTPG2HSMJ3-z=0wRHaa+uTteA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_e7mMB07fOCN6qmm-9YTPG2HSMJ3-z=0wRHaa+uTteA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>

On Wed, Jun 06, 2018 at 07:31:53PM +0100, Peter Maydell wrote:
> On 6 June 2018 at 18:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> > Code must only ever include glib.h indirectly via the glib-compat.h
> > header file, because we will need some macros set before glib.h is
> > pulled in. Adding extra includes of glib.h will (soon) cause compile
> > failures such as:
> >
> > In file included from /home/berrange/src/virt/qemu/include/qemu/osdep=
.h:107,
> >                  from /home/berrange/src/virt/qemu/include/qemu/iova-=
tree.h:26,
> >                  from util/iova-tree.c:13:
> > /home/berrange/src/virt/qemu/include/glib-compat.h:22: error: "GLIB_V=
ERSION_MIN_REQUIRED" redefined [-Werror]
> >  #define GLIB_VERSION_MIN_REQUIRED GLIB_VERSION_2_40
> >
> > In file included from /usr/include/glib-2.0/glib/gtypes.h:34,
> >                  from /usr/include/glib-2.0/glib/galloca.h:32,
> >                  from /usr/include/glib-2.0/glib.h:30,
> >                  from util/iova-tree.c:12:
> > /usr/include/glib-2.0/glib/gversionmacros.h:237: note: this is the lo=
cation of the previous definition
> >  # define GLIB_VERSION_MIN_REQUIRED      (GLIB_VERSION_CUR_STABLE)
> >
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  util/iova-tree.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/util/iova-tree.c b/util/iova-tree.c
> > index 2d9cebfc89..d39cd8bb29 100644
> > --- a/util/iova-tree.c
> > +++ b/util/iova-tree.c
> > @@ -9,7 +9,6 @@
> >   * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> >   */
> >
> > -#include <glib.h>
> >  #include "qemu/iova-tree.h"
>=20
> While we're fixing up the headers in this file:
> it should start with an include of qemu/osdep.h,
> and qemu/iova-tree.h should not include osdep.h...

Sorry to messed this up.  It was used for hwaddr definition.

Maybe we can just replace hwaddr usage in iova-tree.[ch] with
something like uint64_t?  Then I think we can drop the osdep.h.

Regards,

--=20
Peter Xu
