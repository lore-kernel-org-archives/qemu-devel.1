Received: from eggs.gnu.org ([2001:4830:134:3::10]:37277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMDw-00088X-Fa
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eMMDv-00044S-Ne
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 18:02:00 -0500
References: <20171128071409.21887-1-vsementsov@virtuozzo.com>
	<20171128071409.21887-3-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <d6d5f688-d8dc-63e0-eab2-ef81032ceb92@redhat.com>
Date: Tue, 5 Dec 2017 18:01:53 -0500
MIME-Version: 1.0
In-Reply-To: <20171128071409.21887-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] qcow2: handle reopening
 bitmaps on bdrv_invalidate_cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, crosa@redhat.com, den@openvz.org



On 11/28/2017 02:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> Consider migration with shared storage. Persistent bitmaps are stored
> on bdrv_inactivate. Then, on destination
> process_incoming_migration_bh() calls bdrv_invalidate_cache_all() which
> leads to qcow2_load_autoloading_dirty_bitmaps() which fails if bitmaps
> are already loaded on destination start. In this case we should call
> qcow2_reopen_bitmaps_rw instead.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 1914a940e5..f5f205e1b7 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1450,7 +1450,13 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
>          s->autoclear_features &= QCOW2_AUTOCLEAR_MASK;
>      }
>  
> -    if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
> +    if (bdrv_has_readonly_bitmaps(bs)) {
> +        if (!bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE)) {
> +            bool header_updated = false;
> +            qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_err);
> +            update_header = update_header && !header_updated;
> +        }
> +    } else if (qcow2_load_autoloading_dirty_bitmaps(bs, &local_err)) {
>          update_header = false;
>      }
>      if (local_err != NULL) {
> 

It sounds right to me, but I'm going to ask for eyes from Kevin or Max.

Acked-by: John Snow <jsnow@redhat.com>
