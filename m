Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faJHo-0004ag-GV
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1faJHn-0000tS-7C
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 07:15:56 -0400
Date: Tue, 3 Jul 2018 13:15:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180703111538.GB3812@localhost.localdomain>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<20180629151524.138542-3-vsementsov@virtuozzo.com>
	<32ad25bf-0427-e286-94f1-0566af2ea8ed@redhat.com>
	<920ef7dd-67c3-fd93-b1b3-ea3bd31577f2@redhat.com>
	<e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e97fb1f7-a864-a413-0ea4-f3e1dc29bc9f@virtuozzo.com>
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

Am 02.07.2018 um 14:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 29.06.2018 20:40, Eric Blake wrote:
> > On 06/29/2018 12:30 PM, John Snow wrote:
> > >=20
> > >=20
> > > On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
> > > > We need to synchronize backup job with reading from fleecing imag=
e
> > > > like it was done in block/replication.c.
> > > >=20
> > > > Otherwise, the following situation is theoretically possible:
> > > >=20
> > > > 1. client start reading
> > > > 2. client understand, that there is no corresponding cluster in
> > > > =A0=A0=A0 fleecing image
> > >=20
> > > I don't think the client refocuses the read, but QEMU does. (the cl=
ient
> > > has no idea if it is reading from the fleecing node or the backing
> > > file.)
> > >=20
> > > ... but understood:
> > >=20
> > > > 3. client is going to read from backing file (i.e. active image)
> > > > 4. guest writes to active image
> > >=20
> > > My question here is if QEMU will allow reads and writes to interlea=
ve in
> > > general. If the client is reading from the backing file, the active
> > > image, will QEMU allow a write to modify that data before we're don=
e
> > > getting that data?
> > >=20
> > > > 5. this write is stopped by backup(sync=3Dnone) and cluster is co=
pied to
> > > > =A0=A0=A0 fleecing image
> > > > 6. guest write continues...
> > > > 7. and client reads _new_ (or partly new) date from active image
> > > >=20
> > >=20
> > > I can't answer this for myself one way or the other right now, but =
I
> > > imagine you observed a failure in practice in your test setups, whi=
ch
> > > motivated this patch?
> > >=20
> > > A test or some proof would help justification for this patch. It wo=
uld
> > > also help prove that it solves what it claims to!
> >=20
> > In fact, do we really need a new filter, or do we just need to make t=
he
> > "sync":"none" blockdev-backup job take the appropriate synchronizatio=
n
> > locks?
> >=20
>=20
> How? We'll need additional mechanism like serializing requests.. Or a w=
ay to
> reuse serializing requests. Using backup internal synchronization looks
> simpler, and it is already used in block replication.

But it also just an ugly hack that fixes one special case and leaves
everything else broken. replication is usually not a good example for
anything. It always gives me bad surprises when I have to look at it.

We'll have to figure out where to fix this problem (or what it really
is, once you look more than just at fleecing), but I think requiring the
user to add a filter driver to work around missing serialisation in
other code, and corrupting their image if they forget to, is not a
reasonable solution.

I see at least two things wrong in this context:

* The permissions don't seem to match reality. The NBD server
  unconditionally shares PERM_WRITE, which is wrong in this case. The
  client wants to see a point-in-time snapshot that never changes. This
  should become an option so that it can be properly reflected in the
  permissions used.

* Once we have proper permissions, the fleecing setup breaks down
  because the guest needs PERM_WRITE on the backing file, but the
  fleecing overlay allows that only if the NBD client allows it (which
  it doesn't for fleecing).

  Now we can implement an exception right into backup that installs a
  backup filter driver between source and target if the source is the
  backing file of the target. The filter driver would be similar to the
  commit filter driver in that it simply promises !PERM_WRITE to its
  parents, but allows PERM_WRITE on the source because it has installed
  the before_write_notifier that guarantees this condition.

  All writes to the target that are made by the backup job in this setup
  (including before_write_notifier writes) need to be marked as
  serialising so that any concurrent reads are completed first.

And if we decide to add a target filter to backup, we should probably at
the same time use a filter driver for intercepting source writes instead
of using before_write_notifier.

Max, I think you intended to make both source and target children of the
same block job node (or at least for mirror). But wouldn't that create
loops in a setup like this? I think we may need two filters that are
only connected through the block job, but not with block graph edges.

Kevin
