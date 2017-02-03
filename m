Received: from eggs.gnu.org ([2001:4830:134:3::10]:37961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbyO-00047z-4Q
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cZbyK-00020Z-4F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:24:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cZbyJ-0001zg-SD
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 06:24:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 700E861B9A
	for <qemu-devel@nongnu.org>; Fri,  3 Feb 2017 11:24:07 +0000 (UTC)
Date: Fri, 3 Feb 2017 11:24:02 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170203112402.GD3208@work-vm>
References: <1485207141-1941-1-git-send-email-quintela@redhat.com>
	<1485207141-1941-15-git-send-email-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485207141-1941-15-git-send-email-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/17] migration: Create thread
 infrastructure for multifd recv side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We make the locking and the transfer of information specific, even if we
> are still receiving things through the main thread.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 67 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index ca94704..4e530ea 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -523,7 +523,7 @@ void migrate_multifd_send_threads_create(void)
>      }
>  }
> 
> -static int multifd_send_page(uint8_t *address)
> +static uint16_t multifd_send_page(uint8_t *address, bool last_page)
>  {
>      int i, j, thread_count;
>      bool found = false;
> @@ -538,8 +538,10 @@ static int multifd_send_page(uint8_t *address)
>      pages.address[pages.num] = address;
>      pages.num++;
> 
> -    if (pages.num < (pages.size - 1)) {
> -        return UINT16_MAX;
> +    if (!last_page) {
> +        if (pages.num < (pages.size - 1)) {
> +            return UINT16_MAX;
> +        }
>      }

This should be in the previous patch?
(and the place that adds the last_page parameter below)?

> 
>      thread_count = migrate_multifd_threads();
> @@ -570,17 +572,25 @@ static int multifd_send_page(uint8_t *address)
>  }
> 
>  struct MultiFDRecvParams {
> +    /* not changed */
>      QemuThread thread;
>      QIOChannel *c;
>      QemuCond cond;
>      QemuMutex mutex;
> +    /* proteced by param mutex */
>      bool quit;
>      bool started;
> +    multifd_pages_t pages;
> +    /* proteced by multifd mutex */
> +    bool done;
>  };
>  typedef struct MultiFDRecvParams MultiFDRecvParams;
> 
>  static MultiFDRecvParams *multifd_recv;
> 
> +QemuMutex multifd_recv_mutex;
> +QemuCond  multifd_recv_cond;
> +
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *params = opaque;
> @@ -594,7 +604,17 @@ static void *multifd_recv_thread(void *opaque)
> 
>      qemu_mutex_lock(&params->mutex);
>      while (!params->quit){
> -        qemu_cond_wait(&params->cond, &params->mutex);
> +        if (params->pages.num) {
> +            params->pages.num = 0;
> +            qemu_mutex_unlock(&params->mutex);
> +            qemu_mutex_lock(&multifd_recv_mutex);
> +            params->done = true;
> +            qemu_cond_signal(&multifd_recv_cond);
> +            qemu_mutex_unlock(&multifd_recv_mutex);
> +            qemu_mutex_lock(&params->mutex);
> +        } else {
> +            qemu_cond_wait(&params->cond, &params->mutex);
> +        }
>      }
>      qemu_mutex_unlock(&params->mutex);
> 
> @@ -647,8 +667,9 @@ void migrate_multifd_recv_threads_create(void)
>          qemu_cond_init(&multifd_recv[i].cond);
>          multifd_recv[i].quit = false;
>          multifd_recv[i].started = false;
> +        multifd_recv[i].done = true;
> +        multifd_init_group(&multifd_recv[i].pages);
>          multifd_recv[i].c = socket_recv_channel_create();
> -
>          if(!multifd_recv[i].c) {
>              error_report("Error creating a recv channel");
>              exit(0);
> @@ -664,6 +685,45 @@ void migrate_multifd_recv_threads_create(void)
>      }
>  }
> 
> +static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
> +{
> +    int i, thread_count;
> +    MultiFDRecvParams *params;
> +    static multifd_pages_t pages;
> +    static bool once = false;
> +
> +    if (!once) {
> +        multifd_init_group(&pages);
> +        once = true;
> +    }
> +
> +    pages.address[pages.num] = address;
> +    pages.num++;
> +
> +    if (fd_num == UINT16_MAX) {
> +        return;
> +    }
> +
> +    thread_count = migrate_multifd_threads();
> +    assert(fd_num < thread_count);
> +    params = &multifd_recv[fd_num];
> +
> +    qemu_mutex_lock(&multifd_recv_mutex);
> +    while (!params->done) {
> +        qemu_cond_wait(&multifd_recv_cond, &multifd_recv_mutex);
> +    }
> +    params->done = false;
> +    qemu_mutex_unlock(&multifd_recv_mutex);
> +    qemu_mutex_lock(&params->mutex);
> +    for(i = 0; i < pages.num; i++) {
> +        params->pages.address[i] = pages.address[i];
> +    }
> +    params->pages.num = pages.num;
> +    pages.num = 0;
> +    qemu_cond_signal(&params->cond);
> +    qemu_mutex_unlock(&params->mutex);
> +}
> +
>  /**
>   * save_page_header: Write page header to wire
>   *
> @@ -1097,7 +1157,7 @@ static int ram_multifd_page(QEMUFile *f, PageSearchStatus *pss,
>      if (pages == -1) {
>          *bytes_transferred +=
>              save_page_header(f, block, offset | RAM_SAVE_FLAG_MULTIFD_PAGE);
> -        fd_num = multifd_send_page(p);
> +        fd_num = multifd_send_page(p, migration_dirty_pages == 1);
>          qemu_put_be16(f, fd_num);
>          *bytes_transferred += 2; /* size of fd_num */
>          qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
> @@ -2920,10 +2980,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> 
>          case RAM_SAVE_FLAG_MULTIFD_PAGE:
>              fd_num = qemu_get_be16(f);
> -            if (fd_num != 0) {
> -                /* this is yet an unused variable, changed later */
> -                fd_num = fd_num;
> -            }
> +            multifd_recv_page(host, fd_num);

This is going to be quite tricky to fit into ram_load_postcopy
in this form; somehow it's going to have to find addresses to use for place page
and with anything with a page size != target page size it gets messy.

Dave

>              qemu_get_buffer(f, host, TARGET_PAGE_SIZE);
>              break;
> 
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
