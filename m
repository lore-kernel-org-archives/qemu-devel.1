Received: from eggs.gnu.org ([2001:4830:134:3::10]:44504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsk7-0005CO-Qp
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsk3-00073R-NJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:48:11 -0400
Received: from [59.151.112.132] (port=58000 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dFsk2-0006zE-Qx
	for qemu-devel@nongnu.org; Tue, 30 May 2017 21:48:07 -0400
References: <20170526121516.6607-1-maozy.fnst@cn.fujitsu.com>
	<b98f7c09-257c-6d6f-fd25-7286f4d16eb2@redhat.com>
	<5ab8c115-a8de-1d48-155a-3daac7e0d841@cn.fujitsu.com>
	<19dc61d7-9779-22a6-03cc-0eb718fe2875@redhat.com>
	<878tlf7v2i.fsf@dusky.pond.sub.org>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <fef8fbc3-712a-f640-842a-e0bc7a681cbb@cn.fujitsu.com>
Date: Wed, 31 May 2017 09:46:59 +0800
MIME-Version: 1.0
In-Reply-To: <878tlf7v2i.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pci-bridge/i82801b11: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

Hi, Marcel & Markus

On 05/29/2017 07:37 PM, Markus Armbruster wrote:
> Marcel Apfelbaum <marcel@redhat.com> writes:
>
>> On 27/05/2017 9:58, Mao Zhongyi wrote:
>>>
>>>
>>> On 05/26/2017 10:08 PM, Marcel Apfelbaum wrote:
>>>>
>>>>
>>>> On 26/05/2017 15:15, Mao Zhongyi wrote:
>>>>> The pci-birdge device i82801b11 still implements the old
>>>>> PCIDeviceClass .init() through i82801b11_bridge_init()
>>>>> instead of the new .realize(). All devices need to be
>>>>> converted to .realize(). So convert it and rename it to
>>>>> i82801b11_bridge_realize().
>>>>>
>>>>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>>>> ---
>>>>>   hw/pci-bridge/i82801b11.c | 9 ++++-----
>>>>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
>>>>> index 2404e7e..dca3162 100644
>>>>> --- a/hw/pci-bridge/i82801b11.c
>>>>> +++ b/hw/pci-bridge/i82801b11.c
>>>>> @@ -44,6 +44,7 @@
>>>>>   #include "qemu/osdep.h"
>>>>>   #include "hw/pci/pci.h"
>>>>>   #include "hw/i386/ich9.h"
>>>>> +#include "qapi/error.h"
>>>>> /*****************************************************************************/
>>>>> @@ -58,7 +59,7 @@ typedef struct I82801b11Bridge {
>>>>>       /*< public >*/
>>>>>   } I82801b11Bridge;
>>>>>   -static int i82801b11_bridge_initfn(PCIDevice *d)
>>>>> +static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
>>>>>   {
>>>>>       int rc;
>>>>>   @@ -70,12 +71,10 @@ static int i82801b11_bridge_initfn(PCIDevice *d)
>>>>>           goto err_bridge;
>>>>>       }
>>>>>       pci_config_set_prog_interface(d->config,
>>>>> PCI_CLASS_BRIDGE_PCI_INF_SUB);
>>>>> -    return 0;
>>>>> +    return;
>>>>>     err_bridge:
>>>>>       pci_bridge_exitfn(d);
>>>>
>>>> Hi,
>>>>
>>>> Since you move to realize, you may want to leverage the errp to add
>>>> info on errors.
>>>>
>>>> Thanks,
>>>> Marcel
>>>
>>>
>>> Hi, Marcel
>>>
>>
>> Hi!
>>> Thanks for your quick reply and advice. In fact, I have considered
>>> adding an error
>>> message to errp when an error occurs. But I found that
>>> pci_bridge_ssvid_init() has
>>> reported a specific info when it fails. If the error is reported
>>> here again, it seems
>>> a bit more superfluous, so it's not adopted.
>>
>> I agree we don't want to see the error twice, but that means we may want
>> to pass the error pointer to pci_bridge_ssvid_init and so on.
>
> Yes.
>
> Callees that report errors differently are a common issue when
> converting a function to Error.  The correct solution is to convert
> these callees to Error, too.
>
> Sometimes, this is just too much to be practical.  Then a "shallow"
> conversion can make sense as a stop-gap, even though it'll result in
> clearly inferior error reporting.
>
> At a glance, this one doesn't look impractical.
>
>> One of the main things we achieve when moving to 'realize' is better
>> error handling, so if we don't do that maybe is not worth it.
>
> We need to convert all devices to realize() so we can get rid of the old
> qdev methods.  But you're right in that we better convert them
> correctly.
>
>> You may need to do several changes you didn't intend to
>> in order to do the error propagation right...
>
> Yes.  An Error conversion can look simple at first, then balloon into a
> multi-part series.
>
>>
>> Thanks,
>> Marcel
>>
>>> Of course, output a readable error info
>>> to make it easier for users is also a good choice. So, are you sure
>>> you want to do
>>> that?
>>>
>>> Look forward to your feedback and suggestion soon.
>>>
>>> Thanks a lot.
>>> Mao
>
> Any help with converting the remaining devices to realize() is much
> appreciated.
>

Thanks for your detailed explanation, I think I know what to do.

Thanks,
Mao
