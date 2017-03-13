Received: from eggs.gnu.org ([2001:4830:134:3::10]:50990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cnY6j-0004Ez-FG
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cnY6g-0007ZI-7K
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cnY6f-0007Yi-VH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:06:22 -0400
Date: Mon, 13 Mar 2017 16:06:19 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170313160619.28622002@t450s.home>
In-Reply-To: <1488180523-18137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1488180523-18137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vfio pci: kernel support of error recovery
 only for non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com

On Mon, 27 Feb 2017 15:28:43 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> 0. What happens now (PCIE AER only)
>    Fatal errors cause a link reset.
>    Non fatal errors don't.
>    All errors stop the VM eventually, but not immediately
>    because it's detected and reported asynchronously.
>    Interrupts are forwarded as usual.
>    Correctable errors are not reported to guest at all.
>    Note: PPC EEH is different. This focuses on AER.

Perhaps you're only focusing on AER, but don't the error handlers we're
using support both AER and EEH generically?  I don't think we can
completely disregard how this affects EEH behavior, if at all.

> 
> 1. Correctable errors
>    There is no need to report these to guest. So let's not.

What does this patch change to make this happen?  I don't see
anything.  Was this always the case?  No change?

> 
> 2. Fatal errors
>    It's not easy to handle them gracefully since link reset
>    is needed. As a first step, let's use the existing mechanism
>    in that case.

Ok, so no change here either.

> 2. Non-fatal errors
>    Here we could make progress by reporting them to guest
>    and have guest handle them.

In practice, what actual errors do we expect userspace to see as
non-fatal errors?  It would be useful for the commit log to describe
the actual benefit we're going to see by splitting out non-fatal errors
for the user (not always a guest) to see separately.  Justify that this
is actually useful.

> 
>    Issues:
>    a. this behaviour should only be enabled with new userspace,
>       old userspace should work without changes.
> 
>       Suggestion: One way to address this would be to add a new eventfd
>       non_fatal_err_trigger. If not set, invoke err_trigger.

This outline format was really more useful for Michael to try to
generate discussion, for a commit log, I'd much rather see a definitive
statement such as:

 "To maintain backwards compatibility with userspace, non-fatal errors
 will continue to trigger via the existing error interrupt index if a
 non-fatal signaling mechanism has not been registered."

>    b. drivers are supposed to stop MMIO when error is reported,
>       if vm keeps going, we will keep doing MMIO/config.
> 
>       Suggestion 1: ignore this. vm stop happens much later when
>       userspace runs anyway, so we are not making things much worse.
> 
>       Suggestion 2: try to stop MMIO/config, resume on resume call
> 
>       Patch below implements Suggestion 1.
> 
>       Note that although this is really against the documentation, which
>       states error_detected() is the point at which the driver should quiesce
>       the device and not touch it further (until diagnostic poking at
>       mmio_enabled or full access at resume callback).
> 
>       Fixing this won't be easy. However, this is not a regression.
> 
>       Also note this does nothing about interrupts, documentation
>       suggests returning IRQ_NONE until reset.
>       Again, not a regression.

So again, no change here.  I'm not sure what this adds to the commit
log, perhaps we can reference this as a link to Michael's original
proposal.
 
>    c. PF driver might detect that function is completely broken,
>       if vm keeps going, we will keep doing MMIO/config.
> 
>       Suggestion 1: ignore this. vm stop happens much later when
>       userspace runs anyway, so we are not making things much worse.
> 
>       Suggestion 2: detect this and invoke err_trigger to stop VM.
> 
>       Patch below implements Suggestion 2.

This needs more description and seems a bit misleading.  This patch
adds a slot_reset handler, such that if the slot is reset, we notify
the user, essentially promoting the non-fatal error to fatal.  But what
condition gets us to this point?  AIUI, AER is a voting scheme and if
any driver affected says they need a reset, everyone gets a reset.  So
the PF driver we're talking about here is not vfio-pci and it's not the
user, the user has no way to signal that the device is completely
broken, this only handles the case of other collateral devices with
native host drivers that might signal this, right?

It seems like this is where this patch has the greatest exposure to
regressions.  If we take the VM use case, previously we could have a
non-AER aware guest and the hypervisor could stop the VM on all
errors.  Now the hypervisor might support the distinction between fatal
and non-fatal, but the guest may still not have AER support.  That
doesn't imply a problem with this approach, the user (hypervisor) would
be at fault for any difference in handling in that case.

> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 38 +++++++++++++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_intrs.c   | 19 +++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  1 +
>  include/uapi/linux/vfio.h           |  1 +
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e..3551cc9 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -441,7 +441,8 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
> -	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> +	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX ||
> +		   irq_type == VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX) {
>  		if (pci_is_pcie(vdev->pdev))
>  			return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
> @@ -796,6 +797,7 @@ static long vfio_pci_ioctl(void *device_data,
>  		case VFIO_PCI_REQ_IRQ_INDEX:
>  			break;
>  		case VFIO_PCI_ERR_IRQ_INDEX:
> +		case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
>  			if (pci_is_pcie(vdev->pdev))
>  				break;
>  		/* pass thru to return error */
> @@ -1282,7 +1284,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  
>  	mutex_lock(&vdev->igate);
>  
> -	if (vdev->err_trigger)
> +	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
> +		eventfd_signal(vdev->non_fatal_err_trigger, 1);
> +	else if (vdev->err_trigger)
>  		eventfd_signal(vdev->err_trigger, 1);
>  
>  	mutex_unlock(&vdev->igate);
> @@ -1292,8 +1296,38 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +static pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_device *vdev;
> +	struct vfio_device *device;
> +	static pci_ers_result_t err = PCI_ERS_RESULT_NONE;
> +
> +	device = vfio_device_get_from_dev(&pdev->dev);
> +	if (!device)
> +		goto err_dev;
> +
> +	vdev = vfio_device_data(device);
> +	if (!vdev)
> +		goto err_data;
> +
> +	mutex_lock(&vdev->igate);
> +
> +	if (vdev->err_trigger)
> +		eventfd_signal(vdev->err_trigger, 1);

What about the case where the user has not registered for receiving
non-fatal errors, now we send an error signal on both error_detected
and slot_reset.  Is that useful/desirable?

> +
> +	mutex_unlock(&vdev->igate);
> +
> +	err = PCI_ERS_RESULT_RECOVERED;
> +
> +err_data:
> +	vfio_device_put(device);
> +err_dev:
> +	return err;
> +}
> +
>  static const struct pci_error_handlers vfio_err_handlers = {
>  	.error_detected = vfio_pci_aer_err_detected,
> +	.slot_reset = vfio_pci_aer_slot_reset,
>  };
>  
>  static struct pci_driver vfio_pci_driver = {
> diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
> index 1c46045..270d568 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -611,6 +611,17 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_device *vdev,
>  					       count, flags, data);
>  }
>  
> +static int vfio_pci_set_non_fatal_err_trigger(struct vfio_pci_device *vdev,
> +				    unsigned index, unsigned start,
> +				    unsigned count, uint32_t flags, void *data)
> +{
> +	if (index != VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX || start != 0 || count > 1)
> +		return -EINVAL;
> +
> +	return vfio_pci_set_ctx_trigger_single(&vdev->non_fatal_err_trigger,
> +					       count, flags, data);
> +}
> +
>  static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
>  				    unsigned index, unsigned start,
>  				    unsigned count, uint32_t flags, void *data)
> @@ -664,6 +675,14 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
>  			break;
>  		}
>  		break;
> +	case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
> +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> +			if (pci_is_pcie(vdev->pdev))
> +				func = vfio_pci_set_non_fatal_err_trigger;
> +			break;
> +		}
> +		break;
>  	case VFIO_PCI_REQ_IRQ_INDEX:
>  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index f561ac1..d30f8a3 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -93,6 +93,7 @@ struct vfio_pci_device {
>  	struct pci_saved_state	*pci_saved_state;
>  	int			refcnt;
>  	struct eventfd_ctx	*err_trigger;
> +	struct eventfd_ctx	*non_fatal_err_trigger;
>  	struct eventfd_ctx	*req_trigger;
>  	struct list_head	dummy_resources_list;
>  };
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..affa973 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -443,6 +443,7 @@ enum {
>  	VFIO_PCI_MSIX_IRQ_INDEX,
>  	VFIO_PCI_ERR_IRQ_INDEX,
>  	VFIO_PCI_REQ_IRQ_INDEX,
> +	VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX,
>  	VFIO_PCI_NUM_IRQS
>  };
>  
