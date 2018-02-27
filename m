Received: from eggs.gnu.org ([2001:4830:134:3::10]:51505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqimr-0004ez-T5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqimo-0005Or-OI
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:11:33 -0500
Received: from smtp.citrix.com ([66.165.176.89]:55862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5899da973=anthony.perard@citrix.com>)
	id 1eqimo-0005Ne-F7
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:11:30 -0500
Date: Tue, 27 Feb 2018 16:41:47 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180227164147.GB1799@perard.uk.xensource.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
	<20171207101812.23602-4-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171207101812.23602-4-haozhong.zhang@intel.com>
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
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Dec 07, 2017 at 06:18:05PM +0800, Haozhong Zhang wrote:
> diff --git a/backends/hostmem.c b/backends/hostmem.c
> index ee2c2d5bfd..ba13a52994 100644
> --- a/backends/hostmem.c
> +++ b/backends/hostmem.c
> @@ -12,6 +12,7 @@
>  #include "qemu/osdep.h"
>  #include "sysemu/hostmem.h"
>  #include "hw/boards.h"
> +#include "hw/xen/xen.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qapi-types.h"
> @@ -277,6 +278,14 @@ host_memory_backend_memory_complete(UserCreatable *uc, Error **errp)
>              goto out;
>          }
>  
> +        /*
> +         * The backend storage of MEMORY_BACKEND_XEN is managed by Xen,
> +         * so no further work in this function is needed.
> +         */
> +        if (xen_enabled() && !backend->mr.ram_block) {
> +            goto out;
> +        }
> +
>          ptr = memory_region_get_ram_ptr(&backend->mr);
>          sz = memory_region_size(&backend->mr);
>  
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 66eace5a5c..dcbfce33d5 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -28,6 +28,7 @@
>  #include "sysemu/kvm.h"
>  #include "trace.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/xen/xen.h"
>  
>  typedef struct pc_dimms_capacity {
>       uint64_t size;
> @@ -108,7 +109,10 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
>      }
>  
>      memory_region_add_subregion(&hpms->mr, addr - hpms->base, mr);
> -    vmstate_register_ram(vmstate_mr, dev);
> +    /* memory-backend-xen is not backed by RAM. */
> +    if (!xen_enabled()) {

Is it possible to have the same condition as the one used in
host_memory_backend_memory_complete? i.e. base on whether the memory
region is mapped or not (backend->mr.ram_block).

> +        vmstate_register_ram(vmstate_mr, dev);
> +    }
>      numa_set_mem_node_id(addr, memory_region_size(mr), dimm->node);
>  
>  out:
> -- 
> 2.15.1
> 

-- 
Anthony PERARD
