Received: from eggs.gnu.org ([2001:4830:134:3::10]:40549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI36d-0006hS-IG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI36Z-0003Ir-Br
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:16:23 -0400
Received: from [59.151.112.132] (port=7586 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dI36Y-0003Ih-VD
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 21:16:19 -0400
References: <cover.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<135dd81b082d96b0a61e2e59d6b172d5eade0569.1496387804.git.maozy.fnst@cn.fujitsu.com>
	<1fc3b8d8-5571-6f74-11c1-a764a57b44b2@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <f923cf78-250b-bcf5-1377-bd01fb935f9b@cn.fujitsu.com>
Date: Tue, 6 Jun 2017 09:14:58 +0800
MIME-Version: 1.0
In-Reply-To: <1fc3b8d8-5571-6f74-11c1-a764a57b44b2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/6] pci: Fix the wrong return value
 judgment condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: dmitry@daynix.com, jasowang@redhat.com, alex.williamson@redhat.com, mst@redhat.com, armbru@redhat.com


Hi, Marcel

On 06/06/2017 12:20 AM, Marcel Apfelbaum wrote:
> On 02/06/2017 10:54, Mao Zhongyi wrote:
>> On success, pci_add_capability2() returns a positive value. On
>> failure, it sets an error and return a negative value. It doesn't
>> always return 0. So the judgment condtion of pci_add_capability2()
>> is wrong if it contains the situation where return value equal to
>> 0. Fix the error checks from its callers.
>>
>
> Hi,
> I would suggest changing the above to a simpler:
>
> pci_add_capability returns a strictly positive value on success,
> correct asserts.
>
> Thanks,
> Marcel

OK, I see.

Thanks a lot.
Mao

>
>> Cc: dmitry@daynix.com
>> Cc: jasowang@redhat.com
>> Cc: alex.williamson@redhat.com
>> Cc: marcel@redhat.com
>> Cc: mst@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>   hw/net/e1000e.c   | 2 +-
>>   hw/net/eepro100.c | 2 +-
>>   hw/vfio/pci.c     | 2 +-
>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
>> index 6e23493..8259d67 100644
>> --- a/hw/net/e1000e.c
>> +++ b/hw/net/e1000e.c
>> @@ -374,7 +374,7 @@ e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>>   {
>>       int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF);
>>   -    if (ret >= 0) {
>> +    if (ret > 0) {
>>           pci_set_word(pdev->config + offset + PCI_PM_PMC,
>>                        PCI_PM_CAP_VER_1_1 |
>>                        pmc);
>> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
>> index 4bf71f2..da36816 100644
>> --- a/hw/net/eepro100.c
>> +++ b/hw/net/eepro100.c
>> @@ -571,7 +571,7 @@ static void e100_pci_reset(EEPRO100State * s)
>>           int cfg_offset = 0xdc;
>>           int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
>>                                      cfg_offset, PCI_PM_SIZEOF);
>> -        assert(r >= 0);
>> +        assert(r > 0);
>>           pci_set_word(pci_conf + cfg_offset + PCI_PM_PMC, 0x7e21);
>>   #if 0 /* TODO: replace dummy code for power management emulation. */
>>           /* TODO: Power Management Control / Status. */
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 32aca77..5881968 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1744,7 +1744,7 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>>       }
>>         pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size);
>> -    if (pos >= 0) {
>> +    if (pos > 0) {
>>           vdev->pdev.exp.exp_cap = pos;
>>       }
>>
>
>
>
>
