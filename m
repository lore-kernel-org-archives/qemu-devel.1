Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqlPt-00010W-Lz
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqlPq-0002at-Jx
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 16:32:15 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
Date: Fri, 17 Aug 2018 15:32:01 -0500
MIME-Version: 1.0
In-Reply-To: <20180817180440.49687-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.comMarkus Armbruster <armbru@redhat.com>

On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
> Add a new command, returning block nodes graph.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>   qapi/block-core.json  | 116 ++++++++++++++++++++++++++++++++++++++++++++++++++

> +##
> +# @BlockGraphEdge:
> +#
> +# Block Graph edge description for x-query-block-graph.
> +#
> +# @parent: parent id
> +#
> +# @child: child id
> +#
> +# @name: name of the relation (examples are 'file' and 'backing')

Can this be made into a QAPI enum? (It would have ripple effects to 
existing code, but might be a worthwhile cleanup).

> +#
> +# @perm: granted permissions for the parent operating on the child
> +#
> +# @shared-perm: permissions that can still be granted to other users of the
> +#               child while it is still attached this parent
> +#
> +# Since: 3.1
> +##
> +{ 'struct': 'BlockGraphEdge',
> +  'data': { 'parent': 'uint64', 'child': 'uint64',
> +            'name': 'str', 'perm': [ 'BlockPermission' ],
> +            'shared-perm': [ 'BlockPermission' ] } }
> +

> +##
> +# @x-query-block-graph:
> +#
> +# Get the block graph.
> +#
> +# Since: 3.1
> +##
> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }

Why is this command given an x- prefix?  What would it take to promote 
it from experimental to fully supported?

Overall, the command looks quite useful; and the fact that you produced 
some nice .dot graphs from it for visualization seems like it is worth 
considering this as a permanent API addition.  The question, then, is if 
the interface is right, or if it needs any tweaks (like using an enum 
instead of open-coded string for the relation between parent and child), 
as a reason for keeping the x- prefix.

> +++ b/block.c
> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error **errp)
>       return list;
>   }
>   
> +#define QAPI_LIST_ADD(list, element) do { \
> +    typeof(list) _tmp = g_new(typeof(*(list)), 1); \
> +    _tmp->value = (element); \
> +    _tmp->next = (list); \
> +    list = _tmp; \
> +} while (0)

Hmm - this seems like a frequently observed pattern - should it be 
something that we add independently and use throughout the tree as part 
of QAPI interactions in general?

> +
> +BlockGraph *bdrv_get_block_graph(Error **errp)
> +{
> +    BlockGraph *graph = g_new0(BlockGraph, 1);
> +    BlockDriverState *bs;
> +    BdrvChild *child;
> +    BlockGraphNode *node;
> +    BlockGraphEdge *edge;
> +    struct {
> +        unsigned int flag;
> +        BlockPermission num;
> +    } permissions[] = {
> +        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },

Would it be worth directly reusing a QAPI enum for all such permissions 
in the existing code base, instead of having to map between an internal 
and a QAPI enum?

> +        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
> +        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
> +        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
> +        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
> +        { 0, 0 }
> +    }, *p;
> +
> +    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
> +        QLIST_FOREACH(child, &bs->parents, next_parent) {
> +            if (!child->role->parent_is_bds) {
> +                BlockGraphNodeList *el;
> +                bool add = true;

Does your command need/want to expose internal nodes? (I argue that it 
probably should show internal nodes, even when normal 'query-block' 
doesn't, just because knowing about the impact of internal nodes can be 
important when tracking down permissions issues).

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
