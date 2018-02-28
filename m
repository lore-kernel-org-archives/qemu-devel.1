Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwvD-0002nc-LC
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwv9-0004RP-IR
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:17:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:33633)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqwv9-0004R4-7w
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 03:17:03 -0500
Date: Wed, 28 Feb 2018 16:16:59 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180228081659.ih5uidbrcctsdghy@hz-desktop>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
	<20171207101812.23602-6-haozhong.zhang@intel.com>
	<20180227164651.GC1799@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227164651.GC1799@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v4 05/10] xen-hvm: initialize
 fw_cfg interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 02/27/18 16:46 +0000, Anthony PERARD wrote:
> On Thu, Dec 07, 2017 at 06:18:07PM +0800, Haozhong Zhang wrote:
> > Xen is going to reuse QEMU to build ACPI of some devices (e.g., NFIT
> > and SSDT for NVDIMM) for HVM domains. The existing QEMU ACPI build
> > code requires a fw_cfg interface which will also be used to pass QEMU
> > built ACPI to Xen. Therefore, we need to initialize fw_cfg when any
> > ACPI is going to be built by QEMU.
> > 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/i386/xen/xen-hvm.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> > index fe01b7a025..4b29f4052b 100644
> > --- a/hw/i386/xen/xen-hvm.c
> > +++ b/hw/i386/xen/xen-hvm.c
> > @@ -14,6 +14,7 @@
> >  #include "hw/pci/pci.h"
> >  #include "hw/i386/pc.h"
> >  #include "hw/i386/apic-msidef.h"
> > +#include "hw/loader.h"
> >  #include "hw/xen/xen_common.h"
> >  #include "hw/xen/xen_backend.h"
> >  #include "qmp-commands.h"
> > @@ -1234,6 +1235,14 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
> >      xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
> >  }
> >  
> > +static void xen_fw_cfg_init(PCMachineState *pcms)
> > +{
> 
> The fw_cfg interface might already be initialized, it is used for
> "direct kernel boot" on hvm. It is initialized in xen_load_linux().
>

xen_hvm_init() --> xen_fw_cfg_init() are called before
xen_load_linux(). I'll add a check in xen_load_linux() to avoid
redoing fw_cfg_init_io and rom_set_fw.

Haozhong

> > +    FWCfgState *fw_cfg = fw_cfg_init_io(FW_CFG_IO_BASE);
> > +
> > +    rom_set_fw(fw_cfg);
> > +    pcms->fw_cfg = fw_cfg;
> > +}
> > +
> >  void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
> >  {
> >      int i, rc;
> > @@ -1384,6 +1393,9 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
> >  
> >      /* Disable ACPI build because Xen handles it */
> >      pcms->acpi_build_enabled = false;
> > +    if (pcms->acpi_build_enabled) {
> > +        xen_fw_cfg_init(pcms);
> > +    }
> >  
> >      return;
> >  
> > -- 
> > 2.15.1
> > 
> 
> -- 
> Anthony PERARD
