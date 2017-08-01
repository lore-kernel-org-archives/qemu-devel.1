Received: from eggs.gnu.org ([2001:4830:134:3::10]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcVTX-00024N-A0
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dcVTS-00089Y-Bs
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dcVTS-00088e-2h
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:36:30 -0400
Date: Tue, 1 Aug 2017 12:36:22 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170801113622.GK2079@work-vm>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-19-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501229198-30588-19-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC 18/29] migration: new state "postcopy-recover"
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
> Introducing new migration state "postcopy-recover". If a migration
> procedure is paused and the connection is rebuilt afterward
> successfully, we'll switch the source VM state from "postcopy-paused" to
> the new state "postcopy-recover", then we'll do the resume logic in the
> migration thread (along with the return path thread).
> 
> This patch only do the state switch on source side. Another following up
> patch will handle the state switching on destination side using the same
> status bit.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 45 +++++++++++++++++++++++++++++++++++++++++----
>  qapi-schema.json      |  4 +++-
>  2 files changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 64de0ee..3aabe11 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -495,6 +495,7 @@ static bool migration_is_setup_or_active(int state)
>      case MIGRATION_STATUS_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
>      case MIGRATION_STATUS_SETUP:
>          return true;
>  
> @@ -571,6 +572,7 @@ MigrationInfo *qmp_query_migrate(Error **errp)
>      case MIGRATION_STATUS_CANCELLING:
>      case MIGRATION_STATUS_POSTCOPY_ACTIVE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +    case MIGRATION_STATUS_POSTCOPY_RECOVER:
>           /* TODO add some postcopy stats */
>          info->has_status = true;
>          info->has_total_time = true;
> @@ -2018,6 +2020,13 @@ static bool postcopy_should_start(MigrationState *s)
>      return atomic_read(&s->start_postcopy) || s->start_postcopy_fast;
>  }
>  
> +/* Return zero if success, or <0 for error */
> +static int postcopy_do_resume(MigrationState *s)
> +{
> +    /* TODO: do the resume logic */
> +    return 0;
> +}
> +
>  /*
>   * We don't return until we are in a safe state to continue current
>   * postcopy migration.  Returns true to continue the migration, or
> @@ -2026,7 +2035,9 @@ static bool postcopy_should_start(MigrationState *s)
>  static bool postcopy_pause(MigrationState *s)
>  {
>      assert(s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
> -    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
> +
> +do_pause:
> +    migrate_set_state(&s->state, s->state,
>                        MIGRATION_STATUS_POSTCOPY_PAUSED);
>  
>      /* Current channel is possibly broken. Release it. */
> @@ -2043,9 +2054,32 @@ static bool postcopy_pause(MigrationState *s)
>          qemu_sem_wait(&s->postcopy_pause_sem);
>      }
>  
> -    trace_postcopy_pause_continued();
> +    if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
> +        /* We were waken up by a recover procedure. Give it a shot */
>  
> -    return true;
> +        /*
> +         * Firstly, let's wake up the return path now, with a new
> +         * return path channel.
> +         */
> +        qemu_sem_post(&s->postcopy_pause_rp_sem);
> +
> +        /* Do the resume logic */
> +        if (postcopy_do_resume(s) == 0) {
> +            /* Let's continue! */
> +            trace_postcopy_pause_continued();
> +            return true;
> +        } else {
> +            /*
> +             * Something wrong happened during the recovery, let's
> +             * pause again. Pause is always better than throwing data
> +             * away.
> +             */
> +            goto do_pause;

You should be able to turn this around into a do {} while or similar
rather than goto.

Dave

> +        }
> +    } else {
> +        /* This is not right... Time to quit. */
> +        return false;
> +    }
>  }
>  
>  /* Return true if we want to stop the migration, otherwise false. */
> @@ -2300,7 +2334,10 @@ void migrate_fd_connect(MigrationState *s)
>      }
>  
>      if (resume) {
> -        /* TODO: do the resume logic */
> +        /* Wakeup the main migration thread to do the recovery */
> +        migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
> +                          MIGRATION_STATUS_POSTCOPY_RECOVER);
> +        qemu_sem_post(&s->postcopy_pause_sem);
>          return;
>      }
>  
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 27b7c4c..10f1f60 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -669,6 +669,8 @@
>  #
>  # @postcopy-paused: during postcopy but paused. (since 2.10)
>  #
> +# @postcopy-recover: trying to recover from a paused postcopy. (since 2.11)
> +#
>  # @completed: migration is finished.
>  #
>  # @failed: some error occurred during migration process.
> @@ -682,7 +684,7 @@
>  { 'enum': 'MigrationStatus',
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>              'active', 'postcopy-active', 'postcopy-paused',
> -            'completed', 'failed', 'colo' ] }
> +            'postcopy-recover', 'completed', 'failed', 'colo' ] }
>  
>  ##
>  # @MigrationInfo:
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
