Received: from eggs.gnu.org ([2001:4830:134:3::10]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrMG-0005Rj-86
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrMB-0006Z7-Ll
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:40:24 -0400
Received: from [59.151.112.132] (port=64958 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrMA-0006Xo-Jr
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:40:19 -0400
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161224.270f334e@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58DA69DD.2060203@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 21:49:17 +0800
MIME-Version: 1.0
In-Reply-To: <20170324161224.270f334e@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] vfio-pci: process non fatal error
 of AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com, Dou Liyang <douly.fnst@cn.fujitsu.com>



On 03/25/2017 06:12 AM, Alex Williamson wrote:
> On Thu, 23 Mar 2017 17:09:23 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> Make use of the non fatal error eventfd that the kernel module provide
>> to process the AER non fatal error. Fatal error still goes into the
>> legacy way which results in VM stop.
>>
>> Register the handler, wait for notification. Construct aer message and
>> pass it to root port on notification. Root port will trigger an interrupt
>> to signal guest, then guest driver will do the recovery.
> 
> Can we guarantee this is the better solution in all cases or could
> there be guests without AER support where the VM stop is the better
> solution?
> 

Currently, we only have VM stop on errors, that looks the same as a
sudden power down to me.  With this solution, we have about
50%(non-fatal) chance to reduce the sudden power-down risk.

What if a guest doesn't support AER?  It looks the same as a host
without AER support. Now I only can speculate the worst condition: guest
crash, would that be quite different from a sudden power-down?

>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/vfio/pci.c              | 202 +++++++++++++++++++++++++++++++++++++++++++++
>>  hw/vfio/pci.h              |   2 +
>>  linux-headers/linux/vfio.h |   2 +
>>  3 files changed, 206 insertions(+)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 3d0d005..c6786d5 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2432,6 +2432,200 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>>      vfio_put_base_device(&vdev->vbasedev);
>>  }
>>  
>> +static void vfio_non_fatal_err_notifier_handler(void *opaque)
>> +{
>> +    VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *dev = &vdev->pdev;
>> +    PCIEAERMsg msg = {
>> +        .severity = PCI_ERR_ROOT_CMD_NONFATAL_EN,
>> +        .source_id = pci_requester_id(dev),
>> +    };
>> +
>> +    if (!event_notifier_test_and_clear(&vdev->non_fatal_err_notifier)) {
>> +        return;
>> +    }
>> +
>> +    /* Populate the aer msg and send it to root port */
>> +    if (dev->exp.aer_cap) {
> 
> Why would we have registered this notifier otherwise?
> 
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
> 
> Huh?  How can we get a non-fatal error notice for a fatal error?  (and
> why are we saving this to a variable rather than testing it within the
> 'if' condition?
>

Both of these are for the unsure corner cases.
Is it possible that register reading shows a fatal error?
Saving it into a variable just is personal taste: more neat.

>> +
>> +        error_report("%s sending non fatal event to root port. uncor status = "
>> +                     "0x%"PRIx32, vdev->vbasedev.name, uncor_status);
>> +        pcie_aer_msg(dev, &msg);
>> +        return;
>> +    }
>> +
>> +stop:
>> +    /* Terminate the guest in case of fatal error */
>> +    error_report("%s: Device detected a fatal error. VM stopped",
>> +	    vdev->vbasedev.name);
>> +    vm_stop(RUN_STATE_INTERNAL_ERROR);
> 
> Shouldn't we use the existing error index if we can't make use of
> correctable errors?
> 

Why? If register reading shows it is actually a fatal error, is it the
same as fatal error handler is notified?  what we use the existing error
index for?


>> @@ -2860,6 +3054,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>          }
>>      }
>>  
>> +    vfio_register_passive_reset_notifier(vdev);
>> +    vfio_register_non_fatal_err_notifier(vdev);
> 
> I think it's wrong that we configure these unconditionally.  Why do we
> care about these unless we're configuring the guest to receive AER
> events?
> 

But do we have ways to know whether the guest has AER support? For now,
I don't think so.

If guest don't have AER support, for the worst condition: guest crash,
it is not worse than a sudden power-down.


-- 
Sincerely,
Cao jin
