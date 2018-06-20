Received: from eggs.gnu.org ([2001:4830:134:3::10]:50039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVcoJ-000315-Sd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVcoI-0004j4-Ts
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:06:07 -0400
References: <20180613020613.1343-1-jsnow@redhat.com>
	<20180613020613.1343-5-jsnow@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <877c91e0-eab5-754d-6a46-8fa5ba970481@virtuozzo.com>
Date: Wed, 20 Jun 2018 16:05:52 +0300
MIME-Version: 1.0
In-Reply-To: <20180613020613.1343-5-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 04/10] qcow2/bitmap: cache loaded bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

13.06.2018 05:06, John Snow wrote:
> For bitmaps that we succeeded in loading, we can cache a reference
> to that object. This will let us iterate over the more convenient
> form of in-memory bitmaps for qemu-img bitmap manipulation tools.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   block/qcow2-bitmap.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 5ae9b17928..d94b6bd5cf 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -981,6 +981,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>               if (bitmap == NULL) {
>                   goto fail;
>               }
> +            bm->dirty_bitmap = bitmap;
>   
>               if (!(bm->flags & BME_FLAG_AUTO)) {
>                   bdrv_disable_dirty_bitmap(bitmap);
> @@ -1382,6 +1383,7 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error **errp)
>               bm->name = g_strdup(name);
>               QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
>           } else {
> +            assert(bitmap == bm->dirty_bitmap);
>               if (!(bm->flags & BME_FLAG_IN_USE)) {
>                   error_setg(errp, "Bitmap '%s' already exists in the image",
>                              name);

and now it is already used in 02, so it should be reordered or merged to it

-- 
Best regards,
Vladimir
