Received: from eggs.gnu.org ([2001:4830:134:3::10]:59297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23cO-0000SN-2x
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23cL-0003FS-BD
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:07:20 -0400
Received: from smtp.citrix.com ([66.165.176.89]:29016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=449813866=anthony.perard@citrix.com>)
	id 1e23cL-0003FC-0d
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:07:17 -0400
Date: Tue, 10 Oct 2017 15:51:06 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171010145106.GJ1771@perard.uk.xensource.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<ade26715c9bde1fe921959823de08da582fce58f.1506730372.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ade26715c9bde1fe921959823de08da582fce58f.1506730372.git.alistair.francis@xilinx.com>
Subject: Re: [Qemu-devel] [PATCH v2 15/47] hw/i386: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, armbru@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

On Fri, Sep 29, 2017 at 05:15:46PM -0700, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.

[...]

> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index d9ccd5d0d6..f8e3e0507b 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -246,9 +246,10 @@ void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size, MemoryRegion *mr,
>  
>      if (runstate_check(RUN_STATE_INMIGRATE)) {
>          /* RAM already populated in Xen */
> -        fprintf(stderr, "%s: do not alloc "RAM_ADDR_FMT
> -                " bytes of ram at "RAM_ADDR_FMT" when runstate is INMIGRATE\n",
> -                __func__, size, ram_addr); 
> +        error_report("%s: do not alloc "RAM_ADDR_FMT
> +                     " bytes of ram at "RAM_ADDR_FMT" when runstate is "
> +                     " INMIGRATE",
> +                     __func__, size, ram_addr);
>          return;
>      }
>  
> @@ -444,8 +445,9 @@ static int xen_remove_from_physmap(XenIOState *state,
>  
>          rc = xen_xc_domain_add_to_physmap(xen_xc, xen_domid, XENMAPSPACE_gmfn, idx, gpfn);
>          if (rc) {
> -            fprintf(stderr, "add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
> -                    PRI_xen_pfn" failed: %d (errno: %d)\n", idx, gpfn, rc, errno);
> +            error_report("add_to_physmap MFN %"PRI_xen_pfn" to PFN %"
> +                         PRI_xen_pfn" failed: %d (errno: %d)", idx,
> +                         gpfn, rc, errno);
>              return -rc;
>          }
>      }
> @@ -1090,11 +1092,11 @@ static void cpu_handle_ioreq(void *opaque)
>          req->data = copy.data;
>  
>          if (req->state != STATE_IOREQ_INPROCESS) {
> -            fprintf(stderr, "Badness in I/O request ... not in service?!: "
> -                    "%x, ptr: %x, port: %"PRIx64", "
> -                    "data: %"PRIx64", count: %u, size: %u, type: %u\n",
> -                    req->state, req->data_is_ptr, req->addr,
> -                    req->data, req->count, req->size, req->type);
> +            error_report("Badness in I/O request ... not in service?!: "
> +                         "%x, ptr: %x, port: %"PRIx64", "
> +                         "data: %"PRIx64", count: %u, size: %u, type: %u",
> +                         req->state, req->data_is_ptr, req->addr,
> +                         req->data, req->count, req->size, req->type);
>              destroy_hvm_domain(false);
>              return;
>          }
> @@ -1397,16 +1399,16 @@ void destroy_hvm_domain(bool reboot)
>  
>      xc_handle = xc_interface_open(0, 0, 0);
>      if (xc_handle == NULL) {
> -        fprintf(stderr, "Cannot acquire xenctrl handle\n");
> +        error_report("Cannot acquire xenctrl handle");
>      } else {
>          sts = xc_domain_shutdown(xc_handle, xen_domid,
>                                   reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff);
>          if (sts != 0) {
> -            fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
> -                    "sts %d, %s\n", reboot ? "reboot" : "poweroff",
> +            error_report("xc_domain_shutdown failed to issue %s, "
> +                    "sts %d, %s", reboot ? "reboot" : "poweroff",
>                      sts, strerror(errno));
>          } else {
> -            fprintf(stderr, "Issued domain %d %s\n", xen_domid,
> +            error_report("Issued domain %d %s", xen_domid,
>                      reboot ? "reboot" : "poweroff");
>          }
>          xc_interface_close(xc_handle);
> @@ -1425,7 +1427,7 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
>      va_start(ap, fmt);
>      vfprintf(stderr, fmt, ap);

Here, we may want to replace vfprintf by error_vreport as well?
Or is it more complicated and needs its own patch to fix all call to
xen_shutdown_fatal_error?

>      va_end(ap);
> -    fprintf(stderr, "Will destroy the domain.\n");
> +    error_report("Will destroy the domain.");
>      /* destroy the domain */
>      qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_ERROR);
>  }
> diff --git a/hw/i386/xen/xen-mapcache.c b/hw/i386/xen/xen-mapcache.c
> index baab93b614..4062af0900 100644
> --- a/hw/i386/xen/xen-mapcache.c
> +++ b/hw/i386/xen/xen-mapcache.c
> @@ -377,7 +377,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          }
>      }
>      if (!found) {
> -        fprintf(stderr, "%s, could not find %p\n", __func__, ptr);
> +        error_report("%s, could not find %p", __func__, ptr);
>          QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
>              DPRINTF("   "TARGET_FMT_plx" -> %p is present\n", reventry->paddr_index,
>                      reventry->vaddr_req);
> @@ -477,9 +477,9 @@ void xen_invalidate_map_cache(void)
>          if (!reventry->dma) {
>              continue;
>          }
> -        fprintf(stderr, "Locked DMA mapping while invalidating mapcache!"
> -                " "TARGET_FMT_plx" -> %p is present\n",
> -                reventry->paddr_index, reventry->vaddr_req);
> +        error_report("Locked DMA mapping while invalidating mapcache!"
> +                     " "TARGET_FMT_plx" -> %p is present",
> +                     reventry->paddr_index, reventry->vaddr_req);
>      }
>  
>      for (i = 0; i < mapcache->nr_buckets; i++) {
> @@ -545,8 +545,8 @@ static uint8_t *xen_replace_cache_entry_unlocked(hwaddr old_phys_addr,
>      address_index  = new_phys_addr >> MCACHE_BUCKET_SHIFT;
>      address_offset = new_phys_addr & (MCACHE_BUCKET_SIZE - 1);
>  
> -    fprintf(stderr, "Replacing a dummy mapcache entry for "TARGET_FMT_plx \
> -            " with "TARGET_FMT_plx"\n", old_phys_addr, new_phys_addr);
> +    error_report("Replacing a dummy mapcache entry for "TARGET_FMT_plx \
> +                 " with "TARGET_FMT_plx"", old_phys_addr, new_phys_addr);
>  
>      xen_remap_bucket(entry, entry->vaddr_base,
>                       cache_size, address_index, false);
> diff --git a/hw/i386/xen/xen_apic.c b/hw/i386/xen/xen_apic.c
> index 55769eba7e..0571871422 100644
> --- a/hw/i386/xen/xen_apic.c
> +++ b/hw/i386/xen/xen_apic.c
> @@ -10,6 +10,7 @@
>   * later. See the COPYING file in the top-level directory.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/i386/apic_internal.h"
>  #include "hw/pci/msi.h"
>  #include "hw/xen/xen.h"
> @@ -24,7 +25,7 @@ static void xen_apic_mem_write(void *opaque, hwaddr addr,
>                                 uint64_t data, unsigned size)
>  {
>      if (size != sizeof(uint32_t)) {
> -        fprintf(stderr, "Xen: APIC write data size = %d, invalid\n", size);
> +        error_report("Xen: APIC write data size = %d, invalid", size);
>          return;
>      }
>  

Despite my comment, for the Xen part:
Acked-by: Anthony PERARD <anthony.perard@citrix.com>

-- 
Anthony PERARD
