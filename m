Received: from eggs.gnu.org ([2001:4830:134:3::10]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49DL-0007uf-IV
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d49DG-0000Ev-LC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d49DG-0000Er-BM
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 12:57:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D31A80062
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 16:57:45 +0000 (UTC)
Date: Fri, 28 Apr 2017 17:57:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170428165738.GH3276@work-vm>
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170425103049.4073-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] migration: Remove old MigrationParams
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
> Not used anymore after moving block migration to use capabilities.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h | 10 ++--------
>  include/migration/vmstate.h   |  1 -
>  include/qemu/typedefs.h       |  1 -
>  include/sysemu/sysemu.h       |  3 +--
>  migration/colo.c              |  2 +-
>  migration/migration.c         |  8 +++-----
>  migration/savevm.c            | 16 +++-------------
>  7 files changed, 10 insertions(+), 31 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 2917baa..3495162 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -41,10 +41,6 @@
>  /* for vl.c */
>  extern int only_migratable;
>  
> -struct MigrationParams {
> -    bool unused; /* C don't allow empty structs */
> -};
> -
>  /* Messages sent on the return path from destination to source */
>  enum mig_rp_message_type {
>      MIG_RP_MSG_INVALID = 0,  /* Must be 0 */
> @@ -134,12 +130,10 @@ struct MigrationState
>      QEMUBH *cleanup_bh;
>      QEMUFile *to_dst_file;
>  
> -    /* New style params from 'migrate-set-parameters' */
> +    /* params from 'migrate-set-parameters' */
>      MigrationParameters parameters;
>  
>      int state;
> -    /* Old style params from 'migrate' command */
> -    MigrationParams params;
>  
>      /* State related to return path */
>      struct {
> @@ -229,7 +223,7 @@ void migrate_fd_connect(MigrationState *s);
>  
>  void add_migration_state_change_notifier(Notifier *notify);
>  void remove_migration_state_change_notifier(Notifier *notify);
> -MigrationState *migrate_init(const MigrationParams *params);
> +MigrationState *migrate_init(void);
>  bool migration_is_blocked(Error **errp);
>  bool migration_in_setup(MigrationState *);
>  bool migration_is_idle(void);
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 9452dec..4396d7e 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -37,7 +37,6 @@ typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>  
>  typedef struct SaveVMHandlers {
>      /* This runs inside the iothread lock.  */
> -    void (*set_params)(const MigrationParams *params, void * opaque);
>      SaveStateHandler *save_state;
>  
>      void (*cleanup)(void *opaque);
> diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> index f08d327..a388243 100644
> --- a/include/qemu/typedefs.h
> +++ b/include/qemu/typedefs.h
> @@ -49,7 +49,6 @@ typedef struct MemoryRegion MemoryRegion;
>  typedef struct MemoryRegionCache MemoryRegionCache;
>  typedef struct MemoryRegionSection MemoryRegionSection;
>  typedef struct MigrationIncomingState MigrationIncomingState;
> -typedef struct MigrationParams MigrationParams;
>  typedef struct MigrationState MigrationState;
>  typedef struct Monitor Monitor;
>  typedef struct MonitorDef MonitorDef;
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 058d5eb..3340202 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -102,8 +102,7 @@ enum qemu_vm_cmd {
>  #define MAX_VM_CMD_PACKAGED_SIZE (1ul << 24)
>  
>  bool qemu_savevm_state_blocked(Error **errp);
> -void qemu_savevm_state_begin(QEMUFile *f,
> -                             const MigrationParams *params);
> +void qemu_savevm_state_begin(QEMUFile *f);
>  void qemu_savevm_state_header(QEMUFile *f);
>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
> diff --git a/migration/colo.c b/migration/colo.c
> index 5c6c2f0..75e8807 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -333,7 +333,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>      }
>  
>      qemu_savevm_state_header(fb);
> -    qemu_savevm_state_begin(fb, &s->params);
> +    qemu_savevm_state_begin(fb);
>      qemu_mutex_lock_iothread();
>      qemu_savevm_state_complete_precopy(fb, false);
>      qemu_mutex_unlock_iothread();
> diff --git a/migration/migration.c b/migration/migration.c
> index 9b96f1a..f094079 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1102,7 +1102,7 @@ bool migration_is_idle(void)
>      return false;
>  }
>  
> -MigrationState *migrate_init(const MigrationParams *params)
> +MigrationState *migrate_init(void)
>  {
>      MigrationState *s = migrate_get_current();
>  
> @@ -1116,7 +1116,6 @@ MigrationState *migrate_init(const MigrationParams *params)
>      s->cleanup_bh = 0;
>      s->to_dst_file = NULL;
>      s->state = MIGRATION_STATUS_NONE;
> -    s->params = *params;
>      s->rp_state.from_dst_file = NULL;
>      s->rp_state.error = false;
>      s->mbps = 0.0;
> @@ -1215,7 +1214,6 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>  {
>      Error *local_err = NULL;
>      MigrationState *s = migrate_get_current();
> -    MigrationParams params;
>      const char *p;
>  
>      if (migration_is_setup_or_active(s->state) ||
> @@ -1233,7 +1231,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
>          return;
>      }
>  
> -    s = migrate_init(&params);
> +    s = migrate_init();
>  
>      if (has_blk && blk) {
>          migrate_set_block_enabled(s);
> @@ -1966,7 +1964,7 @@ static void *migration_thread(void *opaque)
>          qemu_savevm_send_postcopy_advise(s->to_dst_file);
>      }
>  
> -    qemu_savevm_state_begin(s->to_dst_file, &s->params);
> +    qemu_savevm_state_begin(s->to_dst_file);
>  
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 102b11d..97c6908 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -966,21 +966,13 @@ void qemu_savevm_state_header(QEMUFile *f)
>  
>  }
>  
> -void qemu_savevm_state_begin(QEMUFile *f,
> -                             const MigrationParams *params)
> +void qemu_savevm_state_begin(QEMUFile *f)
>  {
>      SaveStateEntry *se;
>      int ret;
>  
>      trace_savevm_state_begin();
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (!se->ops || !se->ops->set_params) {
> -            continue;
> -        }
> -        se->ops->set_params(params, se->opaque);
> -    }
> -
> -    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>          if (!se->ops || !se->ops->save_live_setup) {
>              continue;
>          }
> @@ -1232,9 +1224,7 @@ void qemu_savevm_state_cleanup(void)
>  static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  {
>      int ret;
> -    MigrationParams params = {
> -    };
> -    MigrationState *ms = migrate_init(&params);
> +    MigrationState *ms = migrate_init();
>      MigrationStatus status;
>      ms->to_dst_file = f;
>  
> @@ -1245,7 +1235,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  
>      qemu_mutex_unlock_iothread();
>      qemu_savevm_state_header(f);
> -    qemu_savevm_state_begin(f, &params);
> +    qemu_savevm_state_begin(f);
>      qemu_mutex_lock_iothread();
>  
>      while (qemu_file_get_error(f) == 0) {
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
