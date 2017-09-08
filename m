Received: from eggs.gnu.org ([2001:4830:134:3::10]:48068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqAWq-0003JJ-PK
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqAWl-00017c-DM
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:04:28 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:38508)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dqAWl-00016D-4v
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 00:04:23 -0400
Received: by mail-pf0-x244.google.com with SMTP id q76so825089pfq.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 21:04:21 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907095142.GA2194@work-vm>
	<f83c81f0-7f4e-7518-750b-86eb84141d9b@ozlabs.ru>
	<20170907145403.GR2098@work-vm>
	<3b4eb5d7-a73a-b0b4-97d4-8033cc3aed8c@ozlabs.ru>
Message-ID: <31a8c1fc-c363-55c0-0811-6c5997911f4c@ozlabs.ru>
Date: Fri, 8 Sep 2017 14:04:15 +1000
MIME-Version: 1.0
In-Reply-To: <3b4eb5d7-a73a-b0b4-97d4-8033cc3aed8c@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH qemu 0/4] memory: Reduce memory use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

On 08/09/17 12:08, Alexey Kardashevskiy wrote:
> On 08/09/17 00:54, Dr. David Alan Gilbert wrote:
>> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
>>> On 07/09/17 19:51, Dr. David Alan Gilbert wrote:
>>>> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
>>>>> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
>>>>>
>>>>> What happens ithere is that every virtio block device creates 2 address
>>>>> spaces - for modern config space (called "virtio-pci-cfg-as") and
>>>>> for busmaster (common pci thing, called after the device name,
>>>>> in my case "virtio-blk-pci").
>>>>>
>>>>> Each address_space_init() updates topology for every address space.
>>>>> Every topology update (address_space_update_topology()) creates a new
>>>>> dispatch tree - AddressSpaceDispatch with nodes (1KB) and
>>>>> sections (48KB) and destroys the old one.
>>>>>
>>>>> However the dispatch destructor is postponed via RCU which does not
>>>>> get a chance to execute until the machine is initialized but before
>>>>> we get there, memory is not returned to the pool, and this is a lot
>>>>> of memory which grows n^2.
>>>>>
>>>>> These patches are trying to address the memory use and boot time
>>>>> issues but tbh only the first one provides visible outcome.
>>>>
>>>> Do you have a feel for how much memory is saved?
>>>
>>>
>>> The 1/4 saves ~33GB (~44GB -> 11GB) for a 2GB guest and 400 virtio-pci
>>> devices. These GB figures are the peak values (but it does not matter for
>>> OOM killer), memory gets released in one go when RCU kicks in, it just
>>> happens too late.
>>
>> Nice saving!  Still, why is it using 11GB?
> 
> Yet to be discovered :) Not clear at the moment.
> 
> 
>> What's it like for more sane configurations, say 2-3 virtio devices - is
>> there anything noticable or is it just the huge setups?
>>
>> Dave
>>
>>
>>> The 3/4 saves less, I'd say 50KB per VCPU (more if you count peaks but so
>>> much). Strangely, I do not see the difference in valgrind output when I run
>>> a guest with 1024 or just 8 CPUs, probably "massif" is not the right tool
>>> to catch this.
> 
> I did some more tests.
> 
> v2.10:
> 1024 CPUs, no virtio:     0:47   490.8MB   38/34
> 1 CPU, 500 virtio-block:  5:03   59.69GB   2354438/3
> 
> 1/4 applied:
> 1024 CPUs, no virtio:	  0:49   490.8MB   38/34
> 1 CPU, 500 virtio-block:  1:57   17.74GB   2186/3
> 
> 3/4 applied:
> 1024 CPUs, no virtio:     0:53   491.1MB   20/17
> 1 CPU, 500 virtio-block:  2:01    17.7GB   2167/0
> 
> 
> Time is what it takes to start QEMU with -S and then Q-Ax.
> 
> Memory amount is peak use from valgrind massif.
> 
> Last 2 numbers - "38/34" for example - 38 is the number of g_new(FlatView,
> 1), 34 is the number of g_free(view); the numbers are printed at
> https://git.qemu.org/?p=qemu.git;a=blob;f=vl.c;h=8e247cc2a239ae8fb3d3cdf6d4ee78fd723d1053;hb=1ab5eb4efb91a3d4569b0df6e824cc08ab4bd8ec#l4666
> before RCU kicks in.
> 
> 500 virtio-block + bridges use around 1100 address spaces.


Numbers are quite wrong for the [3/4] patch as
qemu_run_machine_init_done_notifiers() does the same dance all over again.

I can bring memory peak use down to 3.75GB (yay!) for "1 CPU, 500
virtio-block" with the below fix. It belongs to [1/4] and we might want
just extend that begin+commit to cover both devices creation and notifiers
initialization.

My guess that the general problem is that memory_region_transaction_begin()
and memory_region_transaction_commit() update all address spaces (or flat
views after [3/4] applied) while they do not really need to - they could
receive a hint (an AS? a flatview) and update only respective bits, I just
do not see an easy way to provide with a hint other than storing an AS
pointer in an MR.

In my test, I have 500 devices and 2 layers of PCI bridges. For every PCI
device probed by SLOF (our boot firmware), _all_ flatviews are rebuild 8
times (at least, sometime more, like 20, when a next bridge gets activated,
dunno):

- config space writes at 0x20 0x24 0x28 0x2c 0x1c - we end up in
pci_bridge_update_mappings();
- config space writes at 0x4 for a device and a bridge - pci_update_mappings();
- memory_region_set_enabled() on d->bus_master_enable_region
enable bridge.

Each of these operations re-renders all 1000-ish flatviews and dispatch
trees, making device probing really, really slow. But at least memory is
not sort of leaking or hold by RCU :) And I cannot wrap these config writes
into memory_region_transaction_begin/commit as every config space access
comes independently from SLOF.



diff --git a/vl.c b/vl.c
index 89fb58c1de..4317ef01b4 100644
--- a/vl.c
+++ b/vl.c
@@ -4754,8 +4754,13 @@ int main(int argc, char **argv, char **envp)
     /* TODO: once all bus devices are qdevified, this should be done
      * when bus is created by qdev.c */
     qemu_register_reset(qbus_reset_all_fn, sysbus_get_default());
+
+    memory_region_transaction_begin();
+
     qemu_run_machine_init_done_notifiers();

+    memory_region_transaction_commit();
+
     if (rom_check_and_register_reset() != 0) {
         error_report("rom check and register reset failed");
         exit(1);




> 
> 
> 
> 
> 
>>>
>>>>
>>>> Dave
>>>>
>>>>> There are still things to polish and double check the use of RCU,
>>>>> I'd like to get any feedback before proceeding - is this going
>>>>> the right way or way too ugly?
>>>>>
>>>>>
>>>>> This is based on sha1
>>>>> 1ab5eb4efb Peter Maydell "Update version for v2.10.0 release".
>>>>>
>>>>> Please comment. Thanks.
>>>>>
>>>>>
>>>>>
>>>>> Alexey Kardashevskiy (4):
>>>>>   memory: Postpone flatview and dispatch tree building till all devices
>>>>>     are added
>>>>>   memory: Prepare for shared flat views
>>>>>   memory: Share flat views and dispatch trees between address spaces
>>>>>   memory: Add flat views to HMP "info mtree"
>>>>>
>>>>>  include/exec/memory-internal.h |   6 +-
>>>>>  include/exec/memory.h          |  93 +++++++++----
>>>>>  exec.c                         | 242 +++++++++++++++++++--------------
>>>>>  hw/alpha/typhoon.c             |   2 +-
>>>>>  hw/dma/rc4030.c                |   4 +-
>>>>>  hw/i386/amd_iommu.c            |   2 +-
>>>>>  hw/i386/intel_iommu.c          |   9 +-
>>>>>  hw/intc/openpic_kvm.c          |   2 +-
>>>>>  hw/pci-host/apb.c              |   2 +-
>>>>>  hw/pci/pci.c                   |   3 +-
>>>>>  hw/ppc/spapr_iommu.c           |   4 +-
>>>>>  hw/s390x/s390-pci-bus.c        |   2 +-
>>>>>  hw/vfio/common.c               |   6 +-
>>>>>  hw/virtio/vhost.c              |   6 +-
>>>>>  memory.c                       | 299 +++++++++++++++++++++++++++--------------
>>>>>  monitor.c                      |   3 +-
>>>>>  vl.c                           |   4 +
>>>>>  hmp-commands-info.hx           |   7 +-
>>>>>  18 files changed, 448 insertions(+), 248 deletions(-)
>>>>>
>>>>> -- 
>>>>> 2.11.0
>>>>>
>>>>>
>>>> --
>>>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>>>
>>>
>>>
>>> -- 
>>> Alexey
>> --
>> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>>
> 
> 


-- 
Alexey
