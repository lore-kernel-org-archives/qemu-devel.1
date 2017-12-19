Received: from eggs.gnu.org ([2001:4830:134:3::10]:55608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRBbV-00042R-NC
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:42:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1eRBbR-0005QN-HD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:42:17 -0500
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:42904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1eRBbR-0005PN-B3
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 01:42:13 -0500
Received: by mail-it0-x244.google.com with SMTP id p139so1536654itb.1
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 22:42:13 -0800 (PST)
References: <1513618512-30070-1-git-send-email-thuth@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4e9ce0ac-e4d3-318b-3675-06b33498b45d@ozlabs.ru>
Date: Tue, 19 Dec 2017 17:42:07 +1100
MIME-Version: 1.0
In-Reply-To: <1513618512-30070-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: Remove the deprecated
 spapr-pci-vfio-host-bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

On 19/12/17 04:35, Thomas Huth wrote:
> It's a deprecated dummy device since QEMU v2.6.0. That should have
> been enough time to allow the users to update their scripts in case
> they still use it, so let's remove this legacy code now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

> ---
>  hw/ppc/spapr_pci_vfio.c   | 47 -----------------------------------------------
>  qemu-doc.texi             |  5 -----
>  scripts/device-crash-test |  1 -
>  3 files changed, 53 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
> index 8448e0b..053efb0 100644
> --- a/hw/ppc/spapr_pci_vfio.c
> +++ b/hw/ppc/spapr_pci_vfio.c
> @@ -29,31 +29,6 @@
>  #include "qemu/error-report.h"
>  #include "sysemu/qtest.h"
>  
> -#define TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE "spapr-pci-vfio-host-bridge"
> -
> -#define SPAPR_PCI_VFIO_HOST_BRIDGE(obj) \
> -    OBJECT_CHECK(sPAPRPHBVFIOState, (obj), TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE)
> -
> -typedef struct sPAPRPHBVFIOState sPAPRPHBVFIOState;
> -
> -struct sPAPRPHBVFIOState {
> -    sPAPRPHBState phb;
> -
> -    int32_t iommugroupid;
> -};
> -
> -static Property spapr_phb_vfio_properties[] = {
> -    DEFINE_PROP_INT32("iommu", sPAPRPHBVFIOState, iommugroupid, -1),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
> -static void spapr_phb_vfio_instance_init(Object *obj)
> -{
> -    if (!qtest_enabled()) {
> -        error_report("spapr-pci-vfio-host-bridge is deprecated");
> -    }
> -}
> -
>  bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
>  {
>      return vfio_eeh_as_ok(&sphb->iommu_as);
> @@ -218,25 +193,3 @@ int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
>  
>      return RTAS_OUT_SUCCESS;
>  }
> -
> -static void spapr_phb_vfio_class_init(ObjectClass *klass, void *data)
> -{
> -    DeviceClass *dc = DEVICE_CLASS(klass);
> -
> -    dc->props = spapr_phb_vfio_properties;
> -}
> -
> -static const TypeInfo spapr_phb_vfio_info = {
> -    .name          = TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE,
> -    .parent        = TYPE_SPAPR_PCI_HOST_BRIDGE,
> -    .instance_size = sizeof(sPAPRPHBVFIOState),
> -    .instance_init = spapr_phb_vfio_instance_init,
> -    .class_init    = spapr_phb_vfio_class_init,
> -};
> -
> -static void spapr_pci_vfio_register_types(void)
> -{
> -    type_register_static(&spapr_phb_vfio_info);
> -}
> -
> -type_init(spapr_pci_vfio_register_types)
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index f7317df..14d818d 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2533,11 +2533,6 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
>  The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
>  or ``ivshmem-doorbell`` device types.
>  
> -@subsection spapr-pci-vfio-host-bridge (since 2.6.0)
> -
> -The ``spapr-pci-vfio-host-bridge'' device type is replaced by
> -the ``spapr-pci-host-bridge'' device type.
> -
>  @section System emulator machines
>  
>  @subsection Xilinx EP108 (since 2.11.0)
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index 1aca55f..7417177 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -119,7 +119,6 @@ ERROR_WHITELIST = [
>      {'device':'scsi-generic', 'expected':True},            # drive property not set
>      {'device':'scsi-hd', 'expected':True},                 # drive property not set
>      {'device':'spapr-pci-host-bridge', 'expected':True},   # BUID not specified for PHB
> -    {'device':'spapr-pci-vfio-host-bridge', 'expected':True}, # BUID not specified for PHB
>      {'device':'spapr-rng', 'expected':True},               # spapr-rng needs an RNG backend!
>      {'device':'spapr-vty', 'expected':True},               # chardev property not set
>      {'device':'tpm-tis', 'expected':True},                 # tpm_tis: backend driver with id (null) could not be found
> 


-- 
Alexey
