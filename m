Received: from eggs.gnu.org ([2001:4830:134:3::10]:35625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crNAt-0005Mk-BN
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1crNAq-0006z4-6B
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1crNAp-0006xU-U9
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 07:14:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E52ACF622F
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 11:14:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170324105256.GI2901@work-vm> (David Alan Gilbert's message of
	"Fri, 24 Mar 2017 10:52:56 +0000")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-36-quintela@redhat.com>
	<20170324105256.GI2901@work-vm>
Reply-To: quintela@redhat.com
Date: Fri, 24 Mar 2017 12:14:25 +0100
Message-ID: <87vaqz6i5q.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 35/51] ram: Add QEMUFile to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 17 ++++++++++-------
>>  1 file changed, 10 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c0d6841..7667e73 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -165,6 +165,8 @@ struct RAMSrcPageRequest {
>>  
>>  /* State of RAM for migration */
>>  struct RAMState {
>> +    /* QEMUFile used for this migration */
>> +    QEMUFile *f;
>
> Yes, I guess you're hoping that becomes 'for this RAMBlock' eventually?

For this ramblock or for this migration.  For some reason that I can't
yet fully understand people continues asking about starting a new migration
before the previous one has finished.  No, I haven't a good explanation
for why that could be a good idea.

Later, Juan.

>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>>      /* Last block that we have visited searching for dirty pages */
>>      RAMBlock *last_seen_block;
>>      /* Last block from where we have sent data */
>> @@ -524,14 +526,13 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
>>   *          -1 means that xbzrle would be longer than normal
>>   *
>>   * @rs: current RAM state
>> - * @f: QEMUFile where to send the data
>>   * @current_data: contents of the page
>>   * @current_addr: addr of the page
>>   * @block: block that contains the page we want to send
>>   * @offset: offset inside the block for the page
>>   * @last_stage: if we are at the completion stage
>>   */
>> -static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
>> +static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>>                              ram_addr_t current_addr, RAMBlock *block,
>>                              ram_addr_t offset, bool last_stage)
>>  {
>> @@ -582,10 +583,11 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
>>      }
>>  
>>      /* Send XBZRLE based compressed page */
>> -    bytes_xbzrle = save_page_header(f, block, offset | RAM_SAVE_FLAG_XBZRLE);
>> -    qemu_put_byte(f, ENCODING_FLAG_XBZRLE);
>> -    qemu_put_be16(f, encoded_len);
>> -    qemu_put_buffer(f, XBZRLE.encoded_buf, encoded_len);
>> +    bytes_xbzrle = save_page_header(rs->f, block,
>> +                                    offset | RAM_SAVE_FLAG_XBZRLE);
>> +    qemu_put_byte(rs->f, ENCODING_FLAG_XBZRLE);
>> +    qemu_put_be16(rs->f, encoded_len);
>> +    qemu_put_buffer(rs->f, XBZRLE.encoded_buf, encoded_len);
>>      bytes_xbzrle += encoded_len + 1 + 2;
>>      rs->xbzrle_pages++;
>>      rs->xbzrle_bytes += bytes_xbzrle;
>> @@ -849,7 +851,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>>              ram_release_pages(ms, block->idstr, pss->offset, pages);
>>          } else if (!rs->ram_bulk_stage &&
>>                     !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
>> -            pages = save_xbzrle_page(rs, f, &p, current_addr, block,
>> +            pages = save_xbzrle_page(rs, &p, current_addr, block,
>>                                       offset, last_stage);
>>              if (!last_stage) {
>>                  /* Can't send this cached data async, since the cache page
>> @@ -2087,6 +2089,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>>              return -1;
>>           }
>>      }
>> +    rs->f = f;
>>  
>>      rcu_read_lock();
>>  
>> -- 
>> 2.9.3
>> 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
