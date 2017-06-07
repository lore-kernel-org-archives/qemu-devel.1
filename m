Received: from eggs.gnu.org ([2001:4830:134:3::10]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dITcn-000242-HF
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dITck-00064a-CI
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:35:21 -0400
Received: from [59.151.112.132] (port=55691 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dITci-00062w-QV
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 01:35:18 -0400
References: <cover.1496746390.git.maozy.fnst@cn.fujitsu.com>
	<3579e47c4bb41476406e26685292aaa9153fcc77.1496746391.git.maozy.fnst@cn.fujitsu.com>
	<20170606145250.GG5016@thinpad.lan.raisama.net>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <a6e6a698-ab28-b956-b13d-d75c9c203838@cn.fujitsu.com>
Date: Wed, 7 Jun 2017 13:33:51 +0800
MIME-Version: 1.0
In-Reply-To: <20170606145250.GG5016@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] pci: Make errp the last parameter
 of pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

Hi, Eduardo

On 06/06/2017 10:52 PM, Eduardo Habkost wrote:
> On Tue, Jun 06, 2017 at 07:26:30PM +0800, Mao Zhongyi wrote:
>> Add Error argument for pci_add_capability() to leverage the errp
>> to pass info on errors. This way is helpful for its callers to
>> make a better error handling when moving to 'realize'.
>>
>> Cc: pbonzini@redhat.com
>> Cc: rth@twiddle.net
>> Cc: ehabkost@redhat.com
>> Cc: mst@redhat.com
>> CC: dmitry@daynix.com
>> Cc: jasowang@redhat.com
>> Cc: marcel@redhat.com
>> Cc: alex.williamson@redhat.com
>> Cc: armbru@redhat.com
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
[...]
>
>
> There are multiple places below that checks for errors like this:
>
>     function(...);
>     if (function succeeded) {
>        /* non-error code path here */
>        foo = bar;
>     }
>
> Sometimes it even includes another branch for the error path:
>
>     function(...);
>     if (function succeeded) {
>        /* non-error code path here */
>        foo = bar;
>     } else {
>        /* error path here */
>        return ret;
>     }
>
> I suggest doing this instead, for readability:
>
>     function(...)
>     if (function failed) {
>        return ...;  /* or: "goto out" */
>     }
>
>     /* non-error code path here */
>     foo = bar;
>

Thank you very much for the detailed explanation，will use
this more elegant way to check return value in next version. :)


[...]
>>  static int
>>  e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>>  {
>> -    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF);
>> +    Error *local_err = NULL;
>> +    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
>> +                                 PCI_PM_SIZEOF, &local_err);
>>
>>      if (ret > 0) {
>>          pci_set_word(pdev->config + offset + PCI_PM_PMC,
>> @@ -386,6 +389,8 @@ e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>>
>>          pci_set_word(pdev->w1cmask + offset + PCI_PM_CTRL,
>>                       PCI_PM_CTRL_PME_STATUS);
>> +    } else {
>> +        error_report_err(local_err);
>>      }
>
>
> I suggest this instead:
>
>     int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
>                                  PCI_PM_SIZEOF, &local_err);
>     if (local_err) {
>         error_report_err(local_err);
>         return ret;
>     }
>
>     pci_set_word(...);
>     pci_set_word(...);
>     pci_set_word(...);
>     return ret;
>

OK, I see.

>
>>
>>
>>  /*****************************************************************************/
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index b73bfea..2bba37a 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2264,15 +2264,13 @@ static void pci_del_option_rom(PCIDevice *pdev)
>>   * in pci config space
>>   */
>>  int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
>> -                       uint8_t offset, uint8_t size)
>> +                       uint8_t offset, uint8_t size,
>> +                       Error **errp)
>>  {
>>      int ret;
>> -    Error *local_err = NULL;
>>
>> -    ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
>> -    if (ret < 0) {
>> -        error_report_err(local_err);
>> -    }
>> +    ret = pci_add_capability2(pdev, cap_id, offset, size, errp);
>> +
>>      return ret;
>>  }
>
> pci_add_capability() and pci_add_capability2() now do exactly the
> same, why are both being kept?  I suggest replacing
> pci_add_capability2() with pci_add_capability() everywhere (on a
> separate patch).
>

Completely remove pci_add_capability and direct use pci_add_capability2()
everywhere is it a more thorough way?

Thanks
Mao
