Received: from eggs.gnu.org ([2001:4830:134:3::10]:39728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDN1L-0008KG-DT
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDN1H-0005hw-Ax
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDN1H-0005hQ-13
	for qemu-devel@nongnu.org; Tue, 23 May 2017 23:31:31 -0400
Date: Wed, 24 May 2017 11:31:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170524033122.GE3873@pxdev.xzpeter.org>
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113129eucas1p179082f20f41d1069f5fbd0f37535fae9@eucas1p1.samsung.com>
	<1495539071-12995-7-git-send-email-a.perevalov@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495539071-12995-7-git-send-email-a.perevalov@samsung.com>
Subject: Re: [Qemu-devel] [PATCH V6 06/10] migration: add postcopy blocktime
 ctx into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: qemu-devel@nongnu.org, i.maximets@samsung.com, eblake@redhat.com, dgilbert@redhat.com

On Tue, May 23, 2017 at 02:31:07PM +0300, Alexey Perevalov wrote:
> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
> in case when this feature is provided by kernel.
> 
> PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,
> due to it's postcopy only feature.
> Also it defines PostcopyBlocktimeContext's instance live time.
> Information from PostcopyBlocktimeContext instance will be provided
> much after postcopy migration end, instance of PostcopyBlocktimeContext
> will live till QEMU exit, but part of it (vcpu_addr,
> page_fault_vcpu_time) used only during calculation, will be released
> when postcopy ended or failed.
> 
> To enable postcopy blocktime calculation on destination, need to request
> proper capabiltiy (Patch for documentation will be at the tail of the patch
> set).
> 
> As an example following command enable that capability, assume QEMU was
> started with
> -chardev socket,id=charmonitor,path=/var/lib/migrate-vm-monitor.sock
> option to control it
> 
> [root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
> {\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
> \"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\":
> true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock
> 
> Or just with HMP
> (qemu) migrate_set_capability postcopy-blocktime on
> 
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  include/migration/migration.h |  8 +++++
>  migration/postcopy-ram.c      | 80 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 2951253..449cb07 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -57,6 +57,8 @@ enum mig_rp_message_type {
>  
>  typedef QLIST_HEAD(, LoadStateEntry) LoadStateEntry_Head;
>  
> +struct PostcopyBlocktimeContext;
> +
>  /* State for the incoming migration */
>  struct MigrationIncomingState {
>      QEMUFile *from_src_file;
> @@ -97,6 +99,12 @@ struct MigrationIncomingState {
>  
>      /* See savevm.c */
>      LoadStateEntry_Head loadvm_handlers;
> +
> +    /*
> +     * PostcopyBlocktimeContext to keep information for postcopy
> +     * live migration, to calculate vCPU block time
> +     * */
> +    struct PostcopyBlocktimeContext *blocktime_ctx;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 4f3f495..5435a40 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -59,6 +59,73 @@ struct PostcopyDiscardState {
>  #include <sys/eventfd.h>
>  #include <linux/userfaultfd.h>
>  
> +typedef struct PostcopyBlocktimeContext {
> +    /* time when page fault initiated per vCPU */
> +    int64_t *page_fault_vcpu_time;
> +    /* page address per vCPU */
> +    uint64_t *vcpu_addr;
> +    int64_t total_blocktime;
> +    /* blocktime per vCPU */
> +    int64_t *vcpu_blocktime;
> +    /* point in time when last page fault was initiated */
> +    int64_t last_begin;
> +    /* number of vCPU are suspended */
> +    int smp_cpus_down;
> +
> +    /*
> +     * Handler for exit event, necessary for
> +     * releasing whole blocktime_ctx
> +     */
> +    Notifier exit_notifier;
> +    /*
> +     * Handler for postcopy event, necessary for
> +     * releasing unnecessary part of blocktime_ctx
> +     */
> +    Notifier postcopy_notifier;
> +} PostcopyBlocktimeContext;
> +
> +static void destroy_blocktime_context(struct PostcopyBlocktimeContext *ctx)
> +{
> +    g_free(ctx->page_fault_vcpu_time);
> +    g_free(ctx->vcpu_addr);
> +    g_free(ctx->vcpu_blocktime);
> +    g_free(ctx);
> +}
> +
> +static void postcopy_migration_cb(Notifier *n, void *data)
> +{
> +    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
> +                                               postcopy_notifier);
> +    MigrationState *s = data;
> +    if (migration_has_finished(s) || migration_has_failed(s)) {
> +        g_free(ctx->page_fault_vcpu_time);
> +        /* g_free is NULL robust */
> +        ctx->page_fault_vcpu_time = NULL;
> +        g_free(ctx->vcpu_addr);
> +        ctx->vcpu_addr = NULL;
> +    }
> +}
> +
> +static void migration_exit_cb(Notifier *n, void *data)
> +{
> +    PostcopyBlocktimeContext *ctx = container_of(n, PostcopyBlocktimeContext,
> +                                               exit_notifier);
> +    destroy_blocktime_context(ctx);
> +}
> +
> +static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> +{
> +    PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
> +    ctx->page_fault_vcpu_time = g_new0(int64_t, smp_cpus);
> +    ctx->vcpu_addr = g_new0(uint64_t, smp_cpus);
> +    ctx->vcpu_blocktime = g_new0(int64_t, smp_cpus);
> +
> +    ctx->exit_notifier.notify = migration_exit_cb;
> +    ctx->postcopy_notifier.notify = postcopy_migration_cb;
> +    qemu_add_exit_notifier(&ctx->exit_notifier);
> +    add_migration_state_change_notifier(&ctx->postcopy_notifier);

I think we just need a global MAX_VCPUS macro, then we can just make
the whole struct static. But I admit this is out of topic for current
thread. The point is indeed I see no much point on such fine-grained
management of memory on this... only for a summary of, say a maximum
of 1K vcpus, no more than 8B*3*1K=24KB memory...

IMHO This just made things complicated.

> +    return ctx;
> +}
>  
>  /**
>   * receive_ufd_features: check userfault fd features, to request only supported
> @@ -151,6 +218,19 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis)
>          }
>      }
>  
> +#ifdef UFFD_FEATURE_THREAD_ID
> +    if (migrate_postcopy_blocktime() && mis &&
> +            UFFD_FEATURE_THREAD_ID & supported_features) {

(indent)

> +        /* kernel supports that feature */
> +        /* don't create blocktime_context if it exists */
> +        if (!mis->blocktime_ctx) {

If it does existed, then maybe we'll have problem - in the state
change notifier we cleaned up ->page_fault_vcpu_time and ->vcpu_addr,
but blocktime_ctx was there. So will it possible when we reached here
we'll get blocktime_ctx != NULL but
blocktime_ctx->page_fault_vcpu_time == NULL and also
blocktime_ctx->vcpu_addr == NULL?

Maybe we can just drop the state change notifier, and one single exit
notifier would be enough to cleanup everything?

> +            mis->blocktime_ctx = blocktime_context_new();
> +        }
> +
> +        asked_features |= UFFD_FEATURE_THREAD_ID;
> +    }
> +#endif
> +
>      /*
>       * request features, even if asked_features is 0, due to
>       * kernel expects UFFD_API before UFFDIO_REGISTER, per
> -- 
> 1.8.3.1
> 

Thanks,

-- 
Peter Xu
