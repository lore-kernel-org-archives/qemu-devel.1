Received: from eggs.gnu.org ([2001:4830:134:3::10]:53433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBp3-0005W8-FX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:26:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dgBoz-00081c-CJ
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dgBoz-000810-2d
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 11:25:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D82767DD0A
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 15:25:55 +0000 (UTC)
Date: Fri, 11 Aug 2017 16:25:47 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170811152547.GT2554@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170808162629.32493-1-quintela@redhat.com>
	<20170808162629.32493-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808162629.32493-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 12/19] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Tue, Aug 08, 2017 at 06:26:22PM +0200, Juan Quintela wrote:
> The function still don't use multifd, but we have simplified
> ram_save_page, xbzrle and RDMA stuff is gone.  We have added a new
> counter and a new flag for this type of pages.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> --
> Add last_page parameter
> Add commets for done and address
> ---
>  hmp.c                 |  2 ++
>  migration/migration.c |  1 +
>  migration/ram.c       | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  qapi-schema.json      |  5 ++-
>  4 files changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index a52035a..bc2b071 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -234,6 +234,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>              monitor_printf(mon, "postcopy request count: %" PRIu64 "\n",
>                             info->ram->postcopy_requests);
>          }
> +        monitor_printf(mon, "multifd: %" PRIu64 " pages\n",
> +                       info->ram->multifd);
>      }
>  
>      if (info->has_disk) {
> diff --git a/migration/migration.c b/migration/migration.c
> index 944d6e2..8e9505a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -549,6 +549,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->dirty_sync_count = ram_counters.dirty_sync_count;
>      info->ram->postcopy_requests = ram_counters.postcopy_requests;
>      info->ram->page_size = qemu_target_page_size();
> +    info->ram->multifd = ram_counters.multifd;
>  
>      if (migrate_use_xbzrle()) {
>          info->has_xbzrle_cache = true;
> diff --git a/migration/ram.c b/migration/ram.c
> index e9fa556..03f3427 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -68,6 +68,7 @@
>  #define RAM_SAVE_FLAG_XBZRLE   0x40
>  /* 0x80 is reserved in migration.h start with 0x100 next */
>  #define RAM_SAVE_FLAG_COMPRESS_PAGE    0x100
> +#define RAM_SAVE_FLAG_MULTIFD_PAGE     0x200
>  
>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>  {
> @@ -362,12 +363,22 @@ static void compress_threads_save_setup(void)
>  /* Multiple fd's */
>  
>  struct MultiFDSendParams {
> +    /* not changed */
>      uint8_t id;
>      QemuThread thread;
>      QIOChannel *c;
>      QemuSemaphore sem;
>      QemuMutex mutex;
> +    /* protected by param mutex */
>      bool quit;
> +    /* This is a temp field.  We are using it now to transmit
> +       something the address of the page.  Later in the series, we
> +       change it for the real page.
> +    */
> +    uint8_t *address;
> +    /* protected by multifd mutex */
> +    /* has the thread finish the last submitted job */
> +    bool done;
>  };
>  typedef struct MultiFDSendParams MultiFDSendParams;
>  
> @@ -375,6 +386,8 @@ struct {
>      MultiFDSendParams *params;
>      /* number of created threads */
>      int count;
> +    QemuMutex mutex;
> +    QemuSemaphore sem;
>  } *multifd_send_state;
>  
>  static void terminate_multifd_send_threads(void)
> @@ -433,6 +446,7 @@ static void *multifd_send_thread(void *opaque)
>      g_free(string_uuid);
>      qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
>      g_free(string);
> +    qemu_sem_post(&multifd_send_state->sem);
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -440,6 +454,15 @@ static void *multifd_send_thread(void *opaque)
>              qemu_mutex_unlock(&p->mutex);
>              break;
>          }
> +        if (p->address) {
> +            p->address = 0;
> +            qemu_mutex_unlock(&p->mutex);
> +            qemu_mutex_lock(&multifd_send_state->mutex);
> +            p->done = true;
> +            qemu_mutex_unlock(&multifd_send_state->mutex);
> +            qemu_sem_post(&multifd_send_state->sem);
> +            continue;
> +        }
>          qemu_mutex_unlock(&p->mutex);
>          qemu_sem_wait(&p->sem);
>      }
> @@ -459,6 +482,8 @@ int multifd_save_setup(void)
>      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
>      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
>      multifd_send_state->count = 0;
> +    qemu_mutex_init(&multifd_send_state->mutex);
> +    qemu_sem_init(&multifd_send_state->sem, 0);
>      for (i = 0; i < thread_count; i++) {
>          char thread_name[16];
>          MultiFDSendParams *p = &multifd_send_state->params[i];
> @@ -467,6 +492,8 @@ int multifd_save_setup(void)
>          qemu_sem_init(&p->sem, 0);
>          p->quit = false;
>          p->id = i;
> +        p->done = true;
> +        p->address = 0;
>          p->c = socket_send_channel_create();
>          if (!p->c) {
>              error_report("Error creating a send channel");
> @@ -481,6 +508,30 @@ int multifd_save_setup(void)
>      return 0;
>  }
>  
> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
> +{
> +    int i;
> +    MultiFDSendParams *p = NULL; /* make happy gcc */
> +
> +    qemu_sem_wait(&multifd_send_state->sem);
> +    qemu_mutex_lock(&multifd_send_state->mutex);
> +    for (i = 0; i < multifd_send_state->count; i++) {
> +        p = &multifd_send_state->params[i];
> +
> +        if (p->done) {
> +            p->done = false;
> +            break;
> +        }
> +    }
> +    qemu_mutex_unlock(&multifd_send_state->mutex);
> +    qemu_mutex_lock(&p->mutex);
> +    p->address = address;
> +    qemu_mutex_unlock(&p->mutex);
> +    qemu_sem_post(&p->sem);
> +
> +    return 0;
> +}
> +
>  struct MultiFDRecvParams {
>      uint8_t id;
>      QemuThread thread;
> @@ -1051,6 +1102,32 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      return pages;
>  }
>  
> +static int ram_multifd_page(RAMState *rs, PageSearchStatus *pss,
> +                            bool last_stage)
> +{
> +    int pages;
> +    uint8_t *p;
> +    RAMBlock *block = pss->block;
> +    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> +
> +    p = block->host + offset;
> +
> +    pages = save_zero_page(rs, block, offset, p);
> +    if (pages == -1) {
> +        ram_counters.transferred +=
> +            save_page_header(rs, rs->f, block,
> +                             offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> +        qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
> +        multifd_send_page(p, rs->migration_dirty_pages == 1);
> +        ram_counters.transferred += TARGET_PAGE_SIZE;
> +        pages = 1;
> +        ram_counters.normal++;
> +        ram_counters.multifd++;
> +    }
> +
> +    return pages;
> +}
> +
>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>                                  ram_addr_t offset)
>  {
> @@ -1479,6 +1556,8 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          if (migrate_use_compression() &&
>              (rs->ram_bulk_stage || !migrate_use_xbzrle())) {
>              res = ram_save_compressed_page(rs, pss, last_stage);
> +        } else if (migrate_use_multifd()) {
> +            res = ram_multifd_page(rs, pss, last_stage);
>          } else {
>              res = ram_save_page(rs, pss, last_stage);
>          }
> @@ -2771,6 +2850,10 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>      if (!migrate_use_compression()) {
>          invalid_flags |= RAM_SAVE_FLAG_COMPRESS_PAGE;
>      }
> +
> +    if (!migrate_use_multifd()) {
> +        invalid_flags |= RAM_SAVE_FLAG_MULTIFD_PAGE;
> +    }
>      /* This RCU critical section can be very long running.
>       * When RCU reclaims in the code start to become numerous,
>       * it will be necessary to reduce the granularity of this
> @@ -2795,13 +2878,17 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>              if (flags & invalid_flags & RAM_SAVE_FLAG_COMPRESS_PAGE) {
>                  error_report("Received an unexpected compressed page");
>              }
> +            if (flags & invalid_flags  & RAM_SAVE_FLAG_MULTIFD_PAGE) {
> +                error_report("Received an unexpected multifd page");
> +            }
>  
>              ret = -EINVAL;
>              break;
>          }
>  
>          if (flags & (RAM_SAVE_FLAG_ZERO | RAM_SAVE_FLAG_PAGE |
> -                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
> +                     RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE |
> +                     RAM_SAVE_FLAG_MULTIFD_PAGE)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
>  
>              host = host_from_ram_block_offset(block, addr);
> @@ -2889,6 +2976,11 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                  break;
>              }
>              break;
> +
> +        case RAM_SAVE_FLAG_MULTIFD_PAGE:
> +            qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
> +            break;
> +
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
>              break;
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 2d4dbd3..bb1fe0a 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -617,6 +617,8 @@
>  # @page-size: The number of bytes per page for the various page-based
>  #        statistics (since 2.10)
>  #
> +# @multifd: number of pages sent with multifd (since 2.10)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationStats',
> @@ -624,7 +626,8 @@
>             'duplicate': 'int', 'skipped': 'int', 'normal': 'int',
>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>             'mbps' : 'number', 'dirty-sync-count' : 'int',
> -           'postcopy-requests' : 'int', 'page-size' : 'int' } }
> +           'postcopy-requests' : 'int', 'page-size' : 'int',
> +           'multifd' : 'int'} }

If we enabled multifd when starting the migration, then surely *all*
pages should be sent with multifd, meaning this is no different to
the existing "normal" statistic.

IOW, I don't see any point in adding this new value.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
