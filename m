Received: from eggs.gnu.org ([209.51.188.92]:56483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqkPM-00025d-Sx
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gqkPM-000472-4p
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 14:59:56 -0500
References: <20190204160928.11209-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <509c2192-a078-78a6-70db-278f500853cc@redhat.com>
Date: Mon, 4 Feb 2019 14:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <20190204160928.11209-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] dirty-bitmap: Expose persistent flag to
 'query-block'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, andrey.shinkevich@virtuozzo.com, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>



On 2/4/19 11:09 AM, Eric Blake wrote:
> Since qemu currently doesn't flush persistent bitmaps to disk until
> shutdown (which might be MUCH later), it's useful if 'query-block'
> at least shows WHICH bitmaps will (eventually) make it to persistent
> storage.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 5 ++++-
>  block/dirty-bitmap.c | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index dae5c7b4d83..2e0bd3c245a 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -450,11 +450,14 @@
>  #
>  # @status: current status of the dirty bitmap (since 2.4)
>  #
> +# @persistent: true if the bitmap will eventually be flushed to persistent
> +#              storage (since 4.0)
> +#
>  # Since: 1.3
>  ##
>  { 'struct': 'BlockDirtyInfo',
>    'data': {'*name': 'str', 'count': 'int', 'granularity': 'uint32',
> -           'status': 'DirtyBitmapStatus'} }
> +           'status': 'DirtyBitmapStatus', 'persistent': 'bool' } }
> 
>  ##
>  # @Qcow2BitmapInfoFlags:
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index 00ea36f5545..e46f72b346c 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -440,6 +440,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
>          info->has_name = !!bm->name;
>          info->name = g_strdup(bm->name);
>          info->status = bdrv_dirty_bitmap_status(bm);
> +        info->persistent = bm->persistent;
>          entry->value = info;
>          *plist = entry;
>          plist = &entry->next;
> 

Oh, this needs a change to 236, too.

--js
