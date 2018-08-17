Received: from eggs.gnu.org ([2001:4830:134:3::10]:51598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqfJx-0003Xx-3I
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fqfJt-0005kP-PJ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41492 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fqfJo-0005ho-N3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 10:01:39 -0400
Date: Fri, 17 Aug 2018 15:01:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180817140129.GI2459@work-vm>
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-10-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533562177-16447-10-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v6 09/11] migration: poll the cm event for
 destination qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, quintela@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

* Lidong Chen (jemmy858585@gmail.com) wrote:
> The destination qemu only poll the comp_channel->fd in
> qemu_rdma_wait_comp_channel. But when source qemu disconnnect
> the rdma connection, the destination qemu should be notified.
> 
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>

OK, this could do with an update to the migration_incoming_co comment in
migration.h, since previously it was only used by colo; if we merge this
first please post a patch to update the comment.

Other than that, I think I'm OK:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c |  3 ++-
>  migration/rdma.c      | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index df0c2cf..f7d6e26 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -389,6 +389,7 @@ static void process_incoming_migration_co(void *opaque)
>      int ret;
>  
>      assert(mis->from_src_file);
> +    mis->migration_incoming_co = qemu_coroutine_self();
>      mis->largest_page_size = qemu_ram_pagesize_largest();
>      postcopy_state_set(POSTCOPY_INCOMING_NONE);
>      migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
> @@ -418,7 +419,6 @@ static void process_incoming_migration_co(void *opaque)
>  
>      /* we get COLO info, and know if we are in COLO mode */
>      if (!ret && migration_incoming_enable_colo()) {
> -        mis->migration_incoming_co = qemu_coroutine_self();
>          qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>               colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
>          mis->have_colo_incoming_thread = true;
> @@ -442,6 +442,7 @@ static void process_incoming_migration_co(void *opaque)
>      }
>      mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
>      qemu_bh_schedule(mis->bh);
> +    mis->migration_incoming_co = NULL;
>  }
>  
>  static void migration_incoming_setup(QEMUFile *f)
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 1affc46..ae07515 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3226,6 +3226,35 @@ err:
>  
>  static void rdma_accept_incoming_migration(void *opaque);
>  
> +static void rdma_cm_poll_handler(void *opaque)
> +{
> +    RDMAContext *rdma = opaque;
> +    int ret;
> +    struct rdma_cm_event *cm_event;
> +    MigrationIncomingState *mis = migration_incoming_get_current();
> +
> +    ret = rdma_get_cm_event(rdma->channel, &cm_event);
> +    if (ret) {
> +        error_report("get_cm_event failed %d", errno);
> +        return;
> +    }
> +    rdma_ack_cm_event(cm_event);
> +
> +    if (cm_event->event == RDMA_CM_EVENT_DISCONNECTED ||
> +        cm_event->event == RDMA_CM_EVENT_DEVICE_REMOVAL) {
> +        error_report("receive cm event, cm event is %d", cm_event->event);
> +        rdma->error_state = -EPIPE;
> +        if (rdma->return_path) {
> +            rdma->return_path->error_state = -EPIPE;
> +        }
> +
> +        if (mis->migration_incoming_co) {
> +            qemu_coroutine_enter(mis->migration_incoming_co);
> +        }
> +        return;
> +    }
> +}
> +
>  static int qemu_rdma_accept(RDMAContext *rdma)
>  {
>      RDMACapabilities cap;
> @@ -3326,7 +3355,8 @@ static int qemu_rdma_accept(RDMAContext *rdma)
>                              NULL,
>                              (void *)(intptr_t)rdma->return_path);
>      } else {
> -        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> +        qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
> +                            NULL, rdma);
>      }
>  
>      ret = rdma_accept(rdma->cm_id, &conn_param);
> -- 
> 1.8.3.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
