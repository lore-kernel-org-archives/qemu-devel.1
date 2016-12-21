Received: from eggs.gnu.org ([2001:4830:134:3::10]:47742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJhWE-00077L-UJ
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:05:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cJhWA-0001Wf-Rr
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 09:05:22 -0500
Date: Wed, 21 Dec 2016 22:05:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161221140506.GA12620@lemon>
References: <20161220163139.12016-1-famz@redhat.com>
	<20161220163139.12016-5-famz@redhat.com>
	<20161221115956.GF9482@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161221115956.GF9482@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/4] block: Add VFIO based
 NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, borntraeger@de.ibm.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Karl Rister <krister@redhat.com>

On Wed, 12/21 11:59, Stefan Hajnoczi wrote:
> On Wed, Dec 21, 2016 at 12:31:39AM +0800, Fam Zheng wrote:
> > This is a new protocol driver that exclusively opens a host NVMe
> > controller through VFIO. It achieves better latency than linux-aio.
> 
> This is an interesting block driver to have for performance comparisons.
> Definitely something that is worth merging.
> 
> >                                          nvme://    linux-aio
> > ------------------------------------------------------------------
> >   fio bs=4k  iodepth=1 (IOPS)             30014      24009
> >   fio bs=4k  iodepth=1 (IOPS)  +polling   45148      34689
> >   fio bs=64k iodepth=1 (IOPS)             17801      14954
> >   fio bs=64k iodepth=1 (IOPS)  +polling   17970      14564
> > 
> >   fio bs=4k  iodepth=32 (IOPS)           110637     121480
> >   fio bs=4k  iodepth=32 (IOPS) +polling  145533     166878
> >   fio bs=64k iodepth=32 (IOPS)            50525      50596
> >   fio bs=64k iodepth=32 (IOPS) +polling   50482      50534
> > 
> >   (host) qemu-img bench -c 8000000 (sec)  15.00      43.13
> > 
> > ("+polling" means poll-max-ns=18000 which is a rule of thumb value for
> > the used NVMe device, otherwise it defaults to 0).
> > 
> > For the rows where linux-aio is faster, a lot of evidence shows that the
> > io queue is more likely to stay full if the request completions happen
> > faster, as in the nvme:// case, hence less batch submission and request
> > merging than linux-aio.
> 
> I'm not sure I understand this paragraph.  Sounds like you are saying
> that nvme:// has lower latency and this defeats batch submission.
> Higher numbers are still better at the end of the day so it's worth
> studying this more closely and coming up with solutions.  Maybe at a
> certain rate of submission it makes sense to favor throughput
> (batching) even with nvme://.

Good question! Busy polling at nvme:// side reduces batched completion, and busy
polling at virtio side reduces batched submission. I think this is a common
pattern and we should figure out a general strategy to "favor throughput"
based on the rate.

> 
> Regarding merging: are you doing sequential I/O?  Please try random
> instead.

Yes, it is sequential. I've also tried random but the results are mostly the
same.  It means merging is the smaller factor here, and host <-> guest
communication is the bigger one. Maybe we should go ahead to expriment busy
polling at driver side now.

> > +typedef struct {
> > +    int         index;
> > +    NVMeQueue   sq, cq;
> > +    int         cq_phase;
> > +    uint8_t     *prp_list_pages;
> > +    uint64_t    prp_list_base_iova;
> > +    NVMeRequest reqs[NVME_QUEUE_SIZE];
> > +    CoQueue     wait_queue;
> 
> "free_req_queue" describes the purpose of this queue.

OK, I'll rename it.

> 
> > +    bool        busy;
> > +    int         need_kick;
> > +    int         inflight;
> > +} NVMeQueuePair;
> > +
> > +typedef volatile struct {
> > +    uint64_t cap;
> > +    uint32_t vs;
> > +    uint32_t intms;
> > +    uint32_t intmc;
> > +    uint32_t cc;
> > +    uint32_t reserved0;
> > +    uint32_t csts;
> > +    uint32_t nssr;
> > +    uint32_t aqa;
> > +    uint64_t asq;
> > +    uint64_t acq;
> > +    uint32_t cmbloc;
> > +    uint32_t cmbsz;
> > +    uint8_t  reserved1[0xec0];
> > +    uint8_t  cmd_set_specfic[0x100];
> > +    uint32_t doorbells[];
> > +} QEMU_PACKED NVMeRegs;
> > +
> > +QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
> > +
> > +typedef struct {
> > +    QEMUVFIOState *vfio;
> > +    NVMeRegs *regs;
> > +    /* The submission/completion queue pairs.
> > +     * [0]: admin queue.
> > +     * [1..]: io queues.
> > +     */
> > +    NVMeQueuePair **queues;
> > +    int nr_queues;
> > +    size_t page_size;
> > +    /* How many uint32_t elements does each doorbell entry take. */
> > +    size_t doorbell_scale;
> > +    bool write_cache;
> > +    EventNotifier event_notifier;
> 
> "event_notifier" describes the type, not the purpose of the field.
> "irq_notifier" is clearer.

Good idea.

> > +    while (true) {
> > +        req = nvme_get_free_req(ioq);
> > +        if (req) {
> > +            break;
> > +        }
> > +        DPRINTF("nvme wait req\n");
> > +        qemu_co_queue_wait(&ioq->wait_queue);
> > +        DPRINTF("nvme wait req done\n");
> > +    }
> > +
> > +    r = nvme_cmd_map_qiov(bs, &cmd, req, qiov);
> > +    if (r) {
> > +        return r;
> 
> Is req leaked?

No. It is a pointer to an ioq->reqs element. ioq->reqs is an object pool with
the same lifecycle of ioq. Until nvme_submit_command() is called, *req is still
"free".

Fam
