Received: from eggs.gnu.org ([2001:4830:134:3::10]:48605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7KJb-0005VH-B2
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g7KJS-0006du-Sd
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:02:15 -0400
References: <20180823154655.40188-1-vsementsov@virtuozzo.com>
	<20180823154655.40188-2-vsementsov@virtuozzo.com>
	<2a8dda25-67e8-b710-7de3-00f5db68015e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <9479fc3b-124a-9998-267b-b2f96b1643c3@virtuozzo.com>
Date: Tue, 2 Oct 2018 16:01:45 +0300
MIME-Version: 1.0
In-Reply-To: <2a8dda25-67e8-b710-7de3-00f5db68015e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 1/3] qapi: add x-debug-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, famz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com

28.09.2018 19:31, Max Reitz wrote:
> On 23.08.18 17:46, Vladimir Sementsov-Ogievskiy wrote:
>> Add a new command, returning block nodes (and their users) graph.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   qapi/block-core.json           |  91 +++++++++++++++++++++++
>>   include/block/block.h          |   1 +
>>   include/sysemu/block-backend.h |   2 +
>>   block.c                        | 129 +++++++++++++++++++++++++++++++++
>>   block/block-backend.c          |   5 ++
>>   blockdev.c                     |   5 ++
>>   6 files changed, 233 insertions(+)
> The design looks better (that is to say, good) to me, so I mostly have
> technical remarks.  (Only a bit of bike-shedding this time.)
>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 4c7a37afdc..34cdc595d7 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -1629,6 +1629,97 @@
>>   ##
>>   { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo'=
 ] }
>>  =20
>> +##
>> +# @BlockGraphNodeType:
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'enum': 'BlockGraphNodeType',
>> +  'data': [ 'blk', 'job', 'bds' ] }
> I wouldn't use abbreviations here, but the full names.  At least they
> should be described.

Hmm do you have a suggestion? Do you mean something like
 =C2=A0 block-backend
 =C2=A0 block-job
 =C2=A0 block-driver-state
?


>
> (Though with x-debug-, it doesn't matter too much.)
>
>> +
>> +##
>> +# @BlockGraphNode:
>> +#
> I think a description on at least what the name means for each type
> would be useful; and that @id is generated just for this request and not
> some significant value in the block layer.

let me compose here, before sending next version:

@id: Block graph node identifier. This @id is generated only for=20
x-debug-query-block-graph and don't relate to any other identifiers in Qemu=
.
@type: Type of graph node. Can be one of block-backend, block-job or=20
block-driver-state.
@name: Human readable name of the node. Corresponds to node-name for=20
block-driver-state nodes, and not guaranteed to be unique in the whole=20
graph (with block-jobs and block-backends)

>
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'BlockGraphNode',
>> +  'data': { 'id': 'uint64', 'type': 'BlockGraphNodeType', 'name': 'str'=
 } }
>> +
>> +##
>> +# @BlockPermission:
>> +#
>> +# Enum of base block permissions.
>> +#
>> +# @consistent-read: A user that has the "permission" of consistent read=
s is
>> +#                   guaranteed that their view of the contents of the b=
lock
>> +#                   device is complete and self-consistent, representin=
g the
>> +#                   contents of a disk at a specific point.
>> +#                   For most block devices (including their backing fil=
es) this
>> +#                   is true, but the property cannot be maintained in a=
 few
>> +#                   situations like for intermediate nodes of a commit =
block
>> +#                   job.
>> +#
>> +# @write: This permission is required to change the visible disk conten=
ts.
>> +#
>> +# @write-unchanged: This permission (which is weaker than BLK_PERM_WRIT=
E) is
>> +#                   both enough and required for writes to the block no=
de when
>> +#                   the caller promises that the visible disk content d=
oesn't
>> +#                   change.
>> +#                   As the BLK_PERM_WRITE permission is strictly strong=
er,
>> +#                   either is sufficient to perform an unchanging write=
.
>> +#
>> +# @resize: This permission is required to change the size of a block no=
de.
>> +#
>> +# @graph-mod: This permission is required to change the node that this
>> +#             BdrvChild points to.
>> +#
>> +# Since: 3.1
>> +##
>> +  { 'enum': 'BlockPermission',
>> +    'data': [ 'consistent-read', 'write', 'write-unchanged', 'resize',
>> +              'graph-mod' ] }
>> +##
>> +# @BlockGraphEdge:
>> +#
>> +# Block Graph edge description for x-debug-query-block-graph.
>> +#
>> +# @parent: parent id
>> +#
>> +# @child: child id
>> +#
>> +# @name: name of the relation (examples are 'file' and 'backing')
>> +#
>> +# @perm: granted permissions for the parent operating on the child
>> +#
>> +# @shared-perm: permissions that can still be granted to other users of=
 the
>> +#               child while it is still attached this parent
> s/attached this/attached to this/
>
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'BlockGraphEdge',
>> +  'data': { 'parent': 'uint64', 'child': 'uint64',
>> +            'name': 'str', 'perm': [ 'BlockPermission' ],
>> +            'shared-perm': [ 'BlockPermission' ] } }
>> +
>> +##
>> +# @BlockGraph:
>> +#
>> +# Block Graph - list of nodes and list of edges.
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'BlockGraph',
>> +  'data': { 'nodes': ['BlockGraphNode'], 'edges': ['BlockGraphEdge'] } =
}
>> +
>> +##
>> +# @x-debug-query-block-graph:
>> +#
>> +# Get the block graph.
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'command': 'x-debug-query-block-graph', 'returns': 'BlockGraph' }
>> +
>>   ##
>>   # @drive-mirror:
>>   #
> [...]
>
>> diff --git a/block.c b/block.c
>> index 6161dbe3eb..588f5a2648 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4003,6 +4003,135 @@ BlockDeviceInfoList *bdrv_named_nodes_list(Error=
 **errp)
>>       return list;
>>   }
>>  =20
>> +#define QAPI_LIST_ADD(list, element) do { \
>> +    typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \
>> +    _tmp->value =3D (element); \
>> +    _tmp->next =3D (list); \
>> +    list =3D _tmp; \
> Interesting, how yoo put (list) as an rvalue in parentheses, but don't
> do so when it's an lvalue. :-)
>
> I can follow your line of thinking, but it should probably always be in
> parentheses.

agree.

>
>> +} while (0)
>> +
>> +typedef struct BlockGraphConstructor {
>> +    BlockGraph *graph;
>> +    GHashTable *hash;
> Maybe...  "graph_nodes"?  "hash" seems awfully unspecific.

ok

>
>> +} BlockGraphConstructor;
>> +
>> +static BlockGraphConstructor *graph_new(void)
> I think this is a very broad name.  Maybe prefix all of the function
> names with debug_?  (Or dbg_, or dbg_blk, or something)

ok

>
>> +{
>> +    BlockGraphConstructor *gr =3D g_new(BlockGraphConstructor, 1);
>> +
>> +    gr->graph =3D g_new0(BlockGraph, 1);
>> +    gr->hash =3D g_hash_table_new(NULL, NULL);
>> +
>> +    return gr;
>> +}
>> +
>> +static BlockGraph *graph_finalize(BlockGraphConstructor *gr)
>> +{
>> +    g_hash_table_destroy(gr->hash);
>> +
>> +    return gr->graph;
> gr is leaked here.

good catch, will fix.

>
>> +}
>> +
>> +static uint64_t graph_node_num(BlockGraphConstructor *gr, void *node)
>> +{
>> +    uint64_t ret =3D (uint64_t)g_hash_table_lookup(gr->hash, node);
> I'd prefer a cast to uintptr_t.  Otherwise the compiler may warn that
> you cast a pointer to an integer of different size (with -m32).
>
> Storing it in a uint64_t (with an implicit cast then) is OK, though.
> But maybe you do want to store it in a uintptr_t.  The only reason not
> to is because it's a uint64_t in the QAPI schema, but I think it'd be a
> bit cleaner to work with uintptr_t internally and then emit it as
> uint64_t (because that's definitely safe).  It's just a bit more honest
> because this way it's clear that with -m32, we cannot even represent IDs
> larger than 32 bit (which doesn't matter).

ok. then, why not use just "void *" ?

>
>> +
>> +    if (ret > 0) {
> Just for style I'd prefer !=3D over >.  That makes it more clear that thi=
s
> is a NULL check and not a check for errors (represented as negative
> integers, even though @ret is unsigned).

hm and it will be more clear with pointer type...

>
>> +        return ret;
>> +    }
>> +
>> +    ret =3D g_hash_table_size(gr->hash) + 1;
> Maybe add a comment that you add 1 because 0 (NULL) is reserved for
> non-entries?  (Yes, it's clear, or I wouldn't have figured it out, but
> I'd still find it nice.)

hmm, I don't remember why is it reserved, looks like it doesn't matter..=20
But it may be more native to count graph nodes from 1, not from 0.

>
>> +    g_hash_table_insert(gr->hash, node, (void *)ret);
> This definitely needs a uintptr_t cast or you'll get a warning for 32
> bit pointers.
>
>> +
>> +    return ret;
>> +}
>> +
>> +static void graph_add_node(BlockGraphConstructor *gr, void *node,
>> +                           BlockGraphNodeType type, const char *name)
>> +{
>> +    BlockGraphNode *n;
>> +
>> +    n =3D g_new0(BlockGraphNode, 1);
>> +
>> +    n->id =3D graph_node_num(gr, node);
>> +    n->type =3D type;
>> +    n->name =3D g_strdup(name);
>> +
>> +    QAPI_LIST_ADD(gr->graph->nodes, n);
>> +}
>> +
>> +static void graph_add_edge(BlockGraphConstructor *gr, void *parent,
>> +                           const BdrvChild *child)
>> +{
>> +    typedef struct {
>> +        unsigned int flag;
>> +        BlockPermission num;
>> +    } PermissionMap;
>> +
>> +    static PermissionMap permissions[] =3D {
> You can add a const if you like.

yes

>
>> +        { BLK_PERM_CONSISTENT_READ, BLOCK_PERMISSION_CONSISTENT_READ },
>> +        { BLK_PERM_WRITE,           BLOCK_PERMISSION_WRITE },
>> +        { BLK_PERM_WRITE_UNCHANGED, BLOCK_PERMISSION_WRITE_UNCHANGED },
>> +        { BLK_PERM_RESIZE,          BLOCK_PERMISSION_RESIZE },
>> +        { BLK_PERM_GRAPH_MOD,       BLOCK_PERMISSION_GRAPH_MOD },
>> +        { 0, 0 }
>> +    };
> You could add a static assertion that "1 << (sizeof(permissions) /
> sizeof(permissions[0]) - 1) =3D=3D BLK_PERM_ALL + 1" to ensure that whene=
ver
> we add a permission, we don't forget to update this list.  But then
> again, I don't think we're going to add a permission any time soon...

ok.
hmm, we have cheating bdrv_mirror_top_child_perm(), which definitely=20
shows that permission scheme is not complete.. :)

>
>> +    PermissionMap *p;
>> +    BlockGraphEdge *edge;
>> +
>> +    edge =3D g_new0(BlockGraphEdge, 1);
>> +
>> +    edge->parent =3D graph_node_num(gr, parent);
>> +    edge->child =3D graph_node_num(gr, child->bs);
>> +    edge->name =3D g_strdup(child->name);
>> +
>> +    for (p =3D permissions; p->flag; p++) {
>> +        if (p->flag & child->perm) {
>> +            QAPI_LIST_ADD(edge->perm, p->num);
>> +        }
>> +        if (p->flag & child->shared_perm) {
>> +            QAPI_LIST_ADD(edge->shared_perm, p->num);
>> +        }
>> +    }
>> +
>> +    QAPI_LIST_ADD(gr->graph->edges, edge);
>> +}
>> +
>> +
>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>> +{
>> +    BlockBackend *blk;
>> +    BlockJob *job;
>> +    BlockDriverState *bs;
>> +    BdrvChild *child;
>> +    BlockGraphConstructor *gr =3D graph_new();
>> +
>> +    for (blk =3D blk_all_next(NULL); blk; blk =3D blk_all_next(blk)) {
>> +        graph_add_node(gr, blk, BLOCK_GRAPH_NODE_TYPE_BLK, blk_name(blk=
));
> Hm, I think blk_name() is empty for most backends.
> blk_root_get_parent_desc() then falls back to blk_get_attached_dev_id().
>   I think we should do the same here.

ok, good thing. However backup target blk will remain unnamed anyway.

>
> Max
>
>> +        if (blk_root(blk)) {
>> +            graph_add_edge(gr, blk, blk_root(blk));
>> +        }
>> +    }
>> +
>> +    for (job =3D block_job_next(NULL); job; job =3D block_job_next(job)=
) {
>> +        GSList *el;
>> +
>> +        graph_add_node(gr, job, BLOCK_GRAPH_NODE_TYPE_JOB, job->job.id)=
;
>> +        for (el =3D job->nodes; el; el =3D el->next) {
>> +            graph_add_edge(gr, job, (BdrvChild *)el->data);
>> +        }
>> +    }
>> +
>> +    QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
>> +        graph_add_node(gr, bs, BLOCK_GRAPH_NODE_TYPE_BDS, bs->node_name=
);
>> +        QLIST_FOREACH(child, &bs->children, next) {
>> +            graph_add_edge(gr, bs, child);
>> +        }
>> +    }
>> +
>> +    return graph_finalize(gr);
>> +}
>> +
>>   BlockDriverState *bdrv_lookup_bs(const char *device,
>>                                    const char *node_name,
>>                                    Error **errp)


--=20
Best regards,
Vladimir
