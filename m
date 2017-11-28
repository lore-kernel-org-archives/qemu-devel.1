Received: from eggs.gnu.org ([2001:4830:134:3::10]:34676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eJcyW-0001ZU-AU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eJcyR-0005Un-In
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:18:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eJcyR-0005Ue-9w
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:18:43 -0500
Date: Tue, 28 Nov 2017 10:18:34 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171128101834.GA3256@work-vm>
References: <20171127073233.15376-1-fangying1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127073233.15376-1-fangying1@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3] vhost: Cancel migration when vhost-user
 process restarted during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fangying <fangying1@huawei.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, quintela@redhat.com

* fangying (fangying1@huawei.com) wrote:
> QEMU will abort when vhost-user process is restarted during migration
> and vhost_log_global_start/stop is called. The reason is clear that
> vhost_dev_set_log returns -1 because network connection is temporarily
> lost. To handle this situation, let's cancel migration here.
> 
> Signed-off-by: Ying Fang <fangying1@huawei.com>

I thought we had agreed not to use migrate_fd_cancel here - that's for
cancelling not erroring.

Dave

> ---
>  hw/virtio/vhost.c     | 15 +++++++++++++--
>  migration/migration.c |  2 +-
>  migration/migration.h |  2 +-
>  3 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index ddc42f0..e2ade93 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -26,6 +26,7 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
>  #include "migration/blocker.h"
> +#include "migration/migration.h"
>  #include "sysemu/dma.h"
>  
>  /* enabled until disconnected backend stabilizes */
> @@ -882,20 +883,30 @@ static int vhost_migration_log(MemoryListener *listener, int enable)
>  static void vhost_log_global_start(MemoryListener *listener)
>  {
>      int r;
> +    MigrationState *s = NULL;
>  
>      r = vhost_migration_log(listener, true);
>      if (r < 0) {
> -        abort();
> +        error_report("Failed to start vhost dirty log");
> +        s = migrate_get_current();
> +        if (s->migration_thread_running) {
> +            migrate_fd_cancel(s);
> +        }
>      }
>  }
>  
>  static void vhost_log_global_stop(MemoryListener *listener)
>  {
>      int r;
> +    MigrationState *s = NULL;
>  
>      r = vhost_migration_log(listener, false);
>      if (r < 0) {
> -        abort();
> +        error_report("Failed to stop vhost dirty log");
> +        s = migrate_get_current();
> +        if (s->migration_thread_running) {
> +            migrate_fd_cancel(s);
> +        }
>      }
>  }
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 4de3b55..6d2b7df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1131,7 +1131,7 @@ void migrate_fd_error(MigrationState *s, const Error *error)
>      block_cleanup_parameters(s);
>  }
>  
> -static void migrate_fd_cancel(MigrationState *s)
> +void migrate_fd_cancel(MigrationState *s)
>  {
>      int old_state ;
>      QEMUFile *f = migrate_get_current()->to_dst_file;
> diff --git a/migration/migration.h b/migration/migration.h
> index 663415f..f0261e3 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -167,7 +167,7 @@ uint64_t migrate_max_downtime(void);
>  
>  void migrate_set_error(MigrationState *s, const Error *error);
>  void migrate_fd_error(MigrationState *s, const Error *error);
> -
> +void migrate_fd_cancel(MigrationState *s);
>  void migrate_fd_connect(MigrationState *s);
>  
>  MigrationState *migrate_init(void);
> -- 
> 1.8.3.1
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
