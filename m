Received: from eggs.gnu.org ([2001:4830:134:3::10]:41546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJiOq-0005S5-BV
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:06:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJiOp-0007M1-8R
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:06:20 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-3-eblake@redhat.com>
	<8ada11cb-5455-20ab-4a23-03f05f5c83c1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b3a8a5d-5835-859e-339c-87234622399f@redhat.com>
Date: Tue, 28 Nov 2017 10:05:55 -0600
MIME-Version: 1.0
In-Reply-To: <8ada11cb-5455-20ab-4a23-03f05f5c83c1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/20] block: Switch passthrough drivers
 to .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jsnow@redhat.com

On 11/28/2017 02:19 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:58, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the generic helpers, and all passthrough clie=
nts
>> (blkdebug, commit, mirror, throttle) accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>

>> BlockDriverState **file)
>> +int coroutine_fn bdrv_co_block_status_from_backing(BlockDriverState *=
bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 bool want_zero,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int64_t offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int64_t bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int64_t *pnum,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 int64_t *map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BlockDriverState=20
>> **file)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(bs->backing && bs->backing->bs);
>> -=C2=A0=C2=A0=C2=A0 *pnum =3D nb_sectors;
>> +=C2=A0=C2=A0=C2=A0 *pnum =3D bytes;
>> +=C2=A0=C2=A0=C2=A0 *map =3D offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *file =3D bs->backing->bs;
>> -=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (sector_=
num << BDRV_SECTOR_BITS);
>> +=C2=A0=C2=A0=C2=A0 return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID;
>> =C2=A0 }
>=20
> hmm. not related question, but can you please explain, why we use such=20
> stubs
> instead of really call bdrv_co_block_status on bs->file->bs or=20
> bs->backing->bs ?
>=20

Returning BDRV_BLOCK_RAW is what tells io.c to call=20
bdrv_co_block_status() on whatever got assigned into *file.  The two=20
stubs make it so there are fewer conditionals in io.c; perhaps it could=20
be reworked to avoid the stubs and have io.c have all the smarts when=20
.bdrv_co_block_status is NULL, but as you say, that would be a separate=20
patch (although it was Manos' work earlier this year that even created=20
the common helper stubs rather than duplicating code in each callback in=20
the first place).


>> +static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs=
,

>> +=C2=A0=C2=A0=C2=A0 assert(QEMU_IS_ALIGNED(offset | bytes, bs->bl.requ=
est_alignment));
>=20
> looks like this is obviously guaranteed by block layer, so no needs for=
=20
> special
> function. and we can use
>=20
> .bdrv_co_block_status=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D bdrv_co_b=
lock_status_from_backing
>=20
> like for other drivers.
>=20

We could, but we don't want to.  The point of the blkdebug driver is to=20
explicitly test that certain preconditions are being satisfied, so that=20
even if the block layer in io.c changes, our iotests make sure that=20
drivers are provided with certain guarantees.  In other words, the=20
assert() added here is added value that we cannot stick in the common=20
helper, but something that we want to keep associated with the blkdebug=20
driver.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
