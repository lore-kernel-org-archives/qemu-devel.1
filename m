Received: from eggs.gnu.org ([2001:4830:134:3::10]:49411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHa6E-00047F-1i
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gHa6A-00052Y-QS
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:54:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gHa67-0004xt-08
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:54:44 -0400
Date: Tue, 30 Oct 2018 19:54:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181030195430.GE2441@work-vm>
References: <20181024163529.15665-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024163529.15665-1-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, zhanghailiang <zhang.zhanghailiang@huawei.com>, Thomas Huth <thuth@redhat.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> This compilation issue will occur when user use --disable-replication
> to config Qemu.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

OK; do we need to add a check to migrate_caps_check to stop you enabling
colo in this case?


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/colo.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index 956ac236b7..b81e6ec5bb 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -59,6 +59,8 @@ static bool colo_runstate_is_stopped(void)
>  
>  static void secondary_vm_do_failover(void)
>  {
> +/* COLO needs enable block-replication */
> +#ifdef CONFIG_REPLICATION
>      int old_state;
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> @@ -121,10 +123,14 @@ static void secondary_vm_do_failover(void)
>      if (mis->migration_incoming_co) {
>          qemu_coroutine_enter(mis->migration_incoming_co);
>      }
> +#else
> +    abort();
> +#endif
>  }
>  
>  static void primary_vm_do_failover(void)
>  {
> +#ifdef CONFIG_REPLICATION
>      MigrationState *s = migrate_get_current();
>      int old_state;
>      Error *local_err = NULL;
> @@ -165,6 +171,9 @@ static void primary_vm_do_failover(void)
>  
>      /* Notify COLO thread that failover work is finished */
>      qemu_sem_post(&s->colo_exit_sem);
> +#else
> +    abort();
> +#endif
>  }
>  
>  COLOMode get_colo_mode(void)
> @@ -373,6 +382,7 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>                                            QIOChannelBuffer *bioc,
>                                            QEMUFile *fb)
>  {
> +#ifdef CONFIG_REPLICATION
>      Error *local_err = NULL;
>      int ret = -1;
>  
> @@ -483,6 +493,9 @@ out:
>          error_report_err(local_err);
>      }
>      return ret;
> +#else
> +    abort();
> +#endif
>  }
>  
>  static void colo_compare_notify_checkpoint(Notifier *notifier, void *data)
> @@ -790,13 +803,16 @@ void *colo_process_incoming_thread(void *opaque)
>              qemu_mutex_unlock_iothread();
>              goto out;
>          }
> +#ifdef CONFIG_REPLICATION
>          /* discard colo disk buffer */
>          replication_do_checkpoint_all(&local_err);
>          if (local_err) {
>              qemu_mutex_unlock_iothread();
>              goto out;
>          }
> -
> +#else
> +        abort();
> +#endif
>          /* Notify all filters of all NIC to do checkpoint */
>          colo_notify_filters_event(COLO_EVENT_CHECKPOINT, &local_err);
>  
> -- 
> 2.17.GIT
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
