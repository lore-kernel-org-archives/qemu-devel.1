Received: from eggs.gnu.org ([2001:4830:134:3::10]:60329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d42PF-0002NZ-Cn
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:41:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d42PA-0006sY-KG
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:41:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d42PA-0006rl-Al
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 05:41:36 -0400
Date: Fri, 28 Apr 2017 17:38:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170428093825.GA22801@pxdev.xzpeter.org>
References: <1493362658-8179-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170428065754eucas1p1f51713373ce8c2d19945a4f91c52bd5c@eucas1p1.samsung.com>
	<1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493362658-8179-5-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH RESEND V3 4/6] migration: add postcopy
 downtime into MigrationIncommingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, i.maximets@samsung.com, f4bug@amsat.org

On Fri, Apr 28, 2017 at 09:57:36AM +0300, Alexey Perevalov wrote:
> This patch add request to kernel space for UFFD_FEATURE_THREAD_ID,
> in case when this feature is provided by kernel.
> 
> DowntimeContext is incapsulated inside migration.c.
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/migration/migration.h | 12 ++++++++++++
>  migration/migration.c         | 33 +++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.c      |  8 ++++++++
>  3 files changed, 53 insertions(+)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index ba1a16c..e8fb68f 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -83,6 +83,8 @@ typedef enum {
>      POSTCOPY_INCOMING_END
>  } PostcopyState;
>  
> +struct DowntimeContext;

Nit: shall we embed something like "Postcopy" (or short form) into
this struct name? Since the whole thing is really tailored for
postcopy, only.

> +
>  /* State for the incoming migration */
>  struct MigrationIncomingState {
>      QEMUFile *from_src_file;
> @@ -123,10 +125,20 @@ struct MigrationIncomingState {
>  
>      /* See savevm.c */
>      LoadStateEntry_Head loadvm_handlers;
> +
> +    /*
> +     * DowntimeContext to keep information for postcopy
> +     * live migration, to calculate downtime
> +     * */
> +    struct DowntimeContext *downtime_ctx;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
>  void migration_incoming_state_destroy(void);
> +/*
> + * Functions to work with downtime context
> + */
> +struct DowntimeContext *downtime_context_new(void);
>  
>  struct MigrationState
>  {
> diff --git a/migration/migration.c b/migration/migration.c
> index 569a7f6..ec76e5c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -77,6 +77,18 @@ static NotifierList migration_state_notifiers =
>  
>  static bool deferred_incoming;
>  
> +typedef struct DowntimeContext {
> +    /* time when page fault initiated per vCPU */
> +    int64_t *page_fault_vcpu_time;
> +    /* page address per vCPU */
> +    uint64_t *vcpu_addr;
> +    int64_t total_downtime;
> +    /* downtime per vCPU */
> +    int64_t *vcpu_downtime;
> +    /* point in time when last page fault was initiated */
> +    int64_t last_begin;
> +} DowntimeContext;
> +
>  /*
>   * Current state of incoming postcopy; note this is not part of
>   * MigrationIncomingState since it's state is used during cleanup
> @@ -116,6 +128,23 @@ MigrationState *migrate_get_current(void)
>      return &current_migration;
>  }
>  
> +struct DowntimeContext *downtime_context_new(void)
> +{
> +    DowntimeContext *ctx = g_new0(DowntimeContext, 1);
> +    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
> +    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
> +    ctx->vcpu_downtime = g_new0(int64_t, smp_cpus);
> +    return ctx;
> +}
> +
> +static void destroy_downtime_context(struct DowntimeContext *ctx)
> +{
> +    g_free(ctx->page_fault_vcpu_time);
> +    g_free(ctx->vcpu_addr);
> +    g_free(ctx->vcpu_downtime);
> +    g_free(ctx);
> +}
> +
>  MigrationIncomingState *migration_incoming_get_current(void)
>  {
>      static bool once;
> @@ -138,6 +167,10 @@ void migration_incoming_state_destroy(void)
>  
>      qemu_event_destroy(&mis->main_thread_load_event);
>      loadvm_free_handlers(mis);
> +    if (mis->downtime_ctx) {
> +        destroy_downtime_context(mis->downtime_ctx);
> +        mis->downtime_ctx = NULL;
> +    }
>  }
>  
>  
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 21e7150..f3688f5 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -132,6 +132,14 @@ static bool ufd_version_check(int ufd, MigrationIncomingState *mis)
>          return false;
>      }
>  
> +#ifdef UFFD_FEATURE_THREAD_ID
> +    if (mis && UFFD_FEATURE_THREAD_ID & supported_features) {
> +        /* kernel supports that feature */
> +        mis->downtime_ctx = downtime_context_new();
> +        new_features |= UFFD_FEATURE_THREAD_ID;

So here I know why in patch 2 new_features == 0... 

If I were you, I would like the series be done in below 4 patches:

1. update header
2. introduce THREAD_ID feature, and enable it conditionally
3. squash all the downtime thing (downtime context, calculation) in
   one patch here
4. introduce trace

IMHO that's clearer and easier for review. But I'm okay with current
as well as long as the maintainers (Dave/Juan) won't disagree. :)

Thanks,

> +    }
> +#endif
> +
>      /* request features */
>      if (new_features && !request_ufd_features(ufd, new_features)) {
>          error_report("ufd_version_check failed: features %" PRIu64,
> -- 
> 1.9.1
> 

-- 
Peter Xu
