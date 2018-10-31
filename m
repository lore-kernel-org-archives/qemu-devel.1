Received: from eggs.gnu.org ([2001:4830:134:3::10]:47842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtOj-0006Jm-Qa
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:31:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHtOa-00026b-C5
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:31:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHtOT-0001ti-Q1
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 12:30:58 -0400
Date: Wed, 31 Oct 2018 16:30:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181031163040.GA2402@work-vm>
References: <20181029125818.28720-1-fli@suse.com>
	<20181029125818.28720-7-fli@suse.com>
	<20181030194923.GD2441@work-vm>
	<fd8629e3-cb6f-3e86-ba1a-cbda26373847@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd8629e3-cb6f-3e86-ba1a-cbda26373847@suse.com>
Subject: Re: [Qemu-devel] [PATCH RFC v6 6/7] migration: fix some error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <fli@suse.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, famz@redhat.com, peterx@redhat.com, quintela@redhat.com

* Fei Li (fli@suse.com) wrote:
> 
> 
> On 10/31/2018 03:49 AM, Dr. David Alan Gilbert wrote:
> > * Fei Li (fli@suse.com) wrote:
> > > Add error handling for qemu_ram_foreach_migratable_block() when
> > > it fails.
> > > 
> > > Always call migrate_set_error() to set the error state without relying
> > > on whether multifd_save_cleanup() succeeds. As the passed &local_err
> > > is never used in multifd_save_cleanup(), remove it.
> > > 
> > > Signed-off-by: Fei Li <fli@suse.com>
> > > ---
> > >   migration/migration.c    | 5 +----
> > >   migration/postcopy-ram.c | 3 +++
> > >   migration/ram.c          | 7 +++----
> > >   migration/ram.h          | 2 +-
> > >   4 files changed, 8 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/migration/migration.c b/migration/migration.c
> > > index 87dfc7374f..3b8b7ab4f9 100644
> > > --- a/migration/migration.c
> > > +++ b/migration/migration.c
> > > @@ -1377,7 +1377,6 @@ static void migrate_fd_cleanup(void *opaque)
> > >       qemu_savevm_state_cleanup();
> > >       if (s->to_dst_file) {
> > > -        Error *local_err = NULL;
> > >           QEMUFile *tmp;
> > >           trace_migrate_fd_cleanup();
> > > @@ -1388,9 +1387,7 @@ static void migrate_fd_cleanup(void *opaque)
> > >           }
> > >           qemu_mutex_lock_iothread();
> > > -        if (multifd_save_cleanup(&local_err) != 0) {
> > > -            error_report_err(local_err);
> > > -        }
> > > +        multifd_save_cleanup();
> > >           qemu_mutex_lock(&s->qemu_file_lock);
> > >           tmp = s->to_dst_file;
> > >           s->to_dst_file = NULL;
> > > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > > index e5c02a32c5..4ca2bc02b3 100644
> > > --- a/migration/postcopy-ram.c
> > > +++ b/migration/postcopy-ram.c
> > > @@ -1117,6 +1117,9 @@ int postcopy_ram_enable_notify(MigrationIncomingState *mis)
> > >       /* Mark so that we get notified of accesses to unwritten areas */
> > >       if (qemu_ram_foreach_migratable_block(ram_block_enable_notify, mis)) {
> > > +        error_report("ram_block_enable_notify failed");
> > > +        close(mis->userfault_event_fd);
> > > +        close(mis->userfault_fd);
> > I don't think these close() calls are safe.  This code is just after
> > starting the fault thread, and the fault thread has a poll() call on
> > these fd's, so we can't close them until we've instructed that thread
> > to exit.
> > 
> > We should fall out through postcopy_ram_incoming_cleanup, and because
> > the thread exists it should do a notify to the thread, a join and then
> > only later do the close calls.
> > 
> > Dave
> I see the postcopy_ram_incoming_cleanup() already include the
> notify & join the fault thread & close these two fds and other more cleanup,
> thus that means directly replace the above two close() with
> postcopy_ram_incoming_cleanup() is ok, right? :)

Yes; I think I'd do that in loadvm_postcopy_handle_listen perhaps.
It's a weird case, normally if it fails before 'listen' then we call
cleanup in process_incoming_migration_co,  but after listen we call it
at the bottom of the listen thread.  Here we've got a half-state where
we're trying and failing to enter listen.

> BTW, does the parameter "&local_err" for multifd_save_cleanup(&local_err) is
> reserved for some reason? As I notice no code is using this error parameter,
> and if it is reserved for nothing I'd like to delete it just as the second
> paragraph
> of the commit message said. :)

Yes, that's OK; it might be better as a separate patch;  I suspect maybe
in an earlier version it had an error case.

Dave

> Have a nice day, thanks
> Fei
> > 
> > >           return -1;
> > >       }
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 8f03afe228..57cb1bee3d 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -922,7 +922,7 @@ static void multifd_send_terminate_threads(Error *err)
> > >       }
> > >   }
> > > -int multifd_save_cleanup(Error **errp)
> > > +int multifd_save_cleanup(void)
> > >   {
> > >       int i;
> > >       int ret = 0;
> > > @@ -1082,9 +1082,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
> > >       if (qio_task_propagate_error(task, &local_err)) {
> > >           migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> > > -        if (multifd_save_cleanup(&local_err) != 0) {
> > > -            migrate_set_error(migrate_get_current(), local_err);
> > > -        }
> > > +        multifd_save_cleanup();
> > > +        migrate_set_error(migrate_get_current(), local_err);
> > >       } else {
> > >           p->c = QIO_CHANNEL(sioc);
> > >           qio_channel_set_delay(p->c, false);
> > > diff --git a/migration/ram.h b/migration/ram.h
> > > index 046d3074be..0d1215209e 100644
> > > --- a/migration/ram.h
> > > +++ b/migration/ram.h
> > > @@ -43,7 +43,7 @@ uint64_t ram_bytes_remaining(void);
> > >   uint64_t ram_bytes_total(void);
> > >   int multifd_save_setup(void);
> > > -int multifd_save_cleanup(Error **errp);
> > > +int multifd_save_cleanup(void);
> > >   int multifd_load_setup(void);
> > >   int multifd_load_cleanup(Error **errp);
> > >   bool multifd_recv_all_channels_created(void);
> > > -- 
> > > 2.13.7
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
