Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1r8w-0000ZW-AU
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e1r8q-0002eA-Di
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 05:48:06 -0400
Date: Tue, 10 Oct 2017 11:47:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171010094738.GF4177@dhcp-200-186.str.redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-11-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913181910.29688-11-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/18] block/mirror: Make source the file
 child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
> Regarding the source BDS, the mirror BDS is arguably a filter node.
> Therefore, the source BDS should be its "file" child.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

TODO: Justification why this doesn't break things like
bdrv_is_allocated_above() that iterate through the backing chain.

>  block/mirror.c             | 127 ++++++++++++++++++++++++++++++++++-----------
>  block/qapi.c               |  25 ++++++---
>  tests/qemu-iotests/141.out |   4 +-
>  3 files changed, 119 insertions(+), 37 deletions(-)
> 
> diff --git a/block/qapi.c b/block/qapi.c
> index 7fa2437923..ee792d0cbc 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -147,9 +147,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>  
>          /* Skip automatically inserted nodes that the user isn't aware of for
>           * query-block (blk != NULL), but not for query-named-block-nodes */
> -        while (blk && bs0->drv && bs0->implicit) {
> -            bs0 = backing_bs(bs0);
> -            assert(bs0);
> +        while (blk && bs0 && bs0->drv && bs0->implicit) {
> +            if (bs0->backing) {
> +                bs0 = backing_bs(bs0);
> +            } else {
> +                assert(bs0->file);
> +                bs0 = bs0->file->bs;
> +            }
>          }
>      }

Maybe backing_bs() should skip filters? If so, need to show that all
existing users of backing_bs() really want to skip filters. If not,
explain why the missing backing_bs() callers don't need it (I'm quite
sure that some do).

Also, if we attack this at the backing_bs() level, we need to audit
code that it doesn't directly use bs->backing.

> @@ -1135,44 +1146,88 @@ static const BlockJobDriver commit_active_job_driver = {
>      .drain                  = mirror_drain,
>  };
>  
> +static void source_child_inherit_fmt_options(int *child_flags,
> +                                             QDict *child_options,
> +                                             int parent_flags,
> +                                             QDict *parent_options)
> +{
> +    child_backing.inherit_options(child_flags, child_options,
> +                                  parent_flags, parent_options);
> +}
> +
> +static char *source_child_get_parent_desc(BdrvChild *c)
> +{
> +    return child_backing.get_parent_desc(c);
> +}
> +
> +static void source_child_cb_drained_begin(BdrvChild *c)
> +{
> +    BlockDriverState *bs = c->opaque;
> +    MirrorBDSOpaque *s = bs->opaque;
> +
> +    if (s && s->job) {
> +        block_job_drained_begin(&s->job->common);
> +    }
> +    bdrv_drained_begin(bs);
> +}
> +
> +static void source_child_cb_drained_end(BdrvChild *c)
> +{
> +    BlockDriverState *bs = c->opaque;
> +    MirrorBDSOpaque *s = bs->opaque;
> +
> +    if (s && s->job) {
> +        block_job_drained_end(&s->job->common);
> +    }
> +    bdrv_drained_end(bs);
> +}
> +
> +static BdrvChildRole source_child_role = {
> +    .inherit_options    = source_child_inherit_fmt_options,
> +    .get_parent_desc    = source_child_get_parent_desc,
> +    .drained_begin      = source_child_cb_drained_begin,
> +    .drained_end        = source_child_cb_drained_end,
> +};

Wouldn't it make much more sense to use a standard child role and just
implement BlockDriver callbacks for .bdrv_drained_begin/end? It seems
that master still only has .bdrv_co_drain (which is begin), but one of
Manos' pending series adds the missing end callback.

Kevin
