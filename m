Received: from eggs.gnu.org ([2001:4830:134:3::10]:48484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fZtd7-0008HK-3F
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fZtd6-0002ko-4b
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 03:52:13 -0400
Date: Mon, 2 Jul 2018 08:52:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180702075201.GA4257@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628184624.5867-1-rjones@redhat.com>
	<20180628184624.5867-2-rjones@redhat.com>
	<20180629170343.GY27016@redhat.com>
	<20180629174029.GR1455@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180629174029.GR1455@redhat.com>
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
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, qemu-block@nongnu.org

On Fri, Jun 29, 2018 at 06:40:29PM +0100, Richard W.M. Jones wrote:
> On Fri, Jun 29, 2018 at 06:03:43PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Thu, Jun 28, 2018 at 07:46:24PM +0100, Richard W.M. Jones wrote:
> > > diff --git a/crypto/tlssession.c b/crypto/tlssession.c
> > > index 96a02deb69..50df64e0a9 100644
> > > --- a/crypto/tlssession.c
> > > +++ b/crypto/tlssession.c
> > > @@ -21,6 +21,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "crypto/tlssession.h"
> > >  #include "crypto/tlscredsanon.h"
> > > +#include "crypto/tlscredspsk.h"
> > >  #include "crypto/tlscredsx509.h"
> > >  #include "qapi/error.h"
> > >  #include "qemu/acl.h"
> > > @@ -88,6 +89,8 @@ qcrypto_tls_session_pull(void *opaque, void *buf,=
 size_t len)
> > >      return session->readFunc(buf, len, session->opaque);
> > >  }
> > > =20
> > > +#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
> > > +#define TLS_PRIORITY_ADDITIONAL_PSK  "+ECDHE-PSK:+DHE-PSK:+PSK"
> >=20
> > Unfortunately in testing this I learn ECDHE-PSK is only supported whe=
n
> > using GNUTLS >=3D 3.0, so can you make this conditional based on=20
> > GNUTLS_VERSION_MAJOR  >=3D 3
>=20
> GnuTLS 3.0 was released in 2011, and the last 2.x version seems to be
> from 2009.  Do we need to support such old versions?

With our recently introduced platform support guidelines, I think we can
likely drop 2.x. The issue is timing though - feature freeze deadline is
tomorrow, and I really want to get your PSK patch included without more
delay. So just making it conditional is the simplest way to achieve it.

> I looked at the configure script.  It seems as if we will try to use
> any version of GnuTLS, even ancient ones (although other sub-features
> require later versions of GnuTLS).  But if I'm understanding it
> correctly, by forcing both GnuTLS >=3D 3.0.0 and Nettle we could
> eliminate all the conditionals there, except for one Nettle test.

We still need support for gcrypt unfortunately, since nettle is not cover=
ed
by FIPS certs. So while we will be able to delete a bunch of compat code,
we'll need to refactor much of the configure test logic. I don't want to
risk doing that the day before feature freeze.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
