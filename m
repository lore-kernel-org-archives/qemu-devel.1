Received: from eggs.gnu.org ([209.51.188.92]:35383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9hX-0007Rm-DI
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hL9hV-0008KN-MG
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:04:23 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
	<20190402153730.54145-8-vsementsov@virtuozzo.com>
	<44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Message-ID: <29689dc3-9d7a-ec86-9725-a053b950c7e6@redhat.com>
Date: Mon, 29 Apr 2019 19:04:11 +0200
MIME-Version: 1.0
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7"
Subject: Re: [Qemu-devel] [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, den@openvz.org,
 berrange@redhat.com
Message-ID: <29689dc3-9d7a-ec86-9725-a053b950c7e6@redhat.com>
Subject: Re: [PATCH v5 07/10] qcow2: qcow2_co_preadv: improve locking
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
 <20190402153730.54145-8-vsementsov@virtuozzo.com>
 <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
In-Reply-To: <44be7ef0-9a4f-4c44-44eb-81f341ca7ea6@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.19 18:37, Max Reitz wrote:
> On 02.04.19 17:37, Vladimir Sementsov-Ogievskiy wrote:
>> Background: decryption will be done in threads, to take benefit of it,=

>> we should move it out of the lock first.
>=20
> ...which is safe after your commit c972fa123c73501b4, I presume.
>=20
> (At first glance, the patched looked a bit weird to me because it
> doesn't give a reason why dropping the lock around
> qcrypto_block_decrypt() would be OK.)

On second thought, I guess the actual reason it's safe is because the
crypto code never yields.

Max

>> But let's go further: it turns out, that for locking around switch
>> cases we have only two variants: when we just do memset(0) not
>> releasing the lock (it is useless) and when we actually can handle the=

>> whole case out of the lock. So, refactor the whole thing to reduce
>> locked code region and make it clean.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Reviewed-by: Alberto Garcia <berto@igalia.com>
>> ---
>>  block/qcow2.c | 46 ++++++++++++++++++++++------------------------
>>  1 file changed, 22 insertions(+), 24 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 46e8e39da5..fcf92a7eb6 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1983,6 +1983,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDri=
verState *bs, uint64_t offset,
>> =20
>>          ret =3D qcow2_get_cluster_offset(bs, offset, &cur_bytes, &clu=
ster_offset);
>=20
> Isn't this the only function in the loop that actually needs the lock?
> Wouldn't it make more sense to just take it around this call?
>=20
> Max
>=20
>>          if (ret < 0) {
>> +            qemu_co_mutex_unlock(&s->lock);
>>              goto fail;
>>          }
>> =20
>=20



--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzHLosACgkQ9AfbAGHV
z0Dr5wgAk7auvTJkpU3dpCuYklzekHeXLZHN/bZNLC16FBcaBY/nNbHjSc7rKHvK
KtC3x8Ri3mCtCVj19IbxDUu4NaZWP4I3Ef8fYmBlZCw2OjXBpIQHzSrW66hdeMaZ
9JnVadY0NWA+5HJbMkouEv0KgU9yx8dSThWNFt9pYWTPmVq5VXzkAvuKHT7a39Yh
dbBQEPWc0LMNIsrMKCicHjAjQJlPxmLOfYRY1+hbKBJzXnJWoZdjdnsyzJQhzKOx
EFEphs6sC4FDEzeRvdKKUmS2cv3jfm9CL3PBceBk1RQ2gVwPIUlAIG/S9lUvPj7k
EA7TW/KC/PurvXPnzZTkNx7eA1tUXA==
=TYVn
-----END PGP SIGNATURE-----

--2lRt9pl9LR2LgDM6l2dG3dj05gntWbxd7--
