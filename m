Received: from eggs.gnu.org ([2001:4830:134:3::10]:42883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfhHM-0001c2-Cx
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 02:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dfhHJ-0000CC-8b
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 02:49:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dfhHI-0000Bg-Uv
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 02:49:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8E8E2733ED
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 06:49:07 +0000 (UTC)
Date: Thu, 10 Aug 2017 14:49:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170810064903.GN13486@pxdev.xzpeter.org>
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-18-quintela@redhat.com>
	<20170721024018.GB878@pxdev.xzpeter.org>
	<877eye9tit.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877eye9tit.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v5 17/17] migration: Flush receive queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com, berrange@redhat.com

On Tue, Aug 08, 2017 at 01:40:58PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Mon, Jul 17, 2017 at 03:42:38PM +0200, Juan Quintela wrote:
> >> Each time that we sync the bitmap, it is a possiblity that we receive
> >> a page that is being processed by a different thread.  We fix this
> >> problem just making sure that we wait for all receiving threads to
> >> finish its work before we procedeed with the next stage.
> >> 
> >> We are low on page flags, so we use a combination that is not valid to
> >> emit that message:  MULTIFD_PAGE and COMPRESSED.
> >> 
> >> I tried to make a migration command for it, but it don't work because
> >> we sync the bitmap sometimes when we have already sent the beggining
> >> of the section, so I just added a new page flag.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> 
> >> @@ -675,6 +686,10 @@ static void *multifd_recv_thread(void *opaque)
> >>                  return NULL;
> >>              }
> >>              p->done = true;
> >> +            if (p->sync) {
> >> +                qemu_cond_signal(&p->cond_sync);
> >> +                p->sync = false;
> >> +            }
> >
> > Could we use the same p->ready for this purpose? They looks similar:
> > all we want to do is to let the main thread know "worker thread has
> > finished receiving the last piece and becomes idle again", right?
> 
> We *could*, but "ready" is used for each page that we sent, sync is only
> used once every round.  Notice that "ready" is a semaphore, and its
> semantic is weird.  See next comment.
> 
> 
> >> +static int multifd_flush(void)
> >> +{
> >> +    int i, thread_count;
> >> +
> >> +    if (!migrate_use_multifd()) {
> >> +        return 0;
> >> +    }
> >> +    thread_count = migrate_multifd_threads();
> >> +    for (i = 0; i < thread_count; i++) {
> >> +        MultiFDRecvParams *p = multifd_recv_state->params[i];
> >> +
> >> +        qemu_mutex_lock(&p->mutex);
> >> +        while (!p->done) {
> >> +            p->sync = true;
> >> +            qemu_cond_wait(&p->cond_sync, &p->mutex);
> >
> > (similar comment like above)
> 
> We need to look at the two pieces of code at the same time.  What are we
> trying to do:
> 
> - making sure that all threads have finished the current round.
>   in this particular case, that this thread has finished its current
>   round OR  that it is waiting for work.
> 
> So, the main thread is the one that does the sem_wait(ready) and the channel
> thread is the one that does the sem_post(ready).
> 
> multifd_recv_thread()
> 
>     if (p->sync) {
>         sem_post(ready);
>         p->sync = false;
>     }
> 
> multifd_flush()
>    if (!p->done) {
>        p->sync = true;
>        sem_wait(ready);
>    }
> 
> Ah, but done and sync can be changed from other threads, so current code
> will become:
> 
> multifd_recv_thread()
> 
>     if (p->sync) {
>         sem_post(ready);
>         p->sync = false;
>     }
> 
> multifd_flush()
>    ...
>    mutex_lock(lock);
>    if (!p->done) {
>        p->sync = true;
>        mutex_unlock(lock)
>        sem_wait(ready);
>        mutex_lock(lock)
>    }
>    mutex_unlock(lock)
> 
> That I would claim that it is more complicated to understand.  Mixing
> locks and semaphores is ..... interesting to say the least.  With
> variable conditions it becomes easy.
> 
> Yes, we can change sync/done to atomic access, but not sure that makes
> things so much simpler.

I was thinking that p->ready can be used a notification channel from
recv thread to main thread for any reason. But I'm also fine that if
you want to do this separately to have different sync channels for
page-level completions and global flushes especially in first version.

(but I'd say I feel the whole thing slightly complicated, while I feel
 it can be simpler somewhere...)

> 
> >> +        }
> >> +        qemu_mutex_unlock(&p->mutex);
> >> +    }
> >> +    return 0;
> >> +}
> >> +
> >>  /**
> >>   * save_page_header: write page header to wire
> >>   *
> >> @@ -809,6 +847,12 @@ static size_t save_page_header(RAMState *rs, QEMUFile *f,  RAMBlock *block,
> >>  {
> >>      size_t size, len;
> >>  
> >> +    if (rs->multifd_needs_flush &&
> >> +        (offset & RAM_SAVE_FLAG_MULTIFD_PAGE)) {
> >
> > If multifd_needs_flush is only for multifd, then we may skip this
> > check, but it looks more like an assertion:
> >
> >     if (rs->multifd_needs_flush) {
> >         assert(offset & RAM_SAVE_FLAG_MULTIFD_PAGE);
> >         offset |= RAM_SAVE_FLAG_ZERO;
> >     }
> 
> No, it could be that this page is a _non_ multifd page, and then ZERO
> means something different.  So, we can only send this for MULTIFD pages.

But if multifd_needs_flush==true, it must be a multifd page, no? :)

I think this is trivial, so both work for me.

> 
> > (Dave mentioned about unaligned flag used in commit message and here:
> >  ZERO is used, but COMPRESS is mentioned)
> 
> OK, I can change the message.
> 
> >> @@ -2496,6 +2540,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >>  
> >>      if (!migration_in_postcopy()) {
> >>          migration_bitmap_sync(rs);
> >> +        if (migrate_use_multifd()) {
> >> +            rs->multifd_needs_flush = true;
> >> +        }
> >
> > Would it be good to move this block into entry of
> > migration_bitmap_sync(), instead of setting it up at the callers of
> > migration_bitmap_sync()?
> 
> We can't have all of it.
> 
> We call migration_bitmap_sync() in 4 places.
> - We don't need to set the flag for the 1st synchronization
> - We don't need to set it on postcopy (yet).

[1]

I see.

> 
> So, we can add code inside to check if we are on the 1st round, and
> forget about postcopy (we check in other place), or we maintain it this way.
> 
> So, change becomes:
> 
> modified   migration/ram.c
> @@ -1131,6 +1131,9 @@ static void migration_bitmap_sync(RAMState *rs)
>      if (migrate_use_events()) {
>          qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
>      }
> +    if (rs->ram_bulk_stage && migrate_use_multifd()) {

Should this be "!rs->ram_bulk_stage && migrate_use_multifd()"?

> +        rs->multifd_needs_flush = true;
> +    }
>  }
>  
>  /**
> @@ -2533,9 +2536,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>      if (!migration_in_postcopy()) {
>          migration_bitmap_sync(rs);
> -        if (migrate_use_multifd()) {
> -            rs->multifd_needs_flush = true;
> -        }
>      }
>  
>      ram_control_before_iterate(f, RAM_CONTROL_FINISH);
> @@ -2578,9 +2578,6 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>          qemu_mutex_lock_iothread();
>          rcu_read_lock();
>          migration_bitmap_sync(rs);
> -        if (migrate_use_multifd()) {
> -            rs->multifd_needs_flush = true;
> -        }
>          rcu_read_unlock();
>          qemu_mutex_unlock_iothread();
>          remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
> 
> three less lines, you win.  We need to check in otherplace already that
> postcopy & multifd are not enabled at the same time.

I got the point. I would slightly prefer the new way to have only one
single place to set multifd_needs_flush (it would be nice to have some
comments like [1] there), but I'm also fine if you prefer the old one.

Thanks,

-- 
Peter Xu
