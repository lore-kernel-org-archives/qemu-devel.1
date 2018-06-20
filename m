Received: from eggs.gnu.org ([2001:4830:134:3::10]:38159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVdjw-0004vh-CR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVdjv-0003zK-H4
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:05:40 -0400
References: <20180620121423.16979-1-berrange@redhat.com>
	<20180620121423.16979-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <205e17cb-30f6-ace2-d8eb-e6a60d84731d@redhat.com>
Date: Wed, 20 Jun 2018 09:05:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180620121423.16979-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd: allow authorization with
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Juan Quintela <quintela@redhat.com>

On 06/20/2018 07:14 AM, Daniel P. Berrang=C3=A9 wrote:
> From: "Daniel P. Berrange" <berrange@redhat.com>

I thought you preferred the UTF-8 accent in your Author lines these=20
days?  Or is this because this patch has been sitting around in your=20
local repo prior to the point where you switched your git config author=20
spelling? (Also applies to S-o-b in the series)

>=20
> As with the previous patch to qemu-nbd, the nbd-server-start QMP comman=
d
> also needs to be able to specify authorization when enabling TLS encryp=
tion.
>=20
> First the client must create a QAuthZ object instance using the
> 'object-add' command:
>=20

> They can then reference this in the new 'tls-authz' parameter when
> executing the 'nbd-server-start' command:
>=20

> @@ -132,11 +137,12 @@ void nbd_server_start(SocketAddress *addr, const =
char *tls_creds,
>  =20
>   void qmp_nbd_server_start(SocketAddressLegacy *addr,
>                             bool has_tls_creds, const char *tls_creds,
> +                          bool has_tls_authz, const char *tls_authz,
>                             Error **errp)
>   {
>       SocketAddress *addr_flat =3D socket_address_flatten(addr);
>  =20
> -    nbd_server_start(addr_flat, tls_creds, errp);
> +    nbd_server_start(addr_flat, tls_creds, tls_authz, errp);

Relies on QMP generated code setting tls_authz =3D NULL if has_tls_authz=20
is false (but no different than the fact that we already relied on it=20
for tls_creds).  Someday it would be nice to get rid of the has_FOO for=20
optional strings, but that's not your problem.

> +++ b/qapi/block.json
> @@ -197,6 +197,11 @@
>   #
>   # @addr: Address on which to listen.
>   # @tls-creds: (optional) ID of the TLS credentials object. Since 2.6
> +# @tls-authz: ID of the QAuthZ authorization object used to validate
> +#             the client's x509 distinguished name. This object is
> +#             is only resolved at time of use, so can be deleted and
> +#             recreated on the fly while the NBD server is active.
> +#             If missing, it will default to denying access. Since 3.0
>   #
>   # Returns: error if the server is already running.
>   #
> @@ -204,7 +209,8 @@
>   ##
>   { 'command': 'nbd-server-start',
>     'data': { 'addr': 'SocketAddressLegacy',
> -            '*tls-creds': 'str'} }
> +            '*tls-creds': 'str',
> +            '*tls-authz': 'str'} }

Reviewed-by: Eric Blake <eblake@redhat.com>

Although patch 1 and 2 touch NBD, I'm happy for Dan to be the one that=20
merges it as part of the larger series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
