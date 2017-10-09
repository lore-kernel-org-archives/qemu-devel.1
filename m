Received: from eggs.gnu.org ([2001:4830:134:3::10]:58701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1e1ajf-000718-SS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1e1ajc-0005PS-IT
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 12:16:55 -0400
References: <20171009155431.14093-1-mreitz@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <f762f398-77fc-b966-f829-79578432528c@virtuozzo.com>
Date: Mon, 9 Oct 2017 19:16:25 +0300
MIME-Version: 1.0
In-Reply-To: <20171009155431.14093-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qcow2: Emit errp when truncating the image
 tail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 09.10.2017 18:54, Max Reitz wrote:
> bdrv_truncate() has an errp parameter which is always set when an error
> occurs.  Let's use that instead of a plain strerror().
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/qcow2.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index dff903e05c..2f6a8e1ff8 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3150,12 +3150,13 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
>               return last_cluster;
>           }
>           if ((last_cluster + 1) * s->cluster_size < old_file_size) {
> -            ret = bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
> -                                PREALLOC_MODE_OFF, NULL);
> -            if (ret < 0) {
> -                warn_report("Failed to truncate the tail of the image: %s",
> -                            strerror(-ret));
> -                ret = 0;
> +            Error *local_err = NULL;
> +
> +            bdrv_truncate(bs->file, (last_cluster + 1) * s->cluster_size,
> +                          PREALLOC_MODE_OFF, &local_err);
> +            if (local_err) {
> +                warn_reportf_err(local_err,
> +                                 "Failed to truncate the tail of the image: ");
>               }
>           }
>       } else {
> 

Reviewed-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
