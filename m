Received: from eggs.gnu.org ([2001:4830:134:3::10]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSwe0-0002VQ-TK
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSwdz-0003eY-S3
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:35:52 -0400
References: <20170703221456.30817-1-eblake@redhat.com>
	<20170703221456.30817-4-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3ff30569-67ca-ce9a-02c6-55e7d9150aed@redhat.com>
Date: Wed, 5 Jul 2017 21:35:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170703221456.30817-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oL1gMJhIxlDJNNSoiEORvt7og4dTLAmMj"
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oL1gMJhIxlDJNNSoiEORvt7og4dTLAmMj
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org,
 el13635@mail.ntua.gr, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com
Message-ID: <3ff30569-67ca-ce9a-02c6-55e7d9150aed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/15] block: Add flag to avoid wasted
 work in bdrv_is_allocated()
References: <20170703221456.30817-1-eblake@redhat.com>
 <20170703221456.30817-4-eblake@redhat.com>
In-Reply-To: <20170703221456.30817-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 05:14 PM, Eric Blake wrote:
> Not all callers care about which BDS owns the mapping for a given
> range of the file.  In particular, bdrv_is_allocated() cares more
> about finding the largest run of allocated data from the guest
> perspective, whether or not that data is consecutive from the
> host perspective.  Therefore, doing subsequent refinements such
> as checking how much of the format-layer allocation also satisfies
> BDRV_BLOCK_ZERO at the protocol layer is wasted work - in the best
> case, it just costs extra CPU cycles during a single
> bdrv_is_allocated(), but in the worst case, it results in a smaller
> *pnum, and forces callers to iterate through more status probes when
> visiting the entire file for even more extra CPU cycles.
>=20
> This patch only optimizes the block layer.  But subsequent patches
> will tweak the driver callback to be byte-based, and in the process,
> can also pass this hint through to the driver.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20

> @@ -1810,12 +1817,13 @@ static int64_t coroutine_fn bdrv_co_get_block_s=
tatus(BlockDriverState *bs,
>          }
>      }
>=20
> -    if (local_file && local_file !=3D bs &&
> +    if (!allocation && local_file && local_file !=3D bs &&
>          (ret & BDRV_BLOCK_DATA) && !(ret & BDRV_BLOCK_ZERO) &&
>          (ret & BDRV_BLOCK_OFFSET_VALID)) {
>          int file_pnum;
>=20
> -        ret2 =3D bdrv_co_get_block_status(local_file, ret >> BDRV_SECT=
OR_BITS,
> +        ret2 =3D bdrv_co_get_block_status(local_file, true,
> +                                        ret >> BDRV_SECTOR_BITS,
>                                          *pnum, &file_pnum, NULL);
>          if (ret2 >=3D 0) {
>              /* Ignore errors.  This is just providing extra informatio=
n, it

Hmm. My initial thinking here was that if we already have a good primary
status, we want our secondary status (where we are probing bs->file for
whether we can add BDRV_BLOCK_ZERO) to be as fast as possible, so I
hard-coded the answer that favors is_allocated (I have to be careful
describing this, since v3 will switch from 'bool allocated=3Dtrue' to
'bool mapping=3Dfalse' to express that same request).  But it turns out
that, at least for file-posix.c (for that matter, for several protocol
drivers), it's a LOT faster to just blindly state that the entire file
is allocated and data than it is to lseek(SEEK_HOLE).  So favoring
allocation status instead of mapping status defeats the purpose, and
this should be s/true/allocation/ (which is always false at this point)
[or conversely s/false/mapping/, which is always true, in v3].

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oL1gMJhIxlDJNNSoiEORvt7og4dTLAmMj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZXaH4AAoJEKeha0olJ0NqV0MH/2xZMOgxRxFBhMiPo1C5MX6C
71j+fiEzqm2fWFcgchRrB+c32k3EhPC56WGVekAWDPdYaKpaz0hjG/uuzyGHyVUk
QSqV/4nXGxqhMIv5W9RsMTesnuPreGJJmKkuM03N6fIPta60aRWLwtLepxRTa0S5
8xqquuWbS1Sa0uxHcS6Xr6FSMs2WT3RETppNbG622lSK2Tge5/P3LFJT0SokQcE0
QxewMQvehE/WBgLUQrUwPHgqbznweAmsHTIqfi2ctKzQcighVVr8iIbB5Q52q9a0
kA/ZTHLcgYN4+9j6DAlEfBeFzHfbyCBXWscuUh+boitF1vqlcK2rPswG5DJHSvM=
=xRtg
-----END PGP SIGNATURE-----

--oL1gMJhIxlDJNNSoiEORvt7og4dTLAmMj--
