Received: from eggs.gnu.org ([2001:4830:134:3::10]:42863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYx8U-0005fJ-W1
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYx8T-0008F5-HP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:24:43 -0400
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ecd1901-4148-6dc5-667d-d3c13260f534@redhat.com>
Date: Fri, 29 Jun 2018 12:24:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180629151524.138542-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org

On 06/29/2018 10:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> We need to synchronize backup job with reading from fleecing image
> like it was done in block/replication.c.
> 
> Otherwise, the following situation is theoretically possible:
> 

Grammar suggestions:

> 1. client start reading

client starts reading

> 2. client understand, that there is no corresponding cluster in
>     fleecing image
> 3. client is going to read from backing file (i.e. active image)

client sees that no corresponding cluster has been allocated in the 
fleecing image, so the request is forwarded to the backing file

> 4. guest writes to active image
> 5. this write is stopped by backup(sync=none) and cluster is copied to
>     fleecing image
> 6. guest write continues...
> 7. and client reads _new_ (or partly new) date from active image

Interesting race. Can it actually happen, or does our read code already 
serialize writes to the same area while a read is underway?

In short, I see what problem you are claiming exists: the moment the 
client starts reading from the backing file, that portion of the backing 
file must remain unchanged until after the client is done reading.  But 
I don't know enough details of the block layer to know if this is 
actually a problem, or if adding the new filter is just overhead.

> 
> So, this fleecing-filter should be above fleecing image, the whole
> picture of fleecing looks like this:
> 
>      +-------+           +------------+
>      |       |           |            |
>      | guest |           | NBD client +<------+
>      |       |           |            |       |
>      ++-----++           +------------+       |only read
>       |     ^                                 |
>       | IO  |                                 |
>       v     |                           +-----+------+
>      ++-----+---------+                 |            |
>      |                |                 |  internal  |
>      |  active image  +----+            | NBD server |
>      |                |    |            |            |
>      +-+--------------+    |backup      +-+----------+
>        ^                   |sync=none     ^
>        |backing            |              |only read
>        |                   |              |
>      +-+--------------+    |       +------+----------+
>      |                |    |       |                 |
>      | fleecing image +<---+       | fleecing filter |
>      |                |            |                 |
>      +--------+-------+            +-----+-----------+
>               ^                          |
>               |                          |
>               +--------------------------+
>                         file

Can you also show the sequence of QMP commands to set up this structure 
(or maybe you do in 3/3; which I haven't looked at yet).

> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json    |  6 ++--
>   block/fleecing-filter.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++
>   block/Makefile.objs     |  1 +
>   3 files changed, 85 insertions(+), 2 deletions(-)
>   create mode 100644 block/fleecing-filter.c
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 577ce5e999..43872c3d79 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2542,7 +2542,8 @@
>               'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', 'nfs',
>               'null-aio', 'null-co', 'nvme', 'parallels', 'qcow', 'qcow2', 'qed',
>               'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',
> -            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
> +            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs',
> +            'fleecing-filter' ] }

Missing a 'since 3.0' documentation blurb; also, this enum has been kept 
sorted, so your new filter needs to come earlier.

>   
>   ##
>   # @BlockdevOptionsFile:
> @@ -3594,7 +3595,8 @@
>         'vmdk':       'BlockdevOptionsGenericCOWFormat',
>         'vpc':        'BlockdevOptionsGenericFormat',
>         'vvfat':      'BlockdevOptionsVVFAT',
> -      'vxhs':       'BlockdevOptionsVxHS'
> +      'vxhs':       'BlockdevOptionsVxHS',
> +      'fleecing-filter': 'BlockdevOptionsGenericFormat'

Again, this has been kept sorted.

> +static coroutine_fn int fleecing_co_preadv(BlockDriverState *bs,
> +                                           uint64_t offset, uint64_t bytes,
> +                                           QEMUIOVector *qiov, int flags)
> +{
> +    int ret;
> +    BlockJob *job = bs->file->bs->backing->bs->job;
> +    CowRequest req;
> +
> +    backup_wait_for_overlapping_requests(job, offset, bytes);
> +    backup_cow_request_begin(&req, job, offset, bytes);
> +
> +    ret = bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
> +
> +    backup_cow_request_end(&req);
> +
> +    return ret;
> +}

So the idea here is that you force a serializing request to ensure that 
there are no other writes to the area in the meantime.

> +
> +static coroutine_fn int fleecing_co_pwritev(BlockDriverState *bs,
> +                                            uint64_t offset, uint64_t bytes,
> +                                            QEMUIOVector *qiov, int flags)
> +{
> +    return -EINVAL;

and you force this to be a read-only interface. (Does the block layer 
actually require us to provide a pwritev callback, or can we leave it 
NULL instead?)

> +BlockDriver bdrv_fleecing_filter = {
> +    .format_name = "fleecing-filter",
> +    .protocol_name = "fleecing-filter",
> +    .instance_size = 0,
> +
> +    .bdrv_open = fleecing_open,
> +    .bdrv_close = fleecing_close,
> +
> +    .bdrv_getlength = fleecing_getlength,
> +    .bdrv_co_preadv = fleecing_co_preadv,
> +    .bdrv_co_pwritev = fleecing_co_pwritev,
> +
> +    .is_filter = true,
> +    .bdrv_recurse_is_first_non_filter = fleecing_recurse_is_first_non_filter,
> +    .bdrv_child_perm        = bdrv_filter_default_perms,

No .bdrv_co_block_status callback?  That probably hurts querying for 
sparse regions.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
