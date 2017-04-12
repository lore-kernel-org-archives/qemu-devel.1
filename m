Received: from eggs.gnu.org ([2001:4830:134:3::10]:60481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyQzM-0003I6-Oa
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:43:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cyQzL-0002NA-LO
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 18:43:48 -0400
References: <20170412174920.8744-1-eblake@redhat.com>
	<20170412174920.8744-2-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6805e6dc-52a6-ea41-d095-69c1c6e74b1d@redhat.com>
Date: Wed, 12 Apr 2017 18:43:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170412174920.8744-2-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/12] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>



On 04/12/2017 01:49 PM, Eric Blake wrote:
> We've been documenting the value in bytes since its introduction
> in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.
> 
> Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
> preparation for a rewrite to a list of dirty sectors in the next
> commit 21b5683 in block.c, but the new code mistakenly started
> reporting in sectors.
> 
> Fixes: https://bugzilla.redhat.com/1441460
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> Too late for 2.9, since the regression has been unnoticed for
> nine releases. But worth putting in 2.9.1.
> ---

Since before I started working here :)

I even documented the wrong thing in my two talks on the matter, but I
suppose I never committed it to bitmaps.md, so...

I guess this is technically correct?

http://i3.kym-cdn.com/photos/images/facebook/000/909/991/48c.jpg

>  block/dirty-bitmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 519737c..6d8ce5f 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -345,7 +345,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>      QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
>          BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
>          BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
> -        info->count = bdrv_get_dirty_count(bm);
> +        info->count = bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
>          info->granularity = bdrv_dirty_bitmap_granularity(bm);
>          info->has_name = !!bm->name;
>          info->name = g_strdup(bm->name);
> 

This is strictly more useful than sectors anyway, so ...

Reviewed-by: John Snow <jsnow@redhat.com>
