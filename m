Received: from eggs.gnu.org ([2001:4830:134:3::10]:52241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEFIp-0007of-NV
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1fEFIi-0007xj-I9
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:33:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49228 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1fEFIi-0007xJ-C0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:33:40 -0400
References: <20180501162901.28940.1075.stgit@gimli.home>
	<20180501164332.28940.40383.stgit@gimli.home>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <dbe7f81f-4301-62fe-34e6-0a1f2094da57@redhat.com>
Date: Thu, 3 May 2018 16:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180501164332.28940.40383.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] vfio/quirks: ioeventfd quirk
 acceleration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, kvm@vger.kernel.org

Hi Alex,

On 05/01/2018 06:43 PM, Alex Williamson wrote:
> The NVIDIA BAR0 quirks virtualize the PCI config space mirrors found
> in device MMIO space.  Normally PCI config space is considered a slow
> path and further optimization is unnecessary, however NVIDIA uses a
> register here to enable the MSI interrupt to re-trigger.  Exiting to
> QEMU for this MSI-ACK handling can therefore rate limit our interrupt
> handling.  Fortunately the MSI-ACK write is easily detected since the
> quirk MemoryRegion otherwise has very few accesses, so simply looking
> for consecutive writes with the same data is sufficient, in this case
> 10 consecutive writes with the same data and size is arbitrarily
> chosen.  We configure the KVM ioeventfd with data match, so there's
> no risk of triggering for the wrong data or size, but we do risk that
> pathological driver behavior might consume all of QEMU's file
> descriptors, so we cap ourselves to 10 ioeventfds for this purpose.
> 
> In support of the above, generic ioeventfd infrastructure is added
> for vfio quirks.  This automatically initializes an ioeventfd list
> per quirk, disables and frees ioeventfds on exit, and allows
> ioeventfds marked as dynamic to be dropped on device reset.  The
> rationale for this latter feature is that useful ioeventfds may
> depend on specific driver behavior and since we necessarily place a
> cap on our use of ioeventfds, a machine reset is a reasonable point
> at which to assume a new driver and re-profile.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci-quirks.c |  174 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.c        |    2 +
>  hw/vfio/pci.h        |   15 ++++
>  hw/vfio/trace-events |    3 +
>  4 files changed, 192 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index f0947cbf152f..4cedc733bc0a 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -12,6 +12,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/error-report.h"
> +#include "qemu/main-loop.h"
>  #include "qemu/range.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> @@ -202,6 +203,7 @@ typedef struct VFIOConfigMirrorQuirk {
>      uint32_t offset;
>      uint8_t bar;
>      MemoryRegion *mem;
> +    uint8_t data[];
>  } VFIOConfigMirrorQuirk;
>  
>  static uint64_t vfio_generic_quirk_mirror_read(void *opaque,
> @@ -278,12 +280,98 @@ static const MemoryRegionOps vfio_ati_3c3_quirk = {
>  static VFIOQuirk *vfio_quirk_alloc(int nr_mem)
>  {
>      VFIOQuirk *quirk = g_new0(VFIOQuirk, 1);
> +    QLIST_INIT(&quirk->ioeventfds);
>      quirk->mem = g_new0(MemoryRegion, nr_mem);
>      quirk->nr_mem = nr_mem;
>  
>      return quirk;
>  }
>  
> +static void vfio_ioeventfd_exit(VFIOIOEventFD *ioeventfd)
> +{
> +    QLIST_REMOVE(ioeventfd, next);
> +    memory_region_del_eventfd(ioeventfd->mr, ioeventfd->addr, ioeventfd->size,
> +                              ioeventfd->match_data, ioeventfd->data,
> +                              &ioeventfd->e);
> +    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e), NULL, NULL, NULL);
> +    event_notifier_cleanup(&ioeventfd->e);
> +    trace_vfio_ioeventfd_exit(memory_region_name(ioeventfd->mr),
> +                              (uint64_t)ioeventfd->addr, ioeventfd->size,
> +                              ioeventfd->data);
> +    g_free(ioeventfd);
> +}
> +
> +static void vfio_drop_dynamic_eventfds(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
> +{
> +    VFIOIOEventFD *ioeventfd, *tmp;
> +
> +    QLIST_FOREACH_SAFE(ioeventfd, &quirk->ioeventfds, next, tmp) {
> +        if (ioeventfd->dynamic) {
> +            vfio_ioeventfd_exit(ioeventfd);
> +        }
> +    }
> +}
> +
> +static void vfio_ioeventfd_handler(void *opaque)
> +{
> +    VFIOIOEventFD *ioeventfd = opaque;
> +
> +    if (event_notifier_test_and_clear(&ioeventfd->e)) {
> +        vfio_region_write(ioeventfd->region, ioeventfd->region_addr,
> +                          ioeventfd->data, ioeventfd->size);
> +        trace_vfio_ioeventfd_handler(memory_region_name(ioeventfd->mr),
> +                                     (uint64_t)ioeventfd->addr, ioeventfd->size,
> +                                     ioeventfd->data);
> +    }
> +}
> +
> +static VFIOIOEventFD *vfio_ioeventfd_init(VFIOPCIDevice *vdev,
> +                                          MemoryRegion *mr, hwaddr addr,
> +                                          unsigned size, uint64_t data,
> +                                          VFIORegion *region,
> +                                          hwaddr region_addr, bool dynamic)
> +{
> +    VFIOIOEventFD *ioeventfd;
> +
> +    if (vdev->no_kvm_ioeventfd) {
> +        return NULL;
> +    }
> +
> +    ioeventfd = g_malloc0(sizeof(*ioeventfd));
> +
> +    if (event_notifier_init(&ioeventfd->e, 0)) {
> +        g_free(ioeventfd);
> +        return NULL;
> +    }
> +
> +    /*
> +     * MemoryRegion and relative offset, plus additional ioeventfd setup
> +     * parameters for configuring and later tearing down KVM ioeventfd.
> +     */
> +    ioeventfd->mr = mr;
> +    ioeventfd->addr = addr;
> +    ioeventfd->size = size;
> +    ioeventfd->data = data;
> +    ioeventfd->match_data = true;
> +    ioeventfd->dynamic = dynamic;
> +    /*
> +     * VFIORegion and relative offset for implementing the userspace
> +     * handler.  data & size fields shared for both uses.
> +     */
> +    ioeventfd->region = region;
> +    ioeventfd->region_addr = region_addr;
> +
> +    qemu_set_fd_handler(event_notifier_get_fd(&ioeventfd->e),
> +                        vfio_ioeventfd_handler, NULL, ioeventfd);
> +    memory_region_add_eventfd(ioeventfd->mr, ioeventfd->addr,
> +                              ioeventfd->size, ioeventfd->match_data,
> +                              ioeventfd->data, &ioeventfd->e);
> +    trace_vfio_ioeventfd_init(memory_region_name(mr), (uint64_t)addr,
> +                              size, data);
> +
> +    return ioeventfd;
> +}
> +
>  static void vfio_vga_probe_ati_3c3_quirk(VFIOPCIDevice *vdev)
>  {
>      VFIOQuirk *quirk;
> @@ -719,6 +807,17 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
>      trace_vfio_quirk_nvidia_bar5_probe(vdev->vbasedev.name);
>  }
>  
> +typedef struct LastDataSet {
> +    hwaddr addr;
> +    uint64_t data;
> +    unsigned size;
> +    int hits;
> +    int added;
> +} LastDataSet;
> +
> +#define MAX_DYN_IOEVENTFD 10
> +#define HITS_FOR_IOEVENTFD 10
> +
>  /*
>   * Finally, BAR0 itself.  We want to redirect any accesses to either
>   * 0x1800 or 0x88000 through the PCI config space access functions.
> @@ -729,6 +828,7 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
>      VFIOConfigMirrorQuirk *mirror = opaque;
>      VFIOPCIDevice *vdev = mirror->vdev;
>      PCIDevice *pdev = &vdev->pdev;
> +    LastDataSet *last = (LastDataSet *)&mirror->data;
>  
>      vfio_generic_quirk_mirror_write(opaque, addr, data, size);
>  
> @@ -743,6 +843,60 @@ static void vfio_nvidia_quirk_mirror_write(void *opaque, hwaddr addr,
>                            addr + mirror->offset, data, size);
>          trace_vfio_quirk_nvidia_bar0_msi_ack(vdev->vbasedev.name);
>      }
> +
> +    /*
> +     * Automatically add an ioeventfd to handle any repeated write with the
> +     * same data and size above the standard PCI config space header.  This is
> +     * primarily expected to accelerate the MSI-ACK behavior, such as noted
> +     * above.  Current hardware/drivers should trigger an ioeventfd at config
> +     * offset 0x704 (region offset 0x88704), with data 0x0, size 4.
> +     *
> +     * The criteria of 10 successive hits is arbitrary but reliably adds the
> +     * MSI-ACK region.  Note that as some writes are bypassed via the ioeventfd,
> +     * the remaining ones have a greater chance of being seen successively.
> +     * To avoid the pathological case of burning up all of QEMU's open file
> +     * handles, arbitrarily limit this algorithm from adding no more than 10
> +     * ioeventfds, print an error if we would have added an 11th, and then
> +     * stop counting.
> +     */
> +    if (!vdev->no_kvm_ioeventfd &&
> +        addr > PCI_STD_HEADER_SIZEOF && last->added < MAX_DYN_IOEVENTFD + 1) {
nit: <= MAX_DYN_IOEVENTFD?
> +        if (addr != last->addr || data != last->data || size != last->size) {
> +            last->addr = addr;
> +            last->data = data;
> +            last->size = size;
> +            last->hits = 1;
> +        } else if (++last->hits >= HITS_FOR_IOEVENTFD) {
> +            if (last->added < MAX_DYN_IOEVENTFD) {
> +                VFIOIOEventFD *ioeventfd;
> +                ioeventfd = vfio_ioeventfd_init(vdev, mirror->mem, addr, size,
> +                                        data, &vdev->bars[mirror->bar].region,
> +                                        mirror->offset + addr, true);
> +                if (ioeventfd) {
> +                    VFIOQuirk *quirk;
> +
> +                    QLIST_FOREACH(quirk,
> +                                  &vdev->bars[mirror->bar].quirks, next) {
> +                        if (quirk->data == mirror) {
> +                            QLIST_INSERT_HEAD(&quirk->ioeventfds,
> +                                              ioeventfd, next);
> +                            break;
> +                        }
> +                    }
> +
> +                    assert(quirk != NULL); /* Check not found */
> +
> +                    last->added++;
> +                }
> +            } else {
> +                last->added++;
> +
> +                error_report("NVIDIA ioeventfd queue full for %s, unable to "
> +                             "accelerate 0x%"HWADDR_PRIx", data 0x%"PRIx64", "
> +                             "size %u", vdev->vbasedev.name, addr, data, size);
nit: warn_report?

> +            }
> +        }
> +    }
>  }
>  
>  static const MemoryRegionOps vfio_nvidia_mirror_quirk = {
> @@ -751,6 +905,16 @@ static const MemoryRegionOps vfio_nvidia_mirror_quirk = {
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>  
> +static void vfio_nvidia_bar0_quirk_reset(VFIOPCIDevice *vdev, VFIOQuirk *quirk)
> +{
> +    VFIOConfigMirrorQuirk *mirror = quirk->data;
> +    LastDataSet *last = (LastDataSet *)&mirror->data;
> +
> +    memset(last, 0, sizeof(*last));
> +
> +    vfio_drop_dynamic_eventfds(vdev, quirk);
> +}
> +
>  static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>  {
>      VFIOQuirk *quirk;
> @@ -763,7 +927,8 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      }
>  
>      quirk = vfio_quirk_alloc(1);
> -    mirror = quirk->data = g_malloc0(sizeof(*mirror));
> +    quirk->reset = vfio_nvidia_bar0_quirk_reset;
> +    mirror = quirk->data = g_malloc0(sizeof(*mirror) + sizeof(LastDataSet));
>      mirror->mem = quirk->mem;
>      mirror->vdev = vdev;
>      mirror->offset = 0x88000;
> @@ -781,7 +946,8 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      /* The 0x1800 offset mirror only seems to get used by legacy VGA */
>      if (vdev->vga) {
>          quirk = vfio_quirk_alloc(1);
> -        mirror = quirk->data = g_malloc0(sizeof(*mirror));
> +        quirk->reset = vfio_nvidia_bar0_quirk_reset;
> +        mirror = quirk->data = g_malloc0(sizeof(*mirror) + sizeof(LastDataSet));
>          mirror->mem = quirk->mem;
>          mirror->vdev = vdev;
>          mirror->offset = 0x1800;
> @@ -1668,6 +1834,10 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
>      int i;
>  
>      QLIST_FOREACH(quirk, &bar->quirks, next) {
> +        while (!QLIST_EMPTY(&quirk->ioeventfds)) {
> +            vfio_ioeventfd_exit(QLIST_FIRST(&quirk->ioeventfds));
> +        }
> +
>          for (i = 0; i < quirk->nr_mem; i++) {
>              memory_region_del_subregion(bar->region.mem, &quirk->mem[i]);
>          }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 65446fb42845..ba1239551115 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3175,6 +3175,8 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
>      DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
>                       no_geforce_quirks, false),
> +    DEFINE_PROP_BOOL("x-no-kvm-ioeventfd", VFIOPCIDevice, no_kvm_ioeventfd,
> +                     false),
>      DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 594a5bd00593..dbb3aca9b3d2 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -24,9 +24,23 @@
>  
>  struct VFIOPCIDevice;
>  
> +typedef struct VFIOIOEventFD {
> +    QLIST_ENTRY(VFIOIOEventFD) next;
> +    MemoryRegion *mr;
> +    hwaddr addr;
> +    unsigned size;
> +    uint64_t data;
> +    EventNotifier e;
> +    VFIORegion *region;
> +    hwaddr region_addr;
> +    bool match_data;
> +    bool dynamic;
maybe the "dynamic" semantics may be docuemnted in the code and not only
in the commit message.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> +} VFIOIOEventFD;
> +
>  typedef struct VFIOQuirk {
>      QLIST_ENTRY(VFIOQuirk) next;
>      void *data;
> +    QLIST_HEAD(, VFIOIOEventFD) ioeventfds;
>      int nr_mem;
>      MemoryRegion *mem;
>      void (*reset)(struct VFIOPCIDevice *vdev, struct VFIOQuirk *quirk);
> @@ -149,6 +163,7 @@ typedef struct VFIOPCIDevice {
>      bool no_kvm_msi;
>      bool no_kvm_msix;
>      bool no_geforce_quirks;
> +    bool no_kvm_ioeventfd;
>      VFIODisplay *dpy;
>  } VFIOPCIDevice;
>  
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 20109cb7581f..f8f97d1ff90c 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -77,6 +77,9 @@ vfio_quirk_ati_bonaire_reset_no_smc(const char *name) "%s"
>  vfio_quirk_ati_bonaire_reset_timeout(const char *name) "%s"
>  vfio_quirk_ati_bonaire_reset_done(const char *name) "%s"
>  vfio_quirk_ati_bonaire_reset(const char *name) "%s"
> +vfio_ioeventfd_exit(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
> +vfio_ioeventfd_handler(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d] -> 0x%"PRIx64
> +vfio_ioeventfd_init(const char *name, uint64_t addr, unsigned size, uint64_t data) "%s+0x%"PRIx64"[%d]:0x%"PRIx64
>  vfio_pci_igd_bar4_write(const char *name, uint32_t index, uint32_t data, uint32_t base) "%s [0x%03x] 0x%08x -> 0x%08x"
>  vfio_pci_igd_bdsm_enabled(const char *name, int size) "%s %dMB"
>  vfio_pci_igd_opregion_enabled(const char *name) "%s"
> 
> 
