Received: from eggs.gnu.org ([2001:4830:134:3::10]:43184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTimn-00080c-TK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTimk-00046u-Ps
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:27:53 -0500
Received: from [59.151.112.132] (port=56060 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cTimj-00045c-Qw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 00:27:50 -0500
References: <1483175736-17137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <587EFE33.9020608@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 13:33:39 +0800
MIME-Version: 1.0
In-Reply-To: <1483175736-17137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] vfio/pci: Support error recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, mst@redhat.com

Alex,
Do you have any comments on this version & and the qemu parts?

-- 
Sincerely,
Cao jin

On 12/31/2016 05:15 PM, Cao jin wrote:
> Support serious device error recovery
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  drivers/vfio/pci/vfio_pci.c         | 70 +++++++++++++++++++++++++++++++++++--
>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
>  2 files changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 712a849..752af20 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -534,6 +534,15 @@ static long vfio_pci_ioctl(void *device_data,
>  {
>  	struct vfio_pci_device *vdev = device_data;
>  	unsigned long minsz;
> +	int ret;
> +
> +	if (vdev->aer_recovering && (cmd == VFIO_DEVICE_SET_IRQS ||
> +	    cmd == VFIO_DEVICE_RESET || cmd == VFIO_DEVICE_PCI_HOT_RESET)) {
> +		ret = wait_for_completion_interruptible(
> +			&vdev->aer_completion);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (cmd == VFIO_DEVICE_GET_INFO) {
>  		struct vfio_device_info info;
> @@ -953,6 +962,15 @@ static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
>  {
>  	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
>  	struct vfio_pci_device *vdev = device_data;
> +	int ret;
> +
> +	/* block all kinds of access during host recovery */
> +	if (vdev->aer_recovering) {
> +		ret = wait_for_completion_interruptible(
> +			&vdev->aer_completion);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
>  		return -EINVAL;
> @@ -1117,6 +1135,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>  	mutex_init(&vdev->igate);
>  	spin_lock_init(&vdev->irqlock);
> +	init_completion(&vdev->aer_completion);
>  
>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>  	if (ret) {
> @@ -1176,6 +1195,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  {
>  	struct vfio_pci_device *vdev;
>  	struct vfio_device *device;
> +	u32 uncor_status;
> +	unsigned int aer_cap_offset;
> +	int ret;
>  
>  	device = vfio_device_get_from_dev(&pdev->dev);
>  	if (device == NULL)
> @@ -1187,10 +1209,29 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> +	/*
> +	 * get device's uncorrectable error status as soon as possible,
> +	 * and signal it to user space. The later we read it, the possibility
> +	 * the register value is mangled grows.
> +	 */
> +	aer_cap_offset = pci_find_ext_capability(vdev->pdev, PCI_EXT_CAP_ID_ERR);
> +	ret = pci_read_config_dword(vdev->pdev, aer_cap_offset +
> +                                    PCI_ERR_UNCOR_STATUS, &uncor_status);
> +        if (ret)
> +                return PCI_ERS_RESULT_DISCONNECT;
> +
> +	pr_info("device %d got AER detect notification. uncorrectable error status = 0x%x\n", pdev->devfn, uncor_status);//to be removed
>  	mutex_lock(&vdev->igate);
>  
> -	if (vdev->err_trigger)
> -		eventfd_signal(vdev->err_trigger, 1);
> +	vdev->aer_recovering = true;
> +	reinit_completion(&vdev->aer_completion);
> +
> +	if (vdev->err_trigger && uncor_status) {
> +		pr_info("device %d signal uncor status 0x%x to user",
> +			pdev->devfn, uncor_status);
> +		/* signal uncorrectable error status to user space */
> +		eventfd_signal(vdev->err_trigger, uncor_status);
> +        }
>  
>  	mutex_unlock(&vdev->igate);
>  
> @@ -1199,8 +1240,33 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>  	return PCI_ERS_RESULT_CAN_RECOVER;
>  }
>  
> +static void vfio_pci_aer_resume(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_device *vdev;
> +	struct vfio_device *device;
> +
> +	device = vfio_device_get_from_dev(&pdev->dev);
> +	if (device == NULL)
> +		return;
> +
> +	vdev = vfio_device_data(device);
> +	if (vdev == NULL) {
> +		vfio_device_put(device);
> +		return;
> +	}
> +
> +	mutex_lock(&vdev->igate);
> +	vdev->aer_recovering = false;
> +	mutex_unlock(&vdev->igate);
> +
> +	complete_all(&vdev->aer_completion);
> +
> +	vfio_device_put(device);
> +}
> +
>  static const struct pci_error_handlers vfio_err_handlers = {
>  	.error_detected = vfio_pci_aer_err_detected,
> +	.resume         = vfio_pci_aer_resume,
>  };
>  
>  static struct pci_driver vfio_pci_driver = {
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
> index 8a7d546..ba8471f 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -83,6 +83,8 @@ struct vfio_pci_device {
>  	bool			bardirty;
>  	bool			has_vga;
>  	bool			needs_reset;
> +	bool			aer_recovering;
> +	struct completion	aer_completion;
>  	struct pci_saved_state	*pci_saved_state;
>  	int			refcnt;
>  	struct eventfd_ctx	*err_trigger;
> 
