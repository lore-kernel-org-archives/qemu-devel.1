Received: from eggs.gnu.org ([2001:4830:134:3::10]:44888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cF4tw-0001oj-Jx
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cF4tv-0002B2-Cl
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 15:02:44 -0500
Date: Thu, 8 Dec 2016 20:02:31 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20161208200230.GH2054@work-vm>
References: <1479555831-30960-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20161206134211.GD4990@noname.str.redhat.com>
	<20161206152415.GF2125@work-vm> <5848F139.1020402@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5848F139.1020402@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: re-active images when migration
 fails to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: Kevin Wolf <kwolf@redhat.com>, amit.shah@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, quintela@redhat.com

* Hailiang Zhang (zhang.zhanghailiang@huawei.com) wrote:
> Hi=EF=BC=8C
>=20
> On 2016/12/6 23:24, Dr. David Alan Gilbert wrote:
> > * Kevin Wolf (kwolf@redhat.com) wrote:
> > > Am 19.11.2016 um 12:43 hat zhanghailiang geschrieben:
> > > > commit fe904ea8242cbae2d7e69c052c754b8f5f1ba1d6 fixed a case
> > > > which migration aborted QEMU because it didn't regain the control
> > > > of images while some errors happened.
> > > >=20
> > > > Actually, we have another case in that error path to abort QEMU
> > > > because of the same reason:
> > > >      migration_thread()
> > > >          migration_completion()
> > > >             bdrv_inactivate_all() ----------------> inactivate im=
ages
> > > >             qemu_savevm_state_complete_precopy()
> > > >                 socket_writev_buffer() --------> error because de=
stination fails
> > > >               qemu_fflush() -------------------> set error on mig=
ration stream
> > > >             qemu_mutex_unlock_iothread() ------> unlock
> > > >      qmp_migrate_cancel() ---------------------> user cancelled m=
igration
> > > >          migrate_set_state() ------------------> set migrate CANC=
ELLING
> > >=20
> > > Important to note here: qmp_migrate_cancel() is executed by a concu=
rrent
> > > thread, it doesn't depend on any code paths in migration_completion=
().
> > >=20
> > > >      migration_completion() -----------------> go on to fail_inva=
lidate
> > > >          if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) -> Jump thi=
s branch
> > > >      migration_thread() -----------------------> break migration =
loop
> > > >        vm_start() -----------------------------> restart guest wi=
th inactive
> > > >                                                  images
> > > > We failed to regain the control of images because we only regain =
it
> > > > while the migration state is "active", but here users cancelled t=
he migration
> > > > when they found some errors happened (for example, libvirtd daemo=
n is shutdown
> > > > in destination unexpectedly).
> > > >=20
> > > > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > > > ---
> > > >   migration/migration.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/migration/migration.c b/migration/migration.c
> > > > index f498ab8..0c1ee6d 100644
> > > > --- a/migration/migration.c
> > > > +++ b/migration/migration.c
> > > > @@ -1752,7 +1752,8 @@ fail_invalidate:
> > > >       /* If not doing postcopy, vm_start() will be called: let's =
regain
> > > >        * control on images.
> > > >        */
> > > > -    if (s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
> > >=20
> > > This if condition tries to check whether we ran the code path that
> > > called bdrv_inactivate_all(), so that we only try to reactivate ima=
ges
> > > it if we really inactivated them first.
> > >=20
> > > The problem with it is that it ignores a possible concurrent
> > > modification of s->state.
> > >=20
> > > > +    if (s->state =3D=3D MIGRATION_STATUS_ACTIVE ||
> > > > +        s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
> > >=20
> > > This adds another state that we could end up with with a concurrent
> > > modification, so that even in this case we undo the inactivation.
> > >=20
> > > However, it is no longer limited to the cases where we inactivated =
the
> > > image. It also applies to other code paths (like the postcopy one) =
where
> > > we didn't inactivate images.
> > >=20
> > > What saves the patch is that bdrv_invalidate_cache() is a no-op for
> > > block devices that aren't inactivated, so calling it more often tha=
n
> > > necessary is okay.
> > >=20
> > > But then, if we're going to rely on this, it would be much better t=
o
> > > just remove the if altogether. I can't say whether there are any ot=
her
> > > possible values of s->state that we should consider, and by removin=
g the
> > > if we would be guaranteed to catch all of them.
> > >=20
> > > If we don't want to rely on it, just keep a local bool that remembe=
rs
> > > whether we inactivated images and check that here.
> > >=20
> > > >           Error *local_err =3D NULL;
> > > >=20
> > > >           bdrv_invalidate_cache_all(&local_err);
> > >=20
> > > So in summary, this is a horrible patch because it checks the wrong
> > > thing, and for I can't really say if it covers everything it needs =
to
> > > cover, but arguably it happens to correctly fix the outcome of a
> > > previously failing case.
> > >=20
> > > Normally I would reject such a patch and require a clean solution, =
but
> > > then we're on the day of -rc3, so if you can't send v2 right away, =
we
> > > might not have the time for it.
> > >=20
> > > Tough call...
> >=20
> > Hmm, this case is messy; I created this function having split it out
> > of the main loop a couple of years back but it did get more messy
> > with more s->state checks; as far as I can tell it's always
> > done the transition to COMPLETED at the end well after the locked
> > section, so there's always been that chance that cancellation sneaks
> > in just before or just after the locked section.
> >=20
> > Some of the bad cases that can happen:
> >     a) A cancel sneaks in after the ACTIVE check but before or after
> >       the locked section;  should we reactivate the disks? Well that
> >       depends on whether the destination actually got the full migrat=
ion
> >       stream - we don't know!
> >          If the destination actually starts running we must not react=
ivate
> >          the disk on the source even if the CPU is stopped.
> >=20
>=20
> Yes, we didn't have a mechanism to know exactly whether or not the VM i=
n
> destination is well received.
>=20
> >     b) If the bdrv_inactive_all fails for one device, but the others
> >        are fine, we go down the fail: label and don't reactivate, so
> >        the source dies even though it might have been mostly OK.
> >=20
>=20
> > We can move the _lock to before the check of s->state at the top,
> > which would stop the cancel sneaking in early.
> > In the case where postcopy was never enabled (!migrate_postcopy_ram()=
)
> > we can move the COMPLETED transition into the lock as well; so I thin=
k
> > then we kind of become safe.
> > In the case where postcopy was enabled I think we can do the COMPLETE=
D
> > transition before waiting for the return path to close - I think but
> > I need to think more about that.
> > And there seem to be some dodgy cases where we call the invalidate
> > there after a late postcopy failure; that's bad, we shouldn't reactiv=
ate
> > the source disks after going into postcopy.
> >=20
> > So, in summary; this function is a mess - it needs a much bigger
> > fix than this patch.
> >=20
>=20
> So what's the conclusion ?
> Will you send a patch to fix it ? Or let's fix it step by step ?
> I think Kevin's suggestion which just remove the *if* check is OK.

I don't see any of the simple solutions are easy;  so I plan
to look at it properly, but am not sure when;  if you have time
to do it then feel free.

Dave

>=20
> Thanks,
> Hailiang
>=20
> > Dave
> >=20
> > > Kevin
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
> > .
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
