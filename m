Received: from eggs.gnu.org ([2001:4830:134:3::10]:41615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTwB-0001ME-KH
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gDTw6-0005AE-Py
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gDTw2-0004fE-V1
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:31:24 -0400
Date: Fri, 19 Oct 2018 13:31:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181019123108.GO13722@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181009130442.26296-1-berrange@redhat.com>
	<20181009130442.26296-8-berrange@redhat.com>
	<26a77c1f-10e1-7d9e-49d6-7c2ac4a5f318@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26a77c1f-10e1-7d9e-49d6-7c2ac4a5f318@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/11] authz: add QAuthZSimple object
 type for easy whitelist auth checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Thu, Oct 18, 2018 at 07:53:30PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Hi Daniel,
>=20
> On 09/10/2018 15:04, Daniel P. Berrang=C3=A9 wrote:
> > In many cases a single VM will just need to whilelist a single identi=
ty
> > as the allowed user of network services. This is especially the case =
for
> > TLS live migration (optionally with NBD storage) where we just need t=
o
> > whitelist the x509 certificate distinguished name of the source QEMU
> > host.
> >=20
> > Via QMP this can be configured with:
> >=20
> >   {
> >     "execute": "object-add",
> >     "arguments": {
> >       "qom-type": "authz-simple",
> >       "id": "authz0",
> >       "parameters": {
> >         "identity": "fred"
> >       }
> >     }
> >   }
> >=20
> > Or via the command line
> >=20
> >   -object authz-simple,id=3Dauthz0,identity=3Dfred
> >=20
> > Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> > ---
> >  authz/Makefile.objs    |   1 +
> >  authz/simple.c         | 122 +++++++++++++++++++++++++++++++++++++++=
++
> >  authz/trace-events     |   3 +
> >  include/authz/simple.h |  84 ++++++++++++++++++++++++++++
> >  qemu-options.hx        |  21 +++++++
> >  5 files changed, 231 insertions(+)
> >  create mode 100644 authz/simple.c
> >  create mode 100644 include/authz/simple.h
> > diff --git a/qemu-options.hx b/qemu-options.hx
> > index f139459e80..ef38ff19e2 100644
> > --- a/qemu-options.hx
> > +++ b/qemu-options.hx
> > @@ -4377,6 +4377,27 @@ e.g to launch a SEV guest
> >       .....
> > =20
> >  @end example
> > +
> > +
> > +@item -object authz-simple,id=3D@var{id},identity=3D@var{string}
> > +
> > +Create an authorization object that will control access to network s=
ervices.
> > +
> > +The @option{identity} parameter is identifies the user and its forma=
t
> > +depends on the network service that authorization object is associat=
ed
> > +with. For authorizing based on TLS x509 certificates, the identity m=
ust
> > +be the x509 distinguished name. Note that care must be taken to esca=
pe
> > +any commas in the distinguished name.
> > +
> > +An example authorization object to validate a x509 distinguished nam=
e
> > +would look like:
> > +@example
> > + # $QEMU \
> > +     ...
> > +     -object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.=
com,,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
> > +     ...
>=20
> This example does not work:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -trace qauthz\* -object
> authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,,O=3DExample
> Org,,L=3DLondon,,ST=3DLondon,,C=3DGB
> qemu-system-x86_64: -object
> authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,,O=3DExample=
: Could
> not open 'Org,,L=3DLondon,,ST=3DLondon,,C=3DGB': No such file or direct=
ory
>=20
> However escaping does:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -trace qauthz\* -object
> authz-simple,id=3Dauth0,identity=3D'CN=3Dlaptop.example.com,,O=3DExampl=
e
> Org,,L=3DLondon,,ST=3DLondon,,C=3DGB'
>=20
> With example fixed:
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I'll squash in:

diff --git a/qemu-options.hx b/qemu-options.hx
index ef38ff19e2..160db9c8d2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4394,10 +4394,13 @@ would look like:
 @example
  # $QEMU \
      ...
-     -object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com,=
,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \
+     -object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com=
,,O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' \
      ...
 @end example
=20
+Note the use of quotes due to the x509 distinguished name containing
+whitespace, and escaping of ','.
+
 @end table
=20
 ETEXI

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
