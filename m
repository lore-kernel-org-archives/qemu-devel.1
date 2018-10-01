Received: from eggs.gnu.org ([2001:4830:134:3::10]:60315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70II-0006T0-6k
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70IH-0004rw-CW
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:39:34 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-4-vsementsov@virtuozzo.com>
	<6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
	<9e53e78b-a0ef-9486-1036-3737ba8cad11@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cb8d01ad-0ef9-a11e-1706-f32d505de1b9@redhat.com>
Date: Mon, 1 Oct 2018 17:39:16 +0200
MIME-Version: 1.0
In-Reply-To: <9e53e78b-a0ef-9486-1036-3737ba8cad11@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kz8lFNfHJoRYB2Fg4kGg0q6nGH4iOAVah"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kz8lFNfHJoRYB2Fg4kGg0q6nGH4iOAVah
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <cb8d01ad-0ef9-a11e-1706-f32d505de1b9@redhat.com>
Subject: Re: [PATCH 3/7] qcow2: split out reading normal clusters from
 qcow2_co_preadv
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <20180807174311.32454-4-vsementsov@virtuozzo.com>
 <6e19aaeb-8acc-beb9-5ece-9ae6101637a9@redhat.com>
 <9e53e78b-a0ef-9486-1036-3737ba8cad11@virtuozzo.com>
In-Reply-To: <9e53e78b-a0ef-9486-1036-3737ba8cad11@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.18 17:14, Vladimir Sementsov-Ogievskiy wrote:
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
> Hmm, no excuses. 1- Will fix, 2 - will fix, 3 - will fix or at least
> test the performance.
>=20
>>> +        qemu_iovec_add(&hd_qiov, crypt_buf, bytes);
>>> +    } else {
>>> +        qemu_iovec_concat(&hd_qiov, qiov, qiov_offset, bytes);
>> qcow2_co_preadv() continues to do this as well.  That's superfluous no=
w.
>=20
> hd_qiov is local here.. or what do you mean?

qcow2_co_preadv() continues to have its own hd_qiov and appends qiov to
it (just like here), but it's unused for normal clusters.  So it doesn't
have to do that for normal clusters.

>>> +    }
>>> +
>>> +    BLKDBG_EVENT(bs->file, BLKDBG_READ_AIO);
>>> +    ret =3D bdrv_co_preadv(bs->file,
>>> +                         file_cluster_offset + offset_in_cluster,
>>> +                         bytes, &hd_qiov, 0);
>>> +    if (ret < 0) {
>>> +        goto out;
>>> +    }
>>> +
>>> +    if (bs->encrypted) {
>>> +        assert(s->crypto);
>>> +        assert((offset & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>>> +        assert((bytes & (BDRV_SECTOR_SIZE - 1)) =3D=3D 0);
>>> +        if (qcrypto_block_decrypt(s->crypto,
>>> +                                  (s->crypt_physical_offset ?
>>> +                                   file_cluster_offset + offset_in_c=
luster :
>>> +                                   offset),
>>> +                                  crypt_buf,
>>> +                                  bytes,
>>> +                                  NULL) < 0) {
>> What's the reason against decrypting this in-place in qiov so we could=

>> save the bounce buffer?  We allow offsets in clusters, so why can't we=

>> just call this function once per involved I/O vector entry?
>=20
> Isn't it unsafe to do decryption in guest buffers?

I don't know.  Why would it be?  Because...

>> Max
>>
>>> +            ret =3D -EIO;
>>> +            goto out;
>>> +        }
>>> +        qemu_iovec_from_buf(qiov, qiov_offset, crypt_buf, bytes);

=2E..we're putting the decrypted content there anyway.

The only issue I see is that the guest may see encrypted content for a
short duration.  Hm.  Maybe we don't want that.  In which case it
probably has to stay as it is.

Max


--kz8lFNfHJoRYB2Fg4kGg0q6nGH4iOAVah
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyP6QACgkQ9AfbAGHV
z0AwCQf/TmLblXxCqMYLE6lKbDOWsXJiEOfYO9rVNJqG8uIy2qQzFHUy+n/3ViNx
Fqml+p3ZzMYKAbzRNqiPPcyLwn//ena08AxyR8Jk1GGxuwk4Qc8DlxmwwMxoI4NV
QdJ4Yje0IXgo+xtvVGj+S0VmnUzkvasa9XTsTI82QxdhYrXZJYYnEVQ3DUoSFSg9
RtTZPOE+6k901XerquAQ6ORKsxAsIwh2ds0ZmF5392PQUfefJKoyff8z7dsPd3xP
NYJ5GUCOQ6IWWS2WZpu8qtRb45adVo9GWIDU3iliYg1NFEH/zZnce8XEvNnOvCj/
9PgGvd3UNDd1HnwEPSvL1/zTAbCjvQ==
=tW+x
-----END PGP SIGNATURE-----

--kz8lFNfHJoRYB2Fg4kGg0q6nGH4iOAVah--
