Received: from eggs.gnu.org ([2001:4830:134:3::10]:55406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGTrz-0004iA-8Z
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:54:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGTru-000440-D1
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 11:54:31 -0500
Date: Mon, 12 Dec 2016 16:53:00 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161212165300.GO4074@stefanha-x1.localdomain>
References: <cover.1481290956.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tzZdJ4yHDV5r1Akt"
Content-Disposition: inline
In-Reply-To: <cover.1481290956.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 0/1] Allow storing the
 qcow2 L2 cache in disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--tzZdJ4yHDV5r1Akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 03:47:03PM +0200, Alberto Garcia wrote:
> as we all know, one of the main things that can make the qcow2 format
> slow is the need to load entries from the L2 table in order to map a
> guest offset (on the virtual disk) to a host offset (on the qcow2
> image).
>=20
> We have an L2 cache to deal with this, and as long as the cache is big
> enough then the peformance is comparable to that of a raw image.
>=20
> For large qcow2 images the amount of RAM we need in order to cache all
> L2 tables can be big (128MB per TB of disk image if we're using the
> default cluster size of 64KB). In order to solve this problem we have
> a setting that allows the user to clean unused cache entries after a
> certain interval of time. This works fine most of the time, although
> we can still have peaks of RAM usage if there's a lot of I/O going on
> in one or more VMs.
>=20
> In some scenarios, however, there's a different alternative: if the
> qcow2 image is stored in a slow backend (eg. HDD), we could save
> memory by putting the L2 cache in a faster one (SSD) instead of in
> RAM.
>=20
> I have been making some tests with exactly that scenario and the
> results look good: storing the cache in disk gives roughly the same
> performance as storing it in memory.
>=20
> |---------------------+------------+------+------------+--------|
> |                     | Random 4k reads   | Sequential 4k reads |
> |                     | Throughput | IOPS | Throughput |  IOPS  |
> |---------------------+------------+------+------------+--------|
> | Cache in memory/SSD | 406 KB/s   |   99 | 84 MB/s    |  21000 |
> | Default cache (1MB) | 200 KB/s   |   60 | 83 MB/s    |  21000 |
> | No cache            | 200 KB/s   |   49 | 56 MB/s    |  14000 |
> |---------------------+------------+------+------------+--------|
>=20
> I'm including the patch that I used to get these results. This is the
> simplest approach that I could think of.
>=20
> Opinions, questions?

The root of the performance problem is the L2 table on-disk format,
which also happens to be used as the in-memory L2 table format.  It does
not scale to large disk images.

The simplest tweak is to use larger cluster sizes.  64 KB has been the
default for a long time and it may be time to evaluate performance
effects of increasing it.  I suspect this doesn't solve the problem,
instead we need to decouple metadata scalability from the cluster
size...

Is it time for a new on-disk representation?  Modern file systems seem
to use extent trees instead of offset tables.  That brings a lot of
complication because a good B-tree implementation would require quite a
bit of code changes.

Maybe a more modest change to the on-disk representation could solve
most of the performance problem.  In a very sparsely allocated L2 table
something like run-length encoding is more space-efficient than an
offset table.  In a very densely allocated L2 table it may be possible
to choose a "base offset" and then use much smaller offset entries
relative to the base.  For example:

typedef struct {
    uint64_t base_offset;
    uint16_t rel_offset[];  /* covers 4 GB with 64 KB cluster size */
} L2TableRelative;

uint64_t offset =3D l2->base_offset + l2->rel_offset[i] * cluster_size;

A final option is to leave the on-disk representation alone but
convert to an efficient in-memory representation when loading from disk.

Stefan

--tzZdJ4yHDV5r1Akt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTtXsAAoJEJykq7OBq3PIqNAIAJMuVLhCFyVz9Op/xhIabYPy
KC/p1QoKSc9pfjB5znNW0qlwvHrZl9kDJmNPTSEQ9kwAVEzwnJgMmqUhih6PG1XW
nFuqyBl3O/D2G3FEP1Ku8jRESK0qOBKac33B9hrr6wIArySkCL89emEfaCa2qmHi
JH54/gSeWmZf8808WmHrnKVABWGnA4ipCIyEO0SivM4ZfuIQBJkJH0L5dCwAdveu
4F+/asdU82TruqMOojZgqMIrExgijpxMEsjx+KwqLOoTcosO5izL8XJewOKdYiSP
YIY09Xpa3D/nP6ClmRyRzeIYugyfBbxSPUnhcmn26dMOKN1aUHHwhhtQfnzhOig=
=OOeC
-----END PGP SIGNATURE-----

--tzZdJ4yHDV5r1Akt--
