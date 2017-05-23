Received: from eggs.gnu.org ([2001:4830:134:3::10]:41123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dD5sV-00079R-Pa
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dD5sS-0000dB-GW
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:13:19 -0400
Received: from mail-db5eur01on0132.outbound.protection.outlook.com
	([104.47.2.132]:55744
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dD5sR-0000bn-Nh
	for qemu-devel@nongnu.org; Tue, 23 May 2017 05:13:16 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-2-git-send-email-anton.nefedov@virtuozzo.com>
	<f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <ac9d8539-e713-8c6b-0cf0-ce45c3f270d4@openvz.org>
Date: Tue, 23 May 2017 12:13:09 +0300
MIME-Version: 1.0
In-Reply-To: <f628e214-2faa-0cf2-c5d2-39b0b6505fc2@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v1 01/13] qcow2: alloc space for COW in one
 chunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, mreitz@redhat.com

On 05/22/2017 10:00 PM, Eric Blake wrote:
> On 05/19/2017 04:34 AM, Anton Nefedov wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> Currently each single write operation can result in 3 write operations=

>> if guest offsets are not cluster aligned. One write is performed for t=
he
>> real payload and two for COW-ed areas. Thus the data possibly lays
>> non-contiguously on the host filesystem. This will reduce further
>> sequential read performance significantly.
>>
>> The patch allocates the space in the file with cluster granularity,
>> ensuring
>>   1. better host offset locality
>>   2. less space allocation operations
>>      (which can be expensive on distributed storages)
> s/storages/storage/
>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>  block/qcow2.c | 32 +++++++++++++++++++++++++++++++-
>>  1 file changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index a8d61f0..2e6a0ec 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1575,6 +1575,32 @@ fail:
>>      return ret;
>>  }
>> =20
>> +static void handle_alloc_space(BlockDriverState *bs, QCowL2Meta *l2me=
ta)
>> +{
>> +    BDRVQcow2State *s =3D bs->opaque;
>> +    BlockDriverState *file =3D bs->file->bs;
>> +    QCowL2Meta *m;
>> +    int ret;
>> +
>> +    for (m =3D l2meta; m !=3D NULL; m =3D m->next) {
>> +        uint64_t bytes =3D m->nb_clusters << s->cluster_bits;
>> +
>> +        if (m->cow_start.nb_bytes =3D=3D 0 && m->cow_end.nb_bytes =3D=
=3D 0) {
>> +            continue;
>> +        }
>> +
>> +        /* try to alloc host space in one chunk for better locality *=
/
>> +        ret =3D file->drv->bdrv_co_pwrite_zeroes(file, m->alloc_offse=
t, bytes, 0);
> Are we guaranteed that this is a fast operation?  (That is, it either
> results in a hole or an error, and doesn't waste time tediously writing=

> actual zeroes)
>
This is why we call driver directly. We expect that replacing with actual=
y
zeroes write happens only in generic function.

>> +
>> +        if (ret !=3D 0) {
>> +            continue;
>> +        }
> Supposing we are using a file system that doesn't support holes, then
> ret will not be zero, and we ended up not allocating anything after all=
=2E
>  Is that a problem that we are just blindly continuing the loop as our
> reaction to the error?
>
> /reads further
>
> I guess not - you aren't reacting to any error call, but merely using
> the side effect that an allocation happened for speed when it worked,
> and ignoring failure (you get the old behavior of the write() now
> causing the allocation) when it didn't.
good point

>> +
>> +        file->total_sectors =3D MAX(file->total_sectors,
>> +                                  (m->alloc_offset + bytes) / BDRV_SE=
CTOR_SIZE);
>> +    }
>> +}
>> +
>>  static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64=
_t offset,
>>                                           uint64_t bytes, QEMUIOVector=
 *qiov,
>>                                           int flags)
>> @@ -1656,8 +1682,12 @@ static coroutine_fn int qcow2_co_pwritev(BlockD=
riverState *bs, uint64_t offset,
>>          if (ret < 0) {
>>              goto fail;
>>          }
>> -
>>          qemu_co_mutex_unlock(&s->lock);
>> +
>> +        if (bs->file->bs->drv->bdrv_co_pwrite_zeroes !=3D NULL) {
>> +            handle_alloc_space(bs, l2meta);
>> +        }
> Is it really a good idea to be modifying the underlying protocol image
> outside of the mutex?
yes! This is by design, not accidental. The area is protected by the
meta and
thus writes to not allocated areas will pass.

> At any rate, it looks like your patch is doing a best-effort write
> zeroes as an attempt to trigger consecutive allocation of the entire
> cluster in the underlying protocol right after a cluster has been
> allocated at the qcow2 format layer.  Which means there are more
> syscalls now than there were previously, but now when we do three
> write() calls at offsets B, A, C, those three calls are into file space=

> that was allocated earlier by the write zeroes, rather than fresh calls=

> into unallocated space that is likely to trigger up to three disjoint
> allocations.
>
> As a discussion point, wouldn't we achieve the same effect of less
> fragmentation if we instead collect our data into a bounce buffer, and
> only then do a single write() (or more likely, a writev() where the iov=

> is set up to reconstruct a single buffer on the syscall, but where the
> source data is still at different offsets)?  We'd be avoiding the extra=

> syscalls of pre-allocating the cluster, and while our write() call is
> still causing allocations, at least it is now one cluster-aligned
> write() rather than three sub-cluster out-of-order write()s.
>
If the cluster will become bigger, the difference will be much more
significant.
Actually we have done that already in the original patchset, but those
changes are a bit controversal in terms of performance. They works much
better on SSD and worse on HDD.

May be we have done something wrong, but here only simple non-questionabl=
e
things in terms of performance are included.

Den
