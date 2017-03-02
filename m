Received: from eggs.gnu.org ([2001:4830:134:3::10]:50527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cjZXm-0007SN-7y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:49:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cjZXh-00070X-6T
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:49:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:45248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cjZXg-0006zx-Sd
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:49:49 -0500
Date: Thu, 2 Mar 2017 14:49:43 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
Message-ID: <alpine.DEB.2.10.1703021426050.17906@sstabellini-ThinkPad-X260>
References: <1488452986-24501-1-git-send-email-paul.durrant@citrix.com>
	<1488452986-24501-6-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

On Thu, 2 Mar 2017, Paul Durrant wrote:
> This patch modifies the wrapper functions in xen_common.h to use the
> new xendevicemodel interface if it is available along with compatibility
> code to use the old libxenctrl interface if it is not.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> ---
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> 
> v2:
> - Add a compat define for xenforeignmemory_close() since this is now
>   used.
> ---
>  include/hw/xen/xen_common.h | 115 +++++++++++++++++++++++++++++++-------------
>  xen-common.c                |   8 +++
>  2 files changed, 90 insertions(+), 33 deletions(-)
> 
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 31cf25f..48444e5 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -9,6 +9,7 @@
>  #undef XC_WANT_COMPAT_EVTCHN_API
>  #undef XC_WANT_COMPAT_GNTTAB_API
>  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> +#undef XC_WANT_COMPAT_DEVICEMODEL_API
>  
>  #include <xenctrl.h>
>  #include <xenstore.h>
> @@ -26,48 +27,95 @@ extern xc_interface *xen_xc;
>   * We don't support Xen prior to 4.2.0.
>   */
>  
> +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> +
> +typedef xc_interface xendevicemodel_handle;
> +
> +#define xendevicemodel_open(l, f) xen_xc
> +
> +#define xendevicemodel_map_io_range_to_ioreq_server \
> +    xc_hvm_map_io_range_to_ioreq_server
> +#define xendevicemodel_unmap_io_range_from_ioreq_server \
> +    xc_hvm_unmap_io_range_from_ioreq_server
> +#define xendevicemodel_map_pcidev_to_ioreq_server \
> +    xc_hvm_map_pcidev_to_ioreq_server
> +#define xendevicemodel_unmap_pcidev_from_ioreq_server \
> +    xc_hvm_unmap_pcidev_from_ioreq_server
> +#define xendevicemodel_create_ioreq_server \
> +    xc_hvm_create_ioreq_server
> +#define xendevicemodel_destroy_ioreq_server \
> +    xc_hvm_destroy_ioreq_server
> +#define xendevicemodel_get_ioreq_server_info \
> +    xc_hvm_get_ioreq_server_info
> +#define xendevicemodel_set_ioreq_server_state \
> +    xc_hvm_set_ioreq_server_state
> +#define xendevicemodel_set_pci_intx_level \
> +    xc_hvm_set_pci_intx_level
> +#define xendevicemodel_set_pci_link_route \
> +    xc_hvm_set_pci_link_route
> +#define xendevicemodel_set_isa_irq_level \
> +    xc_hvm_set_isa_irq_level
> +#define xendevicemodel_inject_msi \
> +    xc_hvm_inject_msi
> +#define xendevicemodel_set_mem_type \
> +    xc_hvm_set_mem_type
> +#define xendevicemodel_track_dirty_vram \
> +    xc_hvm_track_dirty_vram
> +#define xendevicemodel_modified_memory \
> +    xc_hvm_modified_memory

It does build correctly now for Xen < 4.9, however it breaks against
xen-unstable:

  ERROR: configure test passed without -Werror but failed with -Werror.
         This is probably a bug in the configure script. The failing command
         will be at the bottom of config.log.
         You can run configure with --disable-werror to bypass this check.

and config.log says:

  config-temp/qemu-conf.c: In function 'main':
  config-temp/qemu-conf.c:32:3: error: implicit declaration of function 'xc_hvm_set_mem_type' [-Werror=implicit-function-declaration]
  config-temp/qemu-conf.c:32:3: error: nested extern declaration of 'xc_hvm_set_mem_type' [-Werror=nested-externs]
  config-temp/qemu-conf.c:34:3: error: implicit declaration of function 'xc_hvm_inject_msi' [-Werror=implicit-function-declaration]
  config-temp/qemu-conf.c:34:3: error: nested extern declaration of 'xc_hvm_inject_msi' [-Werror=nested-externs]
  config-temp/qemu-conf.c:35:3: error: implicit declaration of function 'xc_hvm_create_ioreq_server' [-Werror=implicit-function-declaration]
  config-temp/qemu-conf.c:35:3: error: nested extern declaration of 'xc_hvm_create_ioreq_server' [-Werror=nested-externs]


With -DXC_WANT_COMPAT_DEVICEMODEL_API=1:

  In file included from /local/qemu-upstream/include/hw/xen/xen_backend.h:4:0,
                   from hw/block/xen_disk.c:27:
  /local/qemu-upstream/include/hw/xen/xen_common.h: In function 'xen_set_mem_type':
  /local/qemu-upstream/include/hw/xen/xen_common.h:78:5: error: implicit declaration of function 'xc_hvm_set_mem_type' [-Werror=implicit-function-declaration]


Only another comment (I guess you didn't see in my previous email):
could you please use static inline functions for compatibility rather
than macros? That way we are going to have some more compile time
checks. Or at least macros with parameters.


> +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 490 */
> +
> +#include <xendevicemodel.h>
> +
> +#endif
> +
> +extern xendevicemodel_handle *xen_dmod;
> +
>  static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t type,
>                                     uint64_t first_pfn, uint32_t nr)
>  {
> -    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
> +    return xendevicemodel_set_mem_type(xen_dmod, domid, type, first_pfn,
> +                                       nr);
>  }
>  
>  static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segment,
>                                           uint8_t bus, uint8_t device,
>                                           uint8_t intx, unsigned int level)
>  {
> -    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus, device,
> -                                     intx, level);
> +    return xendevicemodel_set_pci_intx_level(xen_dmod, domid, segment, bus,
> +                                             device, intx, level);
>  }
>  
>  static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
>                                           uint8_t irq)
>  {
> -    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
> +    return xendevicemodel_set_pci_link_route(xen_dmod, domid, link, irq);
>  }
>  
>  static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
>                                   uint32_t msi_data)
>  {
> -    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
> +    return xendevicemodel_inject_msi(xen_dmod, domid, msi_addr, msi_data);
>  }
>  
>  static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
>                                          unsigned int level)
>  {
> -    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
> +    return xendevicemodel_set_isa_irq_level(xen_dmod, domid, irq, level);
>  }
>  
>  static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_pfn,
>                                         uint32_t nr, unsigned long *bitmap)
>  {
> -    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitmap);
> +    return xendevicemodel_track_dirty_vram(xen_dmod, domid, first_pfn, nr,
> +                                           bitmap);
>  }
>  
>  static inline int xen_modified_memory(domid_t domid, uint64_t first_pfn,
>                                        uint32_t nr)
>  {
> -    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
> +    return xendevicemodel_modified_memory(xen_dmod, domid, first_pfn, nr);
>  }
>  
>  /* Xen 4.2 through 4.6 */
> @@ -97,6 +145,7 @@ typedef xc_gnttab xengnttab_handle;
>      xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
>  
>  #define xenforeignmemory_open(l, f) xen_xc
> +#define xenforeignmemory_close(h)
>  
>  static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
>                                           int prot, size_t pages,
> @@ -285,8 +334,8 @@ static inline void xen_map_memory_section(domid_t dom,
>      }
>  
>      trace_xen_map_mmio_range(ioservid, start_addr, end_addr);
> -    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 1,
> -                                        start_addr, end_addr);
> +    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom, ioservid, 1,
> +                                                start_addr, end_addr);
>  }
>  
>  static inline void xen_unmap_memory_section(domid_t dom,
> @@ -302,8 +351,8 @@ static inline void xen_unmap_memory_section(domid_t dom,
>      }
>  
>      trace_xen_unmap_mmio_range(ioservid, start_addr, end_addr);
> -    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
> -                                            1, start_addr, end_addr);
> +    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod, dom, ioservid,
> +                                                    1, start_addr, end_addr);
>  }
>  
>  static inline void xen_map_io_section(domid_t dom,
> @@ -319,8 +368,8 @@ static inline void xen_map_io_section(domid_t dom,
>      }
>  
>      trace_xen_map_portio_range(ioservid, start_addr, end_addr);
> -    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 0,
> -                                        start_addr, end_addr);
> +    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom, ioservid, 0,
> +                                                start_addr, end_addr);
>  }
>  
>  static inline void xen_unmap_io_section(domid_t dom,
> @@ -336,8 +385,8 @@ static inline void xen_unmap_io_section(domid_t dom,
>      }
>  
>      trace_xen_unmap_portio_range(ioservid, start_addr, end_addr);
> -    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
> -                                            0, start_addr, end_addr);
> +    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod, dom, ioservid,
> +                                                    0, start_addr, end_addr);
>  }
>  
>  static inline void xen_map_pcidev(domid_t dom,
> @@ -350,10 +399,10 @@ static inline void xen_map_pcidev(domid_t dom,
>  
>      trace_xen_map_pcidev(ioservid, pci_bus_num(pci_dev->bus),
>                           PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
> -    xc_hvm_map_pcidev_to_ioreq_server(xen_xc, dom, ioservid, 0,
> -                                      pci_bus_num(pci_dev->bus),
> -                                      PCI_SLOT(pci_dev->devfn),
> -                                      PCI_FUNC(pci_dev->devfn));
> +    xendevicemodel_map_pcidev_to_ioreq_server(xen_dmod, dom, ioservid, 0,
> +                                              pci_bus_num(pci_dev->bus),
> +                                              PCI_SLOT(pci_dev->devfn),
> +                                              PCI_FUNC(pci_dev->devfn));
>  }
>  
>  static inline void xen_unmap_pcidev(domid_t dom,
> @@ -366,18 +415,18 @@ static inline void xen_unmap_pcidev(domid_t dom,
>  
>      trace_xen_unmap_pcidev(ioservid, pci_bus_num(pci_dev->bus),
>                             PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->devfn));
> -    xc_hvm_unmap_pcidev_from_ioreq_server(xen_xc, dom, ioservid, 0,
> -                                          pci_bus_num(pci_dev->bus),
> -                                          PCI_SLOT(pci_dev->devfn),
> -                                          PCI_FUNC(pci_dev->devfn));
> +    xendevicemodel_unmap_pcidev_from_ioreq_server(xen_dmod, dom, ioservid, 0,
> +                                                  pci_bus_num(pci_dev->bus),
> +                                                  PCI_SLOT(pci_dev->devfn),
> +                                                  PCI_FUNC(pci_dev->devfn));
>  }
>  
>  static inline void xen_create_ioreq_server(domid_t dom,
>                                             ioservid_t *ioservid)
>  {
> -    int rc = xc_hvm_create_ioreq_server(xen_xc, dom,
> -                                        HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> -                                        ioservid);
> +    int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
> +                                                HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> +                                                ioservid);
>  
>      if (rc == 0) {
>          trace_xen_ioreq_server_create(*ioservid);
> @@ -397,7 +446,7 @@ static inline void xen_destroy_ioreq_server(domid_t dom,
>      }
>  
>      trace_xen_ioreq_server_destroy(ioservid);
> -    xc_hvm_destroy_ioreq_server(xen_xc, dom, ioservid);
> +    xendevicemodel_destroy_ioreq_server(xen_dmod, dom, ioservid);
>  }
>  
>  static inline int xen_get_ioreq_server_info(domid_t dom,
> @@ -412,9 +461,9 @@ static inline int xen_get_ioreq_server_info(domid_t dom,
>                                                   bufioreq_evtchn);
>      }
>  
> -    return xc_hvm_get_ioreq_server_info(xen_xc, dom, ioservid,
> -                                        ioreq_pfn, bufioreq_pfn,
> -                                        bufioreq_evtchn);
> +    return xendevicemodel_get_ioreq_server_info(xen_dmod, dom, ioservid,
> +                                                ioreq_pfn, bufioreq_pfn,
> +                                                bufioreq_evtchn);
>  }
>  
>  static inline int xen_set_ioreq_server_state(domid_t dom,
> @@ -426,8 +475,8 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
>      }
>  
>      trace_xen_ioreq_server_state(ioservid, enable);
> -    return xc_hvm_set_ioreq_server_state(xen_xc, dom, ioservid,
> -                                         enable);
> +    return xendevicemodel_set_ioreq_server_state(xen_dmod, dom, ioservid,
> +                                                 enable);
>  }
>  
>  #endif
> diff --git a/xen-common.c b/xen-common.c
> index 703e7a5..ae76150 100644
> --- a/xen-common.c
> +++ b/xen-common.c
> @@ -27,6 +27,7 @@
>  
>  xc_interface *xen_xc;
>  xenforeignmemory_handle *xen_fmem;
> +xendevicemodel_handle *xen_dmod;
>  
>  static int store_dev_info(int domid, Chardev *cs, const char *string)
>  {
> @@ -128,6 +129,13 @@ static int xen_init(MachineState *ms)
>          xc_interface_close(xen_xc);
>          return -1;
>      }
> +    xen_dmod = xendevicemodel_open(0, 0);
> +    if (xen_dmod == NULL) {
> +        xen_pv_printf(NULL, 0, "can't open xen devicemodel interface\n");
> +        xenforeignmemory_close(xen_fmem);
> +        xc_interface_close(xen_xc);
> +        return -1;
> +    }
>      qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
>  
>      global_state_set_optional();
> -- 
> 2.1.4
> 
