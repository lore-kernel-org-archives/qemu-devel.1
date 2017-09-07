Received: from eggs.gnu.org ([2001:4830:134:3::10]:33630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpy3A-0003mE-PH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:45:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpy32-0004fe-RA
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:45:00 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:37009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dpy32-0004ef-Ji
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 10:44:52 -0400
Received: by mail-pf0-x242.google.com with SMTP id a2so4601218pfj.4
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 07:44:51 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907095142.GA2194@work-vm>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f83c81f0-7f4e-7518-750b-86eb84141d9b@ozlabs.ru>
Date: Fri, 8 Sep 2017 00:44:45 +1000
MIME-Version: 1.0
In-Reply-To: <20170907095142.GA2194@work-vm>
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

On 07/09/17 19:51, Dr. David Alan Gilbert wrote:
> * Alexey Kardashevskiy (aik@ozlabs.ru) wrote:
>> This was inspired by https://bugzilla.redhat.com/show_bug.cgi?id=1481593
>>
>> What happens ithere is that every virtio block device creates 2 address
>> spaces - for modern config space (called "virtio-pci-cfg-as") and
>> for busmaster (common pci thing, called after the device name,
>> in my case "virtio-blk-pci").
>>
>> Each address_space_init() updates topology for every address space.
>> Every topology update (address_space_update_topology()) creates a new
>> dispatch tree - AddressSpaceDispatch with nodes (1KB) and
>> sections (48KB) and destroys the old one.
>>
>> However the dispatch destructor is postponed via RCU which does not
>> get a chance to execute until the machine is initialized but before
>> we get there, memory is not returned to the pool, and this is a lot
>> of memory which grows n^2.
>>
>> These patches are trying to address the memory use and boot time
>> issues but tbh only the first one provides visible outcome.
> 
> Do you have a feel for how much memory is saved?


The 1/4 saves ~33GB (~44GB -> 11GB) for a 2GB guest and 400 virtio-pci
devices. These GB figures are the peak values (but it does not matter for
OOM killer), memory gets released in one go when RCU kicks in, it just
happens too late.

The 3/4 saves less, I'd say 50KB per VCPU (more if you count peaks but so
much). Strangely, I do not see the difference in valgrind output when I run
a guest with 1024 or just 8 CPUs, probably "massif" is not the right tool
to catch this.

> 
> Dave
> 
>> There are still things to polish and double check the use of RCU,
>> I'd like to get any feedback before proceeding - is this going
>> the right way or way too ugly?
>>
>>
>> This is based on sha1
>> 1ab5eb4efb Peter Maydell "Update version for v2.10.0 release".
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (4):
>>   memory: Postpone flatview and dispatch tree building till all devices
>>     are added
>>   memory: Prepare for shared flat views
>>   memory: Share flat views and dispatch trees between address spaces
>>   memory: Add flat views to HMP "info mtree"
>>
>>  include/exec/memory-internal.h |   6 +-
>>  include/exec/memory.h          |  93 +++++++++----
>>  exec.c                         | 242 +++++++++++++++++++--------------
>>  hw/alpha/typhoon.c             |   2 +-
>>  hw/dma/rc4030.c                |   4 +-
>>  hw/i386/amd_iommu.c            |   2 +-
>>  hw/i386/intel_iommu.c          |   9 +-
>>  hw/intc/openpic_kvm.c          |   2 +-
>>  hw/pci-host/apb.c              |   2 +-
>>  hw/pci/pci.c                   |   3 +-
>>  hw/ppc/spapr_iommu.c           |   4 +-
>>  hw/s390x/s390-pci-bus.c        |   2 +-
>>  hw/vfio/common.c               |   6 +-
>>  hw/virtio/vhost.c              |   6 +-
>>  memory.c                       | 299 +++++++++++++++++++++++++++--------------
>>  monitor.c                      |   3 +-
>>  vl.c                           |   4 +
>>  hmp-commands-info.hx           |   7 +-
>>  18 files changed, 448 insertions(+), 248 deletions(-)
>>
>> -- 
>> 2.11.0
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


-- 
Alexey
