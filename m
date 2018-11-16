Received: from eggs.gnu.org ([2001:4830:134:3::10]:54040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNd1V-0007nF-2f
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:14:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gNd1T-0007k0-Vu
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 07:14:57 -0500
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
	<w51efbmh0tp.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
Date: Fri, 16 Nov 2018 13:14:37 +0100
MIME-Version: 1.0
In-Reply-To: <w51efbmh0tp.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mM1NaSlAinvG59ziLpLAMNJdu7hbBBT4M"
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
--mM1NaSlAinvG59ziLpLAMNJdu7hbBBT4M
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2e1b90ae-1a0c-711a-6ef8-3c814335f696@redhat.com>
Subject: Re: KVM Forum block no[td]es
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
 <w511s7p9fkk.fsf@maestria.local.igalia.com>
 <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
 <w51efbmh0tp.fsf@maestria.local.igalia.com>
In-Reply-To: <w51efbmh0tp.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 15.11.18 15:28, Alberto Garcia wrote:
> On Wed 14 Nov 2018 06:24:10 PM CET, Max Reitz wrote:
>>>> Permission system
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> GRAPH_MOD
>>>> ---------
>>>>
>>>> We need some way for the commit job to prevent graph changes on its
>>>> chain while it is running.  Our current blocker doesn=E2=80=99t do t=
he job,
>>>> however.  What to do?
>>>>
>>>> - We have no idea how to make a *permission* work.  Maybe the bigges=
t
>>>>   problem is that it just doesn=E2=80=99t work as a permission, beca=
use the
>>>>   commit job doesn=E2=80=99t own the BdrvChildren that would need to=
 be
>>>>   blocked (namely the @backing BdrvChild).
>>>
>>> What I'm doing at the moment in my blockdev-reopen series is check
>>> whether all parents of the node I want to change share the GRAPH_MOD
>>> permission. If any of them doesn't then the operation fails.
>>>
>>> This can be checked by calling bdrv_get_cumulative_perm() or simply
>>> bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).
>>
>> Sure.
>>
>>> It solves the problem because e.g. the stream block job only allows
>>> BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
>>> modifications allowed.
>>
>> But the problem is that the commit job needs to unshare the permission=

>> on all backing links between base and top, so none of the backing
>> links can be broken.  But it cannot do that because those backing
>> links do not belong to it (but to the respective overlay nodes).
>=20
> I'm not sure if I'm following you. The commit block job has references
> to all intermediate nodes (with block_job_add_bdrv()) and only shares
> BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE. Anyone trying to obtain
> BLK_PERM_GRAPH_MOD on an intermediate node would see that the block job=

> doesn't allow it.

But first of all, why would anyone try to obtain it?  You only obtain a
permission when you attach a new parent (or when an existing parent
tries to change the ones it has).

For instance, in the commit case, if you just remove a backing link,
then the chain is clearly broken and the graph has been modified, but
noone will have taken any permission to do so.

But even beyond that, commit doesn't care about all of the graph.  All
it cares about are the backing links.  So it should not prevent anyone
else from changing any links outside of the backing chain (which a
permission would clearly do).

Let me give a concrete example:

top (T) -> intermediate (I) -> base (B)

Now you commit from top to base.  Clearly you don't want the backing
chain between top and base to change.  So say you unshare the GRAPH_MOD
permission (implying that whenever a parent doesn't care, it just shares
it).  But as said above, if someone just drops the backing link from I
to B, the permission system won't catch that.

The next thing is that how would you even try to catch it in the first
place?  The normal case would be for everything to both share and claim
the GRAPH_MOD permission, the latter so it can see if something unshared
it.  But that would mean that everything is holding that permission all
the time and it's impossible to unshare it.

(You'd take the GRAPH_MOD permission for the backing link from I to B,
and then commit couldn't unshare it because, well, it's taken already.)

So the solution might be to take it first, and release it after having
attached the child.  And maybe you'd say that for the removal case,
you'd have to take the GRAPH_MOD permission before you remove any child.
 But I think that's weird, and also, there's another issue still.


What if you try to attach a read-only NBD server to B?  That should be
OK in my mind.  But it is a graph change, so it wouldn't be allowed if
GRAPH_MOD is a permission, even though commit doesn't care at all.

The fact is that commit clearly only cares about edges it is not
involved in as either parent or child (the backing links), and therefore
has not control over the permissions taken.  It does not care about any
other edges, which is different from what permissions do, because they
always apply to a whole set of edges.


I don't think anything needs a way to generally block graph changes
around some node.  We only need to prevent changes to very specific sets
of edges.  This is something that the permission system just cannot do.

>>>>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=80=
=9D or
>>>>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed =
to mean.
>>>>   Figuring that out always took like half an our in any face-to-face=

>>>>   meeting, and then we decided it was pretty much useless for any
>>>>   case we had at hand.)
>>>
>>> Yeah it's a bit unclear. It can mean "none of this node's children
>>> can be replaced / removed", which is what I'm using it for at the
>>> moment.
>>
>> Yes, but that's just not useful.  I don't think we have any case where=

>> something would be annoyed by having its immediate child replaced
>> (other than the visible data changing, potentially).  Usually when we
>> say something (e.g. a block job) wants to prevent graph modification,
>> it's about changing edges that exist independently of the job (such as=

>> a backing chain).
>=20
> Isn't that what I just said? You cannot change other edges <=3D> you
> cannot replace a node's children (or parents).

Hm, true, but I think it's (1) hard to understand, (2) would require
non-trivial changes to the current model anyway (take GRAPH_MOD before
any modification, release it afterwards (which is quite different from
any other permission anyway)), and (3) would be too restrictive.

Max


--mM1NaSlAinvG59ziLpLAMNJdu7hbBBT4M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvutK0ACgkQ9AfbAGHV
z0BV8wf/TX8vg0QSPDnXkGtoXAlayTFtxOHeYYUce66YJ7M5sPjMU5uTJ+B6nckp
cgP1B6a0tWNVtGes8v8+ht1uLoyaByaO8aHGh5u1WBkX43QCVbQK0YvBZKR1ZuEI
f1JwI9qGrOGPwFYVh5tMwFp574DCLSRAgF+bXBkATWA+S1jmJlueGAiJcJ8Mu+X/
dHZWflcqwEi6DljBp09Xs8kSFwH4fI05/le8227pEnLoM7NdBiTW9HmGvDeqyt0u
39QxKfArgLclXx/QxUQfnsFtvLktipzNHgDnDyww4kxeREaNv07W1FUvZ6q8zS9b
E5Xxb5ZbRy5fj5xW8/9LP5yvpDO2XQ==
=zhRO
-----END PGP SIGNATURE-----

--mM1NaSlAinvG59ziLpLAMNJdu7hbBBT4M--
