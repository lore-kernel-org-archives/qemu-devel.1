Received: from eggs.gnu.org ([2001:4830:134:3::10]:45419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH6mz-0002OG-Ej
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cH6my-0004Zg-7s
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 05:27:57 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-22-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <07824e01-e163-c1eb-101b-5e7e27d701d9@redhat.com>
Date: Wed, 14 Dec 2016 11:27:44 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-22-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 21/21] qcow2-bitmap: refcounts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

On 2016-11-22 at 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Calculate refcounts for qcow2 bitmaps. It is needed for qcow2's qemu-img
> check implementation.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c   | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2-refcount.c |  6 +++++
>  block/qcow2.h          |  3 +++
>  3 files changed, 82 insertions(+)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 55b1112..0e0ddf3 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -1155,3 +1155,76 @@ common_errp:
>                 name, bdrv_get_device_or_node_name(bs), reason);
>      return false;
>  }
> +
> +int qcow2_check_bitmaps_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
> +                                  void **refcount_table,
> +                                  int64_t *refcount_table_size)
> +{

[...]

> +        for (i = 0; i < bm->table_size; ++i) {
> +            uint64_t entry = bitmap_table[i];
> +            uint64_t offset = entry & BME_TABLE_ENTRY_OFFSET_MASK;
> +
> +            if (check_table_entry(entry, s->cluster_size) < 0) {
> +                res->corruptions++;
> +                ret = -EINVAL;
> +                continue;

First an optional suggestion: You could just assign 
check_table_entry()'s return value directly to ret, then you wouldn't 
have to set it manually.

Second, why are you setting ret at all? If any of the next iterations is 
successful, it will get overwritten and be set to 0 again.

Max

> +            }
> +
> +            if (offset == 0) {
> +                continue;
> +            }
> +
> +            ret = qcow2_inc_refcounts_imrt(bs, res,
> +                                           refcount_table, refcount_table_size,
> +                                           offset, s->cluster_size);
> +            if (ret < 0) {
> +                g_free(bitmap_table);
> +                goto out;
> +            }
> +        }
> +
> +        g_free(bitmap_table);
> +    }
> +
> +out:
> +    bitmap_list_free(bm_list);
> +
> +    return ret;
> +}
