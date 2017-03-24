Received: from eggs.gnu.org ([2001:4830:134:3::10]:42490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRx-0004pt-0A
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRt-0002yt-NI
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1crXRt-0002yf-Dy
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:45 -0400
Date: Fri, 24 Mar 2017 16:12:38 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170324161238.366ce6a7@t450s.home>
In-Reply-To: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490260051-6046-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6] vfio error recovery: kernel support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, 23 Mar 2017 17:07:31 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

A more appropriate patch subject would be:

vfio-pci: Report correctable errors and slot reset events to user

> From: "Michael S. Tsirkin" <mst@redhat.com>

This hardly seems accurate anymore.  You could say Suggested-by and let
Michael add a sign-off, but it's changed since he sent it.

> 
> 0. What happens now (PCIE AER only)
>    Fatal errors cause a link reset. Non fatal errors don't.
>    All errors stop the QEMU guest eventually, but not immediately,
>    because it's detected and reported asynchronously.
>    Interrupts are forwarded as usual.
>    Correctable errors are not reported to user at all.
> 
>    Note:
>    PPC EEH is different, but this approach won't affect EEH. EEH treat
>    all errors as fatal ones in AER, so they will still be signalled to user
>    via the legacy eventfd.  Besides, all devices/functions in a PE belongs
>    to the same IOMMU group, so the slot_reset handler in this approach
>    won't affect EEH either.
> 
> 1. Correctable errors
>    Hardware can correct these errors without software intervention,
>    clear the error status is enough, this is what already done now.
>    No need to recover it, nothing changed, leave it as it is.
> 
> 2. Fatal errors
>    They will induce a link reset. This is troublesome when user is
>    a QEMU guest. This approach doesn't touch the existing mechanism.
> 
> 3. Non-fatal errors
>    Before this patch, they are signalled to user the same way as fatal ones.
>    With this patch, a new eventfd is introduced only for non-fatal error
>    notification. By splitting non-fatal ones out, it will benefit AER
>    recovery of a QEMU guest user.
> 
>    To maintain backwards compatibility with userspace, non-fatal errors
>    will continue to trigger via the existing error interrupt index if a
>    non-fatal signaling mechanism has not been registered.
> 
>    Note:
>    In case of PCI Express errors, kernel might request a slot reset
>    affecting our device (from our point of view this is a passive device
>    reset as opposed to an active one requested by vfio itself).
>    This might currently happen if a slot reset is requested by a driver
>    (other than vfio) bound to another device function in the same slot.
>    This will cause our device to lose its state so report this event to
>    userspace.

I tried to convey this in my last comments, I don't think this is an
appropriate commit log.  Lead with what is the problem you're trying to
fix and why, what is the benefit to the user, and how is the change
accomplished.  If you want to provide a State of Error Handling in
VFIO, append it after the main points of the commit log.

I also asked in my previous comments to provide examples of errors that
might trigger correctable errors to the user, this comment seems to
have been missed.  In my experience, AERs generated during device
assignment are generally hardware faults or induced by bad guest
drivers.  These are cases where a single fatal error is an appropriate
and sufficient response.  We've scaled back this support to the point
where we're only improving the situation of correctable errors and I'm
not convinced this is worthwhile and we're not simply checking a box on
an ill-conceived marketing requirements document.

I had also commented asking how the hypervisor is expected to know
whether the guest supports AER.  With the existing support of a single
fatal error, the hypervisor halts the VM regardless of the error
severity or guest support.  Now we have the opportunity that the
hypervisor can forward a correctable error to the guest... and hope the
right thing occurs?  I never saw any response to this comment.

> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> v6 changelog:
> Address all the comments from MST.
> 
>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_intrs.c   | 38 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
>  include/uapi/linux/vfio.h           |  2 ++
>  4 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e..71f9a8a 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -441,7 +441,9 @@ static int vfio_pci_get_irq_count(struct vfio_pci_device *vdev, int irq_type)
>  
>  			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
>  		}
> -	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
> +	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX ||
> +		   irq_type == VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX ||
> +		   irq_type == VFIO_PCI_PASSIVE_RESET_IRQ_INDEX) {

Should we add a typdef to alias VFIO_PCI_ERR_IRQ_INDEX to
VFIO_PCI_FATAL_ERR_IRQ?

>  		if (pci_is_pcie(vdev->pdev))
>  			return 1;
>  	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
> @@ -796,6 +798,8 @@ static long vfio_pci_ioctl(void *device_data,
>  		case VFIO_PCI_REQ_IRQ_INDEX:
>  			break;
>  		case VFIO_PCI_ERR_IRQ_INDEX:
> +		case VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX:
> +		case VFIO_PCI_PASSIVE_RESET_IRQ_INDEX:
>  			if (pci_is_pcie(vdev->pdev))
>  				break;
>  		/* pass thru to return error */
> @@ -1282,7 +1286,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  
>  	mutex_lock(&vdev->igate);
>  
> -	if (vdev->err_trigger)
> +	if (state == pci_channel_io_normal && vdev->non_fatal_err_trigger)
> +		eventfd_signal(vdev->non_fatal_err_trigger, 1);
> +	else if (vdev->err_trigger)
>  		eventfd_signal(vdev->err_trigger, 1);

Should another patch rename err_trigger to fatal_err_trigger to better
describe its new function?

>  
>  	mutex_unlock(&vdev->igate);
> @@ -1292,8 +1298,47 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +/*
> + * In case of PCI Express errors, kernel might request a slot reset
> + * affecting our device (from our point of view, this is a passive device
> + * reset as opposed to an active one requested by vfio itself).
> + * This might currently happen if a slot reset is requested by a driver
> + * (other than vfio) bound to another device function in the same slot.
> + * This will cause our device to lose its state, so report this event to
> + * userspace.
> + */

I really dislike "passive reset".  I expect you avoided "slot reset"
because we have other sources where vfio itself initiates a slot
reset.  Is "spurious" more appropriate?  "Collateral"?

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
> +	if (vdev->passive_reset_trigger)
> +		eventfd_signal(vdev->passive_reset_trigger, 1);

What are the exact user requirements here, we now have:

A) err_trigger
B) non_fatal_err_trigger
C) passive_reset_trigger

Currently we only have A, which makes things very simple, we notify on
errors and assume the user doesn't care otherwise.

The expectation here seems to be that A, B, and C are all registered,
but what if they're not?  What if in the above function, only A & B are
registered, do we trigger A here?  Are B & C really intrinsic to each
other and we should continue to issue only A unless both B & C are
registered?  In that case, should we be exposing a single IRQ INDEX to
the user with two sub-indexes, defined as sub-index 0 is correctable
error, sub-index 1 is slot reset, and promote any error to A if they
are not both registered?

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
> index 1c46045..7157d85 100644
> --- a/drivers/vfio/pci/vfio_pci_intrs.c
> +++ b/drivers/vfio/pci/vfio_pci_intrs.c
> @@ -611,6 +611,28 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_device *vdev,
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
> +static int vfio_pci_set_passive_reset_trigger(struct vfio_pci_device *vdev,
> +				    unsigned index, unsigned start,
> +				    unsigned count, uint32_t flags, void *data)
> +{
> +	if (index != VFIO_PCI_PASSIVE_RESET_IRQ_INDEX || start != 0 || count > 1)
> +		return -EINVAL;
> +
> +	return vfio_pci_set_ctx_trigger_single(&vdev->passive_reset_trigger,
> +					       count, flags, data);
> +}
> +
>  static int vfio_pci_set_req_trigger(struct vfio_pci_device *vdev,
>  				    unsigned index, unsigned start,
>  				    unsigned count, uint32_t flags, void *data)
> @@ -664,6 +686,22 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_device *vdev, uint32_t flags,
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
> +	case VFIO_PCI_PASSIVE_RESET_IRQ_INDEX:
> +		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
> +		case VFIO_IRQ_SET_ACTION_TRIGGER:
> +			if (pci_is_pcie(vdev->pdev))
> +				func = vfio_pci_set_passive_reset_trigger;
> +			break;
> +		}
> +		break;
>  	case VFIO_PCI_REQ_IRQ_INDEX:
>  		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
>  		case VFIO_IRQ_SET_ACTION_TRIGGER:
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index f561ac1..cbc4b88 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -93,6 +93,8 @@ struct vfio_pci_device {
>  	struct pci_saved_state	*pci_saved_state;
>  	int			refcnt;
>  	struct eventfd_ctx	*err_trigger;
> +	struct eventfd_ctx	*non_fatal_err_trigger;
> +	struct eventfd_ctx	*passive_reset_trigger;
>  	struct eventfd_ctx	*req_trigger;
>  	struct list_head	dummy_resources_list;
>  };
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 519eff3..26b4be0 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -443,6 +443,8 @@ enum {
>  	VFIO_PCI_MSIX_IRQ_INDEX,
>  	VFIO_PCI_ERR_IRQ_INDEX,
>  	VFIO_PCI_REQ_IRQ_INDEX,
> +	VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX,
> +	VFIO_PCI_PASSIVE_RESET_IRQ_INDEX,
>  	VFIO_PCI_NUM_IRQS
>  };
>  
