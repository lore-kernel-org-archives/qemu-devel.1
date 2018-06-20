Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fVUmE-0003th-1R
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fVUmA-00087c-1I
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:31:26 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:39625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fVUm9-00087H-QA
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 00:31:21 -0400
Received: by mail-wm0-x241.google.com with SMTP id p11-v6so4129821wmc.4
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 21:31:21 -0700 (PDT)
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
	<20180612163301-mutt-send-email-mst@kernel.org>
	<CAKwiv-jJbcuLgygcbSBkaZw33mnamHqa5T15gMNi2CqUNN2mkA@mail.gmail.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <1282a9a4-4ceb-626d-65ed-c6b0abe030a5@gmail.com>
Date: Wed, 20 Jun 2018 07:31:17 +0300
MIME-Version: 1.0
In-Reply-To: <CAKwiv-jJbcuLgygcbSBkaZw33mnamHqa5T15gMNi2CqUNN2mkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC v2 1/3] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org



On 06/13/2018 11:23 AM, Zihan Yang wrote:
> Michael S. Tsirkin <mst@redhat.com> 于2018年6月12日周二 下午9:43写道：
>> On Tue, Jun 12, 2018 at 05:13:22PM +0800, Zihan Yang wrote:
>>> The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by default,
>>> add a new type TYPE_PXB_PCIE_HOST to better utilize the ECAM of PCIe
>>>
>>> Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>> I have a concern that there are lots of new properties
>> added here, I'm not sure how are upper layers supposed to
>> manage them all.
>>
>> E.g. bus_nr supplied in several places, domain_nr for which
>> it's not clear how it is supposed to be allocated, etc.
> Indeed they seem to double the properties, but the pxb host is
> an internal structure of pxb-pcie device, created in pxb-pcie's
> realization procedure, and acpi-build queries host bridges instead
> of pxb-pcie devices. This means that users can not directly specify
> the property of pxb host bridge, but must 'inherit' from pxb-pcie
> devices. I had thought about changing the acpi-build process,
> but that would require more modifications.
>
> As for the properties, bus_nr means the start bus number
> of this host bridge. It is used when pxb-pcie is in pci domain 0
> with q35 host to avoid bus number confliction. When it is placed
> in a separate pci domain, it is not used and should be 0.
>
> max_bus means how many buses the user desires, EACH bus in
> PCIe requires 1MB configuration space, thus specifying it could
> reduce the reserved memory in MMCFG as suggested by Marcel.

The max_bus property is optional, you set the default to 255.
I am wondering if 255 is too much as a default for an extra bus,
I would use a smaller value, like 10.

> Typically, the user can specify
>
> -device pxb-pcie,id=br1,bus="pcie.0",sep_domain=on,domain_nr=1,max_bus=130
>
> this will place the buses under this pxb host bridge in pci domain
> 1, and reserve (130 + 1) = 131 buses for it. The start bus number
> is always 0 currently for simplicity.
>
>> Can the management interface be simplified?
>> Ideally we wouldn't have to teach libvirt new tricks,
>> just generalize pxb support slightly.
> We can delete 'sep_domain' property, I just find 'domain_nr'
> already indicates domain number.

Agreed, please remove sep_domain property.

Thanks,


> But domain_nr and
> max_bus seems unremovable, although they look 'redundant'
> because they appear twice.
>
> I'm not familiar with libvirt, but from the perspective of user,
> only 2 properties are added(domain_nr and max_bus, if we
> delete sep_domain), though the internal structure actually has
> changed.
