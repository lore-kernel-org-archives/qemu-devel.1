Received: from eggs.gnu.org ([2001:4830:134:3::10]:60134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIcOO-0008FY-7C
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIcOK-000803-6u
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:33:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gIcOJ-0007zQ-Ph
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 12:33:48 -0400
Date: Fri, 2 Nov 2018 16:33:35 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181102163334.GC2387@work-vm>
References: <20181101101715.9443-1-fli@suse.com>
	<20181101101715.9443-6-fli@suse.com> <20181102023738.GD7804@xz-x1>
	<39af00cd-fb54-de7d-154e-d9047156ab43@suse.com>
	<20181102033241.GF7804@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181102033241.GF7804@xz-x1>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v7 5/9] migration: fix the multifd code
 when sending less channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Fei Li <fli@suse.com>, qemu-devel@nongnu.org, armbru@redhat.com, famz@redhat.com, quintela@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Nov 02, 2018 at 11:00:24AM +0800, Fei Li wrote:
> >=20
> >=20
> > On 11/02/2018 10:37 AM, Peter Xu wrote:
> > > On Thu, Nov 01, 2018 at 06:17:11PM +0800, Fei Li wrote:
> > > > Set the migration state to "failed" instead of "setup" when faili=
ng
> > > > to send packet via some channel.
> > > Could you please provide more information in the commit message?
> > > E.g., what will happen if without this patch?  Will it crash the
> > > source or stall the source migration or others?  Otherwise it's a b=
it
> > > hard for me to understand what's this patch for.
> > Sorry for the inadequate description , I was intended to say that whe=
n
> > failing
> > to do the live migration using multifd, e.g. sending less channels, t=
he src
> > status displays "setup" when running `info migrate`. I assume we shou=
ld tell
> > users that the "Migration status" is "failed" now (and along with the
> > failure reason).
> >=20
> > The current src status when failed inmultifd_new_send_channel_async()=
=EF=BC=9A
> >=20
> >=20
> > (qemu) migrate_set_capability x-multifd on
> > (qemu) migrate_set_parameter x-multifd-channels 4
> > (qemu) migrate -d tcp:192.168.190.98:4444
> > (qemu) qemu-system-x86_64: failed in multifd_new_send_channel_async d=
ue to
> > ...
> > (qemu) info migrate
> > globals:
> > store-global-state: on
> > only-migratable: off
> > send-configuration: on
> > send-section-footer: on
> > decompress-error-check: on
> > capabilities: xbzrle: off rdma-pin-all: off auto-converge: off zero-b=
locks:
> > off compress: off events: off postcopy-ram: off x-colo: off release-r=
am: off
> > block: off return-path: off pause-before-switchover: off x-multifd: o=
n
> > dirty-bitmaps: off postcopy-blocktime: off late-block-activate: off
> > Migration status: setup
> > total time: 0 milliseconds
>=20
> Thanks for the information.
>=20
> I had a quick look.  For now we do this:
>=20
>         multifd_save_setup (without waiting for channels to be ready)
>         create thread migration_thread
>                 (in thread)
>                 ram_save_setup
>                         multifd_send_sync_main (wait for the channels)
>=20
> The thing is that we didn't get the notification when one of the
> multifd channel is failed.  IMHO instead of setting the global
> migration state in a per-channel function, we should just report the
> error upwards, then the main thread should decide how to change the
> state machine of the migration.

Best to wait for Juan on that; I've got vague memories that reporting
errors among the threads was a bit tricky.

Dave

> And we have set it in migrate_set_error() after all so the main thread
> should be able to know somehow (though IMHO I'll even prefer to have a
> per-channel variable to keep the state of the channel, then the
> per-channel functions won't touch any globals which offers better
> isolation).
>=20
> I'm not sure how Juan thinks about it, but I'd prefer some work to
> provide such isolation and also some mechanism to allow the main
> thread to detect the per-channel errors not only during setup phase
> but also during the migration (e.g., when network is suddenly down).
> Then we don't touch any globals (e.g., we shouldn't call
> migrate_get_current in any per-channel function like
> multifd_new_send_channel_async).
>=20
> >=20
> > >=20
> > > Normally I would prefer to not touch global states in feature speci=
fic
> > > code path, but I'd like to know the problem more first...
> > >=20
> > > Thanks,
> > >=20
> > > > Cc: Peter Xu <peterx@redhat.com>
> > > > Signed-off-by: Fei Li <fli@suse.com>
> > > > ---
> > > >   migration/ram.c | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 4db3b3e8f4..c84d164fc8 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1072,6 +1072,7 @@ out:
> > > >   static void multifd_new_send_channel_async(QIOTask *task, gpoin=
ter opaque)
> > > >   {
> > > >       MultiFDSendParams *p =3D opaque;
> > > > +    MigrationState *s =3D migrate_get_current();
> > > >       QIOChannel *sioc =3D QIO_CHANNEL(qio_task_get_source(task))=
;
> > > >       Error *local_err =3D NULL;
> > > > @@ -1083,6 +1084,7 @@ static void multifd_new_send_channel_async(=
QIOTask *task, gpointer opaque)
> > > >           if (multifd_save_cleanup(&local_err) !=3D 0) {
> > > >               migrate_set_error(migrate_get_current(), local_err)=
;
> > > >           }
> > > > +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_=
FAILED);
> > > >       } else {
> > > >           p->c =3D QIO_CHANNEL(sioc);
> > > >           qio_channel_set_delay(p->c, false);
> > > > --=20
> > > > 2.13.7
> > > >=20
> > > Regards,
> > >=20
> >=20
>=20
> Regards,
>=20
> --=20
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
