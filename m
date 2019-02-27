Received: from eggs.gnu.org ([209.51.188.92]:43895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz2Pc-00061s-8q
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gz2PS-0003Xe-Ut
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:50:20 -0500
Date: Wed, 27 Feb 2019 16:50:10 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190227165010.GP31688@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
	<29dfdc31-9e4d-88be-13f0-53e3f33d6800@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29dfdc31-9e4d-88be-13f0-53e3f33d6800@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 1/3] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>

On Wed, Feb 27, 2019 at 10:43:40AM -0600, Eric Blake wrote:
> On 2/27/19 10:20 AM, Daniel P. Berrang=C3=A9 wrote:
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> >=20
> > Currently any client which can complete the TLS handshake is able to =
use
> > the NBD server. The server admin can turn on the 'verify-peer' option
> > for the x509 creds to require the client to provide a x509 certificat=
e.
> > This means the client will have to acquire a certificate from the CA
> > before they are permitted to use the NBD server. This is still a fair=
ly
> > low bar to cross.
> >=20
> > This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command wh=
ich
> > takes the ID of a previously added 'QAuthZ' object instance. This wil=
l
> > be used to validate the client's x509 distinguished name. Clients
> > failing the authorization check will not be permitted to use the NBD
> > server.
> >=20
>=20
> > +++ b/qemu-nbd.c
>=20
> > @@ -103,6 +105,7 @@ static void usage(const char *name)
> >  "  --object type,id=3DID,...   define an object such as 'secret' for=
 providing\n"
> >  "                            passwords and/or encryption keys\n"
> >  "  --tls-creds=3DID            use id of an earlier --object to prov=
ide TLS\n"
> > +"  --tls-authz=3DID            use id of an earlier --object to prov=
ide authorization\n"
>=20
> Usage line exceeds 80 columns; I don't mind splitting the line.

Odd that checkpatch.pl didn't complain about this.

> > +=3D=3D check TLS with authorization =3D=3D
> > +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809=
,tls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS cha=
nnel: Software caused connection abort
> > +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809=
,tls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS cha=
nnel: Software caused connection abort
>=20
> A rather uninformative message for the client to figure out why it
> failed, but (as with all things security-related), giving too many
> details may in itself be an improper information leak. At any rate, I
> don't know that you could make it work any better, so it is not a
> problem with this patch.  It may be the sign of a server bug for closin=
g
> the socket too soon (before the client has a chance to read an actual
> error message), where we could tweak things to provoke a nicer error
> than 'Software caused connection abort', but that would be a separate p=
atch.

I'm not sure how we'd do anything better here. From NBD's pov the TLS
handshake failed to complete. At that point NBD can't assume that it is
able to successfully able to send anything over the connection, so has
little choice but to close it.

To some extent this is a result of the QIOChannelTLS API design, because
in acutal fact we've completed the TLS protocol handshake, so we do
actually have an established TLS connection, but we don't consider the
client authorized.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
