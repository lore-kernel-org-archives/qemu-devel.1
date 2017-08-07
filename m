Received: from eggs.gnu.org ([2001:4830:134:3::10]:51160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deorz-0003yF-SM
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1deoru-0003dr-WF
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 16:43:23 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170807203007.19033-1-eblake@redhat.com>
	<20170807203007.19033-2-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <45c1d0d1-91b9-3145-f017-7e41a0ecf734@amsat.org>
Date: Mon, 7 Aug 2017 17:43:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170807203007.19033-2-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] vpc: Check failure of bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 08/07/2017 05:30 PM, Eric Blake wrote:
> vpc_open() was checking for bdrv_getlength() failure in one, but
> not the other, location.
> 
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   block/vpc.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index 574879ba7c..468d10ec1c 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -219,6 +219,7 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>       uint64_t pagetable_size;
>       int disk_type = VHD_DYNAMIC;
>       int ret;
> +    int64_t bs_size;
> 
>       bs->file = bdrv_open_child(NULL, options, "file", bs, &child_file,
>                                  false, errp);
> @@ -411,7 +412,13 @@ static int vpc_open(BlockDriverState *bs, QDict *options, int flags,
>               }
>           }
> 
> -        if (s->free_data_block_offset > bdrv_getlength(bs->file->bs)) {
> +        bs_size = bdrv_getlength(bs->file->bs);
> +        if (bs_size < 0) {
> +            error_setg_errno(errp, -bs_size, "unable to learn image size");
> +            ret = bs_size;
> +            goto fail;
> +        }
> +        if (s->free_data_block_offset > bs_size) {
>               error_setg(errp, "block-vpc: free_data_block_offset points after "
>                                "the end of file. The image has been truncated.");
>               ret = -EINVAL;
> 
