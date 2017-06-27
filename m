Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPnyB-00008I-GY
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dPny8-0003Ow-B4
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:43:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dPny8-0003Oh-2Q
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 06:43:40 -0400
Date: Tue, 27 Jun 2017 11:43:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170627104334.GC2123@work-vm>
References: <1491301666-24320-1-git-send-email-yulei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1491301666-24320-1-git-send-email-yulei.zhang@intel.com>
Subject: Re: [Qemu-devel] [RFC 4/5] vfio: use
 vfio_device_put/vfio_device_get for device status save/restore
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

* Yulei Zhang (yulei.zhang@intel.com) wrote:
> For VFIO pci device status migrate, on the source side with
> funtion vfio_device_put to save the following states
> 1. pci configuration space addr0~addr5
> 2. pci configuration space msi_addr msi_data
> 3. pci device status fetch from device driver
> 
> And on the target side with funtion vfio_device_get to restore
> the same states
> 1. re-setup the pci bar configuration
> 2. re-setup the pci device msi configuration
> 3. restore the pci device status
> 
> Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
> ---
>  hw/vfio/pci.c | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 104 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 605a473..833cd90 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2961,18 +2961,121 @@ static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
>      vfio_status->flags = running ? VFIO_DEVICE_PCI_START :
>  				  VFIO_DEVICE_PCI_STOP;
>  
> -    ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status);
> +    if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status)) {
> +        error_report("vfio: Failed to %s device\n", running ? "start" : "stop");
> +    }
>      g_free(vfio_status);
>  }
>  
>  static int vfio_device_put(QEMUFile *f, void *pv, size_t size, VMStateField *field,
>                              QJSON *vmdesc)
>  {
> +    VFIOPCIDevice *vdev = pv;
> +    PCIDevice *pdev = &vdev->pdev;
> +    VFIORegion *region = &vdev->device_state.region;
> +    int sz = region->size;
> +    uint8_t *buf = NULL;
> +    uint32_t msi_cfg, msi_lo, msi_hi, msi_data, bar_cfg, i;
> +    bool msi_64bit;


Please use vmstate rather than qemu_get/qemu_put - we're trying to
get rid of all the qemu_put/qemu_get throughout the devices.
Probably using a pre_save/post_load is the right way to then tie the
data you've loaded to call the code that uploads it to the device.

> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        bar_cfg = pci_default_read_config(pdev, PCI_BASE_ADDRESS_0 + i*4, 4);
> +        qemu_put_be32(f, bar_cfg);
> +    }

> +    msi_cfg = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +    msi_64bit = !!(msi_cfg & PCI_MSI_FLAGS_64BIT);
> +
> +    msi_lo = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, 4);
> +    qemu_put_be32(f, msi_lo);
> +
> +    if (msi_64bit) {
> +        msi_hi = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, 4);
> +        qemu_put_be32(f, msi_hi);
> +    }
> +
> +    msi_data = pci_default_read_config(pdev,
> +                 pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32), 2);
> +    qemu_put_be32(f, msi_data);

Isn't all this stuff standard PCI config data that's already migrated?

> +    buf = g_malloc(sz);
> +    if (buf == NULL) {
> +        error_report("vfio: Failed to allocate memory for migrate\n");
> +        goto exit;
> +    }

g_malloc asserts rather than returns NULL if it fails to allocate.

> +    if (pread(vdev->vbasedev.fd, buf, sz, region->fd_offset) != sz) {
> +        error_report("vfio: Failed to read Device State Region\n");

Note error_report's shouldn't have \n's

> +        goto exit;
> +    }
> +
> +    qemu_put_buffer(f, buf, sz);

OK, so this is an opaque blob coming from the device.  Hmm.
Is it versioned?  Does it really need to be a closed blob?

Dave

> +exit:
> +    if (buf)
> +        g_free(buf);
> +
>      return 0;
>  }
>  
>  static int vfio_device_get(QEMUFile *f, void *pv, size_t size, VMStateField *field)
>  {
> +    VFIOPCIDevice *vdev = pv;
> +    PCIDevice *pdev = &vdev->pdev;
> +    VFIORegion *region = &vdev->device_state.region;
> +    int sz = region->size;
> +    uint8_t *buf = NULL;
> +    uint32_t ctl, msi_lo, msi_hi, msi_data, bar_cfg, i;
> +    bool msi_64bit;
> +
> +    /* retore pci bar configuration */
> +    ctl = pci_default_read_config(pdev, PCI_COMMAND, 2);
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl & (!(PCI_COMMAND_IO | PCI_COMMAND_MEMORY)), 2);
> +    for (i = 0; i < PCI_ROM_SLOT; i++) {
> +        bar_cfg = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, PCI_BASE_ADDRESS_0 + i*4, bar_cfg, 4);
> +    }
> +    vfio_pci_write_config(pdev, PCI_COMMAND,
> +                          ctl | PCI_COMMAND_IO | PCI_COMMAND_MEMORY, 2);
> +
> +    /* restore msi configuration */
> +    ctl = pci_default_read_config(pdev, pdev->msi_cap + PCI_MSI_FLAGS, 2);
> +    msi_64bit = !!(ctl & PCI_MSI_FLAGS_64BIT);
> +
> +    vfio_pci_write_config(&vdev->pdev,
> +                          pdev->msi_cap + PCI_MSI_FLAGS,
> +                          ctl & (!PCI_MSI_FLAGS_ENABLE), 2);
> +
> +    msi_lo = qemu_get_be32(f);
> +    vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_LO, msi_lo, 4);
> +
> +    if (msi_64bit) {
> +        msi_hi = qemu_get_be32(f);
> +        vfio_pci_write_config(pdev, pdev->msi_cap + PCI_MSI_ADDRESS_HI, msi_hi, 4);
> +    }
> +    msi_data = qemu_get_be32(f);
> +    vfio_pci_write_config(pdev,
> +                          pdev->msi_cap + (msi_64bit ? PCI_MSI_DATA_64 : PCI_MSI_DATA_32),
> +                          msi_data, 2);
> +
> +    vfio_pci_write_config(&vdev->pdev, pdev->msi_cap + PCI_MSI_FLAGS,
> +                          ctl | PCI_MSI_FLAGS_ENABLE, 2);
> +
> +    buf = g_malloc(sz);
> +    if (buf == NULL) {
> +        error_report("vfio: Failed to allocate memory for migrate\n");
> +        return -1;
> +    }
> +
> +    qemu_get_buffer(f, buf, sz);
> +    if (pwrite(vdev->vbasedev.fd, buf, sz, region->fd_offset) != sz) {
> +        error_report("vfio: Failed to write Device State Region\n");
> +        return -1;
> +    }
> +
> +    if (buf)
> +	g_free(buf);
>      return 0;
>  }
>  
> -- 
> 2.7.4
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
