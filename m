Received: from eggs.gnu.org ([2001:4830:134:3::10]:53359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceRVY-0005ic-LZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:14:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceRVV-0006Xl-EN
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:14:24 -0500
References: <95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
	<20170215014544.GC12369@umbus.fritz.box>
	<22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
	<20170216024842.GQ12369@umbus.fritz.box>
	<20170216032808.GR12369@umbus.fritz.box>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <255b322c-f294-4653-ee18-c549962445f5@redhat.com>
Date: Thu, 16 Feb 2017 21:14:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170216032808.GR12369@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on
 root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

On 02/16/2017 05:28 AM, David Gibson wrote:
> On Thu, Feb 16, 2017 at 01:48:42PM +1100, David Gibson wrote:
>> On Wed, Feb 15, 2017 at 04:59:33PM +0200, Marcel Apfelbaum wrote:
>>> On 02/15/2017 03:45 AM, David Gibson wrote:
>>>> On Tue, Feb 14, 2017 at 02:53:08PM +0200, Marcel Apfelbaum wrote:
>>>>> On 02/14/2017 06:15 AM, David Gibson wrote:
>>>>>> On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
>>>>>>> On 02/13/2017 06:33 AM, David Gibson wrote:
>>>>>>>> On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wrote:
>>>>>>>>> On 02/10/2017 02:37 AM, David Gibson wrote:
>>>>>>>>>> On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrote:
>>>>>>>>>>> On 02/09/17 05:16, David Gibson wrote:
>>>>>>>>>>>> On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek wrote:
>>>>>>>>>>>>> On 02/08/17 07:16, David Gibson wrote:
> [snip]
>>>>>   Which means that you can use it to
>>>>>> drive PCIe devices just fine.  "Bus level" PCIe extensions like AER
>>>>>> and PCIe standard hotplug won't work, but PAPR has its own mechanisms
>>>>>> for those (common between PCI and PCIe).
>>>>>>
>>>>>> I did float the idea of having the pseries PCI bus remain plain PCI
>>>>>> but with a special flag to allow PCIe devices to be attached to it
>>>>>> anyway.  It wasn't greeted with much enthusiasm..
>>>>>>
>>>>>
>>>>> Can you point me to the discussion please? It seems similar to what I proposed above.
>>>>
>>>> Sorry, I was misleading.  I think I just raised that idea with Andrea
>>>> and a few other people internally, not on one of the lists at large.
>>>>
>>>>> As you properly described it, is much closer to PCI then PCIe, even the only characteristic
>>>>> that makes it "a little" PCIe, the Extended Configuration Space support,
>>>>> is done with an alternative interface.
>>>>>
>>>>> I agree the PAPR bus is not PCIe.
>>>>
>>>> Ok, so if we take that direction, the question becomes how do we let
>>>> PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
>>>> "pci_bus_accepts_express()" function that will replace many, but not
>>>> all current uses of "pci_bus_is_express()"?
>>>>
>>>
>>> Sounds good and I think Eduardo is already working on exactly this
>>> idea, however he is on PTO now. It is better to synchronize with him.
>>
>> Ah, right.  Do you know when he'll be back?  This is semi-urgent for
>> Power.
>>
>>
>>>> Such a helper could maybe simplify the logic in virtio-pci (and XHCI?)
>>>> by returning false on an x86 root bus.
>>>>
>>>
>>> The rule would me more complicated. We don't want to completely remove the
>>> possibility to have PCIe devices as part of Root Complex. it seems
>>> like I am contradicting myself, but no).
>>> This is why we have guidelines and  not hard-coded policies.
>>> Also ,the QEMU way is to be more permissive. We provide guidelines and sane
>>> defaults, but we let the user to chose.
>>>
>>> Getting back to our problem, the rule would be:
>>> hybrid devices should be PCI or PCIe for a bus?
>>> PAPR bus should return 'PCIe' for hybrid devices.
>>> X86 bus should return 'PCIe' if not root.
>>
>> Ok.
>
> Wait, actually.. we have two possible directions to go, both of which
> have been mentioned in the thread, but I don't think we've settled on
> one:
>
> 1) Have pseries create a PCIe bus (as my first cut draft does).
>
> That should allow pure PCIe devices to appear either under a port or
> (more usually for PAPR) as "integrated endpoints".  In addition we'd
> need as suggested above a "pcie_hybrid_type()" function that would
> tell hybrid devices to also appear as PCIe rather than PCI.
>
> 2) Have pseries create a vanilla PCI bus (or a special PAPR PCI
>    variant)
>
> Appearing as vanilla PCI would in a number of ways more closely match
> the way PCI buses are handled on PAPR.  However, we still need to
> connect PCIe devices to it.  So we'd need some 'bus_accepts_pcie()'
> hook and use that (in place of pci_bus_is_express()) to determine both
> whether we can attach pure PCIe devices and that hybrid devices should
> appear as PCIe rather than plain PCI.
>
>
> Based on the immediately preceding discussion, I was leaning towards
> (2).  Is that your feeling as well?
>

On 02/16/2017 05:28 AM, David Gibson wrote:
 > On Thu, Feb 16, 2017 at 01:48:42PM +1100, David Gibson wrote:
 >> On Wed, Feb 15, 2017 at 04:59:33PM +0200, Marcel Apfelbaum wrote:
 >>> On 02/15/2017 03:45 AM, David Gibson wrote:
 >>>> On Tue, Feb 14, 2017 at 02:53:08PM +0200, Marcel Apfelbaum wrote:
 >>>>> On 02/14/2017 06:15 AM, David Gibson wrote:
 >>>>>> On Mon, Feb 13, 2017 at 12:14:23PM +0200, Marcel Apfelbaum wrote:
 >>>>>>> On 02/13/2017 06:33 AM, David Gibson wrote:
 >>>>>>>> On Sun, Feb 12, 2017 at 09:05:46PM +0200, Marcel Apfelbaum wrote:
 >>>>>>>>> On 02/10/2017 02:37 AM, David Gibson wrote:
 >>>>>>>>>> On Thu, Feb 09, 2017 at 10:04:47AM +0100, Laszlo Ersek wrote:
 >>>>>>>>>>> On 02/09/17 05:16, David Gibson wrote:
 >>>>>>>>>>>> On Wed, Feb 08, 2017 at 11:40:50AM +0100, Laszlo Ersek wrote:
 >>>>>>>>>>>>> On 02/08/17 07:16, David Gibson wrote:
 > [snip]
 >>>>>   Which means that you can use it to
 >>>>>> drive PCIe devices just fine.  "Bus level" PCIe extensions like AER
 >>>>>> and PCIe standard hotplug won't work, but PAPR has its own mechanisms
 >>>>>> for those (common between PCI and PCIe).
 >>>>>>
 >>>>>> I did float the idea of having the pseries PCI bus remain plain PCI
 >>>>>> but with a special flag to allow PCIe devices to be attached to it
 >>>>>> anyway.  It wasn't greeted with much enthusiasm..
 >>>>>>
 >>>>>
 >>>>> Can you point me to the discussion please? It seems similar to what I proposed above.
 >>>>
 >>>> Sorry, I was misleading.  I think I just raised that idea with Andrea
 >>>> and a few other people internally, not on one of the lists at large.
 >>>>
 >>>>> As you properly described it, is much closer to PCI then PCIe, even the only characteristic
 >>>>> that makes it "a little" PCIe, the Extended Configuration Space support,
 >>>>> is done with an alternative interface.
 >>>>>
 >>>>> I agree the PAPR bus is not PCIe.
 >>>>
 >>>> Ok, so if we take that direction, the question becomes how do we let
 >>>> PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
 >>>> "pci_bus_accepts_express()" function that will replace many, but not
 >>>> all current uses of "pci_bus_is_express()"?
 >>>>
 >>>
 >>> Sounds good and I think Eduardo is already working on exactly this
 >>> idea, however he is on PTO now. It is better to synchronize with him.
 >>
 >> Ah, right.  Do you know when he'll be back?  This is semi-urgent for
 >> Power.
 >>
 >>
 >>>> Such a helper could maybe simplify the logic in virtio-pci (and XHCI?)
 >>>> by returning false on an x86 root bus.
 >>>>
 >>>
 >>> The rule would me more complicated. We don't want to completely remove the
 >>> possibility to have PCIe devices as part of Root Complex. it seems
 >>> like I am contradicting myself, but no).
 >>> This is why we have guidelines and  not hard-coded policies.
 >>> Also ,the QEMU way is to be more permissive. We provide guidelines and sane
 >>> defaults, but we let the user to chose.
 >>>
 >>> Getting back to our problem, the rule would be:
 >>> hybrid devices should be PCI or PCIe for a bus?
 >>> PAPR bus should return 'PCIe' for hybrid devices.
 >>> X86 bus should return 'PCIe' if not root.
 >>
 >> Ok.
 >
 > Wait, actually.. we have two possible directions to go, both of which
 > have been mentioned in the thread, but I don't think we've settled on
 > one:
 >
 > 1) Have pseries create a PCIe bus (as my first cut draft does).
 >
 > That should allow pure PCIe devices to appear either under a port or
 > (more usually for PAPR) as "integrated endpoints".  In addition we'd
 > need as suggested above a "pcie_hybrid_type()" function that would
 > tell hybrid devices to also appear as PCIe rather than PCI.
 >
 > 2) Have pseries create a vanilla PCI bus (or a special PAPR PCI
 >    variant)
 >
 > Appearing as vanilla PCI would in a number of ways more closely match
 > the way PCI buses are handled on PAPR.  However, we still need to
 > connect PCIe devices to it.  So we'd need some 'bus_accepts_pcie()'
 > hook and use that (in place of pci_bus_is_express()) to determine both
 > whether we can attach pure PCIe devices and that hybrid devices should
 > appear as PCIe rather than plain PCI.
 >
 >
 > Based on the immediately preceding discussion, I was leaning towards
 > (2).  Is that your feeling as well?
 >

I also like option (2).

Thanks,
Marcel
