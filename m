Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKeC4-0006kJ-VC
	for qemu-devel@nongnu.org; Mon, 21 May 2018 02:21:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fKeC1-000591-Qc
	for qemu-devel@nongnu.org; Mon, 21 May 2018 02:21:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52070 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fKeC1-00058m-M8
	for qemu-devel@nongnu.org; Mon, 21 May 2018 02:21:13 -0400
Date: Mon, 21 May 2018 14:21:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180521062109.GG17725@lemon.usersys.redhat.com>
References: <20180301075428.17320-1-famz@redhat.com>
	<20180301075428.17320-2-famz@redhat.com>
	<CAFEAcA8xWPjuQipfEyv-6KHTjhQ=LuyDi5Zx3r4X28JHZAVw0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xWPjuQipfEyv-6KHTjhQ=LuyDi5Zx3r4X28JHZAVw0w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 1/1] block/nvme: fix Coverity reports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 05/18 19:01, Peter Maydell wrote:
> On 1 March 2018 at 07:54, Fam Zheng <famz@redhat.com> wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> >
> > 1) string not null terminated in sysfs_find_group_file
> >
> > 2) NULL pointer dereference and dead local variable in nvme_init.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> >
> > Message-Id: <20180213015240.9352-1-famz@redhat.com>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> 
> Hi. It looks like Coverity still doesn't like the error-exit
> handling in nvme_init() (CID 1385847):
> 
> > ---
> >  block/nvme.c        | 10 +++++++---
> >  util/vfio-helpers.c |  2 +-
> >  2 files changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 10bffbbf2f..75078022f6 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -645,7 +645,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
> >      aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
> >                             false, nvme_handle_event, nvme_poll_cb);
> >
> > -    nvme_identify(bs, namespace, errp);
> > +    nvme_identify(bs, namespace, &local_err);
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >          ret = -EIO;
> > @@ -666,8 +666,12 @@ fail_queue:
> >      nvme_free_queue_pair(bs, s->queues[0]);
> >  fail:
> >      g_free(s->queues);
> > -    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> > -    qemu_vfio_close(s->vfio);
> > +    if (s->regs) {
> > +        qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
> 
> We can get here with s->vfio being NULL and s->regs being
> uninitialized, but qemu_vfio_pci_unmap_bar() will unconditionally
> dereference s->vfio.
> 
> If you want to write the error path like this I think you need
> to initialize s->regs = NULL before we do the qemu_vfio_open_pci()
> call and error-check.

Block layer uses g_malloc0 to allocate *s, so we expect s->regs is NULL to begin
with. But I can send a patch to explicitly initialize it to NULL to make the
code simpler to reason.

Fam

> 
> > +    }
> > +    if (s->vfio) {
> > +        qemu_vfio_close(s->vfio);
> > +    }
> >      event_notifier_cleanup(&s->irq_notifier);
> >      return ret;
> >  }
> 
> thanks
> -- PMM
