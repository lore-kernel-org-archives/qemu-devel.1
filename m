Received: from eggs.gnu.org ([2001:4830:134:3::10]:47766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJSq6-00007t-IS
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 18:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJSq5-0008P9-LS
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 18:29:26 -0500
Date: Tue, 28 Nov 2017 00:29:09 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171127232909.GF4903@localhost.localdomain>
References: <20171123175747.2309-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171123175747.2309-1-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jcody@redhat.com

Am 23.11.2017 um 18:57 hat Fam Zheng geschrieben:
> Jeff's block job patch made the latent drain bug visible, and I find this
> patch, which by itself also makes some sense, can hide it again. :) With it
> applied we are at least back to the ground where patchew's iotests (make
> docker-test-block@fedora) can pass.
> 
> The real bug is that in the middle of bdrv_parent_drained_end(), bs's parent
> list changes. One drained_end call before the mirror_exit() already did one
> blk_root_drained_end(), a second drained_end on an updated parent node can do
> another same blk_root_drained_end(), making it unbalanced with
> blk_root_drained_begin(). This is shown by the following three backtraces as
> captured by rr with a crashed "qemu-img commit", essentially the same as in
> the failed iotest 020:

My conclusion what really happens in 020 is that we have a graph like
this:

                             mirror target BB --+
                                                |
                                                v
    qemu-img BB -> mirror_top_bs -> overlay -> base

bdrv_drained_end(base) results in it being available for requests again,
so it calls bdrv_parent_drained_end() for overlay. While draining
itself, the mirror job completes and changes the BdrvChild between
mirror_top_bs and overlay (which is currently being drained) to point to
base instead. After returning, QLIST_FOREACH() continues to iterate the
parents of base instead of those of overlay, resulting in a second
blk_drained_end() for the mirror target BB.

This instance can be fixed relatively easily (see below) by using
QLIST_FOREACH_SAFE() instead.

However, I'm not sure if all problems with the graph change can be
solved this way and whether we can really allow graph changes while
iterating the graph for bdrv_drained_begin/end. Not allowing it would
require some more serious changes to the block jobs that delays their
completion until after bdrv_drain_end() has finished (not sure how to
even get a callback at that point...)

And the test cases that Jeff mentions still fail with this patch, too.
But at least it doesn't only make failure less likely by reducing the
window for a race condition, but seems to attack a real problem.

Kevin


diff --git a/block/io.c b/block/io.c
index 4fdf93a014..6773926fc1 100644
--- a/block/io.c
+++ b/block/io.c
@@ -42,9 +42,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
 void bdrv_parent_drained_begin(BlockDriverState *bs)
 {
-    BdrvChild *c;
+    BdrvChild *c, *next;
 
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c->role->drained_begin) {
             c->role->drained_begin(c);
         }
@@ -53,9 +53,9 @@ void bdrv_parent_drained_begin(BlockDriverState *bs)
 
 void bdrv_parent_drained_end(BlockDriverState *bs)
 {
-    BdrvChild *c;
+    BdrvChild *c, *next;
 
-    QLIST_FOREACH(c, &bs->parents, next_parent) {
+    QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c->role->drained_end) {
             c->role->drained_end(c);
         }
