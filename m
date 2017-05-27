Received: from eggs.gnu.org ([2001:4830:134:3::10]:51654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEVhi-0001ws-2F
	for qemu-devel@nongnu.org; Sat, 27 May 2017 03:00:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEVhe-0001B4-8N
	for qemu-devel@nongnu.org; Sat, 27 May 2017 03:00:01 -0400
Received: from [59.151.112.132] (port=36745 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dEVhd-0001Al-Rf
	for qemu-devel@nongnu.org; Sat, 27 May 2017 02:59:58 -0400
References: <20170526121516.6607-1-maozy.fnst@cn.fujitsu.com>
	<b98f7c09-257c-6d6f-fd25-7286f4d16eb2@redhat.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <5ab8c115-a8de-1d48-155a-3daac7e0d841@cn.fujitsu.com>
Date: Sat, 27 May 2017 14:58:37 +0800
MIME-Version: 1.0
In-Reply-To: <b98f7c09-257c-6d6f-fd25-7286f4d16eb2@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
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
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, armbru@redhat.com



On 05/26/2017 10:08 PM, Marcel Apfelbaum wrote:
>
>
> On 26/05/2017 15:15, Mao Zhongyi wrote:
>> The pci-birdge device i82801b11 still implements the old
>> PCIDeviceClass .init() through i82801b11_bridge_init()
>> instead of the new .realize(). All devices need to be
>> converted to .realize(). So convert it and rename it to
>> i82801b11_bridge_realize().
>>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
>>   hw/pci-bridge/i82801b11.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
>> index 2404e7e..dca3162 100644
>> --- a/hw/pci-bridge/i82801b11.c
>> +++ b/hw/pci-bridge/i82801b11.c
>> @@ -44,6 +44,7 @@
>>   #include "qemu/osdep.h"
>>   #include "hw/pci/pci.h"
>>   #include "hw/i386/ich9.h"
>> +#include "qapi/error.h"
>>       /*****************************************************************************/
>> @@ -58,7 +59,7 @@ typedef struct I82801b11Bridge {
>>       /*< public >*/
>>   } I82801b11Bridge;
>>   -static int i82801b11_bridge_initfn(PCIDevice *d)
>> +static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
>>   {
>>       int rc;
>>   @@ -70,12 +71,10 @@ static int i82801b11_bridge_initfn(PCIDevice *d)
>>           goto err_bridge;
>>       }
>>       pci_config_set_prog_interface(d->config, PCI_CLASS_BRIDGE_PCI_INF_SUB);
>> -    return 0;
>> +    return;
>>     err_bridge:
>>       pci_bridge_exitfn(d);
>
> Hi,
>
> Since you move to realize, you may want to leverage the errp to add
> info on errors.
>
> Thanks,
> Marcel


Hi, Marcel

Thanks for your quick reply and advice. In fact, I have considered adding an error
message to errp when an error occurs. But I found that pci_bridge_ssvid_init() has
reported a specific info when it fails. If the error is reported here again, it seems
a bit more superfluous, so it's not adopted. Of course, output a readable error info
to make it easier for users is also a good choice. So, are you sure you want to do
that?

Look forward to your feedback and suggestion soon.

Thanks a lot.
Mao



















>
