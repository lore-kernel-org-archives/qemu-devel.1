Received: from eggs.gnu.org ([2001:4830:134:3::10]:40621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eydOy-0004is-94
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eydOu-0002Bf-Ag
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 09:03:36 -0400
Date: Wed, 21 Mar 2018 09:03:16 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180321130316.GN12302@localhost.localdomain>
References: <20180320173632.25480-1-kwolf@redhat.com>
	<20180320173632.25480-10-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320173632.25480-10-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12 09/12] vhdx: Require power-of-two
 block size on create
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

On Tue, Mar 20, 2018 at 06:36:29PM +0100, Kevin Wolf wrote:
> Images with a non-power-of-two block size are invalid and cannot be
> opened. Reject such block sizes when creating an image.
> 

Good catch.

Reviewed-by: Jeff Cody <jcody@redhat.com>


> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/vhdx.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/block/vhdx.c b/block/vhdx.c
> index f1b97f4b49..ca211a3196 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -1877,6 +1877,10 @@ static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
>          error_setg_errno(errp, EINVAL, "Block size must be a multiple of 1 MB");
>          return -EINVAL;
>      }
> +    if (!is_power_of_2(block_size)) {
> +        error_setg(errp, "Block size must be a power of two");
> +        return -EINVAL;
> +    }
>      if (block_size > VHDX_BLOCK_SIZE_MAX) {
>          error_setg_errno(errp, EINVAL, "Block size must not exceed %d",
>                           VHDX_BLOCK_SIZE_MAX);
> -- 
> 2.13.6
> 
