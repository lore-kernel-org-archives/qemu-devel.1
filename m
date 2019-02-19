Received: from eggs.gnu.org ([209.51.188.92]:46822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw89d-0004yu-EN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:21:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gw89L-0007Y1-JN
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:21:48 -0500
Date: Tue, 19 Feb 2019 16:21:14 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190219162114.GQ7154@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190219161321.15012-1-berrange@redhat.com>
	<20190219161321.15012-3-berrange@redhat.com>
	<d50a19fd-b869-e7f4-cfc7-80191b01ecbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d50a19fd-b869-e7f4-cfc7-80191b01ecbf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: avoid broken pipe with
 certtool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, Feb 19, 2019 at 05:19:46PM +0100, Thomas Huth wrote:
> On 19/02/2019 17.13, Daniel P. Berrang=C3=A9 wrote:
> > When we run "certtool | head -1" the latter command is likely to
> > complete and exit before certtool has written everything it wants to
> > stderr. In at least the RHEL-7 gnutls 3.3.29 this causes certtool to
> > quit with broken pipe before it has finished writing the desired
> > output file to disk. This causes non-deterministic failures of the
> > iotest 233 because the certs are sometimes zero length files.
> > If certtool fails the "head -1" means we also loose any useful error
> > message it would have printed.
> >=20
> > Thus this patch gets rid of the pipe and post-processes the output in=
 a
> > more flexible & reliable manner.
> >=20
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
> >  tests/qemu-iotests/common.tls | 48 +++++++++++++++++++++++----------=
--
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/commo=
n.tls
> > index eae81789bb..6cf11ed383 100644
> > --- a/tests/qemu-iotests/common.tls
> > +++ b/tests/qemu-iotests/common.tls
> > @@ -29,6 +29,17 @@ tls_x509_cleanup()
> >  }
> > =20
> > =20
> > +tls_certtool()
> > +{
> > +    certtool "$@" 1>certtool.log 2>&1
> > +    if test "$?" =3D 0; then
> > +      head -1 certtool.log
> > +    else
> > +      cat certtool.log
> > +    fi
> > +    rm -f certtool.log
> > +}
>=20
> I assume this is running in a unique directory so that there can not be
> a clash with a test running in parallel? Otherwise I'd recommend an
> mktemp file name here...

Hmm, could be a problem.  Whatever happened to the plan to make every
iotests run in a private directory ? Did that ever get done ?

>=20
> Anyway, this fixes the issue for me, too, thus:
>=20
> Tested-by: Thomas Huth <thuth@redhat.com>

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
