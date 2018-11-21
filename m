Received: from eggs.gnu.org ([2001:4830:134:3::10]:45151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVKo-0000W9-7p
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gPVKk-0003XB-Sw
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:26:38 -0500
References: <20181120110427.7321-1-david@redhat.com>
	<12d77ab0-f846-56e9-dcbd-e6d19a108a62@redhat.com>
	<20181121082647-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ab1f6253-aebe-2c20-0bc2-b8f1d23c17b5@redhat.com>
Date: Wed, 21 Nov 2018 17:26:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181121082647-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/11] pci: hotplug handler reworks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org

On 21.11.18 14:28, Michael S. Tsirkin wrote:
> On Wed, Nov 21, 2018 at 01:43:05PM +0100, David Hildenbrand wrote:
>> On 20.11.18 12:04, David Hildenbrand wrote:
>>> This series reworks some pci hotplug handlers (except for s390, that will
>>> require more work but is not required for now).
>>>
>>> 1. Route all unplug calls via the hotplug handler when called from the
>>>    unplug_request handler. This will be required to get multi-stage
>>>    hotplug handlers running, but also makes sense on its own (just like we
>>>    already did for some CPU/memory hotplug handlers).
>>>
>>> 2. Introduce some pre_plug handlers where it makes sense already.
>>>
>>> 3. Call the plug/pre_plug handler also for coldplugged devices. Especially
>>>    pcihp is special as it overwrites hotplug handlers.
>>>
>>> This series will not yet factor out pre_plug/plug/unplug from pci device
>>> realize/unrealize functions, this will require more work but this
>>> series is also required first to get it running.
>>>
>>> In my opinion what needs to be done in the future:
>>> 1. Introduce pre_plug/plug/unplug_request/unplug handlers for all PCI
>>>    buses
>>> 2. Move pci realize/unrealize parts to pre_plug/pkug/unplug functions like
>>>    pci_pre_plug() ...
>>> 3. Call the pci pre_plug/plug/unplug handlers from the PCI bus hotplug
>>>    handler at the right spots
>>> 4. Factor more checks from existing plug() handlers out into pre_plug()
>>>    (e.g. after the call to pci_pre_plug())
>>>
>>> v2 -> v3:
>>> - Added "pci: Reuse pci-bridge hotplug handler handlers for pcie-pci-bridge"
>>> -- Use one handler callback for pcie and !pcie
>>> - "pci/shpc: perform unplug via the hotplug handler"
>>> -- Use one handler callback for pcie and !pcie
>>> -- Replace error check by an assertion
>>> - Minor description changes.
>>> - Added Rbs
>>>
>>> v1 -> v2:
>>> - Added "pci/pcie: rename hotplug handler callbacks"
>>> - Added "pci/shpc: rename hotplug handler callbacks"
>>> - Added "s390x/pci: rename hotplug handler callbacks"
>>> - Dropped "pci/shpc: move hotplug checks to preplug handler"
>>> -- We will have to factor out stuff into pre_plug() first as described
>>>    above
>>> - Renamed and added more details to the "perform unplug via the hotplug
>>>   handler" patches
>>> - "pci/pcihp: overwrite hotplug handler recursively from the start"
>>> -- Perform the overwrite only for cold plugged bridges, to keep the
>>>    existing behavior
>>>
>>> David Hildenbrand (11):
>>>   pci/pcie: rename hotplug handler callbacks
>>>   pci/shpc: rename hotplug handler callbacks
>>>   s390x/pci: rename hotplug handler callbacks
>>>   pci/pcie: stop plug/unplug if the slot is locked
>>>   pci/pcihp: perform check for bus capability in pre_plug handler
>>>   pci/pcihp: overwrite hotplug handler recursively from the start
>>>   pci/pcihp: perform unplug via the hotplug handler
>>>   pci/pcie: perform unplug via the hotplug handler
>>>   pci: Reuse pci-bridge hotplug handler handlers for pcie-pci-bridge
>>>   pci/shpc: perform unplug via the hotplug handler
>>>   spapr_pci: perform unplug via the hotplug handler
>>>
>>>  hw/acpi/pcihp.c                 | 47 ++++++++++++++++++++++++++++-----
>>>  hw/acpi/piix4.c                 | 39 ++++++++++++++-------------
>>>  hw/pci-bridge/pci_bridge_dev.c  | 31 ++++++++++++++--------
>>>  hw/pci-bridge/pcie_pci_bridge.c | 32 +++-------------------
>>>  hw/pci/pcie.c                   | 46 +++++++++++++++++++++-----------
>>>  hw/pci/pcie_port.c              |  6 +++--
>>>  hw/pci/shpc.c                   | 25 ++++++++++++------
>>>  hw/ppc/spapr_pci.c              | 33 ++++++++++++++---------
>>>  hw/s390x/s390-pci-bus.c         | 12 ++++-----
>>>  include/hw/acpi/pcihp.h         |  5 ++++
>>>  include/hw/pci/pci_bridge.h     |  6 +++++
>>>  include/hw/pci/pcie.h           | 12 ++++++---
>>>  include/hw/pci/shpc.h           | 10 ++++---
>>>  13 files changed, 187 insertions(+), 117 deletions(-)
>>>
>>
>> Seems like everything is reviewed and this is good to go. Anybody fancy
>> queuing this? (@mst?) Thanks!
> 
> Yes, thanks! But we are in freeze so please repost after the release and I will queue.

I know about the freeze, however some maintainers seem to be queue
patches already during the freeze. I can resend once we're working on
4.0 :) Thanks!

-- 

Thanks,

David / dhildenb
