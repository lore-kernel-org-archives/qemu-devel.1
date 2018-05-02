Received: from eggs.gnu.org ([2001:4830:134:3::10]:58585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwFk-0002R0-Hu
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDwFj-0005tK-Hh
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:13:20 -0400
References: <20180421165423.30759-1-mreitz@redhat.com>
	<20180421165423.30759-5-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b704895d-fbc9-5854-4d81-24436b4988ec@redhat.com>
Date: Wed, 2 May 2018 13:13:08 -0500
MIME-Version: 1.0
In-Reply-To: <20180421165423.30759-5-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] qemu-img: Add print_amend_option_help()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On 04/21/2018 11:54 AM, Max Reitz wrote:
> The more generic print_block_option_help() function is not really
> suitable for qemu-img amend, for a couple of reasons:
> (1) We do not need to append the protocol-level options, as amendment
>      happens only on one node and does not descend downwards to its
>      children.
> (2) print_block_option_help() says those options are "supported".  For
>      option amendment, we do not really know that.  So this new function
>      explicitly says that those options are the creation options, and not
>      all of them may be supported.
> (3) If the driver does not support option amendment, we should not print
>      anything (except for an error message that amendment is not
>      supported).
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1537956
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   qemu-img.c                 | 30 ++++++++++++++++++++++++++++--
>   tests/qemu-iotests/082.out | 44 +++++++++++++++++++++++++++-----------------
>   2 files changed, 55 insertions(+), 19 deletions(-)
> 

> diff --git a/qemu-img.c b/qemu-img.c
> index 6dd8e95bb2..45e243cc80 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -3578,6 +3578,32 @@ static void amend_status_cb(BlockDriverState *bs,
>       qemu_progress_print(100.f * offset / total_work_size, 0);
>   }
>   
> +static int print_amend_option_help(const char *format)
> +{
> +    BlockDriver *drv;
> +
> +    /* Find driver and parse its options */
> +    drv = bdrv_find_format(format);
> +    if (!drv) {
> +        error_report("Unknown file format '%s'", format);
> +        return 1;
> +    }

Not your fault; I'd love it if this file consistently used EXIT_FAILURE 
instead of 1 (since that's a bit more obvious why we are returning a 
positive value instead of our more usual negative-on-error - we expect 
the caller to feed our return value to exit()), but that's a separate 
cleanup.

But the new output is definitely nicer.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
