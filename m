Received: from eggs.gnu.org ([2001:4830:134:3::10]:57703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXER-0001lo-QI
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXEQ-0007yV-Nz
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:48:27 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<293e7df1bffd17584b6e36d11efb097ea48cd214.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5ea8a9d1-eea9-5447-32ec-b2565c19287f@redhat.com>
Date: Wed, 5 Sep 2018 14:48:13 +0200
MIME-Version: 1.0
In-Reply-To: <293e7df1bffd17584b6e36d11efb097ea48cd214.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YyQi5HqkEfeDvz4J06qJ3zxIzdo6kR0FZ"
Subject: Re: [Qemu-devel] [PATCH v2 06/10] block: Forbid trying to change
 unsupported options during reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YyQi5HqkEfeDvz4J06qJ3zxIzdo6kR0FZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5ea8a9d1-eea9-5447-32ec-b2565c19287f@redhat.com>
Subject: Re: [PATCH v2 06/10] block: Forbid trying to change unsupported
 options during reopen
References: <cover.1535983918.git.berto@igalia.com>
 <293e7df1bffd17584b6e36d11efb097ea48cd214.1535983918.git.berto@igalia.com>
In-Reply-To: <293e7df1bffd17584b6e36d11efb097ea48cd214.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> The bdrv_reopen_prepare() function checks all options passed to each
> BlockDriverState (in the reopen_state->options QDict) and makes all
> necessary preparations to apply the option changes requested by the
> user.
>=20
> Options are removed from the QDict as they are processed, so at the
> end of bdrv_reopen_prepare() only the options that can't be changed
> are left. Then a loop goes over all remaining options and verifies
> that the old and new values are identical, returning an error if
> they're not.
>=20
> The problem is that at the moment there are options that are removed
> from the QDict although they can't be changed. The consequence of this
> is any modification to any of those options is silently ignored:
>=20
>    (qemu) qemu-io virtio0 "reopen -o discard=3Don"
>=20
> This happens when all options from bdrv_runtime_opts are removed
> from the QDict but then only a few of them are processed. Since
> it's especially important that "node-name" and "driver" are not
> changed, the code puts them back into the QDict so they are checked
> at the end of the function. Instead of putting only those two options
> back into the QDict, this patch puts all unprocessed options using
> qemu_opts_to_qdict().
>=20
> update_flags_from_options() also needs to be modified to prevent
> BDRV_OPT_CACHE_NO_FLUSH, BDRV_OPT_CACHE_DIRECT and BDRV_OPT_READ_ONLY
> from going back to the QDict.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--YyQi5HqkEfeDvz4J06qJ3zxIzdo6kR0FZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluP0I0ACgkQ9AfbAGHV
z0BPlwf9FSjXKrdcGqCUuiVgR+BLv31mQYNH5bzWJWGnmfleeb6kED9uPEdchFrz
DXNYCsnR5nYDQpG+lMsZQU53iIihGw6Eb6sYXIm3ayIRKjt5WchFTPghskx5j701
nOU1y1vxYuv0rJEICWxCSlO6adsczklgeWNrdCqW+T6A2dfotU00nvr2jlCyJNP9
v0Klp4mHQb9GptAMKBcMYoalLlegQnRCt2p0/8OvT/LTLNGXrfxLkONe0DMJ0/9j
GgtrscrBVPIxZQTL5CF2xYjA4i2/6DGfzdSu384of1W5ghPF0e1asb6Q//sEtwTT
xC0UTe+89hZo14fGwpOuyE+Jx6KwVQ==
=MIez
-----END PGP SIGNATURE-----

--YyQi5HqkEfeDvz4J06qJ3zxIzdo6kR0FZ--
