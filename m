Received: from eggs.gnu.org ([209.51.188.92]:54746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghnFK-0001IM-7q
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 22:12:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghnFI-0003kW-D4
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 22:12:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:1328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ghnFE-0003h1-RN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 22:12:30 -0500
Date: Fri, 11 Jan 2019 11:08:45 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190111030845.GB634@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-14-yang.zhong@intel.com>
	<fa9d19df-c373-f647-a732-9fc76d9b2f4b@redhat.com>
	<20190108080426.GB27840@yangzhon-Virtual>
	<f5bb53e6-0ba0-57e5-f917-4c25ed53b562@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5bb53e6-0ba0-57e5-f917-4c25ed53b562@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 13/25] scsi: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

On Tue, Jan 08, 2019 at 12:42:06PM +0100, Paolo Bonzini wrote:
> On 08/01/19 09:04, Yang Zhong wrote:
> > On Fri, Jan 04, 2019 at 02:39:50PM +0100, Thomas Huth wrote:
> >> On 2018-12-27 07:34, Yang Zhong wrote:
> >>> From: Paolo Bonzini <pbonzini@redhat.com>
> >>>
> >>> This lets you disable SCSI altogether with "CONFIG_SCSI=n".
> >>>
> >>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >>> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> >>> ---
> >>>  hw/scsi/Kconfig       | 11 ++++++++++-
> >>>  hw/scsi/Makefile.objs |  2 +-
> >>>  2 files changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
> >>> index 6e7575397f..d669a4824e 100644
> >>> --- a/hw/scsi/Kconfig
> >>> +++ b/hw/scsi/Kconfig
> >>>  
> >>> -config PSERIES
> >>> +config SPAPR_VSCSI
> >>>      bool
> >>> +    select SCSI
> >>
> >> I think this should get "default y" and "depends on PSERIES" now.
> >>
> >>  Thomas
> > 
> >    Hello Thomas,
> > 
> >    I greped CONFIG_PSERIES from current Kconfig repo and got below list
> >   ./hw/net/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_llan.o
> >   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
> >   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
> >   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
> >   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> >   ./hw/ppc/Makefile.objs:ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
> >   ./hw/ppc/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
> >   ./hw/char/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_vty.o
> >   ./hw/nvram/Makefile.objs:obj-$(CONFIG_PSERIES) += spapr_nvram.o
> >   ./default-configs/ppc64-softmmu.mak:CONFIG_PSERIES=y
> >   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS=$(CONFIG_PSERIES)
> >   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS_SPAPR=$(CONFIG_PSERIES)
> >   ./default-configs/ppc64-softmmu.mak:CONFIG_XICS_KVM=$(call land,$(CONFIG_PSERIES),$(CONFIG_KVM))
> > 
> >   Since this time is only for x86 and i did not add Kconfig file in hw/ppc/, i did not add 
> >   this dependency too in here. 
> >   
> >   In previous plan, i will add "config PSERRIES" in hw/ppc/Kconfig file for PowerPC pSeries
> >   and will add dependency in that time, thanks.
> 
> You could skip the conversion to Kconfig of default-configs/, but
> already add all "source hw/ARCH/Kconfig" statements to hw/Kconfig and
> all "select" statements for buses.  Then, all machine types for example
> could start removing CONFIG_SCSI=y and CONFIG_PCI=y, even if you do not
> have the machines converted.
> 
  Hello Paolo,

  Okay, i will add extra patches for other machines and only keep ARCHs 
  dependency for default-configs/*-softmmu.mak in next stage.

  The new patches will include: 
   1) hw/ARCH/Makefile configurable
   2) Add Kconfig into hw/ARCH/
   3) convert bus, like pci, usb in other ARCHs

  Regards,

  Yang

> Paolo
