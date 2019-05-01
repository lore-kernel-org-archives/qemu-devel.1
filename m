Received: from eggs.gnu.org ([209.51.188.92]:33600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLr6b-0004Zw-Nn
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLr6V-0001Ds-Sk
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:25:07 -0400
References: <20181116184324.8093-1-jsnow@redhat.com>
	<4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
	<cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
Date: Wed, 1 May 2019 10:24:36 -0500
MIME-Version: 1.0
In-Reply-To: <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj"
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <fb05bc7d-7632-f72c-1c32-ba16d21a7fcb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: Silence
 coverity CID 1390625
References: <20181116184324.8093-1-jsnow@redhat.com>
 <4bc81482-fab6-80dd-f684-4ffde4241dce@virtuozzo.com>
 <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
In-Reply-To: <cb6469ca-9ba3-1ac7-7c3e-9e6c8c53e55f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 6:08 PM, John Snow wrote:
>=20
>=20
> On 11/20/18 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 16.11.2018 21:43, John Snow wrote:
>>> Coverity warns that backing_bs() could give us a NULL pointer, which
>>> we then use without checking that it isn't.
>>>
>>> In our loop condition, we check bs && bs->drv as a point of habit, bu=
t
>>> by nature of the block graph, we cannot have null bs pointers here.
>>>
>>> This loop skips only implicit nodes, which always have children, so
>>> this loop should never encounter a null value.
>>
>=20
> I let this drop again :)
>=20
>> You mean, always have backing (not file for ex.)? Should we at least a=
dd a comment
>> near "bool implicit;" that the node must have backing..
>>
>> Do we have filters, using 'file' child instead of backing, will we wan=
t to auto insert them, and therefore mark them with implicit=3Dtrue?
>>
>=20
> I actually have no idea. I guess this is the sort of thing we actually
> really want a dedicated kind of API for. "Find first non-filter" seems
> like a common use case that we'd want.
>=20
> [But maybe I'll avoid this problem.]

Max has already tried to tackle that problem:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01713.html

>=20
>> And one more thing:
>> So, it's looks like a wrong way to search for all block-nodes, instead=
 of looping through backing chain to the first not-implicit bds, we must =
recursively explore the whole block graph, to find _all_ the bitmaps.
>>
>=20
> Looking at this again after not having done so for so long -- I guess
> that bdrv_first/bdrv_next only iterate over *top level* BDSes and not
> any children thereof. You're right, even the method here isn't quite
> correct. We want to find ALL nodes, wherever they are.
>=20
> query_named_block_nodes uses an implementation in block.c to accomplish=

> this because the API is not public.... or, it wasn't, but it looks like=

> we have bdrv_next_all_states now, and we could use this to just find AL=
L
> of the bdrv nodes.
>=20
> Ehm.... let me send something a little more RFC-caliber that should
> address your concern (as well as Peter's) here.

Max's series also tries to improve how we visit nodes when determining
which bitmaps to find.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzJujQACgkQp6FrSiUn
Q2rrgwf/Z4xmDq0VHvF3495unToxko7PShHyR5SSiF5FCuN+WV1m3XyDdJNzWawO
qzo1XZ+4aTMmSocXBXggY359d0GkgXpMZo+dxuvp2Sqox0Pft34WfkYQz05RlG82
vYW1LMzyAlUmg9SwKTf2YnOBfA2nV7cK+HT26gReCcozifJHz6IMsw6iBqUvihln
RBmbM5xTmPuynscwL6EuCw00ngQK9KBDC6oaI2cXoWs1O8qGF4XK5CRY43FbOMXE
CiewuU//VoJEJ6k+mkVfzcZAAd1YH+GZGtfrbt/G85TzS+26DjMvMaclX/ONq9PP
3y0xnNVsAvUk9bl8enkZiyNJONXqXA==
=0q0G
-----END PGP SIGNATURE-----

--NZ2bxkoyGL4juIOgvnyHGP1wjlx3mAtbj--
