Received: from eggs.gnu.org ([2001:4830:134:3::10]:57785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv79w-0008RH-JR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dv79t-0002jC-EP
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:29:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dv79t-0002iQ-4o
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 15:29:13 -0400
Date: Thu, 21 Sep 2017 20:29:03 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170921192903.GH3401@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-11-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-11-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 10/33] migration: allow dst vm pause on
 postcopy
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
> When there is IO error on the incoming channel (e.g., network down),
> instead of bailing out immediately, we allow the dst vm to switch to the
> new POSTCOPY_PAUSE state. Currently it is still simple - it waits the
> new semaphore, until someone poke it for another attempt.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c  |  1 +
>  migration/migration.h  |  3 +++
>  migration/savevm.c     | 60 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  migration/trace-events |  2 ++
>  4 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8d26ea8..80de212 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -146,6 +146,7 @@ MigrationIncomingState *migration_incoming_get_current(void)
>          memset(&mis_current, 0, sizeof(MigrationIncomingState));
>          qemu_mutex_init(&mis_current.rp_mutex);
>          qemu_event_init(&mis_current.main_thread_load_event, false);
> +        qemu_sem_init(&mis_current.postcopy_pause_sem_dst, 0);
>          once = true;
>      }
>      return &mis_current;
> diff --git a/migration/migration.h b/migration/migration.h
> index 0c957c9..c423682 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -60,6 +60,9 @@ struct MigrationIncomingState {
>      /* The coroutine we should enter (back) after failover */
>      Coroutine *migration_incoming_co;
>      QemuSemaphore colo_incoming_sem;
> +
> +    /* notify PAUSED postcopy incoming migrations to try to continue */
> +    QemuSemaphore postcopy_pause_sem_dst;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7172f14..3777124 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1488,8 +1488,8 @@ static int loadvm_postcopy_ram_handle_discard(MigrationIncomingState *mis,
>   */
>  static void *postcopy_ram_listen_thread(void *opaque)
>  {
> -    QEMUFile *f = opaque;
>      MigrationIncomingState *mis = migration_incoming_get_current();
> +    QEMUFile *f = mis->from_src_file;
>      int load_res;
>  
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
> @@ -1503,6 +1503,14 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       */
>      qemu_file_set_blocking(f, true);
>      load_res = qemu_loadvm_state_main(f, mis);
> +
> +    /*
> +     * This is tricky, but, mis->from_src_file can change after it
> +     * returns, when postcopy recovery happened. In the future, we may
> +     * want a wrapper for the QEMUFile handle.
> +     */
> +    f = mis->from_src_file;
> +
>      /* And non-blocking again so we don't block in any cleanup */
>      qemu_file_set_blocking(f, false);
>  
> @@ -1581,7 +1589,7 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
>      /* Start up the listening thread and wait for it to signal ready */
>      qemu_sem_init(&mis->listen_thread_sem, 0);
>      qemu_thread_create(&mis->listen_thread, "postcopy/listen",
> -                       postcopy_ram_listen_thread, mis->from_src_file,
> +                       postcopy_ram_listen_thread, NULL,
>                         QEMU_THREAD_DETACHED);
>      qemu_sem_wait(&mis->listen_thread_sem);
>      qemu_sem_destroy(&mis->listen_thread_sem);
> @@ -1966,11 +1974,44 @@ void qemu_loadvm_state_cleanup(void)
>      }
>  }
>  
> +/* Return true if we should continue the migration, or false. */
> +static bool postcopy_pause_incoming(MigrationIncomingState *mis)
> +{
> +    trace_postcopy_pause_incoming();
> +
> +    migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +                      MIGRATION_STATUS_POSTCOPY_PAUSED);
> +
> +    assert(mis->from_src_file);
> +    qemu_file_shutdown(mis->from_src_file);
> +    qemu_fclose(mis->from_src_file);
> +    mis->from_src_file = NULL;
> +
> +    assert(mis->to_src_file);
> +    qemu_mutex_lock(&mis->rp_mutex);
> +    qemu_file_shutdown(mis->to_src_file);

Should you not do the shutdown() before the lock?
For example if the other thread is stuck, with rp_mutex
held, trying to write to to_src_file, then you'll block
waiting for the mutex.  If you call shutdown and then take
the lock, the other thread will error and release the lock.

I'm not quite sure what will happen if we end up calling this
before the main thread has been returned from postcopy and the
device loading is complete.

Also, at this point have we guaranteed no one else is about
to do an op on mis->to_src_file and will seg?

Dave

> +    qemu_fclose(mis->to_src_file);
> +    mis->to_src_file = NULL;
> +    qemu_mutex_unlock(&mis->rp_mutex);
> +
> +    error_report("Detected IO failure for postcopy. "
> +                 "Migration paused.");
> +
> +    while (mis->state == MIGRATION_STATUS_POSTCOPY_PAUSED) {
> +        qemu_sem_wait(&mis->postcopy_pause_sem_dst);
> +    }
> +
> +    trace_postcopy_pause_incoming_continued();
> +
> +    return true;
> +}
> +
>  static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>  {
>      uint8_t section_type;
>      int ret = 0;
>  
> +retry:
>      while (true) {
>          section_type = qemu_get_byte(f);
>  
> @@ -2016,6 +2057,21 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
>  out:
>      if (ret < 0) {
>          qemu_file_set_error(f, ret);
> +
> +        /*
> +         * Detect whether it is:
> +         *
> +         * 1. postcopy running
> +         * 2. network failure (-EIO)
> +         *
> +         * If so, we try to wait for a recovery.
> +         */
> +        if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
> +            ret == -EIO && postcopy_pause_incoming(mis)) {
> +            /* Reset f to point to the newly created channel */
> +            f = mis->from_src_file;
> +            goto retry;
> +        }
>      }
>      return ret;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index 907564b..7764c6f 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -99,6 +99,8 @@ open_return_path_on_source(void) ""
>  open_return_path_on_source_continue(void) ""
>  postcopy_start(void) ""
>  postcopy_pause_continued(void) ""
> +postcopy_pause_incoming(void) ""
> +postcopy_pause_incoming_continued(void) ""
>  postcopy_start_set_run(void) ""
>  source_return_path_thread_bad_end(void) ""
>  source_return_path_thread_end(void) ""
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
