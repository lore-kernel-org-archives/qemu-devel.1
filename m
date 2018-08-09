Received: from eggs.gnu.org ([2001:4830:134:3::10]:59171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntOe-0003Pq-FR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:27:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntOd-0008MS-73
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:27:08 -0400
References: <20180809213801.15098-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b62ceead-efde-d86a-ebb7-552d3b6b0aec@redhat.com>
Date: Fri, 10 Aug 2018 00:26:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5J5ZFK7V3B1NjQSKjenMj9tZWchmaeF8h"
Subject: Re: [Qemu-devel] [PATCH 00/11] block: Deal with filters
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
--5J5ZFK7V3B1NjQSKjenMj9tZWchmaeF8h
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b62ceead-efde-d86a-ebb7-552d3b6b0aec@redhat.com>
Subject: Re: [PATCH 00/11] block: Deal with filters
References: <20180809213801.15098-1-mreitz@redhat.com>
In-Reply-To: <20180809213801.15098-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Let's pretend you didn't see this, as it breaks some iotests... *cough*
*cough*

(This is what I get for last-minute changes and rebases without proper
test running.  Yes, I'm ashamed.)

Max


On 2018-08-09 23:37, Max Reitz wrote:
> Note 1: This series depends on v10 of my =E2=80=9Cblock: Fix some filen=
ame
> generation issues=E2=80=9D series.
>=20
> Based-on: <20180809213528.14738-1-mreitz@redhat.com>
>=20
> Note 2: This is technically the first part of my active mirror followup=
=2E
> But just very technically.  I noticed that that followup started to
> consist of two parts, namely (A) fix filtery things in the block layer,=

> and (B) fix active mirror.  So I decided to split it.  This is part A.
> Part B comes later.
>=20
>=20
> When we introduced filters, we did it a bit casually.  Sure, we talked =
a
> lot about them before, but that was mostly discussion about where
> implicit filters should be added to the graph (note that we currently
> only have two implicit filters, those being mirror and commit).  But in=

> the end, we really just designated some drivers filters (Quorum,
> blkdebug, etc.) and added some specifically (throttle, COR), without
> really looking through the block layer to see where issues might occur.=

>=20
> It turns out vast areas of the block layer just don't know about filter=
s
> and cannot really handle them.  Many cases will work in practice, in
> others, well, too bad, you cannot use some feature because some part
> deep inside the block layer looks at your filters and thinks they are
> format nodes.
>=20
> This series sets out to correct a bit of that.  I lost my head many
> times and I'm sure this series is incomplete in many ways, but it reall=
y
> doesn't do any good if it sits on my disk any longer, it needs to go ou=
t
> now.
>=20
> The most important patches of this series are patches 3 and 4.  These
> introduce functions to encapsulate bs->backing and bs->file accesses.
> Because sometimes, bs->backing means COW, sometimes it means filtered
> node.  And sometimes, bs->file means metadata storage, and sometimes it=

> means filtered node.  With this functions, it's always clear what the
> caller wants, and it will always get what it wants.
>=20
> Besides that, patch 3 introduces functions to skip filters which may be=

> used by parts of the block layer that just don't care about them.
>=20
>=20
> Secondly, the restraints put on mirror's @replaces parameter are
> revisited and fixed.
>=20
>=20
> Thirdly, BDS.backing_file is changed to be constant.  I don't quite kno=
w
> why we modify it whenever we change a BDS's backing file, but that's
> definitely not quite right.  This fixes things like being able to
> perform a commit on a file (using relative filenames) in a directory
> that's not qemu's CWD.
>=20
>=20
> Finally, a number of tests are added.
>=20
>=20
> There are probably many things that are worthy of discussion, of which
> only some come to my head, e.g.:
>=20
> - In which cases do we want to skip filters, in which cases do we want
>   to skip implicit filters?
>   My approach was to basically never skip explicitly added filters,
>   except when it's about finding a file in some tree (e.g. in a backing=

>   chain).  Maybe there are cases where you think we should skip even
>   explicitly added filters.
>=20
> - I made interesting decisions like =E2=80=9CWhen you mirror from a nod=
e, we
>   should indeed mirror from that node, but when replacing it, we should=

>   skip leave all implicit filters on top intact.=E2=80=9D  You may disa=
gree with
>   that.
>   (My reasoning here is that users aren't supposed to know about
>   implicit filters, and therefore, they should not intend to remove
>   them.  Also, mirror accepts only root nodes as the source, so you
>   cannot really specify the node below the implicit filters.  But you
>   can use @replaces to drop the implicit filters, if you know they are
>   there.)
>=20
>=20
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
>  include/block/block_int.h      |  53 +++++-
>  block.c                        | 338 ++++++++++++++++++++++++++++-----=

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
>  tests/qemu-iotests/040         | 191 +++++++++++++++++++
>  tests/qemu-iotests/040.out     |   4 +-
>  tests/qemu-iotests/041         | 270 +++++++++++++++++++++++++-
>  tests/qemu-iotests/041.out     |   4 +-
>  tests/qemu-iotests/191.out     |   1 -
>  23 files changed, 1133 insertions(+), 224 deletions(-)
>=20



--5J5ZFK7V3B1NjQSKjenMj9tZWchmaeF8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltsv7IACgkQ9AfbAGHV
z0Bg5wf9F40m2t7yriK98ITuj11bT3KlT31L1goSY1F3QaPqbXJ7FbNawrOJ5cLt
PSxDnjzVo0LEkReoaSQtwKUuyx+kxnUwbNAO6cCEq3fwFYANX/x89uzM3lRcyYOG
F8jYX9qRe6LhhzxBlXONKF0kWrXHyfWd5oIcjAlJh4qZ+QbyaLk+vTBN2xWOqE0v
X6Gtst3pICXMa32JoY5TbemB8LGZyetfiOczuK4B2/4hqqrcVUb620FhsSIx7Tkh
thxiBpsPp5I2WwwmL0PPPA2O5FYo0dHfPlxvFgXMJxXR1sJzfoH/S/mj4Ybc8979
I7yhlI6tdLgfWKo8WtSgoVnkI8E/+g==
=4mac
-----END PGP SIGNATURE-----

--5J5ZFK7V3B1NjQSKjenMj9tZWchmaeF8h--
