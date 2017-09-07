Received: from eggs.gnu.org ([2001:4830:134:3::10]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpwpE-00009c-4O
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:26:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dpwp9-0006IF-9m
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:26:32 -0400
Date: Thu, 7 Sep 2017 15:26:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170907132611.GG4461@dhcp-200-186.str.redhat.com>
References: <20170825132332.6734-1-el13635@mail.ntua.gr>
	<20170825132332.6734-5-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825132332.6734-5-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH v3 4/7] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>

Am 25.08.2017 um 15:23 hat Manos Pitsidianakis geschrieben:
> This commit removes all I/O throttling from block/block-backend.c. In
> order to support the existing interface, it is changed to use the
> block/throttle.c filter driver.
> 
> The throttle filter node that is created by the legacy interface is
> stored in a 'throttle_node' field in the BlockBackendPublic of the
> device. The legacy throttle node is managed by the legacy interface
> completely. More advanced configurations with the filter drive are
> possible using the QMP API, but these will be ignored by the legacy
> interface.
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

This patch doesn't apply cleanly any more and needs a rebase.

>  /* should be called before blk_set_io_limits if a limit is set */
> -void blk_io_limits_enable(BlockBackend *blk, const char *group)
> +void blk_io_limits_enable(BlockBackend *blk, const char *group,  Error **errp)
>  {
> -    assert(!blk->public.throttle_group_member.throttle_state);
> -    throttle_group_register_tgm(&blk->public.throttle_group_member,
> -                                group, blk_get_aio_context(blk));
> +    BlockDriverState *bs = blk_bs(blk), *throttle_node;
> +    QDict *options = qdict_new();
> +    Error *local_err = NULL;
> +    ThrottleState *ts;
> +
> +    bdrv_drained_begin(bs);

bs can be NULL:

$ x86_64-softmmu/qemu-system-x86_64 -drive media=cdrom,bps=1024
Segmentation fault (core dumped)

>  static void blk_root_drained_begin(BdrvChild *child)
>  {
> +    ThrottleGroupMember *tgm;
>      BlockBackend *blk = child->opaque;
>  
>      if (++blk->quiesce_counter == 1) {
> @@ -1997,19 +2025,25 @@ static void blk_root_drained_begin(BdrvChild *child)
>  
>      /* Note that blk->root may not be accessible here yet if we are just
>       * attaching to a BlockDriverState that is drained. Use child instead. */
> -
> -    if (atomic_fetch_inc(&blk->public.throttle_group_member.io_limits_disabled) == 0) {
> -        throttle_group_restart_tgm(&blk->public.throttle_group_member);
> +    if (blk->public.throttle_node) {
> +        tgm = throttle_get_tgm(blk->public.throttle_node);
> +        if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
> +            throttle_group_restart_tgm(tgm);
> +        }
>      }
>  }
>  
>  static void blk_root_drained_end(BdrvChild *child)
>  {
> +    ThrottleGroupMember *tgm;
>      BlockBackend *blk = child->opaque;
>      assert(blk->quiesce_counter);
>  
> -    assert(blk->public.throttle_group_member.io_limits_disabled);
> -    atomic_dec(&blk->public.throttle_group_member.io_limits_disabled);
> +    if (blk->public.throttle_node) {
> +        tgm = throttle_get_tgm(blk->public.throttle_node);
> +        assert(tgm->io_limits_disabled);
> +        atomic_dec(&tgm->io_limits_disabled);
> +    }

We shouldn't really need any throttling code in
blk_root_drained_begin/end any more now because the throttle node will
be drained. If this code is necessary, a bdrv_drain() on an explicit
throttle node will work differently from one on an implicit one.

Unfortunately, this seems to be true about the throttle node. Implicit
throttle nodes will keep ignoring the throttle limit in order to
complete the drain request quickly, where as explicit throttle nodes
will process their requests at the configured speed before the drain
request can be completed.

This doesn't feel right to me, both should behave the same.

Kevin
