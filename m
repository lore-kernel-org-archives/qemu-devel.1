Received: from eggs.gnu.org ([2001:4830:134:3::10]:36406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgqDV-0007nZ-So
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cgqDS-0001BA-5V
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 05:01:42 -0500
Date: Thu, 23 Feb 2017 18:01:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170223100128.GA14175@lemon.lan>
References: <20170223091845.18523-1-famz@redhat.com>
	<20170223091845.18523-4-famz@redhat.com>
	<21422231-2868-49fa-2b3b-363054b09797@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21422231-2868-49fa-2b3b-363054b09797@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] block: Add VFIO based NVMe driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Karl Rister <krister@redhat.com>

On Thu, 02/23 10:43, Paolo Bonzini wrote:
> 
> 
> On 23/02/2017 10:18, Fam Zheng wrote:
> > +    for (i = 0; i < s->nr_queues; ++i) {
> > +        s->queues[i]->free_req_queue_bh =
> > +            aio_bh_new(new_context, nvme_free_req_queue_cb, s->queues[i]);
> > +    }
> 
> aio_bh_new has the issue that you can complete two requests in one
> nvme_process_completion call, but you would only invoke the bottom half
> once.  Because this is a rare event, I think it's enough to use
> aio_bh_schedule_oneshot instead of aio_bh_new.

Yes, that should work.

> 
> > +static coroutine_fn int nvme_cmd_unmap_qiov(BlockDriverState *bs,
> > +                                            QEMUIOVector *qiov)
> > +{
> > +    int r = 0;
> > +    BDRVNVMeState *s = bs->opaque;
> > +
> > +    if (!s->inflight && !qemu_co_queue_empty(&s->dma_flush_queue)) {
> > +        r = nvme_vfio_dma_reset_temporary(s->vfio);
> > +        qemu_co_queue_next(&s->dma_flush_queue);
> > +    }
> > +    return r;
> > +}
> 
> Should this be qemu_co_queue_restart_all instead?

You are right, will fix!

Fam
