Received: from eggs.gnu.org ([2001:4830:134:3::10]:56468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW0WQ-0002ST-6s
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:25:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW0WL-0006os-CI
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:25:14 -0400
Date: Thu, 21 Jun 2018 16:25:00 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180621142500.GJ5024@localhost.localdomain>
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
	<20180614104656.GD8564@localhost.localdomain>
	<8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] bug in reopen arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Am 15.06.2018 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 14.06.2018 13:46, Kevin Wolf wrote:
> > Am 12.06.2018 um 20:57 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > Hi all!
> > >=20
> > > I've faced the following problem:
> > >=20
> > >  =A0=A0=A0 1. create image with dirty bitmap, a.qcow2 (start qemu a=
nd run qmp
> > >  =A0=A0=A0 command block-dirty-bitmap-add)
> > >=20
> > >  =A0=A0=A0 2. run the following commands:
> > >=20
> > >  =A0=A0=A0=A0=A0=A0=A0 qemu-img create -f qcow2 -b a.qcow2 b.qcow2 =
10M
> > >  =A0=A0=A0=A0=A0=A0=A0 qemu-io -c 'write 0 512' b.qcow2
> > >  =A0=A0=A0=A0=A0=A0=A0 qemu-img commit b.qcow2
> > >=20
> > >  =A0=A0=A0 3. last command fails with the following output:
> > >=20
> > > Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_file=3D=
a.qcow2
> > > cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > > wrote 512/512 bytes at offset 0
> > > 512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec)
> > > qemu-img: #block397: Failed to make dirty bitmaps writable: Can't u=
pdate
> > > bitmap directory: Operation not permitted
> > > qemu-img: Block job failed: Operation not permitted
> > >=20
> > > And problem is that children are reopened _after_ parent. But qcow2=
 reopen
> > > needs write access to its file, to write IN_USE flag to dirty-bitma=
ps
> > > extension.
> > I was aware of a different instance of this problem: Assume a qcow2
> > image with an unknown autoclear flag (so it will be cleared on r/w
> > open), which is first opened r/o and then reopened r/w. This will fai=
l
> > because .bdrv_reopen_prepare doesn't have the permissions yet.
>=20
> Hm.. If I understand correctly qcow2_reopen_prepare doesn't deal with=A0
> autoclear flags, as it doesn't call qcow2_do_open.

Hm, right, not sure what I really meant back then when I added it to my
to-do list... Maybe I confused reopen and invalidate_cache.

> > Simply changing the order won't fix this because in the r/w -> r/o, t=
he
> > driver will legitimately flush its caches in .bdrv_reopen_prepare, an=
d
> > for this it still needs to be able to write.
> >=20
> > We may need to have a way for nodes to access both the old and the ne=
w
> > state of their children. I'm not completely sure how to achieve this
> > best, though.
> >=20
> > When I thought only of permissions, the obvious and simple thing to d=
o
> > was to just get combined permissions for the old and new state, i.e.
> > 'old_perm | new_perm' and 'old_shared & new_shared'. But I don't thin=
k
> > this is actually enough when the child node switches between a r/w an=
d
> > a r/o file descriptor because even though QEMU's permission system wo=
uld
> > allow the write, you still can't successfully write to a r/o file
> > descriptor.
> >=20
> > Kevin
>=20
> Maybe we want two .bdrv_reopen_prepare: .bdrv_reopen_prepare_before_chi=
ldren
> and .bdrv_reopen_prepare_after_children. But to write something in
> reopen_prepare, we need to move bdrv_set_perm from reopen_commit to
> .. Is it possible?

Getting the permission problems out of the way can be solved by changing
permissions twice, like I said above: First to the combined permissions
of old and new, and finally to only the new permissions.

The problem I see with .bdrv_reopen_prepare_after_children is that I
don't see how it actually buys you anything: Even if the children
already prepared the reopen, any access of the child node still refers
to the old file descriptor because the new one only becomes valid with
.bdrv_reopen_commit.

> Now, I've found the following workaround, what do you think about somet=
hing
> like this as a temporary fix:

I honestly don't understand why this workaround makes any difference.
Shouldn't all .bdrv_reopen_prepare() callbacks still work on the old
version of the child node?

Even if I understood the reason, it looks a bit too hacky probably.
Maybe I'll change may opinion once I understand it.

Kevin
