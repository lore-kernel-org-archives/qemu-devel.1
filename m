Received: from eggs.gnu.org ([2001:4830:134:3::10]:60352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwbl-0006T0-OF
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eqwbi-0003MD-M4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:57:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:1861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eqwbi-0003Ln-D8
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 02:56:58 -0500
Date: Wed, 28 Feb 2018 15:56:54 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
Message-ID: <20180228075654.gv22h2zd73peuyxm@hz-desktop>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
	<20171207101812.23602-4-haozhong.zhang@intel.com>
	<20180227164147.GB1799@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227164147.GB1799@perard.uk.xensource.com>
Subject: Re: [Qemu-devel] [RFC QEMU PATCH v4 03/10] hostmem-xen: add a host
 memory backend for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 02/27/18 16:41 +0000, Anthony PERARD wrote:
> On Thu, Dec 07, 2017 at 06:18:05PM +0800, Haozhong Zhang wrote:
> > diff --git a/backends/hostmem.c b/backends/hostmem.c
> > index ee2c2d5bfd..ba13a52994 100644
> > --- a/backends/hostmem.c
> > +++ b/backends/hostmem.c
> > @@ -12,6 +12,7 @@
> >  #include "qemu/osdep.h"
> >  #include "sysemu/hostmem.h"
> >  #include "hw/boards.h"
> > +#include "hw/xen/xen.h"
> >  #include "qapi/error.h"
> >  #include "qapi/visitor.h"
> >  #include "qapi-types.h"
> > @@ -277,6 +278,14 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
> >              goto out;
> >          }
> >  
> > +        /*
> > +         * The backend storage of MEMORY_BACKEND_XEN is managed by Xen,
> > +         * so no further work in this function is needed.
> > +         */
> > +        if (xen_enabled() && !backend->mr.ram_block) {
> > +            goto out;
> > +        }
> > +
> >          ptr = memory_region_get_ram_ptr(&backend->mr);
> >          sz = memory_region_size(&backend->mr);
> >  
> > diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> > index 66eace5a5c..dcbfce33d5 100644
> > --- a/hw/mem/pc-dimm.c
> > +++ b/hw/mem/pc-dimm.c
> > @@ -28,6 +28,7 @@
> >  #include "sysemu/kvm.h"
> >  #include "trace.h"
> >  #include "hw/virtio/vhost.h"
> > +#include "hw/xen/xen.h"
> >  
> >  typedef struct pc_dimms_capacity {
> >       uint64_t size;
> > @@ -108,7 +109,10 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
> >      }
> >  
> >      memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
> > -    vmstate_register_ram(vmstate_mr, dev);
> > +    /* memory-backend-xen is not backed by RAM. */
> > +    if (!xen_enabled()) {
> 
> Is it possible to have the same condition as the one used in
> host_memory_backend_memory_complete? i.e. base on whether the memory
> region is mapped or not (backend->mr.ram_block).

Like "if (!xen_enabled() || backend->mr.ram_block))"? No, it will mute
the abortion (vmstate_register_ram --> qemu_ram_set_idstr ) caused by
the case that !backend->mr.ram_block in the non-xen environment.

Haozhong

> 
> > +        vmstate_register_ram(vmstate_mr, dev);
> > +    }
> >      numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
> >  
> >  out:
> > -- 
> > 2.15.1
> > 
> 
> -- 
> Anthony PERARD
