Received: from eggs.gnu.org ([2001:4830:134:3::10]:47060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1daLLH-0006zV-4H
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1daLLF-00044t-U8
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:23:07 -0400
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<1495537965-4187-2-git-send-email-diana.craciun@nxp.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <17ae81be-a86e-d0ab-de93-046846e0b7d2@redhat.com>
Date: Wed, 26 Jul 2017 14:22:50 +0200
MIME-Version: 1.0
In-Reply-To: <1495537965-4187-2-git-send-email-diana.craciun@nxp.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Increased the size of requester_id
 field from MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Diana Craciun <diana.craciun@nxp.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, mike.caraman@nxp.com, qemu-arm@nongnu.org, marcel@redhat.com, bharat.bhushan@nxp.com, christoffer.dall@linaro.org, laurentiu.tudor@nxp.com

Hi Diana,
On 23/05/2017 13:12, Diana Craciun wrote:
> The PCI requester ID field is 16 bits. The requester_id field
> from MemTxAttrs is used for MSIs to specify the device ID for
> the platforms where this device ID is needed (e.g virt machine + GICv3
> ITS). However, if more entities that uses MSIs in the system are used,
> 16 bit is no longer enough to represent the device ID. Increased the size
> of this field to 24 bits in order to accomodate 256 entities.
> Also the name requester_id does no longer reflect the content, so
> the name was changed to stream_id.

I think both deviceid and streamid can be up to 32 bits in theory.

With respect to the renaming, stream_id really is ARM specific and
corresponds to the ID space before the SMMU while you mostly address
device id problematics here (ie. space id input to the interrupt
controller). Maybe a more generic terminology such as originator id
could be used or source id (I think this is Intel terminology though).

Maybe the changes in semantics of the field should be
associated/combined with its new computation found in next patch? see
comments in subsequent patch.

Thanks

Eric

> 
> Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
> ---
>  hw/i386/amd_iommu.c                    | 2 +-
>  hw/i386/intel_iommu.c                  | 2 +-
>  hw/intc/arm_gicv3_its_common.c         | 2 +-
>  hw/intc/arm_gicv3_its_kvm.c            | 2 +-
>  hw/pci/msi.c                           | 2 +-
>  include/exec/memattrs.h                | 4 ++--
>  include/hw/intc/arm_gicv3_its_common.h | 2 +-
>  7 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index f86a40a..b61bdd5 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -145,7 +145,7 @@ static void amdvi_generate_msi_interrupt(AMDVIState *s)
>  {
>      MSIMessage msg = {};
>      MemTxAttrs attrs = {
> -        .requester_id = pci_requester_id(&s->pci.dev)
> +        .stream_id = pci_requester_id(&s->pci.dev)
>      };
>  
>      if (msi_enabled(&s->pci.dev)) {
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 02f047c..9cdcc62 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2597,7 +2597,7 @@ static MemTxResult vtd_mem_ir_write(void *opaque, hwaddr addr,
>  
>      if (!attrs.unspecified) {
>          /* We have explicit Source ID */
> -        sid = attrs.requester_id;
> +        sid = attrs.stream_id;
>      }
>  
>      ret = vtd_interrupt_remap_msi(opaque, &from, &to, sid);
> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
> index 9d67c5c..efdb1b3 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -66,7 +66,7 @@ static MemTxResult gicv3_its_trans_write(void *opaque, hwaddr offset,
>      if (offset == 0x0040 && ((size == 2) || (size == 4))) {
>          GICv3ITSState *s = ARM_GICV3_ITS_COMMON(opaque);
>          GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
> -        int ret = c->send_msi(s, le64_to_cpu(value), attrs.requester_id);
> +        int ret = c->send_msi(s, le64_to_cpu(value), attrs.stream_id);
>  
>          if (ret <= 0) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index bd4f3aa..9006907 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -29,7 +29,7 @@
>  #define TYPE_KVM_ARM_ITS "arm-its-kvm"
>  #define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
>  
> -static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
> +static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint32_t devid)
>  {
>      struct kvm_msi msi;
>  
> diff --git a/hw/pci/msi.c b/hw/pci/msi.c
> index a87b227..7925851 100644
> --- a/hw/pci/msi.c
> +++ b/hw/pci/msi.c
> @@ -336,7 +336,7 @@ void msi_send_message(PCIDevice *dev, MSIMessage msg)
>  {
>      MemTxAttrs attrs = {};
>  
> -    attrs.requester_id = pci_requester_id(dev);
> +    attrs.stream_id = pci_requester_id(dev);
>      address_space_stl_le(&dev->bus_master_as, msg.address, msg.data,
>                           attrs, NULL);
>  }
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index e601061..b13e1b8 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -35,8 +35,8 @@ typedef struct MemTxAttrs {
>      unsigned int secure:1;
>      /* Memory access is usermode (unprivileged) */
>      unsigned int user:1;
> -    /* Requester ID (for MSI for example) */
> -    unsigned int requester_id:16;
> +    /* Stream ID (for MSI for example) */
> +    unsigned int stream_id:24;
>  } MemTxAttrs;
>  
>  /* Bus masters which don't specify any attributes will get this,
> diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
> index 1ba1894..6140fc6 100644
> --- a/include/hw/intc/arm_gicv3_its_common.h
> +++ b/include/hw/intc/arm_gicv3_its_common.h
> @@ -68,7 +68,7 @@ struct GICv3ITSCommonClass {
>      SysBusDeviceClass parent_class;
>      /*< public >*/
>  
> -    int (*send_msi)(GICv3ITSState *s, uint32_t data, uint16_t devid);
> +    int (*send_msi)(GICv3ITSState *s, uint32_t data, uint32_t devid);
>      void (*pre_save)(GICv3ITSState *s);
>      void (*post_load)(GICv3ITSState *s);
>  };
> 
