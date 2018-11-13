Received: from eggs.gnu.org ([2001:4830:134:3::10]:34057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMaZl-0003s6-MO
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gMaNx-0004PV-Hn
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 10:13:52 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
References: <79c52867-2c10-401b-95d9-2d2edd8afa5e@redhat.com>
Date: Tue, 13 Nov 2018 16:12:43 +0100
Message-ID: <w511s7p9fkk.fsf@maestria.local.igalia.com>
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

On Sun 11 Nov 2018 11:25:00 PM CET, Max Reitz wrote:

> Permission system
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> GRAPH_MOD
> ---------
>
> We need some way for the commit job to prevent graph changes on its
> chain while it is running.  Our current blocker doesn=E2=80=99t do the jo=
b,
> however.  What to do?
>
> - We have no idea how to make a *permission* work.  Maybe the biggest
>   problem is that it just doesn=E2=80=99t work as a permission, because t=
he
>   commit job doesn=E2=80=99t own the BdrvChildren that would need to be
>   blocked (namely the @backing BdrvChild).

What I'm doing at the moment in my blockdev-reopen series is check
whether all parents of the node I want to change share the GRAPH_MOD
permission. If any of them doesn't then the operation fails.

This can be checked by calling bdrv_get_cumulative_perm() or simply
bdrv_check_update_perm(..., BLK_PERM_GRAPH_MOD, ...).

It solves the problem because e.g. the stream block job only allows
BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED, so no graph
modifications allowed.

>   (We never quite knew what =E2=80=9Ctaking the GRAPH_PERMISSION=E2=80=9D=
 or
>   =E2=80=9Cunsharing the GRPAH_MOD permission=E2=80=9D was supposed to me=
an.  Figuring
>   that out always took like half an our in any face-to-face meeting,
>   and then we decided it was pretty much useless for any case we had
>   at hand.)

Yeah it's a bit unclear. It can mean "none of this node's children can
be replaced / removed", which is what I'm using it for at the moment.

> Reopen
> ------
>
> How should permissions be handled while the reopen is under way?
> Maybe we should take the union of @perm before and after, and the
> intersection of @shared before and after?

Do you have an example of a case in which you're reopening a node and
the change of permissions causes a problem?

> - Is it possible that changing an option may require taking an
>   intermediate permission that is required neither before nor after
>   the reopen process?
>   Changing a child link comes to mind (like changing a child from one
>   BDS to another, where the visible data changes, which would mean we
>   may want to e.g. unshare CONSISTENT_READ during the reopen).
>   However:
>   1. It is unfeasible to unshare that for all child changes.
>      Effectively everything requires CONSISTENT_READ, and for good
>      reason.
>   2. Why would a user even change a BDS to something of a different
>      content?
>   3. Anything that currently allows you to change a child node assumes
>      that the user always changes it to something of the same content
>      (some take extra care to verify this, like mirror, which makes
>      sure that @replaces and the target are connected, and there are
>      only filter nodes in between).

I don't think the user wants to change a BDS to something of a different
content, but it may happen that QEMU doesn't have a way to verify
whether the content is the same or not.

I think we have one such case already with 'blockdev-snapshot', in which
you add a BDS with blockdev-add and then add its contents on top of an
existing BDS.

Berto
