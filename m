Received: from eggs.gnu.org ([2001:4830:134:3::10]:49489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUcZH-0001aE-Ou
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cUcZA-0005yu-AZ
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:01:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cUcZA-0005yW-2M
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 12:01:32 -0500
Date: Fri, 20 Jan 2017 19:01:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170120185753-mutt-send-email-mst@kernel.org>
References: <20170119001744-mutt-send-email-mst@kernel.org>
	<5881E2C2.2060502@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5881E2C2.2060502@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH RFC] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com

On Fri, Jan 20, 2017 at 06:13:22PM +0800, Cao jin wrote:
> 
> 
> On 01/20/2017 04:16 AM, Michael S. Tsirkin wrote:
> > This is a design and an initial patch for kernel side for AER
> > support in VFIO.
> > 
> > 0. What happens now (PCIE AER only)
> >    Fatal errors cause a link reset.
> >    Non fatal errors don't.
> >    All errors stop the VM eventually, but not immediately
> >    because it's detected and reported asynchronously.
> >    Interrupts are forwarded as usual.
> >    Correctable errors are not reported to guest at all.
> >    Note: PPC EEH is different. This focuses on AER.
> > 
> > 1. Correctable errors
> >    I don't see a need to report these to guest. So let's not.
> > 
> > 2. Fatal errors
> >    It's not easy to handle them gracefully since link reset
> >    is needed. As a first step, let's use the existing mechanism
> >    in that case.
> >    
> > 2. Non-fatal errors
> >    Here we could make progress by reporting them to guest
> >    and have guest handle them.
> >    Issues:
> >     a. this behaviour should only be enabled with new userspace
> >        old userspace should work without changes
> >     Suggestion: One way to address this would be to add a new eventfd
> >     non_fatal_err_trigger. If not set, invoke err_trigger.
> > 
> >     b. drivers are supposed to stop MMIO when error is reported
> >     if vm keeps going, we will keep doing MMIO/config
> >     Suggestion 1: ignore this. vm stop happens much later when userspace runs anyway,
> >     so we are not making things much worse
> >     Suggestion 2: try to stop MMIO/config, resume on resume call
> > 
> >     Patch below implements Suggestion 1.
> > 
> >     c. PF driver might detect that function is completely broken,
> >     if vm keeps going, we will keep doing MMIO/config
> >     Suggestion 1: ignore this. vm stop happens much later when userspace runs anyway,
> >     so we are not making things much worse
> >     Suggestion 2: detect this and invoke err_trigger to stop VM
> > 
> >     Patch below implements Suggestion 2.
> > 
> > Aside: we currently return PCI_ERS_RESULT_DISCONNECT when device
> > is not attached. This seems bogus, likely based on the confusing name.
> > We probably should return PCI_ERS_RESULT_CAN_RECOVER.
> > 
> > The following patch does not change that.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > ---
> > 
> > The patch is completely untested. Let's discuss the design first.
> > Cao jin, if this is deemed acceptable please take it from here.
> > 
> 
> Ok, thanks very much.
> 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index dce511f..fdca683 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -1292,7 +1292,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> >  
> >  	mutex_lock(&vdev->igate);
> >  
> > -	if (vdev->err_trigger)
> > +	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
> > +		eventfd_signal(vdev->err_trigger, 1);
> > +	else if (vdev->err_trigger)
> >  		eventfd_signal(vdev->err_trigger, 1);
> >  
> >  	mutex_unlock(&vdev->igate);
> > @@ -1302,8 +1304,38 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> >  	return PCI_ERS_RESULT_CAN_RECOVER;
> >  }
> >  
> > +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev,
> > +						pci_channel_state_t state)
> > +{
> > +	struct vfio_pci_device *vdev;
> > +	struct vfio_device *device;
> > +
> > +	device = vfio_device_get_from_dev(&pdev->dev);
> > +	if (!device)
> > +		goto err_dev;
> > +
> > +	vdev = vfio_device_data(device);
> > +	if (!vdev)
> > +		goto err_dev;
> > +
> > +	mutex_lock(&vdev->igate);
> > +
> > +	if (vdev->err_trigger)
> > +		eventfd_signal(vdev->err_trigger, 1);
> > +
> > +	mutex_unlock(&vdev->igate);
> > +
> > +	vfio_device_put(device);
> > +
> > +err_data:
> > +	vfio_device_put(device);
> > +err_dev:
> > +	return PCI_ERS_RESULT_RECOVERED;
> > +}
> > +
> >  static const struct pci_error_handlers vfio_err_handlers = {
> >  	.error_detected = vfio_pci_aer_err_detected,
> > +	.slot_reset = vfio_pci_aer_slot_reset,
> >  };
> >  
> 
> if .slot_reset wants to be called, .error_detected should return
> PCI_ERS_RESULT_NEED_RESET, as pci-error-recovery.txt said, so does code.
> 
> Is .slot_reset now just a copy of .error_detected and we are going do
> some tricks here? or else don't get why .slot_reset signal user again.


No. We do not want a slot reset. But it might be triggered by
another (PF) driver on the slot. If that happens some driver did something
to make devices in the slot go to reset and our driver must recover.
We can't recover however, so let's stop the VM.

Basically the design is simple
- if you can keep going - do
- if you can't - ask qemu to stop guest

Don't worry about adding more conditions to trigger reset etc
at this point. Do that with later patches on-top.

> >  static struct pci_driver vfio_pci_driver = {
> > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > index 1c46045..e883db5 100644
> > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > @@ -611,6 +611,17 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_device *vdev,
> >  					       count, flags, data);
> >  }
> >  
> > +static int vfio_pci_set_non_fatal_err_trigger(struct vfio_pci_device *vdev,
> > +				    unsigned index, unsigned start,
> > +				    unsigned count, uint32_t flags, void *data)
> > +{
> > +	if (index != VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX || start != 0 || count > 1)
> > +		return -EINVAL;
> > +
> > +	return vfio_pci_set_ctx_trigger_single(&vdev->non_fatal_err_trigger,
> > +					       count, flags, data);
> > +}
> > +
> >  static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
> >  				    unsigned index, unsigned start,
> >  				    unsigned count, uint32_t flags, void *data)
> > @@ -664,6 +675,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
> >  			break;
> >  		}
> >  		break;
> > +	case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
> > +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> > +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> > +			if (pci_is_pcie(vdev->pdev))
> > +				func = vfio_pci_set_err_trigger;
> 
> s/vfio_pci_set_err_trigger/vfio_pci_set_non_fatal_err_trigger

Right.

> > +			break;
> > +		}
> > +		break;
> >  	case VFIO_PCI_REQ_IRQ_INDEX:
> >  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> >  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> > diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> > index f37c73b..c27a507 100644
> > --- a/drivers/vfio/pci/vfio_pci_private.h
> > +++ b/drivers/vfio/pci/vfio_pci_private.h
> > @@ -93,6 +93,7 @@ struct vfio_pci_device {
> >  	struct pci_saved_state	*pci_saved_state;
> >  	int			refcnt;
> >  	struct eventfd_ctx	*err_trigger;
> > +	struct eventfd_ctx	*non_fatal_err_trigger;
> >  	struct eventfd_ctx	*req_trigger;
> >  	struct list_head	dummy_resources_list;
> >  };
> > 
> 
> -- 
> Sincerely,
> Cao jin
> 
