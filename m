Received: from eggs.gnu.org ([2001:4830:134:3::10]:39597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddGaO-0003A5-Cw
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ddGaJ-0007NE-Px
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:54:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ddGaJ-0007Lv-Gn
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 09:54:43 -0400
Date: Thu, 3 Aug 2017 14:54:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170803135434.GB3673@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-30-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-30-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 29/29] migration: reset migrate thread vars
 when resumed
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
> Firstly, MigThrError enumeration is introduced to describe the error in
> migration_detect_error() better. This gives the migration_thread() a
> chance to know whether a recovery has happened.
> 
> Then, if a recovery is detected, migration_thread() will reset its local
> variables to prepare for that.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 40 +++++++++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ecebe30..439bc22 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2159,6 +2159,15 @@ static bool postcopy_should_start(MigrationState *s)
>      return atomic_read(&s->start_postcopy) || s->start_postcopy_fast;
>  }
>  
> +typedef enum MigThrError {
> +    /* No error detected */
> +    MIG_THR_ERR_NONE = 0,
> +    /* Detected error, but resumed successfully */
> +    MIG_THR_ERR_RECOVERED = 1,
> +    /* Detected fatal error, need to exit */
> +    MIG_THR_ERR_FATAL = 2,
> +} MigThrError;
> +

Could you move this patch earlier to when postcopy_pause is created
so it's created with this enum?

>  static int postcopy_resume_handshake(MigrationState *s)
>  {
>      qemu_mutex_lock(&s->resume_lock);
> @@ -2209,10 +2218,10 @@ static int postcopy_do_resume(MigrationState *s)
>  
>  /*
>   * We don't return until we are in a safe state to continue current
> - * postcopy migration.  Returns true to continue the migration, or
> - * false to terminate current migration.
> + * postcopy migration.  Returns MIG_THR_ERR_RECOVERED if recovered, or
> + * MIG_THR_ERR_FATAL if unrecovery failure happened.
>   */
> -static bool postcopy_pause(MigrationState *s)
> +static MigThrError postcopy_pause(MigrationState *s)
>  {
>      assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>  
> @@ -2247,7 +2256,7 @@ do_pause:
>          if (postcopy_do_resume(s) == 0) {
>              /* Let's continue! */
>              trace_postcopy_pause_continued();
> -            return true;
> +            return MIG_THR_ERR_RECOVERED;
>          } else {
>              /*
>               * Something wrong happened during the recovery, let's
> @@ -2258,12 +2267,11 @@ do_pause:
>          }
>      } else {
>          /* This is not right... Time to quit. */
> -        return false;
> +        return MIG_THR_ERR_FATAL;
>      }
>  }
>  
> -/* Return true if we want to stop the migration, otherwise false. */
> -static bool migration_detect_error(MigrationState *s)
> +static MigThrError migration_detect_error(MigrationState *s)
>  {
>      int ret;
>  
> @@ -2272,7 +2280,7 @@ static bool migration_detect_error(MigrationState *s)
>  
>      if (!ret) {
>          /* Everything is fine */
> -        return false;
> +        return MIG_THR_ERR_NONE;
>      }
>  
>      if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret == -EIO) {
> @@ -2281,7 +2289,7 @@ static bool migration_detect_error(MigrationState *s)
>           * while. After that, it can be continued by a
>           * recovery phase.
>           */
> -        return !postcopy_pause(s);
> +        return postcopy_pause(s);
>      } else {
>          /*
>           * For precopy (or postcopy with error outside IO), we fail
> @@ -2291,7 +2299,7 @@ static bool migration_detect_error(MigrationState *s)
>          trace_migration_thread_file_err();
>  
>          /* Time to stop the migration, now. */
> -        return true;
> +        return MIG_THR_ERR_FATAL;
>      }
>  }
>  
> @@ -2319,6 +2327,7 @@ static void *migration_thread(void *opaque)
>      /* The active state we expect to be in; ACTIVE or POSTCOPY_ACTIVE */
>      enum MigrationStatus current_active_state = MIGRATION_STATUS_ACTIVE;
>      bool enable_colo = migrate_colo_enabled();
> +    MigThrError thr_error;
>  
>      rcu_register_thread();
>  
> @@ -2395,8 +2404,17 @@ static void *migration_thread(void *opaque)
>           * Try to detect any kind of failures, and see whether we
>           * should stop the migration now.
>           */
> -        if (migration_detect_error(s)) {
> +        thr_error = migration_detect_error(s);
> +        if (thr_error == MIG_THR_ERR_FATAL) {
> +            /* Stop migration */
>              break;
> +        } else if (thr_error == MIG_THR_ERR_RECOVERED) {
> +            /*
> +             * Just recovered from a e.g. network failure, reset all
> +             * the local variables.
> +             */
> +            initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +            initial_bytes = 0;

They don't seem that important to reset?

Dave

>          }
>  
>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
