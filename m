Received: from eggs.gnu.org ([2001:4830:134:3::10]:58622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvJxQ-0000HD-LB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dvJxM-0004d7-Id
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:09:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dvJxM-0004cF-Af
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:09:08 -0400
Date: Fri, 22 Sep 2017 10:09:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170922090900.GA2620@work-vm>
References: <1504081950-2528-1-git-send-email-peterx@redhat.com>
	<1504081950-2528-16-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504081950-2528-16-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 15/33] migration: pass MigrationState to
 migrate_init()
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
> Let the callers take the object, then pass it to migrate_init().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 7 ++-----
>  migration/migration.h | 2 +-
>  migration/savevm.c    | 5 ++++-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 394e84b..15b8eb1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1138,10 +1138,8 @@ bool migration_is_idle(void)
>      return false;
>  }
>  
> -MigrationState *migrate_init(void)
> +void migrate_init(MigrationState *s)
>  {
> -    MigrationState *s = migrate_get_current();
> -
>      /*
>       * Reinitialise all migration state, except
>       * parameters/capabilities that the user set, and
> @@ -1169,7 +1167,6 @@ MigrationState *migrate_init(void)
>      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
>  
>      s->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -    return s;
>  }
>  
>  static GSList *migration_blockers;
> @@ -1277,7 +1274,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          migrate_set_block_incremental(s, true);
>      }
>  
> -    s = migrate_init();
> +    migrate_init(s);
>  
>      if (strstart(uri, "tcp:", &p)) {
>          tcp_start_outgoing_migration(s, p, &local_err);
> diff --git a/migration/migration.h b/migration/migration.h
> index 338dfe3..b78b9bd 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -169,7 +169,7 @@ void migrate_fd_error(MigrationState *s, const Error *error);
>  
>  void migrate_fd_connect(MigrationState *s);
>  
> -MigrationState *migrate_init(void);
> +void migrate_init(MigrationState *s);
>  bool migration_is_blocked(Error **errp);
>  /* True if outgoing migration has entered postcopy phase */
>  bool migration_in_postcopy(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index a3162c1..c9bccf7 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1224,8 +1224,11 @@ void qemu_savevm_state_cleanup(void)
>  static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  {
>      int ret;
> -    MigrationState *ms = migrate_init();
> +    MigrationState *ms = migrate_get_current();
>      MigrationStatus status;
> +
> +    migrate_init(ms);
> +
>      ms->to_dst_file = f;
>  
>      if (migration_is_blocked(errp)) {
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
