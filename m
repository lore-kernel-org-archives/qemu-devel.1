Received: from eggs.gnu.org ([2001:4830:134:3::10]:56647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJYfv-0008On-9B
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 00:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eJYft-0007e7-Rf
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 00:43:19 -0500
Date: Tue, 28 Nov 2017 00:43:05 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20171128054305.GP5399@localhost.localdomain>
References: <20171123175747.2309-1-famz@redhat.com>
	<20171127232909.GF4903@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127232909.GF4903@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 0/1] block: Workaround for the iotests
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, Nov 28, 2017 at 12:29:09AM +0100, Kevin Wolf wrote:
> Am 23.11.2017 um 18:57 hat Fam Zheng geschrieben:
> > Jeff's block job patch made the latent drain bug visible, and I find this
> > patch, which by itself also makes some sense, can hide it again. :) With it
> > applied we are at least back to the ground where patchew's iotests (make
> > docker-test-block@fedora) can pass.
> > 
> > The real bug is that in the middle of bdrv_parent_drained_end(), bs's parent
> > list changes. One drained_end call before the mirror_exit() already did one
> > blk_root_drained_end(), a second drained_end on an updated parent node can do
> > another same blk_root_drained_end(), making it unbalanced with
> > blk_root_drained_begin(). This is shown by the following three backtraces as
> > captured by rr with a crashed "qemu-img commit", essentially the same as in
> > the failed iotest 020:
> 
> My conclusion what really happens in 020 is that we have a graph like
> this:
> 
>                              mirror target BB --+
>                                                 |
>                                                 v
>     qemu-img BB -> mirror_top_bs -> overlay -> base
> 
> bdrv_drained_end(base) results in it being available for requests again,
> so it calls bdrv_parent_drained_end() for overlay. While draining
> itself, the mirror job completes and changes the BdrvChild between
> mirror_top_bs and overlay (which is currently being drained) to point to
> base instead. After returning, QLIST_FOREACH() continues to iterate the
> parents of base instead of those of overlay, resulting in a second
> blk_drained_end() for the mirror target BB.
> 
> This instance can be fixed relatively easily (see below) by using
> QLIST_FOREACH_SAFE() instead.
> 
> However, I'm not sure if all problems with the graph change can be
> solved this way and whether we can really allow graph changes while
> iterating the graph for bdrv_drained_begin/end. Not allowing it would
> require some more serious changes to the block jobs that delays their
> completion until after bdrv_drain_end() has finished (not sure how to
> even get a callback at that point...)
> 

That is at least part of what is causing the segfaults that I am still
seeing (after your patch):

We enter bdrv_drain_recurse(), and the BDS has been reaped:


Thread 1 "qemu-img" received signal SIGSEGV, Segmentation fault.
0x000000010014b56e in qemu_mutex_unlock (mutex=0x76767676767676d6) at util/qemu-thread-posix.c:92
92          assert(mutex->initialized);

#0  0x000000010014b56e in qemu_mutex_unlock (mutex=0x76767676767676d6) at util/qemu-thread-posix.c:92
#1  0x00000001001450bf in aio_context_release (ctx=0x7676767676767676) at util/async.c:507
#2  0x000000010009d5c7 in bdrv_drain_recurse (bs=0x100843270, begin=false) at block/io.c:201
#3  0x000000010009d949 in bdrv_drained_end (bs=0x100843270) at block/io.c:297
#4  0x000000010002e705 in bdrv_child_cb_drained_end (child=0x100870c40) at block.c:822
#5  0x000000010009cdc6 in bdrv_parent_drained_end (bs=0x100863b10) at block/io.c:60
#6  0x000000010009d938 in bdrv_drained_end (bs=0x100863b10) at block/io.c:296
#7  0x000000010009d9d5 in bdrv_drain (bs=0x100863b10) at block/io.c:322
#8  0x000000010008c39c in blk_drain (blk=0x100881220) at block/block-backend.c:1523
#9  0x000000010009a85e in mirror_drain (job=0x10088df50) at block/mirror.c:996
#10 0x0000000100037eca in block_job_drain (job=0x10088df50) at blockjob.c:187
#11 0x000000010003856d in block_job_finish_sync (job=0x10088df50, finish=0x100038926 <block_job_complete>, errp=0x7fffffffd1d8) at blockjob.c:378
#12 0x0000000100038b80 in block_job_complete_sync (job=0x10088df50, errp=0x7fffffffd1d8) at blockjob.c:544
#13 0x0000000100023de5 in run_block_job (job=0x10088df50, errp=0x7fffffffd1d8) at qemu-img.c:872
#14 0x0000000100024305 in img_commit (argc=3, argv=0x7fffffffd390) at qemu-img.c:1034
#15 0x000000010002ccd1 in main (argc=3, argv=0x7fffffffd390) at qemu-img.c:4763


(gdb) f 2
#2  0x000000010009d5c7 in bdrv_drain_recurse (bs=0x100843270, begin=false) at block/io.c:201
201         waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
(gdb) list
196
197         /* Ensure any pending metadata writes are submitted to bs->file.  */
198         bdrv_drain_invoke(bs, begin);
199
200         /* Wait for drained requests to finish */
201         waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
202
203         QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
204             BlockDriverState *bs = child->bs;
205             bool in_main_loop =


(gdb) p *bs
$1 = {
  open_flags = 8835232, 
  read_only = true, 
  encrypted = false, 
  sg = false, 
  probed = false, 
  force_share = 56, 
  implicit = 59, 
  drv = 0x0, 
  opaque = 0x0, 
  aio_context = 0x7676767676767676, 
  aio_notifiers = {
    lh_first = 0x7676767676767676
  }, 
  [...]




> And the test cases that Jeff mentions still fail with this patch, too.
> But at least it doesn't only make failure less likely by reducing the
> window for a race condition, but seems to attack a real problem.
> 
> Kevin
> 
> 
> diff --git a/block/io.c b/block/io.c
> index 4fdf93a014..6773926fc1 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
>  
>  void bdrv_parent_drained_begin(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_begin) {
>              c->role->drained_begin(c);
>          }
> @@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
>  
>  void bdrv_parent_drained_end(BlockDriverState *bs)
>  {
> -    BdrvChild *c;
> +    BdrvChild *c, *next;
>  
> -    QLIST_FOREACH(c, &bs->parents, next_parent) {
> +    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
>          if (c->role->drained_end) {
>              c->role->drained_end(c);
>          }
>
