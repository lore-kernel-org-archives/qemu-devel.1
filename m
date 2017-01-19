Received: from eggs.gnu.org ([2001:4830:134:3::10]:35888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU5v3-0003kP-9x
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU5v0-0001hI-3F
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:09:57 -0500
Received: from [59.151.112.132] (port=42671 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cU5uz-0001fr-4a
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 01:09:54 -0500
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
	<20170118144321.38c984bf@t450s.home>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Message-ID: <5880598F.5010601@cn.fujitsu.com>
Date: Thu, 19 Jan 2017 14:15:43 +0800
MIME-Version: 1.0
In-Reply-To: <20170118144321.38c984bf@t450s.home>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v11 0/4] vfio-pci: pass non-fatal error
 to guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, izumi.taku@jp.fujitsu.com



On 01/19/2017 05:43 AM, Alex Williamson wrote:
> On Sat, 31 Dec 2016 17:13:04 +0800
> Cao jin <caoj.fnst@cn.fujitsu.com> wrote:
> 
>> As previous discussion suggest, we could take a step back to handle non-fatal
>> error first, this will make this patchset much more thinner, because we could
>> drop all the configuration restriction related patches.
>>
>> FYI: patch 1 has been cherry picked into another series, and wait to be merged
>> first, so this patchset can't compile in your host.
>>
>> v11 changelog:
>> 1. drop a bunch of code which check the configuration.
>> 2. modify patch 3 to handle non-fatal error only, fatal error still
>>    results in vm stop.
>>    Doesn't modify as suggestion "add another eventfd do distinguish fatal &
>>    non-fatal error", because 1st, user has the ability to distinguish them
>>    just from the uncorrectable error status; 2nd, for back compatible, e.g.
>>    an old user handle both error, rely on the current error eventfd.
>>
>> Test:
>> Test it with intel 82576 NIC, which has 2 functions, function 1 has cable
>> connected to gateway, function 0 has no link. Test in 4 scenario.
>> 1. just assign function 1 to one vm, function 0 has no user
>> 2. assign 2 function to one vm, totally comply previous configuraton restrction
>> 3. assign 2 function to one vm, under different virtual bus
>> 4, assign functions to 2 different vm
>>
>> The test steps are the same as v10: assign ip to function 1, add route info,
>> and ping the gateway. The results meet expectation. But the unsteady hardware
>> often emit fatal error, still don't know why. And igb driver in guest seems
>> has bug: ping gateway for a while, even if I don't do anything, it will show
>> "Destination Host Unreachable" after many successful ping. But obviously,
>> neither of these has relationship with this patchset.
> 
> So something doesn't work right regardless and this doesn't describe
> what testing was done of the functionality added here.  Were AER events
> injected?  Did fatal ones cause a vmstop, did non-fatal ones continue?
> How can you know if he other function was affected if you don't even
> have a cable connected?  How is testing on something that doesn't seem
> to work correctly already valid?  Thanks,
> 
> Alex
> 

Well, of course I test the functionality added here via aer-inject tool
& driver, the same test as I did in v10. The unsteady hardware slows my
test, make me did the test again & again & again, until see what I
expected, maybe I should share some details.

General test steps(linux only)
  * assign ip to function 1 in guest, add route info, and ping the gateway
  * on host, injecting various non fatal error to both devices.
    Robustness test is: fast repeat injecting manually.

Expectation: in all scenario, function 1 who is pinging still works
after non fatal error recovery; function 0(in host, same guest, another
guest) doesn't have any abnormal phenomenon(crash guest, or any abnormal
log in dmesg); fatal error cause a vmstop(surely)

I did the test in each scenario, and I got what I expected: fatal error
definitely cause a vmstop; even bothered by unsteady hardware, non fatal
error recovery is ok

IIRC, in test of v10, I even find that the NIC would emit the fatal
error after I reboot the host, before I start vm.  This is what I called
unsteady hardware(I will try to figure out on which scenario the
hardware is easy to be unsteady). So I think, something doesn't work
right, but in my opinion, none of this patchset's business.

-- 
Sincerely,
Cao jin

>> Chen Fan (3):
>>   vfio: new function to init aer cap for vfio device
>>   vfio-pci: pass the aer error to guest
>>   vfio: add 'aer' property to expose aercap
>>
>> Dou Liyang (1):
>>   pcie_aer: support configurable AER capa version
>>
>>  hw/net/e1000e.c                    |   3 +-
>>  hw/pci-bridge/ioh3420.c            |   2 +-
>>  hw/pci-bridge/xio3130_downstream.c |   2 +-
>>  hw/pci-bridge/xio3130_upstream.c   |   2 +-
>>  hw/pci/pcie_aer.c                  |   5 +-
>>  hw/vfio/pci.c                      | 139 +++++++++++++++++++++++++++++++++----
>>  hw/vfio/pci.h                      |   3 +
>>  include/hw/pci/pcie_aer.h          |   3 +-
>>  8 files changed, 139 insertions(+), 20 deletions(-)
>>
> 
> 
> 
> .
> 
