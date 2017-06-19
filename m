Received: from eggs.gnu.org ([2001:4830:134:3::10]:49481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMuh5-000113-NE
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dMuh2-0005hS-Df
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dMuh2-0005h0-3u
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:18:04 -0400
References: <cover.1497272778.git.maozy.fnst@cn.fujitsu.com>
	<c2f88d614b4832e915688422746ec0060b0a35f0.1497272778.git.maozy.fnst@cn.fujitsu.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <b4a36681-2393-1c76-d1ad-3e442b7e6969@redhat.com>
Date: Mon, 19 Jun 2017 14:17:50 +0300
MIME-Version: 1.0
In-Reply-To: <c2f88d614b4832e915688422746ec0060b0a35f0.1497272778.git.maozy.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 4/9] pci: Make errp the last parameter
 of pci_add_capability()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

On 12/06/2017 16:48, Mao Zhongyi wrote:
> Add Error argument for pci_add_capability() to leverage the errp
> to pass info on errors. This way is helpful for its callers to
> make a better error handling when moving to 'realize'.
> 
> Cc: pbonzini@redhat.com
> Cc: rth@twiddle.net
> Cc: ehabkost@redhat.com
> Cc: mst@redhat.com
> Cc: jasowang@redhat.com
> Cc: marcel@redhat.com
> Cc: alex.williamson@redhat.com
> Cc: armbru@redhat.com
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>   hw/i386/amd_iommu.c       | 24 +++++++++++++++++-------
>   hw/net/e1000e.c           | 30 ++++++++++++++++++------------
>   hw/net/eepro100.c         | 18 ++++++++++++++----
>   hw/pci-bridge/i82801b11.c |  1 +
>   hw/pci/pci.c              | 10 ++++------
>   hw/pci/pci_bridge.c       |  7 ++++++-
>   hw/pci/pcie.c             | 10 ++++++++--
>   hw/pci/shpc.c             |  5 ++++-
>   hw/pci/slotid_cap.c       |  7 ++++++-
>   hw/vfio/pci.c             |  9 ++++++---
>   hw/virtio/virtio-pci.c    | 12 ++++++++----
>   include/hw/pci/pci.h      |  3 ++-
>   12 files changed, 94 insertions(+), 42 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 7b6d4ea..d93ffc2 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1158,13 +1158,23 @@ static void amdvi_realize(DeviceState *dev, Error **err)
>       x86_iommu->type = TYPE_AMD;
>       qdev_set_parent_bus(DEVICE(&s->pci), &bus->qbus);
>       object_property_set_bool(OBJECT(&s->pci), true, "realized", err);
> -    s->capab_offset = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
> -                                         AMDVI_CAPAB_SIZE);
> -    assert(s->capab_offset > 0);
> -    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0, AMDVI_CAPAB_REG_SIZE);
> -    assert(ret > 0);
> -    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0, AMDVI_CAPAB_REG_SIZE);
> -    assert(ret > 0);
> +    ret = pci_add_capability(&s->pci.dev, AMDVI_CAPAB_ID_SEC, 0,
> +                                         AMDVI_CAPAB_SIZE, err);
> +    if (ret < 0) {
> +        return;
> +    }
> +    s->capab_offset = ret;
> +
> +    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_MSI, 0,
> +                             AMDVI_CAPAB_REG_SIZE, err);
> +    if (ret < 0) {
> +        return;
> +    }
> +    ret = pci_add_capability(&s->pci.dev, PCI_CAP_ID_HT, 0,
> +                             AMDVI_CAPAB_REG_SIZE, err);
> +    if (ret < 0) {
> +        return;
> +    }
>   
>       /* set up MMIO */
>       memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
> diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
> index 8259d67..d1b1a97 100644
> --- a/hw/net/e1000e.c
> +++ b/hw/net/e1000e.c
> @@ -47,6 +47,7 @@
>   #include "e1000e_core.h"
>   
>   #include "trace.h"
> +#include "qapi/error.h"
>   
>   #define TYPE_E1000E "e1000e"
>   #define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E)
> @@ -372,21 +373,26 @@ e1000e_gen_dsn(uint8_t *mac)
>   static int
>   e1000e_add_pm_capability(PCIDevice *pdev, uint8_t offset, uint16_t pmc)
>   {
> -    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset, PCI_PM_SIZEOF);
> +    Error *local_err = NULL;
> +    int ret = pci_add_capability(pdev, PCI_CAP_ID_PM, offset,
> +                                 PCI_PM_SIZEOF, &local_err);
>   
> -    if (ret > 0) {
> -        pci_set_word(pdev->config + offset + PCI_PM_PMC,
> -                     PCI_PM_CAP_VER_1_1 |
> -                     pmc);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
>   
> -        pci_set_word(pdev->wmask + offset + PCI_PM_CTRL,
> -                     PCI_PM_CTRL_STATE_MASK |
> -                     PCI_PM_CTRL_PME_ENABLE |
> -                     PCI_PM_CTRL_DATA_SEL_MASK);
> +    pci_set_word(pdev->config + offset + PCI_PM_PMC,
> +                 PCI_PM_CAP_VER_1_1 |
> +                 pmc);
>   
> -        pci_set_word(pdev->w1cmask + offset + PCI_PM_CTRL,
> -                     PCI_PM_CTRL_PME_STATUS);
> -    }
> +    pci_set_word(pdev->wmask + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_STATE_MASK |
> +                 PCI_PM_CTRL_PME_ENABLE |
> +                 PCI_PM_CTRL_DATA_SEL_MASK);
> +
> +    pci_set_word(pdev->w1cmask + offset + PCI_PM_CTRL,
> +                 PCI_PM_CTRL_PME_STATUS);
>   
>       return ret;
>   }
> diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
> index da36816..5a4774a 100644
> --- a/hw/net/eepro100.c
> +++ b/hw/net/eepro100.c
> @@ -48,6 +48,7 @@
>   #include "sysemu/sysemu.h"
>   #include "sysemu/dma.h"
>   #include "qemu/bitops.h"
> +#include "qapi/error.h"
>   
>   /* QEMU sends frames smaller than 60 bytes to ethernet nics.
>    * Such frames are rejected by real nics and their emulations.
> @@ -494,7 +495,7 @@ static void eepro100_fcp_interrupt(EEPRO100State * s)
>   }
>   #endif
>   
> -static void e100_pci_reset(EEPRO100State * s)
> +static void e100_pci_reset(EEPRO100State *s, Error **errp)
>   {
>       E100PCIDeviceInfo *info = eepro100_get_class(s);
>       uint32_t device = s->device;
> @@ -570,8 +571,12 @@ static void e100_pci_reset(EEPRO100State * s)
>           /* Power Management Capabilities */
>           int cfg_offset = 0xdc;
>           int r = pci_add_capability(&s->dev, PCI_CAP_ID_PM,
> -                                   cfg_offset, PCI_PM_SIZEOF);
> -        assert(r > 0);
> +                                   cfg_offset, PCI_PM_SIZEOF,
> +                                   errp);
> +        if (r < 0
> +            return;
> +        }
> +
>           pci_set_word(pci_conf + cfg_offset + PCI_PM_PMC, 0x7e21);
>   #if 0 /* TODO: replace dummy code for power management emulation. */
>           /* TODO: Power Management Control / Status. */
> @@ -1858,12 +1863,17 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
>   {
>       EEPRO100State *s = DO_UPCAST(EEPRO100State, dev, pci_dev);
>       E100PCIDeviceInfo *info = eepro100_get_class(s);
> +    Error *local_err = NULL;
>   
>       TRACE(OTHER, logout("\n"));
>   
>       s->device = info->device;
>   
> -    e100_pci_reset(s);
> +    e100_pci_reset(s, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>   
>       /* Add 64 * 2 EEPROM. i82557 and i82558 support a 64 word EEPROM,
>        * i82559 and later support 64 or 256 word EEPROM. */
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> index 2404e7e..2c065c3 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/i82801b11.c
> @@ -44,6 +44,7 @@
>   #include "qemu/osdep.h"
>   #include "hw/pci/pci.h"
>   #include "hw/i386/ich9.h"
> +#include "qapi/error.h"
>   
>   
>   /*****************************************************************************/
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b73bfea..2bba37a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -2264,15 +2264,13 @@ static void pci_del_option_rom(PCIDevice *pdev)
>    * in pci config space
>    */
>   int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
> -                       uint8_t offset, uint8_t size)
> +                       uint8_t offset, uint8_t size,
> +                       Error **errp)
>   {
>       int ret;
> -    Error *local_err = NULL;
>   
> -    ret = pci_add_capability2(pdev, cap_id, offset, size, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
> +    ret = pci_add_capability2(pdev, cap_id, offset, size, errp);
> +
>       return ret;
>   }
>   
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index 5118ef4..bb0f3a3 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -33,6 +33,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/pci/pci_bus.h"
>   #include "qemu/range.h"
> +#include "qapi/error.h"
>   
>   /* PCI bridge subsystem vendor ID helper functions */
>   #define PCI_SSVID_SIZEOF        8
> @@ -43,8 +44,12 @@ int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
>                             uint16_t svid, uint16_t ssid)
>   {
>       int pos;
> -    pos = pci_add_capability(dev, PCI_CAP_ID_SSVID, offset, PCI_SSVID_SIZEOF);
> +    Error *local_err = NULL;
> +
> +    pos = pci_add_capability(dev, PCI_CAP_ID_SSVID, offset,
> +                             PCI_SSVID_SIZEOF, &local_err);
>       if (pos < 0) {
> +        error_report_err(local_err);
>           return pos;
>       }
>   
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 18e634f..f187512 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -91,11 +91,14 @@ int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type, uint8_t port)
>       /* PCIe cap v2 init */
>       int pos;
>       uint8_t *exp_cap;
> +    Error *local_err = NULL;
>   
>       assert(pci_is_express(dev));
>   
> -    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset, PCI_EXP_VER2_SIZEOF);
> +    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
> +                             PCI_EXP_VER2_SIZEOF, &local_err);
>       if (pos < 0) {
> +        error_report_err(local_err);
>           return pos;
>       }
>       dev->exp.exp_cap = pos;
> @@ -123,11 +126,14 @@ int pcie_cap_v1_init(PCIDevice *dev, uint8_t offset, uint8_t type,
>   {
>       /* PCIe cap v1 init */
>       int pos;
> +    Error *local_err = NULL;
>   
>       assert(pci_is_express(dev));
>   
> -    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset, PCI_EXP_VER1_SIZEOF);
> +    pos = pci_add_capability(dev, PCI_CAP_ID_EXP, offset,
> +                             PCI_EXP_VER1_SIZEOF, &local_err);
>       if (pos < 0) {
> +        error_report_err(local_err);
>           return pos;
>       }
>       dev->exp.exp_cap = pos;
> diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
> index 42fafac..d72d5e4 100644
> --- a/hw/pci/shpc.c
> +++ b/hw/pci/shpc.c
> @@ -450,9 +450,12 @@ static int shpc_cap_add_config(PCIDevice *d)
>   {
>       uint8_t *config;
>       int config_offset;
> +    Error *local_err = NULL;
>       config_offset = pci_add_capability(d, PCI_CAP_ID_SHPC,
> -                                       0, SHPC_CAP_LENGTH);
> +                                       0, SHPC_CAP_LENGTH,
> +                                       &local_err);
>       if (config_offset < 0) {
> +        error_report_err(local_err);
>           return config_offset;
>       }
>       config = d->config + config_offset;
> diff --git a/hw/pci/slotid_cap.c b/hw/pci/slotid_cap.c
> index aec1e91..bdca205 100644
> --- a/hw/pci/slotid_cap.c
> +++ b/hw/pci/slotid_cap.c
> @@ -2,6 +2,7 @@
>   #include "hw/pci/slotid_cap.h"
>   #include "hw/pci/pci.h"
>   #include "qemu/error-report.h"
> +#include "qapi/error.h"
>   
>   #define SLOTID_CAP_LENGTH 4
>   #define SLOTID_NSLOTS_SHIFT ctz32(PCI_SID_ESR_NSLOTS)
> @@ -11,6 +12,8 @@ int slotid_cap_init(PCIDevice *d, int nslots,
>                       unsigned offset)
>   {
>       int cap;
> +    Error *local_err = NULL;
> +
>       if (!chassis) {
>           error_report("Bridge chassis not specified. Each bridge is required "
>                        "to be assigned a unique chassis id > 0.");
> @@ -21,8 +24,10 @@ int slotid_cap_init(PCIDevice *d, int nslots,
>           return -EINVAL;
>       }
>   
> -    cap = pci_add_capability(d, PCI_CAP_ID_SLOTID, offset, SLOTID_CAP_LENGTH);
> +    cap = pci_add_capability(d, PCI_CAP_ID_SLOTID, offset,
> +                             SLOTID_CAP_LENGTH, &local_err);
>       if (cap < 0) {
> +        error_report_err(local_err);
>           return cap;
>       }
>       /* We make each chassis unique, this way each bridge is First in Chassis */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 5881968..70bfb59 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1743,11 +1743,14 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
>                                  PCI_EXP_LNKCAP_MLW | PCI_EXP_LNKCAP_SLS);
>       }
>   
> -    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size);
> -    if (pos > 0) {
> -        vdev->pdev.exp.exp_cap = pos;
> +    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
> +                             errp);
> +    if (pos < 0) {
> +        return pos;
>       }
>   
> +    vdev->pdev.exp.exp_cap = pos;
> +
>       return pos;
>   }
>   
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index f9b7244..1fc5059 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -1162,8 +1162,8 @@ static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
>       PCIDevice *dev = &proxy->pci_dev;
>       int offset;
>   
> -    offset = pci_add_capability(dev, PCI_CAP_ID_VNDR, 0, cap->cap_len);
> -    assert(offset > 0);
> +    offset = pci_add_capability(dev, PCI_CAP_ID_VNDR, 0,
> +                                cap->cap_len, &error_abort);
>   
>       assert(cap->cap_len >= sizeof *cap);
>       memcpy(dev->config + offset + PCI_CAP_FLAGS, &cap->cap_len,
> @@ -1810,8 +1810,12 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
>           pos = pcie_endpoint_cap_init(pci_dev, 0);
>           assert(pos > 0);
>   
> -        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0, PCI_PM_SIZEOF);
> -        assert(pos > 0);
> +        pos = pci_add_capability(pci_dev, PCI_CAP_ID_PM, 0,
> +                                 PCI_PM_SIZEOF, errp);
> +        if (pos < 0) {
> +            return;
> +        }
> +
>           pci_dev->exp.pm_cap = pos;
>   
>           /*
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index a37a2d5..fe52aa8 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -356,7 +356,8 @@ void pci_unregister_vga(PCIDevice *pci_dev);
>   pcibus_t pci_get_bar_addr(PCIDevice *pci_dev, int region_num);
>   
>   int pci_add_capability(PCIDevice *pdev, uint8_t cap_id,
> -                       uint8_t offset, uint8_t size);
> +                       uint8_t offset, uint8_t size,
> +                       Error **errp);
>   int pci_add_capability2(PCIDevice *pdev, uint8_t cap_id,
>                          uint8_t offset, uint8_t size,
>                          Error **errp);
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
