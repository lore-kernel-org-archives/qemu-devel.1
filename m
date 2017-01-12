Received: from eggs.gnu.org ([2001:4830:134:3::10]:49401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1cRgjk-00010v-S2
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:52:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1cRgjg-00019r-TT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 09:52:20 -0500
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
From: Laine Stump <laine@redhat.com>
Message-ID: <bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
Date: Thu, 12 Jan 2017 09:52:10 -0500
MIME-Version: 1.0
In-Reply-To: <1484217095.7948.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, libvir-list@redhat.com
Cc: thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 01/12/2017 05:31 AM, Andrea Bolognani wrote:
> On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
>>>>     * To allow for hotplugged devices, libvirt should also add a number
>>>>       of additional, empty vPHBs (the PAPR spec allows for hotplug of
>>>>       PHBs, but this is not yet implemented in qemu).
>>>
>>> "A number" here will have to mean "one", same number of
>>> empty PCIe Root Ports libvirt will add to a newly-defined
>>> q35 guest.
>>
>> Umm.. why?
>
> Because some applications using libvirt would inevitably
> start relying on the fact that such spare PHBs are
> available, locking us into providing at least the same
> number forever. In other words, increasing the amount at
> a later time is always possible, but decreasing it isn't.
> We did the same when we started automatically adding PCIe
> Root Ports to q35 machines.
>
> The rationale is that having a single spare hotpluggable
> slot is extremely convenient for basic usage, eg. a simple
> guest created by someone who's not necessarily very
> familiar with virtualization; on the other hand, if you
> are actually deploying in production you ought to conduct
> proper capacity planning and figure out in advance how
> many devices you're likely to need to hotplug throughout
> the guest's life.

And of course the reason we don't want to add "too many" extra 
controllers by default is so that we don't end up with *all* guests 
burdened with extra hardware they don't need or want. The libguestfs 
appliance is one example of a libvirt consumer that definitely doesn't 
want extra baggage in its guests - guest startup time is very important 
to libguestfs, so any addition to the hardware list is looked upon with 
disappointment.

>
> Of course this all will be moot once we can hotplug PHBs :)

Will the guest OSes handle that properly? I remember being told that 
Linux, for example, doesn't scan the new bus for devices when a new 
controller is added, making it pointless to hotplug a PCI controller (as 
usual, it could be that I'm remembering incorrectly...)
