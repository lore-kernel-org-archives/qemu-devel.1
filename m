Received: from eggs.gnu.org ([2001:4830:134:3::10]:55118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1danN7-00023T-KM
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:18:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1danN4-0000BQ-D2
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:18:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1danN4-00007d-50
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 14:18:50 -0400
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<d0bd04f4-1ac4-0e3a-885f-2ceb6180f69a@redhat.com>
	<dfb9663b-c31b-2def-9df6-754fb18bb27f@redhat.com>
	<b3936955-d84a-d2ba-e1a0-3ca90547ece7@redhat.com>
	<c1502763-61e8-159a-4455-37e833ca5b6d@redhat.com>
	<2d20e129-cc89-7080-2862-757ce3147046@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <24a3ec8c-d7a6-8d47-2746-67a4c9f429a4@redhat.com>
Date: Thu, 27 Jul 2017 21:18:34 +0300
MIME-Version: 1.0
In-Reply-To: <2d20e129-cc89-7080-2862-757ce3147046@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/4] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, kraxel@redhat.com
Cc: seabios@seabios.org, kevin@koconnor.net, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On 26/07/2017 21:31, Laszlo Ersek wrote:
> On 07/26/17 18:22, Marcel Apfelbaum wrote:
>> On 26/07/2017 18:20, Laszlo Ersek wrote:
> 
> [snip]
> 
>>> However, what does the hot-pluggability of the PCIe-PCI bridge buy us?
>>> In other words, what does it buy us when we do not add the PCIe-PCI
>>> bridge immediately at guest startup, as an integrated device?
>>>   > Why is it a problem to "commit" in advance? I understand that we might
>>> not like the DMI-PCI bridge (due to it being legacy), but what speaks
>>> against cold-plugging the PCIe-PCI bridge either as an integrated device
>>> in pcie.0 (assuming that is permitted), or cold-plugging the PCIe-PCI
>>> bridge in a similarly cold-plugged PCIe root port?
>>>
>>
>> We want to keep Q35 clean, and for most cases we don't want any
>> legacy PCI stuff if not especially required.
>>
>>> I mean, in the cold-plugged case, you use up two bus numbers at the
>>> most, one for the root port, and another for the PCIe-PCI bridge. In the
>>> hot-plugged case, you have to start with the cold-plugged root port just
>>> the same (so that you can communicate the bus number reservation *at
>>> all*), and then reserve (= use up in advance) the bus number, the IO
>>> space, and the MMIO space(s). I don't see the difference; hot-plugging
>>> the PCIe-PCI bridge (= not committing in advance) doesn't seem to save
>>> any resources.
>>>
>>
>> Is not about resources, more about usage model.
>>
>>> I guess I would see a difference if we reserved more than one bus number
>>> in the hotplug case, namely in order to support recursive hotplug under
>>> the PCIe-PCI bridge. But, you confirmed that we intend to keep the flat
>>> hierarchy (ie the exercise is only for enabling legacy PCI endpoints,
>>> not for recursive hotplug).  The PCIe-PCI bridge isn't a device that
>>> does anything at all on its own, so why not just coldplug it? Its
>>> resources have to be reserved in advance anyway.
>>>
>>
>> Even if we prefer flat hierarchies, we should allow a sane nested
>> bridges configuration, so we will some times reserve more than one.
>>
>>> So, thus far I would say "just cold-plug the PCIe-PCI bridge at startup,
>>> possibly even make it an integrated device, and then you don't need to
>>> reserve bus numbers (and other apertures)".
>>>
>>> Where am I wrong?
>>>
>>
>> Nothing wrong, I am just looking for feature parity Q35 vs PC.
>> Users may want to continue using [nested] PCI bridges, and
>> we want the Q35 machine to be used by more users in order
>> to make it reliable faster, while keeping it clean by default.
>>
>> We had a discussion on this matter on last year KVM forum
>> and the hot-pluggable PCIe-PCI bridge was the general consensus.
> 
> OK. I don't want to question or go back on that consensus now; I'd just
> like to point out that all that you describe (nested bridges, and
> enabling legacy PCI with PCIe-PCI bridges, *on demand*) is still
> possible with cold-plugging.
> 
> I.e., the default setup of Q35 does not need to include legacy PCI
> bridges. It's just that the pre-launch configuration effort for a Q35
> user to *reserve* resources for legacy PCI is the exact same as the
> pre-launch configuration effort to *actually cold-plug* the bridge.
> 
> [snip]
> 
>>>>> The PI spec says,
>>>>>
>>>>>> [...] For all the root HPCs and the nonroot HPCs, call
>>>>>> EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding() to obtain the
>>>>>> amount of overallocation and add that amount to the requests from the
>>>>>> physical devices. Reprogram the bus numbers by taking into account the
>>>>>> bus resource padding information. [...]
>>>>>
>>>>> However, according to my interpretation of the source code, PciBusDxe
>>>>> does not consider bus number padding for non-root HPCs (which are "all"
>>>>> HPCs on QEMU).
>>>>>
>>>>
>>>> Theoretically speaking, it is possible to change the  behavior, right?
>>>
>>> Not just theoretically; in the past I have changed PciBusDxe -- it
>>> wouldn't identify QEMU's hotplug controllers (root port, downstream port
>>> etc) appropriately, and I managed to get some patches in. It's just that
>>> the less we understand the current code and the more intrusive/extensive
>>> the change is, the harder it is to sell the *idea*. PciBusDxe is
>>> platform-independent and shipped on many a physical system too.
>>>
>>
>> Understood, but from your explanation it sounds like the existings
>> callback sites(hooks) are enough.
> 
> That's the problem: they don't appear to, if you consider bus number
> reservations. The existing callback sites seem fine regarding IO and
> MMIO, but the only callback site that honors bus number reservation is
> limited to "root" (in the previously defined sense) hotplug controllers.
> 
> So this is something that will need investigation, and my most recent
> queries into the "hotplug preparation" parts of PciBusDxe indicate that
> those parts are quite... "forgotten". :) I guess this might be because
> on physical systems the level of PCI(e) hotpluggery that we plan to do
> is likely unheard of :)
> 

I admit is possible that it looks a little "crazy" on bare-metal,
but as long as we "color inside the lines" we are allowed to push
it a little :)

Thanks,
Marcel

> Thanks!
> Laszlo
> 
