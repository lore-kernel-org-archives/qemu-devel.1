Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fIrqd-0002t3-OR
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fIrqb-0006YB-TX
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:31:47 -0400
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:40835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fIrqb-0006Y1-NB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 04:31:45 -0400
Received: by mail-it0-x242.google.com with SMTP id j186-v6so9057987ita.5
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 01:31:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514192723.GH2497@work-vm>
References: <1525618499-1560-1-git-send-email-lidongchen@tencent.com>
	<1525618499-1560-2-git-send-email-lidongchen@tencent.com>
	<20180508184035.GT2500@work-vm>
	<CAOGPPbdy+198Nxd=ttOtm+mNy7_u4iJxYVhLqYyeK1JJytuZEQ@mail.gmail.com>
	<20180511180335.GH2720@work-vm>
	<CAOGPPbdZX9gnp2BcwaizzyLGxN+T3wdSM_6wzVmGAYDgC+zFqQ@mail.gmail.com>
	<20180514192723.GH2497@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 16 May 2018 16:31:43 +0800
Message-ID: <CAOGPPbfqiKsfd+qW9ik-NzTox5eQTSpGsKgSi8bULjfesWgQug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Aviad Yehezkel <aviadye@mellanox.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Tue, May 15, 2018 at 3:27 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * 858585 jemmy (jemmy858585@gmail.com) wrote:
>> On Sat, May 12, 2018 at 2:03 AM, Dr. David Alan Gilbert
>> <dgilbert@redhat.com> wrote:
>> > * 858585 jemmy (jemmy858585@gmail.com) wrote:
>> >> On Wed, May 9, 2018 at 2:40 AM, Dr. David Alan Gilbert
>> >> <dgilbert@redhat.com> wrote:
>> >> > * Lidong Chen (jemmy858585@gmail.com) wrote:
>> >> >> When cancel migration during RDMA precopy, the source qemu main thread hangs sometime.
>> >> >>
>> >> >> The backtrace is:
>> >> >>     (gdb) bt
>> >> >>     #0  0x00007f249eabd43d in write () from /lib64/libpthread.so.0
>> >> >>     #1  0x00007f24a1ce98e4 in rdma_get_cm_event (channel=0x4675d10, event=0x7ffe2f643dd0) at src/cma.c:2189
>> >> >>     #2  0x00000000007b6166 in qemu_rdma_cleanup (rdma=0x6784000) at migration/rdma.c:2296
>> >> >>     #3  0x00000000007b7cae in qio_channel_rdma_close (ioc=0x3bfcc30, errp=0x0) at migration/rdma.c:2999
>> >> >>     #4  0x00000000008db60e in qio_channel_close (ioc=0x3bfcc30, errp=0x0) at io/channel.c:273
>> >> >>     #5  0x00000000007a8765 in channel_close (opaque=0x3bfcc30) at migration/qemu-file-channel.c:98
>> >> >>     #6  0x00000000007a71f9 in qemu_fclose (f=0x527c000) at migration/qemu-file.c:334
>> >> >>     #7  0x0000000000795b96 in migrate_fd_cleanup (opaque=0x3b46280) at migration/migration.c:1162
>> >> >>     #8  0x000000000093a71b in aio_bh_call (bh=0x3db7a20) at util/async.c:90
>> >> >>     #9  0x000000000093a7b2 in aio_bh_poll (ctx=0x3b121c0) at util/async.c:118
>> >> >>     #10 0x000000000093f2ad in aio_dispatch (ctx=0x3b121c0) at util/aio-posix.c:436
>> >> >>     #11 0x000000000093ab41 in aio_ctx_dispatch (source=0x3b121c0, callback=0x0, user_data=0x0)
>> >> >>         at util/async.c:261
>> >> >>     #12 0x00007f249f73c7aa in g_main_context_dispatch () from /lib64/libglib-2.0.so.0
>> >> >>     #13 0x000000000093dc5e in glib_pollfds_poll () at util/main-loop.c:215
>> >> >>     #14 0x000000000093dd4e in os_host_main_loop_wait (timeout=28000000) at util/main-loop.c:263
>> >> >>     #15 0x000000000093de05 in main_loop_wait (nonblocking=0) at util/main-loop.c:522
>> >> >>     #16 0x00000000005bc6a5 in main_loop () at vl.c:1944
>> >> >>     #17 0x00000000005c39b5 in main (argc=56, argv=0x7ffe2f6443f8, envp=0x3ad0030) at vl.c:4752
>> >> >>
>> >> >> It does not get the RDMA_CM_EVENT_DISCONNECTED event after rdma_disconnect sometime.
>> >> >> I do not find out the root cause why not get RDMA_CM_EVENT_DISCONNECTED event, but
>> >> >> it can be reproduced if not invoke ibv_dereg_mr to release all ram blocks which fixed
>> >> >> in previous patch.
>> >> >
>> >> > Does this happen without your other changes?
>> >>
>> >> Yes, this issue also happen on v2.12.0. base on
>> >> commit 4743c23509a51bd4ee85cc272287a41917d1be35
>> >>
>> >> > Can you give me instructions to repeat it and also say which
>> >> > cards you wereusing?
>> >>
>> >> This issue can be reproduced by start and cancel migration.
>> >> less than 10 times, this issue will be reproduced.
>> >>
>> >> The command line is:
>> >> virsh migrate --live --copy-storage-all  --undefinesource --persistent
>> >> --timeout 10800 \
>> >>  --verbose 83e0049e-1325-4f31-baf9-25231509ada1  \
>> >> qemu+ssh://9.16.46.142/system rdma://9.16.46.142
>> >>
>> >> The net card i use is :
>> >> 0000:3b:00.0 Ethernet controller: Mellanox Technologies MT27710 Family
>> >> [ConnectX-4 Lx]
>> >> 0000:3b:00.1 Ethernet controller: Mellanox Technologies MT27710 Family
>> >> [ConnectX-4 Lx]
>> >>
>> >> This issue is related to ibv_dereg_mr, if not invoke ibv_dereg_mr for
>> >> all ram block, this issue can be reproduced.
>> >> If we fixed the bugs and use ibv_dereg_mr to release all ram block,
>> >> this issue never happens.
>> >
>> > Maybe that is the right fix; I can imagine that the RDMA code doesn't
>> > like closing down if there are still ramblocks registered that
>> > potentially could have incoming DMA?
>> >
>> >> And for the kernel part, there is a bug also cause not release ram
>> >> block when canceling live migration.
>> >> https://patchwork.kernel.org/patch/10385781/
>> >
>> > OK, that's a pain; which threads are doing the dereg - is some stuff
>> > in the migration thread and some stuff in the main thread on cleanup?
>>
>> Yes, the migration thread invokes ibv_reg_mr, and the main thread bh
>> will invoke ibv_dereg_mr.
>
> OK, although my reading of that discussion is that *should* be allowed
> (with your fix).
>
>> and when the main thread schedule s->cleanup_bh, the migration thread
>> may have been exited.
>>
>> And I find ibv_dereg_mr may take a long time for the big memory size
>> virtual machine.
>>
>> The test result is:
>>  10GB  326ms
>>  20GB  699ms
>>  30GB  1021ms
>>  40GB  1387ms
>>  50GB  1712ms
>>  60GB  2034ms
>>  70GB  2457ms
>>  80GB  2807ms
>>  90GB  3107ms
>> 100GB 3474ms
>> 110GB 3735ms
>> 120GB 4064ms
>> 130GB 4567ms
>> 140GB 4886ms
>>
>> when canceling migration, the guest os will hang for a while.
>> so I think we should invoke qemu_fclose(s->to_dst_file)  in
>> migration_thread, and without hold io thread lock.
>
> Be very careful; it's tricky to get it right to handle all the failure
> cases; that's why it's much easier to clean up right at the end.
> It might make sense to try and do the deregister in the migration
> thread but also to just make sure at the end.

Yes, I will make sure at the end of migration thread.

>
> I wonder why dereg_mr takes so long - I could understand if reg_mr
> took a long time, but why for dereg, that sounds like the easy side.

I use perf collect the information when ibv_dereg_mr is invoked.

-   9.95%  client2  [kernel.kallsyms]  [k] put_compound_page
                                                          `
   - put_compound_page
      - 98.45% put_page
           __ib_umem_release
           ib_umem_release
           dereg_mr
           mlx5_ib_dereg_mr
           ib_dereg_mr
           uverbs_free_mr
           remove_commit_idr_uobject
           _rdma_remove_commit_uobject
           rdma_remove_commit_uobject
           ib_uverbs_dereg_mr
           ib_uverbs_write
           vfs_write
           sys_write
           system_call_fastpath
           __GI___libc_write
           0
      + 1.55% __ib_umem_release
+   8.31%  client2  [kernel.kallsyms]  [k] compound_unlock_irqrestore
+   7.01%  client2  [kernel.kallsyms]  [k] page_waitqueue
+   7.00%  client2  [kernel.kallsyms]  [k] set_page_dirty
+   6.61%  client2  [kernel.kallsyms]  [k] unlock_page
+   6.33%  client2  [kernel.kallsyms]  [k] put_page_testzero
+   5.68%  client2  [kernel.kallsyms]  [k] set_page_dirty_lock
+   4.30%  client2  [kernel.kallsyms]  [k] __wake_up_bit
+   4.04%  client2  [kernel.kallsyms]  [k] free_pages_prepare
+   3.65%  client2  [kernel.kallsyms]  [k] release_pages
+   3.62%  client2  [kernel.kallsyms]  [k] arch_local_irq_save
+   3.35%  client2  [kernel.kallsyms]  [k] page_mapping
+   3.13%  client2  [kernel.kallsyms]  [k] get_pageblock_flags_group
+   3.09%  client2  [kernel.kallsyms]  [k] put_page

the reason is __ib_umem_release will loop many times for each page.

static void __ib_umem_release(struct ib_device *dev, struct ib_umem
*umem, int dirty)
{
    struct scatterlist *sg;
    struct page *page;
    int i;

    if (umem->nmap > 0)
         ib_dma_unmap_sg(dev, umem->sg_head.sgl,
                                        umem->npages,
                                        DMA_BIDIRECTIONAL);

         for_each_sg(umem->sg_head.sgl, sg, umem->npages, i) {      <<
loop a lot of times for each page.here
              page = sg_page(sg);
              if (umem->writable && dirty)
                  set_page_dirty_lock(page);
              put_page(page);
         }

         sg_free_table(&umem->sg_head);
         return;
}

>
> Dave
>
>
>> >
>> > Dave
>> >
>> >> >
>> >> >> Anyway, it should not invoke rdma_get_cm_event in main thread, and the event channel
>> >> >> is also destroyed in qemu_rdma_cleanup.
>> >> >>
>> >> >> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> >> >> ---
>> >> >>  migration/rdma.c       | 12 ++----------
>> >> >>  migration/trace-events |  1 -
>> >> >>  2 files changed, 2 insertions(+), 11 deletions(-)
>> >> >>
>> >> >> diff --git a/migration/rdma.c b/migration/rdma.c
>> >> >> index 0dd4033..92e4d30 100644
>> >> >> --- a/migration/rdma.c
>> >> >> +++ b/migration/rdma.c
>> >> >> @@ -2275,8 +2275,7 @@ static int qemu_rdma_write(QEMUFile *f, RDMAContext *rdma,
>> >> >>
>> >> >>  static void qemu_rdma_cleanup(RDMAContext *rdma)
>> >> >>  {
>> >> >> -    struct rdma_cm_event *cm_event;
>> >> >> -    int ret, idx;
>> >> >> +    int idx;
>> >> >>
>> >> >>      if (rdma->cm_id && rdma->connected) {
>> >> >>          if ((rdma->error_state ||
>> >> >> @@ -2290,14 +2289,7 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
>> >> >>              qemu_rdma_post_send_control(rdma, NULL, &head);
>> >> >>          }
>> >> >>
>> >> >> -        ret = rdma_disconnect(rdma->cm_id);
>> >> >> -        if (!ret) {
>> >> >> -            trace_qemu_rdma_cleanup_waiting_for_disconnect();
>> >> >> -            ret = rdma_get_cm_event(rdma->channel, &cm_event);
>> >> >> -            if (!ret) {
>> >> >> -                rdma_ack_cm_event(cm_event);
>> >> >> -            }
>> >> >> -        }
>> >> >> +        rdma_disconnect(rdma->cm_id);
>> >> >
>> >> > I'm worried whether this change could break stuff:
>> >> > The docs say for rdma_disconnect that it flushes any posted work
>> >> > requests to the completion queue;  so unless we wait for the event
>> >> > do we know the stuff has been flushed?   In the normal non-cancel case
>> >> > I'm worried that means we could lose something.
>> >> > (But I don't know the rdma/infiniband specs well enough to know if it's
>> >> > really a problem).
>> >>
>> >> In qemu_fclose function, it invoke qemu_fflush(f) before invoke f->ops->close.
>> >> so I think it's safe for normal migration case.
>> >>
>> >> For the root cause why not receive RDMA_CM_EVENT_DISCONNECTED event
>> >> after rdma_disconnect,
>> >> I loop in Aviad Yehezkel<aviadye@mellanox.com>, Aviad will help us
>> >> find the root cause.
>> >>
>> >> >
>> >> > Dave
>> >> >
>> >> >>          trace_qemu_rdma_cleanup_disconnect();
>> >> >>          rdma->connected = false;
>> >> >>      }
>> >> >> diff --git a/migration/trace-events b/migration/trace-events
>> >> >> index d6be74b..64573ff 100644
>> >> >> --- a/migration/trace-events
>> >> >> +++ b/migration/trace-events
>> >> >> @@ -125,7 +125,6 @@ qemu_rdma_accept_pin_state(bool pin) "%d"
>> >> >>  qemu_rdma_accept_pin_verbsc(void *verbs) "Verbs context after listen: %p"
>> >> >>  qemu_rdma_block_for_wrid_miss(const char *wcompstr, int wcomp, const char *gcompstr, uint64_t req) "A Wanted wrid %s (%d) but got %s (%" PRIu64 ")"
>> >> >>  qemu_rdma_cleanup_disconnect(void) ""
>> >> >> -qemu_rdma_cleanup_waiting_for_disconnect(void) ""
>> >> >>  qemu_rdma_close(void) ""
>> >> >>  qemu_rdma_connect_pin_all_requested(void) ""
>> >> >>  qemu_rdma_connect_pin_all_outcome(bool pin) "%d"
>> >> >> --
>> >> >> 1.8.3.1
>> >> >>
>> >> > --
>> >> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>> > --
>> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
