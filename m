Received: from eggs.gnu.org ([2001:4830:134:3::10]:57932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejSbT-0006UF-Fi
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejSbP-0000dz-H5
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:29:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ejSbP-0000df-CH
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:29:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0EAFEAE8B
	for <qemu-devel@nongnu.org>; Wed,  7 Feb 2018 16:29:42 +0000 (UTC)
Date: Wed, 7 Feb 2018 16:29:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180207162936.GM32061@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180205152455.12088-1-berrange@redhat.com>
	<20180205152455.12088-3-berrange@redhat.com>
	<8ab20df7-a6fe-7dca-d6c3-f3ab33f78550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ab20df7-a6fe-7dca-d6c3-f3ab33f78550@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/9] cutils: add qemu_strtoi &
 qemu_strtoui parsers for int/unsigned int types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Mon, Feb 05, 2018 at 01:37:21PM -0600, Eric Blake wrote:
> On 02/05/2018 09:24 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > There are qemu_strtoNN functions for various sized integers. This add=
s two
> > more for plain int & unsigned int types, with suitable range checking=
.
> >=20
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
>=20
> > +++ b/util/cutils.c
> > @@ -297,6 +297,110 @@ static int check_strtox_error(const char *nptr,=
 char *ep,
> >       return -libc_errno;
> >   }
> > +/**
> > + * Convert string @nptr to a long integer, and store it in @result.
>=20
> s/a long/an/
>=20
> > + */
> > +int qemu_strtoi(const char *nptr, const char **endptr, int base,
> > +                int *result)
> > +{
> > +    char *ep;
> > +    long lresult;
> > +
> > +    if (!nptr) {
> > +        if (endptr) {
> > +            *endptr =3D nptr;
> > +        }
> > +        return -EINVAL;
> > +    }
> > +
> > +    errno =3D 0;
> > +    lresult =3D strtol(nptr, &ep, base);
> > +    if (lresult < INT_MIN) {
> > +        *result =3D INT_MIN;
> > +    } else if (lresult > INT_MAX) {
> > +        *result =3D INT_MAX;
>=20
> On 64-bit platforms, this clamps the result, but does not set errno, fo=
r
> values beyond int but still within the range of long.  Which is differe=
nt
> than what it does on 32-bit platforms.  Gross.  The testsuite is missin=
g
> coverage of this, which ideally would be the same behavior (setting
> errno=3DERANGE) on both platforms.

Opps, yes, bad, I'll fix it to set ERANGE and figure out some test.

I notice the qemu_strtoui is also broken on 32-bit because I mistakenly
used  strtol instead of strtoul, so didn't handled full range of unsigned
int values.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
