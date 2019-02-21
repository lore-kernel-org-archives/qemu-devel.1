Received: from eggs.gnu.org ([209.51.188.92]:49389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwtLk-0007XP-OE
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwtLj-0008M7-Nb
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:45:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwtLj-0008Lr-Em
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:45:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AFC7E37E79
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 18:45:34 +0000 (UTC)
Date: Thu, 21 Feb 2019 18:45:30 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221184529.GQ2605@work-vm>
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220115611.3192-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] multifd: Create new
 next_packet_size field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> We need to send this field when we add compression support.  As we are
> still on x- stage, we can do this kind of changes.

Can you explain this a bit more; I'm confused how you can know what the
next size is going to be until you've got there.

Dave

> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c        | 15 +++++++++++++--
>  migration/trace-events |  4 ++--
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 29f0d431a8..26ed26fc2d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -534,6 +534,8 @@ typedef struct {
>      /* maximum number of allocated pages */
>      uint32_t pages_alloc;
>      uint32_t pages_used;
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
>      uint64_t packet_num;
>      char ramblock[256];
>      uint64_t offset[];
> @@ -581,6 +583,8 @@ typedef struct {
>      MultiFDPacket_t *packet;
>      /* multifd flags for each packet */
>      uint32_t flags;
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
>      /* thread local variables */
> @@ -617,6 +621,8 @@ typedef struct {
>      /* global number of generated multifd packets */
>      uint64_t packet_num;
>      /* thread local variables */
> +    /* size of the next packet that contains pages */
> +    uint32_t next_packet_size;
>      /* packets sent through this channel */
>      uint64_t num_packets;
>      /* pages sent through this channel */
> @@ -721,6 +727,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>      packet->flags = cpu_to_be32(p->flags);
>      packet->pages_alloc = cpu_to_be32(migrate_multifd_page_count());
>      packet->pages_used = cpu_to_be32(p->pages->used);
> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>      packet->packet_num = cpu_to_be64(p->packet_num);
>  
>      if (p->pages->block) {
> @@ -772,6 +779,7 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>          return -1;
>      }
>  
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>      p->packet_num = be64_to_cpu(packet->packet_num);
>  
>      if (p->pages->used) {
> @@ -1011,6 +1019,7 @@ static void *multifd_send_thread(void *opaque)
>              uint64_t packet_num = p->packet_num;
>              uint32_t flags = p->flags;
>  
> +            p->next_packet_size = used * qemu_target_page_size();
>              multifd_send_fill_packet(p);
>              p->flags = 0;
>              p->num_packets++;
> @@ -1018,7 +1027,8 @@ static void *multifd_send_thread(void *opaque)
>              p->pages->used = 0;
>              qemu_mutex_unlock(&p->mutex);
>  
> -            trace_multifd_send(p->id, packet_num, used, flags);
> +            trace_multifd_send(p->id, packet_num, used, flags,
> +                               p->next_packet_size);
>  
>              ret = qio_channel_write_all(p->c, (void *)p->packet,
>                                          p->packet_len, &local_err);
> @@ -1253,7 +1263,8 @@ static void *multifd_recv_thread(void *opaque)
>  
>          used = p->pages->used;
>          flags = p->flags;
> -        trace_multifd_recv(p->id, p->packet_num, used, flags);
> +        trace_multifd_recv(p->id, p->packet_num, used, flags,
> +                           p->next_packet_size);
>          p->num_packets++;
>          p->num_pages += used;
>          qemu_mutex_unlock(&p->mutex);
> diff --git a/migration/trace-events b/migration/trace-events
> index bd2d0cd25a..a11e66e1d9 100644
> --- a/migration/trace-events
> +++ b/migration/trace-events
> @@ -77,13 +77,13 @@ get_queued_page_not_dirty(const char *block_name, uint64_t tmp_offset, unsigned
>  migration_bitmap_sync_start(void) ""
>  migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
>  migration_throttle(void) ""
> -multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags) "channel %d packet number %" PRIu64 " pages %d flags 0x%x"
> +multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet number %" PRIu64 " pages %d flags 0x%x next packet size %d"
>  multifd_recv_sync_main(long packet_num) "packet num %ld"
>  multifd_recv_sync_main_signal(uint8_t id) "channel %d"
>  multifd_recv_sync_main_wait(uint8_t id) "channel %d"
>  multifd_recv_thread_end(uint8_t id, uint64_t packets, uint64_t pages) "channel %d packets %" PRIu64 " pages %" PRIu64
>  multifd_recv_thread_start(uint8_t id) "%d"
> -multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x"
> +multifd_send(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %d packet_num %" PRIu64 " pages %d flags 0x%x next packet size %d"
>  multifd_send_sync_main(long packet_num) "packet num %ld"
>  multifd_send_sync_main_signal(uint8_t id) "channel %d"
>  multifd_send_sync_main_wait(uint8_t id) "channel %d"
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
