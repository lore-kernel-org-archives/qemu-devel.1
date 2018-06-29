Received: from eggs.gnu.org ([2001:4830:134:3::10]:46845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYxNz-0002G8-4D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYxNy-0003gG-42
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:40:43 -0400
Date: Fri, 29 Jun 2018 18:40:29 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180629174029.GR1455@redhat.com>
References: <20180628184624.5867-1-rjones@redhat.com>
	<20180628184624.5867-2-rjones@redhat.com>
	<20180629170343.GY27016@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180629170343.GY27016@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org

On Fri, Jun 29, 2018 at 06:03:43PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 28, 2018 at 07:46:24PM +0100, Richard W.M. Jones wrote:
> > diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> > index 96a02deb69..50df64e0a9 100644
> > --- a/crypto/tlssession.c
> > +++ b/crypto/tlssession.c
> > @@ -21,6 +21,7 @@
> >  #include "qemu/osdep.h"
> >  #include "crypto/tlssession.h"
> >  #include "crypto/tlscredsanon.h"
> > +#include "crypto/tlscredspsk.h"
> >  #include "crypto/tlscredsx509.h"
> >  #include "qapi/error.h"
> >  #include "qemu/acl.h"
> > @@ -88,6 +89,8 @@ qcrypto_tls_session_pull(void *opaque, void *buf, s=
ize_t len)
> >      return session->readFunc(buf, len, session->opaque);
> >  }
> > =20
> > +#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
> > +#define TLS_PRIORITY_ADDITIONAL_PSK  "+ECDHE-PSK:+DHE-PSK:+PSK"
>=20
> Unfortunately in testing this I learn ECDHE-PSK is only supported when
> using GNUTLS >=3D 3.0, so can you make this conditional based on=20
> GNUTLS_VERSION_MAJOR  >=3D 3

GnuTLS 3.0 was released in 2011, and the last 2.x version seems to be
from 2009.  Do we need to support such old versions?

I looked at the configure script.  It seems as if we will try to use
any version of GnuTLS, even ancient ones (although other sub-features
require later versions of GnuTLS).  But if I'm understanding it
correctly, by forcing both GnuTLS >=3D 3.0.0 and Nettle we could
eliminate all the conditionals there, except for one Nettle test.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
