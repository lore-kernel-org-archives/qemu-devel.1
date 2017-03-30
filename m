Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctcsf-0006fM-2i
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctcsb-0007Gt-5l
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:25:01 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:4109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=2553b504f=anthony.perard@citrix.com>)
	id 1ctcsb-0007Bi-0N
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 12:24:57 -0400
Date: Thu, 30 Mar 2017 17:24:52 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20170330162452.GB1864@perard.uk.xensource.com>
References: <1489750157-17401-1-git-send-email-tianyu.lan@intel.com>
	<1489750157-17401-3-git-send-email-tianyu.lan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1489750157-17401-3-git-send-email-tianyu.lan@intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 2/4] Xen: add a dummy vIOMMU to
 create/destroy vIOMMU in Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: xen-devel@lists.xensource.com, qemu-devel@nongnu.org, chao.gao@intel.com, kevin.tian@intel.com, sstabellini@kernel.org

Hi,

On Fri, Mar 17, 2017 at 07:29:15PM +0800, Lan Tianyu wrote:
> From: Chao Gao <chao.gao@intel.com>
> 
> Since adding a dynamic sysbus device is forbidden, so choose TYPE_DEVICE
> as parent class.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  hw/xen/Makefile.objs |   1 +
>  hw/xen/xen_viommu.c  | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 117 insertions(+)
>  create mode 100644 hw/xen/xen_viommu.c
> 
> diff --git a/hw/xen/Makefile.objs b/hw/xen/Makefile.objs
> index d367094..e37d808 100644
> --- a/hw/xen/Makefile.objs
> +++ b/hw/xen/Makefile.objs
> @@ -3,3 +3,4 @@ common-obj-$(CONFIG_XEN_BACKEND) += xen_backend.o xen_devconfig.o
>  
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen-host-pci-device.o
>  obj-$(CONFIG_XEN_PCI_PASSTHROUGH) += xen_pt.o xen_pt_config_init.o xen_pt_graphics.o xen_pt_msi.o
> +obj-$(CONFIG_XEN) += xen_viommu.o
> diff --git a/hw/xen/xen_viommu.c b/hw/xen/xen_viommu.c
> new file mode 100644
> index 0000000..9bf9158
> --- /dev/null
> +++ b/hw/xen/xen_viommu.c
> @@ -0,0 +1,116 @@
> +/*
> + * Xen virtual IOMMU (virtual VT-D)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License along
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +
> +#include "hw/qdev-core.h"
> +#include "hw/sysbus.h"
> +#include "hw/xen/xen.h"
> +#include "hw/xen/xen_backend.h"
> +
> +#define TYPE_XEN_VIOMMU_DEVICE "xen_viommu"
> +#define  XEN_VIOMMU_DEVICE(obj) \
> +    OBJECT_CHECK(XenVIOMMUState, (obj), TYPE_XEN_VIOMMU_DEVICE)
> +
> +typedef struct XenVIOMMUState XenVIOMMUState;
> +
> +struct XenVIOMMUState {
> +    DeviceState dev;
> +    uint32_t id;
> +    uint64_t cap;
> +    uint64_t base_addr;
> +};
> +
> +static void xen_viommu_realize(DeviceState *dev, Error **errp)
> +{
> +    int rc;
> +    uint64_t cap;
> +    char *dom;
> +    char viommu_path[1024];
> +    XenVIOMMUState *s = XEN_VIOMMU_DEVICE(dev);
> +
> +    s->id = -1;
> +    
> +    /* Read vIOMMU attributes from Xenstore. */
> +    dom = xs_get_domain_path(xenstore, xen_domid);
> +    snprintf(viommu_path, sizeof(viommu_path), "%s/viommu", dom);
> +    rc = xenstore_read_uint64(viommu_path, "base_addr", &s->base_addr);  

Could these informations (base_addr and cap) be read from the command
line instead of via xenstore?
Any reason for these informations to be on xenstore?

> +    if (rc) {
> +        error_report("Can't get base address of vIOMMU");

I think error_setg should be used instead of error_report.

> +        exit(1);

Also, exit should be remove, and return instead. error_setg would be
enough to signal that the device can not work.

> +    }
> +
> +    rc = xenstore_read_uint64(viommu_path, "cap", &s->cap);
> +    if (rc) {
> +        error_report("Can't get capabilities of vIOMMU");
> +        exit(1);
> +    }
> +
> +    rc = xc_viommu_query_cap(xen_xc, xen_domid, &cap);

Since xc_viommu_* seems to be new, you should use
xendevicemodel_viommu_* instead, also you will need to define a stub for
them to be able to compile QEMU against older version of Xen.


The patch looks good otherwise.

Thanks,

-- 
Anthony PERARD
