Received: from eggs.gnu.org ([2001:4830:134:3::10]:44744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df8q0-0004Zj-Be
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1df8pw-0004pJ-Pi
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:02:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1df8pw-0004op-Gu
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 14:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC942C0587D3
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 18:02:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170808163047.GP2081@work-vm> (David Alan Gilbert's message of
	"Tue, 8 Aug 2017 17:30:48 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm> <87lgmu8346.fsf@secure.mitica>
	<20170808163047.GP2081@work-vm>
Reply-To: quintela@redhat.com
Date: Tue, 08 Aug 2017 20:02:31 +0200
Message-ID: <87ziba6iq0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
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
>> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
>> > * Juan Quintela (quintela@redhat.com) wrote:

...

>> > My feeling, without having fully thought it through, is that
>> > the locking around 'address' can be simplified; especially if the
>> > sending-thread never actually changes it.
>> >
>> > http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap04.html#tag_04_11
>> > defines that most of the pthread_ functions act as barriers;
>> > including the sem_post and pthread_cond_signal that qemu_sem_post
>> > uses.
>> 
>> At the end of the series the code is this:
>> 
>>     qemu_mutex_lock(&p->mutex);
>>     p->pages.num = pages->num;
>>     iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
>>              iov_size(pages->iov, pages->num));

****** HERE ******

>>     pages->num = 0;
>>     qemu_mutex_unlock(&p->mutex);
>>  
>> Are you sure that it looks like a good idea to drop the mutex?
>> 
>> The other thread uses pages->num to know if things are ready.
>
> Well, I wont push it too hard, but; if you:
>   a) Know that the other thread isn't accessing the iov
>       (because you previously know that it had set done)

This bit I know it is true.

>   b) Know the other thread wont access it until pages->num gets
>      set



>   c) Ensure that all changes to the iov are visible before
>      the pages->num write is visible - appropriate barriers/ordering

There is no barrier there that I can see.  I know that it probably work
on x86, but in others?  I think that it *** HERE **** we need that
memory barrier that we don't have.

> then you're good.  However, the mutex might be simpler.

Code (after all the changes) is:

    qemu_sem_wait(&multifd_send_state->sem);
    qemu_mutex_lock(&multifd_send_state->mutex);
    for (i = 0; i < multifd_send_state->count; i++) {
        p = &multifd_send_state->params[i];

        if (p->done) {
            p->done = false;
            break;
        }
    }
    qemu_mutex_unlock(&multifd_send_state->mutex);
    qemu_mutex_lock(&p->mutex);
    p->pages.num = pages->num;  /* we could probably switch this
                                   statement  with the next, but I doubt
                                   this would make a big difference */
    iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
             iov_size(pages->iov, pages->num));
    pages->num = 0;
    qemu_mutex_unlock(&p->mutex);
    qemu_sem_post(&p->sem);


And the other thread

        qemu_mutex_lock(&p->mutex);
        [...]
        if (p->pages.num) {
            int num;

            num = p->pages.num;
            p->pages.num = 0;
            qemu_mutex_unlock(&p->mutex);

            if (qio_channel_writev_all(p->c, p->pages.iov,
                                       num, &error_abort)
                != num * TARGET_PAGE_SIZE) {
                MigrationState *s = migrate_get_current();

                migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
                                  MIGRATION_STATUS_FAILED);
                terminate_multifd_send_threads();
                return NULL;
            }
            qemu_mutex_lock(&multifd_send_state->mutex);
            p->done = true;
            qemu_mutex_unlock(&multifd_send_state->mutex);
            qemu_sem_post(&multifd_send_state->sem);
            continue;
        }
        qemu_mutex_unlock(&p->mutex);
        qemu_sem_wait(&p->sem);

This code used to have condition variables for waiting.  With
semaphores, we can probably remove the p->mutex, but then we need to
think a lot each time that we do a change.

Later, Juan.
