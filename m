Received: from eggs.gnu.org ([2001:4830:134:3::10]:54245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frh3F-0006Li-HU
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1frh37-00084F-Jz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 06:04:43 -0400
References: <1b072083-700b-9853-e525-e2726bf17476@virtuozzo.com>
	<20180817180440.49687-1-vsementsov@virtuozzo.com>
	<4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0450b9f6-a19d-665e-ee27-ee9ad739d81b@virtuozzo.com>
Date: Mon, 20 Aug 2018 13:03:13 +0300
MIME-Version: 1.0
In-Reply-To: <4d266435-855b-7900-0ad0-d677a568ebf7@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, famz@redhat.com, jsnow@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

17.08.2018 23:32, Eric Blake wrote:
> On 08/17/2018 01:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>> Add a new command, returning block nodes graph.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0 | 116=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++++
>
>> +##
>> +# @BlockGraphEdge:
>> +#
>> +# Block Graph edge description for x-query-block-graph.
>> +#
>> +# @parent: parent id
>> +#
>> +# @child: child id
>> +#
>> +# @name: name of the relation (examples are 'file' and 'backing')
>
> Can this be made into a QAPI enum? (It would have ripple effects to=20
> existing code, but might be a worthwhile cleanup).

I thought about it, but there no corresponding enum in Qemu too, so it's=20
like driver name in query-block.. However, I can
create a function which will map &role pointer to corresponding qapi=20
enum element, which will need to be updated when new
roles created. Not sure that it's better.

>
>> +#
>> +# @perm: granted permissions for the parent operating on the child
>> +#
>> +# @shared-perm: permissions that can still be granted to other users=20
>> of the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 child while it is still attached this parent
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'struct': 'BlockGraphEdge',
>> +=C2=A0 'data': { 'parent': 'uint64', 'child': 'uint64',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'nam=
e': 'str', 'perm': [ 'BlockPermission' ],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'sha=
red-perm': [ 'BlockPermission' ] } }
>> +
>
>> +##
>> +# @x-query-block-graph:
>> +#
>> +# Get the block graph.
>> +#
>> +# Since: 3.1
>> +##
>> +{ 'command': 'x-query-block-graph', 'returns': 'BlockGraph' }
>
> Why is this command given an x- prefix?=C2=A0 What would it take to promo=
te=20
> it from experimental to fully supported?

Hmm, just a new command, used mostly for debugging. I don't have any=20
special plans on improving it, I'm ok to drop x- prefix.

>
> Overall, the command looks quite useful; and the fact that you=20
> produced some nice .dot graphs from it for visualization seems like it=20
> is worth considering this as a permanent API addition. The question,=20
> then, is if the interface is right, or if it needs any tweaks (like=20
> using an enum instead of open-coded string for the relation between=20
> parent and child), as a reason for keeping the x- prefix.

Yes, we should decide about enum.. If we want a qapi enum, how to mirror=20
it in internal qemu structures better? Only by mapping function (ptr ->=20
enum-element), or may be add field of EnumType entirely into the role=20
structure?

>
>> +++ b/block.c
>> @@ -4003,6 +4003,86 @@ BlockDeviceInfoList=20
>> *bdrv_named_nodes_list(Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return list;
>> =C2=A0 }
>> =C2=A0 +#define QAPI_LIST_ADD(list, element) do { \
>> +=C2=A0=C2=A0=C2=A0 typeof(list) _tmp =3D g_new(typeof(*(list)), 1); \
>> +=C2=A0=C2=A0=C2=A0 _tmp->value =3D (element); \
>> +=C2=A0=C2=A0=C2=A0 _tmp->next =3D (list); \
>> +=C2=A0=C2=A0=C2=A0 list =3D _tmp; \
>> +} while (0)
>
> Hmm - this seems like a frequently observed pattern - should it be=20
> something that we add independently and use throughout the tree as=20
> part of QAPI interactions in general?

Agree.

>
>> +
>> +BlockGraph *bdrv_get_block_graph(Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BlockGraph *graph =3D g_new0(BlockGraph, 1);
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *child;
>> +=C2=A0=C2=A0=C2=A0 BlockGraphNode *node;
>> +=C2=A0=C2=A0=C2=A0 BlockGraphEdge *edge;
>> +=C2=A0=C2=A0=C2=A0 struct {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int flag;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockPermission num;
>> +=C2=A0=C2=A0=C2=A0 } permissions[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_CONSISTENT_READ, =
BLOCK_PERMISSION_CONSISTENT_READ },
>
> Would it be worth directly reusing a QAPI enum for all such=20
> permissions in the existing code base, instead of having to map=20
> between an internal and a QAPI enum?

Internal is not enum, they are flags.. How can we use enum instead? Or I=20
don't understand what you mean..

>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE, BLOCK_PERM=
ISSION_WRITE },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_WRITE_UNCHANGED, =
BLOCK_PERMISSION_WRITE_UNCHANGED },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_RESIZE,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_RESIZE },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { BLK_PERM_GRAPH_MOD,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BLOCK_PERMISSION_GRAPH_MOD },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0, 0 }
>> +=C2=A0=C2=A0=C2=A0 }, *p;
>> +
>> +=C2=A0=C2=A0=C2=A0 QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(child, &bs->pa=
rents, next_parent) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!child->role->parent_is_bds) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BlockGraphNodeList *el;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bool add =3D true;
>
> Does your command need/want to expose internal nodes? (I argue that it=20
> probably should show internal nodes, even when normal 'query-block'=20
> doesn't, just because knowing about the impact of internal nodes can=20
> be important when tracking down permissions issues).
>

Yes, I'm for viewing maximum number of nodes.. However my code goes=20
through graph_bdrv_stats, query-named-block-nodes do the same.. Isn't it=20
the whole set of nodes? All named... But, as I understand, now all nodes=20
are named?

--=20
Best regards,
Vladimir
