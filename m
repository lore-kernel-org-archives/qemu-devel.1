Received: from eggs.gnu.org ([2001:4830:134:3::10]:35038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0ucz-0007Pc-Jm
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d0ucu-0005O4-Mg
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d0ucu-0005NU-D3
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 14:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18894C05AA52
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 18:46:51 +0000 (UTC)
Date: Wed, 19 Apr 2017 19:46:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170419184646.GF7758@work-vm>
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170417200041.2451-17-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/19] migration: Export ram.c functions in
 its own file
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h | 36 -----------------------------
>  include/migration/ram.h       | 54 +++++++++++++++++++++++++++++++++++++++++++
>  migration/migration.c         |  1 +
>  migration/postcopy-ram.c      |  1 +
>  migration/ram.c               |  1 +
>  migration/rdma.c              |  1 +
>  migration/savevm.c            |  1 +
>  7 files changed, 59 insertions(+), 36 deletions(-)
>  create mode 100644 include/migration/ram.h
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 1451067..3e5d106 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -192,36 +192,6 @@ bool migration_is_blocked(Error **errp);
>  bool migration_in_postcopy(void);
>  MigrationState *migrate_get_current(void);
>  
> -void migrate_compress_threads_create(void);
> -void migrate_compress_threads_join(void);
> -void migrate_decompress_threads_create(void);
> -void migrate_decompress_threads_join(void);
> -uint64_t ram_bytes_remaining(void);
> -uint64_t ram_bytes_transferred(void);
> -uint64_t ram_bytes_total(void);
> -uint64_t ram_dirty_sync_count(void);
> -uint64_t ram_dirty_pages_rate(void);
> -uint64_t ram_postcopy_requests(void);
> -void free_xbzrle_decoded_buf(void);
> -
> -void acct_update_position(QEMUFile *f, size_t size, bool zero);
> -
> -uint64_t dup_mig_pages_transferred(void);
> -uint64_t norm_mig_pages_transferred(void);
> -uint64_t xbzrle_mig_bytes_transferred(void);
> -uint64_t xbzrle_mig_pages_transferred(void);
> -uint64_t xbzrle_mig_pages_overflow(void);
> -uint64_t xbzrle_mig_pages_cache_miss(void);
> -double xbzrle_mig_cache_miss_rate(void);
> -
> -void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> -void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
> -/* For outgoing discard bitmap */
> -int ram_postcopy_send_discard_bitmap(MigrationState *ms);
> -/* For incoming postcopy discard */
> -int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> -int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> -void ram_postcopy_migrated_memory_release(MigrationState *ms);
>  
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
> @@ -233,8 +203,6 @@ int migrate_use_xbzrle(void);
>  int64_t migrate_xbzrle_cache_size(void);
>  bool migrate_colo_enabled(void);
>  
> -int64_t xbzrle_cache_resize(int64_t new_size);
> -
>  bool migrate_use_block_enabled(void);
>  bool migrate_use_block_shared(void);
>  
> @@ -273,10 +241,6 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_t block_offset,
>                               ram_addr_t offset, size_t size,
>                               uint64_t *bytes_sent);
>  
> -void migration_page_queue_free(void);
> -int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
> -uint64_t ram_pagesize_summary(void);
> -
>  PostcopyState postcopy_state_get(void);
>  /* Set the state and return the old state */
>  PostcopyState postcopy_state_set(PostcopyState new_state);
> diff --git a/include/migration/ram.h b/include/migration/ram.h
> new file mode 100644
> index 0000000..c3653b3
> --- /dev/null
> +++ b/include/migration/ram.h
> @@ -0,0 +1,54 @@
> +/*
> + * QEMU migration ram
> + *
> + * Copyright IBM, Corp. 2008
> + *
> + * Authors:
> + *  Anthony Liguori   <aliguori@us.ibm.com>

Shouldn't that be updated a bit?

Other than that,

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the COPYING file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_MIGRATION_RAM_H
> +#define QEMU_MIGRATION_RAM_H
> +
> +#include "qemu-common.h"
> +#include "exec/cpu-common.h"
> +
> +int64_t xbzrle_cache_resize(int64_t new_size);
> +uint64_t dup_mig_pages_transferred(void);
> +uint64_t norm_mig_pages_transferred(void);
> +uint64_t xbzrle_mig_bytes_transferred(void);
> +uint64_t xbzrle_mig_pages_transferred(void);
> +uint64_t xbzrle_mig_pages_cache_miss(void);
> +double xbzrle_mig_cache_miss_rate(void);
> +uint64_t xbzrle_mig_pages_overflow(void);

Most of hese only exist to fill in MigrationInfo's xbzrle_cache states; see
get_xbzrle_cache_stats - perhaps it should be moved into ram.c and then just
that exposed?

Dave

> +uint64_t ram_bytes_transferred(void);
> +uint64_t ram_bytes_remaining(void);
> +uint64_t ram_dirty_sync_count(void);
> +uint64_t ram_dirty_pages_rate(void);
> +uint64_t ram_postcopy_requests(void);
> +uint64_t ram_bytes_total(void);
> +
> +void migrate_compress_threads_create(void);
> +void migrate_compress_threads_join(void);
> +void migrate_decompress_threads_create(void);
> +void migrate_decompress_threads_join(void);
> +
> +uint64_t ram_pagesize_summary(void);
> +void migration_page_queue_free(void);
> +int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len);
> +void acct_update_position(QEMUFile *f, size_t size, bool zero);
> +void free_xbzrle_decoded_buf(void);
> +void ram_debug_dump_bitmap(unsigned long *todump, bool expected);
> +void ram_postcopy_migrated_memory_release(MigrationState *ms);
> +/* For outgoing discard bitmap */
> +int ram_postcopy_send_discard_bitmap(MigrationState *ms);
> +/* For incoming postcopy discard */
> +int ram_discard_range(const char *block_name, uint64_t start, size_t length);
> +int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> +
> +void ram_handle_compressed(void *host, uint8_t ch, uint64_t size);
> +#endif
> diff --git a/migration/migration.c b/migration/migration.c
> index 6e32be0..ba01ea2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -23,6 +23,7 @@
>  #include "migration/exec.h"
>  #include "migration/fd.h"
>  #include "migration/socket.h"
> +#include "migration/ram.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file-channel.h"
>  #include "migration/vmstate.h"
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 5aea2ff..aec40c3 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -19,6 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
> +#include "migration/ram.h"
>  #include "migration/postcopy-ram.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/balloon.h"
> diff --git a/migration/ram.c b/migration/ram.c
> index 49e518f..eb1ec1b 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -36,6 +36,7 @@
>  #include "qemu/main-loop.h"
>  #include "migration/xbzrle.h"
>  #include "migration/init.h"
> +#include "migration/ram.h"
>  #include "migration/migration.h"
>  #include "migration/qemu-file.h"
>  #include "migration/vmstate.h"
> diff --git a/migration/rdma.c b/migration/rdma.c
> index d9a2d64..3b06fe6 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -18,6 +18,7 @@
>  #include "qemu-common.h"
>  #include "qemu/cutils.h"
>  #include "migration/migration.h"
> +#include "migration/ram.h"
>  #include "migration/qemu-file-channel.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 1e6cf79..f628d01 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -36,6 +36,7 @@
>  #include "audio/audio.h"
>  #include "migration/machine.h"
>  #include "migration/migration.h"
> +#include "migration/ram.h"
>  #include "migration/qemu-file-channel.h"
>  #include "migration/postcopy-ram.h"
>  #include "qapi/qmp/qerror.h"
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
