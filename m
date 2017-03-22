Received: from eggs.gnu.org ([2001:4830:134:3::10]:37389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqg2E-0006nU-92
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cqg2B-00029H-0z
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cqg2A-00028g-OU
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:10:38 -0400
Date: Wed, 22 Mar 2017 15:10:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170322143058-mutt-send-email-mst@kernel.org>
References: <1490178863-14806-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1490178863-14806-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v5] vfio error recovery: kernel support
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

Minor comments on commit log below.

On Wed, Mar 22, 2017 at 06:34:23PM +0800, Cao jin wrote:
> From: "Michael S. Tsirkin" <mst@redhat.com>
> 
> 0. What happens now (PCIE AER only)
>    Fatal errors cause a link reset. Non fatal errors don't.
>    All errors stop the QEMU guest eventually, but not immediately,
>    because it's detected and reported asynchronously.
>    Interrupts are forwarded as usual.
>    Correctable errors are not reported to user at all.
> 
>    Note:
>    PPC EEH is different, but this approach won' affect EEH, because
>    EEH treat all errors as fatal ones in AER, will still signal user
>    via the legacy eventfd. And all devices/functions in a PE belongs to
>    the same IOMMU group, so the slot_reset handler in this approach
>    won't affect EEH either.
> 
> 1. Correctable errors
>    Hardware can correct these errors without software intervention,
>    clear the error status is enough, this is what already done now.
>    No need to recover it, nothing changed, leave it as it is.
> 
> 2. Fatal errors
>    They will induce a link reset. This is troublesome when user is
>    a QEMU guest. This approach doens't touch the existing mechanism.
> 
> 3. Non-fatal errors
>    Before

... this patch

>, they are signalled to user the same

... way

> as fatal ones. In this approach,

-> With this patch

>    a new eventfd is introduced only for non-fatal error notification.

> By
>    splitting non-fatal ones out, it will benefit AER recovery of a QEMU guest
>    user by reporting them to guest saparately.

This last sentence does not add any value, pls drop it.

>    To maintain backwards compatibility with userspace, non-fatal errors
>    will continue to trigger via the existing error interrupt index if a
>    non-fatal signaling mechanism has not been registered.
> 
>    Note:


Below is imho confusing. Pls copy comment text from below.

>    In case of a multi-function device which has different device driver
>    for each of them, and one of the functions is bound to vfio while
>    others doesn't(i.e., functions belong to
> different IOMMU group), a new
>    slot_reset handler & another new eventfd are introduced. This is
>    useful when
> device driver wants a slot reset while vfio-pci doesn't,
>    which means vfio-pci device will got 
>a passive reset.
> Signal user
>    via another new eventfd names
> passive_reset_trigger,
> this helps to
>    avoid signalling user twice via the same legacy error trigger.
> For the original design and discussion,
> refer:
> https://www.spinics.net/lists/linux-virtualization/msg29843.html
> 


I don't think we need to keep this history in commit log.

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
> 
> v5 changelog:
> 1. Add another new eventfd passive_reset_trigger & the boilerplate code,
>    used in slot_reset. Add comment for slot_reset().
> 2. Rewrite the commit log.
> 
>  drivers/vfio/pci/vfio_pci.c         | 49 +++++++++++++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_intrs.c   | 38 ++++++++++++++++++++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
>  include/uapi/linux/vfio.h           |  2 ++
>  4 files changed, 89 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e..375ba20 100644
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
>  
>  	mutex_unlock(&vdev->igate);
> @@ -1292,8 +1298,47 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +/*
> + * In case of a function/device is bound to vfio, while other collateral ones
> + * are still controlled by device driver(i.e., they belongs to different iommu
> + * group), and device driver want a slot reset when seeing AER errors while
> + * vfio pci doesn't, signal user via with proprietary eventfd in precedence to
> + * the legacy one.
> + */

Here's a clearer text, explaining the why not just repeating what the
code does:

/*
 * In case of PCI Express errors, kernel might request a slot reset
 * affecting our device (from our point of view this is a passive device
 * reset as opposed to an active one requested by vfio itself).
 * This might currently happen if a slot reset is requested by a driver
 * (other than vfio) bound to another device function in the same slot.
 * This will cause our device to lose its state so report this event to
 * userspace.
 */



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
> +	else if (vdev->err_trigger)
> +		eventfd_signal(vdev->err_trigger, 1);

why is this chunk here? why not just do

	if (vdev->passive_reset_trigger)
		eventfd_signal(vdev->passive_reset_trigger, 1);

without a fallback?


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
> -- 
> 1.8.3.1
> 
> 
