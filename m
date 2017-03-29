Received: from eggs.gnu.org ([2001:4830:134:3::10]:53535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct3EL-0003Lc-KU
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ct3EH-0005yC-Os
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:21:01 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:34035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ct3EH-0005xJ-3f
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:20:57 -0400
Received: by mail-pf0-x241.google.com with SMTP id o126so71690pfb.1
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 19:20:56 -0700 (PDT)
References: <20170328021651.19350-1-david@gibson.dropbear.id.au>
	<20170328021651.19350-4-david@gibson.dropbear.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <72226418-5022-1ccc-9af4-6fce295db7d4@ozlabs.ru>
Date: Wed, 29 Mar 2017 13:20:50 +1100
MIME-Version: 1.0
In-Reply-To: <20170328021651.19350-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC for-2.10 3/3] pseries: Allow PCIe virtio and
 XHCI on pseries machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com, marcel@redhat.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lersek@redhat.com

On 28/03/17 13:16, David Gibson wrote:
> pseries now allows PCIe devices (both emulated and VFIO), although its
> PCI bus is in most respects a plain PCI bus - this uses paravirtualized
> access methods to PCIe extended config space defined in the PAPR spec.
> 
> However, because the bus is not PCIe, it means that virtio-pci and XHCI
> devices will present themselves as plain PCI rather than PCIe, which would
> be preferable.
> 
> This patch uses the new hook to override the behaviour for such PCI/PCIe
> "hybrid" devices to allow PCIe virtio-pci and XHCI on pseries.


Not clear what all these tests/virtio-*.c changes are for and why here -
does "make check" break if you do not enforce disable-legacy=off?


> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c       | 9 +++++++++
>  tests/virtio-9p-test.c   | 2 +-
>  tests/virtio-blk-test.c  | 4 ++--
>  tests/virtio-net-test.c  | 2 +-
>  tests/virtio-scsi-test.c | 2 +-
>  5 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 98c52e4..7686f7f 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1979,6 +1979,14 @@ static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
>      return sphb->dtbusname;
>  }
>  
> +static bool spapr_phb_allow_hybrid_pcie(PCIHostState *host_bridge,
> +                                        PCIDevice *pci_dev)
> +{
> +    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(host_bridge);
> +
> +    return sphb->pcie_ecs;
> +}
> +
>  static void spapr_phb_class_init(ObjectClass *klass, void *data)
>  {
>      PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
> @@ -1986,6 +1994,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
>      HotplugHandlerClass *hp = HOTPLUG_HANDLER_CLASS(klass);
>  
>      hc->root_bus_path = spapr_phb_root_bus_path;
> +    hc->allow_hybrid_pcie = spapr_phb_allow_hybrid_pcie;
>      dc->realize = spapr_phb_realize;
>      dc->props = spapr_phb_properties;
>      dc->reset = spapr_phb_reset;
> diff --git a/tests/virtio-9p-test.c b/tests/virtio-9p-test.c
> index 43a1ad8..ae0d51e 100644
> --- a/tests/virtio-9p-test.c
> +++ b/tests/virtio-9p-test.c
> @@ -32,7 +32,7 @@ static QVirtIO9P *qvirtio_9p_start(const char *driver)
>  {
>      const char *arch = qtest_get_arch();
>      const char *cmd = "-fsdev local,id=fsdev0,security_model=none,path=%s "
> -                      "-device %s,fsdev=fsdev0,mount_tag=%s";
> +                      "-device %s,fsdev=fsdev0,mount_tag=%s,disable-legacy=off";
>      QVirtIO9P *v9p = g_new0(QVirtIO9P, 1);
>  
>      v9p->test_share = g_strdup("/tmp/qtest.XXXXXX");
> diff --git a/tests/virtio-blk-test.c b/tests/virtio-blk-test.c
> index 1eee95d..5fb7882 100644
> --- a/tests/virtio-blk-test.c
> +++ b/tests/virtio-blk-test.c
> @@ -65,7 +65,7 @@ static QOSState *pci_test_start(void)
>      const char *cmd = "-drive if=none,id=drive0,file=%s,format=raw "
>                        "-drive if=none,id=drive1,file=/dev/null,format=raw "
>                        "-device virtio-blk-pci,id=drv0,drive=drive0,"
> -                      "addr=%x.%x";
> +                      "addr=%x.%x,disable-legacy=off";
>  
>      tmp_path = drive_create();
>  
> @@ -656,7 +656,7 @@ static void pci_hotplug(void)
>  
>      /* plug secondary disk */
>      qpci_plug_device_test("virtio-blk-pci", "drv1", PCI_SLOT_HP,
> -                          "'drive': 'drive1'");
> +                          "'drive': 'drive1', 'disable-legacy': 'off'");
>  
>      dev = virtio_blk_pci_init(qs->pcibus, PCI_SLOT_HP);
>      g_assert(dev);
> diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> index 8f94360..a35d87b 100644
> --- a/tests/virtio-net-test.c
> +++ b/tests/virtio-net-test.c
> @@ -55,7 +55,7 @@ static QOSState *pci_test_start(int socket)
>  {
>      const char *arch = qtest_get_arch();
>      const char *cmd = "-netdev socket,fd=%d,id=hs0 -device "
> -                      "virtio-net-pci,netdev=hs0";
> +                      "virtio-net-pci,netdev=hs0,disable-legacy=off";
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>          return qtest_pc_boot(cmd, socket);
> diff --git a/tests/virtio-scsi-test.c b/tests/virtio-scsi-test.c
> index 0eabd56..5a802d9 100644
> --- a/tests/virtio-scsi-test.c
> +++ b/tests/virtio-scsi-test.c
> @@ -36,7 +36,7 @@ static QOSState *qvirtio_scsi_start(const char *extra_opts)
>  {
>      const char *arch = qtest_get_arch();
>      const char *cmd = "-drive id=drv0,if=none,file=/dev/null,format=raw "
> -                      "-device virtio-scsi-pci,id=vs0 "
> +                      "-device virtio-scsi-pci,id=vs0,disable-legacy=off "
>                        "-device scsi-hd,bus=vs0.0,drive=drv0 %s";
>  
>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> 


-- 
Alexey
