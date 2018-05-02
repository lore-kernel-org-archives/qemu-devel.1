Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDwbV-0003xp-Gz
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fDwbR-0000HR-GU
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:35:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60768 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fDwbR-0000Gw-AC
	for qemu-devel@nongnu.org; Wed, 02 May 2018 14:35:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2B05402291E
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 18:35:41 +0000 (UTC)
Date: Wed, 2 May 2018 19:35:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180502183533.GN2679@work-vm>
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425112723.1111-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 12/21] migration: Add multifd traces
 for start/end thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We want to know how many pages/packets each channel has sent.  Add
> counters for those.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c        | 20 ++++++++++++++++++++
>  migration/trace-events |  4 ++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 804c83ed89..0f1340b4e3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -465,6 +465,10 @@ typedef struct {
>      uint32_t flags;
>      /* global number of generated multifd packets */
>      uint32_t seq;
> +    /* packets sent through this channel */
> +    uint32_t num_packets;
> +    /* pages sent through this channel */
> +    uint32_t num_pages;
>  }  MultiFDSendParams;
>  
>  typedef struct {
> @@ -495,6 +499,10 @@ typedef struct {
>      uint32_t flags;
>      /* global number of generated multifd packets */
>      uint32_t seq;
> +    /* packets sent through this channel */
> +    uint32_t num_packets;
> +    /* pages sent through this channel */
> +    uint32_t num_pages;

Doesn't the comment for 'mutex' say 'protects the following parameters'
(added in 09/21) ?  In which case....

>  } MultiFDRecvParams;
>  
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> @@ -737,9 +745,13 @@ static void *multifd_send_thread(void *opaque)
>      MultiFDSendParams *p = opaque;
>      Error *local_err = NULL;
>  
> +    trace_multifd_send_thread_start(p->id);
> +
>      if (multifd_send_initial_packet(p, &local_err) < 0) {
>          goto out;
>      }
> +    /* initial packet */
> +    p->num_packets = 1;

That's writing to num_packets before the mutex is taken.

>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> @@ -761,6 +773,8 @@ out:
>      p->running = false;
>      qemu_mutex_unlock(&p->mutex);
>  
> +    trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
> +

and should this happen before they're released (OK, it's only a trace)

>      return NULL;
>  }
>  
> @@ -888,6 +902,8 @@ static void *multifd_recv_thread(void *opaque)
>      Error *local_err = NULL;
>      int ret;
>  
> +    trace_multifd_recv_thread_start(p->id);
> +
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
>          if (false)  {
> @@ -910,6 +926,8 @@ static void *multifd_recv_thread(void *opaque)
>      p->running = false;
>      qemu_mutex_unlock(&p->mutex);
>  
> +    trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
> +
>      return NULL;
>  }
>  
> @@ -975,6 +993,8 @@ void multifd_recv_new_channel(QIOChannel *ioc)
>      }
>      p->c = ioc;
>      object_ref(OBJECT(ioc));
> +    /* initial packet */
> +    p->num_packets = 1;

OK, the receive side here is different.

>      p->running = true;
>      qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> diff --git a/migration/trace-events b/migration/trace-events
> index a180d7b008..e480eb050e 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -77,6 +77,10 @@ ram_load_postcopy_loop(uint64_t addr, int flags) "@%" PRIx64 " %x"
>  ram_postcopy_send_discard_bitmap(void) ""
>  ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
>  ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
> +multifd_send_thread_start(uint8_t id) "%d"
> +multifd_send_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"
> +multifd_recv_thread_start(uint8_t id) "%d"
> +multifd_recv_thread_end(uint8_t id, uint32_t packets, uint32_t pages) "channel %d packets %d pages %d"

Please put the m's before the r's

Dave

>  # migration/migration.c
>  await_return_path_close_on_source_close(void) ""
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
