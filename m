Received: from eggs.gnu.org ([2001:4830:134:3::10]:57575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxGf-0004RG-Ft
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxGe-0002kd-IF
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 10:59:41 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
Date: Tue, 11 Apr 2017 16:59:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170411144921.GN4516@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gfHL1oLCn5kkgpJrVb3Qb4qPXXpuAFMcM"
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
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gfHL1oLCn5kkgpJrVb3Qb4qPXXpuAFMcM
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
Subject: Re: [RFC] Proposed qcow2 extension: subcluster allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
In-Reply-To: <20170411144921.GN4516@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 16:49, Kevin Wolf wrote:

[...]

>>>>> By the way, if you'd only allow multiple of 1s overhead
>>>>> (i.e. multiples of 32 subclusters), I think (3) would be pretty muc=
h
>>>>> the same as (2) if you just always write the subcluster information=

>>>>> adjacent to the L2 table. Should be just the same caching-wise and
>>>>> performance-wise.
>>>>
>>>> Then (3) is effectively the same as (2), just that the subcluster
>>>> bitmaps are at the end of the L2 cluster, and not next to each entry=
=2E
>>>
>>> Exactly. But it's a difference in implementation, as you won't have t=
o
>>> worry about having changed the L2 table layout; maybe that's a
>>> benefit.
>>
>> I'm not sure if that would simplify or complicate things, but it's wor=
th
>> considering.
>=20
> Note that 64k between an L2 entry and the corresponding bitmap is enoug=
h
> to make an update not atomic any more. They need to be within the same
> sector to get atomicity.

Good point, but that also means that (with (2)) you can only use
subcluster configurations where the L2 entry size increases by a power
of two. Unfortunately, only one of those configurations itself is a
power of two, and that is 32.

(With 32 subclusters, you take up 64 bits, which means an L2 entry will
take 128 bits; with any higher 2^n, you'd take up 2^{n+1} bits and the
L2 entry would take 2^{n+1} + 64 which is impossible to be a power of two=
=2E)

I don't know how useful non-power-of-two subcluster configurations are.
Probably not at all.

Since using subcluster would always result in the L2 table taking more
than 512 bytes, you could therefore never guarantee that there is no
entry overlapping a sector border (except with 32 subclusters).

Max


--gfHL1oLCn5kkgpJrVb3Qb4qPXXpuAFMcM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs70sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqAcH/RzrEbZcFEOEEeXOUQLuHnmnwpsNhx5Z
U0oNp01q2t273QI7PWML7A0nXqpZMdhomqwvJ73CFTMUJ3IjNOjFR4JzFgeX+AM9
rMtN6HzmSyAUz0FcBXSmAqT2cw1ErazCY2m9qw8laDV+dLPGpvACQ2kYBvgzoaAk
dDVEyn+dDxe+xMCNGMrn7gYmktsHuEa27OOeVnI8vs8X9DQbVm5oor6mvp4NRu8d
JJjq/QSO5natYKEkl/47l86z3vdwbXRRvgffQv7eQBPZZ69PVQL7AgJzTsYaw3ph
zgsTvVTkKDIZ7Homhxx2FbM9B/82rYiwuuwxQnE/cxRwIpVtxc62fik=
=uhhj
-----END PGP SIGNATURE-----

--gfHL1oLCn5kkgpJrVb3Qb4qPXXpuAFMcM--
