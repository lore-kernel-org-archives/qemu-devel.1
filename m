Received: from eggs.gnu.org ([2001:4830:134:3::10]:57692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJeI7-00023U-7W
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eJeI6-0004MS-1l
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:43:07 -0500
Date: Tue, 28 Nov 2017 12:42:50 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171128114250.GB3703@localhost.localdomain>
References: <20171123175747.2309-1-famz@redhat.com>
	<20171127232909.GF4903@localhost.localdomain>
	<20171128054305.GP5399@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128054305.GP5399@localhost.localdomain>
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
To: Jeff Cody <jcody@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Am 28.11.2017 um 06:43 hat Jeff Cody geschrieben:
> On Tue, Nov 28, 2017 at 12:29:09AM +0100, Kevin Wolf wrote:
> > Am 23.11.2017 um 18:57 hat Fam Zheng geschrieben:
> > > Jeff's block job patch made the latent drain bug visible, and I find this
> > > patch, which by itself also makes some sense, can hide it again. :) With it
> > > applied we are at least back to the ground where patchew's iotests (make
> > > docker-test-block@fedora) can pass.
> > > 
> > > The real bug is that in the middle of bdrv_parent_drained_end(), bs's parent
> > > list changes. One drained_end call before the mirror_exit() already did one
> > > blk_root_drained_end(), a second drained_end on an updated parent node can do
> > > another same blk_root_drained_end(), making it unbalanced with
> > > blk_root_drained_begin(). This is shown by the following three backtraces as
> > > captured by rr with a crashed "qemu-img commit", essentially the same as in
> > > the failed iotest 020:
> > 
> > My conclusion what really happens in 020 is that we have a graph like
> > this:
> > 
> >                              mirror target BB --+
> >                                                 |
> >                                                 v
> >     qemu-img BB -> mirror_top_bs -> overlay -> base
> > 
> > bdrv_drained_end(base) results in it being available for requests again,
> > so it calls bdrv_parent_drained_end() for overlay. While draining
> > itself, the mirror job completes and changes the BdrvChild between
> > mirror_top_bs and overlay (which is currently being drained) to point to
> > base instead. After returning, QLIST_FOREACH() continues to iterate the
> > parents of base instead of those of overlay, resulting in a second
> > blk_drained_end() for the mirror target BB.
> > 
> > This instance can be fixed relatively easily (see below) by using
> > QLIST_FOREACH_SAFE() instead.
> > 
> > However, I'm not sure if all problems with the graph change can be
> > solved this way and whether we can really allow graph changes while
> > iterating the graph for bdrv_drained_begin/end. Not allowing it would
> > require some more serious changes to the block jobs that delays their
> > completion until after bdrv_drain_end() has finished (not sure how to
> > even get a callback at that point...)
> > 
> 
> That is at least part of what is causing the segfaults that I am still
> seeing (after your patch):
> 
> We enter bdrv_drain_recurse(), and the BDS has been reaped:

Not sure which test case this is referring to, probably 097 as that's
the next one in your list?

Anyway, test cases 097 and 176 can be fixed for me by keeping some
additional references. This quick fix is probably not quite correct
according to the comment in bdrv_drain_recurse() because bdrv_ref/unref
are only allowed in the main loop thread.

Also, case 141 is still failing.

Kevin


diff --git a/include/block/block_int.h b/include/block/block_int.h
index a5482775ec..c8bdf3648a 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -604,6 +604,7 @@ struct BlockDriverState {
     bool probed;    /* if true, format was probed rather than specified */
     bool force_share; /* if true, always allow all shared permissions */
     bool implicit;  /* if true, this filter node was automatically inserted */
+    bool closing;
 
     BlockDriver *drv; /* NULL means no media */
     void *opaque;
diff --git a/block.c b/block.c
index 9a1a0d1e73..7419e28a3b 100644
--- a/block.c
+++ b/block.c
@@ -3392,6 +3392,13 @@ static void bdrv_delete(BlockDriverState *bs)
     assert(bdrv_op_blocker_is_empty(bs));
     assert(!bs->refcnt);
 
+    /* An additional ref/unref pair during the shutdown (e.g. while draining
+     * the requests of this node) should not cause infinite recursion. */
+    if (bs->closing) {
+        return;
+    }
+    bs->closing = true;
+
     bdrv_close(bs);
 
     /* remove from list, if necessary */
diff --git a/block/io.c b/block/io.c
index 6773926fc1..6589246c48 100644
--- a/block/io.c
+++ b/block/io.c
@@ -194,6 +194,8 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
     BdrvChild *child, *tmp;
     bool waited;
 
+    bdrv_ref(bs);
+
     /* Ensure any pending metadata writes are submitted to bs->file.  */
     bdrv_drain_invoke(bs, begin);
 
@@ -221,6 +223,8 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
         }
     }
 
+    bdrv_unref(bs);
+
     return waited;
 }
 
@@ -293,9 +297,13 @@ void bdrv_drained_end(BlockDriverState *bs)
         return;
     }
 
+    /* bdrv_parent_drained_end() and bdrv_drain_recurse() may cause bs to be
+     * deleted if we don't keep an extra reference */
+    bdrv_ref(bs);
     bdrv_parent_drained_end(bs);
     bdrv_drain_recurse(bs, false);
     aio_enable_external(bdrv_get_aio_context(bs));
+    bdrv_unref(bs);
 }
 
 /*
diff --git a/block/io.c b/block/io.c
index 6773926fc1..6589246c48 100644
--- a/block/io.c
+++ b/block/io.c
@@ -194,6 +194,8 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
     BdrvChild *child, *tmp;
     bool waited;
 
+    bdrv_ref(bs);
+
     /* Ensure any pending metadata writes are submitted to bs->file.  */
     bdrv_drain_invoke(bs, begin);
 
@@ -221,6 +223,8 @@ static bool bdrv_drain_recurse(BlockDriverState *bs, bool begin)
         }
     }
 
+    bdrv_unref(bs);
+
     return waited;
 }
 
@@ -293,9 +297,13 @@ void bdrv_drained_end(BlockDriverState *bs)
         return;
     }
 
+    /* bdrv_parent_drained_end() and bdrv_drain_recurse() may cause bs to be
+     * deleted if we don't keep an extra reference */
+    bdrv_ref(bs);
     bdrv_parent_drained_end(bs);
     bdrv_drain_recurse(bs, false);
     aio_enable_external(bdrv_get_aio_context(bs));
+    bdrv_unref(bs);
 }
 
 /*
