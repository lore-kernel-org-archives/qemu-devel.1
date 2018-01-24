Received: from eggs.gnu.org ([2001:4830:134:3::10]:53223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eeM3Y-0004Pi-AM
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eeM3U-0003WV-Bf
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:29:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eeM3U-0003VS-2O
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 09:29:36 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22BB3FEF1C
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 14:29:35 +0000 (UTC)
Date: Wed, 24 Jan 2018 14:29:26 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180124142926.GE2497@work-vm>
References: <20180110124723.11879-1-quintela@redhat.com>
	<20180110124723.11879-13-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110124723.11879-13-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 12/14] migration: Sent the page list
 over the normal thread
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Hmm not sure what this one is doing;  is this permanent?
Is there a guarantee already that all the pages in one chunk sent over
multifd are from the same RAMBlock?
(and there's a printf down there)

Dave

> ---
>  migration/ram.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b1ad7b2730..f636c7da0a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -411,6 +411,19 @@ static void compress_threads_save_setup(void)
>  /* used to continue on the same multifd group */
>  #define MULTIFD_CONTINUE UINT16_MAX
>  
> +#define MULTIFD_MAGIC 0x112233d
> +#define MULTIFD_VERSION 1
> +
> +typedef struct {
> +    uint32_t magic;
> +    uint32_t version;
> +    uint32_t size;
> +    uint32_t used;
> +    uint32_t seq;
> +    char ramblock[256];
> +    ram_addr_t offset[];
> +} __attribute__((packed)) MultiFDPacket_t;
> +
>  typedef struct {
>      /* number of used pages */
>      uint32_t used;
> @@ -420,6 +433,8 @@ typedef struct {
>      uint32_t seq;
>      struct iovec *iov;
>      RAMBlock *block;
> +    uint32_t packet_len;
> +    MultiFDPacket_t *packet;
>  } multifd_pages_t;
>  
>  struct MultiFDSendParams {
> @@ -456,6 +471,8 @@ static void multifd_pages_init(multifd_pages_t **ppages, size_t size)
>  
>      pages->allocated = size;
>      pages->iov = g_new0(struct iovec, size);
> +    pages->packet_len = sizeof(MultiFDPacket_t) + sizeof(ram_addr_t) * size;
> +    pages->packet = g_malloc0(pages->packet_len);
>      *ppages = pages;
>  }
>  
> @@ -467,6 +484,9 @@ static void multifd_pages_clear(multifd_pages_t *pages)
>      pages->block = NULL;
>      g_free(pages->iov);
>      pages->iov = NULL;
> +    pages->packet_len = 0;
> +    g_free(pages->packet);
> +    pages->packet = NULL;
>      g_free(pages);
>  }
>  
> @@ -553,16 +573,27 @@ static void *multifd_send_thread(void *opaque)
>              break;
>          }
>          if (p->pages->used) {
> +            MultiFDPacket_t *packet = p->pages->packet;
>              Error *local_err = NULL;
>              size_t ret;
> -            uint32_t used;
>  
> -            used = p->pages->used;
> +            packet->used = p->pages->used;
>              p->pages->used = 0;
>              qemu_mutex_unlock(&p->mutex);
> -
> -            trace_multifd_send(p->id, p->pages->seq, used);
> -            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
> +            packet->magic = MULTIFD_MAGIC;
> +            packet->version = MULTIFD_VERSION;
> +            strncpy(packet->ramblock, p->pages->block->idstr, 256);
> +            packet->size = migrate_multifd_page_count();
> +            packet->seq = p->pages->seq;
> +            ret = qio_channel_write_all(p->c, (void *)packet,
> +                                        p->pages->packet_len, &local_err);
> +            if (ret != 0) {
> +                terminate_multifd_send_threads(local_err);
> +                return NULL;
> +            }
> +            trace_multifd_send(p->id, p->pages->seq, packet->used);
> +            ret = qio_channel_writev_all(p->c, p->pages->iov,
> +                                         packet->used, &local_err);
>              if (ret != 0) {
>                  terminate_multifd_send_threads(local_err);
>                  return NULL;
> @@ -645,6 +676,7 @@ static uint16_t multifd_send_page(RAMBlock *block, ram_addr_t offset,
>          pages->block = block;
>      }
>  
> +    pages->packet->offset[pages->used] = offset;
>      pages->iov[pages->used].iov_base = block->host + offset;
>      pages->iov[pages->used].iov_len = TARGET_PAGE_SIZE;
>      pages->used++;
> @@ -776,16 +808,35 @@ static void *multifd_recv_thread(void *opaque)
>              break;
>          }
>          if (p->pages->used) {
> +            MultiFDPacket_t *packet = p->pages->packet;
> +            RAMBlock *block;
>              Error *local_err = NULL;
>              size_t ret;
> -            uint32_t used;
> +            int i;
>  
> -            used = p->pages->used;
>              p->pages->used = 0;
>              qemu_mutex_unlock(&p->mutex);
>  
> -            trace_multifd_recv(p->id, p->pages->seq, used);
> -            ret = qio_channel_readv_all(p->c, p->pages->iov, used, &local_err);
> +            ret = qio_channel_read_all(p->c, (void *)packet,
> +                                       p->pages->packet_len, &local_err);
> +            if (ret != 0) {
> +                terminate_multifd_recv_threads(local_err);
> +                return NULL;
> +            }
> +            block = qemu_ram_block_by_name(packet->ramblock);
> +            p->pages->seq = packet->seq;
> +            for (i = 0; i < packet->used; i++) {
> +                if (block->host + packet->offset[i]
> +                    != p->pages->iov[i].iov_base) {
> +                    printf("page offset %d packet %p pages %p\n", i,
> +                           block->host + packet->offset[i],
> +                           p->pages->iov[i].iov_base);
> +                    break;
> +                }
> +            }
> +            trace_multifd_recv(p->id, p->pages->seq, packet->used);
> +            ret = qio_channel_readv_all(p->c, p->pages->iov,
> +                                        packet->used, &local_err);
>              if (ret != 0) {
>                  terminate_multifd_recv_threads(local_err);
>                  return NULL;
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
