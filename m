Received: from eggs.gnu.org ([2001:4830:134:3::10]:39544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSwB-0007V1-LA
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:44:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSw7-0000Uz-4t
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:44:39 -0500
Received: from [59.151.112.132] (port=49754 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSw6-0000Tm-DL
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 01:44:35 -0500
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-4-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118153152.2869a1aa@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5881B332.5050508@cn.fujitsu.com>
Date: Fri, 20 Jan 2017 14:50:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170118153152.2869a1aa@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 3/4] vfio-pci: pass the aer error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>



On 01/19/2017 06:31 AM, Alex Williamson wrote:
> On Sat, 31 Dec 2016 17:13:07 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>>

>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 76a8ac3..9861f72 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2470,21 +2470,55 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
>>  static void vfio_err_notifier_handler(void *opaque)
>>  {
>>      VFIOPCIDevice *vdev = opaque;
>> +    PCIDevice *dev = &vdev->pdev;
>> +    PCIEAERMsg msg = {
>> +        .severity = 0,
>> +        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
>> +    };
>> +    int len;
>> +    uint64_t uncor_status;
>> +
>> +    /* Read uncorrectable error status from driver */
>> +    len = read(vdev->err_notifier.rfd, &uncor_status, sizeof(uncor_status));
> 
> Whoa this seems bogus.  In the kernel eventfd_signal() adds the value
> to the internal counter.  We can't guarantee that the user is going to
> immediately respond to every signal, multiple signals might occur, each
> incrementing the counter.  I don't think we can use the eventfd like
> this.
> 

Ah, got your concern, make sense. Michael had the same comments as you,
I didn't got him at that time...

I explained the reason in v10 cover letter(5 of changelog): I find that
error status register reading in error handler sometime returns ALL F's.
 I may want to take a look at v10, incorporate your comments, and test
to see if the issue still exists.  Currently if we only handle non-fatal
error, we can still use eventfd like before.

-- 
Sincerely,
Cao jin
>> +    if (len != sizeof(uncor_status)) {
>> +        error_report("vfio-pci: uncor error status reading returns"
>> +                     " invalid number of bytes: %d", len);
>> +        return; //Or goto stop?
> 
> It's bogus use of the eventfd anyway afaict, but
> event_notifier_test_and_clear() certainly handles at least EINTR.
> 
>> +    }
>> +
>> +    if (!(vdev->features & VFIO_FEATURE_ENABLE_AER)) {
>> +        goto stop;
>> +    }
> 
> I'm not sure this should be user selected anymore.
> 
>> +
>> +    /* Populate the aer msg and send it to root port */
>> +    if (dev->exp.aer_cap) {
>> +        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
>> +        bool isfatal = uncor_status &
>> +                       pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
>> +
>> +	if (isfatal) {
>> +	    goto stop;
>> +	}
> 
> QEMU uses spaces not tabs.
> 
>> +
>> +        msg.severity = isfatal ? PCI_ERR_ROOT_CMD_FATAL_EN :
>> +                                 PCI_ERR_ROOT_CMD_NONFATAL_EN;
> 
> We don't get here if isfatal.
> 
>>  
>> -    if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>> +        error_report("vfio-pci device %d sending AER to root port. uncor"
>> +                     " status = 0x%"PRIx64, dev->devfn, uncor_status);
>> +        pcie_aer_msg(dev, &msg);
>>          return;
>>      }
>>  
>> +stop:
>>      /*
>> -     * TBD. Retrieve the error details and decide what action
>> -     * needs to be taken. One of the actions could be to pass
>> -     * the error to the guest and have the guest driver recover
>> -     * from the error. This requires that PCIe capabilities be
>> -     * exposed to the guest. For now, we just terminate the
>> -     * guest to contain the error.
>> +     * Terminate the guest in case of
>> +     * 1. AER capability is not exposed to guest.
>> +     * 2. AER capability is exposed, but error is fatal, only non-fatal
>> +     * error is handled now.
> 
> You're also currently requiring the user to enable aer per device.
> 
>>       */
>>  
>> -    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>> +    error_report("%s(%s) fatal error detected. Please collect any data"
>> +            " possible and then kill the guest", __func__, vdev->vbasedev.name);
>>  
>>      vm_stop(RUN_STATE_INTERNAL_ERROR);
>>  }
> 
> 
> 
> .
> 
