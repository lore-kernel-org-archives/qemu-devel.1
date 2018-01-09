Received: from eggs.gnu.org ([2001:4830:134:3::10]:48768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzwj-0001qr-1o
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzwi-0005WA-5E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:52:29 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
Date: Tue, 9 Jan 2018 13:52:17 -0600
MIME-Version: 1.0
In-Reply-To: <20171207155102.66622-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2BhM6DrxfGFe0n8ZOhB29DQYaegDU5ey6"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add nbd-server-remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2BhM6DrxfGFe0n8ZOhB29DQYaegDU5ey6
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <74fa9031-25d8-df0f-0690-c03ff377c0d9@redhat.com>
Subject: Re: [PATCH v2 3/6] qapi: add nbd-server-remove
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-4-vsementsov@virtuozzo.com>
In-Reply-To: <20171207155102.66622-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add command for export removing. It is needed for cases when we
> don't want to keep export after the operation on it was completed.
> The other example is temporary node, created with blockdev-add.
> If we want to delete it we should firstly remove corresponding
> NBD export.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block.json     | 18 ++++++++++++++++++
>  include/block/nbd.h |  3 ++-
>  blockdev-nbd.c      | 29 ++++++++++++++++++++++++++++-
>  nbd/server.c        | 25 ++++++++++++++++++++++---
>  4 files changed, 70 insertions(+), 5 deletions(-)
>=20
> diff --git a/qapi/block.json b/qapi/block.json
> index 503d4b287b..f83485c325 100644
> --- a/qapi/block.json
> +++ b/qapi/block.json
> @@ -228,6 +228,24 @@
>    'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
> =20
>  ##
> +# @nbd-server-remove:
> +#
> +# Remove NBD export by name.
> +#
> +# @name: Export name.
> +#
> +# @force: Whether active connections to the export should be closed. I=
f this
> +#         parameter is false the export only becomes hidden from clien=
ts (new
> +#         connections are impossible), and would be automatically free=
d after
> +#         all clients are disconnected (default false).

Unstated, but if the parameter is true, existing clients are forcefully
disconnected, possibly losing pending transactions.

Do we want a third mode in the middle, where the server starts replying
to all existing clients with ESHUTDOWN errors for all new requests
rather than abruptly disconnecting (no new I/O, but no forced disconnect
and pending in-flight transactions can still complete gracefully)?

> +#
> +# Returns: error if the server is not running or export is not found.
> +#
> +# Since: 2.12
> +##
> +{ 'command': 'nbd-server-remove', 'data': {'name': 'str', '*force': 'b=
ool'} }
> +

If we're okay with just the bool parameter, then this patch looks good;
but if we want a third mode, then we want '*force' to be an enum type.
So tentative:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2BhM6DrxfGFe0n8ZOhB29DQYaegDU5ey6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVHXEACgkQp6FrSiUn
Q2pbvgf/aB+u4mL1rtI7AAE56NG8UVokJzK3duAQShBB4qJEyHzARJO/mL9GLhjF
vz18MgCYaMoC+TFLbiyKX5WJ7+biDA30mnnQhK4zv8I+uSPMfj5lO4w/JxraqWD0
O/l8UIQ1i1y2PfU8QGuiL9jrenUL51banVbm8OVfxPaoELOpxJyyxfiYXkDhOg22
YyJKnM088zEbi1Mvn7tbx3NMyiX53B4eXwkURGmGgfH0XoMbprRf5ze1VbeP8FHp
EVCmU5bxS34Jb9zrjzq63faglxxbedJ7YgijFspokaRQF3qM9qyYvOHjI+KR0oaF
k0TYPg/0YBVkdVxaIt/LiNPOxiiPFg==
=46QW
-----END PGP SIGNATURE-----

--2BhM6DrxfGFe0n8ZOhB29DQYaegDU5ey6--
