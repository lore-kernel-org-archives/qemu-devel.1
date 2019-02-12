Received: from eggs.gnu.org ([209.51.188.92]:35713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtb2S-0005OV-5f
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:36:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gtauq-0003Yw-RU
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 11:28:13 -0500
Date: Tue, 12 Feb 2019 17:28:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190212162806.GF5283@localhost.localdomain>
References: <cover.1547739122.git.berto@igalia.com>
	<f112a3019e4e1dfc2de6c275edadb5fc3a58ade0.1547739122.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f112a3019e4e1dfc2de6c275edadb5fc3a58ade0.1547739122.git.berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH 06/13] block: Handle child references in
 bdrv_reopen_queue()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.01.2019 um 16:33 hat Alberto Garcia geschrieben:
> Children in QMP are specified with BlockdevRef / BlockdevRefOrNull,
> which can contain a set of child options, a child reference, or
> NULL. In optional attributes like "backing" it can also be missing.
> 
> Only the first case (set of child options) is being handled properly
> by bdrv_reopen_queue(). This patch deals with all the others.
> 
> Here's how these cases should be handled when bdrv_reopen_queue() is
> deciding what to do with each child of a BlockDriverState:
> 
>    1) Set of child options: the options are removed from the parent's
>       options QDict and are passed to the child with a recursive
>       bdrv_reopen_queue() call. This case was already working fine.

Small addition: This is only allowed if the child was implicitly created
(i.e. it inherits from the parent we're coming from).

>    2) Child reference: there's two possibilites here.
> 
>       2a) Reference to the current child: the child is put in the
>           reopen queue, keeping its current set of options (since this
>           was a child reference there was no way to specify a
>           different set of options).

Why even put it in the reopen queue when nothing is going to change?

Ah, it's because inherited options might change, right?

But if the child did not inherit from this parent, we don't need to put
it into the queue anyway. The operation should still be allowed.

>       2b) Reference to a different BDS: the current child is not put
>           in the reopen queue at all. Passing a reference to a
>           different BDS can be used to replace a child, although at
>           the moment no driver implements this, so it results in an
>           error. In any case, the current child is not going to be
>           reopened (and might in fact disappear if it's replaced)

Do we need to break a possible inheritance relationship between the
parent and the old child node in this case?

>    3) NULL: This is similar to (2b). Although no driver allows this
>       yet it can be used to detach the current child so it should not
>       be put in the reopen queue.

Same comment as for 2b.

>    4) Missing option: at the moment "backing" is the only case where
>       this can happen. With "blockdev-add", leaving "backing" out
>       means that the default backing file is opened. We don't want to
>       open a new image during reopen, so we require that "backing" is
>       always present. We'll relax this requirement a bit in the next
>       patch.

I think this is only for keep_old_opts == false; otherwise it should be
treated the same as 2a to avoid breaking compatibility.

> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c               | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
>  include/block/block.h |  1 +
>  2 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/block.c b/block.c
> index 056a620eb2..fd51f1cd35 100644
> --- a/block.c
> +++ b/block.c
> @@ -3032,9 +3032,21 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>      bs_entry->state.perm = UINT64_MAX;
>      bs_entry->state.shared_perm = 0;
>  
> +    /*
> +     * If keep_old_opts is false then it means that unspecified
> +     * options must be reset to its original value. We don't allow

s/its/their/

> +     * resetting 'backing' but we need to know if the option is
> +     * missing in order to decide if we have to return an error.
> +     */
> +    if (!keep_old_opts) {
> +        bs_entry->state.backing_missing =
> +            !qdict_haskey(options, "backing") &&
> +            !qdict_haskey(options, "backing.driver");
> +    }
> +
>      QLIST_FOREACH(child, &bs->children, next) {
> -        QDict *new_child_options;
> -        char *child_key_dot;
> +        QDict *new_child_options = NULL;
> +        bool child_keep_old = keep_old_opts;
>  
>          /* reopen can only change the options of block devices that were
>           * implicitly created and inherited options. For other (referenced)
> @@ -3043,13 +3055,31 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
>              continue;
>          }

The 'continue' in the context just skipped any children that don't
inherit from this parent. Child options for those will stay unmodified
in the options dict.

For case 1, we'll later get an error because keys like 'child.foo' will
still be present and can't be processed by the driver. Implements
exactly what I commented above.

For case 2, the child isn't put in the reopen queue, and the child
reference can be used later. Matches my comment as well.

Good.

> -        child_key_dot = g_strdup_printf("%s.", child->name);
> -        qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
> -        qdict_extract_subqdict(options, &new_child_options, child_key_dot);
> -        g_free(child_key_dot);
> +        /* Check if the options contain a child reference */
> +        if (qdict_haskey(options, child->name)) {
> +            const char *childref = qdict_get_try_str(options, child->name);
> +            /*
> +             * The current child must not be reopened if the child
> +             * reference does not point to it.
> +             */
> +            if (g_strcmp0(childref, child->bs->node_name)) {

This is where we would break the inheritance relationship.

Is this the code path that a QNull should take as well? (case 3)

> +                continue;
> +            }
> +            /*
> +             * If the child reference points to the current child then
> +             * reopen it with its existing set of options.

Mention option inheritance here as the reason why to even bother to
reopen a child with unchanged options?

> +             */
> +            child_keep_old = true;
> +        } else {
> +            /* Extract child options ("child-name.*") */
> +            char *child_key_dot = g_strdup_printf("%s.", child->name);
> +            qdict_extract_subqdict(explicit_options, NULL, child_key_dot);
> +            qdict_extract_subqdict(options, &new_child_options, child_key_dot);
> +            g_free(child_key_dot);
> +        }
>  
>          bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
> -                                child->role, options, flags, keep_old_opts);
> +                                child->role, options, flags, child_keep_old);
>      }
>  
>      return bs_queue;
> @@ -3306,6 +3336,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
>  
>      drv_prepared = true;
>  
> +    if (reopen_state->backing_missing) {
> +        error_setg(errp, "backing is missing for '%s'",
> +                   reopen_state->bs->node_name);
> +        ret = -EINVAL;
> +        goto error;
> +    }

What about drivers that don't even support backing files?

>      /* Options that are not handled are only okay if they are unchanged
>       * compared to the old state. It is expected that some options are only
>       * used for the initial open, but not reopen (e.g. filename) */

Kevin
