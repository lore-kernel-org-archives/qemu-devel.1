Received: from eggs.gnu.org ([2001:4830:134:3::10]:38896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwPq-0001Lf-B2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxwPp-0002SS-5B
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:05:06 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
Date: Tue, 11 Apr 2017 16:04:53 +0200
MIME-Version: 1.0
In-Reply-To: <w5160ibyufr.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oUtU9vcURMiFfgmvShGjwBrumATBpGohb"
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
--oUtU9vcURMiFfgmvShGjwBrumATBpGohb
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
Subject: Re: [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
In-Reply-To: <w5160ibyufr.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 14:56, Alberto Garcia wrote:
> On Fri 07 Apr 2017 07:10:46 PM CEST, Max Reitz wrote:
>>> =3D=3D=3D Changes to the on-disk format =3D=3D=3D
>>>
>>> The qcow2 on-disk format needs to change so each L2 entry has a bitma=
p
>>> indicating the allocation status of each subcluster. There are three
>>> possible states (unallocated, allocated, all zeroes), so we need two
>>> bits per subcluster.
>>
>> You don't need two bits, you need log(3) / log(2) =3D ld(3) =E2=89=88 =
1.58. You
>> can encode the status of eight subclusters (3^8 =3D 6561) in 13 bits
>> (ld(6561) =E2=89=88 12.68).
>=20
> Right, although that would make the encoding more cumbersome to use and=

> to debug. Is it worth it?

Probably not, considering this is probably not the way we want to go anyw=
ay.

>> One case I'd be especially interested in are of course 4 kB
>> subclusters for 64 kB clusters (because 4 kB is a usual page size and
>> can be configured to be the block size of a guest device; and because
>> 64 kB simply is the standard cluster size of qcow2 images
>> nowadays[1]...).
>=20
> I think that we should have at least that, but ideally larger
> cluster-to-subcluster ratios.
>=20
>> (We could even get one more bit if we had a subcluster-flag, because I=

>> guess we can always assume subclustered clusters to have OFLAG_COPIED
>> and be uncompressed. But still, three bits missing.)
>=20
> Why can we always assume OFLAG_COPIED?

Because partially allocated clusters cannot be used with internal
snapshots, and that is what OFLAG_COPIED is for.

>> If course, if you'd be willing to give up the all-zeroes state for
>> subclusters, it would be enough...
>=20
> I still think that it looks like a better idea to allow having more
> subclusters, but giving up the all-zeroes state is a valid
> alternative. Apart from having to overwrite with zeroes when a
> subcluster is discarded, is there anything else that we would miss?

It if it's a real discard you can just discard it (which is what we do
for compat=3D0.10 images anyway); but zero-writes will then have to be
come real writes, yes.

>> By the way, if you'd only allow multiple of 1s overhead
>> (i.e. multiples of 32 subclusters), I think (3) would be pretty much
>> the same as (2) if you just always write the subcluster information
>> adjacent to the L2 table. Should be just the same caching-wise and
>> performance-wise.
>=20
> Then (3) is effectively the same as (2), just that the subcluster
> bitmaps are at the end of the L2 cluster, and not next to each entry.

Exactly. But it's a difference in implementation, as you won't have to
worry about having changed the L2 table layout; maybe that's a benefit.

Max


--oUtU9vcURMiFfgmvShGjwBrumATBpGohb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs4oUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKT4H/3yWGqVFF59IThGMJ6vrNsq5D5VhxlAh
wlUx5Fd5t6inyRiCNQWn7OvJmYOY2C4KGLfmdgKOSt6tiLScS9DPdot5WHI91aRc
K9NScerAV5cI3sE+LtSntRnuy8m6cpi2ah0XFXtHloTmrObHL6ANxhmV5QnEHEfO
jzU93Kfh5IIMigFSXVC11d3av0K+cRiXlLIN1oAQYKEuKiq3ytYK+djBxZJZCynh
panZKdA5pUQOn44qBbN+1NW/YufeLXqXsRnt6XGxEPE03NdXxY1iXEeyixCa/rU8
eS+9nHniLwp2ys5u7T+KuEh2nvTcZ8NA4FOss2nC48uoUbPRlvhMULc=
=5+tK
-----END PGP SIGNATURE-----

--oUtU9vcURMiFfgmvShGjwBrumATBpGohb--
