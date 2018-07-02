Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZxJN-0007VQ-FV
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fZxJM-00015f-2X
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:48:05 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<8ecd1901-4148-6dc5-667d-d3c13260f534@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9ab8b033-ca74-ac13-d64e-bb79932c0c54@virtuozzo.com>
Date: Mon, 2 Jul 2018 14:47:49 +0300
MIME-Version: 1.0
In-Reply-To: <8ecd1901-4148-6dc5-667d-d3c13260f534@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org

29.06.2018 20:24, Eric Blake wrote:
> On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>> We need to synchronize backup job with reading from fleecing image
>> like it was done in block/replication.c.
>>
>> Otherwise, the following situation is theoretically possible:
>>
>
> Grammar suggestions:
>
>> 1. client start reading
>
> client starts reading
>
>> 2. client understand, that there is no corresponding cluster in
>> =C2=A0=C2=A0=C2=A0 fleecing image
>> 3. client is going to read from backing file (i.e. active image)
>
> client sees that no corresponding cluster has been allocated in the=20
> fleecing image, so the request is forwarded to the backing file
>
>> 4. guest writes to active image
>> 5. this write is stopped by backup(sync=3Dnone) and cluster is copied to
>> =C2=A0=C2=A0=C2=A0 fleecing image
>> 6. guest write continues...
>> 7. and client reads _new_ (or partly new) date from active image
>
> Interesting race. Can it actually happen, or does our read code=20
> already serialize writes to the same area while a read is underway?
>
> In short, I see what problem you are claiming exists: the moment the=20
> client starts reading from the backing file, that portion of the=20
> backing file must remain unchanged until after the client is done=20
> reading.=C2=A0 But I don't know enough details of the block layer to know=
=20
> if this is actually a problem, or if adding the new filter is just=20
> overhead.


Looking at the code, more real example (but I still have no reproducer):

1. client starts reading and take qcow2 mutex in qcow2_co_preadv, and=20
goes up to l2 table loading (assume cache miss)
2) guest write =3D> backup COW =3D> qcow2 write =3D> try to take qcow2 mute=
x=20
=3D> waiting
3. l2 table loaded, we see that cluster is UNALLOCATED, go to "case=20
QCOW2_CLUSTER_UNALLOCATED" and unlock mutex before=20
bdrv_co_preadv(bs->backing, ...)
4) aha, mutex unlocked, backup COW continues, and we finally finish=20
guest write and change cluster in our active disk
5. actually, do bdrv_co_preadv(bs->backing, ...) and read _new updated_=20
data.



>
>>
>> So, this fleecing-filter should be above fleecing image, the whole
>> picture of fleecing looks like this:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 +-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +------------+
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 | guest |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | NBD client +<------+
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 ++-----++=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 +------------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |only read
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | IO=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----=
-+------+
>> =C2=A0=C2=A0=C2=A0=C2=A0 ++-----+---------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 internal=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 active image=C2=A0 +----+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | NBD server |
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 +-+--------------+=C2=A0=C2=A0=C2=A0 |backup=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-+----------+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |sync=3Dnone=C2=A0=C2=A0=C2=A0=C2=A0 ^
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |backing=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |only read
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 +-+--------------+=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------+----------+
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 | fleecing image +<---+=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | fleecing filter |
>> =C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0 +--------+-------+=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-----+-----------+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +--------------------------+
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file
>
> Can you also show the sequence of QMP commands to set up this=20
> structure (or maybe you do in 3/3; which I haven't looked at yet).
>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
>> =C2=A0 block/fleecing-filter.c | 80=20
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> =C2=A0 3 files changed, 85 insertions(+), 2 deletions(-)
>> =C2=A0 create mode 100644 block/fleecing-filter.c
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 577ce5e999..43872c3d79 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2542,7 +2542,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd',=20
>> 'nfs',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'null-aio', 'null-co', 'nvme', 'parallels', 'qcow',=20
>> 'qcow2', 'qed',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'thr=
ottle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat',=20
>> 'vxhs' ] }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'thr=
ottle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'fle=
ecing-filter' ] }
>
> Missing a 'since 3.0' documentation blurb; also, this enum has been=20
> kept sorted, so your new filter needs to come earlier.
>
>> =C2=A0 =C2=A0 ##
>> =C2=A0 # @BlockdevOptionsFile:
>> @@ -3594,7 +3595,8 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vmdk': 'BlockdevOptionsGener=
icCOWFormat',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vpc':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 'BlockdevOptionsGenericFormat',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vvfat':=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 'BlockdevOptionsVVFAT',
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vxhs':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'BlockdevOptionsVxHS'
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'vxhs':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 'BlockdevOptionsVxHS',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'fleecing-filter': 'BlockdevOptionsGener=
icFormat'
>
> Again, this has been kept sorted.
>
>> +static coroutine_fn int fleecing_co_preadv(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset, uint64_t=20
>> bytes,
>> + QEMUIOVector *qiov, int flags)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 BlockJob *job =3D bs->file->bs->backing->bs->job;
>> +=C2=A0=C2=A0=C2=A0 CowRequest req;
>> +
>> +=C2=A0=C2=A0=C2=A0 backup_wait_for_overlapping_requests(job, offset, by=
tes);
>> +=C2=A0=C2=A0=C2=A0 backup_cow_request_begin(&req, job, offset, bytes);
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D bdrv_co_preadv(bs->file, offset, bytes, qiov=
, flags);
>> +
>> +=C2=A0=C2=A0=C2=A0 backup_cow_request_end(&req);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>
> So the idea here is that you force a serializing request to ensure=20
> that there are no other writes to the area in the meantime.
>
>> +
>> +static coroutine_fn int fleecing_co_pwritev(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t offset,=20
>> uint64_t bytes,
>> + QEMUIOVector *qiov, int flags)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return -EINVAL;
>
> and you force this to be a read-only interface. (Does the block layer=20
> actually require us to provide a pwritev callback, or can we leave it=20
> NULL instead?)
>
>> +BlockDriver bdrv_fleecing_filter =3D {
>> +=C2=A0=C2=A0=C2=A0 .format_name =3D "fleecing-filter",
>> +=C2=A0=C2=A0=C2=A0 .protocol_name =3D "fleecing-filter",
>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D 0,
>> +
>> +=C2=A0=C2=A0=C2=A0 .bdrv_open =3D fleecing_open,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_close =3D fleecing_close,
>> +
>> +=C2=A0=C2=A0=C2=A0 .bdrv_getlength =3D fleecing_getlength,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_preadv =3D fleecing_co_preadv,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_co_pwritev =3D fleecing_co_pwritev,
>> +
>> +=C2=A0=C2=A0=C2=A0 .is_filter =3D true,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_recurse_is_first_non_filter =3D=20
>> fleecing_recurse_is_first_non_filter,
>> +=C2=A0=C2=A0=C2=A0 .bdrv_child_perm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =3D bdrv_filter_default_perms,
>
> No .bdrv_co_block_status callback?=C2=A0 That probably hurts querying for=
=20
> sparse regions.
>

hm, worth add.. and it possibly needs synchronization with backup too.

--=20
Best regards,
Vladimir
