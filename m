Received: from eggs.gnu.org ([209.51.188.92]:34700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0MH-000061-00
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi0MG-0007rv-0G
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 12:12:37 -0500
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
	<acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
	<2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
	<5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
	<589853f3-847e-155b-7cdf-c4061522c8bc@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3e7a8e8c-ae95-2845-f1a9-7c3b9f868fdb@redhat.com>
Date: Fri, 11 Jan 2019 11:12:04 -0600
MIME-Version: 1.0
In-Reply-To: <589853f3-847e-155b-7cdf-c4061522c8bc@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7tSUr4HnibgQLL4K8Nv38RnaIT0TSwHYC"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net" <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7tSUr4HnibgQLL4K8Nv38RnaIT0TSwHYC
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "armbru@redhat.com" <armbru@redhat.com>, "fam@euphon.net"
 <fam@euphon.net>, "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Lunev <den@virtuozzo.com>
Message-ID: <3e7a8e8c-ae95-2845-f1a9-7c3b9f868fdb@redhat.com>
Subject: Re: [PATCH] block: don't probe zeroes in bs->file by default on
 block_status
References: <20190110132048.49451-1-vsementsov@virtuozzo.com>
 <acf4d082-dabd-55ec-4435-da3e93b6c4ab@redhat.com>
 <2ad46997-01aa-7a7a-ed53-4463a60ca564@virtuozzo.com>
 <5854b5b8-4682-2188-0c00-55c8d413be5e@redhat.com>
 <589853f3-847e-155b-7cdf-c4061522c8bc@virtuozzo.com>
In-Reply-To: <589853f3-847e-155b-7cdf-c4061522c8bc@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/11/19 10:22 AM, Vladimir Sementsov-Ogievskiy wrote:

>> Even a dumb most-recent use cache will speed this up: both the second
>> and third queries above can be avoided because we know that both 0x400=
00
>> and 0x30000 the second query at 0x40000 can be skipped (0x40000 is
>> between our most recent lseek at 0x20000 and hole at 0x10000)
>=20
> Is it correct just use results from previous iterations? In mirror sour=
ce
> is active and may change.

If you keep a cache, you have to keep the cache up-to-date. Any writes
to an area that is covered by the known-hole cache have to flush the
cache, so that the next block status no longer sees a known-hole and
ends up doing another lseek.  Or, if the cache has enough state to track
unknown/known-hole/known-data, then writes update the cache to be
known-data, and future block status can skip the lseek by using the
results of the cache.

>=20
>>
>> Make the cache slightly larger, or use a bitmap with 2 bits per cluste=
r
>> (tracking unknown, known-data, known-hole), with proper flushing of th=
e
>> cache as we write to the image, or whatever, and we should automatical=
ly
>> get some performance improvements by using fewer lseek() anywhere that=

>> we remember what previous lseek() already told us, with no knobs neede=
d.
>>
>=20
> So the cache should consider all writes and discards. And it is obvious=
ly
> more difficult to implement it, than just don't call this lseek. And I
> don't understand, why cache + lseek is better for the case when we don'=
t
> need nor the lseek neither the cache. Is this all to not add an option?=

> Also Kevin objects to caching lseek in parallel sub-thread.

Keven objected to caching anything if the image has multiple writers,
where an outside process could change the file allocation in between our
reads. But multiple writers is rare - in fact, our image locking for
qcow2 formats tries to prevent multiple writers.  Having multiple
threads within one process writing is fine, as long as they properly
coordinate writes to the lseek cache so that readers never see a stale
claim of a hole - although a stale claim of data is safe.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--7tSUr4HnibgQLL4K8Nv38RnaIT0TSwHYC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw4zmQACgkQp6FrSiUn
Q2pqQwgAoREL1bqq/BNNLJQl1YV42xBp4FBjDaH2NKBw/FDWC3rsY5wigsbEq3Bs
/zMIxCe2Ah7bXJ+bI8Kx8XQJ9IRR5DEdfuuC4zADkcgKwVUvOO+irWW0a/7jiNEq
RlYfU92DJIFofHB4o73HzoOosSNWW+ofprvSTrCvYZbs8Nkg449p/9NQEWA9kNag
6byd5DFq8iellMyxW+b7NKAkdL5qhSzcna1HB4JpZt5rV/UFUjPzwtLa8Cq6UWDD
M1IcEmbzsF87EgSwMXTsCGOhMZQf2r+wwICgWi6Vb8R48GeZjmuQsEkiPXTAPOsv
RSRHLLvdvJnYwG8mk9kj0e/4m+u1Kw==
=FhM+
-----END PGP SIGNATURE-----

--7tSUr4HnibgQLL4K8Nv38RnaIT0TSwHYC--
