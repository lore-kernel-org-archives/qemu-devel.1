Received: from eggs.gnu.org ([2001:4830:134:3::10]:40640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnk8M-0008IP-5I
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnk8I-0000cO-7a
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:33:42 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:37729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnk8H-0000aY-V9
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:33:38 -0400
Received: by mail-ed1-x541.google.com with SMTP id b10-v6so2802680eds.4
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 05:33:37 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-4-e.emanuelegiuseppe@gmail.com>
	<938f8b05-a687-8595-5452-8ec5abf7414c@redhat.com>
	<1c703cc4-644b-1ba8-4ec2-8b58ada7028a@gmail.com>
	<050466ae-69e8-20cd-7484-7da7160deaa9@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <7a4ad181-f811-7feb-6178-b7d854e102b3@gmail.com>
Date: Thu, 9 Aug 2018 14:33:29 +0200
MIME-Version: 1.0
In-Reply-To: <050466ae-69e8-20cd-7484-7da7160deaa9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 03/34] tests/qgraph: pci-pc driver and
 interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>



On 08/09/2018 02:29 PM, Laurent Vivier wrote:
> On 09/08/2018 14:17, Emanuele wrote:
>>>> +    return TRUE;
>>>> +}
>>>> +
>>>> +QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>>>> +{
>>>> +    QPCIDevice *dev;
>>>> +
>>>> +    dev = g_malloc0(sizeof(*dev));
>>>> +
>>>> +    if (!qpci_device_set(dev, bus, devfn)) {
>>>>            g_free(dev);
>>>>            return NULL;
>>>>        }
>>>> @@ -66,6 +83,21 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
>>>>        return dev;
>>>>    }
>>>>    +void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress
>>>> *addr)
>>>> +{
>>>> +    uint16_t vendor_id, device_id;
>>>> +
>>>> +    if (!qpci_device_set(dev, bus, addr->devfn)) {
>>>> +        printf("PCI Device not found\n");
>>>> +        abort();
>>>> +    }
>>> so, here, you should use qpci_device_set() and qpci_device_available()...
>> I changed qpci_device_set to just set the fields, while
>> qpci_device_available simply is doing
>> {
>>      return qpci_config_readw(...) != 0xFFFF
>> }
>> Now both qpci_device_init and qpci_device_find call qpci_device_set, and
>> check that  qpci_device_available is not false, otherwise it will
>> trigger g_assert_not_reached().
>>>> +
>>>> +    vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>>> or you can only check vendor_id to see it is 0xffff or not...
>>>
>>>> +    device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>>>> +    g_assert(vendor_id == addr->vendor_id);
>>> that should be in fact detected by this g_assert().
>> since this case is covered by qpci_device_available, I don't think
>> there's the need to insert the assertion.
> What I mean is you don't need the qpci_device_available().
>
> The 0xffff case is detected by "g_assert(vendor_id == addr->vendor_id)".
>
> The functions could be:
>
> static void qpci_device_set(QPCIDevice *dev, QPCIBus *bus, int devfn)
> {
>       dev->bus = bus;
>       dev->devfn = devfn;
> }
>
> void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
> {
>      uint16_t vendor_id, device_id;
>
>      qpci_device_set(dev, bus, addr->devfn);
>
>      vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
>      device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
>      g_assert(vendor_id == addr->vendor_id);
>      g_assert(device_id == addr->device_id);
> }
Ok, makes sense for qpci_device_init, but I still need to perform that 
check for qpci_device_find.
Emanuele
