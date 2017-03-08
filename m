Received: from eggs.gnu.org ([2001:4830:134:3::10]:47158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=233fe4bff=Paul.Durrant@citrix.com>)
	id 1clY5x-000254-JJ
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:41:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=233fe4bff=Paul.Durrant@citrix.com>)
	id 1clY5u-0000OY-EX
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:41:21 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:54993
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=233fe4bff=Paul.Durrant@citrix.com>)
	id 1clY5u-0000M5-0m
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 04:41:18 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 8 Mar 2017 09:41:13 +0000
Message-ID: <9f3e75de3dba4b5f8afa871771a7edff@AMSPEX02CL03.citrite.net>
References: <1488884134-29190-1-git-send-email-paul.durrant@citrix.com>
	<1488884134-29190-6-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1703071112520.17906@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1703071112520.17906@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4 5/5] xen: use libxendevicemodel when
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 07 March 2017 19:14
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; Stefano
> Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v4 5/5] xen: use libxendevicemodel when available
>=20
> On Tue, 7 Mar 2017, Paul Durrant wrote:
> > This patch modifies the wrapper functions in xen_common.h to use the
> > new xendevicemodel interface if it is available along with compatibilit=
y
> > code to use the old libxenctrl interface if it is not.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > Reviewed-by: Anthony Perard <anthony.perard@citrix.com>
>=20
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>=20

Great. Thanks, and thanks for finding the compat issues.

> However, QEMU is in soft-freeze, so I'll wait until the merge window
> open again before sending the pull request.
>=20

Ok.

Cheers,

  Paul

>=20
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> >
> > v4:
> > - Fix typo causing build failures on < 490
> > - Fix building on < 450
> > - Build-tested against 4.2.5 and 4.8.0
> >
> > v3:
> > - Switch from macros to static inlines.
> >
> > v2:
> > - Add a compat define for xenforeignmemory_close() since this is now
> >   used.
> > ---
> >  include/hw/xen/xen_common.h | 203
> +++++++++++++++++++++++++++++++++++++-------
> >  xen-common.c                |   8 ++
> >  2 files changed, 178 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/hw/xen/xen_common.h
> b/include/hw/xen/xen_common.h
> > index 31cf25f..274accc 100644
> > --- a/include/hw/xen/xen_common.h
> > +++ b/include/hw/xen/xen_common.h
> > @@ -9,6 +9,7 @@
> >  #undef XC_WANT_COMPAT_EVTCHN_API
> >  #undef XC_WANT_COMPAT_GNTTAB_API
> >  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
> > +#undef XC_WANT_COMPAT_DEVICEMODEL_API
> >
> >  #include <xenctrl.h>
> >  #include <xenstore.h>
> > @@ -26,48 +27,183 @@ extern xc_interface *xen_xc;
> >   * We don't support Xen prior to 4.2.0.
> >   */
> >
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 490
> > +
> > +typedef xc_interface xendevicemodel_handle;
> > +
> > +static inline xendevicemodel_handle *xendevicemodel_open(
> > +    struct xentoollog_logger *logger, unsigned int open_flags)
> > +{
> > +    return xen_xc;
> > +}
> > +
> > +#if CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 450
> > +
> > +static inline int xendevicemodel_create_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, int handle_bufioreq,
> > +    ioservid_t *id)
> > +{
> > +    return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
> > +                                      id);
> > +}
> > +
> > +static inline int xendevicemodel_get_ioreq_server_info(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
> > +    xen_pfn_t *ioreq_pfn, xen_pfn_t *bufioreq_pfn,
> > +    evtchn_port_t *bufioreq_port)
> > +{
> > +    return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
> > +                                        bufioreq_pfn, bufioreq_port);
> > +}
> > +
> > +static inline int xendevicemodel_map_io_range_to_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int
> is_mmio,
> > +    uint64_t start, uint64_t end)
> > +{
> > +    return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id,
> is_mmio,
> > +                                               start, end);
> > +}
> > +
> > +static inline int xendevicemodel_unmap_io_range_from_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int
> is_mmio,
> > +    uint64_t start, uint64_t end)
> > +{
> > +    return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id,
> is_mmio,
> > +                                                   start, end);
> > +}
> > +
> > +static inline int xendevicemodel_map_pcidev_to_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
> > +    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
> > +{
> > +    return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id,
> segment,
> > +                                             bus, device, function);
> > +}
> > +
> > +static inline int xendevicemodel_unmap_pcidev_from_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
> > +    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
> > +{
> > +    return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id,
> segment,
> > +                                                 bus, device, function=
);
> > +}
> > +
> > +static inline int xendevicemodel_destroy_ioreq_server(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id)
> > +{
> > +    return xc_hvm_destroy_ioreq_server(dmod, domid, id);
> > +}
> > +
> > +static inline int xendevicemodel_set_ioreq_server_state(
> > +    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int
> enabled)
> > +{
> > +    return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
> > +}
> > +
> > +#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 450 */
> > +
> > +static inline int xendevicemodel_set_pci_intx_level(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint16_t segment,
> > +    uint8_t bus, uint8_t device, uint8_t intx, unsigned int level)
> > +{
> > +    return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device=
,
> > +                                     intx, level);
> > +}
> > +
> > +static inline int xendevicemodel_set_isa_irq_level(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint8_t irq,
> > +    unsigned int level)
> > +{
> > +    return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
> > +}
> > +
> > +static inline int xendevicemodel_set_pci_link_route(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint8_t link, uint8_t
> irq)
> > +{
> > +    return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
> > +}
> > +
> > +static inline int xendevicemodel_inject_msi(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint64_t msi_addr,
> > +    uint32_t msi_data)
> > +{
> > +    return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
> > +}
> > +
> > +static inline int xendevicemodel_track_dirty_vram(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
> > +    uint32_t nr, unsigned long *dirty_bitmap)
> > +{
> > +    return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
> > +                                   dirty_bitmap);
> > +}
> > +
> > +static inline int xendevicemodel_modified_memory(
> > +    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
> > +    uint32_t nr)
> > +{
> > +    return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
> > +}
> > +
> > +static inline int xendevicemodel_set_mem_type(
> > +    xendevicemodel_handle *dmod, domid_t domid, hvmmem_type_t
> mem_type,
> > +    uint64_t first_pfn, uint32_t nr)
> > +{
> > +    return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn,
> nr);
> > +}
> > +
> > +#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >=3D 490 */
> > +
> > +#include <xendevicemodel.h>
> > +
> > +#endif
> > +
> > +extern xendevicemodel_handle *xen_dmod;
> > +
> >  static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t
> type,
> >                                     uint64_t first_pfn, uint32_t nr)
> >  {
> > -    return xc_hvm_set_mem_type(xen_xc, domid, type, first_pfn, nr);
> > +    return xendevicemodel_set_mem_type(xen_dmod, domid, type,
> first_pfn,
> > +                                       nr);
> >  }
> >
> >  static inline int xen_set_pci_intx_level(domid_t domid, uint16_t segme=
nt,
> >                                           uint8_t bus, uint8_t device,
> >                                           uint8_t intx, unsigned int le=
vel)
> >  {
> > -    return xc_hvm_set_pci_intx_level(xen_xc, domid, segment, bus,
> device,
> > -                                     intx, level);
> > +    return xendevicemodel_set_pci_intx_level(xen_dmod, domid,
> segment, bus,
> > +                                             device, intx, level);
> >  }
> >
> >  static inline int xen_set_pci_link_route(domid_t domid, uint8_t link,
> >                                           uint8_t irq)
> >  {
> > -    return xc_hvm_set_pci_link_route(xen_xc, domid, link, irq);
> > +    return xendevicemodel_set_pci_link_route(xen_dmod, domid, link,
> irq);
> >  }
> >
> >  static inline int xen_inject_msi(domid_t domid, uint64_t msi_addr,
> >                                   uint32_t msi_data)
> >  {
> > -    return xc_hvm_inject_msi(xen_xc, domid, msi_addr, msi_data);
> > +    return xendevicemodel_inject_msi(xen_dmod, domid, msi_addr,
> msi_data);
> >  }
> >
> >  static inline int xen_set_isa_irq_level(domid_t domid, uint8_t irq,
> >                                          unsigned int level)
> >  {
> > -    return xc_hvm_set_isa_irq_level(xen_xc, domid, irq, level);
> > +    return xendevicemodel_set_isa_irq_level(xen_dmod, domid, irq,
> level);
> >  }
> >
> >  static inline int xen_track_dirty_vram(domid_t domid, uint64_t first_p=
fn,
> >                                         uint32_t nr, unsigned long *bit=
map)
> >  {
> > -    return xc_hvm_track_dirty_vram(xen_xc, domid, first_pfn, nr, bitma=
p);
> > +    return xendevicemodel_track_dirty_vram(xen_dmod, domid, first_pfn,
> nr,
> > +                                           bitmap);
> >  }
> >
> >  static inline int xen_modified_memory(domid_t domid, uint64_t first_pf=
n,
> >                                        uint32_t nr)
> >  {
> > -    return xc_hvm_modified_memory(xen_xc, domid, first_pfn, nr);
> > +    return xendevicemodel_modified_memory(xen_dmod, domid,
> first_pfn, nr);
> >  }
> >
> >  /* Xen 4.2 through 4.6 */
> > @@ -97,6 +233,7 @@ typedef xc_gnttab xengnttab_handle;
> >      xc_gnttab_map_domain_grant_refs(h, c, d, r, p)
> >
> >  #define xenforeignmemory_open(l, f) xen_xc
> > +#define xenforeignmemory_close(h)
> >
> >  static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom=
,
> >                                           int prot, size_t pages,
> > @@ -285,8 +422,8 @@ static inline void
> xen_map_memory_section(domid_t dom,
> >      }
> >
> >      trace_xen_map_mmio_range(ioservid, start_addr, end_addr);
> > -    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 1,
> > -                                        start_addr, end_addr);
> > +    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom,
> ioservid, 1,
> > +                                                start_addr, end_addr);
> >  }
> >
> >  static inline void xen_unmap_memory_section(domid_t dom,
> > @@ -302,8 +439,8 @@ static inline void
> xen_unmap_memory_section(domid_t dom,
> >      }
> >
> >      trace_xen_unmap_mmio_range(ioservid, start_addr, end_addr);
> > -    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
> > -                                            1, start_addr, end_addr);
> > +    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod,
> dom, ioservid,
> > +                                                    1, start_addr, end=
_addr);
> >  }
> >
> >  static inline void xen_map_io_section(domid_t dom,
> > @@ -319,8 +456,8 @@ static inline void xen_map_io_section(domid_t
> dom,
> >      }
> >
> >      trace_xen_map_portio_range(ioservid, start_addr, end_addr);
> > -    xc_hvm_map_io_range_to_ioreq_server(xen_xc, dom, ioservid, 0,
> > -                                        start_addr, end_addr);
> > +    xendevicemodel_map_io_range_to_ioreq_server(xen_dmod, dom,
> ioservid, 0,
> > +                                                start_addr, end_addr);
> >  }
> >
> >  static inline void xen_unmap_io_section(domid_t dom,
> > @@ -336,8 +473,8 @@ static inline void xen_unmap_io_section(domid_t
> dom,
> >      }
> >
> >      trace_xen_unmap_portio_range(ioservid, start_addr, end_addr);
> > -    xc_hvm_unmap_io_range_from_ioreq_server(xen_xc, dom, ioservid,
> > -                                            0, start_addr, end_addr);
> > +    xendevicemodel_unmap_io_range_from_ioreq_server(xen_dmod,
> dom, ioservid,
> > +                                                    0, start_addr, end=
_addr);
> >  }
> >
> >  static inline void xen_map_pcidev(domid_t dom,
> > @@ -350,10 +487,10 @@ static inline void xen_map_pcidev(domid_t dom,
> >
> >      trace_xen_map_pcidev(ioservid, pci_bus_num(pci_dev->bus),
> >                           PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev->d=
evfn));
> > -    xc_hvm_map_pcidev_to_ioreq_server(xen_xc, dom, ioservid, 0,
> > -                                      pci_bus_num(pci_dev->bus),
> > -                                      PCI_SLOT(pci_dev->devfn),
> > -                                      PCI_FUNC(pci_dev->devfn));
> > +    xendevicemodel_map_pcidev_to_ioreq_server(xen_dmod, dom,
> ioservid, 0,
> > +                                              pci_bus_num(pci_dev->bus=
),
> > +                                              PCI_SLOT(pci_dev->devfn)=
,
> > +                                              PCI_FUNC(pci_dev->devfn)=
);
> >  }
> >
> >  static inline void xen_unmap_pcidev(domid_t dom,
> > @@ -366,18 +503,18 @@ static inline void xen_unmap_pcidev(domid_t
> dom,
> >
> >      trace_xen_unmap_pcidev(ioservid, pci_bus_num(pci_dev->bus),
> >                             PCI_SLOT(pci_dev->devfn), PCI_FUNC(pci_dev-=
>devfn));
> > -    xc_hvm_unmap_pcidev_from_ioreq_server(xen_xc, dom, ioservid, 0,
> > -                                          pci_bus_num(pci_dev->bus),
> > -                                          PCI_SLOT(pci_dev->devfn),
> > -                                          PCI_FUNC(pci_dev->devfn));
> > +    xendevicemodel_unmap_pcidev_from_ioreq_server(xen_dmod, dom,
> ioservid, 0,
> > +                                                  pci_bus_num(pci_dev-=
>bus),
> > +                                                  PCI_SLOT(pci_dev->de=
vfn),
> > +                                                  PCI_FUNC(pci_dev->de=
vfn));
> >  }
> >
> >  static inline void xen_create_ioreq_server(domid_t dom,
> >                                             ioservid_t *ioservid)
> >  {
> > -    int rc =3D xc_hvm_create_ioreq_server(xen_xc, dom,
> > -                                        HVM_IOREQSRV_BUFIOREQ_ATOMIC,
> > -                                        ioservid);
> > +    int rc =3D xendevicemodel_create_ioreq_server(xen_dmod, dom,
> > +                                                HVM_IOREQSRV_BUFIOREQ_=
ATOMIC,
> > +                                                ioservid);
> >
> >      if (rc =3D=3D 0) {
> >          trace_xen_ioreq_server_create(*ioservid);
> > @@ -397,7 +534,7 @@ static inline void
> xen_destroy_ioreq_server(domid_t dom,
> >      }
> >
> >      trace_xen_ioreq_server_destroy(ioservid);
> > -    xc_hvm_destroy_ioreq_server(xen_xc, dom, ioservid);
> > +    xendevicemodel_destroy_ioreq_server(xen_dmod, dom, ioservid);
> >  }
> >
> >  static inline int xen_get_ioreq_server_info(domid_t dom,
> > @@ -412,9 +549,9 @@ static inline int xen_get_ioreq_server_info(domid_t
> dom,
> >                                                   bufioreq_evtchn);
> >      }
> >
> > -    return xc_hvm_get_ioreq_server_info(xen_xc, dom, ioservid,
> > -                                        ioreq_pfn, bufioreq_pfn,
> > -                                        bufioreq_evtchn);
> > +    return xendevicemodel_get_ioreq_server_info(xen_dmod, dom,
> ioservid,
> > +                                                ioreq_pfn, bufioreq_pf=
n,
> > +                                                bufioreq_evtchn);
> >  }
> >
> >  static inline int xen_set_ioreq_server_state(domid_t dom,
> > @@ -426,8 +563,8 @@ static inline int
> xen_set_ioreq_server_state(domid_t dom,
> >      }
> >
> >      trace_xen_ioreq_server_state(ioservid, enable);
> > -    return xc_hvm_set_ioreq_server_state(xen_xc, dom, ioservid,
> > -                                         enable);
> > +    return xendevicemodel_set_ioreq_server_state(xen_dmod, dom,
> ioservid,
> > +                                                 enable);
> >  }
> >
> >  #endif
> > diff --git a/xen-common.c b/xen-common.c
> > index 703e7a5..ae76150 100644
> > --- a/xen-common.c
> > +++ b/xen-common.c
> > @@ -27,6 +27,7 @@
> >
> >  xc_interface *xen_xc;
> >  xenforeignmemory_handle *xen_fmem;
> > +xendevicemodel_handle *xen_dmod;
> >
> >  static int store_dev_info(int domid, Chardev *cs, const char *string)
> >  {
> > @@ -128,6 +129,13 @@ static int xen_init(MachineState *ms)
> >          xc_interface_close(xen_xc);
> >          return -1;
> >      }
> > +    xen_dmod =3D xendevicemodel_open(0, 0);
> > +    if (xen_dmod =3D=3D NULL) {
> > +        xen_pv_printf(NULL, 0, "can't open xen devicemodel interface\n=
");
> > +        xenforeignmemory_close(xen_fmem);
> > +        xc_interface_close(xen_xc);
> > +        return -1;
> > +    }
> >      qemu_add_vm_change_state_handler(xen_change_state_handler,
> NULL);
> >
> >      global_state_set_optional();
> > --
> > 2.1.4
> >
