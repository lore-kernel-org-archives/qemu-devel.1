Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egMsj-00048A-0F
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:46:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egMsf-0001Yg-2x
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:46:49 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:41463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1egMse-0001Ws-Tp
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 22:46:45 -0500
Received: by mail-qk0-x244.google.com with SMTP id l29so8465546qkj.8
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 19:46:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180129202326.9417.71344.stgit@gimli.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e68d0f7f-b942-3452-0771-578bdfb1b276@amsat.org>
Date: Tue, 30 Jan 2018 00:46:38 -0300
MIME-Version: 1.0
In-Reply-To: <20180129202326.9417.71344.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vfio/pci: Add option to disable GeForce
 quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>

Hi Alex,

On 01/29/2018 05:23 PM, Alex Williamson wrote:
> These quirks are necessary for GeForce, but not for Quadro/GRID/Tesla
> assignment.  Leaving them enabled is fully functional and provides the
> most compatibility, but due to the unique NVIDIA MSI ACK behavior[1],
> it also introduces latency in re-triggering the MSI interrupt.  This
> overhead is typically negligible, but has been shown to adversely
> affect some (very) high interrupt rate applications.  This adds the
> vfio-pci device option "x-no-geforce-quirks=" which can be set to
> "on" to disable this additional overhead.
> 
> A follow-on optimization for GeForce might be to make use of an
> ioeventfd to allow KVM to trigger an irqfd in the kernel vfio-pci
> driver, avoiding the bounce through userspace to handle this device
> write.
> 
> [1] Background: the NVIDIA driver has been observed to write 0xff to
> the read-only MSI capability ID register via the MMIO mirror of PCI
> config space in order for the MSI interrupt to re-trigger.  This PCI
> config space mirror is virtualized in QEMU for GeForce.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/pci-quirks.c |    9 ++++++---
>  hw/vfio/pci.c        |    2 ++
>  hw/vfio/pci.h        |    1 +
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index 60ad5fb91a83..e5779a7ad35b 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -542,7 +542,8 @@ static void vfio_vga_probe_nvidia_3d0_quirk(VFIOPCIDevice *vdev)
>      VFIOQuirk *quirk;
>      VFIONvidia3d0Quirk *data;
>  
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> +    if (vdev->no_geforce_quirks ||
> +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||

Isn't it enough to check x-pci-device-id == 0x03d0 for GeForce rather
than introduce a x-no-geforce-quirks property?

>          !vdev->bars[1].region.size) {
>          return;
>      }
> @@ -660,7 +661,8 @@ static void vfio_probe_nvidia_bar5_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIONvidiaBAR5Quirk *bar5;
>      VFIOConfigWindowQuirk *window;
>  
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> +    if (vdev->no_geforce_quirks ||
> +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
>          !vdev->vga || nr != 5 || !vdev->bars[5].ioport) {
>          return;
>      }
> @@ -754,7 +756,8 @@ static void vfio_probe_nvidia_bar0_quirk(VFIOPCIDevice *vdev, int nr)
>      VFIOQuirk *quirk;
>      VFIOConfigMirrorQuirk *mirror;
>  
> -    if (!vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
> +    if (vdev->no_geforce_quirks ||
> +        !vfio_pci_is(vdev, PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID) ||
>          !vfio_is_vga(vdev) || nr != 0) {
>          return;
>      }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 2c7129512563..6d260b92c1e1 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2989,6 +2989,8 @@ static Property vfio_pci_dev_properties[] = {
>      DEFINE_PROP_BOOL("x-no-kvm-intx", VFIOPCIDevice, no_kvm_intx, false),
>      DEFINE_PROP_BOOL("x-no-kvm-msi", VFIOPCIDevice, no_kvm_msi, false),
>      DEFINE_PROP_BOOL("x-no-kvm-msix", VFIOPCIDevice, no_kvm_msix, false),
> +    DEFINE_PROP_BOOL("x-no-geforce-quirks", VFIOPCIDevice,
> +                     no_geforce_quirks, false),
>      DEFINE_PROP_UINT32("x-pci-vendor-id", VFIOPCIDevice, vendor_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-device-id", VFIOPCIDevice, device_id, PCI_ANY_ID),
>      DEFINE_PROP_UINT32("x-pci-sub-vendor-id", VFIOPCIDevice,
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index a8fb3b34222c..7c55087a1c44 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -142,6 +142,7 @@ typedef struct VFIOPCIDevice {
>      bool no_kvm_intx;
>      bool no_kvm_msi;
>      bool no_kvm_msix;
> +    bool no_geforce_quirks;
>  } VFIOPCIDevice;
>  
>  uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
> 
> 
