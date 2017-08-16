Received: from eggs.gnu.org ([2001:4830:134:3::10]:40125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1di1LI-0000J9-U9
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:38:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1di1LF-0007CS-ON
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:38:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1di1LF-0007Bq-El
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 12:38:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DC793C58
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 16:38:46 +0000 (UTC)
Date: Wed, 16 Aug 2017 17:38:39 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170816163839.GC2494@work-vm>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-19-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 18/19] migration: Transfer pages over
 new channels
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We switch for sending the page number to send real pages.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> 
> Remove the HACK bit, now we have the function that calculates the size
> of a page exported.
> ---
>  migration/migration.c |  7 +++++-
>  migration/ram.c       | 59 +++++++++++++++++----------------------------------
>  2 files changed, 25 insertions(+), 41 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 974ff92..aac3cdc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2051,6 +2051,7 @@ static void *migration_thread(void *opaque)
>       */
>      int64_t threshold_size = 0;
>      int64_t qemu_file_bytes = 0;
> +    int64_t multifd_pages = 0;
>      int64_t start_time = initial_time;
>      int64_t end_time;
>      bool old_vm_running = false;
> @@ -2139,8 +2140,11 @@ static void *migration_thread(void *opaque)
>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>          if (current_time >= initial_time + BUFFER_DELAY) {
>              uint64_t qemu_file_bytes_now = qemu_ftell(s->to_dst_file);
> +            uint64_t multifd_pages_now = ram_counters.multifd;
>              uint64_t transferred_bytes =
> -                qemu_file_bytes_now - qemu_file_bytes;
> +                (qemu_file_bytes_now - qemu_file_bytes) +
> +                (multifd_pages_now - multifd_pages) *
> +                qemu_target_page_size();
>              uint64_t time_spent = current_time - initial_time;
>              double bandwidth = (double)transferred_bytes / time_spent;
>              threshold_size = bandwidth * s->parameters.downtime_limit;
> @@ -2160,6 +2164,7 @@ static void *migration_thread(void *opaque)
>              qemu_file_reset_rate_limit(s->to_dst_file);
>              initial_time = current_time;
>              qemu_file_bytes = qemu_file_bytes_now;
> +            multifd_pages = multifd_pages_now;
>          }
>          if (qemu_file_rate_limit(s->to_dst_file)) {
>              /* usleep expects microseconds */
> diff --git a/migration/ram.c b/migration/ram.c
> index 42ad126..f337360 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -479,25 +479,21 @@ static void *multifd_send_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> -            int i;
>              int num;
>  
>              num = p->pages.num;
>              p->pages.num = 0;
>              qemu_mutex_unlock(&p->mutex);
>  
> -            for (i = 0; i < num; i++) {
> -                if (qio_channel_write(p->c,
> -                                      (const char *)&p->pages.iov[i].iov_base,
> -                                      sizeof(uint8_t *), &error_abort)
> -                    != sizeof(uint8_t *)) {
> -                    MigrationState *s = migrate_get_current();
> +            if (qio_channel_writev_all(p->c, p->pages.iov,
> +                                       num, &error_abort)

One way out of the problem of errors might be to add an
  Error *errp;

to MultiFD*Params, and make sure it's NULL initially;
then instead of &error_abort you can have &p->errp,
I think we're already guaranteed the lifetime of the
params is at least the length of the thread and then
you can check p->errp before you free the params.

You could also return this value as the return value of
the thread as an easy way to flag the thread failed when the
join happens.

Dave


> +                != num * TARGET_PAGE_SIZE) {
> +                MigrationState *s = migrate_get_current();
>  
> -                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                                      MIGRATION_STATUS_FAILED);
> -                    terminate_multifd_send_threads();
> -                    return NULL;
> -                }
> +                migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                                  MIGRATION_STATUS_FAILED);
> +                terminate_multifd_send_threads();
> +                return NULL;
>              }
>              qemu_mutex_lock(&multifd_send_state->mutex);
>              p->done = true;
> @@ -658,7 +654,6 @@ void multifd_load_cleanup(void)
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
> -    uint8_t *recv_address;
>  
>      qemu_sem_post(&p->ready);
>      while (true) {
> @@ -668,38 +663,21 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>          if (p->pages.num) {
> -            int i;
>              int num;
>  
>              num = p->pages.num;
>              p->pages.num = 0;
>  
> -            for (i = 0; i < num; i++) {
> -                if (qio_channel_read(p->c,
> -                                     (char *)&recv_address,
> -                                     sizeof(uint8_t *), &error_abort)
> -                    != sizeof(uint8_t *)) {
> -                    MigrationState *s = migrate_get_current();
> +            if (qio_channel_readv_all(p->c, p->pages.iov,
> +                                      num, &error_abort)
> +                != num * TARGET_PAGE_SIZE) {
> +                MigrationState *s = migrate_get_current();
>  
> -                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                                      MIGRATION_STATUS_FAILED);
> -                    terminate_multifd_recv_threads();
> -                    return NULL;
> -                }
> -                if (recv_address != p->pages.iov[i].iov_base) {
> -                    MigrationState *s = migrate_get_current();
> -
> -                    printf("We received %p what we were expecting %p (%d)\n",
> -                           recv_address,
> -                           p->pages.iov[i].iov_base, i);
> -
> -                    migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                                      MIGRATION_STATUS_FAILED);
> -                    terminate_multifd_recv_threads();
> -                    return NULL;
> -                }
> +                migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> +                                  MIGRATION_STATUS_FAILED);
> +                terminate_multifd_recv_threads();
> +                return NULL;
>              }
> -
>              p->done = true;
>              qemu_mutex_unlock(&p->mutex);
>              qemu_sem_post(&p->ready);
> @@ -1259,8 +1237,10 @@ static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
>                               offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
>          fd_num = multifd_send_page(p, rs->migration_dirty_pages == 1);
>          qemu_put_be16(rs->f, fd_num);
> +        if (fd_num != MULTIFD_CONTINUE) {
> +            qemu_fflush(rs->f);
> +        }
>          ram_counters.transferred += 2; /* size of fd_num */
> -        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
>          ram_counters.transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          ram_counters.normal++;
> @@ -3123,7 +3103,6 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>              fd_num = qemu_get_be16(f);
>              multifd_recv_page(host, fd_num);
> -            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
>  
>          case RAM_SAVE_FLAG_EOS:
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
