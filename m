Received: from eggs.gnu.org ([2001:4830:134:3::10]:40837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS5Vw-0005Ek-2f
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS5Vv-0005rK-0C
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 13:52:00 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-4-el13635@mail.ntua.gr>
	<69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
Date: Mon, 3 Jul 2017 12:51:45 -0500
MIME-Version: 1.0
In-Reply-To: <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gWq6ec5mLV3KCwBcmAMdcqLquJgwVAB5D"
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gWq6ec5mLV3KCwBcmAMdcqLquJgwVAB5D
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <a3c3ad15-ae75-4eae-f74e-72da4e96d980@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] block: add default implementations
 for bdrv_co_get_block_status()
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-4-el13635@mail.ntua.gr>
 <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
In-Reply-To: <69eaa5de-6e3c-d520-cdc6-35a6298aee94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 11:12 AM, Eric Blake wrote:
> On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
>> bdrv_co_get_block_status_from_file() and
>> bdrv_co_get_block_status_from_backing() set *file to bs->file and
>> bs->backing respectively, so that bdrv_co_get_block_status() can recur=
se
>> to them. Future block drivers won't have to duplicate code to implemen=
t
>> this.
>>
>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block/blkdebug.c          | 12 +-----------
>>  block/commit.c            | 12 +-----------
>>  block/io.c                | 24 ++++++++++++++++++++++++
>>  block/mirror.c            | 12 +-----------
>>  include/block/block_int.h | 16 ++++++++++++++++
>>  5 files changed, 43 insertions(+), 33 deletions(-)
>=20
> My [still-needs-rebasing] part 3 series converting
> bdrv_co_get_block_status to byte-based will be impacted by this, but I'=
d
> rather yours go in first and I can deal with the rebase fallout.

In fact, my rebase fallout is to completely delete
bdrv_co_get_block_status_from_file().  Why? Because blkdebug is the only
client, but I want to enhance blkdebug to add in-place assert()ions that
the values passed by the block layer are properly aligned to
bs->bl.request_alignment (matching what blkdebug does for read and write
- after all, if a device cannot access smaller than a given alignment
for a read, it should not be able to report different statuses half-way
through that granularity).  However, in-place assertions are no longer
generic, so we no longer have a client of a generic helper function
referring to bs->file.

Which means you are REALLY left only with commit and mirror as the two
functions that have a common implementation of pointing back to backing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gWq6ec5mLV3KCwBcmAMdcqLquJgwVAB5D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWoQxAAoJEKeha0olJ0NqOzYH/jc05Gp8/Fes59qe8aUzfQo+
GtHN8m10F6YDhbgwtD2iQqe8Ae5BmuAm6lxf9FM8JZ3ivrAgfD9mzaF4k0qdDkqE
oNx+otiGQpn+Nhq70PecSV5PntObiTL3T8paWf1lZOS+FLhWCViyzqDDJzxc5uZZ
Gu4cMy65zo1cebzz6Fid+t7gQwuXN04xN/i7N6I7DOs7Sx15IcZmkwhWzbZLKben
zr9fkynqeTPu6yfURcQNgjSlSVlBS4LskWycDJu9tMaEpH4NmCSuLdAu/sDrK1/o
R5KzJJrLwFICd+ciFUgh1BjjZmX49UmsxShR8nrTVjAM8h2VSFYRgjld7U/xjUY=
=oKRX
-----END PGP SIGNATURE-----

--gWq6ec5mLV3KCwBcmAMdcqLquJgwVAB5D--
