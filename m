Received: from eggs.gnu.org ([2001:4830:134:3::10]:47578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dtvsL-0001Bj-83
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dtvsG-0002YT-U4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:14:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dtvsG-0002Y8-Kq
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 09:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ACDD8753B3
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 13:14:07 +0000 (UTC)
Date: Mon, 18 Sep 2017 10:13:55 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170918131355.GI10621@localhost.localdomain>
References: <1505729649-11943-1-git-send-email-mgamal@redhat.com>
	<1505729649-11943-2-git-send-email-mgamal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1505729649-11943-2-git-send-email-mgamal@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] x86_iommu: Move machine check to
 x86_iommu_realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mohammed Gamal <mgamal@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, thuth@redhat.com, peterx@redhat.com, pbonzini@redhat.com

On Mon, Sep 18, 2017 at 12:14:08PM +0200, Mohammed Gamal wrote:
> Instead of having the same error checks in vtd_realize()
> and amdvi_realize(), move that over to the generic
> x86_iommu_realize().
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  hw/i386/amd_iommu.c   | 10 +---------
>  hw/i386/intel_iommu.c | 10 +---------
>  hw/i386/x86-iommu.c   | 12 ++++++++++++
>  3 files changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 334938a..839f01f 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1141,18 +1141,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>      AMDVIState *s = AMD_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>      MachineState *ms = MACHINE(qdev_get_machine());
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>      PCMachineState *pcms =
>          PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));

This is where you shouldn't use object_dynamic_cast() because the
code now expects pcms to never be NULL...

> -    PCIBus *bus;
> +    PCIBus *bus = pcms->bus;
>  
> -    if (!pcms) {
> -        error_setg(err, "Machine-type '%s' not supported by amd-iommu",
> -                   mc->name);
> -        return;
> -    }
> -
> -    bus = pcms->bus;
>      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
>                                       amdvi_uint64_equal, g_free, g_free);
>  
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3a5bb0b..aa01812 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3027,20 +3027,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>  static void vtd_realize(DeviceState *dev, Error **errp)
>  {
>      MachineState *ms = MACHINE(qdev_get_machine());
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
>      PCMachineState *pcms =
>          PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));

Same as above.

> -    PCIBus *bus;
> +    PCIBus *bus = pcms->bus;
>      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>  
> -    if (!pcms) {
> -        error_setg(errp, "Machine-type '%s' not supported by intel-iommu",
> -                   mc->name);
> -        return;
> -    }
> -
> -    bus = pcms->bus;
>      x86_iommu->type = TYPE_INTEL;
>  
>      if (!vtd_decide_config(s, errp)) {
> diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> index 293caf8..d43b08a 100644
> --- a/hw/i386/x86-iommu.c
> +++ b/hw/i386/x86-iommu.c
> @@ -21,6 +21,8 @@
>  #include "hw/sysbus.h"
>  #include "hw/boards.h"
>  #include "hw/i386/x86-iommu.h"
> +#include "hw/i386/pc.h"
> +#include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "trace.h"
>  
> @@ -80,7 +82,17 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
>  {
>      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
>      X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    PCMachineState *pcms = PC_MACHINE(ms);

And here is where you really need object_dynamic_cast(),
otherwise the "if (!pcms)" check below will be useless and you'll
get this:

  $ qemu-system-x86_64 -machine none -device intel-iommu
  qemu/hw/i386/x86-iommu.c:87:x86_iommu_realize: Object 0x53d7d02060 is not an instance of type generic-pc-machine
  Aborted (core dumped)


>      QLIST_INIT(&x86_iommu->iec_notifiers);
> +
> +    if (!pcms) {
> +        error_setg(errp, "Machine-type '%s' not supported by IOMMU",
> +                   mc->name);
> +        return;
> +    }
> +
>      if (x86_class->realize) {
>          x86_class->realize(dev, errp);
>      }
> -- 
> 1.8.3.1
> 

-- 
Eduardo
