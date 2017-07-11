Received: from eggs.gnu.org ([2001:4830:134:3::10]:34975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyYP-0007IK-AK
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUyYO-0004cv-AE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:02:29 -0400
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-2-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f4ae4fe-4f24-7abe-b112-5a10be15ee02@redhat.com>
Date: Tue, 11 Jul 2017 12:02:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170711163748.17817-2-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pkero79jVXQUORBuULMdbjFgJCbqDJF7X"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: pass bdrv_* methods to
 bs->file by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pkero79jVXQUORBuULMdbjFgJCbqDJF7X
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <8f4ae4fe-4f24-7abe-b112-5a10be15ee02@redhat.com>
Subject: Re: [PATCH v4 1/4] block: pass bdrv_* methods to bs->file by default
 in block filters
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
 <20170711163748.17817-2-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv is a filter and does not
> implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them. This=

> commit makes `drv->is_filter =3D true` imply that these callbacks will =
be
> forwarded to bs->file by default, so disabling support for these
> functions must be done explicitly.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 21 +++++++++++++++++++--
>  include/block/block_int.h |  6 +++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)
> @@ -3778,6 +3786,9 @@ int bdrv_has_zero_init(BlockDriverState *bs)
>      if (bs->drv->bdrv_has_zero_init) {
>          return bs->drv->bdrv_has_zero_init(bs);
>      }
> +    if (bs->file && bs->drv->is_filter) {
> +        return bdrv_has_zero_init(bs->file->bs);
> +    }
> =20
>      /* safe default */
>      return 0;

Someday, we should probably clean this function (and all callback
implementations) to return bool rather than int.  But not this patch.

Certainly more conservative than the earlier versions.  I'd still trust
Kevin's review over mine, but looks okay to me.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pkero79jVXQUORBuULMdbjFgJCbqDJF7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZQSWAAoJEKeha0olJ0Nq4BMH/01r1yiECTUQvwTrUmqwgPCT
qDAGxPs6Lm7lCxjXmmxURKG0KzBwzpoJ9W0uS7ORPcDR+nxpiciZ2rVBg3YVGnny
Hk5KvzKkFXqqSNRh+pOoV5fFj++8p7K5Z9oHTc+YAKurpu96bB6womqh/EV9pDpc
R8qCkZE/2DXDj9xSQeS7h6QF8U6R53PlzoGn1GvsPhAwk1fUXG5Q78uQ/fsz5BdW
9mdveSmm4IoGIUTJD0kbmgATMcp19akGoUmDczlXSBGsHgPMNreAkC5MN2WCNCAv
uG0ozikTMfJxkLasGuaoVJUFJGKBD+//WG1x0KaHwUOMYfL2D/2znysc3Ulz3eg=
=NJUS
-----END PGP SIGNATURE-----

--pkero79jVXQUORBuULMdbjFgJCbqDJF7X--
