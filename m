Received: from eggs.gnu.org ([2001:4830:134:3::10]:51228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fWLjS-0000a4-Jg
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:04:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fWLjN-0007l1-Jo
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 09:04:06 -0400
Date: Fri, 22 Jun 2018 15:03:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180622130349.GG4366@localhost.localdomain>
References: <f9a9b5bb-4941-a6b3-ff6b-02ab2cb046df@virtuozzo.com>
	<20180614104656.GD8564@localhost.localdomain>
	<8114a2a4-8bd1-809e-44c2-f3c8fb52b773@virtuozzo.com>
	<20180621142500.GJ5024@localhost.localdomain>
	<14e2ebb9-8d4f-3079-83f0-a4b6bd60e9d6@virtuozzo.com>
	<20180621171729.GK5024@localhost.localdomain>
	<5513dadd-7695-e95b-6437-85defae28ce9@virtuozzo.com>
	<20180622085613.GC4366@localhost.localdomain>
	<b2ce7bb2-5fd1-56d3-c82d-79ea834a5e15@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <b2ce7bb2-5fd1-56d3-c82d-79ea834a5e15@virtuozzo.com>
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
Cc: qemu block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, berto@igalia.com

Am 22.06.2018 um 13:17 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 22.06.2018 11:56, Kevin Wolf wrote:
> > (Berto, I'm CCing you just because this is about reopen, so you might
> > have thoughts about it. But it's not really related to what you're
> > currently working on.)
> >=20
> > Am 21.06.2018 um 19:44 hat Vladimir Sementsov-Ogievskiy geschrieben:
> > > 21.06.2018 20:17, Kevin Wolf wrote:
> > > > Am 21.06.2018 um 17:55 hat Vladimir Sementsov-Ogievskiy geschrieb=
en:
> > > > > 21.06.2018 17:25, Kevin Wolf wrote:
> > > > > > Am 15.06.2018 um 20:42 hat Vladimir Sementsov-Ogievskiy gesch=
rieben:
> > > > > > > Now, I've found the following workaround, what do you think=
 about something
> > > > > > > like this as a temporary fix:
> > > > > > I honestly don't understand why this workaround makes any dif=
ference.
> > > > > with this patch, commit for children will be called earlier tha=
n for parent,
> > > > > so, when reopening bitmaps rw (which is done in commit) bs->fil=
e will be
> > > > > already completely reopened rw, and all works.
> > > > .bdrv_reopen_commit() can't do any I/O because it must not fail.
> > > > Therefore the order in which nodes are committed should not matte=
r.
> > > >=20
> > > > Any I/O that needs to be done has to be in .bdrv_reopen_prepare()=
 (and
> > > > possibly be kept in a temporary buffer) and .bdrv_reopen_commit()=
 can
> > > > only apply what is already in memory.
> > > >=20
> > > > I don't see the code for reopening bitmaps in master. Is this a p=
ending
> > > > patch?
> > > it is in block.c, in bdrv_reopen_commit()
> > >=20
> > > ...
> > > if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw)=
 {
> > >  =A0=A0=A0=A0=A0=A0=A0 Error *local_err =3D NULL;
> > >  =A0=A0=A0=A0=A0=A0=A0 if (drv->bdrv_reopen_bitmaps_rw(bs, &local_e=
rr) < 0) {
> > This is already an ugly hack, we shouldn't have a separate callback f=
or
> > reopening bitmaps. :-(
> >=20
> > If done properly, this code would only exist internally in qcow2 as p=
art
> > of the .bdrv_reopen/commit implementation.
> >=20
> > I'm also not convinced of the error handling. According to commit
> > cb9ff6c25, this is mostly about the IN_USE flag. The qcow2 spec says
> > "The bitmap was not saved correctly and may be inconsistent." for thi=
s
> > flag. So the fail-safe state is IN_USE being set.
> >=20
> >=20
> > What I think qcow2 should be doing is setting IN_USE in .prepare (for=
 ro
> > -> rw) and clearing it in .commit (for rw -> ro).
>=20
> why this in prepare and this in commit? Not both in commit or both in
> prepare?

We cannot guarantee full transactional semantics because we need to
write to the image to commit, and this may fail. So no atomicity for us.

For the case that the write fails, we have the choice between:

1. Clear IN_USE in .prepare, even though it should be set for writable
   images. Setting it in .commit fails. This is unsafe if we make the
   bitmaps writable as promised. Currently code leaves them read-only,
   but doesn't return an error from the reopen operation. The management
   tool can't know about the situation, so it will fail later.

2. Set IN_USE in .prepare, even though it can be cleared for read-only
   files. Clearing it in .commit fails. This is always safe and leaves
   the read-only image in a state as if QEMU had crashed.

I think 2. is preferable.

Kevin

> > For this to be possible, .prepare needs write access to an image that
> > was read-only before and is becoming writable; and .commit needs writ=
e
> > access to an image that was writable and is becoming read-only.
> >=20
> > This is the problem to solve, and implementing a proper design that c=
an
> > provide this will solve the bug for you, too.
> >=20
> >=20
> > I'm not completely sure how this can be achieved best. Allowing paren=
ts
> > to choose whether they want to access the old or the new state is
> > probably not going to work in the general case because that's
> > essentially an image opened twice.
> >=20
> > Even if it feels like a hack, too, maybe we need to make file-posix
> > already switch to the "better" file descriptor in .prepare and store =
the
> > old one in the BDRVRawReopenState so it can be restored in .abort.
> >=20
> > The "better" file descriptor is the one that allows more operation, i=
.e.
> > writable is better than read-only in this sense. Of course, if we hav=
e
> > two options like read-only that can prevent certain operations, it ma=
y
> > be unclear, which of the two file descriptors is the one we want.
> >=20
> > And obviously, this still needs child-to-parent .prepare order. I
> > believe when I tried reversing the current order a while ago, I ran i=
nto
> > problems, so whether this is possible or how it needs to be done in
> > detail needs to be checked carefully.
> >=20
> > Kevin
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20
