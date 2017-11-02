Received: from eggs.gnu.org ([2001:4830:134:3::10]:41454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMWC-0000xF-2D
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:55:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eAMWA-0004Tk-Pn
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:55:16 -0400
References: <20171023092945.54532-1-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ae493dbe-4678-7430-bfc4-d5eb8eb90a5c@redhat.com>
Date: Thu, 2 Nov 2017 16:55:03 -0400
MIME-Version: 1.0
In-Reply-To: <20171023092945.54532-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block/snapshot: dirty all dirty bitmaps on
 snapshot-switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 10/23/2017 05:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> Snapshot-switch actually changes active state of disk so it should
> reflect on dirty bitmaps. Otherwise next incremental backup using
> these bitmaps will be invalid.
> 

Good call. I knew that snapshots weren't compatible, but this makes it
more obvious and less error-prone to an end user.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  block/snapshot.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/block/snapshot.c b/block/snapshot.c
> index a46564e7b7..1d5ab5f90f 100644
> --- a/block/snapshot.c
> +++ b/block/snapshot.c
> @@ -181,10 +181,24 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
>  {
>      BlockDriver *drv = bs->drv;
>      int ret, open_ret;
> +    int64_t len;
>  
>      if (!drv) {
>          return -ENOMEDIUM;
>      }
> +
> +    len = bdrv_getlength(bs);
> +    if (len < 0) {
> +        return len;
> +    }
> +    /* We should set all bits in all enabled dirty bitmaps, because dirty
> +     * bitmaps reflect active state of disk and snapshot switch operation
> +     * actually dirties active state.
> +     * TODO: It may make sense not to set all bits but analyze block status of
> +     * current state and destination snapshot and do not set bits corresponding
> +     * to both-zero or both-unallocated areas. */
> +    bdrv_set_dirty(bs, 0, len);
> +
>      if (drv->bdrv_snapshot_goto) {
>          return drv->bdrv_snapshot_goto(bs, snapshot_id);
>      }
> 
