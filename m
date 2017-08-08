Received: from eggs.gnu.org ([2001:4830:134:3::10]:44686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df0M1-00076T-Bm
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df0Lw-00023w-Di
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:59:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df0Lw-00023L-42
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 04:59:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 093827C838
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 08:59:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170719164945.GH3500@work-vm> (David Alan Gilbert's message of
	"Wed, 19 Jul 2017 17:49:45 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-8-quintela@redhat.com>
	<20170719164945.GH3500@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 10:58:59 +0200
Message-ID: <878tiubfl8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 07/17] migration: Create multifd
 migration threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, berrange@redhat.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> Creation of the threads, nothing inside yet.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>

>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        qemu_mutex_lock(&p->mutex);
>> +        p->quit = true;
>> +        qemu_sem_post(&p->sem);
>> +        qemu_mutex_unlock(&p->mutex);
>
> I don't think you need that lock/unlock pair - as long as no one
> else is currently going around setting them to false; so as long
> as you know you're safely after initialisation and no one is trying
> to start a new migration at the moment then I think it's safe.

It is the error path, or the end of migration.  I get very nervous with:
*I think  that it is safe*, and specially, then I lost "moral
authority" when somebody else tries *not* to protect some access to a
variable.

If you prefer it, I can change that to one atomic, but I am not sure
that it would make a big difference.

And yes, in this case it is probably OK, because the sem_post() should
synchronize everything needed, but I am not one expert in all
architectures, better sorry than safe, no?

>> +    }
>> +}
>> +
>> +void multifd_save_cleanup(void)
>> +{
>> +    int i;
>> +
>> +    if (!migrate_use_multifd()) {
>> +        return;
>> +    }
>> +    terminate_multifd_send_threads();
>> +    for (i = 0; i < multifd_send_state->count; i++) {
>> +        MultiFDSendParams *p = &multifd_send_state->params[i];
>> +
>> +        qemu_thread_join(&p->thread);
>> +        qemu_mutex_destroy(&p->mutex);
>> +        qemu_sem_destroy(&p->sem);
>> +    }
>> +    g_free(multifd_send_state->params);
>> +    multifd_send_state->params = NULL;
>> +    g_free(multifd_send_state);
>> +    multifd_send_state = NULL;
>
> I'd be tempted to add a few traces around here, and also some
> protection against it being called twice.  Maybe it shouldn't
> happen, but it would be nice to debug it when it does.

I can change like I do on the reception side, As it is an array of
pointers, I can easily make them point to NULL.  What do you think?

>
>> +}
>> +
>> +static void *multifd_send_thread(void *opaque)
>> +{
>> +    MultiFDSendParams *p = opaque;
>> +
>> +    while (true) {
>> +        qemu_mutex_lock(&p->mutex);
>> +        if (p->quit) {
>> +            qemu_mutex_unlock(&p->mutex);
>> +            break;
>> +        }
>> +        qemu_mutex_unlock(&p->mutex);
>> +        qemu_sem_wait(&p->sem);
>
> Similar to above, I don't think you need those
> locks around the quit check.

For POSIX it is not strictly needed:



 Applications shall ensure that access to any memory location by more
 than one thread of control (threads or processes) is restricted such
 that no thread of control can read or modify a memory location while
 another thread of control may be modifying it. Such access is restricted
 using functions that synchronize thread execution and also synchronize
 memory with respect to other threads. The following functions
 synchronize memory with respect to other threads:

 fork() pthread_barrier_wait() pthread_cond_broadcast()
 pthread_cond_signal() pthread_cond_timedwait() pthread_cond_wait()
 pthread_create() pthread_join() pthread_mutex_lock()
 pthread_mutex_timedlock()

 pthread_mutex_trylock() pthread_mutex_unlock() pthread_spin_lock()
 pthread_spin_trylock() pthread_spin_unlock() pthread_rwlock_rdlock()
 pthread_rwlock_timedrdlock() pthread_rwlock_timedwrlock()
 pthread_rwlock_tryrdlock() pthread_rwlock_trywrlock()

 pthread_rwlock_unlock() pthread_rwlock_wrlock() sem_post()
 sem_timedwait() sem_trywait() sem_wait() semctl() semop() wait()
 waitpid()

sem_wait() synchronizes memory, but when we add more code to the mix, we
need to make sure that we call some function that synchronizes memory
there.  My experience is that this gets us into trouble along the road.

Just for starters, I never remember this list of functions from memory,
and secondly, in x86, if you are just assigning a variable, it just
works correctly almost always, so we always get the bugs on other
architectures.


>> +int multifd_load_setup(void)
>> +{
>> +    int thread_count;
>> +    uint8_t i;
>> +
>> +    if (!migrate_use_multifd()) {
>> +        return 0;
>> +    }
>> +    thread_count = migrate_multifd_threads();
>> +    multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
>> +    multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
>> +    multifd_recv_state->count = 0;
>> +    for (i = 0; i < thread_count; i++) {
>> +        char thread_name[16];
>> +        MultiFDRecvParams *p = &multifd_recv_state->params[i];
>> +
>> +        qemu_mutex_init(&p->mutex);
>> +        qemu_sem_init(&p->sem, 0);
>> +        p->quit = false;
>> +        p->id = i;
>> +        snprintf(thread_name, sizeof(thread_name), "multifdrecv_%d", i);
>> +        qemu_thread_create(&p->thread, thread_name, multifd_recv_thread, p,
>> +                           QEMU_THREAD_JOINABLE);
>> +        multifd_recv_state->count++;
>> +    }
>> +    return 0;
>> +}
>> +
>
> (It's a shame there's no way to wrap this boiler plate up to share
> between send/receive threads).

I want to share it with compress/decompress, but first I want to be sure
that this is the scheme that we want.

> However, all the above is minor, so:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks.
