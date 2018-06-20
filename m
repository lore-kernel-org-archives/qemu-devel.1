Received: from eggs.gnu.org ([2001:4830:134:3::10]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVddL-0001nP-5T
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVddK-00015O-9E
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:58:51 -0400
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d25692fc-8aec-295b-6ca6-39d2e4f691c3@redhat.com>
Date: Wed, 20 Jun 2018 08:58:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180620121423.16979-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/6] qemu-nbd: add support for
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On 06/20/2018 07:14 AM, Daniel P. Berrang=C3=A9 wrote:
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

Is the space in O=3D intentional?

>=20
> use:
>=20
>    qemu-nbd --object tls-creds-x509,id=3Dtls0,dir=3D/home/berrange/qemu=
tls,\
>                      endpoint=3Dserver,verify-peer=3Dyes \
>             --object authz-simple,id=3Dauth0,identity=3DCN=3Dlaptop.exa=
mple.com,,\
>                      O=3DExample Org,,L=3DLondon,,ST=3DLondon,,C=3DGB \

you need shell quoting to preserve the space. Also, the indentation=20
breaks the intent that these long lines are single arguments, not=20
separate arguments.

>             --tls-creds tls0 \
>             --tls-authz authz0
> 	   ....other qemu-nbd args...

Is it also worth a sample command line using JSON syntax?

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   include/block/nbd.h |  2 +-
>   nbd/server.c        | 10 +++++-----
>   qemu-nbd.c          | 13 ++++++++++++-
>   qemu-nbd.texi       |  4 ++++
>   4 files changed, 22 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
