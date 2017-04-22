Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1zHS-0005zl-EK
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d1zHR-0000YF-6n
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 13:57:10 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
	<382b0707-233d-ab05-e054-3da43617460d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
Date: Sat, 22 Apr 2017 19:56:57 +0200
MIME-Version: 1.0
In-Reply-To: <382b0707-233d-ab05-e054-3da43617460d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ORlLhCLNNLRnXOdSgg7sp41slAhIuALEI"
Subject: Re: [Qemu-devel] proposed qcow2 extension: cluster reservations
 [was: [RFC] Proposed qcow2 extension: subcluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ORlLhCLNNLRnXOdSgg7sp41slAhIuALEI
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1877dc76-87e0-650c-d76a-44e6e7754a2b@redhat.com>
Subject: Re: proposed qcow2 extension: cluster reservations [was: [Qemu-devel]
 [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <da7174ff-38c1-07fd-96b6-fa9280524002@redhat.com>
 <382b0707-233d-ab05-e054-3da43617460d@redhat.com>
In-Reply-To: <382b0707-233d-ab05-e054-3da43617460d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.04.2017 23:09, Eric Blake wrote:
> On 04/06/2017 11:40 AM, Eric Blake wrote:
>=20
>>> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>>>
>>> The qcow2 on-disk format needs to change so each L2 entry has a bitma=
p
>>> indicating the allocation status of each subcluster. There are three
>>> possible states (unallocated, allocated, all zeroes), so we need two
>>> bits per subcluster.
>>
>> You also have to add a new incompatible feature bit, so that older too=
ls
>> know they can't read the new image correctly, and therefore don't
>> accidentally corrupt it.
>=20
> As long as we are talking about incompatible feature bits, I had some
> thoughts about image mapping today.
>=20
> tl;dr: summary> As long as we are considering incompatible features, ma=
ybe we should
> make it easier to have an image file that explicitly preserves
> guest=3D>host mapping, such that nothing the guest can do will reorder =
the
> mapping.  This way, it would be possible to fully preallocate an image
> such that all guest offsets are adjusted by a constant offset to become=

> the corresponding host offset (basically, no qcow2 metadata is
> interleaved in the middle of guest data).
>=20
> I don't see any way to do it on current qcow2 images, but with
> subclusters, you get it for free by having a cluster with an offset but=

> with all subclusters marked as unallocated.  But perhaps it is somethin=
g
> orthogonal enough that we would want a separate incompatible feature bi=
t
> for just this, without having subclusters at the same time.
>=20
> In the process of exploring the topic, I expose a couple of existing
> bugs in our qcow2 handling.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Longer version:
>=20
> If I'm reading qcow2-clusters.c and qcow2-refcount.c correctly, our
> current implementation of bdrv_discard() says that except for clusters
> already marked QCOW2_CLUSTER_ZERO, we will unconditionally remove the L=
2
> mapping of the address.

As I've said, I think the ZERO bit is just a bug and we should free
preallocated zero clusters.

>                          Whether we actually punch a hole in the
> underlying image, or merely add it to a list of free clusters for use i=
n
> subsequent allocations, is later decided based on
> s->discard_passthrough[type] (that is, the caller can pass different
> type levels that control whether to never punch, always punch, or let
> the blockdev parameters of the caller control whether to punch).
>=20
> Presumably, if I've preallocated my image because I want to guarantee
> enough host space, then I would use blockdev parameters that ensure tha=
t
> guest actions never punch a hole.  But based on my reading, I still hav=
e
> the situation that if I initially preallocated things so that guest
> cluster 0 and 1 are consecutive clusters in the host, and the guest
> triggers bdrv_pdiscard() over both clusters, then writes to cluster 1
> before cluster 0, then even though I'm not changing the underlying
> allocation of the host file, I _am_ resulting in fragmentation in the
> qcow2 file, where cluster 1 in the guest now falls prior to cluster 0.

[...]

> But if we can preserve mappings of clusters that are explicitly marked
> zero, I started to wonder if it would also be reasonable to have a mode=

> where we could ALWAYS preserve mappings.  Adding another bit that says
> that a cluster has a reserved mapping, but still defers to the backing
> file for its current data, would let us extend the existing behavior of=

> map-preservation on write zeros to work with ALL writes, when writing t=
o
> a fully pre-allocated image.

Yes, and it also means that we may want to think about implementation a
preallocation mode in qemu which puts all of the data into a single
consecutive chunk (as you have hinted at somewhere above).

> When I chatted with Max on IRC about the idea, we said this:
>=20
>=20
> <mreitz> I mean, sure, we can add both, but I'd still want them two be
> two incompatible bits
> <eblake> if you want the features to be orthogonal (with exponentially
> more cases to check), then having multiple incompatible bits is okay
> <mreitz> Because FEATURE_BIT_UNALLOCATED_AND_SUBCLUSTERS sounds weird
> and FEATURE_BIT_EXTENDED_L2_ENTRIES a bit pretentious
> <mreitz> Well, orthogonal is a good question. If we want to have an
> UNALLOCATED flag we should think so before adding subclusters
> <mreitz> Because then we should at least make clear that the ZERO flag
> for a subcluster requires the ALLOCATED flag to be set or something
> <mreitz> So we can reserve ZERO/!ALLOCATED for the case where you want
> to fall through to the backing file
>=20
> So, if you got this far in reading, the question becomes whether having=

> a mode where you can mark a cluster as mapping-reserved-but-unallocated=

> has enough use case to be worth pursuing, knowing that it will burn an
> incompatible feature bit; or if it should be rolled into the subcluster=

> proposal, or whether it's not a feature that anyone needs after all.

I just forgot that just saying !ALLOCATED will be enough, regardless of
the ZERO flag... Yeah, subclusters will give us this for free, and I
think it's therefore reasonable to just require them if you want this
feature (preallocation with a backing file).

> And meanwhile, it looks like I have some patches to propose (and
> qemu-iotests to write) if I can help fix the bugs I've pointed out.

You mean these?
https://github.com/XanClic/qemu/commits/random-qcow2-stuff-v1

;-)

I'll send them once I've written tests.

Max


--ORlLhCLNNLRnXOdSgg7sp41slAhIuALEI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlj7mWkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXTMH/3QF95NXwDKMeX0S60qpB8Z14lDa2jvC
FBbIoJUcLlbHb35QKIBvNEOoaEWQReIu6N92fMp1qtTTLu+Zom2VRXytbEqicSao
vzpcj6IcHZWEvpZRNFN9A+bxsRj2s/hfP91jHISCF2yN5jgo8oqG7oDs1zZKIaKS
mOl7OpY1JLw3oAw4P2Hcb59iaZpPzp3yA5epWNFdBpbU647vcdtp49yQn3ZUYf/V
d9nO1S07Mh2zLN7JLSUvjW2efu5kAgP8iIXSZkbzEXbNEXQN/BtG/CQM4ugcoh1S
tTP/KCNfBvBiFVRDYCf0xD9pHxsFSib0j/6zNVVEZjYqnbZIKG0Yj0M=
=5oPd
-----END PGP SIGNATURE-----

--ORlLhCLNNLRnXOdSgg7sp41slAhIuALEI--
