Received: from eggs.gnu.org ([2001:4830:134:3::10]:53332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eOKa2-0003G4-43
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eOKZz-0007BH-1i
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eOKZy-0007AR-OO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 04:40:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE0E3C0587E1
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:40:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171017145151.GD2326@work-vm> (David Alan Gilbert's message of
	"Tue, 17 Oct 2017 15:51:52 +0100")
References: <20171004104636.7963-1-quintela@redhat.com>
	<20171004104636.7963-12-quintela@redhat.com>
	<20171017145151.GD2326@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 11 Dec 2017 10:40:49 +0100
Message-ID: <87609dr49q.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v9 11/12] migration: Flush receive queue
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

>> +/* We are getting low on pages flags, so we start using combinations
>> +   When we need to flush a page, we sent it as
>> +   RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_COMPRESS_PAGE
>> +   We don't allow that combination
>> +*/
>> +#define RAM_SAVE_FLAG_MULTIFD_SYNC \
>> +    (RAM_SAVE_FLAG_MULTIFD_PAGE | RAM_SAVE_FLAG_ZERO)
>
> Good that's better than last time; note you're using FLAG_ZERO where
> the comment says COMPRESS_PAGE and the commit message says COMPRESSED.

Fixed.

>
>> +
>>  static inline bool is_zero_range(uint8_t *p, uint64_t size)
>>  {
>>      return buffer_is_zero(p, size);
>> @@ -194,6 +202,9 @@ struct RAMState {
>>      uint64_t iterations_prev;
>>      /* Iterations since start */
>>      uint64_t iterations;
>> +    /* Indicates if we have synced the bitmap and we need to assure that
>> +       target has processeed all previous pages */
>> +    bool multifd_needs_flush;
>>      /* number of dirty bits in the bitmap */
>>      uint64_t migration_dirty_pages;
>>      /* protects modification of the bitmap */
>> @@ -614,9 +625,11 @@ struct MultiFDRecvParams {
>>      QIOChannel *c;
>>      QemuSemaphore ready;
>>      QemuSemaphore sem;
>> +    QemuCond cond_sync;
>>      QemuMutex mutex;
>>      /* proteced by param mutex */
>>      bool quit;
>> +    bool sync;
>>      multifd_pages_t pages;
>>      bool done;
>>  };
>> @@ -669,6 +682,7 @@ int multifd_load_cleanup(Error **errp)
>>          qemu_thread_join(&p->thread);
>>          qemu_mutex_destroy(&p->mutex);
>>          qemu_sem_destroy(&p->sem);
>> +        qemu_cond_destroy(&p->cond_sync);
>>          socket_recv_channel_destroy(p->c);
>>          g_free(p->name);
>>          p->name = NULL;
>> @@ -707,6 +721,10 @@ static void *multifd_recv_thread(void *opaque)
>>                  return NULL;
>>              }
>>              p->done = true;
>> +            if (p->sync) {
>> +                qemu_cond_signal(&p->cond_sync);
>> +                p->sync = false;
>> +            }
>>              qemu_mutex_unlock(&p->mutex);
>>              qemu_sem_post(&p->ready);
>>              continue;
>> @@ -752,9 +770,11 @@ void multifd_new_channel(QIOChannel *ioc)
>>      qemu_mutex_init(&p->mutex);
>>      qemu_sem_init(&p->sem, 0);
>>      qemu_sem_init(&p->ready, 0);
>> +    qemu_cond_init(&p->cond_sync);
>>      p->quit = false;
>>      p->id = msg.id;
>>      p->done = false;
>> +    p->sync = false;
>>      multifd_init_pages(&p->pages);
>>      p->c = ioc;
>>      multifd_recv_state->count++;
>> @@ -819,6 +839,27 @@ static void multifd_recv_page(uint8_t *address, uint16_t fd_num)
>>      qemu_sem_post(&p->sem);
>>  }
>>  
>> +static int multifd_flush(void)
>> +{
>> +    int i, thread_count;
>> +
>> +    if (!migrate_use_multifd()) {
>> +        return 0;
>> +    }
>> +    thread_count = migrate_multifd_channels();
>> +    for (i = 0; i < thread_count; i++) {
>> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
>> +
>> +        qemu_mutex_lock(&p->mutex);
>> +        while (!p->done) {
>> +            p->sync = true;
>> +            qemu_cond_wait(&p->cond_sync, &p->mutex);
>> +        }
>> +        qemu_mutex_unlock(&p->mutex);
>> +    }
>> +    return 0;
>> +}
pD>
> I wonder if we need some way of terminating this on error
> (e.g. if terminate_multifd_recev_threads is called for an error
> case).

It could be, I have to think about this.

Later, Juan.
