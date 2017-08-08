Received: from eggs.gnu.org ([2001:4830:134:3::10]:34100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df7Pj-0005vO-OL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:31:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1df7Pg-0002O6-Fd
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:31:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1df7Pg-0002NP-6H
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 12:31:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BDC7806B8
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 16:31:23 +0000 (UTC)
Date: Tue, 8 Aug 2017 17:30:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170808163047.GP2081@work-vm>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm> <87lgmu8346.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lgmu8346.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > * Juan Quintela (quintela@redhat.com) wrote:
> >> The function still don't use multifd, but we have simplified
> >> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> >> counter and a new flag for this type of pages.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> ---
> >>  hmp.c                 |  2 ++
> >>  migration/migration.c |  1 +
> >>  migration/ram.c       | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  qapi-schema.json      |  5 ++-
> >>  4 files changed, 96 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/hmp.c b/hmp.c
> >> index b01605a..eeb308b 100644
> >> --- a/hmp.c
> >> +++ b/hmp.c
> >> @@ -234,6 +234,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
> >>              monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
> >>                             info->ram->postcopy_requests);
> >>          }
> >> +        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
> >> +                       info->ram->multifd);
> >>      }
> >>  
> >>      if (info->has_disk) {
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index e1c79d5..d9d5415 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -528,6 +528,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
> >>      info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
> >>      info->ram->postcopy_requests = ram_counters.postcopy_requests;
> >>      info->ram->page_size = qemu_target_page_size();
> >> +    info->ram->multifd = ram_counters.multifd;
> >>  
> >>      if (migrate_use_xbzrle()) {
> >>          info->has_xbzrle_cache = true;
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index b80f511..2bf3fa7 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -68,6 +68,7 @@
> >>  #define RAM_SAVE_FLAG_XBZRLE   0x40
> >>  /* 0x80 is reserved in migration.h start with 0x100 next */
> >>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> >> +#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
> >>  
> >>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
> >>  {
> >> @@ -362,12 +363,17 @@ static void compress_threads_save_setup(void)
> >>  /* Multiple fd's */
> >>  
> >>  struct MultiFDSendParams {
> >> +    /* not changed */
> >>      uint8_t id;
> >>      QemuThread thread;
> >>      QIOChannel *c;
> >>      QemuSemaphore sem;
> >>      QemuMutex mutex;
> >> +    /* protected by param mutex */
> >>      bool quit;
> >
> > Should probably comment to say what address space address is in - this
> > is really a qemu pointer - and that's why we can treat 0 as special?
> 
> Ok.  Added
> 
>     /* This is a temp field.  We are using it now to transmit
>        something the address of the page.  Later in the series, we
>        change it for the real page.
>     */
> 
> 
> >
> >> +    uint8_t *address;
> >> +    /* protected by multifd mutex */
> >> +    bool done;
> >
> > done needs a comment to explain what it is because
> > it sounds similar to quit;  I think 'done' is saying that
> > the thread is idle having done what was asked?
> 
>     /* has the thread finish the last submitted job */
> 
> >> +static int multifd_send_page(uint8_t *address)
> >> +{
> >> +    int i;
> >> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> >> +
> >> +    qemu_sem_wait(&multifd_send_state->sem);
> >> +    qemu_mutex_lock(&multifd_send_state->mutex);
> >> +    for (i = 0; i < multifd_send_state->count; i++) {
> >> +        p = &multifd_send_state->params[i];
> >> +
> >> +        if (p->done) {
> >> +            p->done = false;
> >> +            break;
> >> +        }
> >> +    }
> >> +    qemu_mutex_unlock(&multifd_send_state->mutex);
> >> +    qemu_mutex_lock(&p->mutex);
> >> +    p->address = address;
> >> +    qemu_mutex_unlock(&p->mutex);
> >> +    qemu_sem_post(&p->sem);
> >
> > My feeling, without having fully thought it through, is that
> > the locking around 'address' can be simplified; especially if the
> > sending-thread never actually changes it.
> >
> > http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_11
> > defines that most of the pthread_ functions act as barriers;
> > including the sem_post and pthread_cond_signal that qemu_sem_post
> > uses.
> 
> At the end of the series the code is this:
> 
>     qemu_mutex_lock(&p->mutex);
>     p->pages.num = pages->num;
>     iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
>              iov_size(pages->iov, pages->num));
>     pages->num = 0;
>     qemu_mutex_unlock(&p->mutex);
>  
> Are you sure that it looks like a good idea to drop the mutex?
> 
> The other thread uses pages->num to know if things are ready.

Well, I wont push it too hard, but; if you:
  a) Know that the other thread isn't accessing the iov
      (because you previously know that it had set done)
  b) Know the other thread wont access it until pages->num gets
     set
  c) Ensure that all changes to the iov are visible before
     the pages->num write is visible - appropriate barriers/ordering

then you're good.  However, the mutex might be simpler.

Dave

> >
> >> +    return 0;
> >> +}
> >> +
> >>  struct MultiFDRecvParams {
> >>      uint8_t id;
> >>      QemuThread thread;
> >> @@ -537,6 +583,7 @@ void multifd_load_cleanup(void)
> >>          qemu_sem_destroy(&p->sem);
> >>          socket_recv_channel_destroy(p->c);
> >>          g_free(p);
> >> +        multifd_recv_state->params[i] = NULL;
> >>      }
> >>      g_free(multifd_recv_state->params);
> >>      multifd_recv_state->params = NULL;
> >> @@ -1058,6 +1105,32 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
> >>      return pages;
> >>  }
> >>  
> >> +static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
> >> +                            bool last_stage)
> >> +{
> >> +    int pages;
> >> +    uint8_t *p;
> >> +    RAMBlock *block = pss->block;
> >> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> >> +
> >> +    p = block->host + offset;
> >> +
> >> +    pages = save_zero_page(rs, block, offset, p);
> >> +    if (pages == -1) {
> >> +        ram_counters.transferred +=
> >> +            save_page_header(rs, rs->f, block,
> >> +                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> >> +        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> >> +        multifd_send_page(p);
> >> +        ram_counters.transferred += TARGET_PAGE_SIZE;
> >> +        pages = 1;
> >> +        ram_counters.normal++;
> >> +        ram_counters.multifd++;
> >> +    }
> >> +
> >> +    return pages;
> >> +}
> >> +
> >>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
> >>                                  ram_addr_t offset)
> >>  {
> >> @@ -1486,6 +1559,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
> >>          if (migrate_use_compression() &&
> >>              (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
> >>              res = ram_save_compressed_page(rs, pss, last_stage);
> >> +        } else if (migrate_use_multifd()) {
> >> +            res = ram_multifd_page(rs, pss, last_stage);
> >
> > It's a pity we can't wire this up with compression, but I understand
> > why you simplify that.
> >
> > I'll see how the multiple-pages stuff works below; but the interesting
> > thing here is we've already split up host-pages, which seems like a bad
> > idea.
> 
> It is.  But I can't fix all the world in one go :-(
> >>  #        statistics (since 2.10)
> >>  #
> >> +# @multifd: number of pages sent with multifd (since 2.10)
> >
> > Hopeful!
> 
> Everything puts 2.11.
> 
> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
