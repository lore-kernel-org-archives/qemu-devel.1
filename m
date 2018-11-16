Received: from eggs.gnu.org ([2001:4830:134:3::10]:43937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNfua-00036E-Io
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNfuZ-0007sV-6e
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:20:00 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
	<2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
	<w51in0xuksv.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <47c24046-63e2-c148-6d9d-86b82ced4e6d@redhat.com>
Date: Fri, 16 Nov 2018 16:19:30 +0100
MIME-Version: 1.0
In-Reply-To: <w51in0xuksv.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="I5Fu4WXwztsLJVOmhmKWVJxlSb5PFz5lZ"
Subject: Re: [Qemu-devel] KVM Forum block no[td]es
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5Fu4WXwztsLJVOmhmKWVJxlSb5PFz5lZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <47c24046-63e2-c148-6d9d-86b82ced4e6d@redhat.com>
Subject: Re: KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <w511s7p9fkk.fsf@maestria.local.igalia.com>
 <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
 <w51efbmh0tp.fsf@maestria.local.igalia.com>
 <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
 <w51in0xuksv.fsf@maestria.local.igalia.com>
In-Reply-To: <w51in0xuksv.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.11.18 16:03, Alberto Garcia wrote:
> On Fri 16 Nov 2018 01:14:37 PM CET, Max Reitz wrote:
>>>>>> Permission system
>>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>>>
>>>>>> GRAPH_MOD
>>>>>> ---------
>>>>>>
>>>>>> We need some way for the commit job to prevent graph changes on it=
s
>>>>>> chain while it is running.  Our current blocker doesn=E2=80=99t do=
 the job,
>>>>>> however.  What to do?
>>>>>>
>>>>>> - We have no idea how to make a *permission* work.  Maybe the bigg=
est
>>>>>>   problem is that it just doesn=E2=80=99t work as a permission, be=
cause the
>>>>>>   commit job doesn=E2=80=99t own the BdrvChildren that would need =
to be
>>>>>>   blocked (namely the @backing BdrvChild).
>>>>>
>>>>> What I'm doing at the moment in my blockdev-reopen series is check
>>>>> whether all parents of the node I want to change share the GRAPH_MO=
D
>>>>> permission. If any of them doesn't then the operation fails.
>>>>>
>>>>> This can be checked by calling bdrv_get_cumulative_perm() or simply=

>>>>> bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).
>>>>
>>>> Sure.
>>>>
>>>>> It solves the problem because e.g. the stream block job only allows=

>>>>> BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
>>>>> modifications allowed.
>>>>
>>>> But the problem is that the commit job needs to unshare the permissi=
on
>>>> on all backing links between base and top, so none of the backing
>>>> links can be broken.  But it cannot do that because those backing
>>>> links do not belong to it (but to the respective overlay nodes).
>>>
>>> I'm not sure if I'm following you. The commit block job has reference=
s
>>> to all intermediate nodes (with block_job_add_bdrv()) and only shares=

>>> BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE. Anyone trying to obtain
>>> BLK_PERM_GRAPH_MOD on an intermediate node would see that the block j=
ob
>>> doesn't allow it.
>>
>> But first of all, why would anyone try to obtain it?  You only obtain
>> a permission when you attach a new parent (or when an existing parent
>> tries to change the ones it has).
>=20
> You don't need to obtain it, you only need to see that the permission i=
s
> shared (with bdrv_get_cumulative_perm()). Or, as you suggest if I got i=
t
> right, attach a new "reopen" parent during bdrv_reopen_prepare() and
> release it on commit / abort.

OK, but that's just completely different from how all other permissions
work.

>> For instance, in the commit case, if you just remove a backing link,
>> then the chain is clearly broken and the graph has been modified, but
>> noone will have taken any permission to do so.
>=20
> If you do what I said in my previous paragraph then you can't remove th=
e
> backing link (this is one of my test cases).
>=20
>> But even beyond that, commit doesn't care about all of the graph.  All=

>> it cares about are the backing links.  So it should not prevent anyone=

>> else from changing any links outside of the backing chain (which a
>> permission would clearly do).
>>
>> Let me give a concrete example:
>>
>> top (T) -> intermediate (I) -> base (B)
>>
>> Now you commit from top to base.  Clearly you don't want the backing
>> chain between top and base to change.  So say you unshare the GRAPH_MO=
D
>> permission (implying that whenever a parent doesn't care, it just shar=
es
>> it).  But as said above, if someone just drops the backing link from I=

>> to B, the permission system won't catch that.
>=20
> Yes it will, because the block job (either mirror or commit depending o=
n
> the case) is the parent of all three nodes (BlockJob.nodes is where the=

> list is stored) and does not alow GRAPH_MOD in any of them[*]. So
> dropping that backing link fails (I also have a test case for that).
>=20
>> The next thing is that how would you even try to catch it in the first=

>> place?  The normal case would be for everything to both share and
>> claim the GRAPH_MOD permission, the latter so it can see if something
>> unshared it.  But that would mean that everything is holding that
>> permission all the time and it's impossible to unshare it.
>=20
> As things are now, GRAPH_MOD is shared by default on backing files
> (bdrv_format_default_perms()), but I don't understand why you need that=

> everything takes GRAPH_MOD, you only need it when you're actually
> planning to change the graph (e.g a block job).
>=20
>> So the solution might be to take it first, and release it after having=

>> attached the child.  And maybe you'd say that for the removal case,
>> you'd have to take the GRAPH_MOD permission before you remove any
>> child.
>=20
> Yes, something like that.
>=20
>> But I think that's weird, and also, there's another issue still.
>>
>> What if you try to attach a read-only NBD server to B?  That should be=

>> OK in my mind.  But it is a graph change, so it wouldn't be allowed if=

>> GRAPH_MOD is a permission, even though commit doesn't care at all.
>=20
> I haven't examined that case (I'm not familiar with NBD),

It doesn't matter whether it's NBD.  What matters is that commit doesn't
care about non-backing relationships.

> but if the
> only problem is that the permission system is unnecessarily strict in
> certain corner cases then maybe it's reasonable compromise _if_ there's=

> no simpler alternative (I'm not saying that there isn't!).

But I'm very much saying there is.  GRAPH_MOD is complicated to
understand; to make it work, it would have to work differently from all
other permissions; and it isn't even what we want.

>> I don't think anything needs a way to generally block graph changes
>> around some node.  We only need to prevent changes to very specific
>> sets of edges.  This is something that the permission system just
>> cannot do.
>=20
> But what would you do then?

What I wrote in the notes.  Have e.g. a counter in every BdrvChild that
can be incremented by everyone that means "If this is non-zero, do not
modify this BdrvChild".

At the start of the job, commit would go through the backing chain and
increment this counter on every backing link; and it would decrement it
after it's done.

>>>>>>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=
=80=9D or
>>>>>>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was suppose=
d to mean.
>>>>>>   Figuring that out always took like half an our in any
>>>>>>   face-to-face meeting, and then we decided it was pretty much
>>>>>>   useless for any case we had at hand.)
>>>>>
>>>>> Yeah it's a bit unclear. It can mean "none of this node's children
>>>>> can be replaced / removed", which is what I'm using it for at the
>>>>> moment.
>>>>
>>>> Yes, but that's just not useful.  I don't think we have any case whe=
re
>>>> something would be annoyed by having its immediate child replaced
>>>> (other than the visible data changing, potentially).  Usually when w=
e
>>>> say something (e.g. a block job) wants to prevent graph modification=
,
>>>> it's about changing edges that exist independently of the job (such =
as
>>>> a backing chain).
>>>
>>> Isn't that what I just said? You cannot change other edges <=3D> you
>>> cannot replace a node's children (or parents).
>>
>> Hm, true, but I think it's (1) hard to understand, (2) would require
>> non-trivial changes to the current model anyway (take GRAPH_MOD before=

>> any modification, release it afterwards (which is quite different from=

>> any other permission anyway)), and (3) would be too restrictive.
>=20
> I don't understand (2), block-stream is already doing that (takes
> GRAPH_MOD when you create the block job, releases when the job is
> completed).

And isn't that just wrong?

You don't have to take it if you want to prevent modifications, you'd
have to unshare it.  Well, it does that, too, but there is no reason for
it to take that permission for a prolonged period of time.  You seem to
agree with me that you'd only take GRAPH_MOD while you actually do some
modification.  I suppose the idea may be that it takes the permission at
the start of the job so it can definitely successfully perform the
change at the end, because it has taken the permission already.  But
that's just wrong, because it takes the permission on the root node,
which is completely unaffected by stream's graph modifications anyway.

What is correct is that it doesn't share GRAPH_MOD for the intermediate
nodes it attaches to the block job.  But that probably doesn't do
anything because nothing cares to set/query/whatever GRAPH_MOD when
modifying the graph.


You seem to be implying that GRAPH_MOD works perfectly well.  But I
think it just does not.  I think most parts of the block layer
completely ignore it, and the rest is torn up in confusion what it's
even supposed to mean.

So even if we decided that GRAPH_MOD is good enough, there'd still be a
ton of work to do.  I very much think it'd be much more work (and not
just boring, tedious, but brain-mangling work that brings you to the
brink of a nervous breakdown) than just adding a BdrvChild.freeze
counter that actually makes sense and actually does what we need.

Max


--I5Fu4WXwztsLJVOmhmKWVJxlSb5PFz5lZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvu4AIACgkQ9AfbAGHV
z0AV7QgAvcz8xoEpDnp1HNzNwZFji38wvNwZuxhBwXS5wocY03n1TbPp9JgYA3H/
1fPXbBU5haLBMh6tebfHeosRDLQv4nKecPKnTZe0uZhVIErhJgvsQTw8hAJZAWNQ
qAxD4gD3u53pIrfsf/wJ+mT2AhyzdgvmH8SBbiIGm3Oo5Jt2dJLzsD1W15jbm+3u
mH9IDhbGIyXLDhUbbyysmYDNgYMdMRcY4npXkMfXVL9CRpiWaINmsH9xZY68FRXQ
uMfuX+w8URkO5yT4RrCwGpQTLDwGaocfOV5RGWeKF/izJ7BL/Y3A+Jr6RgVa4YMI
6oW8Pu7c83qV7j1TNnafOYf9wBp77w==
=3rUK
-----END PGP SIGNATURE-----

--I5Fu4WXwztsLJVOmhmKWVJxlSb5PFz5lZ--
