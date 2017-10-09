Received: from eggs.gnu.org ([2001:4830:134:3::10]:43443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e1a2j-0005m5-WE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e1a2d-0003Nx-H3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e1a2d-0003NH-8M
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 11:32:27 -0400
Date: Mon, 9 Oct 2017 16:32:21 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171009153221.GO2374@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-10-git-send-email-peterx@redhat.com>
	<20170921192144.GG3401@work-vm>
	<20170926093532.GE3828@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20170926093532.GE3828@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC v2 09/33] migration: implement
 "postcopy-pause" src logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Sep 21, 2017 at 08:21:45PM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Now when network down for postcopy, the source side will not fail the
> > > migration. Instead we convert the status into this new paused state, =
and
> > > we will try to wait for a rescue in the future.
> > >=20
> > > If a recovery is detected, migration_thread() will reset its local
> > > variables to prepare for that.
> > >=20
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration.c  | 98 ++++++++++++++++++++++++++++++++++++++++=
+++++++---
> > >  migration/migration.h  |  3 ++
> > >  migration/trace-events |  1 +
> > >  3 files changed, 98 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index f6130db..8d26ea8 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -993,6 +993,8 @@ static void migrate_fd_cleanup(void *opaque)
> > > =20
> > >      notifier_list_notify(&migration_state_notifiers, s);
> > >      block_cleanup_parameters(s);
> > > +
> > > +    qemu_sem_destroy(&s->postcopy_pause_sem);
> > >  }
> > > =20
> > >  void migrate_fd_error(MigrationState *s, const Error *error)
> > > @@ -1136,6 +1138,7 @@ MigrationState *migrate_init(void)
> > >      s->migration_thread_running =3D false;
> > >      error_free(s->error);
> > >      s->error =3D NULL;
> > > +    qemu_sem_init(&s->postcopy_pause_sem, 0);
> > > =20
> > >      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_ST=
ATUS_SETUP);
> > > =20
> > > @@ -1938,6 +1941,80 @@ bool migrate_colo_enabled(void)
> > >      return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
> > >  }
> > > =20
> > > +typedef enum MigThrError {
> > > +    /* No error detected */
> > > +    MIG_THR_ERR_NONE =3D 0,
> > > +    /* Detected error, but resumed successfully */
> > > +    MIG_THR_ERR_RECOVERED =3D 1,
> > > +    /* Detected fatal error, need to exit */
> > > +    MIG_THR_ERR_FATAL =3D 2,
> >=20
> > I don't think it's necessary to assign the values there, but it's OK.
> >=20
> > > +} MigThrError;
> > > +
> > > +/*
> > > + * We don't return until we are in a safe state to continue current
> > > + * postcopy migration.  Returns MIG_THR_ERR_RECOVERED if recovered, =
or
> > > + * MIG_THR_ERR_FATAL if unrecovery failure happened.
> > > + */
> > > +static MigThrError postcopy_pause(MigrationState *s)
> > > +{
> > > +    assert(s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > > +    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> > > +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> > > +
> > > +    /* Current channel is possibly broken. Release it. */
> > > +    assert(s->to_dst_file);
> > > +    qemu_file_shutdown(s->to_dst_file);
> > > +    qemu_fclose(s->to_dst_file);
> > > +    s->to_dst_file =3D NULL;
> > > +
> > > +    error_report("Detected IO failure for postcopy. "
> > > +                 "Migration paused.");
> > > +
> > > +    /*
> > > +     * We wait until things fixed up. Then someone will setup the
> > > +     * status back for us.
> > > +     */
> > > +    while (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_PAUSED) {
> > > +        qemu_sem_wait(&s->postcopy_pause_sem);
> > > +    }
> > > +
> > > +    trace_postcopy_pause_continued();
> > > +
> > > +    return MIG_THR_ERR_RECOVERED;
> > > +}
> > > +
> > > +static MigThrError migration_detect_error(MigrationState *s)
> > > +{
> > > +    int ret;
> > > +
> > > +    /* Try to detect any file errors */
> > > +    ret =3D qemu_file_get_error(s->to_dst_file);
> > > +
> > > +    if (!ret) {
> > > +        /* Everything is fine */
> > > +        return MIG_THR_ERR_NONE;
> > > +    }
> > > +
> > > +    if (s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE && ret =3D=
=3D -EIO) {
> >=20
> > We do need to make sure that whenever we hit a failure in migration
> > due to a device that we pass that up rather than calling
> > qemu_file_set_error - e.g. an EIO in a block device or network.
> >=20
> > However,
> >=20
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
> I'll take the R-b first. :)
>=20
> Regarding to above - aren't we currently detecting these kind of
> errors using -EIO?  And network down should be only one of such case?
>=20
> For now I still cannot distinguish network down out of something worse
> that cannot even be recovered.  No matter what, current code will go
> into PAUSED state as long as EIO is got.  I thought about it, and for
> now I don't think it is a problem, since even if it is a critical
> failure and unable to recover in any way, we still won't lose anything
> if we stop the VM at once (that's what paused state do - VM is just
> stopped).  For the critical failures, we will just find out that the
> recovery will fail again rather than success.

Yes I think it's fine for now;  my suspicion is that sometimes errors
=66rom devices (e.g. disk/NIC) end up in the qemu_file_set_error - but
they shouldn't, I think we should try and keep that just for actual
migration stream transport errors, and then this patch is safe.

Dave

> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
