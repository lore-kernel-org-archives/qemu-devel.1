Received: from eggs.gnu.org ([2001:4830:134:3::10]:45852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXV4q-00042u-Fs
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:14:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fXV4l-0006MA-Qt
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43180 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fXV4l-0006LQ-Fv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 13:14:51 -0400
Date: Mon, 25 Jun 2018 18:14:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180625171447.GJ2390@work-vm>
References: <20180609141457.6283-1-vsementsov@virtuozzo.com>
	<20180615120649.GC2615@work-vm>
	<f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f40607cd-a777-b033-ae37-0be50e3bc3d2@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: invalidate cache before source
 start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 15.06.2018 15:06, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > Invalidate cache before source start in case of failed migration.
> > >=20
> > > Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
> > Why doesn't the code at the bottom of migration_completion,
> > fail_invalidate:   and the code in migrate_fd_cancel   handle this?
> >=20
> > What case did you see it in that those didn't handle?
> > (Also I guess it probably should set s->block_inactive =3D false)
>=20
> on source I see:
>=20
> 81392@1529065750.766289:migrate_set_state new state 7
> 81392@1529065750.766330:migration_thread_file_err
> 81392@1529065750.766332:migration_thread_after_loop
>=20
> so, we are leaving loop on
> =A0=A0=A0=A0=A0=A0=A0 if (qemu_file_get_error(s->to_dst_file)) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 migrate_set_state(&s->state, current_=
active_state,
> MIGRATION_STATUS_FAILED);
> trace_migration_thread_file_err();
> break;
> =A0=A0=A0=A0=A0=A0=A0 }
>=20
> and skip migration_completion()

Yeh, OK; I'd seen soemthing else a few days ago, where a cancellation
test that had previously ended with a 'cancelled' state has now ended up
in 'failed' (which is the state 7 you have above).
I suspect there's something else going on as well; I think what is
supposed to happen in the case of 'cancel' is that it spins in 'cancellin=
g' for
a while in migrate_fd_cancel and then at the bottom of migrate_fd_cancel
it does the recovery, but because it's going to failed instead, then
it's jumping over that recovery.

Dave

>=20
> >=20
> > Dave
> >=20
> > > ---
> > >=20
> > >   migration/migration.c | 9 ++++++++-
> > >   1 file changed, 8 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 1e99ec9b7e..8f39e0dc02 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -2806,7 +2806,14 @@ static void migration_iteration_finish(Migra=
tionState *s)
> > >       case MIGRATION_STATUS_FAILED:
> > >       case MIGRATION_STATUS_CANCELLED:
> > >           if (s->vm_was_running) {
> > > -            vm_start();
> > > +            Error *local_err =3D NULL;
> > > +            bdrv_invalidate_cache_all(&local_err);
> > > +            if (local_err) {
> > > +                error_reportf_err(local_err, "Can't invalidate dis=
ks before "
> > > +                                  "source vm start");
> > > +            } else {
> > > +                vm_start();
> > > +            }
> > >           } else {
> > >               if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> > >                   runstate_set(RUN_STATE_POSTMIGRATE);
> > > --=20
> > > 2.11.1
> > >=20
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
> --=20
> Best regards,
> Vladimir
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
