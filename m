Received: from eggs.gnu.org ([2001:4830:134:3::10]:47321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIb3b-0002W3-3a
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:36:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIb3W-0008SW-FT
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:36:03 -0400
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-2-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d61d47db-a121-a3e3-5bd8-312af5511991@redhat.com>
Date: Tue, 15 May 2018 09:35:48 -0500
MIME-Version: 1.0
In-Reply-To: <1525791496-125188-2-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 1/9] mirror: inherit supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@virtuozzo.com, berto@igalia.com

On 05/08/2018 09:58 AM, Anton Nefedov wrote:
> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   block/mirror.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

That said,

> 
> diff --git a/block/mirror.c b/block/mirror.c
> index 820f512..a22ddef 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1098,6 +1098,15 @@ static BlockDriver bdrv_mirror_top = {
>       .bdrv_child_perm            = bdrv_mirror_top_child_perm,
>   };
>   
> +static void mirror_top_set_supported_flags(BlockDriverState *bs)
> +{
> +    bs->supported_write_flags = BDRV_REQ_FUA &
> +        bs->backing->bs->supported_write_flags;
> +    bs->supported_zero_flags =
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->backing->bs->supported_zero_flags;
> +}
> +

This is a pretty short static function...

>   static void mirror_start_job(const char *job_id, BlockDriverState *bs,
>                                int creation_flags, BlockDriverState *target,
>                                const char *replaces, int64_t speed,
> @@ -1163,6 +1172,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
>           return;
>       }
>   
> +    mirror_top_set_supported_flags(mirror_top_bs);

...with exactly one caller.  Wouldn't it be easier to just inline it?

> +
>       /* Make sure that the source is not resized while the job is running */
>       s = block_job_create(job_id, driver, NULL, mirror_top_bs,
>                            BLK_PERM_CONSISTENT_READ,
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
