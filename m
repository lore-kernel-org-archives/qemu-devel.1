Received: from eggs.gnu.org ([2001:4830:134:3::10]:55028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv2IM-0005TM-Pt
	for Qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fv2IG-0001U2-CC
	for Qemu-devel@nongnu.org; Wed, 29 Aug 2018 11:22:10 -0400
From: Max Reitz <mreitz@redhat.com>
References: <c8301133-5f39-3fa5-af3e-9bc60ce44172@redhat.com>
	<8c51bdec-2862-211d-3818-ee69b51ef17c@redhat.com>
	<045562f3-6c25-244d-7ba5-1ae8650ab405@redhat.com>
	<f36df962-ade5-6e79-957c-d2e541fa752c@redhat.com>
Message-ID: <b751574b-c1db-6584-84dd-89732a93b08b@redhat.com>
Date: Wed, 29 Aug 2018 17:22:00 +0200
MIME-Version: 1.0
In-Reply-To: <f36df962-ade5-6e79-957c-d2e541fa752c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2RlB7i0KMa8EqL2hwIm76mPvs26qa3Raf"
Subject: Re: [Qemu-devel] blkdebug get_status bug [was: [Qemu-block] NBD
 structured reads vs. block size]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu block <qemu-block@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2RlB7i0KMa8EqL2hwIm76mPvs26qa3Raf
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu block <qemu-block@nongnu.org>,
 Kevin O'Connor <kevin@koconnor.net>,
 "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>
Message-ID: <b751574b-c1db-6584-84dd-89732a93b08b@redhat.com>
Subject: Re: [Qemu-devel] blkdebug get_status bug [was: [Qemu-block] NBD
 structured reads vs. block size]
References: <c8301133-5f39-3fa5-af3e-9bc60ce44172@redhat.com>
 <8c51bdec-2862-211d-3818-ee69b51ef17c@redhat.com>
 <045562f3-6c25-244d-7ba5-1ae8650ab405@redhat.com>
 <f36df962-ade5-6e79-957c-d2e541fa752c@redhat.com>
In-Reply-To: <f36df962-ade5-6e79-957c-d2e541fa752c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-29 15:24, Max Reitz wrote:
> On 2018-08-28 23:59, Eric Blake wrote:
>> [following up to a different set of emails]
>>
>> On 08/28/2018 03:41 PM, Eric Blake wrote:
>>> Revisiting this:
>>>
>>> On 08/01/2018 09:41 AM, Eric Blake wrote:
>>>> Rich Jones pointed me to questionable behavior in qemu's NBD server
>>>> implementation today: qemu advertises a minimum block size of 512 to=

>>>> any client that promises to honor block sizes, but when serving up a=

>>>> raw file that is not aligned to a sector boundary, attempting to rea=
d
>>>> that final portion of the file results in a structured read with two=

>>>> chunks, the first for the data up to the end of the actual file, and=

>>>> the second reporting a hole for the rest of the sector. If a client
>>>> is promising to obey block sizes on its requests, it seems odd that
>>>> the server is allowed to send a result that is not also aligned to
>>>> block sizes.
>>>>
>>>> Right now, the NBD spec says that when structured replies are in use=
,
>>>> then for a structured read:
>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 The server MAY split the reply into any num=
ber of content chunks;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 each chunk MUST describe at least one byte,=
 although to minimize
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 overhead, the server SHOULD use chunks with=
 lengths and offsets as
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 an integer multiple of 512 bytes, where pos=
sible (the first and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 last chunk of an unaligned read being the m=
ost obvious places for
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 an exception).
>>>>
>>>> I'm wondering if we should tighten that to require that the server
>>>> partition the reply chunks to be aligned to the advertised minimum
>>>> block size (at which point, qemu should either advertise 1 instead o=
f
>>>> 512 as the minimum size when serving up an unaligned file, or else
>>>> qemu should just send the final partial sector as a single data chun=
k
>>>> rather than trying to report the last few bytes as a hole).
>>>>
>>>> For comparison, on block status, we require:
>>>>
>>>> =C2=A0=C2=A0=C2=A0 The server SHOULD use descriptor
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 lengths that are an integer multiple of 512=
 bytes where possible
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 (the first and last descriptor of an unalig=
ned query being the
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 most obvious places for an exception), and =
MUST use descriptor
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 lengths that are an integer multiple of any=
 advertised minimum
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 block size.
>>>>
>>>> And qemu as a client currently hangs up on any server that violates
>>>> that requirement on block status (that is, when qemu as the server
>>>> tries to send a block status that was not aligned to the advertised
>>>> block size, qemu as the client flags it as an invalid server - which=

>>>> means qemu as server is currently broken).=C2=A0 So I'm thinking we =
should
>>>> copy that requirement onto servers for reads as well.
>>>
>>> Vladimir pointed out that the problem is not necessarily just limited=

>>> to the implicit hole at the end of a file that was rounded up to
>>> sector size.=C2=A0 Another case where sub-region changes occur in qem=
u is
>>> where you have a backing file with 512-byte hole granularity (qemu-im=
g
>>> create -f qcow2 -o cluster_size=3D512 backing.qcow2 100M) and an over=
lay
>>> with larger granularity (qemu-img create -f qcow2 -b backing.qcow2 -F=

>>> qcow2 -o cluster_size=3D4k active.qcow2). On a cluster where the top
>>> layer defers to the underlying layer, it is possible to alternate
>>> between holes and data at sector boundaries but at subsets of the
>>> cluster boundary of the top layer.=C2=A0 As long as qemu advertises a=

>>> minimum block size of 512 rather than the cluster size, then this
>>> isn't a problem, but if qemu were to change to report the qcow2
>>> cluster size as its minimum I/O (rather than merely its preferred I/O=
,
>>> because it can do read-modify-write on data smaller than a cluster),
>>> this would be another case where unaligned replies might confuse a
>>> client.
>>
>> So, I tried to actually create this scenario, to see what actually
>> happens, and we have a worse bug that needs to be resolved first.=C2=A0=
 That
>> is, bdrv_block_status_above() chokes when there is a blkdebug node in
>> the works:
>>
>> $ qemu-img create -f qcow2 -o cluster_size=3D512 back.qcow2 100M
>> $ qemu-io -c 'w P1 0 512' -c 'w -P1 1k 512' -f qcow2 back.qcow2
>=20
> s/ P1/ -P1/
>=20
>> $ qemu-img create -f qcow2 -F qcow2 -b back.qcow2 \
>> =C2=A0=C2=A0=C2=A0 -o cluster_size=3D1M top.qcow2
>> $ qemu-img map --output=3Djson -f qcow2 top.qcow2
>> [{ "start": 0, "length": 512, "depth": 1, "zero": false, "data": true,=

>> "offset": 27648},
>> { "start": 512, "length": 512, "depth": 1, "zero": true, "data": false=
},
>> { "start": 1024, "length": 512, "depth": 1, "zero": false, "data": tru=
e,
>> "offset": 28160},
>> { "start": 1536, "length": 104856064, "depth": 1, "zero": true, "data"=
:
>> false}]
>> $ qemu-img map --output=3Djson --image-opts \
>> =C2=A0=C2=A0 driver=3Dblkdebug,image.driver=3Dqcow2,image.file.driver=3D=
file,\
>> image.file.filename=3Dtop.qcow2,align=3D4k
>> [{ "start": 0, "length": 104857600, "depth": 0, "zero": false, "data":=

>> false}]
>>
>> Yikes! Adding blkdebug says there is no data in the file at all! Actio=
ns
>> like 'qemu-img convert' for copying between images would thus behave
>> differently on a blkdebug image than they would on the real image, whi=
ch
>> somewhat defeats the purpose of blkdebug being a filter node.
>>
>> $ ./qemu-io --image-opts \
>> =C2=A0=C2=A0 driver=3Dblkdebug,image.driver=3Dqcow2,image.file.driver=3D=
file,\
>> image.file.filename=3Dtop.qcow2,align=3D4k
>> qemu-io> r -P1 0 512
>> read 512/512 bytes at offset 0
>> 512 bytes, 1 ops; 0.0002 sec (1.782 MiB/sec and 3649.6350 ops/sec)
>> qemu-io> r -P0 512 512
>> read 512/512 bytes at offset 512
>> 512 bytes, 1 ops; 0.0002 sec (2.114 MiB/sec and 4329.0043 ops/sec)
>> qemu-io>
>>
>> Meanwhile, the data from the backing file is clearly visible when read=
=2E
>> So the bug must lie somewhere in the get_status operation.=C2=A0 Looki=
ng
>> closer, I see this in bdrv_co_block_status_above():
>>
>> 2242=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (p =3D bs; p !=3D b=
ase; p =3D backing_bs(p)) {
>>
>> When qcow2 is directly opened, this iterates to back.qcow2 and sees th=
at
>> there is data in the first cluster, changing the overall status report=
ed
>> to the caller.=C2=A0 But when the qcow2 is hidden by blkdebug, backing=
_bs()
>> states that blkdebug has no backing image, and terminates the loop ear=
ly
>> with JUST the status of the (empty) top file, rather than properly
>> merging in the status from the backing file.
>>
>> I don't know if the bug lies in backing_bs(), or in the blkdebug drive=
r,
>> or in the combination of the two.=C2=A0 Maybe it is as simple as fixin=
g
>> backing_bs() such that on a filter node bs, it defers to
>> backing_bs(bs->file->bs), to make filter nodes behave as if they have
>> the same backing file semantics as what they are wrapping.
>=20
> You mean my "block: Deal with filters" series?
>=20
> (Which replaces the backing_bs(p) with bdrv_filtered_bs(p) -- "filtered=
"
> means both "normal" R/W filter nodes, and "backing" COW filtering.)
>=20
> qemu-img map doesn't work even with that series, though, because
> bdrv_block_status() only gets the status of the topmost node.  And if
> that's a blkdebug node, well, you only get your blkdebug info.  That is=

> pretty much working as intended.
>=20
> The real issue is in qemu-img map, which should just disregard filters.=

> Add a "bs =3D bdrv_skip_rw_filters(bs)" right at the top of the loop in=

> qemu-img.c:get_block_status(), and it works.

By the way, iotest 204 tests this behavior already.  It issues a
qemu-img map right at the end, onto a blkdebug'ed qcow2 file with a
backing image.  The allocation in the backing image is currently missing
from the output, which is wrong.

Max


--2RlB7i0KMa8EqL2hwIm76mPvs26qa3Raf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGuhgACgkQ9AfbAGHV
z0CKDQgAt4+td8TLzOdTvVIy/6G/DW7GB7Ql137cVhEhOWkyz/FvGElyf9EXo3+/
v8aEWdXhjD9FK2hu4JQai/XkbDGzNn0E12cR39gz4YZ1hEmK7SCt2tje0n0fAoG5
5u/Tb5X8EPSXh1VsGyUN5P+2BuM40eq0HiIhnErJCBkn3HhX2E92nJtp+/hPPU00
Wx5OGZPIlmFTsFQ+vcGcrU1uCitP0fUEQxRmLErHZmNSuUkDb57XxpMygnfTVcy1
V+7QDvqgknmd9gfb/tO9wqFAtyuY+83r5mf8iAi2a5FYWW65l/O1eibGBeqfcqAX
uGt5XG6LrkKzZxcyfXRtyPNwsZ+Zfw==
=5psr
-----END PGP SIGNATURE-----

--2RlB7i0KMa8EqL2hwIm76mPvs26qa3Raf--
