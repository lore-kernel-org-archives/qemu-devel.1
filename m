Received: from eggs.gnu.org ([2001:4830:134:3::10]:50856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMgu-0006pI-PQ
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGMgs-0006BT-8H
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:51:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGMgs-0006AU-3s
	for qemu-devel@nongnu.org; Wed, 09 May 2018 06:51:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A09F140200A0
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 10:51:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502175237.GL2679@work-vm> (David Alan Gilbert's message of
	"Wed, 2 May 2018 18:52:38 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-11-quintela@redhat.com>
	<20180502175237.GL2679@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 12:53:37 +0200
Message-ID: <87h8nh5ccu.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 10/21] migration: Create multipage
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We only create/destry the page list here.  We will use it later.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index ffefa73099..b19300992e 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -412,6 +412,20 @@ typedef struct {
>>      uint8_t id;
>>  } __attribute__((packed)) MultiFDInit_t;
>>  
>> +typedef struct {
>> +    /* number of used pages */
>> +    uint32_t used;
>> +    /* number of allocated pages */
>> +    uint32_t allocated;
>> +    /* global number of generated multifd packets */
>> +    uint32_t seq;
>
> Is that sufficiently large?
> Consider a 40Gbps link; that's ~4GByte/second,
> so if each packet is a 4K page, that's just over one hour at
> that link speed;  that's a long migration on a fast link, but
> it's not impossible is it - and what happens when it wraps?

Nothing really, it is just a counter that is used for traces.

Later, Juan.
