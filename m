Received: from eggs.gnu.org ([209.51.188.92]:43061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JZR-0006VQ-2z
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h2JZO-000715-MQ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h2JZL-0006rK-Cf
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 12:46:04 -0500
Date: Fri, 8 Mar 2019 17:45:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190308174556.GH2834@work-vm>
References: <20190303145021.2962-1-chen.zhang@intel.com>
	<20190303145021.2962-8-chen.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303145021.2962-8-chen.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH V3 7/7] Migration/colo.c: Make user obtain
 the COLO mode info after failover
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <chen.zhang@intel.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-dev <qemu-devel@nongnu.org>

* Zhang Chen (chen.zhang@intel.com) wrote:
> From: Zhang Chen <chen.zhang@intel.com>
> 
> Add the last_colo_mode to save the status after failover.
> This patch can solve the issue that user got nothing to call
> query_colo_status after failover.

I don't understand what this is doing; cna you show me an example
of the way the state looks before and after the patch?

Dave

> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  migration/colo.c | 28 +++++++++++++++++++++++-----
>  1 file changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index d1ae2e6d11..6eba8e06f2 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -38,6 +38,9 @@
>  static bool vmstate_loading;
>  static Notifier packets_compare_notifier;
>  
> +/* User need to know colo mode after COLO failover */
> +static COLOMode last_colo_mode;
> +
>  #define COLO_BUFFER_BASE_SIZE (4 * 1024 * 1024)
>  
>  bool migration_in_colo_state(void)
> @@ -197,7 +200,10 @@ void colo_do_failover(MigrationState *s)
>          vm_stop_force_state(RUN_STATE_COLO);
>      }
>  
> -    switch (get_colo_mode()) {
> +    /* Update last_COLO_mode to avoid unexpectedly exit COLO status */
> +    last_colo_mode = get_colo_mode();
> +
> +    switch (last_colo_mode) {
>      case COLO_MODE_PRIMARY:
>          primary_vm_do_failover();
>          break;
> @@ -263,7 +269,7 @@ COLOStatus *qmp_query_colo_status(Error **errp)
>  {
>      COLOStatus *s = g_new0(COLOStatus, 1);
>  
> -    s->mode = get_colo_mode();
> +    s->mode = last_colo_mode;
>  
>      switch (failover_get_state()) {
>      case FAILOVER_STATUS_NONE:
> @@ -515,6 +521,12 @@ static void colo_process_checkpoint(MigrationState *s)
>      Error *local_err = NULL;
>      int ret;
>  
> +    last_colo_mode = get_colo_mode();
> +    if (last_colo_mode != COLO_MODE_PRIMARY) {
> +        error_report("COLO mode must be COLO_MODE_PRIMARY");
> +        return;
> +    }
> +
>      failover_init_state();
>  
>      s->rp_state.from_dst_file = qemu_file_get_return_path(s->to_dst_file);
> @@ -682,12 +694,18 @@ void *colo_process_incoming_thread(void *opaque)
>      Error *local_err = NULL;
>      int ret;
>  
> -    rcu_register_thread();
> -    qemu_sem_init(&mis->colo_incoming_sem, 0);
> -
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_COLO);
>  
> +    last_colo_mode = get_colo_mode();
> +    if (last_colo_mode != COLO_MODE_SECONDARY) {
> +        error_report("COLO mode must be COLO_MODE_SECONDARY");
> +        return NULL;
> +    }
> +
> +    rcu_register_thread();
> +    qemu_sem_init(&mis->colo_incoming_sem, 0);
> +
>      failover_init_state();
>  
>      mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
