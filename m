Received: from eggs.gnu.org ([2001:4830:134:3::10]:59673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsp3-00009l-Ee
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsoz-00082M-Aj
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:49:57 -0400
Received: from [59.151.112.132] (port=28170 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cqsoy-00081h-EZ
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 22:49:53 -0400
References: <1490179012-14990-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490179012-14990-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170322151235-mutt-send-email-mst@kernel.org>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58D339D3.40806@cn.fujitsu.com>
Date: Thu, 23 Mar 2017 10:58:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170322151235-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] vfio-pci: process non fatal error
 of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, alex.williamson@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>, peterx@redhat.com



On 03/22/2017 09:27 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 22, 2017 at 06:36:52PM +0800, Cao jin wrote:
>> Make use of the non fatal error eventfd that the kernel module provide
>> to process the AER non fatal error. Fatal error still goes into the
>> legacy way which results in VM stop.
>>
>> Register the handler, wait for notification. Construct aer message and
>> pass it to root port on notification. Root port will trigger an interrupt
>> to signal guest, then guest driver will do the recovery.
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/vfio/pci.c              | 247 +++++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/pci.h              |   4 +
>>  linux-headers/linux/vfio.h |   2 +
>>  3 files changed, 253 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 3d0d005..4912bc6 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2422,6 +2422,34 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>>                       "Could not enable error recovery for the device",
>>                       vbasedev->name);
>>      }
>> +
>> +    irq_info.index = VFIO_PCI_NON_FATAL_ERR_IRQ_INDEX;
>> +    irq_info.count = 0; /* clear */
>> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
>> +    if (ret) {
>> +        /* This can fail for an old kernel or legacy PCI dev */
>> +        trace_vfio_populate_device_get_irq_info_failure();
>> +    } else if (irq_info.count == 1) {
>> +        vdev->pci_aer_non_fatal = true;
>> +    } else {
>> +        error_report(WARN_PREFIX
>> +                     "Couldn't enable non fatal error recovery for the device",
>> +                     vbasedev->name);
> 
> when does this trigger?
> 
>> +    }
>> +
>> +    irq_info.index = VFIO_PCI_PASSIVE_RESET_IRQ_INDEX;
>> +    irq_info.count = 0; /* clear */
>> +    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
>> +    if (ret) {
>> +        /* This can fail for an old kernel or legacy PCI dev */
>> +        trace_vfio_populate_device_get_irq_info_failure();
>> +    } else if (irq_info.count == 1) {
>> +        vdev->passive_reset = true;
>> +    } else {
>> +        error_report(WARN_PREFIX
>> +                     "Don't support passive reset notification",
>> +                     vbasedev->name);
> 
> when does this happen?
> what does this message mean?
> 

Both are boilerplate code as err_notifier. They will be triggered by
running latest QEMU on older kernel.  Will drop these code & the flags

>> +    }
>>  }
>>  
>>  static void vfio_put_device(VFIOPCIDevice *vdev)
>> @@ -2432,6 +2460,221 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>>      vfio_put_base_device(&vdev->vbasedev);
>>  }
>>  
>> +static void vfio_non_fatal_err_notifier_handler(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *dev = &vdev->pdev;
>> +    PCIEAERMsg msg = {
>> +        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
>> +        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
>> +    };
>> +
> 
> Should this just use pci_requester_id?
> 
> 
> At least Peter thought so.
> 
>> +    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
>> +        return;
>> +    }
>> +
>> +    /* Populate the aer msg and send it to root port */
>> +    if (dev->exp.aer_cap) {
>> +        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
>> +        uint32_t uncor_status;
>> +        bool isfatal;
>> +
>> +        uncor_status = vfio_pci_read_config(dev,
>> +                            dev->exp.aer_cap + PCI_ERR_UNCOR_STATUS, 4);
>> +        if (!uncor_status) {
>> +            return;
>> +        }
>> +
>> +        isfatal = uncor_status & pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
>> +        if (isfatal) {
>> +            goto stop;
>> +        }
>> +
>> +        error_report("%s sending non fatal event to root port. uncor status = "
>> +                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
>> +        pcie_aer_msg(dev, &msg);
>> +        return;
>> +    }
>> +
>> +stop:
>> +    /* Terminate the guest in case of fatal error */
>> +    error_report("%s(%s) fatal error detected. Please collect any data"
>> +            " possible and then kill the guest", __func__, vdev->vbasedev.name);
> 
> "Device detected a fatal error. VM stopped".
> 
> would be better IMO.
> 

Yes, user has no way to collect any data.

>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index 34e8b04..dcb0e0a 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -119,6 +119,8 @@ typedef struct VFIOPCIDevice {
>>      void *igd_opregion;
>>      PCIHostDeviceAddress host;
>>      EventNotifier err_notifier;
>> +    EventNotifier non_fatal_err_notifier;
>> +    EventNotifier passive_reset_notifier;
>>      EventNotifier req_notifier;
>>      int (*resetfn)(struct VFIOPCIDevice *);
>>      uint32_t vendor_id;
>> @@ -137,6 +139,8 @@ typedef struct VFIOPCIDevice {
>>      uint32_t igd_gms;
>>      uint8_t pm_cap;
>>      bool pci_aer;
>> +    bool pci_aer_non_fatal;
>> +    bool passive_reset;
>>      bool req_enabled;
>>      bool has_flr;
>>      bool has_pm_reset;
> 
> Why do you need these flags? Why isn't the notifier sufficient?
> 

sounds good. Will remove pci_aer also

-- 
Sincerely,
Cao jin
