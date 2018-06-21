Received: from eggs.gnu.org ([2001:4830:134:3::10]:51317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW3DH-0008Gg-Ly
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fW3DG-0004K3-8d
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 13:17:39 -0400
Date: Thu, 21 Jun 2018 19:17:29 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180621171729.GK5024@localhost.localdomain>
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
	<20180614104656.GD8564@localhost.localdomain>
	<8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
	<20180621142500.GJ5024@localhost.localdomain>
	<14e2ebb9-8d4f-3079-83f0-a4b6bd60e9d6@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <14e2ebb9-8d4f-3079-83f0-a4b6bd60e9d6@virtuozzo.com>
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

Am 21.06.2018 um 17:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 21.06.2018 17:25, Kevin Wolf wrote:
> > Am 15.06.2018 um 20:42 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 14.06.2018 13:46, Kevin Wolf wrote:
> > > > Am 12.06.2018 um 20:57 hat Vladimir Sementsov-Ogievskiy geschrieb=
en:
> > > > > Hi all!
> > > > >=20
> > > > > I've faced the following problem:
> > > > >=20
> > > > >   =A0=A0=A0 1. create image with dirty bitmap, a.qcow2 (start q=
emu and run qmp
> > > > >   =A0=A0=A0 command block-dirty-bitmap-add)
> > > > >=20
> > > > >   =A0=A0=A0 2. run the following commands:
> > > > >=20
> > > > >   =A0=A0=A0=A0=A0=A0=A0 qemu-img create -f qcow2 -b a.qcow2 b.q=
cow2 10M
> > > > >   =A0=A0=A0=A0=A0=A0=A0 qemu-io -c 'write 0 512' b.qcow2
> > > > >   =A0=A0=A0=A0=A0=A0=A0 qemu-img commit b.qcow2
> > > > >=20
> > > > >   =A0=A0=A0 3. last command fails with the following output:
> > > > >=20
> > > > > Formatting 'b.qcow2', fmt=3Dqcow2 size=3D68719476736 backing_fi=
le=3Da.qcow2
> > > > > cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
> > > > > wrote 512/512 bytes at offset 0
> > > > > 512 bytes, 1 ops; 0.0953 sec (5.243 KiB/sec and 10.4867 ops/sec=
)
> > > > > qemu-img: #block397: Failed to make dirty bitmaps writable: Can=
't update
> > > > > bitmap directory: Operation not permitted
> > > > > qemu-img: Block job failed: Operation not permitted
> > > > >=20
> > > > > And problem is that children are reopened _after_ parent. But q=
cow2 reopen
> > > > > needs write access to its file, to write IN_USE flag to dirty-b=
itmaps
> > > > > extension.
> > > > I was aware of a different instance of this problem: Assume a qco=
w2
> > > > image with an unknown autoclear flag (so it will be cleared on r/=
w
> > > > open), which is first opened r/o and then reopened r/w. This will=
 fail
> > > > because .bdrv_reopen_prepare doesn't have the permissions yet.
> > > Hm.. If I understand correctly qcow2_reopen_prepare doesn't deal wi=
th
> > > autoclear flags, as it doesn't call qcow2_do_open.
> > Hm, right, not sure what I really meant back then when I added it to =
my
> > to-do list... Maybe I confused reopen and invalidate_cache.
> >=20
> > > > Simply changing the order won't fix this because in the r/w -> r/=
o, the
> > > > driver will legitimately flush its caches in .bdrv_reopen_prepare=
, and
> > > > for this it still needs to be able to write.
> > > >=20
> > > > We may need to have a way for nodes to access both the old and th=
e new
> > > > state of their children. I'm not completely sure how to achieve t=
his
> > > > best, though.
> > > >=20
> > > > When I thought only of permissions, the obvious and simple thing =
to do
> > > > was to just get combined permissions for the old and new state, i=
.e.
> > > > 'old_perm | new_perm' and 'old_shared & new_shared'. But I don't =
think
> > > > this is actually enough when the child node switches between a r/=
w and
> > > > a r/o file descriptor because even though QEMU's permission syste=
m would
> > > > allow the write, you still can't successfully write to a r/o file
> > > > descriptor.
> > > >=20
> > > > Kevin
> > > Maybe we want two .bdrv_reopen_prepare: .bdrv_reopen_prepare_before=
_children
> > > and .bdrv_reopen_prepare_after_children. But to write something in
> > > reopen_prepare, we need to move bdrv_set_perm from reopen_commit to
> > > .. Is it possible?
> > Getting the permission problems out of the way can be solved by chang=
ing
> > permissions twice, like I said above: First to the combined permissio=
ns
> > of old and new, and finally to only the new permissions.
> >=20
> > The problem I see with .bdrv_reopen_prepare_after_children is that I
> > don't see how it actually buys you anything: Even if the children
> > already prepared the reopen, any access of the child node still refer=
s
> > to the old file descriptor because the new one only becomes valid wit=
h
> > .bdrv_reopen_commit.
> >=20
> > > Now, I've found the following workaround, what do you think about s=
omething
> > > like this as a temporary fix:
> > I honestly don't understand why this workaround makes any difference.
>=20
> with this patch, commit for children will be called earlier than for pa=
rent,
> so, when reopening bitmaps rw (which is done in commit) bs->file will b=
e
> already completely reopened rw, and all works.

.bdrv_reopen_commit() can't do any I/O because it must not fail.
Therefore the order in which nodes are committed should not matter.

Any I/O that needs to be done has to be in .bdrv_reopen_prepare() (and
possibly be kept in a temporary buffer) and .bdrv_reopen_commit() can
only apply what is already in memory.

I don't see the code for reopening bitmaps in master. Is this a pending
patch?

Kevin
