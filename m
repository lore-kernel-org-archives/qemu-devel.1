Received: from eggs.gnu.org ([2001:4830:134:3::10]:48286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFFSY-0007J1-9j
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dFFSU-0001US-DS
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:51:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dFFSU-0001UB-4N
	for qemu-devel@nongnu.org; Mon, 29 May 2017 03:51:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170526082925.2888-1-maozy.fnst@cn.fujitsu.com>
	<20170526114320.63f4f0b3@nial.brq.redhat.com>
Date: Mon, 29 May 2017 09:51:14 +0200
In-Reply-To: <20170526114320.63f4f0b3@nial.brq.redhat.com> (Igor Mammedov's
	message of "Fri, 26 May 2017 11:43:20 +0200")
Message-ID: <87y3tgayod.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] pci: Set err to errp directly rather than
 through error_porpagate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, marcel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

Igor Mammedov <imammedo@redhat.com> writes:

> On Fri, 26 May 2017 16:29:25 +0800
> Mao Zhongyi <maozy.fnst@cn.fujitsu.com> wrote:
>
>> ioh3420_interrupts_init() and its callers, rp_realize() and
>> pci_qdev_realize() fill error message to local_err, then
>> propagate it to errp by error_porpagate(), which's not necessary.
>> So eliminate it and pass errp directly instead of local_err.
>> Of course, error_propagate() also will be removed.
>> 
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> ---
> [...]
>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 98ccc27..0d4a3ff 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -1982,7 +1982,6 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>  {
>>      PCIDevice *pci_dev = (PCIDevice *)qdev;
>>      PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
>> -    Error *local_err = NULL;
>>      PCIBus *bus;
>>      bool is_default_rom;
>>  
>> @@ -1999,9 +1998,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>          return;
>>  
>>      if (pc->realize) {
>> -        pc->realize(pci_dev, &local_err);
>> -        if (local_err) {
>> -            error_propagate(errp, local_err);
>> +        pc->realize(pci_dev, errp);
>> +        if (errp && *errp) {
>>              do_pci_unregister_device(pci_dev);
>>              return;
>>          }
>> @@ -2014,9 +2012,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
>>          is_default_rom = true;
>>      }
>>  
>> -    pci_add_option_rom(pci_dev, is_default_rom, &local_err);
>> -    if (local_err) {
>> -        error_propagate(errp, local_err);
>> +    pci_add_option_rom(pci_dev, is_default_rom, errp);
>> +    if (errp && *errp) {
>>          pci_qdev_unrealize(DEVICE(pci_dev), NULL);
>>          return;
>>      }
>
> dropping local_error here looks wrong since it's used
> to check error status inside these functions and to undo
> side effects in case of failure.
>
> consider if caller pass errp = NULL
> then error handling path won't be executed.

Exactly.  The big comment in include/qapi/error.h explains this and
more.

> So keep the rest of the patch but drop above hunks. 
