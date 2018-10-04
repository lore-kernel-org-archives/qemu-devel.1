Received: from eggs.gnu.org ([2001:4830:134:3::10]:39157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8508-00034A-3O
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g8505-0004cs-Pj
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 10:53:16 -0400
Date: Thu, 4 Oct 2018 16:52:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181004145241.GG6009@localhost.localdomain>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
	<20181001102928.20533-14-vsementsov@virtuozzo.com>
	<20181004124421.GC6009@localhost.localdomain>
	<d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d691c927-e37a-1178-8180-9893278aa02c@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 13/18] block: introduce new filter
 driver: fleecing-hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "eblake@redhat.com" <eblake@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "xiechanglong.d@gmail.com" <xiechanglong.d@gmail.com>, "wencongyang2@huawei.com" <wencongyang2@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "jcody@redhat.com" <jcody@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>

Am 04.10.2018 um 15:59 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 04.10.2018 15:44, Kevin Wolf wrote:
> > Am 01.10.2018 um 12:29 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> Fleecing-hook filter does copy-before-write operation. It should be
> >> inserted above active disk and has a target node for CBW, like the
> >> following:
> >>
> >>      +-------+
> >>      | Guest |
> >>      +---+---+
> >>          |r,w
> >>          v
> >>      +---+-----------+  target   +---------------+
> >>      | Fleecing hook |---------->| target(qcow2) |
> >>      +---+-----------+   CBW     +---+-----------+
> >>          |                           |
> >> backing |r,w                        |
> >>          v                           |
> >>      +---+---------+      backing    |
> >>      | Active disk |<----------------+
> >>      +-------------+        r
> >>
> >> Target's backing may point to active disk (should be set up
> >> separately), which gives fleecing-scheme.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
> > This lacks an explanation why we need a specialised fleecing hook dri=
ver
> > rather than just a generic bdrv_backup_top block driver in analogy to
> > what commit and mirror are already doing.
> >
> > In fact, if I'm reading the last patch of the series right, backup
> > doesn't even restrict the use of the fleecing-hook driver to actual
> > fleecing scenarios.
> >
> > Maybe what doesn't feel right to me is just that it's a misnomer, and=
 if
> > you rename it into bdrv_backup_top (and make it internal to the block
> > job), it is very close to what I actually have in mind?
> >
> > Kevin
>=20
> Hm.
> 1. assume we move to internal bdrv_backup_top
> 2. backup(mode=3Dnone) becomes just a wrapper for append/drop of the=20
> bdrv_backup_top node

I think you mean sync=3Dnone?

Yes, this is true. There is no actual background job taking place there,
so the job infrastructure doesn't add much. As you say, it's just
inserting the node at the start and dropping it again at the end.

> 3. looks interesting to get rid of empty (doing nothing) job and use=20
> bdrv_backup_top directly.

We could directly make the filter node available for the user, like this
series does. Should we do that? I'm not sure, but I'm not necessarily
opposed either.

But looking at the big picture, I have some more thoughts on this:

1. Is backup with sync=3Dnone only useful for fleecing? My understanding
   was that "fleecing" specifically means a setup where the target of
   the backup node is an overlay of the active layer of the guest
   device.

   I can imagine other use cases that would use sync=3Dnone (e.g. if you
   don't access arbitrary blocks like from the NBD server in the
   fleecing setup, but directly write to a backup file that can be
   commited back later to revert things).

   So I think 'fleecing-hook' is too narrow as a name. Maybe just
   'backup' would be better?

2. mirror has a sync=3Dnone mode, too. And like backup, it doesn't
   actually have any background job running then (at least in active
   mirror mode), but only changes the graph at the end of the job.
   Some consistency would be nice there, so is the goal to eventually
   let the user create filter nodes for all jobs that don't have a
   real background job?

3. We have been thinking about unifying backup, commit and mirror
   into a single copy block job because they are doing quite similar
   things. Of course, there are differences whether the old data or the
   new data should be copied on a write, and which graph changes to make
   at the end of the job, but many of the other differences are actually
   features that would make sense in all of them, but are only
   implemented in one job driver.

   Maybe having a single 'copy' filter driver that provides options to
   select backup-like behaviour or mirror-like behaviour, and that can
   then internally be used by all three block jobs would be an
   interesting first step towards this?

   We can start with supporting only what backup needs, but design
   everything with the idea that mirror and commit could use it, too.

I honestly feel that at first this wouldn't be very different from what
you have, so with a few renames and cleanups we might be good. But it
would give us a design in the grand scheme to work towards instead of
doing one-off things for every special case like fleecing and ending up
with even more similar things that are implemented separately even
though they do mostly the same thing.

> I want to finally create different backup schemes, based on fleecing=20
> hook, for example:
>=20
>  =A0=A0=A0 +-------+
>  =A0=A0=A0 | Guest |
>  =A0=A0=A0 +-------+
>  =A0=A0=A0=A0=A0=A0=A0 |r,w
>  =A0=A0=A0=A0=A0=A0=A0 v
>  =A0=A0=A0 +---+-----------+=A0 target=A0=A0 +---------------+ +-------=
-+
>  =A0=A0=A0 | Fleecing hook +---------->+ fleecing-node +---------->+ ta=
rget |
>  =A0=A0=A0 +---+-----------+=A0=A0 CBW=A0=A0=A0=A0 +---+-----------+ ba=
ckup +--------+
>  =A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (no =
hook)
> backing |r,w=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |
>  =A0=A0=A0=A0=A0=A0=A0 v =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  =A0=A0=A0 +---+---------+=A0=A0=A0=A0=A0 backing=A0=A0=A0 |
>  =A0=A0=A0 | Active disk +<----------------+
>  =A0=A0=A0 +-------------+=A0=A0=A0=A0=A0=A0=A0 r
>=20
>=20
> This is needed for slow nbd target, if we don't need to slow down
> guest writes.  Here backup(no hook) is a backup job without hook /
> write notifiers, as it actually do copy from static source.

Right.

We don't actually have a backup without a hook yet (which would be the
same as the equally missing mirror for read-only nodes), but we do have
commit without a hook - it doesn't share the WRITE permission for the
source.  This is an example for a mode that a unified 'copy' driver
would automatically support.

> Or, we can use mirror instead of backup, as mirror is asynchronous and=20
> is faster than backup. We can even use mirror with write-blocking mode=20
> (proposed by Max) and use something like null bds (but with backing)=20
> instead of qcow2 fleecing-node - this will imitate current backup=20
> approach, but with mirror instead of backup.

To be honest, I don't understand the null BDS part. null throws away
whatever data is written to it, so that's certainly not what you want?

> Of course, we can use old backup(sync=3Dnone) for all such schemes, I j=
ust=20
> think that architecture with filter node is more clean, than with backu=
p=20
> job, which looks the same but with additional job:
>  =A0=A0=A0 +-------+
>  =A0=A0=A0 | Guest |
>  =A0=A0=A0 +-------+
>  =A0=A0=A0=A0=A0=A0=A0 |r,w
>  =A0=A0=A0=A0=A0=A0=A0 v
>  =A0=A0=A0 +---------------+=A0 target=A0=A0 +---------------+ +-------=
-+
>  =A0=A0=A0 |bdrv_backup_top+---------->+ fleecing-node +---------->+ ta=
rget |
>  =A0=A0=A0 +---------------+=A0=A0 CBW=A0=A0=A0=A0 +---+----------++ ba=
ckup +--------+
>  =A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 ^=A0 (no hook=
)
> backing |r,w=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  =A0=A0=A0=A0=A0=A0=A0 v =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  =A0=A0=A0 +---+---------+=A0=A0=A0=A0=A0 backing=A0=A0=A0 |=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 |
>  =A0=A0=A0 | Active disk +<----------------+=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 |
>  =A0=A0=A0 +----------+--+=A0=A0=A0=A0=A0=A0=A0 r=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 backup(sync=3Dnone)=A0=A0 |
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +--------------------------=
-----+

This looks only more complex because you decided to draw the block job
into the graph, as an edge connecting source and target. In reality,
this is not an edge that would be existing because bdrv_backup_top
already has both nodes as children. The job wouldn't have an additional
reference, but just use the BdrvChild that is owned by bdrv_backup_top.

Maybe this is an interesting point for the decision between an
integrated filter driver in the jobs and completely separate filter
driver. The jobs probably need access to the internal data structure
(bs->opaque) of the filter node at least, so that they can issue
requests on the child nodes.

Of course, if it isn't an internal filter driver, but a proper
standalone driver, letting jobs use those child nodes might be
considered a bit ugly...

> Finally, the first picture looks nicer and has less entities (and I=20
> didn't draw target blk which backup creates and all the permissions).=20
> Hmm, it also may be more difficult to setup permissions in the second=20
> scheme, but I didn't dive into. We just agreed with Max that separate=20
> building brick which may be reused in different schemes is better than=20
> internal thing in backup, so, I went this way. However, if you are=20
> against, it isn't difficult to move it all into backup.

The idea with bdrv_backup_top would obviously be to get rid of the
additional BlockBackend and BdrvChild instances and only access source
and target as children of the filter node.

Kevin
