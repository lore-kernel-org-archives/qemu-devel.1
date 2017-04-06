Received: from eggs.gnu.org ([2001:4830:134:3::10]:35814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwASt-0004rv-UG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cwASs-00020O-72
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 12:40:55 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
From: Eric Blake <eblake@redhat.com>
Message-ID: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Date: Thu, 6 Apr 2017 11:40:41 -0500
MIME-Version: 1.0
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Jx85vsk9GA9NRNc30QHMnKG58q7lh2F1H"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jx85vsk9GA9NRNc30QHMnKG58q7lh2F1H
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
In-Reply-To: <20170406150148.zwjpozqtale44jfh@perseus.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 10:01 AM, Alberto Garcia wrote:
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

The idea in general makes sense; I can even remember chatting with Kevin
about similar ideas as far back as 2015, where the biggest drawback is
that it is an incompatible image change, and therefore images created
with the flag cannot be read by older tools.

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

Those are some cool results!


> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>=20
> The qcow2 on-disk format needs to change so each L2 entry has a bitmap
> indicating the allocation status of each subcluster. There are three
> possible states (unallocated, allocated, all zeroes), so we need two
> bits per subcluster.

You also have to add a new incompatible feature bit, so that older tools
know they can't read the new image correctly, and therefore don't
accidentally corrupt it.

>=20
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

Note that because you are using exactly 8 subclusters, you can require
that the minimum cluster size when subclusters are enabled be 4k (since
we already have a lower-limit of 512-byte sector operation, and don't
want subclusters to be smaller than that); at which case you are
guaranteed that the host cluster offset will be 4k aligned.  So in
reality, once you turn on subclusters, you have:

63    56 55    48 47    40 39    32 31    24 23    16 15     8 7      0
00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
**<----> <-----------------------------------------------><---------->*
  Rsrved              host cluster offset of data             Reserved
  (6 bits)                (44 bits)                           (11 bits)

where you have 17 bits plus the "all zeroes" bit to play with, thanks to
the three bits of host cluster offset that are now guaranteed to be zero
due to cluster size alignment (but you're also right that the "all
zeroes" bit is now redundant information with the 8 subcluster-is-zero
bits, so repurposing it does not hurt)

>=20
>     * Pros:
>       + Simple. Few changes compared to the current qcow2 format.
>=20
>     * Cons:
>       - Only 8 subclusters per cluster. We would not be making the
>         most of this feature.
>=20
>       - No reserved bits left for the future.

I just argued you have at least one, and probably 2, bits left over for
future in-word expansion.

>=20
> (2) Making L2 entries 128-bit wide.
>=20
>     In this alternative we would double the size of L2 entries. The
>     first half would remain unchanged and the second one would store
>     the bitmap. That would leave us with 32 subclusters per cluster.

Although for smaller cluster sizes (such as 4k clusters), you'd still
want to restrict that subclusters are at least 512-byte sectors, so
you'd be using fewer than 32 of those subcluster positions until the
cluster size is large enough.

>=20
>     * Pros:
>       + More subclusters per cluster. We could have images with
>         e.g. 128k clusters with 4k subclusters.

Could allow variable-sized subclusters (your choice of 32 subclusters of
4k each, or 16 subclusters of 8k each)

>=20
>     * Cons:
>       - More space needed for L2 entries. The same cluster size would
>         require a cache twice as large, although having subcluster
>         allocation would compensate for this.
>=20
>       - More changes to the code to handle 128-bit entries.

Dealing with variable-sized subclusters, or with unused subclsuster
entries when the cluster size is too small (such as a 4k cluster should
not be allowed any subclusters smaller than 512 bytes, but that's at
most 8 out of the 32 slots available), can get tricky.

>=20
>       - We would still be wasting the 14 reserved bits that L2 entries
>         have.
>=20
> (3) Storing the bitmap somewhere else
>=20
>     This would involve storing the bitmap separate from the L2 tables
>     (perhaps using the bitmaps extension? I haven't looked much into
>     this).
>=20
>     * Pros:
>       + Possibility to make the number of subclusters configurable
>         by the user (32, 64, 128, ...)
>       + All existing metadata structures would remain untouched
>         (although the "all zeroes" bit in L2 entries would probably
>         become unused).

It might still remain useful for optimization purposes, although then we
get into image consistency questions (if the all zeroes bit is set but
subcluster map claims allocation, or if the all zeroes bit is clear but
all subclusters claim zero, which one wins).

>=20
>     * Cons:
>       - As with alternative (2), more space needed for metadata.
>=20
>       - The bitmap would also need to be cached for performance
>         reasons.
>=20
>       - Possibly one more *_cache_size option.
>=20
>       - One more metadata structure to be updated for each
>         allocation. This would probably impact I/O negatively.

Having the subcluster table directly in the L2 means that updating the
L2 table is done with a single write. You are definitely right that
having the subcluster table as a bitmap in a separate cluster means two
writes instead of one, but as always, it's hard to predict how much of
an impact that is without benchmarks.

>=20
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

The fact that you already have numbers proving the speedups that are
possible when first allocating the image make this sound like a useful
project, even though it is an incompatible image change that old tools
won't be able to recognize. You'll want to make sure 'qemu-img amend'
can rewrite an image with subclusters into an older image.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Jx85vsk9GA9NRNc30QHMnKG58q7lh2F1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5m+JAAoJEKeha0olJ0NqUKMH/1fkfgAu6LQWl5WvnHBkhmgH
PgtOCCJvNMWVa46RFBnCX0th5ppp/CCcPy9uYmwjqcMvBOthdy64gPf8GZn0ORtV
XXO37OvlZ7+c0z1CTDtnFsqvp9VkMxfxc+VwFbG5pUr2GWmqIBacSYAwTboQWymo
7kcl1yVEptCeXwuxA9JQQ2eToZWAuKJj1xSAKF5T1M7ta3gncyQ5+VDd3Zd5PYh2
HM7QBcoxNk0USxUmqVxXVTF+8ziVenZcVQd9sdjL8zafoBLuzcKmALIMxE0FT4ld
UvpPrSHZQeEhH02sMlpL0AJKGtrbY+IJtj6oK38gGb+yENpP/2xOurfizN6SiSI=
=1SDl
-----END PGP SIGNATURE-----

--Jx85vsk9GA9NRNc30QHMnKG58q7lh2F1H--
