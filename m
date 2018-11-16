Received: from eggs.gnu.org ([2001:4830:134:3::10]:40246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNff9-00045x-DV
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNff7-00087d-LU
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:04:03 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
Date: Fri, 16 Nov 2018 16:03:12 +0100
Message-ID: <w51in0xuksv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On Fri 16 Nov 2018 01:14:37 PM CET, Max Reitz wrote:
>>>>> Permission system
>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>
>>>>> GRAPH_MOD
>>>>> ---------
>>>>>
>>>>> We need some way for the commit job to prevent graph changes on its
>>>>> chain while it is running.  Our current blocker doesn=E2=80=99t do th=
e job,
>>>>> however.  What to do?
>>>>>
>>>>> - We have no idea how to make a *permission* work.  Maybe the biggest
>>>>>   problem is that it just doesn=E2=80=99t work as a permission, becau=
se the
>>>>>   commit job doesn=E2=80=99t own the BdrvChildren that would need to =
be
>>>>>   blocked (namely the @backing BdrvChild).
>>>>
>>>> What I'm doing at the moment in my blockdev-reopen series is check
>>>> whether all parents of the node I want to change share the GRAPH_MOD
>>>> permission. If any of them doesn't then the operation fails.
>>>>
>>>> This can be checked by calling bdrv_get_cumulative_perm() or simply
>>>> bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).
>>>
>>> Sure.
>>>
>>>> It solves the problem because e.g. the stream block job only allows
>>>> BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
>>>> modifications allowed.
>>>
>>> But the problem is that the commit job needs to unshare the permission
>>> on all backing links between base and top, so none of the backing
>>> links can be broken.  But it cannot do that because those backing
>>> links do not belong to it (but to the respective overlay nodes).
>>=20
>> I'm not sure if I'm following you. The commit block job has references
>> to all intermediate nodes (with block_job_add_bdrv()) and only shares
>> BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE. Anyone trying to obtain
>> BLK_PERM_GRAPH_MOD on an intermediate node would see that the block job
>> doesn't allow it.
>
> But first of all, why would anyone try to obtain it?  You only obtain
> a permission when you attach a new parent (or when an existing parent
> tries to change the ones it has).

You don't need to obtain it, you only need to see that the permission is
shared (with bdrv_get_cumulative_perm()). Or, as you suggest if I got it
right, attach a new "reopen" parent during bdrv_reopen_prepare() and
release it on commit / abort.

> For instance, in the commit case, if you just remove a backing link,
> then the chain is clearly broken and the graph has been modified, but
> noone will have taken any permission to do so.

If you do what I said in my previous paragraph then you can't remove the
backing link (this is one of my test cases).

> But even beyond that, commit doesn't care about all of the graph.  All
> it cares about are the backing links.  So it should not prevent anyone
> else from changing any links outside of the backing chain (which a
> permission would clearly do).
>
> Let me give a concrete example:
>
> top (T) -> intermediate (I) -> base (B)
>
> Now you commit from top to base.  Clearly you don't want the backing
> chain between top and base to change.  So say you unshare the GRAPH_MOD
> permission (implying that whenever a parent doesn't care, it just shares
> it).  But as said above, if someone just drops the backing link from I
> to B, the permission system won't catch that.

Yes it will, because the block job (either mirror or commit depending on
the case) is the parent of all three nodes (BlockJob.nodes is where the
list is stored) and does not alow GRAPH_MOD in any of them[*]. So
dropping that backing link fails (I also have a test case for that).

> The next thing is that how would you even try to catch it in the first
> place?  The normal case would be for everything to both share and
> claim the GRAPH_MOD permission, the latter so it can see if something
> unshared it.  But that would mean that everything is holding that
> permission all the time and it's impossible to unshare it.

As things are now, GRAPH_MOD is shared by default on backing files
(bdrv_format_default_perms()), but I don't understand why you need that
everything takes GRAPH_MOD, you only need it when you're actually
planning to change the graph (e.g a block job).

> So the solution might be to take it first, and release it after having
> attached the child.  And maybe you'd say that for the removal case,
> you'd have to take the GRAPH_MOD permission before you remove any
> child.

Yes, something like that.

> But I think that's weird, and also, there's another issue still.
>
> What if you try to attach a read-only NBD server to B?  That should be
> OK in my mind.  But it is a graph change, so it wouldn't be allowed if
> GRAPH_MOD is a permission, even though commit doesn't care at all.

I haven't examined that case (I'm not familiar with NBD), but if the
only problem is that the permission system is unnecessarily strict in
certain corner cases then maybe it's reasonable compromise _if_ there's
no simpler alternative (I'm not saying that there isn't!).

> I don't think anything needs a way to generally block graph changes
> around some node.  We only need to prevent changes to very specific
> sets of edges.  This is something that the permission system just
> cannot do.

But what would you do then?

>>>>>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=
=80=9D or
>>>>>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed t=
o mean.
>>>>>   Figuring that out always took like half an our in any
>>>>>   face-to-face meeting, and then we decided it was pretty much
>>>>>   useless for any case we had at hand.)
>>>>
>>>> Yeah it's a bit unclear. It can mean "none of this node's children
>>>> can be replaced / removed", which is what I'm using it for at the
>>>> moment.
>>>
>>> Yes, but that's just not useful.  I don't think we have any case where
>>> something would be annoyed by having its immediate child replaced
>>> (other than the visible data changing, potentially).  Usually when we
>>> say something (e.g. a block job) wants to prevent graph modification,
>>> it's about changing edges that exist independently of the job (such as
>>> a backing chain).
>>=20
>> Isn't that what I just said? You cannot change other edges <=3D> you
>> cannot replace a node's children (or parents).
>
> Hm, true, but I think it's (1) hard to understand, (2) would require
> non-trivial changes to the current model anyway (take GRAPH_MOD before
> any modification, release it afterwards (which is quite different from
> any other permission anyway)), and (3) would be too restrictive.

I don't understand (2), block-stream is already doing that (takes
GRAPH_MOD when you create the block job, releases when the job is
completed).

Berto
