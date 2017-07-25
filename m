Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZyNx-00073O-SV
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:52:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZyNu-0002JX-RU
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:52:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZyNu-0002JL-Kt
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:52:18 -0400
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-7-git-send-email-zuban32s@gmail.com>
	<20170724234138-mutt-send-email-mst@kernel.org>
	<CAKSfGUDf090V2Q=Vnpxq0S1o+Ho5gp63BKgkzmDMU=HDL7fGHA@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c3c38eb9-a229-431d-c2e6-fb78b4ad41bd@redhat.com>
Date: Tue, 25 Jul 2017 14:52:06 +0300
MIME-Version: 1.0
In-Reply-To: <CAKSfGUDf090V2Q=Vnpxq0S1o+Ho5gp63BKgkzmDMU=HDL7fGHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 6/6] hw/pci: add hint capabilty for
 additional bus reservation to pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexander Bezzubikov <zuban32s@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, seabios@seabios.org

On 25/07/2017 0:43, Alexander Bezzubikov wrote:
> 2017-07-24 23:43 GMT+03:00 Michael S. Tsirkin <mst@redhat.com>:
>> On Sun, Jul 23, 2017 at 01:15:43AM +0300, Aleksandr Bezzubikov wrote:
>>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>>> ---
>>>   hw/pci-bridge/pcie_root_port.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
>>> index b0e49e1..ca92d85 100644
>>> --- a/hw/pci-bridge/pcie_root_port.c
>>> +++ b/hw/pci-bridge/pcie_root_port.c
>>> @@ -106,6 +106,11 @@ static void rp_realize(PCIDevice *d, Error **errp)
>>>       pcie_aer_root_init(d);
>>>       rp_aer_vector_update(d);
>>>
>>> +    rc = pci_bridge_help_cap_init(d, 0, p->bus_reserve, 0, 0, 0, errp);
>>> +    if (rc < 0) {
>>> +        goto err;
>>> +    }
>>> +
>>>       return;
>>>
>>>   err:
>>
>> It looks like this will add the capability unconditionally to all
>> pcie root ports. Two issues with it:
>> 1. you can't add vendor properties to devices where vendor is
>>     not qemu as they might have their own concept of what it does.
>> 2. this will break compatibility with old machine types,
>>     need to disable for these
>>
> 
> Actually the original idea was to add it for pcie-root-port excusively
> (for now at least), looks like I've confused a little with files naming.

Right, for the Generic PCIe Root Port and not for all the root ports.
In the future we may want to add it to the PCI-brigde so we can have
nested bridges, but we are not there yet.

> Will add it for v3.
> 

Thanks,
Marcel

>>> --
>>> 2.7.4
> 
> 
> 
