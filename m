Received: from eggs.gnu.org ([2001:4830:134:3::10]:35086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cULeG-0006Wl-M5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:57:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cULeD-0004UD-Fn
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:57:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cULeD-0004TC-7A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 17:57:37 -0500
Date: Thu, 19 Jan 2017 15:57:34 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170119155734.7dda7fc3@t450s.home>
In-Reply-To: <20170120001132-mutt-send-email-mst@kernel.org>
References: <20170119001744-mutt-send-email-mst@kernel.org>
	<20170119151056.44b559d1@t450s.home>
	<20170120001132-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cao jin <caoj.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com

On Fri, 20 Jan 2017 00:21:02 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jan 19, 2017 at 03:10:56PM -0700, Alex Williamson wrote:
> > On Thu, 19 Jan 2017 22:16:03 +0200
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > This is a design and an initial patch for kernel side for AER
> > > support in VFIO.
> > > 
> > > 0. What happens now (PCIE AER only)
> > >    Fatal errors cause a link reset.
> > >    Non fatal errors don't.
> > >    All errors stop the VM eventually, but not immediately
> > >    because it's detected and reported asynchronously.
> > >    Interrupts are forwarded as usual.
> > >    Correctable errors are not reported to guest at all.
> > >    Note: PPC EEH is different. This focuses on AER.
> > > 
> > > 1. Correctable errors
> > >    I don't see a need to report these to guest. So let's not.
> > > 
> > > 2. Fatal errors
> > >    It's not easy to handle them gracefully since link reset
> > >    is needed. As a first step, let's use the existing mechanism
> > >    in that case.
> > >    
> > > 2. Non-fatal errors
> > >    Here we could make progress by reporting them to guest
> > >    and have guest handle them.
> > >    Issues:
> > >     a. this behaviour should only be enabled with new userspace
> > >        old userspace should work without changes
> > >     Suggestion: One way to address this would be to add a new eventfd
> > >     non_fatal_err_trigger. If not set, invoke err_trigger.
> > > 
> > >     b. drivers are supposed to stop MMIO when error is reported
> > >     if vm keeps going, we will keep doing MMIO/config
> > >     Suggestion 1: ignore this. vm stop happens much later when userspace runs anyway,
> > >     so we are not making things much worse
> > >     Suggestion 2: try to stop MMIO/config, resume on resume call
> > > 
> > >     Patch below implements Suggestion 1.  
> > 
> > Although this is really against the documentation,  
> 
> documentation is out of sync with code unfortunately.
> I have a todo to rewrite it to match reality, for now
> you will have to read the recovery function code.
> Fortunately it is rather short.
> 
> > which states
> > error_detected() is the point at which the driver should quiesce the
> > device and not touch it further (until diagnostic poking at
> > mmio_enabled or full access at resume callback).  
> 
> Right. But note it's not a regression.

Agreed.
 
> > >     c. PF driver might detect that function is completely broken,
> > >     if vm keeps going, we will keep doing MMIO/config
> > >     Suggestion 1: ignore this. vm stop happens much later when userspace runs anyway,
> > >     so we are not making things much worse
> > >     Suggestion 2: detect this and invoke err_trigger to stop VM
> > > 
> > >     Patch below implements Suggestion 2.
> > > 
> > > Aside: we currently return PCI_ERS_RESULT_DISCONNECT when device
> > > is not attached. This seems bogus, likely based on the confusing name.
> > > We probably should return PCI_ERS_RESULT_CAN_RECOVER.  
> > 
> > Not sure I agree here, if we get called for the error_detected callback
> > and we can't find a handle for the device, we certainly don't want to
> > see any of the other callbacks for this device and we can't do anything
> > about recovering it.  
> 
> But we aren't actually driving it from any VMs so it's in the same
> state it was and not doing any DMA or MMIO.

If either of the two cases where we return DISCONNECT occur, then we're
probably getting an error_detected callback as the device is being
unbound from vfio-pci, or we're just in a completely inconsistent state
where we're getting aer callbacks for devices not even bound to
vfio-pci.  We really just want to not be involved with recover of such
devices. Maybe we should vote PCI_ERS_RESULT_NONE.

> >  What's wrong with putting the device into a
> > failed state in that case?  
> 
> That you will wedge the PF too for no good reason.
> 
> > I actually question whether CAN_RECOVER is really the right return for
> > the existing path.  If we consider this to be a fatal error, should we
> > be voting NEED_RESET?  We're certainly not doing anything to return the
> > device to a working state.  
> 
> 
> Yes we do - we stop VM and reset device on VM shutdown.
> At least for VFs this is likely enough as by design they
> must not wedge each other on driver bugs.

Right, if the device supports FLR, which VFs are required to do, then
we can always reset the device.  I think that we have a lot of use
cases of PF assignment though, I don't think that's just something we
can push to the side as not recommended.

> >  Should we be more harsh if err_trigger is
> > not registered, putting the device into DISCONNECT?  Should only the new
> > path you've added below for non-fatal errors return CAN_RECOVER?  
> 
> So anyone assigning PFs deserves the resulting pain. I don't
> want to speculate about the best strategy there.
> But for VFs I think CAN_RECOVER is reasonable because
> they should be independent of each other.

So perhaps we should be using our reset probe when the device is opened
for whether it supports a function level reset (whether that be FLR or
some other mechanism) so we can support both VFs and "robust" PFs.

> Also pls note any status except CAN_RECOVER mostly just wedges hardware
> ATM. Maybe AER should do link resets more aggressively but it does not.

:-\

> > > The following patch does not change that.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > 
> > > ---
> > > 
> > > The patch is completely untested. Let's discuss the design first.
> > > Cao jin, if this is deemed acceptable please take it from here.
> > > 
> > > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > > index dce511f..fdca683 100644
> > > --- a/drivers/vfio/pci/vfio_pci.c
> > > +++ b/drivers/vfio/pci/vfio_pci.c
> > > @@ -1292,7 +1292,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> > >  
> > >  	mutex_lock(&vdev->igate);
> > >  
> > > -	if (vdev->err_trigger)
> > > +	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
> > > +		eventfd_signal(vdev->err_trigger, 1);  
> > 
> > s/err_trigger/non_fatal_err_trigger/
> >   
> > > +	else if (vdev->err_trigger)
> > >  		eventfd_signal(vdev->err_trigger, 1);
> > >  
> > >  	mutex_unlock(&vdev->igate);
> > > @@ -1302,8 +1304,38 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
> > >  	return PCI_ERS_RESULT_CAN_RECOVER;
> > >  }
> > >  
> > > +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev,
> > > +						pci_channel_state_t state)
> > > +{
> > > +	struct vfio_pci_device *vdev;
> > > +	struct vfio_device *device;
> > > +
> > > +	device = vfio_device_get_from_dev(&pdev->dev);
> > > +	if (!device)
> > > +		goto err_dev;
> > > +
> > > +	vdev = vfio_device_data(device);
> > > +	if (!vdev)
> > > +		goto err_dev;  
> > 
> > s/err_dev/err_data/
> >   
> > > +
> > > +	mutex_lock(&vdev->igate);
> > > +
> > > +	if (vdev->err_trigger)
> > > +		eventfd_signal(vdev->err_trigger, 1);
> > > +
> > > +	mutex_unlock(&vdev->igate);
> > > +
> > > +	vfio_device_put(device);
> > > +
> > > +err_data:
> > > +	vfio_device_put(device);
> > > +err_dev:
> > > +	return PCI_ERS_RESULT_RECOVERED;
> > > +}
> > > +
> > >  static const struct pci_error_handlers vfio_err_handlers = {
> > >  	.error_detected = vfio_pci_aer_err_detected,
> > > +	.slot_reset = vfio_pci_aer_slot_reset,
> > >  };
> > >  
> > >  static struct pci_driver vfio_pci_driver = {
> > > diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> > > index 1c46045..e883db5 100644
> > > --- a/drivers/vfio/pci/vfio_pci_intrs.c
> > > +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> > > @@ -611,6 +611,17 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_device *vdev,
> > >  					       count, flags, data);
> > >  }
> > >  
> > > +static int vfio_pci_set_non_fatal_err_trigger(struct vfio_pci_device *vdev,
> > > +				    unsigned index, unsigned start,
> > > +				    unsigned count, uint32_t flags, void *data)
> > > +{
> > > +	if (index != VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX || start != 0 || count > 1)
> > > +		return -EINVAL;
> > > +
> > > +	return vfio_pci_set_ctx_trigger_single(&vdev->non_fatal_err_trigger,
> > > +					       count, flags, data);
> > > +}
> > > +
> > >  static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
> > >  				    unsigned index, unsigned start,
> > >  				    unsigned count, uint32_t flags, void *data)
> > > @@ -664,6 +675,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
> > >  			break;
> > >  		}
> > >  		break;
> > > +	case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
> > > +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> > > +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> > > +			if (pci_is_pcie(vdev->pdev))
> > > +				func = vfio_pci_set_err_trigger;
> > > +			break;
> > > +		}
> > > +		break;
> > >  	case VFIO_PCI_REQ_IRQ_INDEX:
> > >  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> > >  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> > > diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> > > index f37c73b..c27a507 100644
> > > --- a/drivers/vfio/pci/vfio_pci_private.h
> > > +++ b/drivers/vfio/pci/vfio_pci_private.h
> > > @@ -93,6 +93,7 @@ struct vfio_pci_device {
> > >  	struct pci_saved_state	*pci_saved_state;
> > >  	int			refcnt;
> > >  	struct eventfd_ctx	*err_trigger;
> > > +	struct eventfd_ctx	*non_fatal_err_trigger;
> > >  	struct eventfd_ctx	*req_trigger;
> > >  	struct list_head	dummy_resources_list;
> > >  };
> > >   
> > 
> > VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX never got defined.
> > 
> > So if we think the link is ok, we notify a non-fatal event to the user,
> > but we don't do anything about preventing access to the device between
> > error_detected and resume as the documentation indicates we should.  If
> > the system does a slot reset anyway, perhaps as a response to another
> > driver on the same bus, we promote to fatal error signaling.  If we
> > have no user signaling mechanism, shouldn't that also mark the device
> > failed via returning DISCONNECT?  On the QEMU side, we'd still need to
> > try to guess whether the VM is attempting a link reset is in response to
> > the AER event and QEMU would need to vm_stop() in that case, right?
> > Thanks,
> > 
> > Alex  
