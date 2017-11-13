Received: from eggs.gnu.org ([2001:4830:134:3::10]:52892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEENE-00088P-ID
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1eEEND-00072h-JN
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:02:00 -0500
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-16-git-send-email-eric.auger@redhat.com>
	<CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <40a0ece3-7498-0dda-9e13-234ba09bedf1@redhat.com>
Date: Mon, 13 Nov 2017 14:00:33 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 15/20] hw/arm/sysbus-fdt: Pass the
 VirtMachineState to the node creation functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

Hi Peter,

On 09/10/2017 19:47, Peter Maydell wrote:
> On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
>> The VirtMachineState contains some dt phandles that will be used
>> in some node creation functions. For instance we plan to use the
>> PCI host controller phandle in the smmu node creation function. So
>> let's pass the VirtMachineState handle down to the node creation
>> functions by enhancing the involved datatypes.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/sysbus-fdt.c         | 3 +++
>>  hw/arm/virt.c               | 1 +
>>  include/hw/arm/sysbus-fdt.h | 2 ++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
>> index d68e3dc..d92a983 100644
>> --- a/hw/arm/sysbus-fdt.c
>> +++ b/hw/arm/sysbus-fdt.c
>> @@ -36,6 +36,7 @@
>>  #include "hw/vfio/vfio-platform.h"
>>  #include "hw/vfio/vfio-calxeda-xgmac.h"
>>  #include "hw/vfio/vfio-amd-xgbe.h"
>> +#include "hw/arm/virt.h"
>>  #include "hw/arm/fdt.h"
>>
>>  /*
>> @@ -47,6 +48,7 @@ typedef struct PlatformBusFDTData {
>>      int irq_start; /* index of the first IRQ usable by platform bus devices */
>>      const char *pbus_node_name; /* name of the platform bus node */
>>      PlatformBusDevice *pbus;
>> +    VirtMachineState *vms;
>>  } PlatformBusFDTData;
> 
> sysbus-fdt isn't virt specific, so this doesn't belong here.
Correct. I plan to replace this by MachineState instead.
> 
> More generally, why is sysbus-fdt involved in this at all?
> I expected that instantiating and wiring up the SMMU would
> be the job of hw/arm/virt.c, like any other device we
> might have on the board.
I wished to have the same type of option as for x86 where
"-device intel-iommu" is passed to the QEMU command line. smmuv3 device
being a SysBusDevice, a natural framework to handle its node creation
function is sysbus-fdt. Having a -device approach is practical to pass
other options to the device (this was typically the case for the
"caching-mode" option). On Intel there are caching-mode, passthrough
(pt) options.

Although the smmu caching-mode option may not survive in this form, we
can foresee other options to come. In the future we may pass the PCI bus
number we want to plug the smmu into.

Also the invocation method would be identical for virtio-iommu.

I explored the other (and simpler) alternative of passing an option to
virt machine but I think this approach is less flexible. Also as you
pointed out, by default, smmu would be on, if we stick to the existing
convention. Given the perf overhead I don't think this is what we want.

Thanks

Eric
> 
> thanks
> -- PMM
> 
