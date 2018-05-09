Received: from eggs.gnu.org ([2001:4830:134:3::10]:53722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGUzF-00029O-0V
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:42:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGUzA-0004IO-JO
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:42:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33700 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGUzA-0004II-DT
	for qemu-devel@nongnu.org; Wed, 09 May 2018 15:42:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCAFE40200B3
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 19:42:47 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180503104437.GC2660@work-vm> (David Alan Gilbert's message of
	"Thu, 3 May 2018 11:44:38 +0100")
References: <20180425112723.1111-1-quintela@redhat.com>
	<20180425112723.1111-17-quintela@redhat.com>
	<20180503104437.GC2660@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 09 May 2018 21:45:00 +0200
Message-ID: <87lgcs396r.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v12 16/21] migration: Synchronize multifd
 threads with main thread
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
>> We synchronize all threads each RAM_SAVE_FLAG_EOS.  Bitmap
>> synchronizations don't happen inside a  ram section, so we are safe
>> about two channels trying to overwrite the same memory.
>
> OK, that's quite neat - so you don't need any extra flags in the stream
> to do the sync;  it probably needs a comment in the code somewhere so we
> don't forget!

Thanks.

>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  migration/ram.c        | 118 +++++++++++++++++++++++++++++++++++++----
>>  migration/trace-events |   6 +++
>>  2 files changed, 113 insertions(+), 11 deletions(-)
>> 
>> diff --git a/migration/ram.c b/migration/ram.c
>> index c4c185cc4c..398cb0af3b 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -405,6 +405,8 @@ static void compress_threads_save_setup(void)
>>  #define MULTIFD_MAGIC 0x11223344U
>>  #define MULTIFD_VERSION 1
>>  
>> +#define MULTIFD_FLAG_SYNC (1 << 0)
>> +
>>  typedef struct {
>>      uint32_t magic;
>>      uint32_t version;
>> @@ -471,6 +473,8 @@ typedef struct {
>>      uint32_t num_packets;
>>      /* pages sent through this channel */
>>      uint32_t num_pages;
>> +    /* syncs main thread and channels */
>> +    QemuSemaphore sem_sync;
>>  }  MultiFDSendParams;
>>  
>>  typedef struct {
>> @@ -507,6 +511,8 @@ typedef struct {
>>      uint32_t num_packets;
>>      /* pages sent through this channel */
>>      uint32_t num_pages;
>> +    /* syncs main thread and channels */
>> +    QemuSemaphore sem_sync;
>>  } MultiFDRecvParams;
>>  
>>  static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
>> @@ -682,6 +688,10 @@ struct {
>>      int count;
>>      /* array of pages to sent */
>>      MultiFDPages_t *pages;
>> +    /* syncs main thread and channels */
>> +    QemuSemaphore sem_sync;
>> +    /* global number of generated multifd packets */
>> +    uint32_t seq;
>
> It's interesting you use the same comment for 'seq' in
> MultiFDSendParams - but I guess that means only this one is the global
> version and the others aren't really global number - they're just
> local to that thread?

Only place that "increases/generates" seq is multifd_send_pages(), that
is what creates a new packet to be sent.  So, if we see _any_ packet on
the wire, we know the real global ordering.  They are only used for
traces, to se that packet 42 was sent through channel 3, and on
reception you check that packet 42 is what you received through channel
3.  They only appears on traces, but I find they useful for debugging
synchcronization errors.


>> +    for (i = 0; i < migrate_multifd_channels(); i++) {
>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        trace_multifd_send_sync_main_signal(p->id);
>> +
>> +        qemu_mutex_lock(&p->mutex);
>> +        p->flags |= MULTIFD_FLAG_SYNC;
>> +        p->pending_job++;
>> +        qemu_mutex_unlock(&p->mutex);
>> +        qemu_sem_post(&p->sem);
>> +    }

[1]

>> +    for (i = 0; i < migrate_multifd_channels(); i++) {
>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        trace_multifd_send_sync_main_wait(p->id);
>> +        qemu_sem_wait(&multifd_send_state->sem_sync);
>> +    }

[2]

>> +    trace_multifd_send_sync_main(multifd_send_state->seq);
>> +}
>> +
>
> OK, so this just makes each of the sending threads ack, so that seems
> OK.
> But what happens with an error? multifd_send_sync_main exits it's
> loop with a 'break' if the writes fail, and that could mean they never
> come and post the flag-sync sem.

Let's see.

[1]: we are just doing mutex_lock/sem_post(), if we are not able to do
that, we have got a big race that needs to be fixed.  So that bit is ok.

[2]: We do an unconditional sem_wait().  Looking at the worker code.
     In this patch level, we are ok, but I agree with you than in later
     patches, we need to also do the post on the error case.  Changing.

>> +
>> +        trace_multifd_recv_sync_main_wait(p->id);
>> +        qemu_sem_wait(&multifd_recv_state->sem_sync);
>> +        qemu_mutex_lock(&p->mutex);
>> +        if (multifd_recv_state->seq < p->seq) {
>> +            multifd_recv_state->seq = p->seq;
>> +        }
>
> Can you explain what this is for?
> Something like the latest received block?

When we are at a synhronization point, we don't know on the main thread
when that synchronization happened (at what packet considered as a
logical list of packages).  So, we choose 'seq' from the channel with
the highest number.   That is the one that we want.  We only use this
for tracing, so we can "match" that we did a synchronization on the send
side at packet N and we see the trace at reception side that we did it
at packet N also.

Remember than in a  previous patch you asked me what happened if this
does a wark around?  At that point nothing.  But now I need to change
this code to be.


    multifd_recv_state->seq = 0;
    for (i = 0; i < migrate_multifd_channels(); i++) {
        MultiFDRecvParams *p = &multifd_recv_state->params[i];
        ...
        if (multifd_recv_state->seq < p->seq) {
            multifd_recv_state->seq = p->seq;
        }

And I have fixed the workaround problem, no?

>> @@ -933,9 +1019,8 @@ static void *multifd_recv_thread(void *opaque)
>>      trace_multifd_recv_thread_start(p->id);
>>  
>>      while (true) {
>> -        qemu_sem_wait(&p->sem);
>>          qemu_mutex_lock(&p->mutex);
>> -        if (p->pending_job) {
>> +        if (true || p->pending_job) {
>
> A TODO I guess???

Oops, that should be out.

Fixed on next version.

>>              uint32_t used;
>>              uint32_t flags;
>>              qemu_mutex_unlock(&p->mutex);
>> @@ -956,14 +1041,18 @@ static void *multifd_recv_thread(void *opaque)
>>              p->num_packets++;
>>              p->num_pages += used;
>>              qemu_mutex_unlock(&p->mutex);
>> +
>> +            if (flags & MULTIFD_FLAG_SYNC) {
>> +                qemu_sem_post(&multifd_recv_state->sem_sync);
>> +                qemu_sem_wait(&p->sem_sync);
>> +            }
>
> Can you explain the receive side logic - I think this is waiting for all
> receive threads to 'ack' - but how do we know that they've finished
> receiving all data that was sent?

Because they need to receive a packet with MULTIFD_FLAG_SYNC sent.  And
if they receive that flag, we know that is the last one of the sequence.

synchrconization works like (2 channels to make things easy):

                main thread:
                we finish a RAM_SECTION;
                flush pending packets to one of the channels
                send packet with MULTIFD_FLAG_SYNC for all the channels
                wait unil all the channels have processesed the FLAG_SYNC
                At this point send the RAM_SECTION_EOS footer.

worker1                                                worker 2

if there is a pending packet, send it                  if there is a pending packet, send it
(notice that there can't be more than one ever)
send a pacet with SYNC flag set                        send a pacet with SYNC flag set

On recetpion side


              main thread
              receives RAM_SECTION_EOS footer
              wait for works to receive a sync

worker1                                                worker1
process any pending packet(no sync)                    process any pending packet(no sync)
process packet with SYNC                               process packet with SYNC
post main thread                                       post main thread

              now main thread can continue

Notice that we don't care what happens first, receiving packet with SYNC
in workeers or RAM_SECTION_EOS on main thread, all works as expected.

Noticing how long took to explain this, I think that I am going to add
this to migration documentation.  Will wait for any question you had
before adding it.

Later, Juan.
