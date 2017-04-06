Received: from eggs.gnu.org ([2001:4830:134:3::10]:44314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw9UD-0006Qc-It
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cw9UC-0001v2-J9
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 11:38:13 -0400
Date: Thu, 6 Apr 2017 17:37:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170406153754.GK4341@noname.redhat.com>
References: <20170406142527.25835-1-famz@redhat.com>
	<20170406142527.25835-5-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406142527.25835-5-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] block: Drain BH in
 bdrv_drained_begin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Ed Swierk <eswierk@skyportsystems.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 06.04.2017 um 16:25 hat Fam Zheng geschrieben:
> During block job completion, nothing is preventing
> block_job_defer_to_main_loop_bh from being called in a nested
> aio_poll(), which is a trouble, such as in this code path:
> 
>     qmp_block_commit
>       commit_active_start
>         bdrv_reopen
>           bdrv_reopen_multiple
>             bdrv_reopen_prepare
>               bdrv_flush
>                 aio_poll
>                   aio_bh_poll
>                     aio_bh_call
>                       block_job_defer_to_main_loop_bh
>                         stream_complete
>                           bdrv_reopen
> 
> block_job_defer_to_main_loop_bh is the last step of the stream job,
> which should have been "paused" by the bdrv_drained_begin/end in
> bdrv_reopen_multiple, but it is not done because it's in the form of a
> main loop BH.
> 
> Similar to why block jobs should be paused between drained_begin and
> drained_end, BHs they schedule must be excluded as well.  To achieve
> this, this patch forces draining the BH before leaving bdrv_drained_begin().
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

We used to poll BHs in earlier times. Commit 99723548 ('block: add BDS
field to count in-flight requests') changed this, without an explanation
in the commit message.

Paolo, is this simply a bug in that commit, or do you rely on it
somewhere? I remember that you wanted to get rid of some aio_poll()
calls a while ago.

>  block/io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/block/io.c b/block/io.c
> index 2709a70..b9cfd18 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -228,7 +228,12 @@ void bdrv_drained_begin(BlockDriverState *bs)
>          bdrv_parent_drained_begin(bs);
>      }
>  
> -    bdrv_drain_recurse(bs);
> +    while (true) {
> +        if (!bdrv_drain_recurse(bs) &&
> +            !aio_poll(bdrv_get_aio_context(bs), false)) {
> +                break;
> +            }

The indentation is off here.

> +    }
>  }

The old code had this in what is now the BDRV_POLL_WHILE() call in
bdrv_drain_recurse(). I think it makes more sense there, saves you a
loop here and fixes bdrv_drain_all_begin() at the same time.

Kevin
