Received: from eggs.gnu.org ([209.51.188.92]:46632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwt7d-0000Iu-Na
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gwt7N-00077E-4o
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gwt7L-0006so-UK
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:30:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1F8408763A
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 18:30:25 +0000 (UTC)
Date: Thu, 21 Feb 2019 18:30:21 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190221183020.GO2605@work-vm>
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220115611.3192-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] multifd: Be flexible about packet
 size
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
> This way we can change the packet size in the future and everything
> will work.  We choose an arbitrary big number (100 times configured
> size) as a limit about how big we will reallocate.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e22d02760b..75a8fc21f8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -723,13 +723,13 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>  {
>      MultiFDPacket_t *packet = p->packet;
> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint32_t page_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      int i;
>  
>      packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>      packet->version = cpu_to_be32(MULTIFD_VERSION);
>      packet->flags = cpu_to_be32(p->flags);
> -    packet->pages_alloc = cpu_to_be32(page_count);
> +    packet->pages_alloc = cpu_to_be32(page_max);
>      packet->pages_used = cpu_to_be32(p->pages->used);
>      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>      packet->packet_num = cpu_to_be64(p->packet_num);
> @@ -746,7 +746,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>  {
>      MultiFDPacket_t *packet = p->packet;
> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
> +    uint32_t pages_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>      RAMBlock *block;
>      int i;
>  
> @@ -769,12 +769,24 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>      p->flags = be32_to_cpu(packet->flags);
>  
>      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
> -    if (packet->pages_alloc > page_count) {
> +    /*
> +     * If we recevied a packet that is 100 times bigger than expected
> +     * just stop migration.  It is a magic number.
> +     */
> +    if (packet->pages_alloc > pages_max * 100) {
>          error_setg(errp, "multifd: received packet "
> -                   "with size %d and expected maximum size %d",
> -                   packet->pages_alloc, page_count) ;
> +                   "with size %d and expected size %d",
> +                   packet->pages_alloc, pages_max) ;

Should that end with pages_max * 100 ?

>          return -1;
>      }
> +    /*
> +     * We received a packet that is bigger than expected but inside
> +     * reasonable limits (see previous comment).  Just reallocate.
> +     */
> +    if (packet->pages_alloc > p->pages->allocated) {
> +        multifd_pages_clear(p->pages);
> +        multifd_pages_init(packet->pages_alloc);
> +    }
>  
>      p->pages->used = be32_to_cpu(packet->pages_used);
>      if (p->pages->used > packet->pages_alloc) {

Other than that error message, I think it's OK, although the names get
very confusing (max, alloc, allocated)


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
