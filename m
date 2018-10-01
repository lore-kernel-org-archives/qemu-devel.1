Received: from eggs.gnu.org ([2001:4830:134:3::10]:34701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70TM-0004IY-9F
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:51:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g70TL-0003LM-EH
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 11:51:00 -0400
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
	<20180807174311.32454-6-vsementsov@virtuozzo.com>
	<5c871ce7-2cab-f897-0b06-cbc05b9ffe97@redhat.com>
	<20249828-f5fd-e2d8-6253-e4a0a48800ff@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b79b14c0-914e-609f-81f9-37ec0384ac53@redhat.com>
Date: Mon, 1 Oct 2018 17:50:50 +0200
MIME-Version: 1.0
In-Reply-To: <20249828-f5fd-e2d8-6253-e4a0a48800ff@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UnsmTCVC2EHklRTqTVTPoOTdSBqbKUM2w"
Subject: Re: [Qemu-devel] [PATCH 5/7] qcow2: refactor qcow2_co_pwritev:
 split out qcow2_co_do_pwritev
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
--UnsmTCVC2EHklRTqTVTPoOTdSBqbKUM2w
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <b79b14c0-914e-609f-81f9-37ec0384ac53@redhat.com>
Subject: Re: [PATCH 5/7] qcow2: refactor qcow2_co_pwritev: split out
 qcow2_co_do_pwritev
References: <20180807174311.32454-1-vsementsov@virtuozzo.com>
 <20180807174311.32454-6-vsementsov@virtuozzo.com>
 <5c871ce7-2cab-f897-0b06-cbc05b9ffe97@redhat.com>
 <20249828-f5fd-e2d8-6253-e4a0a48800ff@virtuozzo.com>
In-Reply-To: <20249828-f5fd-e2d8-6253-e4a0a48800ff@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01.10.18 17:43, Vladimir Sementsov-Ogievskiy wrote:
> 28.09.2018 17:23, Max Reitz wrote:
>> On 07.08.18 19:43, Vladimir Sementsov-Ogievskiy wrote:
>>> Split out block which will be reused in async scheme.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/qcow2.c | 138
>>> ++++++++++++++++++++++++++++++++++++----------------------
>>> =C2=A0 1 file changed, 86 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index a0df8d4e50..4d669432d1 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -2210,6 +2210,85 @@ static bool merge_cow(uint64_t offset,
>>> unsigned bytes,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0 }
>>> =C2=A0 +/* qcow2_co_do_pwritev
>>> + * Called without s->lock unlocked
>>> + * hd_qiov - temp qiov for any use. It is initialized so it is empty=

>>> and
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 suppo=
rt adding up to qiov->niov + 2 elements
>>> + * l2meta=C2=A0 - if not NULL, qcow2_co_do_pwritev() will consume it=
=2E
>>> Caller must not
>>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use i=
t somehow after qcow2_co_do_pwritev() call
>>> + */
>>> +static coroutine_fn int qcow2_co_do_pwritev(BlockDriverState *bs,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t
>>> file_cluster_offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t bytes,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMUIOVector *qiov,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t qiov_offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QCowL2Meta *l2meta)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 void *crypt_buf =3D NULL;
>>> +=C2=A0=C2=A0=C2=A0 QEMUIOVector hd_qiov;
>>> +=C2=A0=C2=A0=C2=A0 int offset_in_cluster =3D offset_into_cluster(s, =
offset);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 qemu_iovec_reset(&hd_qiov);
>> This shouldn't be here.
>>
>>> +=C2=A0=C2=A0=C2=A0 qemu_iovec_init(&hd_qiov, qiov->niov);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (bs->encrypted) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(s->crypto);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(bytes <=3D QCOW_MA=
X_CRYPT_CLUSTERS * s->cluster_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypt_buf =3D qemu_try_bl=
ockalign(bs->file->bs, bytes);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_iovec_to_buf(qiov, q=
iov_offset, crypt_buf, bytes);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qcrypto_block_encrypt=
(s->crypto,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (s->crypt_physical=
_offset ?
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file_cluster=
_offset +
>>> offset_in_cluster :
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crypt_buf,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bytes, NULL) < 0) =
{
>> Same question as in the read case: Can't we make do without the bounce=

>> buffer?
>=20
> I think, we should not modify guest buffers..

Hmm, yes, agreed. O:-)

Max


--UnsmTCVC2EHklRTqTVTPoOTdSBqbKUM2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyQloACgkQ9AfbAGHV
z0AZigf+KJttZsS5u7lmlgRAwrgiYt4nzFGyCE1PFor2q18BsAAtj6EwtXCvTL8Q
cjZKnWLGfa219+d4abU4NKKF+RmaP47G2u7ywJDD/zPt1beIPOKCwjbvpNsBi1II
zwsN71hXJB90L3QGRtqujvPhZA/OgwhsDwCm/FwHUyxIeLJr9GmjuVWVSMTThoIl
T6K9iAaU5L4BI8dYzTO7fB+D5ttDZRQeTfC30NH1GOP5Fuuxavj6bfS800nAsae5
3nzdD6SZf9rpOBo//RaHJZyMHWsVSZgrr0g2CiS5p1I+KxCU/Zc84XCj6m+tujye
uFxiUX79WF1FfpicWMMqmb8P9rlhlg==
=VC1b
-----END PGP SIGNATURE-----

--UnsmTCVC2EHklRTqTVTPoOTdSBqbKUM2w--
