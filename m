Received: from eggs.gnu.org ([2001:4830:134:3::10]:47786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIb5H-0003pD-BI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fIb5G-0000jy-Av
	for qemu-devel@nongnu.org; Tue, 15 May 2018 10:37:47 -0400
References: <1525791496-125188-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1525791496-125188-3-git-send-email-anton.nefedov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <27657d49-932c-873e-c5f3-2544b0b2aa93@redhat.com>
Date: Tue, 15 May 2018 09:37:35 -0500
MIME-Version: 1.0
In-Reply-To: <1525791496-125188-3-git-send-email-anton.nefedov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 2/9] blkverify: set supported write/zero
 flags
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
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>   block/blkverify.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/block/blkverify.c b/block/blkverify.c
> index 754cc9e..496ae09 100644
> --- a/block/blkverify.c
> +++ b/block/blkverify.c
> @@ -141,6 +141,15 @@ static int blkverify_open(BlockDriverState *bs, QDict *options, int flags,
>           goto fail;
>       }
>   
> +    bs->supported_write_flags = BDRV_REQ_FUA &
> +        bs->file->bs->supported_write_flags &
> +        s->test_file->bs->supported_write_flags;

I wonder if it's worth the effort to support the flags if the main file 
supports them natively but the test_file does not (and just emulate the 
flag on the test file, in that situation).  But for now, I'm fine with 
your choice that both files must support a flag before the blkverify 
layer claims the flag as well.

> +
> +    bs->supported_zero_flags =
> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
> +        bs->file->bs->supported_zero_flags &
> +        s->test_file->bs->supported_zero_flags;
> +
>       ret = 0;
>   fail:
>       qemu_opts_del(opts);
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
