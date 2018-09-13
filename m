Received: from eggs.gnu.org ([2001:4830:134:3::10]:43511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0Hlw-0002bw-1f
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 22:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0Hlv-0006O6-8q
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 22:54:23 -0400
Date: Thu, 13 Sep 2018 10:54:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913025413.GA22356@lemon.usersys.redhat.com>
References: <20180913023134.3853-1-yuchenlin@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913023134.3853-1-yuchenlin@synology.com>
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: align end of file to a sector
 boundary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuchenlin@synology.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 09/13 10:31, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> There is a rare case which the size of last compressed cluster
> is larger than the cluster size, which will cause the file is
> not aligned at the sector boundary.

The code looks good to me. Can you also explain why it is important to align
file size to sector boundary in the comment?

Fam

> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
> v1 -> v2:
> * Add more detail comment.
> * Add QEMU_ALIGN_UP to show the intention more clearly.
> * Add newline in the end of bdrv_truncate.
> 
> thanks
> 
>  block/vmdk.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a9d0084e36..2c9e86d98f 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1698,6 +1698,27 @@ static int coroutine_fn
>  vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>                             uint64_t bytes, QEMUIOVector *qiov)
>  {
> +    if (bytes == 0) {
> +        /* The caller will write bytes 0 to signal EOF.
> +         * When receive it, we align EOF to a sector boundary. */
> +        BDRVVmdkState *s = bs->opaque;
> +        int i, ret;
> +        int64_t length;
> +
> +        for (i = 0; i < s->num_extents; i++) {
> +            length = bdrv_getlength(s->extents[i].file->bs);
> +            if (length < 0) {
> +                return length;
> +            }
> +            length = QEMU_ALIGN_UP(length, BDRV_SECTOR_SIZE);
> +            ret = bdrv_truncate(s->extents[i].file, length,
> +                                PREALLOC_MODE_OFF, NULL);
> +            if (ret < 0) {
> +                return ret;
> +            }
> +        }
> +        return 0;
> +    }
>      return vmdk_co_pwritev(bs, offset, bytes, qiov, 0);
>  }
>  
> -- 
> 2.18.0
> 
