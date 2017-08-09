Received: from eggs.gnu.org ([2001:4830:134:3::10]:57580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfLdY-0002mP-H4
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:42:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfLdU-0006n3-HY
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:42:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfLdU-0006m3-8a
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 03:42:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 994CE46269
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 07:42:32 +0000 (UTC)
Date: Wed, 9 Aug 2017 15:42:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170809074226.GI13486@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-11-quintela@redhat.com>
	<20170719190238.GK3500@work-vm>
	<20170720081005.GB23385@pxdev.xzpeter.org>
	<87d18682qh.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d18682qh.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 10/17] migration: Create ram_multifd_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, berrange@redhat.com

On Tue, Aug 08, 2017 at 06:04:54PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Jul 19, 2017 at 08:02:39PM +0100, Dr. David Alan Gilbert wrote:
> >> * Juan Quintela (quintela@redhat.com) wrote:
> 
> >> >  struct MultiFDSendParams {
> >> > +    /* not changed */
> >> >      uint8_t id;
> >> >      QemuThread thread;
> >> >      QIOChannel *c;
> >> >      QemuSemaphore sem;
> >> >      QemuMutex mutex;
> >> > +    /* protected by param mutex */
> >> >      bool quit;
> >> 
> >> Should probably comment to say what address space address is in - this
> >> is really a qemu pointer - and that's why we can treat 0 as special?
> >
> > I believe this comment is for "address" below.
> >
> > Yes, it would be nice to comment it. IIUC it belongs to virtual
> > address space of QEMU, so it should be okay to use zero as a "special"
> > value.
> 
> See new comments.
> 
> >> 
> >> > +    uint8_t *address;
> >> > +    /* protected by multifd mutex */
> >> > +    bool done;
> >> 
> >> done needs a comment to explain what it is because
> >> it sounds similar to quit;  I think 'done' is saying that
> >> the thread is idle having done what was asked?
> >
> > Since we know that valid address won't be zero, not sure whether we
> > can just avoid introducing the "done" field (even, not sure whether we
> > will need lock when modifying "address", I think not as well? Please
> > see below). For what I see this, it works like a state machine, and
> > "address" can be the state:
> >
> >             +--------  send thread ---------+
> >             |                               |
> >            \|/                              |
> >         address==0 (IDLE)               address!=0 (ACTIVE)
> >             |                              /|\
> >             |                               |
> >             +--------  main thread ---------+
> >
> > Then...
> 
> It is needed, we change things later in the series.  We could treat as
> an special case page.num == 0. But then we can differentiate the case
> where we have finished the last round and that we are in the beggining
> of the new one.

(Will comment below)

> 
> >> 
> >> >  };
> >> >  typedef struct MultiFDSendParams MultiFDSendParams;
> >> >  
> >> > @@ -375,6 +381,8 @@ struct {
> >> >      MultiFDSendParams *params;
> >> >      /* number of created threads */
> >> >      int count;
> >> > +    QemuMutex mutex;
> >> > +    QemuSemaphore sem;
> >> >  } *multifd_send_state;
> >> >  
> >> >  static void terminate_multifd_send_threads(void)
> >> > @@ -443,6 +451,7 @@ static void *multifd_send_thread(void *opaque)
> >> >      } else {
> >> >          qio_channel_write(p->c, string, MULTIFD_UUID_MSG, &error_abort);
> >> >      }
> >> > +    qemu_sem_post(&multifd_send_state->sem);
> >> >  
> >> >      while (!exit) {
> >> >          qemu_mutex_lock(&p->mutex);
> >> > @@ -450,6 +459,15 @@ static void *multifd_send_thread(void *opaque)
> >> >              qemu_mutex_unlock(&p->mutex);
> >> >              break;
> >> >          }
> >> > +        if (p->address) {
> >> > +            p->address = 0;
> >> > +            qemu_mutex_unlock(&p->mutex);
> >> > +            qemu_mutex_lock(&multifd_send_state->mutex);
> >> > +            p->done = true;
> >> > +            qemu_mutex_unlock(&multifd_send_state->mutex);
> >> > +            qemu_sem_post(&multifd_send_state->sem);
> >> > +            continue;
> >
> > Here instead of setting up address=0 at the entry, can we do this (no
> > "done" for this time)?
> >
> >                  // send the page before clearing p->address
> >                  send_page(p->address);
> >                  // clear p->address to switch to "IDLE" state
> >                  atomic_set(&p->address, 0);
> >                  // tell main thread, in case it's waiting
> >                  qemu_sem_post(&multifd_send_state->sem);
> >
> > And on the main thread...
> >
> >> > +        }
> >> >          qemu_mutex_unlock(&p->mutex);
> >> >          qemu_sem_wait(&p->sem);
> >> >      }
> >> > @@ -469,6 +487,8 @@ int multifd_save_setup(void)
> >> >      multifd_send_state = g_malloc0(sizeof(*multifd_send_state));
> >> >      multifd_send_state->params = g_new0(MultiFDSendParams, thread_count);
> >> >      multifd_send_state->count = 0;
> >> > +    qemu_mutex_init(&multifd_send_state->mutex);
> >> > +    qemu_sem_init(&multifd_send_state->sem, 0);
> >> >      for (i = 0; i < thread_count; i++) {
> >> >          char thread_name[16];
> >> >          MultiFDSendParams *p = &multifd_send_state->params[i];
> >> > @@ -477,6 +497,8 @@ int multifd_save_setup(void)
> >> >          qemu_sem_init(&p->sem, 0);
> >> >          p->quit = false;
> >> >          p->id = i;
> >> > +        p->done = true;
> >> > +        p->address = 0;
> >> >          p->c = socket_send_channel_create();
> >> >          if (!p->c) {
> >> >              error_report("Error creating a send channel");
> >> > @@ -491,6 +513,30 @@ int multifd_save_setup(void)
> >> >      return 0;
> >> >  }
> >> >  
> >> > +static int multifd_send_page(uint8_t *address)
> >> > +{
> >> > +    int i;
> >> > +    MultiFDSendParams *p = NULL; /* make happy gcc */
> >> > +
> >
> >
> >> > +    qemu_sem_wait(&multifd_send_state->sem);
> >> > +    qemu_mutex_lock(&multifd_send_state->mutex);
> >> > +    for (i = 0; i < multifd_send_state->count; i++) {
> >> > +        p = &multifd_send_state->params[i];
> >> > +
> >> > +        if (p->done) {
> >> > +            p->done = false;
> >> > +            break;
> >> > +        }
> >> > +    }
> >> > +    qemu_mutex_unlock(&multifd_send_state->mutex);
> >> > +    qemu_mutex_lock(&p->mutex);
> >> > +    p->address = address;
> >> > +    qemu_mutex_unlock(&p->mutex);
> >> > +    qemu_sem_post(&p->sem);
> >
> > ... here can we just do this?
> >
> > retry:
> >     // don't take any lock, only read each p->address
> >     for (i = 0; i < multifd_send_state->count; i++) {
> >         p = &multifd_send_state->params[i];
> >         if (!p->address) {
> >             // we found one IDLE send thread
> >             break;
> >         }
> >     }
> >     if (!p) {
> >         qemu_sem_wait(&multifd_send_state->sem);
> >         goto retry;
> >     }
> >     // we switch its state, IDLE -> ACTIVE
> >     atomic_set(&p->address, address);
> >     // tell the thread to start work
> >     qemu_sem_post(&p->sem);
> >
> > Above didn't really use any lock at all (either the per thread lock,
> > or the global lock). Would it work?
> 
> Probably (surely on x86).
> 
> But on the "final code", it becomes:
> 
>     qemu_mutex_lock(&multifd_send_state->mutex);
>     for (i = 0; i < multifd_send_state->count; i++) {
>         p = &multifd_send_state->params[i];
> 
>         if (p->done) {
>             p->done = false;
>             break;
>         }
>     }
>     qemu_mutex_unlock(&multifd_send_state->mutex);
>     qemu_mutex_lock(&p->mutex);
>     p->pages.num = pages->num;
>     iov_copy(p->pages.iov, pages->num, pages->iov, pages->num, 0,
>              iov_size(pages->iov, pages->num));
>     pages->num = 0;
>     qemu_mutex_unlock(&p->mutex);
>     qemu_sem_post(&p->sem);
> 
> So, we set done to false, without the global mutex (yes, we can change
> that for one atomic).

Yep. Then IMHO we should be able to avoid the global lock
(multifd_send_state->mutex).

Though I still think that p->done is not really necessary, since there
are only two valid states for each MultiFDSendParams, either:

  p->done == true, p->pages.num == 0

Which means the send thread is idle, or:

  p->done == true, p->pages.num > 0

Which means the send thread is busy. So logically p->pages.num
contains all the information already.

But I'm fine with either way.

> 
> But then we copy an iov without a lock?  With the other thread checking
> for pages->num == 0?  It sounds a bit fragile to me, no?

Yeah, for this one, not sure this can be achieved by careful ordering.
When we publish the send request, we may need to:

    for (i = 0; i < pages->num; i++) {
        p->pages.iov[j].iov_base = pages.iov[j].iov_base;
        p->pages.iov[j].iov_len = pages.iov[j].iov_len;
    }
    atomic_set(&p->pages.num, pages->num);
    qemu_sem_post(&p->sem);

The point is (just like when we were using address in current patch),
we use p->pages.num as a state, though for this time num==0 means
IDLE, but num>0 means busy. As long as we setup the IOVs before the
final state change, IMHO we should be fine.

Again, I'm also fine if we want to keep the locks at least in the
first version. I just think it may be faster if we can avoid using
those locks.

Thanks,

-- 
Peter Xu
