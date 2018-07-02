Received: from eggs.gnu.org ([2001:4830:134:3::10]:55247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fZxmy-0000s1-7n
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fZxmx-0007ph-2N
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 08:18:40 -0400
Date: Mon, 2 Jul 2018 13:18:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180702121829.GA5939@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180628184624.5867-1-rjones@redhat.com>
	<20180628184624.5867-2-rjones@redhat.com>
	<20180629170343.GY27016@redhat.com>
	<20180629174029.GR1455@redhat.com>
	<20180702075201.GA4257@redhat.com>
	<13609f2c-d695-dd60-bdf7-b3b1654c4ee3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13609f2c-d695-dd60-bdf7-b3b1654c4ee3@redhat.com>
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
To: Eric Blake <eblake@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Jul 02, 2018 at 06:54:41AM -0500, Eric Blake wrote:
> On 07/02/2018 02:52 AM, Daniel P. Berrang=C3=A9 wrote:
>=20
> > > > > +#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
> > > > > +#define TLS_PRIORITY_ADDITIONAL_PSK  "+ECDHE-PSK:+DHE-PSK:+PSK=
"
> > > >=20
> > > > Unfortunately in testing this I learn ECDHE-PSK is only supported=
 when
> > > > using GNUTLS >=3D 3.0, so can you make this conditional based on
> > > > GNUTLS_VERSION_MAJOR  >=3D 3
> > >=20
> > > GnuTLS 3.0 was released in 2011, and the last 2.x version seems to =
be
> > > from 2009.  Do we need to support such old versions?
> >=20
> > With our recently introduced platform support guidelines, I think we =
can
> > likely drop 2.x. The issue is timing though - feature freeze deadline=
 is
> > tomorrow, and I really want to get your PSK patch included without mo=
re
> > delay. So just making it conditional is the simplest way to achieve i=
t.
> >=20
> > > I looked at the configure script.  It seems as if we will try to us=
e
> > > any version of GnuTLS, even ancient ones (although other sub-featur=
es
> > > require later versions of GnuTLS).  But if I'm understanding it
> > > correctly, by forcing both GnuTLS >=3D 3.0.0 and Nettle we could
> > > eliminate all the conditionals there, except for one Nettle test.
> >=20
> > We still need support for gcrypt unfortunately, since nettle is not c=
overed
> > by FIPS certs. So while we will be able to delete a bunch of compat c=
ode,
> > we'll need to refactor much of the configure test logic. I don't want=
 to
> > risk doing that the day before feature freeze.
>=20
> We can still check in the initial PSK implementation in time for soft
> freeze, then fix conditionals during the freeze but prior to the releas=
e as
> bug fixes, if that makes life easier (although we also want to minimize
> known-broken builds - if the CI tools fail to compile an unconditional =
use,
> for example, it's harder to justify committing the code just to meet fr=
eeze
> deadlines).

We can't commit it because it breaks unit tests on a number of platforms,
so it won't pass pre-merge testing.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
