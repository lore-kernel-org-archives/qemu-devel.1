Received: from eggs.gnu.org ([2001:4830:134:3::10]:56303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coou0-0007BB-Ee
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cootx-0003yj-9B
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cootx-0003yE-1P
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:14:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29B7985376
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:14:29 +0000 (UTC)
Date: Fri, 17 Mar 2017 10:14:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317101424.GC2396@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-28-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-28-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 27/31] ram: Move last_req_rb to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> It was on MigrationState when it is only used inside ram.c for
> postcopy.  Problem is that we need to access it without being able to
> pass it RAMState directly.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h | 2 --
>  migration/migration.c         | 1 -
>  migration/ram.c               | 6 ++++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 84cef4b..e032fb0 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -189,8 +189,6 @@ struct MigrationState
>      /* Queue of outstanding page requests from the destination */
>      QemuMutex src_page_req_mutex;
>      QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
> -    /* The RAMBlock used in the last src_page_request */
> -    RAMBlock *last_req_rb;

Should this be kept together with src_page_req_mutex and src_page_requests?

Dave

>      /* The semaphore is used to notify COLO thread that failover is finished */
>      QemuSemaphore colo_exit_sem;
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 46645b6..4f19382 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1114,7 +1114,6 @@ MigrationState *migrate_init(const MigrationParams *params)
>      s->postcopy_after_devices = false;
>      s->postcopy_requests = 0;
>      s->migration_thread_running = false;
> -    s->last_req_rb = NULL;
>      error_free(s->error);
>      s->error = NULL;
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index e7db39c..50ca1da 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -197,6 +197,8 @@ struct RAMState {
>      QemuMutex bitmap_mutex;
>      /* Ram Bitmap protected by RCU */
>      RAMBitmap *ram_bitmap;
> +    /* The RAMBlock used in the last src_page_request */
> +    RAMBlock *last_req_rb;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -1190,7 +1192,7 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>      rcu_read_lock();
>      if (!rbname) {
>          /* Reuse last RAMBlock */
> -        ramblock = ms->last_req_rb;
> +        ramblock = ram_state.last_req_rb;
>  
>          if (!ramblock) {
>              /*
> @@ -1208,7 +1210,7 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>              error_report("ram_save_queue_pages no block '%s'", rbname);
>              goto err;
>          }
> -        ms->last_req_rb = ramblock;
> +        ram_state.last_req_rb = ramblock;
>      }
>      trace_ram_save_queue_pages(ramblock->idstr, start, len);
>      if (start+len > ramblock->used_length) {
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
