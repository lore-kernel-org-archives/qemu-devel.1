Received: from eggs.gnu.org ([2001:4830:134:3::10]:35785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU2wC-00028F-OS
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 21:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU2w9-0007mp-Kg
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 21:58:56 -0500
Received: from [59.151.112.132] (port=55136 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU2w8-0007mK-Gq
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 21:58:53 -0500
References: <1483175736-17137-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170110005600-mutt-send-email-mst@kernel.org>
	<5874C989.9080504@cn.fujitsu.com>
	<20170110170832-mutt-send-email-mst@kernel.org>
	<20170118143239.68c3ee86@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58802CC5.1080005@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 11:04:37 +0800
MIME-Version: 1.0
In-Reply-To: <20170118143239.68c3ee86@t450s.home>
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
To: Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com



On 01/19/2017 05:32 AM, Alex Williamson wrote:
> On Tue, 10 Jan 2017 17:11:01 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Tue, Jan 10, 2017 at 07:46:17PM +0800, Cao jin wrote:
>>>
>>>
>>> On 01/10/2017 07:04 AM, Michael S. Tsirkin wrote:  
>>>> On Sat, Dec 31, 2016 at 05:15:36PM +0800, Cao jin wrote:  
>>>>> Support serious device error recovery  
>>>>
>>>> serious?
>>>>  
>>>
>>> Sorry for my poor vocabulary if it confuses people. I wanted to express
>>> the meaning that: vfio-pci actually cannot do a real recovery for device
>>> even if it provides the callbacks, it relies on the user to do a
>>> effective(or word "serious"?) recovery.
>>>
>>> Welcome the amendment on the commit log.  
>>
>> It's up to Alex, maybe he's able to figure it all out from
>> code, but the rest of us could benefit from a description
>> of what the patch does from userspace point of view.
>>
>> Also, is it a pre-requisite of the userspace patches you posted?
> 
> This is the same blocking user accesses while the device is in recovery
> that you thought was ineffective/wrong before.  Why do we still need it
> if QEMU isn't trying to handle fatal errors?  If the kernel is doing a
> reset shouldn't the user consider the device dead?  A commit log
> explaining this is absolutely necessary.  Thanks,
> 
> Alex
> 

Yes, it is the same blocking user access as before, and I did said it is
not effective as we expected, and I drew the figure to illustrate my
analysis. I think the blocking is right, maybe just not enough to work
fine, because it is possible that vfio's blocking is over, while
hardware reset is not done, results in inaccessible device.

Leave the blocking here is no harm for now, and could be useful in
future(when we handle fatal error).

We don't forward fatal error events to guest, why would guest kernel do
a reset? Or do you mean some device driver would do hardware reset on
non-fatal error?

-- 
Sincerely,
Cao jin

>>>>>
>>>>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>>>>> ---
>>>>>  drivers/vfio/pci/vfio_pci.c         | 70 +++++++++++++++++++++++++++++++++++--
>>>>>  drivers/vfio/pci/vfio_pci_private.h |  2 ++
>>>>>  2 files changed, 70 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>>>>> index 712a849..752af20 100644
>>>>> --- a/drivers/vfio/pci/vfio_pci.c
>>>>> +++ b/drivers/vfio/pci/vfio_pci.c
>>>>> @@ -534,6 +534,15 @@ static long vfio_pci_ioctl(void *device_data,
>>>>>  {
>>>>>  	struct vfio_pci_device *vdev = device_data;
>>>>>  	unsigned long minsz;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (vdev->aer_recovering && (cmd == VFIO_DEVICE_SET_IRQS ||
>>>>> +	    cmd == VFIO_DEVICE_RESET || cmd == VFIO_DEVICE_PCI_HOT_RESET)) {
>>>>> +		ret = wait_for_completion_interruptible(
>>>>> +			&vdev->aer_completion);  
>>>>
>>>> don't split it like that.
>>>>   
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>>  
>>>>>  	if (cmd == VFIO_DEVICE_GET_INFO) {
>>>>>  		struct vfio_device_info info;
>>>>> @@ -953,6 +962,15 @@ static ssize_t vfio_pci_rw(void *device_data, char __user *buf,
>>>>>  {
>>>>>  	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
>>>>>  	struct vfio_pci_device *vdev = device_data;
>>>>> +	int ret;
>>>>> +
>>>>> +	/* block all kinds of access during host recovery */
>>>>> +	if (vdev->aer_recovering) {
>>>>> +		ret = wait_for_completion_interruptible(
>>>>> +			&vdev->aer_completion);
>>>>> +		if (ret)
>>>>> +			return ret;
>>>>> +	}
>>>>>  
>>>>>  	if (index >= VFIO_PCI_NUM_REGIONS + vdev->num_regions)
>>>>>  		return -EINVAL;
>>>>> @@ -1117,6 +1135,7 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>  	vdev->irq_type = VFIO_PCI_NUM_IRQS;
>>>>>  	mutex_init(&vdev->igate);
>>>>>  	spin_lock_init(&vdev->irqlock);
>>>>> +	init_completion(&vdev->aer_completion);
>>>>>  
>>>>>  	ret = vfio_add_group_dev(&pdev->dev, &vfio_pci_ops, vdev);
>>>>>  	if (ret) {
>>>>> @@ -1176,6 +1195,9 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>>>>>  {
>>>>>  	struct vfio_pci_device *vdev;
>>>>>  	struct vfio_device *device;
>>>>> +	u32 uncor_status;
>>>>> +	unsigned int aer_cap_offset;
>>>>> +	int ret;
>>>>>  
>>>>>  	device = vfio_device_get_from_dev(&pdev->dev);
>>>>>  	if (device == NULL)
>>>>> @@ -1187,10 +1209,29 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>>>>>  		return PCI_ERS_RESULT_DISCONNECT;
>>>>>  	}
>>>>>  
>>>>> +	/*
>>>>> +	 * get device's uncorrectable error status as soon as possible,  
>>>>
>>>> should be "Get".
>>>>   
>>>>> +	 * and signal it to user space. The later we read it, the possibility
>>>>> +	 * the register value is mangled grows.
>>>>> +	 */
>>>>> +	aer_cap_offset = pci_find_ext_capability(vdev->pdev, PCI_EXT_CAP_ID_ERR);
>>>>> +	ret = pci_read_config_dword(vdev->pdev, aer_cap_offset +
>>>>> +                                    PCI_ERR_UNCOR_STATUS, &uncor_status);
>>>>> +        if (ret)
>>>>> +                return PCI_ERS_RESULT_DISCONNECT;
>>>>> +
>>>>> +	pr_info("device %d got AER detect notification. uncorrectable error status = 0x%x\n", pdev->devfn, uncor_status);//to be removed  
>>>>
>>>> Pls drop this.
>>>>   
>>>>>  	mutex_lock(&vdev->igate);
>>>>>  
>>>>> -	if (vdev->err_trigger)
>>>>> -		eventfd_signal(vdev->err_trigger, 1);
>>>>> +	vdev->aer_recovering = true;
>>>>> +	reinit_completion(&vdev->aer_completion);
>>>>> +
>>>>> +	if (vdev->err_trigger && uncor_status) {
>>>>> +		pr_info("device %d signal uncor status 0x%x to user",
>>>>> +			pdev->devfn, uncor_status);
>>>>> +		/* signal uncorrectable error status to user space */
>>>>> +		eventfd_signal(vdev->err_trigger, uncor_status);
>>>>> +        }
>>>>>  
>>>>>  	mutex_unlock(&vdev->igate);
>>>>>  
>>>>> @@ -1199,8 +1240,33 @@ static pci_ers_result_t vfio_pci_aer_err_detected(struct pci_dev *pdev,
>>>>>  	return PCI_ERS_RESULT_CAN_RECOVER;
>>>>>  }
>>>>>  
>>>>> +static void vfio_pci_aer_resume(struct pci_dev *pdev)
>>>>> +{
>>>>> +	struct vfio_pci_device *vdev;
>>>>> +	struct vfio_device *device;
>>>>> +
>>>>> +	device = vfio_device_get_from_dev(&pdev->dev);
>>>>> +	if (device == NULL)
>>>>> +		return;
>>>>> +
>>>>> +	vdev = vfio_device_data(device);
>>>>> +	if (vdev == NULL) {
>>>>> +		vfio_device_put(device);
>>>>> +		return;
>>>>> +	}
>>>>> +
>>>>> +	mutex_lock(&vdev->igate);
>>>>> +	vdev->aer_recovering = false;
>>>>> +	mutex_unlock(&vdev->igate);
>>>>> +
>>>>> +	complete_all(&vdev->aer_completion);
>>>>> +
>>>>> +	vfio_device_put(device);
>>>>> +}
>>>>> +
>>>>>  static const struct pci_error_handlers vfio_err_handlers = {
>>>>>  	.error_detected = vfio_pci_aer_err_detected,
>>>>> +	.resume         = vfio_pci_aer_resume,
>>>>>  };
>>>>>  
>>>>>  static struct pci_driver vfio_pci_driver = {
>>>>> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_pci_private.h
>>>>> index 8a7d546..ba8471f 100644
>>>>> --- a/drivers/vfio/pci/vfio_pci_private.h
>>>>> +++ b/drivers/vfio/pci/vfio_pci_private.h
>>>>> @@ -83,6 +83,8 @@ struct vfio_pci_device {
>>>>>  	bool			bardirty;
>>>>>  	bool			has_vga;
>>>>>  	bool			needs_reset;
>>>>> +	bool			aer_recovering;
>>>>> +	struct completion	aer_completion;
>>>>>  	struct pci_saved_state	*pci_saved_state;
>>>>>  	int			refcnt;
>>>>>  	struct eventfd_ctx	*err_trigger;
>>>>> -- 
>>>>> 1.8.3.1
>>>>>
>>>>>  
>>>>
>>>> How about some explanation about what is going on here?  All these
>>>> changes seem racy since any number of errors can trigger at any time.
>>>>   
>>>
>>>   
> 
> 
> 
> .
> 
