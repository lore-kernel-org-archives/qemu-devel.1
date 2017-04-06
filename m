Received: from eggs.gnu.org ([2001:4830:134:3::10]:37694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw52S-0005tk-RB
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cw52P-0000Lh-MG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:38870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cw52P-0000LS-AF
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 06:53:13 -0400
Date: Thu, 6 Apr 2017 18:53:09 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20170406105309.4yqkqo3itlhkuy5o@hz-desktop>
References: <20170331084147.32716-1-haozhong.zhang@intel.com>
	<20170331084147.32716-5-haozhong.zhang@intel.com>
	<20170406101356.GC21261@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170406101356.GC21261@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] nvdimm acpi: build flush hint
 address structure if required
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, dan.j.williams@intel.com, Richard Henderson <rth@twiddle.net>

On 04/06/17 11:13 +0100, Stefan Hajnoczi wrote:
> On Fri, Mar 31, 2017 at 04:41:47PM +0800, Haozhong Zhang wrote:
> > 
> > Add an boolean option 'flush-hint' to device 'nvdimm'. If it's on, a
> > flush hint address structure will be constructed for each nvdimm
> > device.
> 
> Users should not need to set the flush hint option.  NVDIMM
> configurations that persist data properly without Flush Hint Addresses
> shouldn't use them (for best performance).  Configurations that rely on
> flush hints *must* use them to guarantee data integrity.

It's for backwards compatibility, i.e. migrating a VM on QEMU w/o
flush hint support to another one w/ flush hint support. By using a
flush-hint option and making it disabled by default, users can ensure
both QEMU provide the same VM configuration.

Haozhong

> 
> I don't remember if there's a way to detect the configuration from host
> userspace, but we should focus on setting this correctly without
> requiring users to know which setting is necessary.
> 
> > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > ---
> >  hw/acpi/nvdimm.c        | 106 +++++++++++++++++++++++++++++++++++++++++++++---
> >  hw/i386/pc.c            |   5 ++-
> >  hw/mem/nvdimm.c         |  26 ++++++++++++
> >  include/hw/mem/nvdimm.h |   2 +-
> >  4 files changed, 132 insertions(+), 7 deletions(-)
> > 
> > diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> > index ea2ac3e..a7ff0b2 100644
> > --- a/hw/acpi/nvdimm.c
> > +++ b/hw/acpi/nvdimm.c
> > @@ -32,6 +32,8 @@
> >  #include "hw/acpi/bios-linker-loader.h"
> >  #include "hw/nvram/fw_cfg.h"
> >  #include "hw/mem/nvdimm.h"
> > +#include "exec/address-spaces.h"
> > +#include "qapi/error.h"
> >  
> >  static int nvdimm_device_list(Object *obj, void *opaque)
> >  {
> > @@ -168,6 +170,22 @@ struct NvdimmNfitControlRegion {
> >  typedef struct NvdimmNfitControlRegion NvdimmNfitControlRegion;
> >  
> >  /*
> > + * NVDIMM Flush Hint Address Structure
> > + *
> > + * It enables the data durability mechanism via ACPI.
> > + */
> > +struct NvdimmNfitFlushHintAddress {
> > +    uint16_t type;
> > +    uint16_t length;
> > +    uint32_t nfit_handle;
> > +    uint16_t nr_flush_hint_addr;
> > +    uint8_t  reserved[6];
> > +#define NR_FLUSH_HINT_ADDR 1
> > +    uint64_t flush_hint_addr[NR_FLUSH_HINT_ADDR];
> 
> How should the number of flush hints be set?  This patch hardcodes it to
> 1 but the Linux nvdimm drivers tries to balance between flush hint
> addresses to improve performance (to prevent cache line bouncing?).
> 
> > +} QEMU_PACKED;
> > +typedef struct NvdimmNfitFlushHintAddress NvdimmNfitFlushHintAddress;
> > +
> > +/*
> >   * Module serial number is a unique number for each device. We use the
> >   * slot id of NVDIMM device to generate this number so that each device
> >   * associates with a different number.
> > @@ -343,10 +361,79 @@ static void nvdimm_build_structure_dcr(GArray *structures, DeviceState *dev)
> >                                           (DSM) in DSM Spec Rev1.*/);
> >  }
> >  
> > -static GArray *nvdimm_build_device_structure(void)
> > +static uint64_t nvdimm_flush_hint_read(void *opaque, hwaddr addr, unsigned size)
> > +{
> > +    return 0;
> > +}
> > +
> > +static void nvdimm_flush_hint_write(void *opaque, hwaddr addr,
> > +                                    uint64_t data, unsigned size)
> > +{
> > +    nvdimm_debug("Write Flush Hint: offset 0x%"HWADDR_PRIx", data 0x%"PRIx64"\n",
> > +                 addr, data);
> > +    nvdimm_flush((NVDIMMDevice *)opaque);
> 
> C automatically casts void * to any other pointer type.  The cast is
> unnecessary.
