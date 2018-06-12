Received: from eggs.gnu.org ([2001:4830:134:3::10]:58180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSoFC-000518-UC
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:42:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fSoFB-00038D-FL
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 14:42:14 -0400
References: <1525506577-1946-1-git-send-email-ivanren@tencent.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <04ee2a50-c79d-fe1d-4c08-52ba9ec7fb21@redhat.com>
Date: Tue, 12 Jun 2018 14:42:05 -0400
MIME-Version: 1.0
In-Reply-To: <1525506577-1946-1-git-send-email-ivanren@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: return allocated
 size for block device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>



On 05/05/2018 03:49 AM, Ivan Ren wrote:
> qemu-img info with a block device which has a qcow2 format always
> return 0 for disk size, and this can not reflect the qcow2 size
> and the used space of the block device. This patch return the
> allocated size of qcow2 as the disk size.
> 

This has hit over a month old; I only skimmed the comments on V1 from
Max and Eric. Is this something we still want?

--js

> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>  block/qcow2.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> This version differs from the previous:
> (1).Accumulate all non-0 refcount cluster as the allocated size instead the
> highest offset.
> (2).Simplify the implementation by just check the refcount info.
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index ef68772..e64469a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -4493,6 +4493,59 @@ static QemuOptsList qcow2_create_opts = {
>      }
>  };
>  
> +/* Get allocated space of qcow2, aligned to cluster_size */
> +static int64_t qcow2_get_allocated_size(BlockDriverState *bs)
> +{
> +    int64_t allocated_cluster_count = 0;
> +    uint64_t refcount;
> +    int64_t i, j, begin_index, end_index;
> +
> +    BDRVQcow2State *s = bs->opaque;
> +
> +    /* Traverse refcount table */
> +    for (i = 0; i < s->refcount_table_size; i++) {
> +        if (s->refcount_table[i] & REFT_OFFSET_MASK) {
> +            begin_index = i * s->refcount_block_size;
> +            end_index = begin_index + s->refcount_block_size;
> +            for (j = begin_index; j < end_index; j++) {
> +                if (qcow2_get_refcount(bs, j, &refcount) < 0) {
> +                    continue;
> +                }
> +                if (refcount > 0) {
> +                    allocated_cluster_count++;
> +                }
> +            }
> +        }
> +
> +    }
> +
> +    return allocated_cluster_count * s->cluster_size;
> +}
> +
> +static int64_t qcow2_get_allocated_file_size(BlockDriverState *bs)
> +{
> +    int64_t ret = 0;
> +
> +    /* Get through bs->file first */
> +    if (bs->file) {
> +        ret = bdrv_get_allocated_file_size(bs->file->bs);
> +    }
> +
> +    /*
> +     * If ret < 0, some error may happen to the underlying media, return the
> +     * error directly.
> +     * If ret == 0, means length get from bs->file is 0, which is impossible
> +     * for a normal file because of the qcow2 header. In this case, the
> +     * underlying media may be a block device or anything else that can't
> +     * return a suitable size. So we get the allocated size of qcow2 instead.
> +     */
> +    if (!ret) {
> +        ret = qcow2_get_allocated_size(bs);
> +    }
> +
> +    return ret;
> +}
> +
>  BlockDriver bdrv_qcow2 = {
>      .format_name        = "qcow2",
>      .instance_size      = sizeof(BDRVQcow2State),
> @@ -4516,6 +4569,7 @@ BlockDriver bdrv_qcow2 = {
>      .bdrv_co_pwrite_zeroes  = qcow2_co_pwrite_zeroes,
>      .bdrv_co_pdiscard       = qcow2_co_pdiscard,
>      .bdrv_truncate          = qcow2_truncate,
> +    .bdrv_get_allocated_file_size = qcow2_get_allocated_file_size,
>      .bdrv_co_pwritev_compressed = qcow2_co_pwritev_compressed,
>      .bdrv_make_empty        = qcow2_make_empty,
>  
> 
