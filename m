Received: from eggs.gnu.org ([2001:4830:134:3::10]:44193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRMY-0006yn-7T
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRMV-0003rB-1B
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:51:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLRMU-0003qB-T2
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:51:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2F200818BAF5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:51:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180503145501.GH2660@work-vm> (David Alan Gilbert's message of
	"Thu, 3 May 2018 15:55:02 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-19-quintela@redhat.com>
	<20180503145501.GH2660@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 23 May 2018 12:51:15 +0200
Message-ID: <87o9h6bq70.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 18/21] migration: Start sending messages
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
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 862ec53d32..9adbaa81f9 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -625,9 +625,6 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>>      RAMBlock *block;
>>      int i;
>>  
>> -    /* ToDo: We can't use it until we haven't received a message */
>> -    return 0;
>> -
>>      be32_to_cpus(&packet->magic);
>>      if (packet->magic != MULTIFD_MAGIC) {
>>          error_setg(errp, "multifd: received packet "
>> @@ -851,6 +848,7 @@ static void *multifd_send_thread(void *opaque)
>>  {
>>      MultiFDSendParams *p = opaque;
>>      Error *local_err = NULL;
>> +    int ret;
>>  
>>      trace_multifd_send_thread_start(p->id);
>>  
>> @@ -878,10 +876,18 @@ static void *multifd_send_thread(void *opaque)
>>  
>>              trace_multifd_send(p->id, seq, used, flags);
>>  
>> -            /* ToDo: send packet here */
>> +            ret = qio_channel_write_all(p->c, (void *)p->packet,
>> +                                        p->packet_len, &local_err);
>> +            if (ret != 0) {
>> +                break;
>> +            }
>> +
>> +            ret = qio_channel_writev_all(p->c, p->pages->iov, used, &local_err);
>> +            if (ret != 0) {
>> +                break;
>> +            }
>>  
>>              qemu_mutex_lock(&p->mutex);
>> -            p->flags = 0;
>
> What's this change?

Leftover from previous approach on patch 16, we already do that
assignment several lines before.  Removed it on patch 16 as it should.

Thanks, Juan.
