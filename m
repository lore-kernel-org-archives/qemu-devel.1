Received: from eggs.gnu.org ([2001:4830:134:3::10]:52981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwXPa-0007pm-FE
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cwXPX-0008K4-VS
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:11:02 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
Date: Fri, 7 Apr 2017 19:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4plksu4TW7dhdTlwgAwadCjf7d70kix2i"
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4plksu4TW7dhdTlwgAwadCjf7d70kix2i
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
Subject: Re: [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06.04.2017 17:01, Alberto Garcia wrote:
> Hi all,
>=20
> over the past couple of months I discussed with some of you the
> possibility to extend the qcow2 format in order to improve its
> performance and reduce its memory requirements (particularly with very
> large images).
>=20
> After some discussion in the mailing list and the #qemu IRC channel I
> decided to write a prototype of a new extension for qcow2 so I could
> understand better the scope of the changes and have some preliminary
> data about its effects.
>=20
> This e-mail is the formal presentation of my proposal to extend the
> on-disk qcow2 format. As you can see this is still an RFC. Due to the
> nature of the changes I would like to get as much feedback as possible
> before going forward.
>=20
> =3D=3D=3D Problem =3D=3D=3D
>=20
> The original problem that I wanted to address is the memory
> requirements of qcow2 files if you want to have very large images and
> still keep good I/O performance. This is a consequence of its very
> structure, which I'm going to describe now.
>=20
> A qcow2 image is divided into units of constant size called clusters,
> and among other things it contains metadata that maps guest addresses
> to host addresses (the so-called L1 and L2 tables).
>=20
> There are two basic problems that result from this:
>=20
> 1) Reading from or writing to a qcow2 image involves reading the
>    corresponding entry on the L2 table that maps the guest address to
>    the host address. This is very slow because it involves two I/O
>    operations: one on the L2 table and the other one on the actual
>    data cluster.
>=20
> 2) A cluster is the smallest unit of allocation. Therefore writing a
>    mere 512 bytes to an empty disk requires allocating a complete
>    cluster and filling it with zeroes (or with data from the backing
>    image if there is one). This wastes more disk space and also has a
>    negative impact on I/O.
>=20
> Problem (1) can be solved by keeping in memory a cache of the L2
> tables (QEMU has an "l2_cache_size" parameter for this purpose). The
> amount of disk space used by L2 tables depends on two factors: the
> disk size and the cluster size.
>=20
> The cluster size can be configured when the image is created, and it
> can be any power of two between 512 bytes and 2 MB (it defaults to 64
> KB).
>=20
> The maximum amount of space needed for the L2 tables can be calculated
> with the following formula:
>=20
>    max_l2_size =3D virtual_disk_size * 8 / cluster_size
>=20
> Large images require a large amount of metadata, and therefore a large
> amount of memory for the L2 cache. With the default cluster size
> (64KB) that's 128MB of L2 cache for a 1TB qcow2 image.
>=20
> The only way to reduce the size of the L2 tables is therefore
> increasing the cluster size, but this makes the image less efficient
> as described earlier in (2).
>=20
> =3D=3D=3D The proposal =3D=3D=3D
>=20
> The idea of this proposal is to extend the qcow2 format by allowing
> subcluster allocation. There would be an optional feature that would
> need to be enabled when creating the image. The on-disk format would
> remain essentially the same, except that each data cluster would be
> internally divided into a number of subclusters of equal size.
>=20
> What this means in practice is that each entry on an L2 table would be
> accompanied by a bitmap indicating the allocation state of each one of
> the subclusters for that cluster. There are several alternatives for
> storing the bitmap, described below.
>=20
> Other than L2 entries, all other data structures would remain
> unchanged, but for data clusters the smallest unit of allocation would
> now be the subcluster. Reference counting would still be at the
> cluster level, because there's no way to reference individual
> subclusters. Copy-on-write on internal snapshots would need to copy
> complete clusters, so that scenario would not benefit from this
> change.
>=20
> I see two main use cases for this feature:
>=20
> a) The qcow2 image is not too large / the L2 cache is not a problem,
>    but you want to increase the allocation performance. In this case
>    you can have something like a 128KB cluster with 4KB subclusters
>    (with 4KB being a common block size in ext4 and other filesystems)
>=20
> b) The qcow2 image is very large and you want to save metadata space
>    in order to have a smaller L2 cache. In this case you can go for
>    the maximum cluster size (2MB) but you want to have smaller
>    subclusters to increase the allocation performance and optimize the
>    disk usage. This was actually my original use case.
>=20
> =3D=3D=3D Test results =3D=3D=3D
>=20
> I have a basic working prototype of this. It's still incomplete -and
> buggy :)- but it gives an idea of what we can expect from it. In my
> implementation each data cluster has 8 subclusters, but that's not set
> in stone (see below).
>=20
> I made all tests on an SSD drive, writing to an empty qcow2 image with
> a fully populated 40GB backing image, performing random writes using
> fio with a block size of 4KB.
>=20
> I tried with the default and maximum cluster sizes (64KB and 2MB) and
> also with some other sizes. I also made sure to try with 32KB clusters
> so the subcluster size matches the 4KB block size used for the I/O.
>=20
> It's important to point out that once a cluster has been completely
> allocated then having subclusters offers no performance benefit. For
> this reason the size of the image for these tests (40GB) was chosen to
> be large enough to guarantee that there are always new clusters being
> allocated. This is therefore a worst-case scenario (or best-case for
> this feature, if you want).
>=20
> Here are the results (subcluster size in brackets):
>=20
> |-----------------+----------------+-----------------+-----------------=
--|
> |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache=
 size |
> |-----------------+----------------+-----------------+-----------------=
--|
> |   2 MB (256 KB) |   440 IOPS     |  100 IOPS       | 160 KB (*)      =
  |
> | 512 KB  (64 KB) |  1000 IOPS     |  300 IOPS       | 640 KB          =
  |
> |  64 KB   (8 KB) |  3000 IOPS     | 1000 IOPS       |   5 MB          =
  |
> |  32 KB   (4 KB) | 12000 IOPS     | 1300 IOPS       |  10 MB          =
  |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB          =
  |
> |-----------------+----------------+-----------------+-----------------=
--|
>=20
>                 (*) The L2 cache must be a multiple of the cluster
>                     size, so in this case it must be 2MB. On the table
>                     I chose to show how much of those 2MB are actually
>                     used so you can compare it with the other cases.
>=20
> Some comments about the results:
>=20
> - For the 64KB, 512KB and 2MB cases, having subclusters increases
>   write performance roughly by three. This happens because for each
>   cluster allocation there's less data to copy from the backing
>   image. For the same reason, the smaller the cluster, the better the
>   performance. As expected, 64KB clusters with no subclusters perform
>   roughly the same as 512KB clusters with 64KB subclusters.
>=20
> - The 32KB case is the most interesting one. Without subclusters it's
>   not very different from the 64KB case, but having a subcluster with
>   the same size of the I/O block eliminates the need for COW entirely
>   and the performance skyrockets (10 times faster!).
>=20
> - 4KB is however very slow. I attribute this to the fact that the
>   cluster size is so small that a new cluster needs to be allocated
>   for every single write and its refcount updated accordingly. The L2
>   and refcount tables are also so small that they are too inefficient
>   and need to grow all the time.
>=20
> Here are the results when writing to an empty 40GB qcow2 image with no
> backing file. The numbers are of course different but as you can see
> the patterns are similar:
>=20
> |-----------------+----------------+-----------------+-----------------=
--|
> |  cluster size   | subclusters=3Don | subclusters=3Doff | Max L2 cache=
 size |
> |-----------------+----------------+-----------------+-----------------=
--|
> |   2 MB (256 KB) |  1200 IOPS     |  255 IOPS       | 160 KB          =
  |
> | 512 KB  (64 KB) |  3000 IOPS     |  700 IOPS       | 640 KB          =
  |
> |  64 KB   (8 KB) |  7200 IOPS     | 3300 IOPS       |   5 MB          =
  |
> |  32 KB   (4 KB) | 12300 IOPS     | 4200 IOPS       |  10 MB          =
  |
> |   4 KB  (512 B) |   100 IOPS     |  100 IOPS       |  80 MB          =
  |
> |-----------------+----------------+-----------------+-----------------=
--|
>=20
> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>=20
> The qcow2 on-disk format needs to change so each L2 entry has a bitmap
> indicating the allocation status of each subcluster. There are three
> possible states (unallocated, allocated, all zeroes), so we need two
> bits per subcluster.

You don't need two bits, you need log(3) / log(2) =3D ld(3) =E2=89=88 1.5=
8. You
can encode the status of eight subclusters (3^8 =3D 6561) in 13 bits
(ld(6561) =E2=89=88 12.68).

(Why not write it in Malbolge? I guarantee it will be much simpler given
this is ternary information.)

> An L2 entry is 64 bits wide, and this is the current format (for
> uncompressed clusters):
>=20
> 63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0=

> 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000=

> **<----> <--------------------------------------------------><------->*=

>   Rsrved              host cluster offset of data             Reserved
>   (6 bits)                (47 bits)                           (8 bits)
>=20
>     bit 63: refcount =3D=3D 1   (QCOW_OFLAG_COPIED)
>     bit 62: compressed =3D 1  (QCOW_OFLAG_COMPRESSED)
>     bit 0: all zeros        (QCOW_OFLAG_ZERO)
>=20
> I thought of three alternatives for storing the subcluster bitmaps. I
> haven't made my mind completely about which one is the best one, so
> I'd like to present all three for discussion. Here they are:
>=20
> (1) Storing the bitmap inside the 64-bit entry
>=20
>     This is a simple alternative and is the one that I chose for my
>     prototype. There are 14 unused bits plus the "all zeroes" one. If
>     we steal one from the host offset we have the 16 bits that we need
>     for the bitmap and we have 46 bits left for the host offset, which
>     is more than enough.

No need to steal because you only need 13 bits (apart from what Eric wrot=
e).

>=20
>     * Pros:
>       + Simple. Few changes compared to the current qcow2 format.
>=20
>     * Cons:
>       - Only 8 subclusters per cluster. We would not be making the
>         most of this feature.

I agree on this one, though.

One case I'd be especially interested in are of course 4 kB subclusters
for 64 kB clusters (because 4 kB is a usual page size and can be
configured to be the block size of a guest device; and because 64 kB
simply is the standard cluster size of qcow2 images nowadays[1]...).

Then we'd have 16 subclusters which would require 26 bits.
Unfortunately, with 64 kB clusters we'd only have 22 bits available
(including the is-zero flag)... So this is not going to fly.

(We could even get one more bit if we had a subcluster-flag, because I
guess we can always assume subclustered clusters to have OFLAG_COPIED
and be uncompressed. But still, three bits missing.)

If course, if you'd be willing to give up the all-zeroes state for
subclusters, it would be enough...

>       - No reserved bits left for the future.

One bit left (or more, see Eric). :-)

> (2) Making L2 entries 128-bit wide.
>=20
>     In this alternative we would double the size of L2 entries. The
>     first half would remain unchanged and the second one would store
>     the bitmap. That would leave us with 32 subclusters per cluster.
>=20
>     * Pros:
>       + More subclusters per cluster. We could have images with
>         e.g. 128k clusters with 4k subclusters.
>=20
>     * Cons:
>       - More space needed for L2 entries. The same cluster size would
>         require a cache twice as large, although having subcluster
>         allocation would compensate for this.
>=20
>       - More changes to the code to handle 128-bit entries.
>=20
>       - We would still be wasting the 14 reserved bits that L2 entries
>         have.

Not sure I like this too much, but maybe it performs better than (3).

Also, Kevin doesn't like (3) and neither do you anymore...

> (3) Storing the bitmap somewhere else
>=20
>     This would involve storing the bitmap separate from the L2 tables
>     (perhaps using the bitmaps extension? I haven't looked much into
>     this).

(not really)

>     * Pros:
>       + Possibility to make the number of subclusters configurable
>         by the user (32, 64, 128, ...)

Yes indeed!

>       + All existing metadata structures would remain untouched
>         (although the "all zeroes" bit in L2 entries would probably
>         become unused).

Well, sounds nice but it's still an incompatible change, so I'm not sure
whether this is really a benefit. I guess it means our code stays simpler=
=2E

>     * Cons:
>       - As with alternative (2), more space needed for metadata.

Yeah, but just one 1/4 more if you have 8 subclusters or 1/2 more if you
take my favorite 64 kB/4 kB configuration. Not too bad.

(This is worse for (2). It'll always be double or more.)

>       - The bitmap would also need to be cached for performance
>         reasons.
>=20
>       - Possibly one more *_cache_size option.

I don't think so. There is no reason we shouldn't cache all the entries
whose corresponding L2 table is loaded.

(Or I can't see one, at least. At least once we can cache partial
clusters; if the subcluster information for an L2 table only takes 1/4th
of the space (and thus 1/4th of a cluster) we only need to cache that
much data. We don't need to cache the adjacent subcluster information
blocks if their L2 tables aren't cached, too.)

>       - One more metadata structure to be updated for each
>         allocation. This would probably impact I/O negatively.

Needs benchmarks. :-)

I don't think it would be too bad on an SSD. On an HDD it means
additional seeking, yes. (Unless you're clever: If you have 1/2th
overhead, you could put the subcluster information between the
corresponding L2 tables (same for every multiple of 1/2 that isn't also
a multiple of 1). For multiples of 1, you just put it into a cluster
adjacent to the L2 table.

(OTOH, the fact that you effectively need to at least double the L2 size
for (2) means that you need to write more data, so (2) might actually
perform worse than (3) if you would be all fine with just 16 subclusters
(at least on an SSD).)

By the way, if you'd only allow multiple of 1s overhead (i.e. multiples
of 32 subclusters), I think (3) would be pretty much the same as (2) if
you just always write the subcluster information adjacent to the L2
table. Should be just the same caching-wise and performance-wise.

Max

> =3D=3D=3D Compressed clusters =3D=3D=3D
>=20
> My idea is that compressed clusters would remain the same. They are
> read-only anyway so they would not be affected by any of these
> changes.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
> I think I managed to summarize all the ideas that I had in my mind,
> but I'm sure you probably have questions and comments, so I'd be happy
> to get as much feedback as possible.
>=20
> So, looking forward to reading your opinions.
>=20
> Regards,
>=20
> Berto
>=20



--4plksu4TW7dhdTlwgAwadCjf7d70kix2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljnyBYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHE0H/ivsxZswZRPJLdUwW7mq5GOqw6qwPf+R
WDcyd2HD4xMTCYV4AbQFWKbW+4/4gcgk3E3JAFkkyLT23hsgFhfxcsB11lWrSZTX
2y6lVio5w4vmvH4BPK1cAYtgLqsCCXHjUe/LyBDLAiQdIKPPK4Y17VL+ocBDp+BU
MXVldfCWyCvW/BrFUg91mgHFAU+Wd6ZCKFiTRHkcRzDpaluMEi2XogIpeecUVdl0
d62w0lE0gCdaAmrApSEVRhiUUGlw1w0tA+9EZzC4yZU5cED4MFuRMACE1LQzfsHA
SMyjhck27CYnl9mhDtRlqU0f6s8dI7/Sazb4fWE3wr41SkO6lKVb/2U=
=39tt
-----END PGP SIGNATURE-----

--4plksu4TW7dhdTlwgAwadCjf7d70kix2i--
