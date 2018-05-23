Received: from eggs.gnu.org ([2001:4830:134:3::10]:45793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRU5-0008Ny-U1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fLRU2-0007iP-Nj
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:59:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39642 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fLRU2-0007iD-If
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:59:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2437818BAF5
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 10:59:05 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180503093646.GA2660@work-vm> (David Alan Gilbert's message of
	"Thu, 3 May 2018 10:36:46 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-15-quintela@redhat.com>
	<20180503093646.GA2660@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 23 May 2018 12:59:03 +0200
Message-ID: <87k1rubpu0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 14/21] migration: Multifd channels
 always wait on the sem
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
>> Either for quit, sync or packet, we first wake them.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 0f1340b4e3..21b448c4ed 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -754,6 +754,7 @@ static void *multifd_send_thread(void *opaque)
>>      p->num_packets = 1;
>>  
>>      while (true) {
>> +        qemu_sem_wait(&p->sem);
>>          qemu_mutex_lock(&p->mutex);
>>          multifd_send_fill_packet(p);
>>          if (p->quit) {
>> @@ -761,7 +762,9 @@ static void *multifd_send_thread(void *opaque)
>>              break;
>>          }
>>          qemu_mutex_unlock(&p->mutex);
>> -        qemu_sem_wait(&p->sem);
>> +        /* this is impossible */
>> +        error_setg(&local_err, "multifd_send_thread: Unknown command");
>> +        break;
>
> This error disappears in a later patch saying that you can have spurious
> wakeups.
>
>>      }
>>  
>>  out:
>> @@ -905,6 +908,7 @@ static void *multifd_recv_thread(void *opaque)
>>      trace_multifd_recv_thread_start(p->id);
>>  
>>      while (true) {
>> +        qemu_sem_wait(&p->sem);
>>          qemu_mutex_lock(&p->mutex);
>
> All this stuff seems to change again in later patches.

Tricky :-(

Except, for patches 18, 19 and 20, everything else is independent and
works in every interval.  18 and 19 don't work (for multifd).  So, I
have the option of:
- creating a bigger patch that is more difficult to understand (my
  humble opinion)
- or having it split logically but that they don't work.

The real problem is that before we really send data through the
channels, we synchronize on one sem (that is reception).  After we start
sending data through the channels, reception synchronizes in one
read().  "faking" synchronizations on reads() while you are not reading
is "interesting".

Later, JUan.
