Received: from eggs.gnu.org ([2001:4830:134:3::10]:41974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcTlu-0007k1-6i
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcTlr-0002lj-J6
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcTlr-0002lX-7v
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 05:47:23 -0400
Date: Tue, 1 Aug 2017 10:47:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801094715.GE2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-13-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-13-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 12/29] migration: allow dst vm pause on
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
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

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
>  migration/savevm.c     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  migration/trace-events |  2 ++
>  4 files changed, 51 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 0bc70c8..c729c5a 100644
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
> index 24cdaf6..08b90e8 100644
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
> index 13ae9d6..1f62268 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1954,11 +1954,41 @@ void qemu_loadvm_state_cleanup(void)
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
> +    qemu_fclose(mis->to_src_file);
> +    mis->to_src_file = NULL;
> +    qemu_mutex_unlock(&mis->rp_mutex);

Hmm is that safe?  If we look at migrate_send_rp_message we have:

    static void migrate_send_rp_message(MigrationIncomingState *mis,
                                        enum mig_rp_message_type message_type,
                                        uint16_t len, void *data)
    {
        trace_migrate_send_rp_message((int)message_type, len);
        qemu_mutex_lock(&mis->rp_mutex);
        qemu_put_be16(mis->to_src_file, (unsigned int)message_type);
        qemu_put_be16(mis->to_src_file, len);
        qemu_put_buffer(mis->to_src_file, data, len);
        qemu_fflush(mis->to_src_file);
        qemu_mutex_unlock(&mis->rp_mutex);
    }

If we came into postcopy_pause_incoming at about the same time
migrate_send_rp_message was being called and pause_incoming took the
lock first, then once it release the lock, send_rp_message carries on
and uses mis->to_src_file that's now NULL.

One solution here is to just call qemu_file_shutdown() but leave the
files open at this point, but clean the files up sometime later.

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
> @@ -2004,6 +2034,21 @@ static int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis)
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

I wonder if:

           if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE &&
               ret == -EIO && postcopy_pause_incoming(mis)) {
               /* Try again after postcopy recovery */
               return qemu_loadvm_state_main(mis->from_src_file, mis);
           }
would be nicer; it avoids the goto loop.

Dave

>      }
>      return ret;
>  }
> diff --git a/migration/trace-events b/migration/trace-events
> index 2211acc..22a629e 100644
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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
