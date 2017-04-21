Received: from eggs.gnu.org ([2001:4830:134:3::10]:48994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1lll-0005mU-RZ
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1llj-0004yA-GL
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 23:31:33 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <382b0707-233d-ab05-e054-3da43617460d@redhat.com>
Date: Fri, 21 Apr 2017 16:09:12 -0500
MIME-Version: 1.0
In-Reply-To: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wtwWWAeEAXrFbiPHG3VptwgNmjnSQRllM"
Subject: [Qemu-devel] proposed qcow2 extension: cluster reservations [was:
 [RFC] Proposed qcow2 extension: subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtwWWAeEAXrFbiPHG3VptwgNmjnSQRllM
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <382b0707-233d-ab05-e054-3da43617460d@redhat.com>
Subject: proposed qcow2 extension: cluster reservations [was: [Qemu-devel]
 [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
In-Reply-To: <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/06/2017 11:40 AM, Eric Blake wrote:

>> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>>
>> The qcow2 on-disk format needs to change so each L2 entry has a bitmap=

>> indicating the allocation status of each subcluster. There are three
>> possible states (unallocated, allocated, all zeroes), so we need two
>> bits per subcluster.
>=20
> You also have to add a new incompatible feature bit, so that older tool=
s
> know they can't read the new image correctly, and therefore don't
> accidentally corrupt it.

As long as we are talking about incompatible feature bits, I had some
thoughts about image mapping today.

tl;dr: summary
As long as we are considering incompatible features, maybe we should
make it easier to have an image file that explicitly preserves
guest=3D>host mapping, such that nothing the guest can do will reorder th=
e
mapping.  This way, it would be possible to fully preallocate an image
such that all guest offsets are adjusted by a constant offset to become
the corresponding host offset (basically, no qcow2 metadata is
interleaved in the middle of guest data).

I don't see any way to do it on current qcow2 images, but with
subclusters, you get it for free by having a cluster with an offset but
with all subclusters marked as unallocated.  But perhaps it is something
orthogonal enough that we would want a separate incompatible feature bit
for just this, without having subclusters at the same time.

In the process of exploring the topic, I expose a couple of existing
bugs in our qcow2 handling.

=3D=3D=3D=3D=3D=3D=3D=3D

Longer version:

If I'm reading qcow2-clusters.c and qcow2-refcount.c correctly, our
current implementation of bdrv_discard() says that except for clusters
already marked QCOW2_CLUSTER_ZERO, we will unconditionally remove the L2
mapping of the address.  Whether we actually punch a hole in the
underlying image, or merely add it to a list of free clusters for use in
subsequent allocations, is later decided based on
s->discard_passthrough[type] (that is, the caller can pass different
type levels that control whether to never punch, always punch, or let
the blockdev parameters of the caller control whether to punch).

Presumably, if I've preallocated my image because I want to guarantee
enough host space, then I would use blockdev parameters that ensure that
guest actions never punch a hole.  But based on my reading, I still have
the situation that if I initially preallocated things so that guest
cluster 0 and 1 are consecutive clusters in the host, and the guest
triggers bdrv_pdiscard() over both clusters, then writes to cluster 1
before cluster 0, then even though I'm not changing the underlying
allocation of the host file, I _am_ resulting in fragmentation in the
qcow2 file, where cluster 1 in the guest now falls prior to cluster 0.

Demonstration:
$ qemu-img create -f qcow2 -o cluster_size=3D1M,preallocation=3Dfull file=
3 10M
Formatting 'file3', fmt=3Dqcow2 size=3D10485760 encryption=3Doff
cluster_size=3D1048576 preallocation=3Dfull lazy_refcounts=3Doff refcount=
_bits=3D16
$ qemu-img map -f qcow2 file3
Offset          Length          Mapped to       File
0               0x900000        0x500000        file3
0x9ff000        0x1000          0xeff000        file3

Oh, that's weird - our "full allocation" still results in a gap in
guest-allocation (nothing from 0x900000-0x9ff000 appears to be mapped),
even though every offset that IS allocated has a 1:1 mapping (for any
given guest offset, add 5M to get the host offset).  Maybe the JSON
output will shed more light:

$ qemu-img map -f qcow2 file3 --output=3Djson
[{ "start": 0, "length": 9437184, "depth": 0, "zero": false, "data":
true, "offset": 5242880},
{ "start": 9437184, "length": 1044480, "depth": 0, "zero": true, "data":
true, "offset": 14680064},
{ "start": 10481664, "length": 4096, "depth": 0, "zero": false, "data":
true, "offset": 15724544}]

That's a bit better - the hole that didn't show up is still mapped, it's
just the human version omitted it because that portion of the file
explicitly reads as zero.  But I'm still confused - how can only half of
a 1M cluster read as zero, when our QCOW2_CLUSTER_ZERO flag applies a
cluster-at-a-time?  Oh - it's because we defer to the file system, and
according to lseek(SEEK_HOLE), we actually do have a hole in the file...

$ qemu-img map -f raw file3 --output=3Djson
[{ "start": 0, "length": 5242880, "depth": 0, "zero": false, "data":
true, "offset": 0},
{ "start": 5242880, "length": 10481664, "depth": 0, "zero": true,
"data": false, "offset": 5242880},
{ "start": 15724544, "length": 4096, "depth": 0, "zero": false, "data":
true, "offset": 15724544}]
$ qemu-io -f raw file3

and reading the L2 table shows that we do NOT have a case of
QCOW2_CLUSTER_ZERO set in the qcow2 image:

$ qemu-io -f raw file3
qemu-io> r -v 4m 128
00400000:  80 00 00 00 00 50 00 00 80 00 00 00 00 60 00 00  .....P.......=
=2E..
00400010:  80 00 00 00 00 70 00 00 80 00 00 00 00 80 00 00  .....p.......=
=2E..
00400020:  80 00 00 00 00 90 00 00 80 00 00 00 00 a0 00 00  .............=
=2E..
00400030:  80 00 00 00 00 b0 00 00 80 00 00 00 00 c0 00 00  .............=
=2E..
00400040:  80 00 00 00 00 d0 00 00 80 00 00 00 00 e0 00 00  .............=
=2E..
00400050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
read 128/128 bytes at offset 4194304
128 bytes, 1 ops; 0.0001 sec (905.797 KiB/sec and 7246.3768 ops/sec)
qemu-io> q


But it's still sad that our request for preallocation=3Dfull didn't
actually work on the underlying file (we have a hole that we didn't
want).  Oh well, yet another thing to fix someday.

Anyways, now have the guest do a discard and subsequent re-write:

$ qemu-io -f qcow2 file3
qemu-io> discard 0 2m
discard 2097152/2097152 bytes at offset 0
2 MiB, 1 ops; 0.0014 sec (1.395 GiB/sec and 714.2857 ops/sec)
qemu-io> w 1m 1m
wrote 1048576/1048576 bytes at offset 1048576
1 MiB, 1 ops; 0.0465 sec (21.487 MiB/sec and 21.4869 ops/sec)
qemu-io> w 0 1m
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0327 sec (30.497 MiB/sec and 30.4971 ops/sec)
qemu-io> q
$ qemu-img map -f qcow2 file3
Offset          Length          Mapped to       File
0               0x100000        0x600000        file3
0x100000        0x100000        0x500000        file3
0x200000        0x700000        0x700000        file3
0x9ff000        0x1000          0xeff000        file3

We haven't consumed any new host space (good), but we HAVE fragmented
the guest image (cluster 0 and 1 have now swapped spaces; we no longer
have contiguous guest=3D>host translations).

But watch what happens with explicit zero clusters:

$ qemu-io -f qcow2 file3
qemu-io> w -z 3m 2m
wrote 2097152/2097152 bytes at offset 3145728
2 MiB, 1 ops; 0.0136 sec (146.563 MiB/sec and 73.2815 ops/sec)
qemu-io> q

Per the L2 map, we have now set the explicit zero bit, but maintained an
allocation:

$ qemu-io -f raw file3
qemu-io> r -v 4m 128
00400000:  80 00 00 00 00 60 00 00 80 00 00 00 00 50 00 00  .............=
P..
00400010:  80 00 00 00 00 70 00 00 80 00 00 00 00 80 00 01  .....p.......=
=2E..
00400020:  80 00 00 00 00 90 00 01 80 00 00 00 00 a0 00 00  .............=
=2E..
00400030:  80 00 00 00 00 b0 00 00 80 00 00 00 00 c0 00 00  .............=
=2E..
00400040:  80 00 00 00 00 d0 00 00 80 00 00 00 00 e0 00 00  .............=
=2E..
00400050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
read 128/128 bytes at offset 4194304
128 bytes, 1 ops; 0.0001 sec (1.197 MiB/sec and 9803.9216 ops/sec)
qemu-io> q


And with that allocation in place, discarding and then rewriting zero
does NOT lose the allocation:

$ qemu-io -f qcow2 file3
qemu-io> discard 3m 2m
discard 2097152/2097152 bytes at offset 3145728
2 MiB, 1 ops; 0.0007 sec (2.622 GiB/sec and 1342.2819 ops/sec)
qemu-io> w -z 4m 1m
wrote 1048576/1048576 bytes at offset 4194304
1 MiB, 1 ops; 0.0103 sec (97.003 MiB/sec and 97.0026 ops/sec)
qemu-io> w -z 3m 1m
wrote 1048576/1048576 bytes at offset 3145728
1 MiB, 1 ops; 0.0095 sec (104.319 MiB/sec and 104.3188 ops/sec)
qemu-io> q

eblake@red (0) ~/qemu (nbd|REBASE-i 26/109)
$ qemu-io -f raw file3
qemu-io> r -v 4m 128
00400000:  80 00 00 00 00 60 00 00 80 00 00 00 00 50 00 00  .............=
P..
00400010:  80 00 00 00 00 70 00 00 80 00 00 00 00 80 00 01  .....p.......=
=2E..
00400020:  80 00 00 00 00 90 00 01 80 00 00 00 00 a0 00 00  .............=
=2E..
00400030:  80 00 00 00 00 b0 00 00 80 00 00 00 00 c0 00 00  .............=
=2E..
00400040:  80 00 00 00 00 d0 00 00 80 00 00 00 00 e0 00 00  .............=
=2E..
00400050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
00400070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
=2E..
read 128/128 bytes at offset 4194304
128 bytes, 1 ops; 0.0001 sec (1.185 MiB/sec and 9708.7379 ops/sec)
qemu-io>

Clusters 3 and 4 are still mapped to host 8 and 9, as they were
originally.  But what happens when we try to write data there:

$ qemu-io -f qcow2 file3
qemu-io> w 4m 1m
wrote 1048576/1048576 bytes at offset 4194304
1 MiB, 1 ops; 0.0402 sec (24.830 MiB/sec and 24.8299 ops/sec)
qemu-io> q
$ qemu-img map -f qcow2 file3
Offset          Length          Mapped to       File
0               0x100000        0x600000        file3
0x100000        0x100000        0x500000        file3
0x200000        0x100000        0x700000        file3
0x400000        0x100000        0xf00000        file3
0x500000        0x400000        0xa00000        file3
0x9ff000        0x1000          0xeff000        file3

Ouch - that cluster write IGNORED the fact that we already had a
reservation at host 8, and instead changed the mapping so that guest 4
now maps to host f, making our refcount table larger, and fragmenting
things.  So much for pre-allocation saving the day :(

So, we need a bug-fix such that allocating a cluster that will be
replacing an allocated-but-zero cluster would reuse the existing
allocation, rather than create a new mapping.

[Oh, and how will all of this interact with refcounts > 1, when internal
snapshots are in use?  Ugh - I don't know that we want to go there]

But if we can preserve mappings of clusters that are explicitly marked
zero, I started to wonder if it would also be reasonable to have a mode
where we could ALWAYS preserve mappings.  Adding another bit that says
that a cluster has a reserved mapping, but still defers to the backing
file for its current data, would let us extend the existing behavior of
map-preservation on write zeros to work with ALL writes, when writing to
a fully pre-allocated image.

Such a bit is incompatible (existing qemu would not know how to present
correct data to the guest when the bit is set), so if we want it, we
have to burn an incompatible feature bit.  The question is whether this
feature is independently useful enough to do it orthogonally from
subclusters, or whether we want to minimize the exponential explosion of
orthogonal bits by only allowing the feature when subclusters are also
enabled.  And in a way, subclusters already provide this feature: any
time you map a cluster to an address, but have ALL of its subclusters
marked as unallocated (read from backing file), you have preallocated a
mapping that you can later use when writing to that cluster, and that
preallocation is no longer tied to whether the guest uses write-zeros.

When I chatted with Max on IRC about the idea, we said this:


<mreitz> I mean, sure, we can add both, but I'd still want them two be
two incompatible bits
<eblake> if you want the features to be orthogonal (with exponentially
more cases to check), then having multiple incompatible bits is okay
<mreitz> Because FEATURE_BIT_UNALLOCATED_AND_SUBCLUSTERS sounds weird
and FEATURE_BIT_EXTENDED_L2_ENTRIES a bit pretentious
<mreitz> Well, orthogonal is a good question. If we want to have an
UNALLOCATED flag we should think so before adding subclusters
<mreitz> Because then we should at least make clear that the ZERO flag
for a subcluster requires the ALLOCATED flag to be set or something
<mreitz> So we can reserve ZERO/!ALLOCATED for the case where you want
to fall through to the backing file

So, if you got this far in reading, the question becomes whether having
a mode where you can mark a cluster as mapping-reserved-but-unallocated
has enough use case to be worth pursuing, knowing that it will burn an
incompatible feature bit; or if it should be rolled into the subcluster
proposal, or whether it's not a feature that anyone needs after all.

And meanwhile, it looks like I have some patches to propose (and
qemu-iotests to write) if I can help fix the bugs I've pointed out.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wtwWWAeEAXrFbiPHG3VptwgNmjnSQRllM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+nT4AAoJEKeha0olJ0NqDB0H/0ylZzJBUygrYlTQJ0jkqNDW
yj7anZPVI63tV2qjsm0D80mmPqJcbQVxvNMkyjSEZVx0W4TVF3jmQz0tXi5sUJqu
1hYcrfm3KuSvaPKZIqcm3U/2rzsrNKNSCyeAj39XkRqHN9iteuR354YvM/O4onvH
Sw50MH51t16OP6ZToeExrQ0W44n1MN5KUN75U0wBZ5LZHCr47qwnCIyI0IdgYMbQ
T7V8xoOcC2U0qzYdfPZZv6ZKWrhoTMMoNQoODoky0wpL5G2cKEh1rRdk3a8ZTF7O
lFJy6EfjHbmTHkBHJUHkVVt4QRm0FrReMjxCFvEa28LL5sFaQbdboffoycdGnFo=
=1qKn
-----END PGP SIGNATURE-----

--wtwWWAeEAXrFbiPHG3VptwgNmjnSQRllM--
