Received: from eggs.gnu.org ([2001:4830:134:3::10]:52776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dPaTj-0005Ji-Ku
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dPaTf-0007VT-Ly
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dPaTf-0007VI-D6
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 16:19:19 -0400
Date: Mon, 26 Jun 2017 14:19:17 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170626141917.6e75a852@w520.home>
In-Reply-To: <1491301650-24275-1-git-send-email-yulei.zhang@intel.com>
References: <1491301650-24275-1-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 3/5] vfio: introduce new VFIO ioctl
 VFIO_DEVICE_PCI_STATUS_SET
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yulei Zhang <yulei.zhang@intel.com>
Cc: qemu-devel@nongnu.org, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com

On Tue,  4 Apr 2017 18:27:30 +0800
Yulei Zhang <yulei.zhang@intel.com> wrote:

> New VFIO ioctl VFIO_DEVICE_PCI_STATUS_SET is added to change the
> vfio pci device status during the migration, stop the device on
> the source side before fetch its status and start the deivce on
> the target side after restore its status.
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c              | 17 +++++++++++++++++
>  linux-headers/linux/vfio.h | 15 +++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 7de4eb4..605a473 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -38,6 +38,7 @@
>  static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>  static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>  static VMStateDescription vfio_pci_vmstate;
> +static void vfio_vm_change_state_handler(void *pv, int running, RunState state);
>  
>  /*
>   * Disabling BAR mmaping can be slow, but toggling it around INTx can
> @@ -2866,6 +2867,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vfio_register_err_notifier(vdev);
>      vfio_register_req_notifier(vdev);
>      vfio_setup_resetfn_quirk(vdev);
> +    qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
>  
>      return;
>  
> @@ -2948,6 +2950,21 @@ post_reset:
>      vfio_pci_post_reset(vdev);
>  }
>  
> +static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
> +{
> +    VFIOPCIDevice *vdev = pv;
> +    struct vfio_pci_status_set *vfio_status;
> +    int argsz = sizeof(*vfio_status);
> +
> +    vfio_status = g_malloc0(argsz);
> +    vfio_status->argsz = argsz;
> +    vfio_status->flags = running ? VFIO_DEVICE_PCI_START :
> +				  VFIO_DEVICE_PCI_STOP;
> +
> +    ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status);
> +    g_free(vfio_status);
> +}
> +
>  static int vfio_device_put(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                              QJSON *vmdesc)
>  {
> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
> index c87d05c..fa17848 100644
> --- a/linux-headers/linux/vfio.h
> +++ b/linux-headers/linux/vfio.h
> @@ -487,6 +487,21 @@ struct vfio_pci_hot_reset {
>  
>  #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
>  
> +/**
> + * VFIO_DEVICE_PCI_STATUS_SET - _IOW(VFIO_TYPE, VFIO_BASE + 14,
> + *				    struct vfio_pci_status_set)
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct vfio_pci_status_set{
> +	__u32	argsz;
> +	__u32	flags;
> +#define VFIO_DEVICE_PCI_STOP  (1 << 0)
> +#define VFIO_DEVICE_PCI_START (1 << 1)
> +};
> +
> +#define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE + 14)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

Why does this need to be an ioctl?  We could simply define the first
dword of the migration region as the device state and the user could
read and write it.  Thanks,

Alex
