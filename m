Received: from eggs.gnu.org ([2001:4830:134:3::10]:56984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1duQo0-00024L-Au
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 18:15:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1duQnw-0006cd-VT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 18:15:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1duQnw-0006af-LZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 18:15:44 -0400
References: <20170906142658.58298-1-marcel@redhat.com>
	<20170906142658.58298-3-marcel@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <4ca77991-ad6a-a138-622b-b42f410fa1eb@redhat.com>
Date: Wed, 20 Sep 2017 00:15:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170906142658.58298-3-marcel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/pcie: disable IO port fwd by
 default for pcie-root-port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi Marcel,

On 09/06/17 16:26, Marcel Apfelbaum wrote:
> For most cases the devices attached to PCIe Root Ports
> do not need IO ports range, add an 'enable-io-fwd' property
> making it false by default, but keeping it true for older machines.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
>  hw/pci-bridge/gen_pcie_root_port.c | 38 ++++++++++++++++++++++++++++++++++++++
>  include/hw/compat.h                |  6 +++++-
>  2 files changed, 43 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index cb694d6da5..cbdeb73e2c 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -20,12 +20,26 @@
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  
> +#define GEN_PCIE_ROOT_PORT(obj) \
> +     OBJECT_CHECK(GenPCIERootPort, (obj), TYPE_GEN_PCIE_ROOT_PORT)
> +#define GEN_PCIE_ROOT_PORT_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(GenPCIERootPortClass, (klass), TYPE_GEN_PCIE_ROOT_PORT)
> +#define GEN_PCIE_ROOT_PORT_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(GenPCIERootPortClass, (obj), TYPE_GEN_PCIE_ROOT_PORT)
> +
> +typedef struct GenPCIERootPortClass {
> +    PCIERootPortClass parent_class;
> +
> +    DeviceRealize parent_realize;
> +} GenPCIERootPortClass;
> +
>  typedef struct GenPCIERootPort {
>      /*< private >*/
>      PCIESlot parent_obj;
>      /*< public >*/
>  
>      bool migrate_msix;
> +    bool enable_io_fwd;
>  } GenPCIERootPort;
>  
>  static uint8_t gen_rp_aer_vector(const PCIDevice *d)
> @@ -60,6 +74,25 @@ static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
>      return rp->migrate_msix;
>  }
>  
> +static void gen_rp_realize(DeviceState *d, Error **errp)
> +{
> +    GenPCIERootPortClass *grpc = GEN_PCIE_ROOT_PORT_GET_CLASS(d);
> +    GenPCIERootPort *grp = GEN_PCIE_ROOT_PORT(d);
> +    PCIDevice *pci_dev = PCI_DEVICE(d);
> +
> +    grpc->parent_realize(DEVICE(d), errp);
> +    if (*errp) {
> +        return;
> +    }
> +
> +    if (!grp->enable_io_fwd) {
> +        pci_word_test_and_clear_mask(pci_dev->wmask + PCI_COMMAND,
> +                                     PCI_COMMAND_IO);
> +        pci_dev->wmask[PCI_IO_BASE] = 0;
> +        pci_dev->wmask[PCI_IO_LIMIT] = 0;
> +    }
> +}
> +

This function exists now, but with different implementation, from
Aleksandr's commit 226263fb5cda ("hw/pci: add QEMU-specific PCI
capability to the Generic PCI Express Root Port", 2017-08-18).

It seems that we now have "grp->io_reserve" (a numeric quantity, not a
boolean), from property "io-reserve". The default value is -1.

According to the documentation added in c1800a162765 ("docs: update
documentation considering PCIE-PCI bridge", 2017-08-18), the value -1
seems to imply, "If any reservation field is -1 then this kind of
reservation is not needed and must be ignored by firmware".

I think we'll need to refine the definition. Once OVMF starts processing
this capability, the behavior should be compatible with earlier
behavior. Assume that a user sets only "mem-reserve" to something
different from -1, and thus the capability appears. When OVMF sees the
capability, it should be able to tell apart:

- no particular hint about IO space, so continue doing whatever has been
done all this time (default IO space reservation),
- do not request IO space reservation at all,
- a given (positive) size of IO space should be reserved.

So I think:

(a) the above read-only mask setting should be done based on

  (grp->io_reserve == 0)

and the "enable-io-fwd" property should be unnecessary,

(b) the "io-reserve" property should be set to 0 for 2.11 machine types
and onward, and to -1 for 2.10 and earlier (for compatibility),

(c) the documentation in "docs/pcie_pci_bridge.txt" should be updated to
say:
* (-1) --> default firmware behavior (unspecified)
*   0  --> do not reserve
*  >0  --> specific reservation requested

(d) pci_bridge_qemu_reserve_cap_init() should be updated accordingly
(i.e., a conflict exists if both mem_pref_32_reserve and
mem_pref_64_reserve are *positive*),


Second, when determining the reservations in OVMF, I would like to look
only at the capability fields, and not do a read-write-read-write
quadruplet to the IO base/limit registers. Do you agree?

Thanks!
Laszlo


>  static const VMStateDescription vmstate_rp_dev = {
>      .name = "pcie-root-port",
>      .version_id = 1,
> @@ -78,6 +111,7 @@ static const VMStateDescription vmstate_rp_dev = {
>  
>  static Property gen_rp_props[] = {
>      DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
> +    DEFINE_PROP_BOOL("enable-io-fwd", GenPCIERootPort, enable_io_fwd, false),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> @@ -86,6 +120,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>      PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(klass);
> +    GenPCIERootPortClass *grpc = GEN_PCIE_ROOT_PORT_CLASS(klass);
>  
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
> @@ -96,6 +131,8 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>      rpc->interrupts_init = gen_rp_interrupts_init;
>      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
>      rpc->aer_offset = GEN_PCIE_ROOT_PORT_AER_OFFSET;
> +    grpc->parent_realize = dc->realize;
> +    dc->realize = gen_rp_realize;
>  }
>  
>  static const TypeInfo gen_rp_dev_info = {
> @@ -103,6 +140,7 @@ static const TypeInfo gen_rp_dev_info = {
>      .parent        = TYPE_PCIE_ROOT_PORT,
>      .instance_size = sizeof(GenPCIERootPort),
>      .class_init    = gen_rp_dev_class_init,
> +    .class_size    = sizeof(GenPCIERootPortClass),
>  };
>  
>   static void gen_rp_register_types(void)
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 3e101f8f67..843bf4a3a5 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -2,7 +2,11 @@
>  #define HW_COMPAT_H
>  
>  #define HW_COMPAT_2_10 \
> -    /* empty */
> +    {\
> +        .driver   = "pcie-root-port",\
> +        .property = "enable-io-fwd",\
> +        .value    = "true",\
> +    },
>  
>  #define HW_COMPAT_2_9 \
>      {\
> 
