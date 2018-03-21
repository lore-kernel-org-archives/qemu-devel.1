Received: from eggs.gnu.org ([2001:4830:134:3::10]:40874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eydQI-0005MX-NQ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:04:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eydQD-0002jg-Pk
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:04:58 -0400
Date: Wed, 21 Mar 2018 09:04:37 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180321130437.GO12302@localhost.localdomain>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-11-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320173632.25480-11-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 10/12] vhdx: Don't use
 error_setg_errno() with constant errno
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, den@openvz.org, eblake@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 06:36:30PM +0100, Kevin Wolf wrote:
> error_setg_errno() is meant for cases where we got an errno from the OS
> that can add useful extra information to an error message. It's
> pointless if we pass a constant errno, these cases should use plain
> error_setg().
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vhdx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index ca211a3196..0e48179b81 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1822,7 +1822,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>      /* Validate options and set default values */
>      image_size = vhdx_opts->size;
>      if (image_size > VHDX_MAX_IMAGE_SIZE) {
> -        error_setg_errno(errp, EINVAL, "Image size too large; max of 64TB");
> +        error_setg(errp, "Image size too large; max of 64TB");
>          return -EINVAL;
>      }
>  
> @@ -1832,7 +1832,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          log_size = vhdx_opts->log_size;
>      }
>      if (log_size < MiB || (log_size % MiB) != 0) {
> -        error_setg_errno(errp, EINVAL, "Log size must be a multiple of 1 MB");
> +        error_setg(errp, "Log size must be a multiple of 1 MB");
>          return -EINVAL;
>      }
>  
> @@ -1874,7 +1874,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>      }
>  
>      if (block_size < MiB || (block_size % MiB) != 0) {
> -        error_setg_errno(errp, EINVAL, "Block size must be a multiple of 1 MB");
> +        error_setg(errp, "Block size must be a multiple of 1 MB");
>          return -EINVAL;
>      }
>      if (!is_power_of_2(block_size)) {
> @@ -1882,8 +1882,7 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          return -EINVAL;
>      }
>      if (block_size > VHDX_BLOCK_SIZE_MAX) {
> -        error_setg_errno(errp, EINVAL, "Block size must not exceed %d",
> -                         VHDX_BLOCK_SIZE_MAX);
> +        error_setg(errp, "Block size must not exceed %d", VHDX_BLOCK_SIZE_MAX);
>          return -EINVAL;
>      }
>  
> -- 
> 2.13.6
> 

Reviewed-by: Jeff Cody <jcody@redhat.com>
