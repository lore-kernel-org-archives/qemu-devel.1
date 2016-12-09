Received: from eggs.gnu.org ([2001:4830:134:3::10]:47091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFM3D-0007ll-E8
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFM3A-0004zp-90
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 09:21:27 -0500
References: <cover.1481290956.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
Date: Fri, 9 Dec 2016 15:21:08 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1481290956.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QtlS1RgXNKSwrvwQgwlULi1ULFhdThCuA"
Subject: Re: [Qemu-devel] [PATCH RFC 0/1] Allow storing the qcow2 L2 cache
 in disk
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
--QtlS1RgXNKSwrvwQgwlULi1ULFhdThCuA
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <468dbeb8-5b1b-669f-f7e5-0d24a4308da8@redhat.com>
Subject: Re: [PATCH RFC 0/1] Allow storing the qcow2 L2 cache in disk
References: <cover.1481290956.git.berto@igalia.com>
In-Reply-To: <cover.1481290956.git.berto@igalia.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 09.12.2016 14:47, Alberto Garcia wrote:
> Hi all,
>=20
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

Well, from a full design standpoint, it doesn't make a lot of sense to me=
:

We have a two-level on-disk structure for cluster mapping so as to not
waste memory for unused areas and so that we don't need to keep one
large continuous chunk of metadata. Accessing the disk is slow, so we
also have an in-memory cache which is just a single level fully
associative cache replicating the same data (but just a part of it).

Now you want to replicate all of it and store it on disk. My mind tells
me that is duplicate data: We already have all of the metadata elsewhere
on disk, namely in the qcow2 file, and even better, it is not stored in
a fully associative structure there but directly mapped, making finding
the correct entry much quicker.

Therefore, this is not a good idea. The existing structures already
exist and are just better.

However, the thing is that the existing structures also only exist in
the original qcow2 file and cannot be just placed anywhere else, as
opposed to our cache. In order to solve this, we would need to
(incompatibly) modify the qcow2 format to allow storing data
independently from metadata. I think this would be certainly doable, but
the question is whether it is worth the effort.

I'm not sure, maybe it actually is worth the effort. Your patch is nice
and simple and certainly improves things now. But the question is
whether we can't do better than to look up all cluster mappings in a
fully associative table.

Maybe we can at least make the cache directly mapped if it is supposed
to cover the whole image? That is, we would basically just load all of
the L2 tables into memory and bypass the existing cache.

Max


--QtlS1RgXNKSwrvwQgwlULi1ULFhdThCuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhKvdQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHvcIAIvC/qZk8hsXGdqqZADkcn7o65Jetpzc
2qTCU0eoeUusjHsNAUd3NvqOdVFCuWzQcNMXr4k6RFfoCYVeLwYwW9bZq4jARwvT
NbzGO4i3UjEe0os5gFosxdH7ahPcdR+hs28lETVq2r7xQTszYv+WQOoMuI0oQNet
CScMuastC0B6FrDPxNxL3gtHuGIocijXDGQ2l+fUjBqodXF9DOQpxRWOfI9U01K/
eMacg7s1N7rlSCK6XeI5B19M/a+8JUARM6wXhbPPyeDAAOtze8M6siMH78vGykGX
UV8iHSDNx6yTKbY5UvYbbskezErxpMbEzUUWhyoVmwtQGO71XFKuVOE=
=tqbT
-----END PGP SIGNATURE-----

--QtlS1RgXNKSwrvwQgwlULi1ULFhdThCuA--
