Received: from eggs.gnu.org ([2001:4830:134:3::10]:35907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxzT1-0004hB-BR
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dxzT0-0007gw-4w
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:52:51 -0400
Date: Fri, 29 Sep 2017 19:52:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170929175235.GF3812@localhost.localdomain>
References: <20170815074513.9055-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815074513.9055-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH RFC] block: add block-insert-node QMP
 command
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <qemu-devel.nongnu.org>

Am 15.08.2017 um 09:45 hat Manos Pitsidianakis geschrieben:
> block-insert-node and its pair command block-remove-node provide runtime
> insertion and removal of filter nodes.
> 
> block-insert-node takes a (parent, child) and (node, child) pair of
> edges and unrefs the (parent, child) BdrvChild relationship and creates
> a new (parent, node) child with the same BdrvChildRole.
> 
> This is a different approach than x-blockdev-change which uses the driver
> methods bdrv_add_child() and bdrv_del_child(),
> 
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4d6ba1baef..16e19cb648 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3947,3 +3947,63 @@
>    'data' : { 'parent': 'str',
>               '*child': 'str',
>               '*node': 'str' } }
> +
> +##
> +# @block-insert-node:
> +#
> +# Insert a filter node between a specific edge in the block driver state graph.
> +# @parent:  the name of the parent node or device
> +# @node:    the name of the node to insert under parent
> +# @child:   the name of the child of both node and parent
> +#
> +# Example:
> +# Insert and remove a throttle filter on top of a device chain, between the
> +# device 'ide0-hd0' and node 'node-A'
> +#
> +# -> {'execute': 'object-add',
> +#     "arguments": {
> +#       "qom-type": "throttle-group",
> +#       "id": "group0",
> +#       "props" : { "limits": { "iops-total": 300 } }
> +#     }
> +#    }
> +# <- { 'return': {} }
> +# -> {'execute': 'blockdev-add',
> +#       'arguments': {
> +#           'driver': 'throttle',
> +#           'node-name': 'throttle0',
> +#           'throttle-group': 'group0',
> +#           'file': 'node-A'
> +#       }
> +#    }
> +# <- { 'return': {} }
> +# -> { 'execute': 'block-insert-node',
> +#       'arguments': { 'parent': 'ide0-hd0', 'child': 'node-A', 'node': 'throttle0' }
> +#    }
> +# <- { 'return': {} }
> +# -> { 'execute': 'block-remove-node',
> +#       'arguments': { 'parent': 'ide0-hd0', 'child': 'node-A', 'node': 'throttle0' }
> +#    }
> +# <- { 'return': {} }
> +# -> { 'execute': 'blockdev-del',
> +#       'arguments': { 'node-name': 'throttle0' }
> +#    }
> +# <- { 'return': {} }
> +#
> +##
> +{ 'command': 'block-insert-node',
> +  'data': { 'parent': 'str',
> +             'child': 'str',
> +             'node': 'str'} }

I would suggest a change to the meaning of @child: Instead of using the
node-name of the child BDS, I would use the name of the BdrvChild that
represents the link.

The reason for this is that the node-name could be ambiguous, if you
have two edges between the same two nodes.

The only use of the node-name of the child that I can remember was for
checking that the graph still looks like what the user expects. But I
think we came to the conclusion that there are no race conditions to
check for if we have manual block job deletion instead of automatic
completion which can involve surprise changes to the graph. So probably
we don't need the node-name even for this.

> +##
> +# @block-remove-node:
> +#
> +# Remove a filter node between two other nodes in the block driver state graph.
> +# @parent:  the name of the parent node or device
> +# @node:    the name of the node to remove from parent
> +# @child:   the name of the child of node which will go under parent
> +##
> +{ 'command': 'block-remove-node',
> +  'data': { 'parent': 'str',
> +             'child': 'str',
> +             'node': 'str'} }

Same thing here.

> diff --git a/block.c b/block.c
> index 81bd51b670..f874aabbfb 100644
> --- a/block.c
> +++ b/block.c
> +    /* insert 'node' as child bs of 'parent' node */
> +    if (check_node_edge(parent, child, errp)) {
> +        return;
> +    }
> +    parent_bs = bdrv_find_node(parent);
> +    c = bdrv_find_child(parent_bs, child);
> +    role = c->role;
> +    assert(role == &child_file || role == &child_backing);
> +
> +    bdrv_ref(node_bs);
> +
> +    bdrv_drained_begin(parent_bs);
> +    bdrv_unref_child(parent_bs, c);
> +    if (role == &child_file) {
> +        parent_bs->file = bdrv_attach_child(parent_bs, node_bs, "file",
> +                                            &child_file, errp);
> +        if (!parent_bs->file) {
> +            parent_bs->file = bdrv_attach_child(parent_bs, child_bs, "file",
> +                                                &child_file, &error_abort);
> +            goto out;
> +        }
> +    } else if (role == &child_backing) {
> +        parent_bs->backing = bdrv_attach_child(parent_bs, node_bs, "backing",
> +                                               &child_backing, errp);
> +        if (!parent_bs->backing) {
> +            parent_bs->backing = bdrv_attach_child(parent_bs, child_bs,
> +                                                   "backing", &child_backing,
> +                                                   &error_abort);
> +            goto out;
> +        }
> +    }

I would prefer if we could find a solution to avoid requiring a specific
role. I'm not even sure that your assertion above is correct; can you
explain why c couldn't have any other role?

Instead of bdrv_unref_child/bdrv_attach_child, could we just change
where the child points to using bdrv_replace_child()? Then
parent_bs->file and parent_bs->backing (or whatever other variable
contains the BdrvChild pointer) can stay unchanged and just keep
working.

> +    bdrv_refresh_filename(parent_bs);
> +    bdrv_refresh_limits(parent_bs, NULL);
> +
> +out:
> +    bdrv_drained_end(parent_bs);
> +}

> diff --git a/blockdev.c b/blockdev.c
> index 8e2fc6e64c..5195ec1b61 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -4238,3 +4238,47 @@ QemuOptsList qemu_drive_opts = {
>          { /* end of list */ }
>      },
>  };
> +
> +void qmp_block_insert_node(const char *parent, const char *child,
> +                           const char *node, Error **errp)
> +{
> +    BlockDriverState *bs = bdrv_find_node(node);
> +    if (!bs) {
> +        error_setg(errp, "Node '%s' not found", node);
> +        return;
> +    }
> +    if (!bs->monitor_list.tqe_prev) {
> +        error_setg(errp, "Node '%s' is not owned by the monitor",
> +                   bs->node_name);
> +        return;
> +    }
> +    if (!bs->drv->is_filter) {
> +        error_setg(errp, "Block format '%s' used by node '%s' does not support"
> +                   "insertion", bs->drv->format_name, bs->node_name);
> +        return;
> +    }
> +
> +    bdrv_insert_node(parent, child, node, errp);
> +}

Do we need to acquire an AioContext lock somewhere?

Kevin
