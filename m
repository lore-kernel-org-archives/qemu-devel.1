Received: from eggs.gnu.org ([2001:4830:134:3::10]:43258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cH8Gn-0002EC-Lo
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cH8Gj-0005XV-Ho
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 07:02:49 -0500
References: <20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
	<491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
	<1481642137.17253.68.camel@kernel.crashing.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c6bc5786-f02b-69b2-ee9d-20be7cf1c98d@redhat.com>
Date: Wed, 14 Dec 2016 14:02:32 +0200
MIME-Version: 1.0
In-Reply-To: <1481642137.17253.68.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, Marcel Apfelbaum <mapfelba@redhat.com>

On 12/13/2016 05:15 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2016-12-13 at 14:25 +0200, Marcel Apfelbaum wrote:
>>>> Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
>>>> bridge came up before.  I think one of us spotted a problem with that,
>>>> but I don't recall what it was now.  I guess one is how libvirt would
>>>> map it's stupid-fake-domain-numbers to which root bus to use.
>>
>> This would be a weird configuration, I never heard of something like that
>> on a bare metal machine, but I never worked on pseries, who knows...
>
> That's the thing though, it's *not* bare metal ;-)
>
> On bare metal, we use the "powernv" platform for which we haven't yet upstreamed
> the PCIE support, but there we have real PCIe root ports with all what's exepcted
> on them.
>
> They come on physically different PHB, one root complex per PHB, but they are
> "proper" PCIe. Hotplug is a bit weird still because it has to go through some
> FW interactions as the HW doesn't use the PCIe standard slot control bits (and
> our qemu model doesn't handle it yet) but otherwise it's standard.
>

Thanks for the explanations, so bare metal is standard minus hotplug.

> "pseries" on the other hand is a paravirtualized platform. It's the environment
> presented to guests by our propritary hypervisor (PowerVM, aka pHyp) and
> KVM/qemu. I think there's a public spec these days but to cut the story short,
> it doesn't expose PCIe "properly" for bad historical reasons.
>
> It tends to hide the parent, ie, the root port for slots connected directly to
> a PHB or the entire hierarchy from the root to (and including) the downstream
> switch port for slots under as switch.
>
> So you end up with PCIe devices devoid of a proper "parent" which is a bit
> weird.
>

OK, now is more "clear". I can get back to read the thread from the start :)

Thanks,
Marcel

> Hotplug is implemented using specific firmware interfaces that are identical
> with pre-PCIe (ie PCI/PCI-X) systems. The FW has interface for supporting 3
> kinds of hotplug:
>
>    - Entire PHBs
>    - P2P Bridges
>    - Individual devices on an existing PHB or P2P bridge
>
> In practice these days mostly the first one is used for everything under pHyp,
> though I think we have a mix of 1 and 3 for KVM/qemu.
>
> Cheers,
> Ben.
>
