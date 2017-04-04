Received: from eggs.gnu.org ([2001:4830:134:3::10]:35307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvT5Q-0001SJ-Cy
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:21:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvT5N-0000lo-5m
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:21:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvT5M-0000lA-WB
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:21:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2EB680487
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 18:21:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170331122232.GE4514@work-vm> (David Alan Gilbert's message of
	"Fri, 31 Mar 2017 13:22:33 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-46-quintela@redhat.com>
	<20170331122232.GE4514@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 04 Apr 2017 20:21:42 +0200
Message-ID: <87inmk3ufd.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 45/51] ram: Use page number instead of an
 address for the bitmap operations
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
>> We use an unsigned long for the page number.  Notice that our bitmaps
>> already got that for the index, so we have that limit.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 76 ++++++++++++++++++++++++++-------------------------------
>>  1 file changed, 34 insertions(+), 42 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 6cd77b5..b1a031e 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -611,13 +611,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>>   * @rs: current RAM state
>>   * @rb: RAMBlock where to search for dirty pages
>>   * @start: starting address (typically so we can continue from previous page)
>> - * @ram_addr_abs: pointer into which to store the address of the dirty page
>> - *                within the global ram_addr space
>> + * @page: pointer into where to store the dirty page
>
> I'd prefer if you could call it 'page_abs' - it often gets tricky to know
> whether we're talking about a page offset within a RAMBlock or an
> offset within
> the whole bitmap.

I don't really care.  Changed.

> (I wish we had different index types)

This is C man!!
>> -                trace_get_queued_page(block->idstr,
>> -                                      (uint64_t)offset,
>> -                                      (uint64_t)*ram_addr_abs);
>> +                trace_get_queued_page(block->idstr, (uint64_t)offset,
>> +                                     *page);
>
> I think you need to fix the trace_ definitions for get_queued_page
> and get_queued_page_not_dirty they're currently taking uint64_t's for
> ram_addr and they now need to be long's (with the format changes).

Done.

Thanks, Juan.
