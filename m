Received: from eggs.gnu.org ([2001:4830:134:3::10]:57109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fduha-0003ad-Io
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:49:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fduhZ-00035S-5r
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 05:49:26 -0400
References: <20180628000745.4477-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <86ba537d-3b77-c7d1-ac46-c85f18faf5ca@redhat.com>
Date: Fri, 13 Jul 2018 11:49:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u45TnSjS6V6LcXmDbubxE0cOpGxJG4LWU"
Subject: Re: [Qemu-devel] [PATCH v9 00/31] block: Fix some filename
 generation issues
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
--u45TnSjS6V6LcXmDbubxE0cOpGxJG4LWU
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <86ba537d-3b77-c7d1-ac46-c85f18faf5ca@redhat.com>
Subject: Re: [PATCH v9 00/31] block: Fix some filename generation issues
References: <20180628000745.4477-1-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping =E2=80=93 any thoughts on the design, Kevin?


(Continuing to see how much of a mess our backing filename handling is
(half of the time, bs->backing_file is seen as a value in the image
header (so relative paths are interpreted relatively to the overlay),
half of the time it is seen as a cache of bs->backing->bs->filename (so
relative paths are given relatively to qemu)), I am nearly inclined to
move off the first part of this series that deals with detecting changed
backing files until later, when I try to tackle that bs->backing_file
issue.)


On 2018-06-28 02:07, Max Reitz wrote:
> Once more, I=E2=80=99ll spare both me and you another iteration of the =
cover
> letter, so see here:
>=20
> http://lists.nongnu.org/archive/html/qemu-block/2017-09/msg01030.html
>=20
> (Although this series no longer includes a @base-directory option.)
>=20
> In regards to the last version, the biggest change is that I dropped
> backing_overridden and instead try to compare the filename from the
> image header with the filename of the actual backing BDS to find out
> whether the backing file has been overridden.
>=20
> In order that this doesn=E2=80=99t break whenever the header contains a=
 slightly
> unusual (=E2=80=9Cnon-canonical=E2=80=9D) backing filename (e.g. =E2=80=
=9Cfile:foo.qcow2=E2=80=9D or
> =E2=80=9Cnbd:localhost:10809=E2=80=9D instead of =E2=80=9Cnbd://localho=
st:10809=E2=80=9D, i.e. something
> different from what bdrv_refresh_filename() would generate), when the
> reference filename in the BDS (auto_backing_file) is used to open the
> backing file, it is updated from the backing BDS's resulting filename.
>=20
>=20
> All (I hope) changes in v9:
> - Rebase (warranting an NVME patch)
>=20
> - Dropped backing_overridden, switched to the comparison described abov=
e
>   (and dealt with the fallout, for example test 191 can now stay
>   unchanged)
>=20
> - Removed all existing bdrv_refresh_filename() calls and moved them to
>   the users of BDS.filename (first patch) -- otherwise, I got iotest
>   failure (because it's hard to reflect all graph changes properly with=

>   a =E2=80=9Cpushing=E2=80=9D bdrv_refresh_filename()), and I don't eve=
n want to
>   remember how 191 broke without this change.
>=20
> - Renamed =E2=80=9Csignificant options=E2=80=9D to =E2=80=9Cstrong opti=
ons=E2=80=9D
>=20
> - Implicit nodes should be completely skipped in
>   bdrv_refresh_filename(), including setting of bs->full_open_options
>   (patch 3)
>=20
> - vmdk_gather_child_options() failed to set backing=3Dnull when the ima=
ge
>   header asked for a backing file, but the user forbid its use
>=20
> - Added the penultimate patch which makes json:{} filenames for explici=
t
>   internal nodes kind of working?
>   (When you specify @filter-node e.g. for block-commit, the node should=

>   be visible, so it may appear in a json:{} filename; but creating that=

>   node did not take a real options QDict, so it was lacking the @driver=

>   option, and that was a bit sad.)
>=20
> - Dropped a superfluous =E2=80=9Csuspend.=E2=80=9D in blkdebug
>=20
> - Dropped the first patch of v8
>=20
> - Restyled some comments (=E2=80=9C/*=E2=80=9D on its own line where =E2=
=80=9C*/=E2=80=9D is on its own
>   line)
>=20
> - Fixed mention of "NBD" in the NFS patch (18)
>=20
>=20
> git-backport-diff against v8:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/31:[down] 'block: Use bdrv_refresh_filename() to pull'
> 002/31:[----] [--] 'block: Use children list in bdrv_refresh_filename'
> 003/31:[down] 'block: Skip implicit nodes for filename info'
> 004/31:[down] 'block: Add BDS.auto_backing_file'
> 005/31:[0052] [FC] 'block: Respect backing bs in bdrv_refresh_filename'=

> 006/31:[down] 'iotests.py: Add filter_imgfmt()'
> 007/31:[down] 'iotests.py: Add node_info()'
> 008/31:[down] 'iotests: Add test for backing file overrides'
> 009/31:[----] [--] 'block: Make path_combine() return the path'
> 010/31:[0016] [FC] 'block: bdrv_get_full_backing_filename_from_...'s re=
t. val.'
> 011/31:[0001] [FC] 'block: bdrv_get_full_backing_filename's ret. val.'
> 012/31:[0022] [FC] 'block: Add bdrv_make_absolute_filename()'
> 013/31:[0003] [FC] 'block: Fix bdrv_find_backing_image()'
> 014/31:[0001] [FC] 'block: Add bdrv_dirname()'
> 015/31:[----] [--] 'blkverify: Make bdrv_dirname() return NULL'
> 016/31:[----] [-C] 'quorum: Make bdrv_dirname() return NULL'
> 017/31:[----] [-C] 'block/nbd: Make bdrv_dirname() return NULL'
> 018/31:[0003] [FC] 'block/nfs: Implement bdrv_dirname()'
> 019/31:[0014] [FC] 'block: Use bdrv_dirname() for relative filenames'
> 020/31:[----] [--] 'iotests: Add quorum case to test 110'
> 021/31:[down] 'block: Add strong_runtime_opts to BlockDriver'
> 022/31:[0037] [FC] 'block: Add BlockDriver.bdrv_gather_child_options'
> 023/31:[0084] [FC] 'block: Generically refresh runtime options'
> 024/31:[0076] [FC] 'block: Purify .bdrv_refresh_filename()'
> 025/31:[0005] [FC] 'block: Do not copy exact_filename from format file'=

> 026/31:[down] 'block/nvme: Fix bdrv_refresh_filename()'
> 027/31:[----] [--] 'block/curl: Harmonize option defaults'
> 028/31:[----] [-C] 'block/curl: Implement bdrv_refresh_filename()'
> 029/31:[----] [--] 'block/null: Generate filename even with latency-ns'=

> 030/31:[down] 'block: BDS options may lack the "driver" option'
> 031/31:[down] 'iotests: Test json:{} filenames of internal BDSs'
>=20
>=20
> Max Reitz (31):
>   block: Use bdrv_refresh_filename() to pull
>   block: Use children list in bdrv_refresh_filename
>   block: Skip implicit nodes for filename info
>   block: Add BDS.auto_backing_file
>   block: Respect backing bs in bdrv_refresh_filename
>   iotests.py: Add filter_imgfmt()
>   iotests.py: Add node_info()
>   iotests: Add test for backing file overrides
>   block: Make path_combine() return the path
>   block: bdrv_get_full_backing_filename_from_...'s ret. val.
>   block: bdrv_get_full_backing_filename's ret. val.
>   block: Add bdrv_make_absolute_filename()
>   block: Fix bdrv_find_backing_image()
>   block: Add bdrv_dirname()
>   blkverify: Make bdrv_dirname() return NULL
>   quorum: Make bdrv_dirname() return NULL
>   block/nbd: Make bdrv_dirname() return NULL
>   block/nfs: Implement bdrv_dirname()
>   block: Use bdrv_dirname() for relative filenames
>   iotests: Add quorum case to test 110
>   block: Add strong_runtime_opts to BlockDriver
>   block: Add BlockDriver.bdrv_gather_child_options
>   block: Generically refresh runtime options
>   block: Purify .bdrv_refresh_filename()
>   block: Do not copy exact_filename from format file
>   block/nvme: Fix bdrv_refresh_filename()
>   block/curl: Harmonize option defaults
>   block/curl: Implement bdrv_refresh_filename()
>   block/null: Generate filename even with latency-ns
>   block: BDS options may lack the "driver" option
>   iotests: Test json:{} filenames of internal BDSs
>=20
>  include/block/block.h         |  16 +-
>  include/block/block_int.h     |  48 +++-
>  block.c                       | 505 ++++++++++++++++++++++------------=

>  block/blkdebug.c              |  70 ++---
>  block/blkverify.c             |  29 +-
>  block/commit.c                |   3 +-
>  block/crypto.c                |   8 +
>  block/curl.c                  |  55 +++-
>  block/gluster.c               |  19 ++
>  block/iscsi.c                 |  18 ++
>  block/mirror.c                |   3 +-
>  block/nbd.c                   |  46 ++--
>  block/nfs.c                   |  54 ++--
>  block/null.c                  |  32 ++-
>  block/nvme.c                  |  27 +-
>  block/qapi.c                  |  16 +-
>  block/qcow.c                  |  14 +-
>  block/qcow2.c                 |  17 +-
>  block/qed.c                   |   7 +-
>  block/quorum.c                |  71 +++--
>  block/raw-format.c            |  11 +-
>  block/rbd.c                   |  14 +
>  block/replication.c           |  10 +-
>  block/sheepdog.c              |  12 +
>  block/ssh.c                   |  12 +
>  block/throttle.c              |   7 +
>  block/vhdx-log.c              |   1 +
>  block/vmdk.c                  |  43 ++-
>  block/vpc.c                   |  11 +-
>  block/vvfat.c                 |  12 +
>  block/vxhs.c                  |  11 +
>  blockdev.c                    |   8 +
>  qemu-img.c                    |  12 +-
>  tests/qemu-iotests/051.out    |   8 +-
>  tests/qemu-iotests/051.pc.out |   8 +-
>  tests/qemu-iotests/110        |  29 +-
>  tests/qemu-iotests/110.out    |   9 +-
>  tests/qemu-iotests/223        | 235 ++++++++++++++++
>  tests/qemu-iotests/223.out    |  84 ++++++
>  tests/qemu-iotests/224        | 139 ++++++++++
>  tests/qemu-iotests/224.out    |  18 ++
>  tests/qemu-iotests/group      |   2 +
>  tests/qemu-iotests/iotests.py |  10 +
>  43 files changed, 1374 insertions(+), 390 deletions(-)
>  create mode 100755 tests/qemu-iotests/223
>  create mode 100644 tests/qemu-iotests/223.out
>  create mode 100755 tests/qemu-iotests/224
>  create mode 100644 tests/qemu-iotests/224.out
>=20



--u45TnSjS6V6LcXmDbubxE0cOpGxJG4LWU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltIdZsACgkQ9AfbAGHV
z0DpSQf/dX/N8/pvjhn8mHsuPUsd3/VZQFOtkB3Khe4NwMBnRnaovR1SnB7UUtJ5
oRxzXRhC6O51MoPb2tBbqO/a9nADAIB/CqN9zDPZ2HjvNSjOgZDA36cu91P5EIz0
mWuOnleoSiPUMuGXYyBuc1U5TV0QD5V3P0ht9ZLlIjL93D6I23/0LorKzyhwrwx9
8FQS0EAJjkK8vX9DCAxzWpT5K2YxIYhREKxEWzZaW7BYC5YfFTOO841pbUALSd5Z
8FpPWyt8zGTeNQCgUv+1vgJLwhd6WbIKIRK27aL3bKvQ2gu2jAjc6AuTCcv3UR6a
qhCvHb/oaUWP14OyTwMRycedKwJcVQ==
=wimH
-----END PGP SIGNATURE-----

--u45TnSjS6V6LcXmDbubxE0cOpGxJG4LWU--
