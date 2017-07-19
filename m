Received: from eggs.gnu.org ([2001:4830:134:3::10]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXpPS-0005m7-Ox
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dXpPR-0001xs-8c
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 09:53:02 -0400
Date: Wed, 19 Jul 2017 15:45:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170719134558.GE4617@noname.redhat.com>
References: <1500453887-20819-1-git-send-email-kwolf@redhat.com>
	<87a840inlm.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a840inlm.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, pkrempa@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, nsoffer@redhat.com

Am 19.07.2017 um 15:05 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> > nodes above the top layer of mirror and commit block jobs. The
> > assumption made there was that since libvirt doesn't do node-level
> > management of the block layer yet, it shouldn't be affected by added
> > nodes.
> >
> > This is true as far as commands issued by libvirt are concerned. It only
> > uses BlockBackend names to address nodes, so any operations it performs
> > still operate on the root of the tree as intended.
> >
> > However, the assumption breaks down when you consider query commands,
> > which return data for the wrong node now. These commands also return
> > information on some child nodes (bs->file and/or bs->backing), which
> > libvirt does make use of, and which refer to the wrong nodes, too.
> >
> > One of the consequences is that oVirt gets wrong information about the
> > image size and stops the VM in response as long as a mirror or commit
> > job is running:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1470634
> >
> > This patch fixes the problem by hiding the implict nodes created
> > automatically by the mirror and commit block jobs in the output of
> > query-block and BlockBackend-based query-blockstats as long as the user
> > doesn't indicate that they are aware of those nodes by providing a node
> > name for them in the QMP command to start the block job.
> >
> > The node-based commands query-named-block-nodes and query-blockstats
> > with query-nodes=true still show all nodes, including implicit ones.
> 
> The only other query-FOO in block*.json is query-block-jobs.  Good.
> 
> > This ensures that users that are capable of node-level management can
> > still access the full information; users that only know BlockBackends
> > won't use these commands.
> 
> I think I can follow your reasoning, but I could use a concrete example.
> A small reproducer with output before and after the patch, and an
> explanation what exactly makes the output before the patch problematic.

Nir already replied with a link to comment 28 in the referenced BZ.
Thanks!

In short, the management tool is interested in "actual-size" of the
top-level image (as far as I can tell in order to check whether the
target device is large enough), but while the block job is running, it
gets the results for the filter node instead, where "actual-size" isn't
even present.

> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  block/commit.c             |  3 +++
> >  block/mirror.c             |  3 +++
> >  block/qapi.c               | 13 ++++++++++++-
> >  include/block/block_int.h  |  1 +
> >  qapi/block-core.json       |  6 ++++--
> >  tests/qemu-iotests/041     | 23 +++++++++++++++++++++++
> >  tests/qemu-iotests/041.out |  4 ++--
> >  7 files changed, 48 insertions(+), 5 deletions(-)
> >
> > diff --git a/block/commit.c b/block/commit.c
> > index 5cc910f..c7857c3 100644
> > --- a/block/commit.c
> > +++ b/block/commit.c
> > @@ -346,6 +346,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
> >      if (commit_top_bs == NULL) {
> >          goto fail;
> >      }
> > +    if (!filter_node_name) {
> > +        commit_top_bs->implicit = true;
> > +    }
> >      commit_top_bs->total_sectors = top->total_sectors;
> >      bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
> >  
> > diff --git a/block/mirror.c b/block/mirror.c
> > index 8583b76..c9a6a3c 100644
> > --- a/block/mirror.c
> > +++ b/block/mirror.c
> > @@ -1168,6 +1168,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
> >      if (mirror_top_bs == NULL) {
> >          return;
> >      }
> > +    if (!filter_node_name) {
> > +        mirror_top_bs->implicit = true;
> > +    }
> >      mirror_top_bs->total_sectors = bs->total_sectors;
> >      bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
> >  
> > diff --git a/block/qapi.c b/block/qapi.c
> > index 95b2e2d..0ed23b8 100644
> > --- a/block/qapi.c
> > +++ b/block/qapi.c
> > @@ -324,6 +324,11 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
> >      BlockDriverState *bs = blk_bs(blk);
> >      char *qdev;
> >  
> > +    /* Skip automatically inserted nodes that the user isn't aware of */
> > +    while (bs && bs->drv && bs->implicit) {
> > +        bs = backing_bs(bs);
> > +    }
> > +
> >      info->device = g_strdup(blk_name(blk));
> >      info->type = g_strdup("unknown");
> >      info->locked = blk_dev_is_medium_locked(blk);
> > @@ -518,12 +523,18 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
> >          }
> >      } else {
> >          for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
> > +            BlockDriverState *bs = blk_bs(blk);
> >              BlockStatsList *info = g_malloc0(sizeof(*info));
> >              AioContext *ctx = blk_get_aio_context(blk);
> >              BlockStats *s;
> >  
> > +            /* Skip automatically inserted nodes that the user isn't aware of */
> > +            while (bs && bs->drv && bs->implicit) {
> > +                bs = backing_bs(bs);
> > +            }
> > +
> >              aio_context_acquire(ctx);
> > -            s = bdrv_query_bds_stats(blk_bs(blk), true);
> > +            s = bdrv_query_bds_stats(bs, true);
> >              s->has_device = true;
> >              s->device = g_strdup(blk_name(blk));
> >              bdrv_query_blk_stats(s->stats, blk);
> 
> The result types of query-block and query-blockstats are recursive.  How
> can I convince myself that we're skipping everywhere we need to?

As Peter already commented, the recursive calls aren't covered. I'll
send out a v2 soon.

> > diff --git a/include/block/block_int.h b/include/block/block_int.h
> > index 5c6b761..d4f4ea7 100644
> > --- a/include/block/block_int.h
> > +++ b/include/block/block_int.h
> > @@ -549,6 +549,7 @@ struct BlockDriverState {
> >      bool sg;        /* if true, the device is a /dev/sg* */
> >      bool probed;    /* if true, format was probed rather than specified */
> >      bool force_share; /* if true, always allow all shared permissions */
> > +    bool implicit;  /* if true, this filter node was automatically inserted */
> 
> Makes sense.  How can I convince myself that your patch marks them all?

Tough question. The real answer is probably that you have to check all
(direct and indirect) callers of bdrv_open_driver().

The lazier answer is that we just know that bdrv_open_common() is never
called to create implicit nodes and we can restrict ourselves to calls
of bdrv_new_open_driver().

We have four calls of this function:

* In commit_start() and mirror_start_job(): Covered by this patch

* In bdrv_commit(): We could add it to commit_top_bs there, but it's a
  temporary node that is removed again before the function returns, and
  we're running under BQL, so it doesn't make a difference

* In vvfat: There an internal node is created, but it is not a filter
  driver, but a weird protocol driver. It is used as the backing file of
  the "qcow" child node of a vvfat node, so not accessible when
  following only bs->file and bs->backing edges

Kevin
