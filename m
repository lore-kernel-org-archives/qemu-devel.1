Received: from eggs.gnu.org ([2001:4830:134:3::10]:60713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frhIi-0007qM-2l
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frhIh-000838-2C
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:20:44 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
	<f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8ce95ada-2162-d22f-6925-a97309d8c48a@virtuozzo.com>
Date: Mon, 20 Aug 2018 13:20:29 +0300
MIME-Version: 1.0
In-Reply-To: <f4f935d2-cb37-b63b-5060-f15cb43becbd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: add x-query-block-graph
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

18.08.2018 00:03, Max Reitz wrote:
> On 2018-08-17 22:32, Eric Blake wrote:
>> On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add a new command, returning block nodes graph.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>>  =C2=A0 qapi/block-core.json=C2=A0 | 116
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>>> +##
>>> +# @BlockGraphEdge:
>>> +#
>>> +# Block Graph edge description for x-query-block-graph.
>>> +#
>>> +# @parent: parent id
>>> +#
>>> +# @child: child id
>>> +#
>>> +# @name: name of the relation (examples are 'file' and 'backing')
>> Can this be made into a QAPI enum? (It would have ripple effects to
>> existing code, but might be a worthwhile cleanup).
>>
>>> +#
>>> +# @perm: granted permissions for the parent operating on the child
>>> +#
>>> +# @shared-perm: permissions that can still be granted to other users
>>> of the
>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 child while it is still attached this parent
>>> +#
>>> +# Since: 3.1
>>> +##
>>> +{ 'struct': 'BlockGraphEdge',
>>> +=C2=A0 'data': { 'parent': 'uint64', 'child': 'uint64',
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'na=
me': 'str', 'perm': [ 'BlockPermission' ],
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'sh=
ared-perm': [ 'BlockPermission' ] } }
>>> +
>>> +##
>>> +# @x-query-block-graph:
>>> +#
>>> +# Get the block graph.
>>> +#
>>> +# Since: 3.1
>>> +##
>>> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
>> Why is this command given an x- prefix?=C2=A0 What would it take to prom=
ote
>> it from experimental to fully supported?
> This is just a very bad reasons, but I'll give it anyway: We really want
> such a command but still don't have one.  So I doubt this is exactly
> what we want. :-)
>
> A better reason is that we probably do not want a single command to
> return the whole block graph.  Do we want the command to just return
> info for a single node, including just the node names of the children?
> Do we want the command to include child info on request (but start from
> a user-specified root)?
>
> Also, the interface is...  Er, weird?  Honestly, I don't quite see why
> we would want it like this without x-.
>
> Why use newly generated IDs instead of node names?  Why are those RAM
> addresses?  That is just so fishy.
>
> Because parents can be non-nodes?  Well, I suppose you better not
> include them in the graph like this, then.
>
> I don't see why the query command we want would include non-BDSs at all.
>
> It may be useful for debugging, so, er, well, with an x-debug- prefix,
> OK.  But the question then is whether it's useful enough to warrant
> having a separate query command that isn't precisely the command we want
> anyway.


>
> The first question we probably have to ask is whether the query command
> needs to output parent information.  If not, querying would probably
> start at some named node and then you'd go down from there (either with
> many queries or through a single one).
>
> If so, well, then we can still output parent information, but I'd say
> that then is purely informational and we don't need to "generate" new
> IDs for them.  Just have either a node-name there or a user-readable
> description (like it was in v1; although it has to be noted that such a
> user-readable description is useless to a management layer), but these
> new IDs are really not something I like.
>
>> Overall, the command looks quite useful; and the fact that you produced
>> some nice .dot graphs from it for visualization seems like it is worth
>> considering this as a permanent API addition.=C2=A0 The question, then, =
is if
>> the interface is right, or if it needs any tweaks (like using an enum
>> instead of open-coded string for the relation between parent and child),
>> as a reason for keeping the x- prefix.
> You can use x-debug- even when you decide to keep a command.
>
> I see no reason why a command should hastily not get an x- prefix just
> because it may be useful enough.  If it really is and we really see the
> interface is good (which I really don't think it is), then we can always
> drop it later.
>
> Max
>
>>> +++ b/block.c
>>> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList
>>> *bdrv_named_nodes_list(Error **errp)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return list;
>>>  =C2=A0 }
>>>  =C2=A0 +#define QAPI_LIST_ADD(list, element) do { \
>>> +=C2=A0=C2=A0=C2=A0 typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \
>>> +=C2=A0=C2=A0=C2=A0 _tmp->value =3D (element); \
>>> +=C2=A0=C2=A0=C2=A0 _tmp->next =3D (list); \
>>> +=C2=A0=C2=A0=C2=A0 list =3D _tmp; \
>>> +} while (0)
>> Hmm - this seems like a frequently observed pattern - should it be
>> something that we add independently and use throughout the tree as part
>> of QAPI interactions in general?
>>
>>> +
>>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BlockGraph *graph =3D g_new0(BlockGraph, 1);
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>>> +=C2=A0=C2=A0=C2=A0 BlockGraphNode *node;
>>> +=C2=A0=C2=A0=C2=A0 BlockGraphEdge *edge;
>>> +=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flag;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockPermission num;
>>> +=C2=A0=C2=A0=C2=A0 } permissions[] =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_CONSISTENT_READ,=
 BLOCK_PERMISSION_CONSISTENT_READ },
>> Would it be worth directly reusing a QAPI enum for all such permissions
>> in the existing code base, instead of having to map between an internal
>> and a QAPI enum?
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_WRITE =
},
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE_UNCHANGED,=
 BLOCK_PERMISSION_WRITE_UNCHANGED },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_RESIZE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_RESIZE },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_GRAPH_MOD,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_GRAPH_MOD },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0 }
>>> +=C2=A0=C2=A0=C2=A0 }, *p;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs->p=
arents, next_parent) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
(!child->role->parent_is_bds) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BlockGraphNodeList *el;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool add =3D true;
>> Does your command need/want to expose internal nodes? (I argue that it
>> probably should show internal nodes, even when normal 'query-block'
>> doesn't, just because knowing about the impact of internal nodes can be
>> important when tracking down permissions issues).
> You could make it a flag, but in theory, implicit nodes should never be
> visible through QMP.  (Though if you explicitly request them, that's
> probably a different story.)
>
> Max
>

My goal is to get graphviz representation of block graph with all the=20
parents for debugging. And I'm absolutely ok to do it with x-debug-.=20
Then we shouldn't care about enum for role type now. So, it the patch ok=20
for you with x-debug- prefix?

--=20
Best regards,
Vladimir
