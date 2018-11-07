Received: from eggs.gnu.org ([2001:4830:134:3::10]:36755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gKOFa-0005PA-1M
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gKOFY-0003Rz-My
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:52:05 -0500
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-4-vsementsov@virtuozzo.com>
	<6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
	<9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9e7f1442-14ac-1c64-f637-010fe263c2ae@redhat.com>
Date: Wed, 7 Nov 2018 14:51:39 +0100
MIME-Version: 1.0
In-Reply-To: <9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dkd5N8WH8Q0krpGz2GFDZjrU6iAFIuCsa"
Subject: Re: [Qemu-devel] [PATCH 3/7] qcow2: split out reading normal
 clusters from qcow2_co_preadv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dkd5N8WH8Q0krpGz2GFDZjrU6iAFIuCsa
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>
Message-ID: <9e7f1442-14ac-1c64-f637-010fe263c2ae@redhat.com>
Subject: Re: [PATCH 3/7] qcow2: split out reading normal clusters from
 qcow2_co_preadv
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <20180807174311.32454-4-vsementsov@virtuozzo.com>
 <6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
 <9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
In-Reply-To: <9aa2ee7b-2dcb-be00-5501-c616f5c5fda0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.11.18 13:17, Vladimir Sementsov-Ogievskiy wrote:
> 27.09.2018 20:35, Max Reitz wrote:
>> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>> Memory allocation may become less efficient for encrypted case. It's =
a
>>> payment for further asynchronous scheme.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>  block/qcow2.c | 114 ++++++++++++++++++++++++++++++++----------------=
----------
>>>  1 file changed, 64 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 65e3ca00e2..5e7f2ee318 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1808,6 +1808,67 @@ out:
>>>      return ret;
>>>  }
>>> =20
>>> +static coroutine_fn int qcow2_co_preadv_normal(BlockDriverState *bs,=

>>> +                                               uint64_t file_cluster=
_offset,
>>> +                                               uint64_t offset,
>>> +                                               uint64_t bytes,
>>> +                                               QEMUIOVector *qiov,
>>> +                                               uint64_t qiov_offset)=

>>> +{
>>> +    int ret;
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    void *crypt_buf =3D NULL;
>>> +    QEMUIOVector hd_qiov;
>>> +    int offset_in_cluster =3D offset_into_cluster(s, offset);
>>> +
>>> +    if ((file_cluster_offset & 511) !=3D 0) {
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    qemu_iovec_init(&hd_qiov, qiov->niov);
>> So you're not just re-allocating the bounce buffer for every single
>> call, but also this I/O vector.  Hm.
>>
>>> +    if (bs->encrypted) {
>>> +        assert(s->crypto);
>>> +        assert(bytes <=3D QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size)=
;
>>> +
>>> +        crypt_buf =3D qemu_try_blockalign(bs->file->bs, bytes);
>> 1. Why did you remove the comment?
>>
>> 2. The check for whether crypt_buf was successfully allocated is missi=
ng.
>>
>> 3. Do you have any benchmarks for encrypted images?  Having to allocat=
e
>> the bounce buffer for potentially every single cluster sounds rather b=
ad
>> to me.
>=20
> Hmm, about this.
>=20
> Now we have compress threads to do several compress operations in
> parallel. And I plan to do the same thing for decompression, encryption=

> and decryption. So, we'll definitely need several cluster-size buffers
> to do all these operations. How many? The first thought is just as many=

> as maximum number of threads (or twice as many, to have in and out
> buffers for compression). But it's wrong, consider for example
> encryption on write:
>=20
> 1. get free thread for encryption (may be yield if maximum thread numbe=
r
> achieved, waiting until all threads are busy)
> 2. get buffer (per thread)
> 3. thread handles encryption
> a. free thread here?
> 4. write encrypted data to underlying file
> b. free thread here?
>=20
> Of course, we want free thread as soon as possible, in "a." not in "b."=
=2E
> And this mean, that we should free buffer in "a." too, so we should cop=
y
> data to locally allocated buffer, or, better, we just use local buffer
> from the beginning, and thread don't own it's own buffer..
>=20
> So, what are the options we have?
>=20
> 1. the most simple thing: just allocate buffers for each request
> locally, like it is already done for compression.
> pros: simple
> cons: allocate/free every time may influence performance, as you notice=
d
>=20
> 2. keep a pool of such buffers, so when buffer freed, it's just queued
> to the list of free buffers
> pros:
> =C2=A0=C2=A0 reduce number of real alloc/free calls
> =C2=A0=C2=A0 we can limit the pool maximum size
> =C2=A0=C2=A0 we can allocate new buffers on demand, not the whole pool =
at start
> cons:
> =C2=A0=C2=A0 hmm, so, it looks like custom allocator. Is it really need=
ed? Is it
> really faster than just use system allocator and call alloc/free every
> time we need a buffer?
>=20
> 3. should not we use g_slice_alloc instead of inventing it in "2."
>=20
> So, I've decided to do some tests, and here are results (memcpy is for
> 32K, all other things allocates 64K in a loop, list_alloc is a simple
> realization of "2.":
>=20
> nothing: 200000000 it / 0.301361 sec =3D 663655696.202532 it/s
> memcpy: 2000000 it / 1.633015 sec =3D 1224728.554970 it/s
> g_malloc: 200000000 it / 5.346707 sec =3D 37406202.540530 it/s
> g_slice_alloc: 200000000 it / 7.812036 sec =3D 25601520.402792 it/s
> list_alloc: 200000000 it / 5.432771 sec =3D 36813626.268630 it/s
> posix_memalign: 20000000 it / 1.025543 sec =3D 19501864.376084 it/s
> aligned_alloc: 20000000 it / 1.035639 sec =3D 19311752.149739 it/s
>=20
> So, you see that yes, list_alloc is twice as fast as posix_memalign, bu=
t
> on the other hand, simple memcpy is a lot slower (16 times slower) (and=

> I don't say about real disk IO which will be even more slower), so,
> should we care about allocation, what do you thing?
> test is attached.

Agreed.  Thanks for testing.

I am a bit worried about the maximum memory usage still.  With 16
workers, having bounce buffers can mean up to 32 MB of memory usage with
the default cluster size (and 1 GB with 2 MB clusters).  Then again, it
should be easy to limit memory usage even without a custom pool (just
some variable that says how much memory there is left).  Also, it'd be
OK to do that on top.

Max


--dkd5N8WH8Q0krpGz2GFDZjrU6iAFIuCsa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvi7esACgkQ9AfbAGHV
z0DLWggAxJ79GBKWiL/RPRMDJNsJTr/zkR+eAjEUtVr9nSL5TBuHQ4U3hRws33qT
rfMzIKstJ0dw2KBT4sP2QDzmA8PX1GepMq8SooqH3lJDSQFf0bCcLJPkoFf9pCim
vpYQsCoOjWHOXFkEMeyQyYmFaKhFQcji3QM8EIpcnnk2OeXjWGguuKTmNB49zoym
1A04pNGn404hMNIoW73QjGpX1GM6iVfCRjW4HlBLL5zxhpS6XaR0wzjv9q1vHhmp
YALCHzIPqi2PgEfN00hkh713naLt9FlOFHPthtR4Z9Ek/7+i6t94F3pIgwAaaB6x
QIyhT6CFF9w3BJuJFLMnH7Hw9UWNIw==
=2nSy
-----END PGP SIGNATURE-----

--dkd5N8WH8Q0krpGz2GFDZjrU6iAFIuCsa--
