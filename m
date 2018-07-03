Received: from eggs.gnu.org ([2001:4830:134:3::10]:40205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPdr-0001hS-7f
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faPdq-0001Vi-9F
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:03:07 -0400
Date: Tue, 3 Jul 2018 20:02:57 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703180257.GF28229@localhost.localdomain>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
	<e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
	<20180703111538.GB3812@localhost.localdomain>
	<e77b0d41-ac6c-9480-3260-b3a6ed31327e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e77b0d41-ac6c-9480-3260-b3a6ed31327e@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] block/fleecing-filter: new filter
 driver for fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

Am 03.07.2018 um 18:11 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 03.07.2018 14:15, Kevin Wolf wrote:
> > We'll have to figure out where to fix this problem (or what it really
> > is, once you look more than just at fleecing), but I think requiring =
the
> > user to add a filter driver to work around missing serialisation in
> > other code, and corrupting their image if they forget to, is not a
> > reasonable solution.
> >=20
> > I see at least two things wrong in this context:
> >=20
> > * The permissions don't seem to match reality. The NBD server
> >    unconditionally shares PERM_WRITE, which is wrong in this case. Th=
e
> >    client wants to see a point-in-time snapshot that never changes. T=
his
> >    should become an option so that it can be properly reflected in th=
e
> >    permissions used.
> >=20
> > * Once we have proper permissions, the fleecing setup breaks down
> >    because the guest needs PERM_WRITE on the backing file, but the
> >    fleecing overlay allows that only if the NBD client allows it (whi=
ch
> >    it doesn't for fleecing).
> >=20
> >    Now we can implement an exception right into backup that installs =
a
> >    backup filter driver between source and target if the source is th=
e
> >    backing file of the target. The filter driver would be similar to =
the
> >    commit filter driver in that it simply promises !PERM_WRITE to its
> >    parents, but allows PERM_WRITE on the source because it has instal=
led
> >    the before_write_notifier that guarantees this condition.
> >=20
> >    All writes to the target that are made by the backup job in this s=
etup
> >    (including before_write_notifier writes) need to be marked as
> >    serialising so that any concurrent reads are completed first.
> >=20
> > And if we decide to add a target filter to backup, we should probably=
 at
> > the same time use a filter driver for intercepting source writes inst=
ead
> > of using before_write_notifier.
>=20
> Hmm, is it possible to do all the staff in one super filter driver, whi=
ch we
> insert into the tree like this:
>=20
> top blk=A0=A0=A0=A0=A0=A0=A0 fleecing qcow2
> =A0=A0=A0=A0 +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +
> =A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |backing
> =A0=A0=A0=A0 v=A0=A0=A0=A0 <-----+
> =A0=A0 super filter
> =A0=A0=A0=A0 +
> =A0=A0=A0=A0 |file
> =A0=A0=A0=A0 v
> =A0=A0 active image
>=20
>=20
> And super filter do the following:
>=20
> 1. copy-on-write, before forwarding write to file, it do serializing wr=
ite
> to fleecing qcow2

This is where it breaks down. The filter driver in your graph doesn't
know fleecing.qcow2, so it can't write to it. Attaching fleecing.qcow2
as an additional child to the super filter doesn't work either because
you would create a loop then.

I think we need two separate nodes (and probably it's better to have
them managed by a block job so that both together can be checked to
result in a consistent setup).

> 2. fake .bdrv_child_perm for fleecing qcow2, like in block commit
>=20
> and no block job is needed.

Kevin
