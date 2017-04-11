Received: from eggs.gnu.org ([2001:4830:134:3::10]:37775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxk2-00067C-CQ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cxxk0-0003Dr-Vt
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 11:30:02 -0400
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
	<d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
	<w5160ibyufr.fsf@maestria.local.igalia.com>
	<9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
	<w5137dfyq1f.fsf@maestria.local.igalia.com>
	<20170411144921.GN4516@noname.str.redhat.com>
	<b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
	<1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
	<760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
	<20170411152922.GP4516@noname.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5fff2f1d-b105-8ca3-d3dc-0f167b1077fe@redhat.com>
Date: Tue, 11 Apr 2017 17:29:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170411152922.GP4516@noname.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UXUpxrTg6xHvoVlulGdUjIxJQVpJR70Xq"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UXUpxrTg6xHvoVlulGdUjIxJQVpJR70Xq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Message-ID: <5fff2f1d-b105-8ca3-d3dc-0f167b1077fe@redhat.com>
Subject: Re: [Qemu-devel] [RFC] Proposed qcow2 extension: subcluster
 allocation
References: <20170406150148.zwjpozqtale44jfh@perseus.local>
 <d60ea1f9-ae2c-6625-90de-944cbb490f85@redhat.com>
 <w5160ibyufr.fsf@maestria.local.igalia.com>
 <9d848582-8c76-4d88-2b31-e0e4c63b61d4@redhat.com>
 <w5137dfyq1f.fsf@maestria.local.igalia.com>
 <20170411144921.GN4516@noname.str.redhat.com>
 <b5fb4bc7-d07b-6b7a-4fd5-d17c6e380ce7@redhat.com>
 <1bbcc4ba-e889-2242-cb44-c933eedfb212@redhat.com>
 <760cb82c-9bff-c289-c2b3-940319c66b5c@redhat.com>
 <20170411152922.GP4516@noname.str.redhat.com>
In-Reply-To: <20170411152922.GP4516@noname.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11.04.2017 17:29, Kevin Wolf wrote:
> Am 11.04.2017 um 17:18 hat Max Reitz geschrieben:
>> On 11.04.2017 17:08, Eric Blake wrote:
>>> On 04/11/2017 09:59 AM, Max Reitz wrote:
>>>
>>>>
>>>> Good point, but that also means that (with (2)) you can only use
>>>> subcluster configurations where the L2 entry size increases by a pow=
er
>>>> of two. Unfortunately, only one of those configurations itself is a
>>>> power of two, and that is 32.
>>>>
>>>> (With 32 subclusters, you take up 64 bits, which means an L2 entry w=
ill
>>>> take 128 bits; with any higher 2^n, you'd take up 2^{n+1} bits and t=
he
>>>> L2 entry would take 2^{n+1} + 64 which is impossible to be a power o=
f two.)
>>>
>>> Or we add padding. If you want 64 subclusters, you burn 256 bits per>=
 entry, even though only 192 of those bits are used.
>>
>> Hm, yeah, although you have to keep in mind that the padding is almost=

>> pretty much the same as the the data bits we need, effectively doublin=
g
>> the size of the L2 tables:
>>
>> padding =3D 2^{n+2} - 2^{n+1} - 64 (=3D2^6)
>>         =3D 2^{n+1} - 64
>>
>> So that's not so nice, but if it's the only thing we can do...
>>
>>>> I don't know how useful non-power-of-two subcluster configurations a=
re.
>>>> Probably not at all.
>>>>
>>>> Since using subcluster would always result in the L2 table taking mo=
re
>>>> than 512 bytes, you could therefore never guarantee that there is no=

>>>> entry overlapping a sector border (except with 32 subclusters).
>>>
>>> Yes, there's definite benefits to keeping whatever structure we end u=
p
>>> with aligned so that it naturally falls into sector boundaries, even =
if
>>> it means more padding bits.
>>
>> Then again, I'm not even sure we really need atomicity for L2 entries =
+
>> subcluster bits. I don't think you'd ever have to modify both at the
>> same time (if you just say the subclusters are all unallocated when
>> allocating the cluster itself, and then you write which subclusters ar=
e
>> actually allocated afterwards)).
>>
>> (This also applies to your remark on caching, I think.)
>>
>> Atomicity certainly makes things easier, though.
>=20
> Unless you want to deal with ordering (i.e. on cluster allocation, firs=
t
> update the subcluster bitmap, then flush, then add the L2 entry), I
> think you need atomicity.

Yes, that's what I meant.

Max


--UXUpxrTg6xHvoVlulGdUjIxJQVpJR70Xq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljs9mwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsO8H/1GqF7/diaYb6Om/83nc5EUtlWvTUA/Y
Cg5uDQupii62LhSUgUpjkUf9bf9MPenOXoJFGVhbpwuatE+/JSRMmE38DlnMKVQm
AUpBuRBHptgOJRoCS8zXsFh0E14ZHhQXPZLjzwXs+NMFPXOG+zObo7mBKLS7K64w
quuJXFsLj2x32BJ3Ev+GvOMc1cfb5bvtqhfTZoqToQ7yhK7q8vwZOS7yyUR31Huy
vkFkMxfE22TY4ASH1Ss0mwx1LA++TzP7mIXfoxRd12cLNccoUHUnhdhMuKb+/nbx
jyZufTELTw4EvGbExrFuzSzD6SxiGhxm+nbevkA+o0BR/Q1ryQhY13U=
=XXm7
-----END PGP SIGNATURE-----

--UXUpxrTg6xHvoVlulGdUjIxJQVpJR70Xq--
