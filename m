Received: from eggs.gnu.org ([2001:4830:134:3::10]:37409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyZ4e-0006HP-Tq
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:21:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cyZ4d-0008Rl-TH
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:21:48 -0400
Date: Thu, 13 Apr 2017 15:21:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170413072137.GA7585@lemon>
References: <20170410022636.29925-1-famz@redhat.com>
	<20170410160417.GH3214@stefanha-x1.localdomain>
	<0800f14a-4b80-9bed-bf2a-41f177ffff64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0800f14a-4b80-9bed-bf2a-41f177ffff64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] block: Quiesce old aio context
 during bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu, 04/13 14:51, Paolo Bonzini wrote:
> 
> 
> On 11/04/2017 00:04, Stefan Hajnoczi wrote:
> > On Mon, Apr 10, 2017 at 10:26:34AM +0800, Fam Zheng wrote:
> >> v3: Use bdrv_parent_drained_begin/end. [Kevin]
> >>     Do it before releasing new_context. [Stefan]
> >>
> >> Fam Zheng (2):
> >>   block: Make bdrv_parent_drained_begin/end public
> >>   block: Quiesce old aio context during bdrv_set_aio_context
> >>
> >>  block.c               |  7 +++++--
> >>  block/io.c            |  4 ++--
> >>  include/block/block.h | 16 ++++++++++++++++
> >>  3 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > Thanks, applied to my block tree for 2.10:
> > https://github.com/stefanha/qemu/commits/block
> > 
> > If you'd like this in a stable release please CC qemu-stable.
> 
> Stefan, can you squash this documentation patch in please?
> 
> diff --git a/block.c b/block.c
> index 3b20a29..cb1c5c9 100644
> --- a/block.c
> +++ b/block.c
> @@ -4392,6 +4392,18 @@ void bdrv_set_aio_context(BlockDriverState *bs,
> AioContext *new_context)
>  {
>      AioContext *ctx = bdrv_get_aio_context(bs);
> 
> +    /* FIXME: This is the same as bdrv_drained_begin, only done
> +     * manually.  At the end of this function, aio_enable_external
> +     * must be done on ctx, not on new_context, so we cannot call
> +     * bdrv_drained_end there.  And because bs->quiesce_counter will
> +     * not be decreased there, we have to "explode" bdrv_drained_begin
> +     * here too.
> +     *
> +     * Once aio_disable_external and aio_enable_external are replaced
> +     * by BlockBackend device ops (called by .drained_begin/end
> +     * BdrvChildRole callbacks), this can be replaced by a simple
> +     * bdrv_drained_begin/end pair.
> +     */
>      aio_disable_external(ctx);
>      bdrv_parent_drained_begin(bs);
>      bdrv_drain(bs); /* ensure there are no in-flight requests */

This patch was necessary to fix the earlier crash so it is already merged with
my last pull request for -rc4:

commit aabf591007a83dc6520329bce929570115849286
Author: Fam Zheng <famz@redhat.com>
Date:   Wed Apr 5 14:44:24 2017 +0800

    block: Quiesce old aio context during bdrv_set_aio_context
    
    The fact that the bs->aio_context is changing can confuse the dataplane
    iothread, because of the now fine granularity aio context lock.
    bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
    bs->aio_context is changing, we can just use aio_disable_external and
    bdrv_parent_drained_begin.
    
    Reported-by: Ed Swierk <eswierk@skyportsystems.com>
    Signed-off-by: Fam Zheng <famz@redhat.com>
    Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Reviewed-by: Kevin Wolf <kwolf@redhat.com>

Paolo, maybe you want to submit a formal patch for 2.10? (Sorry for the
confusion, these series of mine went a bit messy.)

Fam
