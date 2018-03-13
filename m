Received: from eggs.gnu.org ([2001:4830:134:3::10]:36239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evoGS-0000RJ-Oz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1evoGN-0007q6-Tn
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 14:03:08 -0400
Date: Tue, 13 Mar 2018 18:02:38 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180313180237.GJ3545@work-vm>
References: <20180207155837.92351-1-vsementsov@virtuozzo.com>
	<20180207155837.92351-11-vsementsov@virtuozzo.com>
	<20180312160901.GJ3219@work-vm>
	<e4883029-31b5-2b09-8ac3-186b04ce6075@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4883029-31b5-2b09-8ac3-186b04ce6075@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v10 10/12] migration: add postcopy
 migration of dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com

* Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> 12.03.2018 19:09, Dr. David Alan Gilbert wrote:
> > * Vladimir Sementsov-Ogievskiy (vsementsov@virtuozzo.com) wrote:
> > > Postcopy migration of dirty bitmaps. Only named dirty bitmaps are migrated.
> > > 
> > > +
> > > +        init_dirty_bitmap_incoming_migration();
> > > +
> > You might want to consider if that's better in vl.c near where
> > ram_mig_init() is, OR whether there should be a call in
> > migratation_incoming_state_destroy to clean it up.
> > (Although I doubt the cases where the destroy happens are interesting
> > for postcopy bitmaps).
> 
> If you don't mind, let's leave it as is for now

Yep, that's OK.

Dave

> > 
> > >           once = true;
> > >       }
> > >       return &mis_current;
> > > @@ -297,6 +300,8 @@ static void process_incoming_migration_bh(void *opaque)
> > >          state, we need to obey autostart. Any other state is set with
> > >          runstate_set. */
> > > +    dirty_bitmap_mig_before_vm_start();
> > > +
> > >       if (!global_state_received() ||
> > >           global_state_get_runstate() == RUN_STATE_RUNNING) {
> > >           if (autostart) {
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index e5d557458e..93b339646b 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -1673,6 +1673,8 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
> > >       trace_loadvm_postcopy_handle_run_vmstart();
> > > +    dirty_bitmap_mig_before_vm_start();
> > > +
> > >       if (autostart) {
> > >           /* Hold onto your hats, starting the CPU */
> > >           vm_start();
> > > diff --git a/vl.c b/vl.c
> > > index e517a8d995..0ef3f2b5a2 100644
> > > --- a/vl.c
> > > +++ b/vl.c
> > > @@ -4514,6 +4514,7 @@ int main(int argc, char **argv, char **envp)
> > >       blk_mig_init();
> > >       ram_mig_init();
> > > +    dirty_bitmap_mig_init();
> > >       /* If the currently selected machine wishes to override the units-per-bus
> > >        * property of its default HBA interface type, do so now. */
> > > diff --git a/migration/Makefile.objs b/migration/Makefile.objs
> > > index 99e038024d..c83ec47ba8 100644
> > > --- a/migration/Makefile.objs
> > > +++ b/migration/Makefile.objs
> > > @@ -6,6 +6,7 @@ common-obj-y += qemu-file.o global_state.o
> > >   common-obj-y += qemu-file-channel.o
> > >   common-obj-y += xbzrle.o postcopy-ram.o
> > >   common-obj-y += qjson.o
> > > +common-obj-y += block-dirty-bitmap.o
> > >   common-obj-$(CONFIG_RDMA) += rdma.o
> > > diff --git a/migration/trace-events b/migration/trace-events
> > > index a04fffb877..e9eb8078d4 100644
> > > --- a/migration/trace-events
> > > +++ b/migration/trace-events
> > > @@ -227,3 +227,17 @@ colo_vm_state_change(const char *old, const char *new) "Change '%s' => '%s'"
> > >   colo_send_message(const char *msg) "Send '%s' message"
> > >   colo_receive_message(const char *msg) "Receive '%s' message"
> > >   colo_failover_set_state(const char *new_state) "new state %s"
> > > +
> > > +# migration/block-dirty-bitmap.c
> > > +send_bitmap_header_enter(void) ""
> > > +send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "\n   flags:        0x%x\n   start_sector: %" PRIu64 "\n   nr_sectors:   %" PRIu32 "\n   data_size:    %" PRIu64 "\n"
> > Tracing doesn't have \n's in
> 
> will fix.
> 
> > 
> > > +dirty_bitmap_save_iterate(int in_postcopy) "in postcopy: %d"
> > > +dirty_bitmap_save_complete_enter(void) ""
> > > +dirty_bitmap_save_complete_finish(void) ""
> > > +dirty_bitmap_save_pending(uint64_t pending, uint64_t max_size) "pending %" PRIu64 " max: %" PRIu64
> > > +dirty_bitmap_load_complete(void) ""
> > > +dirty_bitmap_load_bits_enter(uint64_t first_sector, uint32_t nr_sectors) "chunk: %" PRIu64 " %" PRIu32
> > > +dirty_bitmap_load_bits_zeroes(void) ""
> > > +dirty_bitmap_load_header(uint32_t flags) "flags 0x%x"
> > > +dirty_bitmap_load_enter(void) ""
> > > +dirty_bitmap_load_success(void) ""
> > So other than minor bits, this one looks OK from a migration side; I
> > can't say I've followed the block side of the patch though.
> > 
> > Dave
> > 
> > > -- 
> > > 2.11.1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> 
> -- 
> Best regards,
> Vladimir
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
