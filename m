Received: from eggs.gnu.org ([2001:4830:134:3::10]:51770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLv7i-0003Nd-LY
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:33:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dLv7d-0007AE-Ns
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dLv7d-00079r-Ey
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 13:33:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 729D780482
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 17:33:24 +0000 (UTC)
Date: Fri, 16 Jun 2017 18:33:15 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170616173315.GC19805@work-vm>
References: <20170613095338.11560-1-quintela@redhat.com>
	<20170613095338.11560-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613095338.11560-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] migration: Rename cleanup() to
 save_cleanup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, kwolf@redhat.com, stefanha@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need a cleanup for loads, so we rename here to be consistent.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/ppc/spapr.c               | 2 +-
>  include/migration/register.h | 2 +-
>  migration/block.c            | 2 +-
>  migration/ram.c              | 2 +-
>  migration/savevm.c           | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7db5396..dabf822 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1871,7 +1871,7 @@ static SaveVMHandlers savevm_htab_handlers = {
>      .save_setup = htab_save_setup,
>      .save_live_iterate = htab_save_iterate,
>      .save_live_complete_precopy = htab_save_complete,
> -    .cleanup = htab_cleanup,
> +    .save_cleanup = htab_cleanup,
>      .load_state = htab_load,

It might make sense to follow the rename through so that those
become htab_save_cleanup.

However, only minor.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  };
>  
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 333e3df..9ad1e4c 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -21,7 +21,7 @@ typedef struct SaveVMHandlers {
>      /* This runs inside the iothread lock.  */
>      SaveStateHandler *save_state;
>  
> -    void (*cleanup)(void *opaque);
> +    void (*save_cleanup)(void *opaque);
>      int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
>      int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
>  
> diff --git a/migration/block.c b/migration/block.c
> index c160d41..ad36afb 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -1012,7 +1012,7 @@ static SaveVMHandlers savevm_block_handlers = {
>      .save_live_complete_precopy = block_save_complete,
>      .save_live_pending = block_save_pending,
>      .load_state = block_load,
> -    .cleanup = block_migration_cleanup,
> +    .save_cleanup = block_migration_cleanup,
>      .is_active = block_is_active,
>  };
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 3454bf7..be78e42 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2611,7 +2611,7 @@ static SaveVMHandlers savevm_ram_handlers = {
>      .save_live_complete_precopy = ram_save_complete,
>      .save_live_pending = ram_save_pending,
>      .load_state = ram_load,
> -    .cleanup = ram_migration_cleanup,
> +    .save_cleanup = ram_migration_cleanup,
>  };
>  
>  void ram_mig_init(void)
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7f2a5bd..fb93931 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1226,8 +1226,8 @@ void qemu_savevm_state_cleanup(void)
>  
>      trace_savevm_state_cleanup();
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
> -        if (se->ops && se->ops->cleanup) {
> -            se->ops->cleanup(se->opaque);
> +        if (se->ops && se->ops->save_cleanup) {
> +            se->ops->save_cleanup(se->opaque);
>          }
>      }
>  }
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
