Received: from eggs.gnu.org ([2001:4830:134:3::10]:49902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1fEDYS-00068N-EN
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <x1917x@gmail.com>) id 1fEDYM-0003K3-54
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:48 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:35094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <x1917x@gmail.com>) id 1fEDYL-0003JJ-PO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 08:41:42 -0400
Received: by mail-lf0-x242.google.com with SMTP id y72-v6so12008355lfd.2
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 05:41:41 -0700 (PDT)
Date: Thu, 3 May 2018 22:41:28 +1000
From: Alexey G <x1917x@gmail.com>
Message-ID: <20180503224128.00005cf7@gmail.com>
In-Reply-To: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
References: <1525346320-24553-1-git-send-email-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] xen-hvm: stop faking I/O to access PCI
 config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 3 May 2018 12:18:40 +0100
Paul Durrant <paul.durrant@citrix.com> wrote:

>This patch removes the current hackery where IOREQ_TYPE_PCI_CONFIG
>reqyests are handled by faking PIO to 0xcf8 and 0xcfc and replaces it
>with direct calls to pci_host_config_read/write_common().
>Doing so necessitates mapping BDFs to PCIDevices but maintaining a
>simple QLIST in xen_device_realize/unrealize() will suffice.
>
>NOTE: whilst config space accesses are currently limited to
>      PCI_CONFIG_SPACE_SIZE, this patch paves the way to increasing the
>      limit to PCIE_CONFIG_SPACE_SIZE when Xen gains the ability to
>      emulate MCFG table accesses.
>
>Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Minor problem here is a possible incompatibility with PCI-PCI bridges
which we'll need to use eventually for Q35 PT -- IIRC changing secondary
bus numbers do not cause unrealize/realize pair to be called for
affected PCI devices. This means that dev_list may contain stale BDF
information if any related bus number change.

Anyway, PCI-PCI bridges and their secondary bus numbers must be handled
specifically, so it can be ignored for now.

I'll try to reuse this patch for my Xen patch for supporting MMCONFIG
ioreq forwarding to multiple ioreq servers.

>--
>Cc: Stefano Stabellini <sstabellini@kernel.org>
>Cc: Anthony Perard <anthony.perard@citrix.com>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Marcel Apfelbaum <marcel@redhat.com>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Richard Henderson <rth@twiddle.net>
>Cc: Eduardo Habkost <ehabkost@redhat.com>
>---
> hw/i386/xen/trace-events |   2 +
> hw/i386/xen/xen-hvm.c    | 101
> +++++++++++++++++++++++++++++++++++++---------- 2 files changed, 83
> insertions(+), 20 deletions(-)
>
>diff --git a/hw/i386/xen/trace-events b/hw/i386/xen/trace-events
>index 8dab7bc..f576f1b 100644
>--- a/hw/i386/xen/trace-events
>+++ b/hw/i386/xen/trace-events
>@@ -15,6 +15,8 @@ cpu_ioreq_pio(void *req, uint32_t dir, uint32_t df,
>uint32_t data_is_ptr, uint64
> cpu_ioreq_pio_read_reg(void *req, uint64_t data, uint64_t addr,
> uint32_t size) "I/O=%p pio read reg data=0x%"PRIx64" port=0x%"PRIx64"
> size=%d" cpu_ioreq_pio_write_reg(void *req, uint64_t data, uint64_t
> addr, uint32_t size) "I/O=%p pio write reg data=0x%"PRIx64"
> port=0x%"PRIx64" size=%d" cpu_ioreq_move(void *req, uint32_t dir,
> uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data,
> uint32_t count, uint32_t size) "I/O=%p copy dir=%d df=%d ptr=%d
> port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
>+cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg,
>uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u
>data=0x%x" +cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t
>reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u
>data=0x%x"
> 
> # xen-mapcache.c
> xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
>diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
>index caa563b..c139d29 100644
>--- a/hw/i386/xen/xen-hvm.c
>+++ b/hw/i386/xen/xen-hvm.c
>@@ -12,6 +12,7 @@
> 
> #include "cpu.h"
> #include "hw/pci/pci.h"
>+#include "hw/pci/pci_host.h"
> #include "hw/i386/pc.h"
> #include "hw/i386/apic-msidef.h"
> #include "hw/xen/xen_common.h"
>@@ -86,6 +87,12 @@ typedef struct XenPhysmap {
>     QLIST_ENTRY(XenPhysmap) list;
> } XenPhysmap;
> 
>+typedef struct XenPciDevice {
>+    PCIDevice *pci_dev;
>+    uint32_t sbdf;
>+    QLIST_ENTRY(XenPciDevice) entry;
>+} XenPciDevice;
>+
> typedef struct XenIOState {
>     ioservid_t ioservid;
>     shared_iopage_t *shared_page;
>@@ -105,6 +112,7 @@ typedef struct XenIOState {
>     struct xs_handle *xenstore;
>     MemoryListener memory_listener;
>     MemoryListener io_listener;
>+    QLIST_HEAD(, XenPciDevice) dev_list;
>     DeviceListener device_listener;
>     QLIST_HEAD(, XenPhysmap) physmap;
>     hwaddr free_phys_offset;
>@@ -569,6 +577,12 @@ static void xen_device_realize(DeviceListener
>*listener,
> 
>     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>         PCIDevice *pci_dev = PCI_DEVICE(dev);
>+        XenPciDevice *xendev = g_new(XenPciDevice, 1);
>+
>+        xendev->pci_dev = pci_dev;
>+        xendev->sbdf = PCI_BUILD_BDF(pci_dev_bus_num(pci_dev),
>+                                     pci_dev->devfn);
>+        QLIST_INSERT_HEAD(&state->dev_list, xendev, entry);
> 
>         xen_map_pcidev(xen_domid, state->ioservid, pci_dev);
>     }
>@@ -581,8 +595,17 @@ static void xen_device_unrealize(DeviceListener
>*listener,
> 
>     if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
>         PCIDevice *pci_dev = PCI_DEVICE(dev);
>+        XenPciDevice *xendev, *next;
> 
>         xen_unmap_pcidev(xen_domid, state->ioservid, pci_dev);
>+
>+        QLIST_FOREACH_SAFE(xendev, &state->dev_list, entry, next) {
>+            if (xendev->pci_dev == pci_dev) {
>+                QLIST_REMOVE(xendev, entry);
>+                g_free(xendev);
>+                break;
>+            }
>+        }
>     }
> }
> 
>@@ -903,6 +926,61 @@ static void cpu_ioreq_move(ioreq_t *req)
>     }
> }
> 
>+static void cpu_ioreq_config(XenIOState *state, ioreq_t *req)
>+{
>+    uint32_t sbdf = req->addr >> 32;
>+    uint32_t reg = req->addr;
>+    XenPciDevice *xendev;
>+
>+    if (req->size > sizeof(uint32_t)) {
>+        hw_error("PCI config access: bad size (%u)", req->size);
>+    }
>+
>+    QLIST_FOREACH(xendev, &state->dev_list, entry) {
>+        unsigned int i;
>+
>+        if (xendev->sbdf != sbdf) {
>+            continue;
>+        }
>+
>+        if (req->dir == IOREQ_READ) {
>+            if (!req->data_is_ptr) {
>+                req->data = pci_host_config_read_common(
>+                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
>+                    req->size);
>+                trace_cpu_ioreq_config_read(req, sbdf, reg, req->size,
>+                                            req->data);
>+            } else {
>+                for (i = 0; i < req->count; i++) {
>+                    uint32_t tmp;
>+
>+                    tmp = pci_host_config_read_common(
>+                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
>+                        req->size);
>+                    write_phys_req_item(req->data, req, i, &tmp);
>+                }
>+            }
>+        } else if (req->dir == IOREQ_WRITE) {
>+            if (!req->data_is_ptr) {
>+                trace_cpu_ioreq_config_write(req, sbdf, reg,
>req->size,
>+                                             req->data);
>+                pci_host_config_write_common(
>+                    xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
>req->data,
>+                    req->size);
>+            } else {
>+                for (i = 0; i < req->count; i++) {
>+                    uint32_t tmp = 0;
>+
>+                    read_phys_req_item(req->data, req, i, &tmp);
>+                    pci_host_config_write_common(
>+                        xendev->pci_dev, reg, PCI_CONFIG_SPACE_SIZE,
>tmp,
>+                        req->size);
>+                }
>+            }
>+        }
>+    }
>+}
>+
> static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
> {
>     X86CPU *cpu;
>@@ -975,27 +1053,9 @@ static void handle_ioreq(XenIOState *state,
>ioreq_t *req)
>         case IOREQ_TYPE_INVALIDATE:
>             xen_invalidate_map_cache();
>             break;
>-        case IOREQ_TYPE_PCI_CONFIG: {
>-            uint32_t sbdf = req->addr >> 32;
>-            uint32_t val;
>-
>-            /* Fake a write to port 0xCF8 so that
>-             * the config space access will target the
>-             * correct device model.
>-             */
>-            val = (1u << 31) |
>-                  ((req->addr & 0x0f00) << 16) |
>-                  ((sbdf & 0xffff) << 8) |
>-                  (req->addr & 0xfc);
>-            do_outp(0xcf8, 4, val);
>-
>-            /* Now issue the config space access via
>-             * port 0xCFC
>-             */
>-            req->addr = 0xcfc | (req->addr & 0x03);
>-            cpu_ioreq_pio(req);
>+        case IOREQ_TYPE_PCI_CONFIG:
>+            cpu_ioreq_config(state, req);
>             break;
>-        }
>         default:
>             hw_error("Invalid ioreq type 0x%x\n", req->type);
>     }
>@@ -1366,6 +1426,7 @@ void xen_hvm_init(PCMachineState *pcms,
>MemoryRegion **ram_memory)
>     memory_listener_register(&state->io_listener, &address_space_io);
> 
>     state->device_listener = xen_device_listener;
>+    QLIST_INIT(&state->dev_list);
>     device_listener_register(&state->device_listener);
> 
>     /* Initialize backend core & drivers */
