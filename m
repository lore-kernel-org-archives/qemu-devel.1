Received: from eggs.gnu.org ([2001:4830:134:3::10]:59266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk7gL-00050x-Jo
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dk7gI-0005G4-H7
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:49:17 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170809140256.25584-5-el13635@mail.ntua.gr>
References: <20170809140256.25584-1-el13635@mail.ntua.gr>
	<20170809140256.25584-5-el13635@mail.ntua.gr>
Date: Tue, 22 Aug 2017 13:49:12 +0200
Message-ID: <w5160dfhlfr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 4/6] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Wed 09 Aug 2017 04:02:54 PM CEST, Manos Pitsidianakis wrote:
> +void blk_io_limits_update_group(BlockBackend *blk, const char *group, Error **errp)
>  {
> +    ThrottleGroupMember *tgm;
> +
>      /* this BB is not part of any group */
> -    if (!blk->public.throttle_group_member.throttle_state) {
> +    if (!blk->public.throttle_node) {
>          return;
>      }
>  
> +    tgm = throttle_get_tgm(blk->public.throttle_node);
>      /* this BB is a part of the same group than the one we want */
> -    if (!g_strcmp0(throttle_group_get_name(&blk->public.throttle_group_member),
> -                group)) {
> +    if (!g_strcmp0(throttle_group_get_name(tgm),
> +                   group)) {

You can join these two lines, no need to have 'group' in its own line.

> @@ -2629,6 +2636,9 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>      BlockDriverState *bs;
>      BlockBackend *blk;
>      AioContext *aio_context;
> +    BlockDriverState *throttle_node = NULL;
> +    ThrottleGroupMember *tgm;
> +    Error *local_err = NULL;
>  
>      blk = qmp_get_blk(arg->has_device ? arg->device : NULL,
>                        arg->has_id ? arg->id : NULL,
> @@ -2704,18 +2714,33 @@ void qmp_block_set_io_throttle(BlockIOThrottle *arg, Error **errp)
>      if (throttle_enabled(&cfg)) {
>          /* Enable I/O limits if they're not enabled yet, otherwise
>           * just update the throttling group. */
> -        if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
> -            blk_io_limits_enable(blk,
> -                                 arg->has_group ? arg->group :
> -                                 arg->has_device ? arg->device :
> -                                 arg->id);
> -        } else if (arg->has_group) {
> -            blk_io_limits_update_group(blk, arg->group);
> +        if (!blk_get_public(blk)->throttle_node) {
> +            blk_io_limits_enable(blk, arg->has_group ? arg->group :
> +                                 arg->has_device ? arg->device : arg->id,
> +                                 &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                goto out;
> +            }
>          }
> -        /* Set the new throttling configuration */
> -        blk_set_io_limits(blk, &cfg);
> -    } else if (blk_get_public(blk)->throttle_group_member.throttle_state) {
> -        /* If all throttling settings are set to 0, disable I/O limits */
> +
> +        if (arg->has_group) {
> +            /* move throttle node membership to arg->group */
> +            blk_io_limits_update_group(blk, arg->group, &local_err);
> +            if (local_err) {
> +                error_propagate(errp, local_err);
> +                goto out;
> +            }
> +        }

This used to be

   if (!blk_get_public(blk)->throttle_group_member.throttle_state) {
      /* Enable throttling */
   } else if (arg->has_group) {
      /* Update group */
   }

but now it is

   if (!blk_get_throttle_node(blk)) {
      /* Enable throttling */
   }
   if (arg->has_group) {
      /* Update group */
   }

Now if I/O limits are not set then the code sets the same group twice.

Everything else looks fine.

Berto
