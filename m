Received: from eggs.gnu.org ([2001:4830:134:3::10]:47475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daq8l-00037X-EK
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 17:16:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1daq8k-0004ks-Hx
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 17:16:15 -0400
References: <20170718160059.26806-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <91ce148c-2358-a7b6-9558-610a5ad84a1e@redhat.com>
Date: Thu, 27 Jul 2017 17:16:03 -0400
MIME-Version: 1.0
In-Reply-To: <20170718160059.26806-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Make bdrv_img_create() size
 selection easier to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 07/18/2017 12:00 PM, Eric Blake wrote:
> All callers of bdrv_img_create() pass in a size, or -1 to read the
> size from the backing file.  We then set that size as the QemuOpt
> default, which means we will reuse that default rather than the
> final parameter to qemu_opt_get_size() several lines later.  But
> it is rather confusing to read subsequent checks of 'size == -1'
> when it looks (without seeing the full context) like size defaults
> to 0; it also doesn't help that a size of 0 is valid (for some
> formats).
> 
> Rework the logic to make things more legible.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>   block.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 2dd9262cd0..57195ec40f 100644
> --- a/block.c
> +++ b/block.c
> @@ -4398,7 +4398,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
> 
>       /* The size for the image must always be specified, unless we have a backing
>        * file and we have not been forbidden from opening it. */
> -    size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> +    size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, img_size);
>       if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
>           BlockDriverState *bs;
>           char *full_backing = g_new0(char, PATH_MAX);
> 
