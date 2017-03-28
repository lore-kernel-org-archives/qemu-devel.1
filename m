Received: from eggs.gnu.org ([2001:4830:134:3::10]:60663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKa-0003yE-H7
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKV-0005l5-VY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:40 -0400
Received: from [59.151.112.132] (port=32314 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1csrKV-0005jo-Hn
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:38:35 -0400
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<1490260163-6157-2-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170324161230.5642283f@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <58DA6972.6020606@cn.fujitsu.com>
Date: Tue, 28 Mar 2017 21:47:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170324161230.5642283f@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] pcie aer: verify if AER
 functionality is available
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
> On Thu, 23 Mar 2017 17:09:21 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> For devices which support AER function, verify it can work or not in the
>> system:
>> 1. AER capable device is a PCIe device, it can't be plugged into PCI bus
>> 2. If root port doesn't support AER, then there is no need to expose the
>>    AER capability
>>
>> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
>> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
>> ---
>>  hw/pci/pcie_aer.c | 28 ++++++++++++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
>> index daf1f65..a2e9818 100644
>> --- a/hw/pci/pcie_aer.c
>> +++ b/hw/pci/pcie_aer.c
>> @@ -100,6 +100,34 @@ static void aer_log_clear_all_err(PCIEAERLog *aer_log)
>>  int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
>>                    uint16_t size, Error **errp)
>>  {
>> +    PCIDevice *parent_dev;
>> +    uint8_t type;
>> +    uint8_t parent_type;
>> +
>> +    /* Topology test: see if there is need to expose AER cap */
>> +    type = pcie_cap_get_type(dev);
>> +    parent_dev = pci_bridge_get_device(dev->bus);
>> +    while (parent_dev) {
>> +        parent_type = pcie_cap_get_type(parent_dev);
>> +
>> +        if (type == PCI_EXP_TYPE_ENDPOINT &&
>> +                (parent_type != PCI_EXP_TYPE_ROOT_PORT &&
>> +                 parent_type != PCI_EXP_TYPE_DOWNSTREAM)) {
>> +            error_setg(errp, "Parent device is not a PCIe component");
>> +            return -ENOTSUP;
>> +        }
>> +        
>> +        if (parent_type == PCI_EXP_TYPE_ROOT_PORT) {
>> +            if (!parent_dev->exp.aer_cap)
>> +            {
> 
> Curly brace at the end of the previous line.
> 
>> +                error_setg(errp, "Root port does not support AER");
>> +                return -ENOTSUP;
>> +            }
>> +        }
>> +
>> +        parent_dev = pci_bridge_get_device(parent_dev->bus);
>> +    }
>> +
>>      pcie_add_capability(dev, PCI_EXT_CAP_ID_ERR, cap_ver,
>>                          offset, size);
>>      dev->exp.aer_cap = offset;
> 
> This patch makes existing configurations including PCIe root ports,
> upstream ports, downstream ports, and e1000e fail if they do not meet
> this new configuration requirement.
> 

Yes, I noticed that e1000e could be realized on i440fx, which I think is
not possible in real world, like the commit log(1.) said.

But for those ports, what are the conditions they will fail with this patch?
-- 
Sincerely,
Cao jin
