Received: from eggs.gnu.org ([2001:4830:134:3::10]:49331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAK30-0001Lj-Dl
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAK2y-0002V5-Vv
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:44:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAK2y-0002Ui-N0
	for qemu-devel@nongnu.org; Mon, 15 May 2017 13:44:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6E4E2800AE
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 17:44:29 +0000 (UTC)
References: <1494866344-11013-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <764477dc-99b9-ead7-ba97-8c0f6fa4bd9b@redhat.com>
Date: Mon, 15 May 2017 12:44:25 -0500
MIME-Version: 1.0
In-Reply-To: <1494866344-11013-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TM3jgeVQVFFl97j8giTduBDKew3d0uenF"
Subject: Re: [Qemu-devel] [PATCH] sockets: Plug memory leak in
 socket_address_flatten()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TM3jgeVQVFFl97j8giTduBDKew3d0uenF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <764477dc-99b9-ead7-ba97-8c0f6fa4bd9b@redhat.com>
Subject: Re: [PATCH] sockets: Plug memory leak in socket_address_flatten()
References: <1494866344-11013-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1494866344-11013-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 11:39 AM, Markus Armbruster wrote:
> socket_address_flatten() leaks a SocketAddress when its argument is
> null.  Happens when opening a ChardevBackend of type 'udp' that is
> configured without a local address.  Screwed up in commit bd269ebc due
> to last minute semantic conflict resolution.  Spotted by Coverity.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  util/qemu-sockets.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Matches the fix I had proposed here against the v2 pull request:
https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01825.html

I guess in the confusion of the rebasing, you didn't quite implement it
in v3 the way I had proposed.

>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index d8183f7..b39ae74 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1338,12 +1338,14 @@ char *socket_address_to_string(struct SocketAdd=
ress *addr, Error **errp)
> =20
>  SocketAddress *socket_address_flatten(SocketAddressLegacy *addr_legacy=
)
>  {
> -    SocketAddress *addr =3D g_new(SocketAddress, 1);
> +    SocketAddress *addr;
> =20
>      if (!addr_legacy) {
>          return NULL;
>      }
> =20
> +    addr =3D g_new(SocketAddress, 1);
> +
>      switch (addr_legacy->type) {
>      case SOCKET_ADDRESS_LEGACY_KIND_INET:
>          addr->type =3D SOCKET_ADDRESS_TYPE_INET;
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TM3jgeVQVFFl97j8giTduBDKew3d0uenF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGej5AAoJEKeha0olJ0NqBmAH/0YMmOpRvI8k43CPnw+Yahpz
Nic8hiLeMH6iJUd/icrO5Yko83AI0me1PniXEdTYaYFnF/krS9PHSD26c5is0tEh
krwbpNfBn7dcLXa9m3Ae19CjQWUbST+IT5Ncp24z6JaYFn9u1ABo0lpJGUj8/TsW
N+8u0REJpyMyJnou057fCZ3eKeRKiMvg3hbbQSm+DM1+S1Lqr5t4u4Wjm6WHPiws
UYlt/pslFoUJCtcyiLx5vJffhpAA6QvWxpmyXP1dvgeEZoco5P9X6uq+QtWXVO80
J2VvceG44ci9fqTONept7i7KD65vpVTyLDmy7YuBxYCFpi9iYsmVsB+nXIIL95U=
=3d5T
-----END PGP SIGNATURE-----

--TM3jgeVQVFFl97j8giTduBDKew3d0uenF--
