Received: from eggs.gnu.org ([2001:4830:134:3::10]:51144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dulRB-0007d4-6c
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dulRA-0002PL-7d
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 16:17:37 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-2-pbutsykin@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <eaef3a7c-e634-50bb-a98c-9d5db7446c00@redhat.com>
Date: Wed, 20 Sep 2017 16:17:29 -0400
MIME-Version: 1.0
In-Reply-To: <20170920135833.20472-2-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] qcow2: fix return error
 code in qcow2_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com



On 09/20/2017 09:58 AM, Pavel Butsykin wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 2174a84d1f..8a4311d338 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3166,7 +3166,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>          if (old_file_size < 0) {
>              error_setg_errno(errp, -old_file_size,
>                               "Failed to inquire current file length");
> -            return ret;
> +            return old_file_size;
>          }
>  
>          nb_new_data_clusters = DIV_ROUND_UP(offset - old_length,
> @@ -3195,7 +3195,7 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>          if (allocation_start < 0) {
>              error_setg_errno(errp, -allocation_start,
>                               "Failed to resize refcount structures");
> -            return -allocation_start;
> +            return allocation_start;
>          }
>  
>          clusters_allocated = qcow2_alloc_clusters_at(bs, allocation_start,
> 

Yikes...

Reviewed-by: John Snow <jsnow@redhat.com>
