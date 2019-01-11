Received: from eggs.gnu.org ([209.51.188.92]:32911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0Em-0004fl-DD
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:04:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0Ek-0004kX-Vn
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:04:52 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<20190111104126.GC5010@dhcp-200-186.str.redhat.com>
	<b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
	<20190111122151.GF5010@dhcp-200-186.str.redhat.com>
	<8a963e64-ca73-d1ff-0736-ade519d868e7@virtuozzo.com>
	<20190111131538.GH5010@dhcp-200-186.str.redhat.com>
	<277fe3a0-9025-b96e-41b2-0388f491d724@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07274f18-f342-9f9f-7b9f-9b68100ae7d9@redhat.com>
Date: Fri, 11 Jan 2019 11:04:32 -0600
MIME-Version: 1.0
In-Reply-To: <277fe3a0-9025-b96e-41b2-0388f491d724@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FdXG4vcozOV3LVhrDXC0NzeisnlGNgpAh"
Subject: Re: [Qemu-devel] [PATCH] block: don't probe zeroes in bs->file by
 default on block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FdXG4vcozOV3LVhrDXC0NzeisnlGNgpAh
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <07274f18-f342-9f9f-7b9f-9b68100ae7d9@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
 <20190111104126.GC5010@dhcp-200-186.str.redhat.com>
 <b504e946-205c-8800-fe2c-e11f0b27c23a@virtuozzo.com>
 <20190111122151.GF5010@dhcp-200-186.str.redhat.com>
 <8a963e64-ca73-d1ff-0736-ade519d868e7@virtuozzo.com>
 <20190111131538.GH5010@dhcp-200-186.str.redhat.com>
 <277fe3a0-9025-b96e-41b2-0388f491d724@virtuozzo.com>
In-Reply-To: <277fe3a0-9025-b96e-41b2-0388f491d724@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 10:09 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> I suggested one: Pass large contiguous allocated ranges to the proto=
col
>>>> driver, but just assume that the allocation status is correct in the=

>>>> format layer if they are small.
>>>
>>> So, for fully allocated image, we will call lseek always?
>>
>> If they are fully contiguous, yes. But that's a single lseek() call pe=
r
>> image then instead of an lseek() for every 64k, so not a big problem.
>=20
> lseek is called on each mirror iteration, why one per image?

If the image has no holes, then lseek(0, SEEK_HOLE) will return EOF, and
then you know that there are no holes, and you don't need to make any
further lseek() calls.  Hence, once per image.  A fully-allocated file
that has areas that read as known zeroes can be determined by fiemap
(but not by lseek, which can only detect unallocated holes) - but we
already know that while fiemap has more information, it also has more
problems (you cannot use it safely without sync, but sync makes it too
slow to use), so that is a non-starter.

>>
>> In the more realistic case, you will still call lseek() occasionally
>> because you will have some fragmentation, but the fragments can be
>> rather large. But it should still significantly reduce them compared t=
o
>> now because you skip it for those parts with small contiguous
>> allocations where lseek() would be called a lot today.
>>
>> Kevin
>>
>=20
> Ok, you propose not to call lseek for small enough data regions reporte=
d by
> format layer. And for images which are less fragmented, this helps less=
 or don't
> help.

Indeed - pick some threshold (maybe 16 clusters); if block status of the
format layer returns something smaller than the threshold, don't bother
refining the answer further by doing block status of the protocol layer
(if the caller is iterating over an image 1 cluster at a time, then the
threshold will never be tripped and thus you'll never do an lseek); but
where the block status of the format layer is large, we are reading the
file in larger chunks so we end up with fewer lseeks in the long run
anyways.

>=20
> Why do you think it is better?
>=20
> For not preallocated images it is worse, as it covers less cases. So, f=
or our
> scenarios it is worse.

Anywhere that you skip calling lseek(), you end up missing out on
opportunities to optimize had you instead been able to learn from lseek
that you were on a hole after all.  So it becomes a balancing question:
how much time is spent on probing for whether an optimization is even
possible, vs. how much time is spent if the probe succeeded and you can
then optimize.  For a fully-allocated image, all of the time spent
probing is wasted (you never find a hole, so every probe was wasted).
So it is indeed a tradeoff when picking your heuristics, of trying to
balance how likely the probe will justify the time spent on the probe.

> The only case, when heuristic works better, is when user have prealloca=
ted image,
> but don't know about new option, which returns old behavior. We are not=
 interested
> in this case and can't go this way, as it doesn't guarantee, that some =
customer will
> not come again with lseek-related problems.
>=20
> Don't you like what Eric propose, about binding behavior switch to exis=
ting
> detect-zeroes option?
>=20
> Or, we can add an opposite option, to enable new behavior, keeping the =
old one by
> default. So, all stays as is, and who need uses new option. Heuristic m=
ay be
> implemented then too.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--FdXG4vcozOV3LVhrDXC0NzeisnlGNgpAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4zKAACgkQp6FrSiUn
Q2oD6AgAjoiNXX+dVvtGvRZ+kVhZKDOJbsYhQHKjapKPJ4udauqRj7MoOrg9IYKQ
DOXSbsWK2kAC8222UetH3HHiZsLcBooBW9/tRpnqhVScmT7piL4BBecI/XRESp9L
GGJT2eh+Tve+s0g30xeGxN7kIBXIEL3LkBocWePr9AFn+yJxH+2m/JnunbtQuuc4
JLSPp7f4WEqJPx+Fgk8mebuojq0Iaw20xQxoKTOUbmWVCNyGOkOn/UDAeEl5SHyc
lO5pNZe+LMCJ41CLmkZp3Mz3iqK+1uwTbadvMMzaHkT4jVzNNrPX1Oz+2thgns9I
E7VLp3K8XuvIS5YGCuuo7kQZ9hswvw==
=95Rj
-----END PGP SIGNATURE-----

--FdXG4vcozOV3LVhrDXC0NzeisnlGNgpAh--
