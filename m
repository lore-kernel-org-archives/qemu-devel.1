Received: from eggs.gnu.org ([209.51.188.92]:37883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1grbXE-0004Qv-Dm
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 23:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1grbX9-0008UN-2E
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 23:43:34 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:46271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1grbX8-0008Sy-Ay
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 23:43:30 -0500
Received: by mail-pl1-x644.google.com with SMTP id o6so4199704pls.13
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 20:43:25 -0800 (PST)
References: <20190117025115.81178-1-aik@ozlabs.ru>
	<fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <b82674e7-cc41-6bba-2f9e-9882bfd7afbd@ozlabs.ru>
Date: Thu, 7 Feb 2019 15:43:18 +1100
MIME-Version: 1.0
In-Reply-To: <fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu 0/3] spapr_pci,
 vfio: NVIDIA V100 + P9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>



On 07/02/2019 04:22, Daniel Henrique Barboza wrote:
> Based on this series, I've sent a Libvirt patch to allow a QEMU process
> to inherit IPC_LOCK when using VFIO passthrough with the Tesla V100
> GPU:
> 
> https://www.redhat.com/archives/libvir-list/2019-February/msg00219.html
> 
> 
> In that thread, Alex raised concerns about allowing QEMU to freely lock
> all the memory it wants. Is this an issue to be considered in the review
> of this series here?
> 
> Reading the patches, specially patch 3/3, it seems to me that QEMU is
> going to lock the KVM memory to populate the NUMA node with memory
> of the GPU itself, so at first there is no risk of not taking over the
> host RAM.
> Am I missing something?


The GPU memory belongs to the device and not visible to the host as
memory blocks and not covered by page structs, for the host it is more
like MMIO which is passed through to the guest without that locked
accounting, I'd expect libvirt to keep working as usual except that:

when libvirt calculates the amount of memory needed for TCE tables
(which is guestRAM/64k*8), now it needs to use the end of the last GPU
RAM window as a guest RAM size. For example, in QEMU HMP "info mtree -f":

FlatView #2
 AS "memory", root: system
 AS "cpu-memory-0", root: system
 Root memory region: system
  0000000000000000-000000007fffffff (prio 0, ram): ppc_spapr.ram
  0000010000000000-0000011fffffffff (prio 0, ram): nvlink2-mr

So previously the DMA window would cover 0x7fffffff+1, now it has to
cover 0x11fffffffff+1.


> 
> 
> Thanks,
> 
> 
> DHB
> 
> 
> On 1/17/19 12:51 AM, Alexey Kardashevskiy wrote:
>> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>>
>> This implements a subdriver for NVIDIA V100 GPU with coherent memory and
>> NPU/ATS support available in the POWER9 CPU.
>>
>> 1/3 is not strictly related but since new memory also needs to be mapped
>> to the 64bit DMA window and it is located quite high in the address space,
>> some adjustments are needed.
>>
>>
>> This is based on dwg/ppc-for-4.0 sha1 a0a8bff and requires headers update
>> from v5.0-rc1 staged by Paolo already.
>>
>> Please comment. Thanks.
>>
>>
>>
>> Alexey Kardashevskiy (3):
>>   vfio/spapr: Fix indirect levels calculation
>>   vfio: Make vfio_get_region_info_cap public
>>   spapr: Support NVIDIA V100 GPU with NVLink2
>>
>>  hw/vfio/pci.h                 |   2 +
>>  include/hw/pci-host/spapr.h   |   9 +
>>  include/hw/ppc/spapr.h        |   3 +-
>>  include/hw/vfio/vfio-common.h |   2 +
>>  hw/ppc/spapr.c                |  25 ++-
>>  hw/ppc/spapr_pci.c            | 333 +++++++++++++++++++++++++++++++++-
>>  hw/vfio/common.c              |   2 +-
>>  hw/vfio/pci-quirks.c          | 120 ++++++++++++
>>  hw/vfio/pci.c                 |  14 ++
>>  hw/vfio/spapr.c               |  38 +++-
>>  hw/vfio/trace-events          |   6 +-
>>  11 files changed, 539 insertions(+), 15 deletions(-)
>>
> 

-- 
Alexey
