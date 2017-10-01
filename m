Received: from eggs.gnu.org ([2001:4830:134:3::10]:47681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dyUUe-0004HU-74
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1dyUUd-0000ez-A5
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 23:00:36 -0400
Date: Sat, 30 Sep 2017 23:00:25 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171001030025.GE4313@localhost.localdomain>
References: <20170930195345.23338-1-eblake@redhat.com>
	<20170930195345.23338-3-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170930195345.23338-3-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] block: Add blkdebug hook
 for copy-on-read
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Sat, Sep 30, 2017 at 02:53:43PM -0500, Eric Blake wrote:
> Make it possible to inject errors on writes performed during a
> read operation due to copy-on-read semantics.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>


Reviewed-by: Jeff Cody <jcody@redhat.com>


> ---
>  qapi/block-core.json | 5 ++++-
>  block/io.c           | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 750bb0c77c..ab96e348e6 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2538,6 +2538,8 @@
>  #
>  # @l1_shrink_free_l2_clusters: discard the l2 tables. (since 2.11)
>  #
> +# @cor_write: a write due to copy-on-read (since 2.11)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'BlkdebugEvent', 'prefix': 'BLKDBG',
> @@ -2555,7 +2557,8 @@
>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
>              'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> -            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters',
> +            'cor_write'] }
> 
>  ##
>  # @BlkdebugInjectErrorOptions:
> diff --git a/block/io.c b/block/io.c
> index d633b0f851..97d9fa655d 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -983,6 +983,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>          goto err;
>      }
> 
> +    bdrv_debug_event(bs, BLKDBG_COR_WRITE);
>      if (drv->bdrv_co_pwrite_zeroes &&
>          buffer_is_zero(bounce_buffer, iov.iov_len)) {
>          /* FIXME: Should we (perhaps conditionally) be setting
> -- 
> 2.13.6
> 
> 
