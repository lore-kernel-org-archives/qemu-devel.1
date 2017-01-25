Received: from eggs.gnu.org ([2001:4830:134:3::10]:45121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRbp-00064T-5j
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRbo-0006FL-8B
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:43:49 -0500
Date: Wed, 25 Jan 2017 12:43:40 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170125174340.GA2688@localhost.localdomain>
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Forgot to cc qemu-block, added.

On Wed, Jan 25, 2017 at 12:22:02PM -0500, Jeff Cody wrote:
> In bdrv_find_backing_image(), if we are searching an image for a backing
> file that contains a protocol, we currently only compare unmodified
> paths.
> 
> However, some management software will change the backing filename to be
> a relative filename in a path.  QEMU is able to handle this fine,
> because internally it will use path_combine to put together the full
> protocol URI.
> 
> However, this can lead to an inability to match an image during a QAPI
> command that needs to use bdrv_find_backing_image() to find the image,
> when it is searched by the full URI.
> 
> When searching for a protocol filename, if the straight comparison
> fails, this patch will also compare against the full backing filename to
> see if that is a match.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/block.c b/block.c
> index 39ddea3..a173afc 100644
> --- a/block.c
> +++ b/block.c
> @@ -3145,6 +3145,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>      int is_protocol = 0;
>      BlockDriverState *curr_bs = NULL;
>      BlockDriverState *retval = NULL;
> +    Error *local_error = NULL;
>  
>      if (!bs || !bs->drv || !backing_file) {
>          return NULL;
> @@ -3165,6 +3166,17 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
>                  retval = curr_bs->backing->bs;
>                  break;
>              }
> +            /* Also check against the full backing filename for the image */
> +            bdrv_get_full_backing_filename(curr_bs, backing_file_full, PATH_MAX,
> +                                           &local_error);
> +            if (local_error == NULL) {
> +                if (strcmp(backing_file, backing_file_full) == 0) {
> +                    retval = curr_bs->backing->bs;
> +                    break;
> +                }
> +            } else {
> +                error_free(local_error);
> +            }
>          } else {
>              /* If not an absolute filename path, make it relative to the current
>               * image's filename path */
> -- 
> 2.9.3
> 
