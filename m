Received: from eggs.gnu.org ([2001:4830:134:3::10]:37864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXumq-0001dg-Sd
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dXumn-00089M-Nr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:37:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dXumn-00088I-E9
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 15:37:29 -0400
References: <1500470414-7911-1-git-send-email-zuban32s@gmail.com>
	<20170719135726.GG5722@char.us.oracle.com>
	<CAKSfGUDgtN+S=u_4S7-s1wUxt6fZtibLG+ZSX+qZ0d+9marXQQ@mail.gmail.com>
	<20170719181853.GC13096@char.us.oracle.com>
	<CAKSfGUCp=AFDjm24bMOpaSAA5FiDZXO0ZrBvuCp4wT+5EbhqDA@mail.gmail.com>
	<CAKSfGUC0SKK6A55pv=WoMdx9d5VuBFR8OHmUEm01zHiQbJ2S9g@mail.gmail.com>
	<20170719185603.GC13557@char.us.oracle.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <22d016f4-6766-3938-f440-166794b1dde3@redhat.com>
Date: Wed, 19 Jul 2017 22:37:23 +0300
MIME-Version: 1.0
In-Reply-To: <20170719185603.GC13557@char.us.oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Fwd: [RFC PATCH 0/2] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Alexander Bezzubikov <zuban32s@gmail.com>
Cc: qemu-devel@nongnu.org, seabios@seabios.org

On 19/07/2017 21:56, Konrad Rzeszutek Wilk wrote:
> On Wed, Jul 19, 2017 at 09:38:50PM +0300, Alexander Bezzubikov wrote:
>> 2017-07-19 21:18 GMT+03:00 Konrad Rzeszutek Wilk <konrad.wilk@oracle.c=
om>:
>>
>>> On Wed, Jul 19, 2017 at 05:14:41PM +0000, Alexander Bezzubikov wrote:
>>>> =D1=81=D1=80, 19 =D0=B8=D1=8E=D0=BB=D1=8F 2017 =D0=B3. =D0=B2 16:57,=
 Konrad Rzeszutek Wilk <
>>> konrad.wilk@oracle.com>:
>>>>
>>>>> On Wed, Jul 19, 2017 at 04:20:12PM +0300, Aleksandr Bezzubikov wrot=
e:
>>>>>> Now PCI bridges (and PCIE root port too) get a bus range number in
>>>>> system init,
>>>>>> basing on currently plugged devices. That's why when one wants to
>>>>> hotplug another bridge,
>>>>>> it needs his child bus, which the parent is unable to provide.
>>>>>
>>>>> Could you explain how you trigger this?
>>>>
>>>>
>>>> I'm trying to hot plug pcie-pci bridge into pcie root port, and Linu=
x
>>> says
>>>> 'cannot allocate bus number for device bla-bla'. This obviously does=
 not
>>>> allow me to use the bridge at all.
>>>>
>>>>>
>>>>>
>>>>>> The suggested workaround is to have vendor-specific capability in
>>> RedHat
>>>>> generic pcie-root-port
>>>>>> that contains number of additional bus to reserve on BIOS PCI init=
.
>>>>>
>>>>> But wouldn't the proper fix be for the PCI bridge to have the
>>> subordinate
>>>>> value be extended to fit more bus ranges?
>>>>
>>>>
>>>> What do you mean? This is what I'm trying to do. Do you suppose to g=
et
>>> rid
>>>> of vendor-specific cap and use original register value instead of it=
?
>>>
>>> I would suggest a simple fix - each bridge has a a number of bus devi=
ces
>>> it can use. You have up to 255 - so you split the number of northbrid=
ge
>>> numbers by the amount of NUMA nodes (if that is used) - so for exampl=
e
>>> if you have 4 NUMA nodes, each bridge would cover 63 bus numbers.
>>>
>>> Meaning the root bridge would cover 0->63 bus, 64->128, and so on.
>>> That gives you enough space to plug in your plugged in devices
>>> (up to 63).
>>>
>>> And if you need sub-briges then carve out a specific range.
>>>
>>

Hi Konrad,

>> The problem is that we don't know at the init moment how many subbridg=
es we
>> may need,
>=20

Is possible the explanation was not clear clear and led to
some miscommunication.

>                                                                        =
                                   =20
> And the explanation above does not either. It just setups at init time
> an range where you can plug in your new devices in. But in a more unifo=
rm
> way such that you can also utilize this with NUMA and _PXM topology
> in the future.
>=20

I fully agree with you and actually QEMU has already implemented the
exact idea you are describing here, its called a pxb/pxb-pci device,
that can be "bounded" to a specific NUMA node and has a subrange of bus
numbers dedicated to it.

However this problem is different. In a PCI Express machine you
can hotplug PCIe devices only into PCIe Root Ports (or switch
downstream ports, but not in current scope).

We want to be able to hotplug a PCIe-PCI bridge into a PCIe Root Port
so we can then hot-plug legacy PCI devices.

Since the PCIe Root Port is a type of PCI bridge, at boot time
it only gets the bus sub-range (primary bus,subordinate bus]
which is computed by firmware and leaves no bus number that
can be used by a hot-plugged pci-bridge. And this obviously
does not depend on how we arrange NUMA/proximities.

We are also not looking for a fix for a specific guest OS,
so reserving some extra bus-numbers it has minimal impact
on the system. I do agree the problem may be solved differently,
however we can't reach all guest OS vendors and ask them to
support an alternative solution in a reasonable time frame.

Thanks,
Marcel

>> and how deep the whole device tree will be. The key moment - PCI bridg=
e
>> hotplugging
>> needs either rescan all buses on each bridge device addition, or reser=
ve
>> space in advance during BIOS init.
>=20
> can all buses on each bridge device addition, or reserve
>                                                                        =
                                                             =20
> It is more complex than that - you may need to move devices that are
> below you. And Linux kernel (nor any other OS) can handle that.
> (They can during bootup)
>=20
>> In this series the second way was chosen.
>>
>>
>>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>> Aleksandr Bezzubikov (2):
>>>>>>    pci: add support for direct usage of bdf for capability lookup
>>>>>>    pci: enable RedHat pci bridges to reserve more buses
>>>>>>
>>>>>>   src/fw/pciinit.c   | 12 ++++++++++--
>>>>>>   src/hw/pcidevice.c | 24 ++++++++++++++++++++++++
>>>>>>   src/hw/pcidevice.h |  1 +
>>>>>>   3 files changed, 35 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 2.7.4
>>>>>>
>>>>>>
>>>>>
>>>> --
>>>> Alexander Bezzubikov
>>>
>>
>>
>>
>> --=20
>> Alexander Bezzubikov
