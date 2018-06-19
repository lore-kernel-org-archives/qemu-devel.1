Received: from eggs.gnu.org ([2001:4830:134:3::10]:43545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMxI-00084Q-HZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVMxH-0003tJ-J4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 16:10:20 -0400
References: <20180615155103.11924-1-berrange@redhat.com>
	<20180615155103.11924-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d10a7833-5e37-52cb-cb5d-25018313469a@redhat.com>
Date: Tue, 19 Jun 2018 15:10:12 -0500
MIME-Version: 1.0
In-Reply-To: <20180615155103.11924-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] nbd: allow authorization with
 nbd-server-start QMP command
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
> As with the previous patch to qemu-nbd, the nbd-server-start QMP comman=
d
> also needs to be able to specify authorization when enabling TLS encryp=
tion.
>=20
> First the client must create a QAuthZ object instance using the
> 'object-add' command:
>=20
>     {
>       'execute': 'object-add',
>       'arguments': {
>         'qom-type': 'authz-simple',
>         'id': 'authz0',
>         'parameters': {
>           'policy': 'deny',
>           'rules': [
>             {
>               'match': '*CN=3Dfred',
>               'policy': 'allow'
>             }
>           ]
>         }
>       }
>     }
>=20
> They can then reference this in the new 'tls-authz' parameter when
> executing the 'nbd-server-start' command:
>=20
>     {
>       'execute': 'nbd-server-start',
>       'arguments': {
>         'addr': {
>             'type': 'inet',
>             'host': '127.0.0.1',
>             'port': '9000'
>         },
>         'tls-creds': 'tls0',
>         'tls-authz': 'authz0'
>       }
>     }

Is it worth using a discriminated union (string vs. QAuthZ) so that one=20
could specify the authz policy inline rather than as a separate object,=20
for convenience?  But that would be fine as a followup patch, if we even=20
want it.

>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>   blockdev-nbd.c      | 14 +++++++++++---
>   hmp.c               |  2 +-
>   include/block/nbd.h |  2 +-
>   qapi/block.json     |  4 +++-
>   4 files changed, 16 insertions(+), 6 deletions(-)
>=20

> @@ -118,6 +121,10 @@ void nbd_server_start(SocketAddress *addr, const c=
har *tls_creds,
>           }
>       }
>  =20
> +    if (tls_authz) {
> +        nbd_server->tlsauthz =3D g_strdup(tls_authz);
> +    }

Pointless 'if'; g_strdup() does the right thing.

> +++ b/qapi/block.json
> @@ -197,6 +197,7 @@
>   #
>   # @addr: Address on which to listen.
>   # @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
> +# @tls-authz: (optional) ID of the QAuthZ authorization object. Since =
2.13

No need for the string '(optional)' (I thought we killed those uses when=20
we automated the documentation generation - but obviously a few were=20
left behind).

s/2.13/3.0/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
