Received: from eggs.gnu.org ([2001:4830:134:3::10]:53669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsr65-0000sn-JA
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:55:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dsr62-0008NU-Ac
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:55:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dsr61-0008LM-MY
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 09:55:54 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CE154A6FB
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 13:55:52 +0000 (UTC)
Date: Fri, 15 Sep 2017 21:55:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170915135543.GX3617@pxdev.xzpeter.org>
References: <1505474026-13151-1-git-send-email-mgamal@redhat.com>
	<1505474026-13151-2-git-send-email-mgamal@redhat.com>
	<20170915135223.GV3617@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170915135223.GV3617@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH 1/2] x86_iommu: Move machine check to
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, mst@redhat.com, thuth@redhat.com

On Fri, Sep 15, 2017 at 09:52:23PM +0800, Peter Xu wrote:
> On Fri, Sep 15, 2017 at 01:13:45PM +0200, Mohammed Gamal wrote:
> > Instead of having the same error checks in vtd_realize()
> > and amdvi_realize(), move that over to the generic
> > x86_iommu_realize().
> > 
> > Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> > ---
> >  hw/i386/amd_iommu.c   | 10 +---------
> >  hw/i386/intel_iommu.c | 10 +---------
> >  hw/i386/x86-iommu.c   | 13 +++++++++++++
> >  3 files changed, 15 insertions(+), 18 deletions(-)
> > 
> > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > index 334938a..839f01f 100644
> > --- a/hw/i386/amd_iommu.c
> > +++ b/hw/i386/amd_iommu.c
> > @@ -1141,18 +1141,10 @@ static void amdvi_realize(DeviceState *dev, Error **err)
> >      AMDVIState *s = AMD_IOMMU_DEVICE(dev);
> >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >      PCMachineState *pcms =
> >          PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
> > -    PCIBus *bus;
> > +    PCIBus *bus = pcms->bus;
> >  
> > -    if (!pcms) {
> > -        error_setg(err, "Machine-type '%s' not supported by amd-iommu",
> > -                   mc->name);
> > -        return;
> > -    }
> > -
> > -    bus = pcms->bus;
> >      s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> >                                       amdvi_uint64_equal, g_free, g_free);
> >  
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 3a5bb0b..aa01812 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -3027,20 +3027,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
> >  static void vtd_realize(DeviceState *dev, Error **errp)
> >  {
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> >      PCMachineState *pcms =
> >          PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
> > -    PCIBus *bus;
> > +    PCIBus *bus = pcms->bus;
> >      IntelIOMMUState *s = INTEL_IOMMU_DEVICE(dev);
> >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
> >  
> > -    if (!pcms) {
> > -        error_setg(errp, "Machine-type '%s' not supported by intel-iommu",
> > -                   mc->name);
> > -        return;
> > -    }
> > -
> > -    bus = pcms->bus;
> >      x86_iommu->type = TYPE_INTEL;
> >  
> >      if (!vtd_decide_config(s, errp)) {
> > diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
> > index 293caf8..4d17e1f 100644
> > --- a/hw/i386/x86-iommu.c
> > +++ b/hw/i386/x86-iommu.c
> > @@ -21,6 +21,8 @@
> >  #include "hw/sysbus.h"
> >  #include "hw/boards.h"
> >  #include "hw/i386/x86-iommu.h"
> > +#include "hw/i386/pc.h"
> > +#include "qapi/error.h"
> >  #include "qemu/error-report.h"
> >  #include "trace.h"
> >  
> > @@ -80,7 +82,18 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
> >  {
> >      X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(dev);
> >      X86IOMMUClass *x86_class = X86_IOMMU_GET_CLASS(dev);
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    PCMachineState *pcms =
> > +        PC_MACHINE(object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE));
> >      QLIST_INIT(&x86_iommu->iec_notifiers);
> > +
> > +    if (!pcms) {
> > +        error_setg(errp, "Machine-type '%s' not supported by iommu",
> 
> When moving it, maybe also fix the English? :)
> 
>   "Machine-type '%s' does not support IOMMU."

I was wrong.  I changed the correct thing into error.  E.g., ppc64
obviously supports IOMMU... Please ignore my comment and just pick my
r-b.  Sorry for the noise.

> 
> Otherwise:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Thanks,
> 
> > +                   mc->name);
> > +        return;
> > +    }
> > +
> >      if (x86_class->realize) {
> >          x86_class->realize(dev, errp);
> >      }
> > -- 
> > 1.8.3.1
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu
