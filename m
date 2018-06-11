Received: from eggs.gnu.org ([2001:4830:134:3::10]:32896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSKiM-0004df-JG
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fSKiJ-0007en-B0
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:10:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fSKiJ-0007eH-32
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 07:10:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 997D37C6C4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 11:10:18 +0000 (UTC)
Date: Mon, 11 Jun 2018 12:10:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180611111011.GC2661@work-vm>
References: <20180523111817.1463-1-quintela@redhat.com>
	<20180523111817.1463-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523111817.1463-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v13 02/12] migration: Create multifd packet
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
> We still don't put anything there.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> --
> fix magic (dave)
> check offset/ramblock  (dave)
> ---
>  migration/ram.c | 145 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 23cc5625eb..54350db8b0 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -510,6 +510,17 @@ typedef struct {
>      uint8_t id;
>  } __attribute__((packed)) MultiFDInit_t;
>  
> +typedef struct {
> +    uint32_t magic;
> +    uint32_t version;
> +    uint32_t flags;
> +    uint32_t size;
> +    uint32_t used;
> +    uint32_t seq;
> +    char ramblock[256];
> +    uint64_t offset[];
> +} __attribute__((packed)) MultiFDPacket_t;
> +
>  typedef struct {
>      /* number of used pages */
>      uint32_t used;
> @@ -544,6 +555,14 @@ typedef struct {
>      bool quit;
>      /* array of pages to sent */
>      MultiFDPages_t *pages;
> +    /* packet allocated len */
> +    uint32_t packet_len;
> +    /* pointer to the packet */
> +    MultiFDPacket_t *packet;
> +    /* multifd flags for each packet */
> +    uint32_t flags;
> +    /* global number of generated multifd packets */
> +    uint32_t seq;
>  }  MultiFDSendParams;
>  
>  typedef struct {
> @@ -566,6 +585,14 @@ typedef struct {
>      bool quit;
>      /* array of pages to receive */
>      MultiFDPages_t *pages;
> +    /* packet allocated len */
> +    uint32_t packet_len;
> +    /* pointer to the packet */
> +    MultiFDPacket_t *packet;
> +    /* multifd flags for each packet */
> +    uint32_t flags;
> +    /* global number of generated multifd packets */
> +    uint32_t seq;
>  } MultiFDRecvParams;
>  
>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
> @@ -654,6 +681,99 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>      g_free(pages);
>  }
>  
> +static void multifd_send_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    int i;
> +
> +    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> +    packet->version = cpu_to_be32(MULTIFD_VERSION);
> +    packet->flags = cpu_to_be32(p->flags);
> +    packet->size = cpu_to_be32(migrate_multifd_page_count());
> +    packet->used = cpu_to_be32(p->pages->used);
> +    packet->seq = cpu_to_be32(p->seq);
> +
> +    if (p->pages->block) {
> +        strncpy(packet->ramblock, p->pages->block->idstr, 256);
> +    }
> +
> +    for (i = 0; i < p->pages->used; i++) {
> +        packet->offset[i] = cpu_to_be64(p->pages->offset[i]);
> +    }
> +}
> +
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    RAMBlock *block;
> +    int i;
> +
> +    /* ToDo: We can't use it until we haven't received a message */
> +    return 0;
> +
> +    be32_to_cpus(&packet->magic);
> +    if (packet->magic != MULTIFD_MAGIC) {
> +        error_setg(errp, "multifd: received packet "
> +                   "magic %x and expected magic %x",
> +                   packet->magic, MULTIFD_MAGIC);
> +        return -1;
> +    }
> +
> +    be32_to_cpus(&packet->version);
> +    if (packet->version != MULTIFD_VERSION) {
> +        error_setg(errp, "multifd: received packet "
> +                   "version %d and expected version %d",
> +                   packet->version, MULTIFD_VERSION);
> +        return -1;
> +    }
> +
> +    p->flags = be32_to_cpu(packet->flags);
> +
> +    be32_to_cpus(&packet->size);
> +    if (packet->size > migrate_multifd_page_count()) {
> +        error_setg(errp, "multifd: received packet "
> +                   "with size %d and expected maximum size %d",
> +                   packet->size, migrate_multifd_page_count()) ;
> +        return -1;
> +    }
> +
> +    p->pages->used = be32_to_cpu(packet->used);
> +    if (p->pages->used > packet->size) {
> +        error_setg(errp, "multifd: received packet "
> +                   "with size %d and expected maximum size %d",
> +                   p->pages->used, packet->size) ;
> +        return -1;
> +    }
> +
> +    p->seq = be32_to_cpu(packet->seq);
> +
> +    if (p->pages->used) {
> +        /* make sure that ramblock is 0 terminated */
> +        packet->ramblock[255] = 0;
> +        block = qemu_ram_block_by_name(packet->ramblock);
> +        if (!block) {
> +            error_setg(errp, "multifd: unknown ram block %s",
> +                       packet->ramblock);
> +            return -1;
> +        }
> +    }
> +
> +    for (i = 0; i < p->pages->used; i++) {
> +        ram_addr_t offset = be64_to_cpu(packet->offset[i]);
> +
> +        if (offset > (block->used_length - TARGET_PAGE_SIZE)) {
> +            error_setg(errp, "multifd: offset too long %" PRId64
> +                       " (max %" PRId64 ")",
> +                       offset, block->max_length);
> +            return -1;
> +        }
> +        p->pages->iov[i].iov_base = block->host + offset;
> +        p->pages->iov[i].iov_len = TARGET_PAGE_SIZE;
> +    }
> +
> +    return 0;
> +}
> +
>  struct {
>      MultiFDSendParams *params;
>      /* number of created threads */
> @@ -711,6 +831,9 @@ int multifd_save_cleanup(Error **errp)
>          p->name = NULL;
>          multifd_pages_clear(p->pages);
>          p->pages = NULL;
> +        p->packet_len = 0;
> +        g_free(p->packet);
> +        p->packet = NULL;
>      }
>      g_free(multifd_send_state->params);
>      multifd_send_state->params = NULL;
> @@ -732,6 +855,7 @@ static void *multifd_send_thread(void *opaque)
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> +        multifd_send_fill_packet(p);
>          if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
>              break;
> @@ -796,6 +920,9 @@ int multifd_save_setup(void)
>          p->quit = false;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> +        p->packet_len = sizeof(MultiFDPacket_t)
> +                      + sizeof(ram_addr_t) * page_count;
> +        p->packet = g_malloc0(p->packet_len);
>          p->name = g_strdup_printf("multifdsend_%d", i);
>          socket_send_channel_create(multifd_new_send_channel_async, p);
>      }
> @@ -855,6 +982,9 @@ int multifd_load_cleanup(Error **errp)
>          p->name = NULL;
>          multifd_pages_clear(p->pages);
>          p->pages = NULL;
> +        p->packet_len = 0;
> +        g_free(p->packet);
> +        p->packet = NULL;
>      }
>      g_free(multifd_recv_state->params);
>      multifd_recv_state->params = NULL;
> @@ -867,10 +997,20 @@ int multifd_load_cleanup(Error **errp)
>  static void *multifd_recv_thread(void *opaque)
>  {
>      MultiFDRecvParams *p = opaque;
> +    Error *local_err = NULL;
> +    int ret;
>  
>      while (true) {
>          qemu_mutex_lock(&p->mutex);
> -        if (p->quit) {
> +        if (false)  {
> +            /* ToDo: Packet reception goes here */
> +
> +            ret = multifd_recv_unfill_packet(p, &local_err);
> +            qemu_mutex_unlock(&p->mutex);
> +            if (ret) {
> +                break;
> +            }
> +        } else if (p->quit) {
>              qemu_mutex_unlock(&p->mutex);
>              break;
>          }
> @@ -907,6 +1047,9 @@ int multifd_load_setup(void)
>          p->quit = false;
>          p->id = i;
>          p->pages = multifd_pages_init(page_count);
> +        p->packet_len = sizeof(MultiFDPacket_t)
> +                      + sizeof(ram_addr_t) * page_count;
> +        p->packet = g_malloc0(p->packet_len);
>          p->name = g_strdup_printf("multifdrecv_%d", i);
>      }
>      return 0;
> -- 
> 2.17.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
