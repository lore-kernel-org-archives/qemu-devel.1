Received: from eggs.gnu.org ([2001:4830:134:3::10]:34523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSCz-0000IC-01
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSCv-0005ZW-U5
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:57:57 -0500
Received: from [59.151.112.132] (port=22444 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cUSCu-0005X3-V8
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 00:57:53 -0500
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1483175588-17006-3-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118150957.63c38425@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5881A83E.3000803@cn.fujitsu.com>
Date: Fri, 20 Jan 2017 14:03:42 +0800
MIME-Version: 1.0
In-Reply-To: <20170118150957.63c38425@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 2/4] vfio: new function to init aer
 cap for vfio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>



On 01/19/2017 06:09 AM, Alex Williamson wrote:
> On Sat, 31 Dec 2016 17:13:06 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>>
>> Introduce new function to initilize AER capability registers
>> for vfio-pci device.
>>
>> Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/vfio/pci.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
>>  hw/vfio/pci.h |  3 +++
>>  2 files changed, 85 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index d7dbe0e..76a8ac3 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1851,18 +1851,81 @@ out:
>>      return 0;
>>  }
>>  
>> -static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
>> +static int vfio_setup_aer(VFIOPCIDevice *vdev, uint8_t cap_ver,
>> +                          int pos, uint16_t size, Error **errp)
>> +{
>> +    PCIDevice *pdev = &vdev->pdev;
>> +    PCIDevice *dev_iter;
>> +    uint8_t type;
>> +    uint32_t errcap;
>> +
>> +    /* In case the physical device has AER cap while user doesn't enable AER,
>> +     * still allocate the config space in the emulated device for AER */
> 
> Bad comment style
> 
> /*
>  * Multi-line comments should
>  * look like this.
>  */
> 
> /* Single line comments may look like this */
> 
> /* Muli-line comments may
>  * absolutely not look like this */
> 
>> +    if (!(vdev->features & VFIO_FEATURE_ENABLE_AER)) {
>> +        pcie_add_capability(pdev, PCI_EXT_CAP_ID_ERR,
>> +                            cap_ver, pos, size);
>> +        return 0;
>> +    }
>> +
>> +    dev_iter = pci_bridge_get_device(pdev->bus);
>> +    if (!dev_iter) {
>> +        goto error;
>> +    }
>> +
>> +    while (dev_iter) {
>> +        if (!pci_is_express(dev_iter)) {
>> +            goto error;
>> +        }
>> +
>> +        type = pcie_cap_get_type(dev_iter);
>> +        if ((type != PCI_EXP_TYPE_ROOT_PORT &&
>> +             type != PCI_EXP_TYPE_UPSTREAM &&
>> +             type != PCI_EXP_TYPE_DOWNSTREAM)) {
>> +            goto error;
>> +        }
>> +
>> +        if (!dev_iter->exp.aer_cap) {
>> +            goto error;
>> +        }
>> +
>> +        dev_iter = pci_bridge_get_device(dev_iter->bus);
>> +    }
>> +
>> +    errcap = vfio_pci_read_config(pdev, pos + PCI_ERR_CAP, 4);
>> +    /*
>> +     * The ability to record multiple headers is depending on
>> +     * the state of the Multiple Header Recording Capable bit and
>> +     * enabled by the Multiple Header Recording Enable bit.
>> +     */
>> +    if ((errcap & PCI_ERR_CAP_MHRC) &&
>> +        (errcap & PCI_ERR_CAP_MHRE)) {
>> +        pdev->exp.aer_log.log_max = PCIE_AER_LOG_MAX_DEFAULT;
>> +    } else {
>> +        pdev->exp.aer_log.log_max = 0;
>> +    }
>> +
>> +    pcie_cap_deverr_init(pdev);
>> +    return pcie_aer_init(pdev, cap_ver, pos, size);
>> +
>> +error:
>> +    error_setg(errp, "vfio: Unable to enable AER for device %s, parent bus "
>> +               "does not support AER signaling", vdev->vbasedev.name);
>> +    return -1;
> 
> If we're only handling non-fatal errors, should we place the burden on
> the user to know when to add the aer flag for the device or should we
> just enable it opportunistically as available?

If we only handle non-fatal error, It make sense to me that we don't
need aer property as a switch and enable aer opportunistically as
available, it is no harm.

But considering that:
1. non-fatal error support is incomplete AER functionality, so I think
make it defaults to off is reasonable.

2. we may support fatal error too in the future, that will bring the
configuration restriction we used before. In this condition, make it
defaults to off is your discussion result(I guess). If this is the
finally choice, adopt it a little earlier is acceptable?

3. from another perspective, if 'aer' property shows in the future once
we support fatal-error too, would it seems that the 'aer' property is
dedicated to fatal-error only?(of course we could make it as the switch
of both error at that time)

> Should pcie_aer_init() be the one testing the topology?  It doesn't
> seem vfio specific anymore.
>

It does is not vfio specific, but I guess not. Question: could a
aer-capable device plugged under certain (root/downstream)port that is
not aer-capable? the answer I think is YES. If topology testing is done
in pcie_aer_init(), that means the answer is NO.

-- 
Sincerely,
Cao jin
