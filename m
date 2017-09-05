Received: from eggs.gnu.org ([2001:4830:134:3::10]:54326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpF3T-0000JN-Oz
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dpF3P-0007WW-8w
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 10:42:19 -0400
Date: Tue, 5 Sep 2017 15:42:02 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170905144202.GS17449@stefanha-x1.localdomain>
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
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

On Fri, Aug 25, 2017 at 04:23:29PM +0300, Manos Pitsidianakis wrote:
>  void blk_io_limits_disable(BlockBackend *blk)
>  {
> -    assert(blk->public.throttle_group_member.throttle_state);
> -    bdrv_drained_begin(blk_bs(blk));
> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
> -    bdrv_drained_end(blk_bs(blk));
> +    BlockDriverState *bs, *throttle_node;
> +
> +    throttle_node = blk_get_public(blk)->throttle_node;
> +
> +    assert(throttle_node);
> +
> +    bs = throttle_node->file->bs;
> +    bdrv_drained_begin(bs);
> +
> +    /* Ref throttle_node's child bs to ensure it won't go away */
> +    bdrv_ref(bs);

Is this really necessary?  bdrv_replace_node() also takes a temporary
reference:

  bdrv_ref(to);
  bdrv_replace_child_noperm(c, to);
  bdrv_unref(from);
