Received: from eggs.gnu.org ([2001:4830:134:3::10]:44911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAuCd-0007q2-SS
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAuCY-0004NU-2d
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:57:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAuCW-0004K2-1f
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 05:57:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id e187-v6so12377948wmf.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 02:57:42 -0700 (PDT)
References: <1539315629-5424-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e2236f30-1927-22e0-c548-bcd4c7ad3793@redhat.com>
Date: Fri, 12 Oct 2018 11:57:39 +0200
MIME-Version: 1.0
In-Reply-To: <1539315629-5424-1-git-send-email-liq3ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vfio-pci: make vfio-pci device more QOM
 conventional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>, alex.williamson@redhat.com
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

On 12/10/2018 05:40, Li Qiang wrote:
> Define a TYPE_VFIO_PCI and drop DO_UPCAST.
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/vfio/pci.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 866f0deeb7..3f232aedff 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -37,6 +37,9 @@
>  
>  #define MSIX_CAP_LENGTH 12
>  
> +#define TYPE_VFIO_PCI "vfio-pci"
> +#define PCI_VFIO(obj)    OBJECT_CHECK(VFIOPCIDevice, obj, TYPE_VFIO_PCI)
> +
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>  
> @@ -222,7 +225,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>  
>  static void vfio_intx_update(PCIDevice *pdev)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      PCIINTxRoute route;
>      Error *err = NULL;
>  
> @@ -477,7 +480,7 @@ static void vfio_update_kvm_msi_virq(VFIOMSIVector *vector, MSIMessage msg,
>  static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>                                     MSIMessage *msg, IOHandler *handler)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      VFIOMSIVector *vector;
>      int ret;
>  
> @@ -574,7 +577,7 @@ static int vfio_msix_vector_use(PCIDevice *pdev,
>  
>  static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      VFIOMSIVector *vector = &vdev->msi_vectors[nr];
>  
>      trace_vfio_msix_vector_release(vdev->vbasedev.name, nr);
> @@ -1086,7 +1089,7 @@ static const MemoryRegionOps vfio_vga_ops = {
>   */
>  static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      VFIORegion *region = &vdev->bars[bar].region;
>      MemoryRegion *mmap_mr, *region_mr, *base_mr;
>      PCIIORegion *r;
> @@ -1132,7 +1135,7 @@ static void vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>   */
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      uint32_t emu_bits = 0, emu_val = 0, phys_val = 0, val;
>  
>      memcpy(&emu_bits, vdev->emulated_config_bits + addr, len);
> @@ -1165,7 +1168,7 @@ uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len)
>  void vfio_pci_write_config(PCIDevice *pdev,
>                             uint32_t addr, uint32_t val, int len)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      uint32_t val_le = cpu_to_le32(val);
>  
>      trace_vfio_pci_write_config(vdev->vbasedev.name, addr, val, len);
> @@ -2801,7 +2804,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
>  
>  static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>      VFIODevice *vbasedev_iter;
>      VFIOGroup *group;
>      char *tmp, *subsys, group_path[PATH_MAX], *group_name;
> @@ -3084,8 +3087,7 @@ error:
>  
>  static void vfio_instance_finalize(Object *obj)
>  {
> -    PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pci_dev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(obj);
>      VFIOGroup *group = vdev->vbasedev.group;
>  
>      vfio_display_finalize(vdev);
> @@ -3105,7 +3107,7 @@ static void vfio_instance_finalize(Object *obj)
>  
>  static void vfio_exitfn(PCIDevice *pdev)
>  {
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(pdev);
>  
>      vfio_unregister_req_notifier(vdev);
>      vfio_unregister_err_notifier(vdev);
> @@ -3120,8 +3122,7 @@ static void vfio_exitfn(PCIDevice *pdev)
>  
>  static void vfio_pci_reset(DeviceState *dev)
>  {
> -    PCIDevice *pdev = DO_UPCAST(PCIDevice, qdev, dev);
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
> +    VFIOPCIDevice *vdev = PCI_VFIO(dev);
>  
>      trace_vfio_pci_reset(vdev->vbasedev.name);
>  
> @@ -3161,7 +3162,7 @@ post_reset:
>  static void vfio_instance_init(Object *obj)
>  {
>      PCIDevice *pci_dev = PCI_DEVICE(obj);
> -    VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, PCI_DEVICE(obj));
> +    VFIOPCIDevice *vdev = PCI_VFIO(obj);
>  
>      device_add_bootindex_property(obj, &vdev->bootindex,
>                                    "bootindex", NULL,
> @@ -3245,7 +3246,7 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo vfio_pci_dev_info = {
> -    .name = "vfio-pci",
> +    .name = TYPE_VFIO_PCI,
>      .parent = TYPE_PCI_DEVICE,
>      .instance_size = sizeof(VFIOPCIDevice),
>      .class_init = vfio_pci_dev_class_init,
> 
