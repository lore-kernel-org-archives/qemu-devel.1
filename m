Received: from eggs.gnu.org ([208.118.235.92]:57148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKo2o-00064V-GM
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:21:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKo23-00029d-7j
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:20:06 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-12-eblake@redhat.com>
	<25e48537-efc6-714d-3c44-7a299e1959eb@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff81219e-0ee7-e441-fe24-4a93125d2d80@redhat.com>
Date: Thu, 30 Nov 2017 16:38:05 -0600
MIME-Version: 1.0
In-Reply-To: <25e48537-efc6-714d-3c44-7a299e1959eb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/20] qcow2: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/30/2017 03:51 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:59, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the qcow2 driver accordingly.
>>
>> For now, we are ignoring the 'want_zero' hint.=C2=A0 However, it shoul=
d
>> be relatively straightforward to honor the hint as a way to return
>> larger *pnum values when we have consecutive clusters with the same
>> data/zero status but which differ only in having non-consecutive
>> mappings.
>=20
> useful thing (for example, to get several compressed clusters in one ch=
unk,
> but do not include following zero clusters). but should not the hint be=
=20
> called want_mapping for it?
> or may be we will move to "int hint_flags", which will include status f=
lags
> we a interested in?

Right now, there are only two public interfaces: bdrv_is_allocated=20
(want_zero is false), and bdrv_block_status (want_zero is true).  You=20
may have a point that there could be further optimizations possible if=20
the caller has more control over what flags it is interested in, but=20
that should be a patch series for a later day; I'm already cramming=20
enough into this series, and it's already stretched out (first patches=20
went into 2.10), so I want it done.

>=20
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

>> -static int64_t coroutine_fn=20
>> qcow2_co_get_block_status(BlockDriverState *bs,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t sector_num, int nb=
_sectors, int *pnum,=20
>> BlockDriverState **file)
>> +static int coroutine_fn qcow2_co_block_status(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool want_zero,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset, int64=
_t=20
>> count,
>=20
> 'count' is used instead of 'bytes' because of qcow2_get_cluster_offset=20
> which wants int*..

Yes,...

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t *pnum, int64_=
t=20
>> *map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState **fi=
le)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t cluster_offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int index_in_cluster, ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int bytes;

...because of that.

>> -=C2=A0=C2=A0=C2=A0 int64_t status =3D 0;
>> +=C2=A0=C2=A0=C2=A0 int status =3D 0;
>>
>> -=C2=A0=C2=A0=C2=A0 bytes =3D MIN(INT_MAX, nb_sectors * BDRV_SECTOR_SI=
ZE);
>> +=C2=A0=C2=A0=C2=A0 bytes =3D MIN(INT_MAX, count);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_co_mutex_lock(&s->lock);
>> -=C2=A0=C2=A0=C2=A0 ret =3D qcow2_get_cluster_offset(bs, sector_num <<=
=20
>> BDRV_SECTOR_BITS, &bytes,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &cluster_off=
set);
>> +=C2=A0=C2=A0=C2=A0 ret =3D qcow2_get_cluster_offset(bs, offset, &byte=
s, &cluster_offset);

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
