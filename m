Received: from eggs.gnu.org ([2001:4830:134:3::10]:40766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxOaa-0001a1-31
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxOaW-0006Pp-Mr
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:30:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxOaW-0006PO-Cv
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 22:30:08 -0400
Date: Thu, 28 Sep 2017 10:30:01 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170928023001.GC17044@pxdev.xzpeter.org>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-25-git-send-email-peterx@redhat.com>
	<20170922113318.GH2620@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170922113318.GH2620@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 24/33] migration: synchronize dirty bitmap
 for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Sep 22, 2017 at 12:33:19PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > This patch implements the first part of core RAM resume logic for
> > postcopy. ram_resume_prepare() is provided for the work.
> > 
> > When the migration is interrupted by network failure, the dirty bitmap
> > on the source side will be meaningless, because even the dirty bit is
> > cleared, it is still possible that the sent page was lost along the way
> > to destination. Here instead of continue the migration with the old
> > dirty bitmap on source, we ask the destination side to send back its
> > received bitmap, then invert it to be our initial dirty bitmap.
> > 
> > The source side send thread will issue the MIG_CMD_RECV_BITMAP requests,
> > once per ramblock, to ask for the received bitmap. On destination side,
> > MIG_RP_MSG_RECV_BITMAP will be issued, along with the requested bitmap.
> > Data will be received on the return-path thread of source, and the main
> > migration thread will be notified when all the ramblock bitmaps are
> > synchronized.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/migration.c  |  4 +++
> >  migration/migration.h  |  1 +
> >  migration/ram.c        | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  migration/trace-events |  4 +++
> >  4 files changed, 76 insertions(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 19b7f3a5..19aed72 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -2605,6 +2605,8 @@ static void migration_instance_finalize(Object *obj)
> >  
> >      g_free(params->tls_hostname);
> >      g_free(params->tls_creds);
> > +
> > +    qemu_sem_destroy(&ms->rp_state.rp_sem);
> >  }
> >  
> >  static void migration_instance_init(Object *obj)
> > @@ -2629,6 +2631,8 @@ static void migration_instance_init(Object *obj)
> >      params->has_downtime_limit = true;
> >      params->has_x_checkpoint_delay = true;
> >      params->has_block_incremental = true;
> > +
> > +    qemu_sem_init(&ms->rp_state.rp_sem, 1);
> >  }
> >  
> >  /*
> > diff --git a/migration/migration.h b/migration/migration.h
> > index a3a0582..d041369 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -107,6 +107,7 @@ struct MigrationState
> >          QEMUFile     *from_dst_file;
> >          QemuThread    rp_thread;
> >          bool          error;
> > +        QemuSemaphore rp_sem;
> >      } rp_state;
> >  
> >      double mbps;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 5d938e3..afabcf5 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -47,6 +47,7 @@
> >  #include "exec/target_page.h"
> >  #include "qemu/rcu_queue.h"
> >  #include "migration/colo.h"
> > +#include "savevm.h"
> >  
> >  /***********************************************************/
> >  /* ram save/restore */
> > @@ -295,6 +296,8 @@ struct RAMState {
> >      RAMBlock *last_req_rb;
> >      /* Queue of outstanding page requests from the destination */
> >      QemuMutex src_page_req_mutex;
> > +    /* Ramblock counts to sync dirty bitmap. Only used for recovery */
> > +    int ramblock_to_sync;
> >      QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
> >  };
> >  typedef struct RAMState RAMState;
> > @@ -2770,6 +2773,56 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >      return ret;
> >  }
> >  
> > +/* Sync all the dirty bitmap with destination VM.  */
> > +static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
> > +{
> > +    RAMBlock *block;
> > +    QEMUFile *file = s->to_dst_file;
> > +    int ramblock_count = 0;
> > +
> > +    trace_ram_dirty_bitmap_sync_start();
> > +
> > +    /*
> > +     * We do this in such order:
> > +     *
> > +     * 1. calculate block count
> > +     * 2. fill in the count to N
> > +     * 3. send MIG_CMD_RECV_BITMAP requests
> > +     * 4. wait on the semaphore until N -> 0
> > +     */
> > +
> > +    RAMBLOCK_FOREACH(block) {
> > +        ramblock_count++;
> > +    }
> > +
> > +    atomic_set(&rs->ramblock_to_sync, ramblock_count);
> > +    RAMBLOCK_FOREACH(block) {
> > +        qemu_savevm_send_recv_bitmap(file, block->idstr);
> > +    }
> > +
> > +    trace_ram_dirty_bitmap_sync_wait();
> 
> Please include the RAMBlock name in the trace, so if it hangs we can
> see where.

This is to note when we start to wait, while there is a trace below
when we reload one single ramblock at [1].  Would that suffice?

> 
> > +
> > +    /* Wait until all the ramblocks' dirty bitmap synced */
> > +    while (atomic_read(&rs->ramblock_to_sync)) {
> > +        qemu_sem_wait(&s->rp_state.rp_sem);
> > +    }
> 
> Do you need to make ramblock_to_sync global and use atomics - I think
> you can simplify it;  if you qemu_sem_init to 0, then I think you
> can do:
>    while (ramblock_count--) {
>        qemu_sem_wait(&s->rp_state.rp_sem);
>    }
> 
> qemu_sem_wait will block until the semaphore is >0....

You are right!

> 
> > +
> > +    trace_ram_dirty_bitmap_sync_complete();
> > +
> > +    return 0;
> > +}
> > +
> > +static void ram_dirty_bitmap_reload_notify(MigrationState *s)
> > +{
> > +    atomic_dec(&ram_state->ramblock_to_sync);
> > +    if (ram_state->ramblock_to_sync == 0) {
> > +        /* Make sure the other thread gets the latest */
> > +        trace_ram_dirty_bitmap_sync_notify();
> > +        qemu_sem_post(&s->rp_state.rp_sem);
> > +    }
> 
> then with the suggestion above you just do a qemu_sem_post each time.

Yes.  I'll also remove the notify trace since there is a better
tracepoint before calling this function.

> 
> > +}
> > +
> >  /*
> >   * Read the received bitmap, revert it as the initial dirty bitmap.
> >   * This is only used when the postcopy migration is paused but wants
> > @@ -2841,12 +2894,25 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
> >  
> >      trace_ram_dirty_bitmap_reload(block->idstr);

[1]

> >  
> > +    /*
> > +     * We succeeded to sync bitmap for current ramblock. If this is
> > +     * the last one to sync, we need to notify the main send thread.
> > +     */
> > +    ram_dirty_bitmap_reload_notify(s);
> > +
> >      ret = 0;
> >  out:
> >      free(le_bitmap);
> >      return ret;
> >  }
> >  
> > +static int ram_resume_prepare(MigrationState *s, void *opaque)
> > +{
> > +    RAMState *rs = *(RAMState **)opaque;
> > +
> > +    return ram_dirty_bitmap_sync_all(s, rs);
> > +}
> > +
> >  static SaveVMHandlers savevm_ram_handlers = {
> >      .save_setup = ram_save_setup,
> >      .save_live_iterate = ram_save_iterate,
> > @@ -2857,6 +2923,7 @@ static SaveVMHandlers savevm_ram_handlers = {
> >      .save_cleanup = ram_save_cleanup,
> >      .load_setup = ram_load_setup,
> >      .load_cleanup = ram_load_cleanup,
> > +    .resume_prepare = ram_resume_prepare,
> >  };
> >  
> >  void ram_mig_init(void)
> > diff --git a/migration/trace-events b/migration/trace-events
> > index 61b0d49..8962916 100644
> > --- a/migration/trace-events
> > +++ b/migration/trace-events
> > @@ -81,6 +81,10 @@ ram_postcopy_send_discard_bitmap(void) ""
> >  ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
> >  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
> >  ram_dirty_bitmap_reload(char *str) "%s"
> > +ram_dirty_bitmap_sync_start(void) ""
> > +ram_dirty_bitmap_sync_wait(void) ""
> > +ram_dirty_bitmap_sync_notify(void) ""
> > +ram_dirty_bitmap_sync_complete(void) ""
> >  
> >  # migration/migration.c
> >  await_return_path_close_on_source_close(void) ""
> > -- 
> > 2.7.4
> > 
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

-- 
Peter Xu
