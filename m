Received: from eggs.gnu.org ([2001:4830:134:3::10]:36385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvT7s-0002nW-6V
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:24:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cvT7o-0002jE-CQ
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:24:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cvT7o-0002j9-6e
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 14:24:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1231F64D80
	for <qemu-devel@nongnu.org>; Tue,  4 Apr 2017 18:24:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170331090914.GC2408@work-vm> (David Alan Gilbert's message of
	"Fri, 31 Mar 2017 10:09:15 +0100")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-47-quintela@redhat.com>
	<20170331090914.GC2408@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 04 Apr 2017 20:24:13 +0200
Message-ID: <87efx83ub6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 46/51] ram: Remember last_page instead of
 last_offset
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
>>  migration/ram.c | 14 +++++++-------
>>  1 file changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index b1a031e..57b776b 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -171,8 +171,8 @@ struct RAMState {
>>      RAMBlock *last_seen_block;
>>      /* Last block from where we have sent data */
>>      RAMBlock *last_sent_block;
>> -    /* Last offset we have sent data from */
>> -    ram_addr_t last_offset;
>> +    /* Last dirty page we have sent */
>
> Can you make that 'Last dirty target page we have sent' 
> just so we know which shape page we're dealing with.

Done.

>> +    ram_addr_t last_page;
>>      /* last ram version we have seen */
>>      uint32_t last_version;
>>      /* We are in the first round */
>> @@ -1063,7 +1063,7 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>>      pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
>>                                                page);
>>      if (pss->complete_round && pss->block == rs->last_seen_block &&
>> -        pss->offset >= rs->last_offset) {
>> +        pss->offset >= rs->last_page) {
>
> That's odd; isn't pss->offset still in bytes?

It is not odd, it is wrong.

Fixed.

Thanks, Juan.
