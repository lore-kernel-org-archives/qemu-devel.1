Received: from eggs.gnu.org ([209.51.188.92]:34111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gyx02-0006HA-4E
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:03:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gywzv-0006xb-T1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:03:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1gywzt-0006u5-MO
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 06:03:35 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 84D8D300308F
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 11:03:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20190221183020.GO2605@work-vm> (David Alan Gilbert's message of
	"Thu, 21 Feb 2019 18:30:21 +0000")
References: <20190220115611.3192-1-quintela@redhat.com>
	<20190220115611.3192-6-quintela@redhat.com>
	<20190221183020.GO2605@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 27 Feb 2019 12:06:55 +0100
Message-ID: <874l8psd68.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> This way we can change the packet size in the future and everything
>> will work.  We choose an arbitrary big number (100 times configured
>> size) as a limit about how big we will reallocate.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index e22d02760b..75a8fc21f8 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -723,13 +723,13 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
>>  static void multifd_send_fill_packet(MultiFDSendParams *p)
>>  {
>>      MultiFDPacket_t *packet = p->packet;
>> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>> +    uint32_t page_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>>      int i;
>>  
>>      packet->magic = cpu_to_be32(MULTIFD_MAGIC);
>>      packet->version = cpu_to_be32(MULTIFD_VERSION);
>>      packet->flags = cpu_to_be32(p->flags);
>> -    packet->pages_alloc = cpu_to_be32(page_count);
>> +    packet->pages_alloc = cpu_to_be32(page_max);
>>      packet->pages_used = cpu_to_be32(p->pages->used);
>>      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>>      packet->packet_num = cpu_to_be64(p->packet_num);
>> @@ -746,7 +746,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>>  static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>  {
>>      MultiFDPacket_t *packet = p->packet;
>> -    uint32_t page_count = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>> +    uint32_t pages_max = MULTIFD_PACKET_SIZE / qemu_target_page_size();
>>      RAMBlock *block;
>>      int i;
>>  
>> @@ -769,12 +769,24 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>      p->flags = be32_to_cpu(packet->flags);
>>  
>>      packet->pages_alloc = be32_to_cpu(packet->pages_alloc);
>> -    if (packet->pages_alloc > page_count) {
>> +    /*
>> +     * If we recevied a packet that is 100 times bigger than expected
>> +     * just stop migration.  It is a magic number.
>> +     */
>> +    if (packet->pages_alloc > pages_max * 100) {
>>          error_setg(errp, "multifd: received packet "
>> -                   "with size %d and expected maximum size %d",
>> -                   packet->pages_alloc, page_count) ;
>> +                   "with size %d and expected size %d",
>> +                   packet->pages_alloc, pages_max) ;
>
> Should that end with pages_max * 100 ?

Not sure.

The *allocated* by defaault size is pages_max.  If we receive
bigger packets, we update it, but until a limit (arbitrary, I am open to
other limits).

So, what multifd is expecting here is pages_max.  But it will cope with
anything that is smaller than pages_max * 100.  So, what I should put on
the error message?  100 * pages_max or pages_max?

It appears that for you it is simpler to understand pages_max * 100, and
as I don't care, I am just changing it.

>>          return -1;
>>      }
>> +    /*
>> +     * We received a packet that is bigger than expected but inside
>> +     * reasonable limits (see previous comment).  Just reallocate.
>> +     */
>> +    if (packet->pages_alloc > p->pages->allocated) {
>> +        multifd_pages_clear(p->pages);
>> +        multifd_pages_init(packet->pages_alloc);
>> +    }
>>  
>>      p->pages->used = be32_to_cpu(packet->pages_used);
>>      if (p->pages->used > packet->pages_alloc) {
>
> Other than that error message, I think it's OK, although the names get
> very confusing (max, alloc, allocated)

I am open to suggestions.  I just got out of names :-(

>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.
