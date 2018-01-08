Received: from eggs.gnu.org ([2001:4830:134:3::10]:38828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYTfW-0002UG-O0
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:24:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eYTfR-0004vx-N6
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:24:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eYTfR-0004tJ-H5
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 04:24:29 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 881B87EBD3
	for <qemu-devel@nongnu.org>; Mon,  8 Jan 2018 09:24:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171017110705.GA2326@work-vm> (David Alan Gilbert's message of
	"Tue, 17 Oct 2017 12:07:05 +0100")
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-8-quintela@redhat.com>
	<20171017110705.GA2326@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 08 Jan 2018 10:24:21 +0100
Message-ID: <87efn0aeka.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 07/12] migration: Create thread
 infrastructure for multifd recv side
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
>> We make the locking and the transfer of information specific, even if we
>> are still receiving things through the main thread.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> 
>> --
>> 
>> We split when we create the main channel and where we start the main
>> migration thread, so we wait for the creation of the other threads.
>> 

>> @@ -668,12 +676,20 @@ static void *multifd_recv_thread(void *opaque)
>>  {
>>      MultiFDRecvParams *p = opaque;
>>  
>> +    qemu_sem_post(&p->ready);
>>      while (true) {
>>          qemu_mutex_lock(&p->mutex);
>>          if (p->quit) {
>>              qemu_mutex_unlock(&p->mutex);
>>              break;
>>          }
>> +        if (p->pages.num) {
>> +            p->pages.num = 0;
>
> This could do with some TODO comments in - since this code
> doesn't do anything useful yet and is confusing, but gets clearer
> when you add the filling in the later patches.

Added.


>> +            p->done = true;
>> +            qemu_mutex_unlock(&p->mutex);
>> +            qemu_sem_post(&p->ready);
>> +            continue;
>> +        }
>>          qemu_mutex_unlock(&p->mutex);
>>          qemu_sem_wait(&p->sem);
>>      }
>> @@ -714,13 +730,21 @@ void multifd_new_channel(QIOChannel *ioc)
>>      }
>>      qemu_mutex_init(&p->mutex);
>>      qemu_sem_init(&p->sem, 0);
>> +    qemu_sem_init(&p->ready, 0);
>>      p->quit = false;
>>      p->id = msg.id;
>> +    p->done = false;
>> +    multifd_init_pages(&p->pages);
>>      p->c = ioc;
>>      multifd_recv_state->count++;
>>      p->name = g_strdup_printf("multifdrecv_%d", msg.id);
>> +    object_ref(OBJECT(ioc));
>
> It would be good to comment to say where that gets unref'd.

Added this on Start of multiple fd work patch.

It belongs there, and there is where the unref is done.

Thanks, Juan.
