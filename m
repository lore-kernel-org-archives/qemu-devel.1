Received: from eggs.gnu.org ([2001:4830:134:3::10]:33117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntVL-0001Ro-3x
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:34:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntVJ-0005jq-Vc
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:34:03 -0400
References: <20180809223117.7846-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4740306e-0053-5681-1655-d2dc035d916d@redhat.com>
Date: Fri, 10 Aug 2018 00:33:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5sXnihdEFNj2H1pM694rZKlaqR1WZGSTr"
Subject: Re: [Qemu-devel] [PATCH v2 00/11] block: Deal with filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5sXnihdEFNj2H1pM694rZKlaqR1WZGSTr
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <4740306e-0053-5681-1655-d2dc035d916d@redhat.com>
Subject: Re: [PATCH v2 00/11] block: Deal with filters
References: <20180809223117.7846-1-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-10 00:31, Max Reitz wrote:

[...]

> v2:
> - Patch 4: We must clear BDS.exact_filename for filter nodes, or we
>   basically end up with a random filename for them.  This is achieved b=
y
>   pulling the !drv->is_filter check into an inner condition.
>   (Fixes iotests 40 and 184)
>=20
> - Patch 7: iotest 228 tried to use QAPI's backing_file information
>   (which was very inconsistent, so with 228 doing some funky backing
>   stuff, it really showed) to get some idea of what qemu thinks about
>   the image header.  Let's make it use full-backing-filename (and that
>   now really reflects the image header).

*cough* *cough* *cough*

git-backport-diff against v1:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream pat=
ch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively

001/11:[----] [--] 'block: Mark commit and mirror as filter drivers'
002/11:[----] [--] 'blockdev: Check @replaces in blockdev_mirror_common'
003/11:[----] [--] 'block: Filtered children access functions'
004/11:[0005] [FC] 'block: Storage child access function'
005/11:[----] [--] 'block: Fix check_to_replace_node()'
006/11:[----] [--] 'iotests: Add tests for mirror @replaces loops'
007/11:[0012] [FC] 'block: Leave BDS.backing_file constant'
008/11:[----] [--] 'iotests: Add filter commit test cases'
009/11:[----] [--] 'iotests: Add filter mirror test cases'
010/11:[----] [--] 'iotests: Add test for commit in sub directory'
011/11:[----] [--] 'iotests: Test committing to overridden backing'

> Max Reitz (11):
>   block: Mark commit and mirror as filter drivers
>   blockdev: Check @replaces in blockdev_mirror_common
>   block: Filtered children access functions
>   block: Storage child access function
>   block: Fix check_to_replace_node()
>   iotests: Add tests for mirror @replaces loops
>   block: Leave BDS.backing_file constant
>   iotests: Add filter commit test cases
>   iotests: Add filter mirror test cases
>   iotests: Add test for commit in sub directory
>   iotests: Test committing to overridden backing
>=20
>  qapi/block-core.json           |   4 +
>  include/block/block.h          |   2 +
>  include/block/block_int.h      |  53 ++++-
>  block.c                        | 341 ++++++++++++++++++++++++++++-----=

>  block/backup.c                 |   8 +-
>  block/block-backend.c          |  16 +-
>  block/commit.c                 |  38 ++--
>  block/io.c                     |  47 +++--
>  block/mirror.c                 |  39 ++--
>  block/qapi.c                   |  38 ++--
>  block/snapshot.c               |  40 ++--
>  block/stream.c                 |  15 +-
>  blockdev.c                     | 167 ++++++++++++----
>  migration/block-dirty-bitmap.c |   4 +-
>  nbd/server.c                   |   8 +-
>  qemu-img.c                     |  24 ++-
>  tests/qemu-iotests/020         |  36 ++++
>  tests/qemu-iotests/020.out     |  10 +
>  tests/qemu-iotests/040         | 191 ++++++++++++++++++
>  tests/qemu-iotests/040.out     |   4 +-
>  tests/qemu-iotests/041         | 270 +++++++++++++++++++++++++-
>  tests/qemu-iotests/041.out     |   4 +-
>  tests/qemu-iotests/191.out     |   1 -
>  tests/qemu-iotests/228         |   6 +-
>  tests/qemu-iotests/228.out     |   6 +-
>  25 files changed, 1141 insertions(+), 231 deletions(-)
>=20



--5sXnihdEFNj2H1pM694rZKlaqR1WZGSTr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltswVQACgkQ9AfbAGHV
z0DVNggAglX/Y1oaE+jHh9w5kLTpufiEJJkny2tM6yHBSw9OtkCzafrqkrdq1CvT
WTsvxzhu3/TXoxe8Z9v2sbHAtxjy+imyJX5u6ikXVI36jMfYbZpW6uWau7JxV2+F
diWuteGqp8xl/VwpZ9JqzdGegsqKpqeCiv02yiZOANLZPQoxTVK1Rm+IF7qniLyY
MovuvFrwLxy8/0xDP0avQBGY+0IqU/soQu3jOdzIxz8itJs1/0WBpyvsqgD0ULZ3
EgKu/i0oM3czlEbXffg7lAW1US80FPYrbwhfOI+ifiHJyT4SG9W7/O1e4uwkS6Iu
rijxl8OrcBPP4DsgScVZOJA9L445EA==
=vrM1
-----END PGP SIGNATURE-----

--5sXnihdEFNj2H1pM694rZKlaqR1WZGSTr--
