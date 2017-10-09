Received: from eggs.gnu.org ([2001:4830:134:3::10]:57209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1c9k-00073W-Fi
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1c9j-0005zv-Kc
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:47:56 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:53122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1c9j-0005zY-EX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:47:55 -0400
Received: by mail-wm0-x236.google.com with SMTP id k4so25625381wmc.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:47:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-16-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-16-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:47:33 +0100
Message-ID: <CAFEAcA-BfvNFMFpiQd-XwGPYGasV3D-w3oDcqfHRoAXOAT17Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> The VirtMachineState contains some dt phandles that will be used
> in some node creation functions. For instance we plan to use the
> PCI host controller phandle in the smmu node creation function. So
> let's pass the VirtMachineState handle down to the node creation
> functions by enhancing the involved datatypes.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/sysbus-fdt.c         | 3 +++
>  hw/arm/virt.c               | 1 +
>  include/hw/arm/sysbus-fdt.h | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index d68e3dc..d92a983 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -36,6 +36,7 @@
>  #include "hw/vfio/vfio-platform.h"
>  #include "hw/vfio/vfio-calxeda-xgmac.h"
>  #include "hw/vfio/vfio-amd-xgbe.h"
> +#include "hw/arm/virt.h"
>  #include "hw/arm/fdt.h"
>
>  /*
> @@ -47,6 +48,7 @@ typedef struct PlatformBusFDTData {
>      int irq_start; /* index of the first IRQ usable by platform bus devices */
>      const char *pbus_node_name; /* name of the platform bus node */
>      PlatformBusDevice *pbus;
> +    VirtMachineState *vms;
>  } PlatformBusFDTData;

sysbus-fdt isn't virt specific, so this doesn't belong here.

More generally, why is sysbus-fdt involved in this at all?
I expected that instantiating and wiring up the SMMU would
be the job of hw/arm/virt.c, like any other device we
might have on the board.

thanks
-- PMM
