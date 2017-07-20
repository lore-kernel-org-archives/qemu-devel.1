Received: from eggs.gnu.org ([2001:4830:134:3::10]:59521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY6XJ-0001AL-0U
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:10:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dY6XD-00047f-S0
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:10:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dY6XD-00046i-I4
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:10:11 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E25B2F86E0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:10:10 +0000 (UTC)
Date: Thu, 20 Jul 2017 16:10:05 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170720081005.GB23385@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170719190238.GK3500@work-vm>
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, berrange@redhat.com

On Wed, Jul 19, 2017 at 08:02:39PM +0100, Dr. David Alan Gilbert wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
> > The function still don't use multifd, but we have simplified
> > ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> > counter and a new flag for this type of pages.
> > 
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  hmp.c                 |  2 ++
> >  migration/migration.c |  1 +
> >  migration/ram.c       | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  qapi-schema.json      |  5 ++-
> >  4 files changed, 96 insertions(+), 2 deletions(-)
> > 
> > diff --git a/hmp.c b/hmp.c
> > index b01605a..eeb308b 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -234,6 +234,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> >              monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
> >                             info->ram->postcopy_requests);
> >          }
> > +        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
> > +                       info->ram->multifd);
> >      }
> >  
> >      if (info->has_disk) {
> > diff --git a/migration/migration.c b/migration/migration.c
> > index e1c79d5..d9d5415 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -528,6 +528,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >      info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
> >      info->ram->postcopy_requests = ram_counters.postcopy_requests;
> >      info->ram->page_size = qemu_target_page_size();
> > +    info->ram->multifd = ram_counters.multifd;
> >  
> >      if (migrate_use_xbzrle()) {
> >          info->has_xbzrle_cache = true;
> > diff --git a/migration/ram.c b/migration/ram.c
> > index b80f511..2bf3fa7 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -68,6 +68,7 @@
> >  #define RAM_SAVE_FLAG_XBZRLE   0x40
> >  /* 0x80 is reserved in migration.h start with 0x100 next */
> >  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> > +#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
> >  
> >  static inline bool is_zero_range(uint8_t *p, uint64_t size)
> >  {
> > @@ -362,12 +363,17 @@ static void compress_threads_save_setup(void)
> >  /* Multiple fd's */
> >  
> >  struct MultiFDSendParams {
> > +    /* not changed */
> >      uint8_t id;
> >      QemuThread thread;
> >      QIOChannel *c;
> >      QemuSemaphore sem;
> >      QemuMutex mutex;
> > +    /* protected by param mutex */
> >      bool quit;
> 
> Should probably comment to say what address space address is in - this
> is really a qemu pointer - and that's why we can treat 0 as special?

I believe this comment is for "address" below.

Yes, it would be nice to comment it. IIUC it belongs to virtual
address space of QEMU, so it should be okay to use zero as a "special"
value.

> 
> > +    uint8_t *address;
> > +    /* protected by multifd mutex */
> > +    bool done;
> 
> done needs a comment to explain what it is because
> it sounds similar to quit;  I think 'done' is saying that
> the thread is idle having done what was asked?

Since we know that valid address won't be zero, not sure whether we
can just avoid introducing the "done" field (even, not sure whether we
will need lock when modifying "address", I think not as well? Please
see below). For what I see this, it works like a state machine, and
"address" can be the state:

            +--------  send thread ---------+
            |                               |
           \|/                              |
        address==0 (IDLE)               address!=0 (ACTIVE)
            |                              /|\
            |                               |
            +--------  main thread ---------+

Then...

> 
> >  };
> >  typedef struct MultiFDSendParams MultiFDSendParams;
> >  
> > @@ -375,6 +381,8 @@ struct {
> >      MultiFDSendParams *params;
> >      /* number of created threads */
> >      int count;
> > +    QemuMutex mutex;
> > +    QemuSemaphore sem;
> >  } *multifd_send_state;
> >  
> >  static void terminate_multifd_send_threads(void)
> > @@ -443,6 +451,7 @@ static void *multifd_send_thread(void *opaque)
> >      } else {
> >          qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
> >      }
> > +    qemu_sem_post(&multifd_send_state->sem);
> >  
> >      while (!exit) {
> >          qemu_mutex_lock(&p->mutex);
> > @@ -450,6 +459,15 @@ static void *multifd_send_thread(void *opaque)
> >              qemu_mutex_unlock(&p->mutex);
> >              break;
> >          }
> > +        if (p->address) {
> > +            p->address = 0;
> > +            qemu_mutex_unlock(&p->mutex);
> > +            qemu_mutex_lock(&multifd_send_state->mutex);
> > +            p->done = true;
> > +            qemu_mutex_unlock(&multifd_send_state->mutex);
> > +            qemu_sem_post(&multifd_send_state->sem);
> > +            continue;

Here instead of setting up address=0 at the entry, can we do this (no
"done" for this time)?

                 // send the page before clearing p->address
                 send_page(p->address);
                 // clear p->address to switch to "IDLE" state
                 atomic_set(&p->address, 0);
                 // tell main thread, in case it's waiting
                 qemu_sem_post(&multifd_send_state->sem);

And on the main thread...

> > +        }
> >          qemu_mutex_unlock(&p->mutex);
> >          qemu_sem_wait(&p->sem);
> >      }
> > @@ -469,6 +487,8 @@ int multifd_save_setup(void)
> >      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
> >      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> >      multifd_send_state->count = 0;
> > +    qemu_mutex_init(&multifd_send_state->mutex);
> > +    qemu_sem_init(&multifd_send_state->sem, 0);
> >      for (i = 0; i < thread_count; i++) {
> >          char thread_name[16];
> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> > @@ -477,6 +497,8 @@ int multifd_save_setup(void)
> >          qemu_sem_init(&p->sem, 0);
> >          p->quit = false;
> >          p->id = i;
> > +        p->done = true;
> > +        p->address = 0;
> >          p->c = socket_send_channel_create();
> >          if (!p->c) {
> >              error_report("Error creating a send channel");
> > @@ -491,6 +513,30 @@ int multifd_save_setup(void)
> >      return 0;
> >  }
> >  
> > +static int multifd_send_page(uint8_t *address)
> > +{
> > +    int i;
> > +    MultiFDSendParams *p = NULL; /* make happy gcc */
> > +


> > +    qemu_sem_wait(&multifd_send_state->sem);
> > +    qemu_mutex_lock(&multifd_send_state->mutex);
> > +    for (i = 0; i < multifd_send_state->count; i++) {
> > +        p = &multifd_send_state->params[i];
> > +
> > +        if (p->done) {
> > +            p->done = false;
> > +            break;
> > +        }
> > +    }
> > +    qemu_mutex_unlock(&multifd_send_state->mutex);
> > +    qemu_mutex_lock(&p->mutex);
> > +    p->address = address;
> > +    qemu_mutex_unlock(&p->mutex);
> > +    qemu_sem_post(&p->sem);

... here can we just do this?

retry:
    // don't take any lock, only read each p->address
    for (i = 0; i < multifd_send_state->count; i++) {
        p = &multifd_send_state->params[i];
        if (!p->address) {
            // we found one IDLE send thread
            break;
        }
    }
    if (!p) {
        qemu_sem_wait(&multifd_send_state->sem);
        goto retry;
    }
    // we switch its state, IDLE -> ACTIVE
    atomic_set(&p->address, address);
    // tell the thread to start work
    qemu_sem_post(&p->sem);

Above didn't really use any lock at all (either the per thread lock,
or the global lock). Would it work?

Thanks,

-- 
Peter Xu
