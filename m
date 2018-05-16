Received: from eggs.gnu.org ([2001:4830:134:3::10]:51804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIwFO-0004xS-CB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fIwFJ-0007mJ-Jk
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fIwFJ-0007m5-DQ
	for qemu-devel@nongnu.org; Wed, 16 May 2018 09:13:33 -0400
Date: Wed, 16 May 2018 14:13:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180516131327.GF2531@work-vm>
References: <20180508184035.GT2500@work-vm>
	<CAOGPPbdy+198Nxd=ttOtm+mNy7_u4iJxYVhLqYyeK1JJytuZEQ@mail.gmail.com>
	<20180511180335.GH2720@work-vm>
	<CAOGPPbdZX9gnp2BcwaizzyLGxN+T3wdSM_6wzVmGAYDgC+zFqQ@mail.gmail.com>
	<20180514192723.GH2497@work-vm>
	<CAOGPPbfqiKsfd+qW9ik-NzTox5eQTSpGsKgSi8bULjfesWgQug@mail.gmail.com>
	<20180516093944.GA2531@work-vm>
	<CAOGPPbemRCtRTmYaWSfQPTXZkGOX2RqAAb_HcdOCncCZ1d9Jqw@mail.gmail.com>
	<20180516095344.GB2531@work-vm>
	<CAOGPPbdjb6x-7Lgtw-xDA7qT=qfGHPwibeu2q+v08G21HUmKyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGPPbdjb6x-7Lgtw-xDA7qT=qfGHPwibeu2q+v08G21HUmKyQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] migration: not wait
 RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

* 858585 jemmy (jemmy858585@gmail.com) wrote:

<snip>

> >> >> > I wonder why dereg_mr takes so long - I could understand if reg_mr
> >> >> > took a long time, but why for dereg, that sounds like the easy side.
> >> >>
> >> >> I use perf collect the information when ibv_dereg_mr is invoked.
> >> >>
> >> >> -   9.95%  client2  [kernel.kallsyms]  [k] put_compound_page
> >> >>                                                           `
> >> >>    - put_compound_page
> >> >>       - 98.45% put_page
> >> >>            __ib_umem_release
> >> >>            ib_umem_release
> >> >>            dereg_mr
> >> >>            mlx5_ib_dereg_mr
> >> >>            ib_dereg_mr
> >> >>            uverbs_free_mr
> >> >>            remove_commit_idr_uobject
> >> >>            _rdma_remove_commit_uobject
> >> >>            rdma_remove_commit_uobject
> >> >>            ib_uverbs_dereg_mr
> >> >>            ib_uverbs_write
> >> >>            vfs_write
> >> >>            sys_write
> >> >>            system_call_fastpath
> >> >>            __GI___libc_write
> >> >>            0
> >> >>       + 1.55% __ib_umem_release
> >> >> +   8.31%  client2  [kernel.kallsyms]  [k] compound_unlock_irqrestore
> >> >> +   7.01%  client2  [kernel.kallsyms]  [k] page_waitqueue
> >> >> +   7.00%  client2  [kernel.kallsyms]  [k] set_page_dirty
> >> >> +   6.61%  client2  [kernel.kallsyms]  [k] unlock_page
> >> >> +   6.33%  client2  [kernel.kallsyms]  [k] put_page_testzero
> >> >> +   5.68%  client2  [kernel.kallsyms]  [k] set_page_dirty_lock
> >> >> +   4.30%  client2  [kernel.kallsyms]  [k] __wake_up_bit
> >> >> +   4.04%  client2  [kernel.kallsyms]  [k] free_pages_prepare
> >> >> +   3.65%  client2  [kernel.kallsyms]  [k] release_pages
> >> >> +   3.62%  client2  [kernel.kallsyms]  [k] arch_local_irq_save
> >> >> +   3.35%  client2  [kernel.kallsyms]  [k] page_mapping
> >> >> +   3.13%  client2  [kernel.kallsyms]  [k] get_pageblock_flags_group
> >> >> +   3.09%  client2  [kernel.kallsyms]  [k] put_page
> >> >>
> >> >> the reason is __ib_umem_release will loop many times for each page.
> >> >>
> >> >> static void __ib_umem_release(struct ib_device *dev, struct ib_umem
> >> >> *umem, int dirty)
> >> >> {
> >> >>     struct scatterlist *sg;
> >> >>     struct page *page;
> >> >>     int i;
> >> >>
> >> >>     if (umem->nmap > 0)
> >> >>          ib_dma_unmap_sg(dev, umem->sg_head.sgl,
> >> >>                                         umem->npages,
> >> >>                                         DMA_BIDIRECTIONAL);
> >> >>
> >> >>          for_each_sg(umem->sg_head.sgl, sg, umem->npages, i) {      <<
> >> >> loop a lot of times for each page.here
> >> >
> >> > Why 'lot of times for each page'?  I don't know this code at all, but
> >> > I'd expected once per page?
> >>
> >> sorry, once per page, but a lot of page for a big size virtual machine.
> >
> > Ah OK; so yes it seems best if you can find a way to do the release in
> > the migration thread then;  still maybe this is something some
> > of the kernel people could look at speeding up?
> 
> The kernel code seem is not complex, and I have no idea how to speed up.

Me neither; but I'll ask around.

> >> >
> >> > With your other kernel fix, does the problem of the missing
> >> > RDMA_CM_EVENT_DISCONNECTED events go away?
> >>
> >> Yes, after kernel and qemu fixed, this issue never happens again.
> >
> > I'm confused; which qemu fix; my question was whether the kernel fix by
> > itself fixed the problem of the missing event.
> 
> this qemu fix:
> migration: update index field when delete or qsort RDMALocalBlock

OK good; so then we shouldn't need this 2/2 patch.

> this issue also cause by some ram block is not released. but I do not
> find the root cause.

Hmm, we should try and track that down.

> >
> >> Do you think we should remove rdma_get_cm_event after rdma_disconnect?
> >
> > I don't think so; if 'rdma_disconnect' is supposed to generate the event
> > I think we're supposed to wait for it to know that the disconnect is
> > really complete.
> 
> After move qemu_fclose to migration thread, it will not block the main
> thread when wait
> the disconnection event.

I'm not sure about moving the fclose to the migration thread; it worries
me with the interaction with cancel and other failures.

Dave

> >
> > Dave
> >
> >>
> >> >
> >> > Dave
> >> >
> >> >>               page = sg_page(sg);
> >> >>               if (umem->writable && dirty)
> >> >>                   set_page_dirty_lock(page);
> >> >>               put_page(page);
> >> >>          }
> >> >>
> >> >>          sg_free_table(&umem->sg_head);
> >> >>          return;
> >> >> }
> >> >>
> >> >> >
> >> >> > Dave
> >> >> >
> >> >> >
> >> >> >> >
> >> >> >> > Dave
> >> >> >> >
> >> >> >> >> >
> >> >> >> >> >> Anyway, it should not invoke rdma_get_cm_event in main thread, and the event channel
> >> >> >> >> >> is also destroyed in qemu_rdma_cleanup.
> >> >> >> >> >>
> >> >> >> >> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> >> >> >> >> >> ---
> >> >> >> >> >>  migration/rdma.c       | 12 ++----------
> >> >> >> >> >>  migration/trace-events |  1 -
> >> >> >> >> >>  2 files changed, 2 insertions(+), 11 deletions(-)
> >> >> >> >> >>
> >> >> >> >> >> diff --git a/migration/rdma.c b/migration/rdma.c
> >> >> >> >> >> index 0dd4033..92e4d30 100644
> >> >> >> >> >> --- a/migration/rdma.c
> >> >> >> >> >> +++ b/migration/rdma.c
> >> >> >> >> >> @@ -2275,8 +2275,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
> >> >> >> >> >>
> >> >> >> >> >>  static void qemu_rdma_cleanup(RDMAContext *rdma)
> >> >> >> >> >>  {
> >> >> >> >> >> -    struct rdma_cm_event *cm_event;
> >> >> >> >> >> -    int ret, idx;
> >> >> >> >> >> +    int idx;
> >> >> >> >> >>
> >> >> >> >> >>      if (rdma->cm_id && rdma->connected) {
> >> >> >> >> >>          if ((rdma->error_state ||
> >> >> >> >> >> @@ -2290,14 +2289,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
> >> >> >> >> >>              qemu_rdma_post_send_control(rdma, NULL, &head);
> >> >> >> >> >>          }
> >> >> >> >> >>
> >> >> >> >> >> -        ret = rdma_disconnect(rdma->cm_id);
> >> >> >> >> >> -        if (!ret) {
> >> >> >> >> >> -            trace_qemu_rdma_cleanup_waiting_for_disconnect();
> >> >> >> >> >> -            ret = rdma_get_cm_event(rdma->channel, &cm_event);
> >> >> >> >> >> -            if (!ret) {
> >> >> >> >> >> -                rdma_ack_cm_event(cm_event);
> >> >> >> >> >> -            }
> >> >> >> >> >> -        }
> >> >> >> >> >> +        rdma_disconnect(rdma->cm_id);
> >> >> >> >> >
> >> >> >> >> > I'm worried whether this change could break stuff:
> >> >> >> >> > The docs say for rdma_disconnect that it flushes any posted work
> >> >> >> >> > requests to the completion queue;  so unless we wait for the event
> >> >> >> >> > do we know the stuff has been flushed?   In the normal non-cancel case
> >> >> >> >> > I'm worried that means we could lose something.
> >> >> >> >> > (But I don't know the rdma/infiniband specs well enough to know if it's
> >> >> >> >> > really a problem).
> >> >> >> >>
> >> >> >> >> In qemu_fclose function, it invoke qemu_fflush(f) before invoke f->ops->close.
> >> >> >> >> so I think it's safe for normal migration case.
> >> >> >> >>
> >> >> >> >> For the root cause why not receive RDMA_CM_EVENT_DISCONNECTED event
> >> >> >> >> after rdma_disconnect,
> >> >> >> >> I loop in Aviad Yehezkel<aviadye@mellanox.com>, Aviad will help us
> >> >> >> >> find the root cause.
> >> >> >> >>
> >> >> >> >> >
> >> >> >> >> > Dave
> >> >> >> >> >
> >> >> >> >> >>          trace_qemu_rdma_cleanup_disconnect();
> >> >> >> >> >>          rdma->connected = false;
> >> >> >> >> >>      }
> >> >> >> >> >> diff --git a/migration/trace-events b/migration/trace-events
> >> >> >> >> >> index d6be74b..64573ff 100644
> >> >> >> >> >> --- a/migration/trace-events
> >> >> >> >> >> +++ b/migration/trace-events
> >> >> >> >> >> @@ -125,7 +125,6 @@ qemu_rdma_accept_pin_state(bool pin) "%d"
> >> >> >> >> >>  qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
> >> >> >> >> >>  qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
> >> >> >> >> >>  qemu_rdma_cleanup_disconnect(void) ""
> >> >> >> >> >> -qemu_rdma_cleanup_waiting_for_disconnect(void) ""
> >> >> >> >> >>  qemu_rdma_close(void) ""
> >> >> >> >> >>  qemu_rdma_connect_pin_all_requested(void) ""
> >> >> >> >> >>  qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
> >> >> >> >> >> --
> >> >> >> >> >> 1.8.3.1
> >> >> >> >> >>
> >> >> >> >> > --
> >> >> >> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> >> >> > --
> >> >> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> >> > --
> >> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >> > --
> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
