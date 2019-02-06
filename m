Received: from eggs.gnu.org ([209.51.188.92]:54497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1grQuZ-0006ja-Ae
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb413@gmail.com>) id 1grQuY-0000bD-7P
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 12:22:59 -0500
References: <20190117025115.81178-1-aik@ozlabs.ru>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <fbe0ca8e-4d52-d59c-4f8d-9a1f473a81df@gmail.com>
Date: Wed, 6 Feb 2019 15:22:28 -0200
MIME-Version: 1.0
In-Reply-To: <20190117025115.81178-1-aik@ozlabs.ru>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>

Based on this series, I've sent a Libvirt patch to allow a QEMU process
to inherit IPC_LOCK when using VFIO passthrough with the Tesla V100
GPU:

https://www.redhat.com/archives/libvir-list/2019-February/msg00219.html


In that thread, Alex raised concerns about allowing QEMU to freely lock
all the memory it wants. Is this an issue to be considered in the review
of this series here?

Reading the patches, specially patch 3/3, it seems to me that QEMU is
going to lock the KVM memory to populate the NUMA node with memory
of the GPU itself, so at first there is no risk of not taking over the 
host RAM.
Am I missing something?


Thanks,


DHB


On 1/17/19 12:51 AM, Alexey Kardashevskiy wrote:
> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
>
> This implements a subdriver for NVIDIA V100 GPU with coherent memory and
> NPU/ATS support available in the POWER9 CPU.
>
> 1/3 is not strictly related but since new memory also needs to be mapped
> to the 64bit DMA window and it is located quite high in the address space,
> some adjustments are needed.
>
>
> This is based on dwg/ppc-for-4.0 sha1 a0a8bff and requires headers update
> from v5.0-rc1 staged by Paolo already.
>
> Please comment. Thanks.
>
>
>
> Alexey Kardashevskiy (3):
>    vfio/spapr: Fix indirect levels calculation
>    vfio: Make vfio_get_region_info_cap public
>    spapr: Support NVIDIA V100 GPU with NVLink2
>
>   hw/vfio/pci.h                 |   2 +
>   include/hw/pci-host/spapr.h   |   9 +
>   include/hw/ppc/spapr.h        |   3 +-
>   include/hw/vfio/vfio-common.h |   2 +
>   hw/ppc/spapr.c                |  25 ++-
>   hw/ppc/spapr_pci.c            | 333 +++++++++++++++++++++++++++++++++-
>   hw/vfio/common.c              |   2 +-
>   hw/vfio/pci-quirks.c          | 120 ++++++++++++
>   hw/vfio/pci.c                 |  14 ++
>   hw/vfio/spapr.c               |  38 +++-
>   hw/vfio/trace-events          |   6 +-
>   11 files changed, 539 insertions(+), 15 deletions(-)
>
