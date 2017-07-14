Received: from eggs.gnu.org ([2001:4830:134:3::10]:42480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVzKz-0002No-HG
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dVzKy-0006S7-CW
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:04:49 -0400
References: <20170711160814.20941-1-mreitz@redhat.com>
	<20170711160814.20941-51-mreitz@redhat.com>
	<CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <32291ebe-8c5f-eddf-3cd3-6bcf75deb56d@virtuozzo.com>
Date: Fri, 14 Jul 2017 15:04:35 +0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90jG=vzGX0xKQh5ZkDsnNw6mMQb5QDip7+sAqd8HVTSA@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 50/85] qcow2: add
 .bdrv_remove_persistent_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Max Reitz <mreitz@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

14.07.2017 13:42, Peter Maydell wrote:
> On 11 July 2017 at 17:07, Max Reitz <mreitz@redhat.com> wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Realize .bdrv_remove_persistent_dirty_bitmap interface.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>> Message-id: 20170628120530.31251-29-vsementsov@virtuozzo.com
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> +void qcow2_remove_persistent_dirty_bitmap(BlockDriverState *bs,
>> +                                          const char *name,
>> +                                          Error **errp)
>> +{
>> +    int ret;
>> +    BDRVQcow2State *s = bs->opaque;
>> +    Qcow2Bitmap *bm;
>> +    Qcow2BitmapList *bm_list;
>> +
>> +    if (s->nb_bitmaps == 0) {
>> +        /* Absence of the bitmap is not an error: see explanation above
>> +         * bdrv_remove_persistent_dirty_bitmap() definition. */
>> +        return;
>> +    }
>> +
>> +    bm_list = bitmap_list_load(bs, s->bitmap_directory_offset,
>> +                               s->bitmap_directory_size, errp);
>> +    if (bm_list == NULL) {
>> +        return;
>> +    }
>> +
>> +    bm = find_bitmap_by_name(bm_list, name);
>> +    if (bm == NULL) {
>> +        goto fail;
>> +    }
>> +
>> +    QSIMPLEQ_REMOVE(bm_list, bm, Qcow2Bitmap, entry);
>> +
>> +    ret = update_ext_header_and_dir(bs, bm_list);
>> +    if (ret < 0) {
>> +        error_setg_errno(errp, -ret, "Failed to update bitmap extension");
>> +        goto fail;
>> +    }
>> +
>> +    free_bitmap_clusters(bs, &bm->table);
>> +
>> +fail:
>> +    bitmap_free(bm);
>> +    bitmap_list_free(bm_list);
>> +}
> Coverity points out that this can crash in the error-exit paths,
> because bitmap_free() doesn't handle being passed a NULL pointer.
> (CID 1377700).
>
> Probably the best fix for this is to make bitmap_free() do
> nothing when handed NULL.

Agree, my stupid omission. Can this be fixed in flight? Just squash into 
commit "qcow2: add bitmaps extension"

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8448bec46d..39dfe16fc0 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -487,6 +487,10 @@ static inline void bitmap_directory_to_be(uint8_t 
*dir, size_t size)

  static void bitmap_free(Qcow2Bitmap *bm)
  {
+    if (bm == NULL) {
+        return;
+    }
+
      g_free(bm->name);
      g_free(bm);
  }
//

>
> thanks
> -- PMM


-- 
Best regards,
Vladimir
