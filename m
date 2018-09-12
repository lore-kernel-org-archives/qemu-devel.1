Received: from eggs.gnu.org ([2001:4830:134:3::10]:39839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g01XN-0001Zt-7X
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 05:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g01XM-0007FY-If
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 05:34:17 -0400
Date: Wed, 12 Sep 2018 17:34:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180912093408.GG2526@lemon.usersys.redhat.com>
References: <20180828031751.29507-1-yuchenlin@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828031751.29507-1-yuchenlin@synology.com>
Subject: Re: [Qemu-devel] [PATCH] vmdk: align end of file to a sector
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

On Tue, 08/28 11:17, yuchenlin@synology.com wrote:
> From: yuchenlin <yuchenlin@synology.com>
> 
> There is a rare case which the size of last compressed cluster
> is larger than the cluster size, which will cause the file is
> not aligned at the sector boundary.

I don't understand. Doesn't it mean that if you force the alignment by
truncating out the extra bytes, some data is lost?

> 
> Signed-off-by: yuchenlin <yuchenlin@synology.com>
> ---
>  block/vmdk.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/block/vmdk.c b/block/vmdk.c
> index a9d0084e36..a8ae7c65d2 100644
> --- a/block/vmdk.c
> +++ b/block/vmdk.c
> @@ -1698,6 +1698,24 @@ static int coroutine_fn
>  vmdk_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
>                             uint64_t bytes, QEMUIOVector *qiov)
>  {
> +    if (bytes == 0) {

Where is this bytes == 0 condition from?

> +        /* align end of file to a sector boundary. */
> +        BDRVVmdkState *s = bs->opaque;
> +        int i, ret;
> +        int64_t length;
> +
> +        for (i = 0; i < s->num_extents; i++) {
> +            length = bdrv_getlength(s->extents[i].file->bs);
> +            if (length < 0) {
> +                return length;
> +            }
> +            ret = bdrv_truncate(s->extents[i].file, length, PREALLOC_MODE_OFF, NULL);
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
> 2.17.0
> 

Fam
