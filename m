Received: from eggs.gnu.org ([2001:4830:134:3::10]:41001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMtK-0006H2-0t
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:06:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMtI-0000Qy-Sf
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:06:14 -0400
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e17406b-7910-5827-6239-ded1115bd0c7@redhat.com>
Date: Tue, 19 Jun 2018 15:06:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180615155103.11924-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-nbd: add support for
 authorization of TLS clients
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>

On 06/15/2018 10:50 AM, Daniel P. Berrang=C3=A9 wrote:
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
> For example to setup authorization that only allows connection from a c=
lient
> whose x509 certificate distinguished name contains 'CN=3Dfred', you wou=
ld
> use:
>=20
>    qemu-nbd -object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemut=
ls,\
>                     endpoint=3Dserver,verify-peer=3Dyes \
>             -object authz-simple,id=3Dauthz0,policy=3Ddeny,\
> 	           rules.0.match=3D*CN=3Dfred,rules.0.policy=3Dallow \

s/-object/--object/g

>             -tls-creds tls0 \
>             -tls-authz authz0

s/-tls/--tls/g

(qemu-nbd requires double-dash long-opts, -o means --offset except that=20
'bject' is not an offset; similarly for -t meaning --persistent)

> 	   ....other qemu-nbd args...
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   include/block/nbd.h |  2 +-
>   nbd/server.c        | 12 +++++++-----
>   qemu-nbd.c          | 13 ++++++++++++-
>   qemu-nbd.texi       |  4 ++++
>   4 files changed, 24 insertions(+), 7 deletions(-)

> +++ b/nbd/server.c

> @@ -2153,7 +2153,9 @@ void nbd_client_new(NBDExport *exp,
>       if (tlscreds) {
>           object_ref(OBJECT(client->tlscreds));
>       }
> -    client->tlsaclname =3D g_strdup(tlsaclname);
> +    if (tlsauthz) {
> +        client->tlsauthz =3D g_strdup(tlsauthz);
> +    }

The 'if' is pointless; g_strdup(NULL) is safe.


> +++ b/qemu-nbd.c

> @@ -533,6 +535,7 @@ int main(int argc, char **argv)
>           { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>           { "trace", required_argument, NULL, 'T' },
>           { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> +        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },

Not your fault, but worth sorting these alphabetically?

Bummer that pre-patch, you could use '--tls' as an unambiguous=20
abbreviation for --tls-creds; now it is an ambiguous prefix (you have to=20
type --tls-c or --tls-a to get to the point of no ambiguity).  If we=20
really cared, we could add:

{ "t", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
{ "tl", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
{ "tls", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
{ "tls-", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },

since getopt_long() no longer reports ambiguity if there is an exact=20
match to what is otherwise the common prefix of two ambiguous options.=20
But I don't think backwards-compatibility on this front is worth=20
worrying about (generally, scripts don't rely on getopt_long()'s=20
unambiguous prefix handling).

> +++ b/qemu-nbd.texi
> @@ -91,6 +91,10 @@ of the TLS credentials object previously created wit=
h the --object
>   option.
>   @item --fork
>   Fork off the server process and exit the parent once the server is ru=
nning.
> +@item --tls-authz=3DID
> +Specify the ID of a qauthz object previously created with the

s/qauthz/authz-simple/ ?

> +--object option. This will be used to authorize users who
> +connect against their x509 distinguished name.

Sounds like someone is "connecting against their name", rather than=20
"authorizing against their name".  Better might be:

This will be used to authorize connecting users against their x509=20
distinguished name.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
