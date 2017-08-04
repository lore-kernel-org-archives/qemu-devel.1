Received: from eggs.gnu.org ([2001:4830:134:3::10]:46036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddXMj-0004xC-GE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:49:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddXMf-0001SR-5d
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:49:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddXMe-0001RN-Tl
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:49:45 -0400
Date: Fri, 4 Aug 2017 15:49:39 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804074939.GM5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-27-git-send-email-peterx@redhat.com>
	<20170803115631.GH2076@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803115631.GH2076@work-vm>
Subject: Re: [Qemu-devel] [RFC 26/29] migration: synchronize dirty bitmap
 for resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Aug 03, 2017 at 12:56:31PM +0100, Dr. David Alan Gilbert wrote:

[...]

> > @@ -256,6 +257,8 @@ struct RAMState {
> >      RAMBlock *last_req_rb;
> >      /* Queue of outstanding page requests from the destination */
> >      QemuMutex src_page_req_mutex;
> > +    /* Ramblock counts to sync dirty bitmap. Only used for recovery */
> > +    int ramblock_to_sync;
> >      QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
> >  };
> >  typedef struct RAMState RAMState;
> > @@ -2731,6 +2734,57 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
> >      return ret;
> >  }
> >  
> > +/* Sync all the dirty bitmap with destination VM.  */
> > +static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
> > +{
> > +    RAMBlock *block;
> > +    QEMUFile *file = s->to_dst_file;
> > +    int ramblock_count = 0;
> > +
> > +    trace_ram_dirty_bitmap_sync("start");
> 
> Most (but not all) of our trace_ uses have separate trace_ entries for
> each step; e.g.   trace_ram_dirty_bitmap_sync_start9)

Okay.

> 
> > +    /*
> > +     * We need to take the resume lock to make sure that the send
> > +     * thread (current thread) and the rp-thread will do their work in
> > +     * order.
> > +     */
> > +    qemu_mutex_lock(&s->resume_lock);
> > +
> > +    /* Request for receive-bitmap for each block */
> > +    RAMBLOCK_FOREACH(block) {
> > +        ramblock_count++;
> > +        qemu_savevm_send_recv_bitmap(file, block->idstr);
> > +    }
> > +
> > +    /* Init the ramblock count to total */
> > +    atomic_set(&rs->ramblock_to_sync, ramblock_count);
> > +
> > +    trace_ram_dirty_bitmap_sync("wait-bitmap");
> > +
> > +    /* Wait until all the ramblocks' dirty bitmap synced */
> > +    while (rs->ramblock_to_sync) {
> > +        qemu_cond_wait(&s->resume_cond, &s->resume_lock);
> > +    }
> 
> Does the locking here get simpler if you:
>   a) count the number of RAMBlocks 'n'
>   b) Initialise a sempahore to -(n-1)
>   c) Call qemu_savevm_send_recv_bitmap for each bitmap
>   d) sem_wait on the semaphore - which is waiting for the semaphore to
>      be >0
> 
> as you receive each bitmap do a sem_post; on the last one
> it should go from 0->1 and the sem_wait should wake up?

I think you are right. :-) A single semaphore suffice here (and also
for the following up handshake).

I will touch up the commit message as well.  Thanks,

-- 
Peter Xu
