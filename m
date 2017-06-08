Received: from eggs.gnu.org ([2001:4830:134:3::10]:56948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dItJv-0007dC-KF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:01:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dItJs-0001US-Hx
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dItJs-0001UA-9f
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 05:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 142CCC04B92D
	for <qemu-devel@nongnu.org>; Thu,  8 Jun 2017 09:01:31 +0000 (UTC)
Date: Thu, 8 Jun 2017 10:01:23 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170608090123.GA2082@work-vm>
References: <20170607124359.79478-1-marcel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607124359.79478-1-marcel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V2] hw/pcie: fix the generic pcie root port
 to support migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com

* Marcel Apfelbaum (marcel@redhat.com) wrote:
> Add msix state to pcie-root-ports's vmstate
> in order to support migration.
> 
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
> ---
> v1 -> v2:
>  - Added x-migrate-msix compat property to avoid
>    breaking migration (Dave)
> 
>  hw/pci-bridge/gen_pcie_root_port.c | 25 +++++++++++++++++++++++++
>  include/hw/compat.h                |  4 ++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/hw/pci-bridge/gen_pcie_root_port.c b/hw/pci-bridge/gen_pcie_root_port.c
> index 8ebffa8..cb694d6 100644
> --- a/hw/pci-bridge/gen_pcie_root_port.c
> +++ b/hw/pci-bridge/gen_pcie_root_port.c
> @@ -20,6 +20,14 @@
>  #define GEN_PCIE_ROOT_PORT_AER_OFFSET           0x100
>  #define GEN_PCIE_ROOT_PORT_MSIX_NR_VECTOR       1
>  
> +typedef struct GenPCIERootPort {
> +    /*< private >*/
> +    PCIESlot parent_obj;
> +    /*< public >*/
> +
> +    bool migrate_msix;
> +} GenPCIERootPort;
> +
>  static uint8_t gen_rp_aer_vector(const PCIDevice *d)
>  {
>      return 0;
> @@ -45,6 +53,13 @@ static void gen_rp_interrupts_uninit(PCIDevice *d)
>      msix_uninit_exclusive_bar(d);
>  }
>  
> +static bool gen_rp_test_migrate_msix(void *opaque, int version_id)
> +{
> +    GenPCIERootPort *rp = opaque;
> +
> +    return rp->migrate_msix;
> +}
> +
>  static const VMStateDescription vmstate_rp_dev = {
>      .name = "pcie-root-port",
>      .version_id = 1,
> @@ -54,10 +69,18 @@ static const VMStateDescription vmstate_rp_dev = {
>          VMSTATE_PCI_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
>          VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
>                         PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
> +        VMSTATE_MSIX_TEST(parent_obj.parent_obj.parent_obj.parent_obj,
> +                          GenPCIERootPort,
> +                          gen_rp_test_migrate_msix),

So that's  GenPCIERootPort,
    parent_obj is PCIESlot
    parent_obj is PCIEPort
    parent_obj is PCIEBridge
    parent_obj is PCIDevice

and msix_save is expecting a PCIDevice, so yep.

>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
> +static Property gen_rp_props[] = {
> +    DEFINE_PROP_BOOL("x-migrate-msix", GenPCIERootPort, migrate_msix, true),
> +    DEFINE_PROP_END_OF_LIST()
> +};
> +
>  static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -68,6 +91,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
>      dc->desc = "PCI Express Root Port";
>      dc->vmsd = &vmstate_rp_dev;
> +    dc->props = gen_rp_props;
>      rpc->aer_vector = gen_rp_aer_vector;
>      rpc->interrupts_init = gen_rp_interrupts_init;
>      rpc->interrupts_uninit = gen_rp_interrupts_uninit;
> @@ -77,6 +101,7 @@ static void gen_rp_dev_class_init(ObjectClass *klass, void *data)
>  static const TypeInfo gen_rp_dev_info = {
>      .name          = TYPE_GEN_PCIE_ROOT_PORT,
>      .parent        = TYPE_PCIE_ROOT_PORT,
> +    .instance_size = sizeof(GenPCIERootPort),
>      .class_init    = gen_rp_dev_class_init,
>  };
>  
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 55b1765..4fb6a19 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -6,6 +6,10 @@
>          .driver   = "pci-bridge",\
>          .property = "shpc",\
>          .value    = "off",\
> +    },{\
> +        .driver   = "pcie-root-port",\
> +        .property = "x-migrate-msix",\
> +        .value    = "false",\

You could lose the x-  but that's OK.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      },
>  
>  #define HW_COMPAT_2_8 \
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
