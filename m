Received: from eggs.gnu.org ([209.51.188.92]:42499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz2Jb-0002MQ-KE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:44:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gz2JV-0008GM-8u
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:44:11 -0500
References: <20190227162035.18543-1-berrange@redhat.com>
	<20190227162035.18543-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29dfdc31-9e4d-88be-13f0-53e3f33d6800@redhat.com>
Date: Wed, 27 Feb 2019 10:43:40 -0600
MIME-Version: 1.0
In-Reply-To: <20190227162035.18543-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Juan Quintela <quintela@redhat.com>

On 2/27/19 10:20 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>
>=20
> Currently any client which can complete the TLS handshake is able to us=
e
> the NBD server. The server admin can turn on the 'verify-peer' option
> for the x509 creds to require the client to provide a x509 certificate.
> This means the client will have to acquire a certificate from the CA
> before they are permitted to use the NBD server. This is still a fairly
> low bar to cross.
>=20
> This adds a '--tls-authz OBJECT-ID' option to the qemu-nbd command whic=
h
> takes the ID of a previously added 'QAuthZ' object instance. This will
> be used to validate the client's x509 distinguished name. Clients
> failing the authorization check will not be permitted to use the NBD
> server.
>=20

> +++ b/qemu-nbd.c

> @@ -103,6 +105,7 @@ static void usage(const char *name)
>  "  --object type,id=3DID,...   define an object such as 'secret' for p=
roviding\n"
>  "                            passwords and/or encryption keys\n"
>  "  --tls-creds=3DID            use id of an earlier --object to provid=
e TLS\n"
> +"  --tls-authz=3DID            use id of an earlier --object to provid=
e authorization\n"

Usage line exceeds 80 columns; I don't mind splitting the line.

> @@ -142,13 +146,16 @@ qemu-nbd -f qcow2 file.qcow2
>  @end example
> =20
>  Start a long-running server listening with encryption on port 10810,
> -and require clients to have a correct X.509 certificate to connect to
> +and whitelist clients with a specific X.509 certificate to connect to
>  a 1 megabyte subset of a raw file, using the export name 'subset':
> =20
>  @example
>  qemu-nbd \
>    --object tls-creds-x509,id=3Dtls0,endpoint=3Dserver,dir=3D/path/to/q=
emutls \
> -  --tls-creds tls0 -t -x subset -p 10810 \
> +  --object 'authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.example.com=
,,\
> +            O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB' \

A long line may be necessary here, unless the whitespace in the
identity=3D parameter inserted by the line continuation is harmless.  Lon=
g
lines in man pages are annoying, but even worse is an example that
copies-and-pastes incorrectly.  I may just s/^ *O/O/.


> =20
> +=3D=3D check TLS with authorization =3D=3D
> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,t=
ls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS chann=
el: Software caused connection abort
> +qemu-img: Could not open 'driver=3Dnbd,host=3D127.0.0.1,port=3D10809,t=
ls-creds=3Dtls0': Failed to read option reply: Cannot read from TLS chann=
el: Software caused connection abort

A rather uninformative message for the client to figure out why it
failed, but (as with all things security-related), giving too many
details may in itself be an improper information leak. At any rate, I
don't know that you could make it work any better, so it is not a
problem with this patch.  It may be the sign of a server bug for closing
the socket too soon (before the client has a chance to read an actual
error message), where we could tweak things to provoke a nicer error
than 'Software caused connection abort', but that would be a separate pat=
ch.

Reviewed-by: Eric Blake <eblake@redhat.com>

I can make the minor changes as part of staging through my NBD tree
without needing a v7.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
