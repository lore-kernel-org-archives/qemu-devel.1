Received: from eggs.gnu.org ([2001:4830:134:3::10]:34004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNIeR-0000qU-I9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:29:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gNIeM-0002cf-Bp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:29:46 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
	<w511s7p9fkk.fsf@maestria.local.igalia.com>
	<462138b3-e9e7-29e5-da55-d0ebd626aee7@redhat.com>
Date: Thu, 15 Nov 2018 15:28:34 +0100
Message-ID: <w51efbmh0tp.fsf@maestria.local.igalia.com>
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

On Wed 14 Nov 2018 06:24:10 PM CET, Max Reitz wrote:
>>> Permission system
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>
>>> GRAPH_MOD
>>> ---------
>>>
>>> We need some way for the commit job to prevent graph changes on its
>>> chain while it is running.  Our current blocker doesn=E2=80=99t do the =
job,
>>> however.  What to do?
>>>
>>> - We have no idea how to make a *permission* work.  Maybe the biggest
>>>   problem is that it just doesn=E2=80=99t work as a permission, because=
 the
>>>   commit job doesn=E2=80=99t own the BdrvChildren that would need to be
>>>   blocked (namely the @backing BdrvChild).
>>=20
>> What I'm doing at the moment in my blockdev-reopen series is check
>> whether all parents of the node I want to change share the GRAPH_MOD
>> permission. If any of them doesn't then the operation fails.
>>=20
>> This can be checked by calling bdrv_get_cumulative_perm() or simply
>> bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).
>
> Sure.
>
>> It solves the problem because e.g. the stream block job only allows
>> BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
>> modifications allowed.
>
> But the problem is that the commit job needs to unshare the permission
> on all backing links between base and top, so none of the backing
> links can be broken.  But it cannot do that because those backing
> links do not belong to it (but to the respective overlay nodes).

I'm not sure if I'm following you. The commit block job has references
to all intermediate nodes (with block_job_add_bdrv()) and only shares
BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE. Anyone trying to obtain
BLK_PERM_GRAPH_MOD on an intermediate node would see that the block job
doesn't allow it.

>>>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=80=
=9D or
>>>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed to =
mean.
>>>   Figuring that out always took like half an our in any face-to-face
>>>   meeting, and then we decided it was pretty much useless for any
>>>   case we had at hand.)
>>=20
>> Yeah it's a bit unclear. It can mean "none of this node's children
>> can be replaced / removed", which is what I'm using it for at the
>> moment.
>
> Yes, but that's just not useful.  I don't think we have any case where
> something would be annoyed by having its immediate child replaced
> (other than the visible data changing, potentially).  Usually when we
> say something (e.g. a block job) wants to prevent graph modification,
> it's about changing edges that exist independently of the job (such as
> a backing chain).

Isn't that what I just said? You cannot change other edges <=3D> you
cannot replace a node's children (or parents).

>>> Reopen
>>> ------
>>>
>>> How should permissions be handled while the reopen is under way?
>>> Maybe we should take the union of @perm before and after, and the
>>> intersection of @shared before and after?
>>=20
>> Do you have an example of a case in which you're reopening a node and
>> the change of permissions causes a problem?
>
> I do not.  So currently we switch from the permissions before to the
> ones after, right?  Which should be safe because that switch is a
> transaction that is integrated into reopen.
>
> However, I suppose it's possible the protocol layer gives us some
> issues again.  It cannot switch the locks before commit, but
> committing may fail.  What to do then?
>
> It would be safer if we took the union/intersection in
> bdrv_reopen_prepare() and then released the unnecessary flags in
> bdrv_reopen_commit().  We can still get errors (as discussed), but
> those can be safely ignored.  (They're just annoying, but not
> harmful.)

Ok, I suppose you're right.

Berto
