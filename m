Received: from eggs.gnu.org ([209.51.188.92]:56910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzo5g-0006yx-Lh
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:45:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzo5f-0000PR-8w
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:45:04 -0500
References: <20190301191545.8728-1-jsnow@redhat.com>
	<20190301191545.8728-7-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d204716-dc54-70ac-8b67-266ce8f44e0e@redhat.com>
Date: Fri, 1 Mar 2019 13:44:36 -0600
MIME-Version: 1.0
In-Reply-To: <20190301191545.8728-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

On 3/1/19 1:15 PM, John Snow wrote:
> We didn't do any state checking on source bitmaps at all,
> so this adds inconsistent and busy checks. readonly is
> allowed, so you can still copy a readonly bitmap to a new
> destination to use it for operations like drive-backup.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c | 3 +++
>  1 file changed, 3 insertions(+)
> 

I understand forbidding inconsistent sources (because if the source is
potentially missing bits, then the merge destination will also be
missing bits and thus be inconsistent), but why forbid busy?  If I've
associated a bitmap with an NBD server (making it busy), it is still
readable, and so I should still be able to merge its bits into another copy.

> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 769668ccdc..8403c9981d 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -825,6 +825,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
>          goto out;
>      }
>  
> +    if (bdrv_dirty_bitmap_check(src, BDRV_BITMAP_ALLOW_RO, errp)) {

Thus, I think this should be BDRV_BITMAP_INCONSISTENT.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
