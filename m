Received: from eggs.gnu.org ([2001:4830:134:3::10]:53771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJnis-0007bB-8r
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 17:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gJnZ0-00070D-JH
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 17:41:44 -0500
References: <20181009132330.7549-1-berrange@redhat.com>
	<20181009132330.7549-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1baede2d-7113-be2c-62dd-9f5ce6425bb1@redhat.com>
Date: Mon, 5 Nov 2018 16:41:09 -0600
MIME-Version: 1.0
In-Reply-To: <20181009132330.7549-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/6] qemu-nbd: add support for
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, libvir-list@redhat.com, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 10/9/18 8:23 AM, Daniel P. Berrang=C3=A9 wrote:
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
> whose x509 certificate distinguished name is
>=20
>     CN=3Dlaptop.example.com,O=3DExample Org,L=3DLondon,ST=3DLondon,C=3D=
GB
>=20
> use:
>=20
>    qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemu=
tls,\
>                      endpoint=3Dserver,verify-peer=3Dyes \
>             --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exa=
mple.com,,\
>                      O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \

Missing shell quoting around the space in 'Example Org'. It's also=20
fairly obvious that actual shell commands can't have leading space=20
between \-newline line continuations.

>             --tls-creds tls0 \
>             --tls-authz authz0
> 	   ....other qemu-nbd args...
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   include/block/nbd.h |  2 +-
>   nbd/server.c        | 10 +++++-----
>   qemu-nbd.c          | 13 ++++++++++++-
>   qemu-nbd.texi       |  4 ++++
>   4 files changed, 22 insertions(+), 7 deletions(-)
>=20

> +++ b/qemu-nbd.c
> @@ -52,6 +52,7 @@
>   #define QEMU_NBD_OPT_TLSCREDS      261
>   #define QEMU_NBD_OPT_IMAGE_OPTS    262
>   #define QEMU_NBD_OPT_FORK          263
> +#define QEMU_NBD_OPT_TLSAUTHZ      264
>  =20

> @@ -532,6 +534,7 @@ int main(int argc, char **argv)
>           { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>           { "trace", required_argument, NULL, 'T' },
>           { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> +        { "tls-authz", no_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
>           { NULL, 0, NULL, 0 }
>       };

Missing a change to qemu-nbd --help to describe the new option.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
