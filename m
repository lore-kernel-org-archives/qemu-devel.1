Received: from eggs.gnu.org ([2001:4830:134:3::10]:54686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG0qf-0004Fb-I0
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fG0qb-000396-GL
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:32:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fG0qb-00038w-Aa
	for qemu-devel@nongnu.org; Tue, 08 May 2018 07:31:57 -0400
Date: Tue, 8 May 2018 12:31:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180508113148.GJ2500@work-vm>
References: <20180502104740.12123-1-peterx@redhat.com>
	<20180502104740.12123-23-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502104740.12123-23-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 22/24] migration: introduce lock for
 to_dst_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> Let's introduce a lock for that QEMUFile since we are going to operate
> on it in multiple threads.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.h |  6 ++++++
>  migration/channel.c   |  3 ++-
>  migration/migration.c | 22 +++++++++++++++++++---
>  3 files changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index 012bcd352b..f6b9e774f9 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -114,6 +114,12 @@ struct MigrationState
>      QemuThread thread;
>      QEMUBH *cleanup_bh;
>      QEMUFile *to_dst_file;
> +    /*
> +     * Protects to_dst_file pointer.  We need to make sure we won't
> +     * yield or hang during the critical section, since this lock will
> +     * be used in OOB command handler.
> +     */
> +    QemuMutex qemu_file_lock;

So what are the rules on access to_dst_file?
You only seem to be taking the lock when closing or setting the
to_dst_file.  Which I think given the problem we were trying
to fix is OK, but it needs to be commented to say why it's safe.

Dave

>      /* bytes already send at the beggining of current interation */
>      uint64_t iteration_initial_bytes;
> diff --git a/migration/channel.c b/migration/channel.c
> index c5eaf0fa0e..716192bf75 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -74,8 +74,9 @@ void migration_channel_connect(MigrationState *s,
>          } else {
>              QEMUFile *f = qemu_fopen_channel_output(ioc);
>  
> +            qemu_mutex_lock(&s->qemu_file_lock);
>              s->to_dst_file = f;
> -
> +            qemu_mutex_unlock(&s->qemu_file_lock);
>          }
>      }
>      migrate_fd_connect(s, error);
> diff --git a/migration/migration.c b/migration/migration.c
> index 03d1fc7bc3..25f26052d2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1229,6 +1229,7 @@ static void migrate_fd_cleanup(void *opaque)
>  
>      if (s->to_dst_file) {
>          Error *local_err = NULL;
> +        QEMUFile *tmp;
>  
>          trace_migrate_fd_cleanup();
>          qemu_mutex_unlock_iothread();
> @@ -1241,8 +1242,15 @@ static void migrate_fd_cleanup(void *opaque)
>          if (multifd_save_cleanup(&local_err) != 0) {
>              error_report_err(local_err);
>          }
> -        qemu_fclose(s->to_dst_file);
> +        qemu_mutex_lock(&s->qemu_file_lock);
> +        tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
> +        qemu_mutex_unlock(&s->qemu_file_lock);
> +        /*
> +         * Close the file handle without the lock to make sure the
> +         * critical section won't block for long.
> +         */
> +        qemu_fclose(tmp);
>      }
>  
>      assert((s->state != MIGRATION_STATUS_ACTIVE) &&
> @@ -2526,14 +2534,20 @@ static MigThrError postcopy_pause(MigrationState *s)
>      assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>  
>      while (true) {
> +        QEMUFile *file;
> +
>          migrate_set_state(&s->state, s->state,
>                            MIGRATION_STATUS_POSTCOPY_PAUSED);
>  
>          /* Current channel is possibly broken. Release it. */
>          assert(s->to_dst_file);
> -        qemu_file_shutdown(s->to_dst_file);
> -        qemu_fclose(s->to_dst_file);
> +        qemu_mutex_lock(&s->qemu_file_lock);
> +        file = s->to_dst_file;
>          s->to_dst_file = NULL;
> +        qemu_mutex_unlock(&s->qemu_file_lock);
> +
> +        qemu_file_shutdown(file);
> +        qemu_fclose(file);
>  
>          error_report("Detected IO failure for postcopy. "
>                       "Migration paused.");
> @@ -3002,6 +3016,7 @@ static void migration_instance_finalize(Object *obj)
>      MigrationParameters *params = &ms->parameters;
>  
>      qemu_mutex_destroy(&ms->error_mutex);
> +    qemu_mutex_destroy(&ms->qemu_file_lock);
>      g_free(params->tls_hostname);
>      g_free(params->tls_creds);
>      qemu_sem_destroy(&ms->pause_sem);
> @@ -3041,6 +3056,7 @@ static void migration_instance_init(Object *obj)
>      qemu_sem_init(&ms->postcopy_pause_sem, 0);
>      qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
> +    qemu_mutex_init(&ms->qemu_file_lock);
>  }
>  
>  /*
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
