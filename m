Received: from eggs.gnu.org ([2001:4830:134:3::10]:38204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVgk-0006ek-1Z
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chVgf-0002gY-39
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chVge-0002gK-Qn
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 01:18:33 -0500
References: <20170223122025.10420-1-cornelia.huck@de.ibm.com>
	<20170223122025.10420-4-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4fe97bb7-d6f0-7b58-916f-94dc0ae81616@redhat.com>
Date: Sat, 25 Feb 2017 07:18:29 +0100
MIME-Version: 1.0
In-Reply-To: <20170223122025.10420-4-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/5] s390x/ipl: Load network boot image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, jfrei@linux.vnet.ibm.com, Farhan Ali <alifm@linux.vnet.ibm.com>, agraf@suse.de

On 23.02.2017 13:20, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
> 
> Load the network boot image into guest RAM when the boot
> device selected is a network device. Use some of the reserved
> space in IplBlockCcw to store the start address of the netboot
> image.
> 
> A user could also use 'chreipl'(diag 308/5) to change the boot device.
> So every time we update the IPLB, we need to verify if the selected
> boot device is a network device so we can appropriately load the
> network boot image.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/ipl.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/s390x/ipl.h |  4 ++-
>  2 files changed, 92 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fd656718a7..195cac559f 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -20,6 +20,7 @@
>  #include "hw/s390x/virtio-ccw.h"
>  #include "hw/s390x/css.h"
>  #include "ipl.h"
> +#include "qemu/error-report.h"
>  
>  #define KERN_IMAGE_START                0x010000UL
>  #define KERN_PARM_AREA                  0x010480UL
> @@ -227,6 +228,12 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>                  TYPE_VIRTIO_CCW_DEVICE);
>          SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
>                                                              TYPE_SCSI_DEVICE);
> +        VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
> +                                                          TYPE_VIRTIO_NET);
> +
> +        if (vn) {
> +            ipl->netboot = true;
> +        }
>          if (virtio_ccw_dev) {
>              CcwDevice *ccw_dev = CCW_DEVICE(virtio_ccw_dev);
>  
> @@ -259,12 +266,86 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
>      return false;
>  }
>  
> +static int load_netboot_image(Error **errp)
> +{
> +    S390IPLState *ipl = get_ipl_device();
> +    char *netboot_filename;
> +    MemoryRegion *sysmem =  get_system_memory();
> +    MemoryRegion *mr = NULL;
> +    void *ram_ptr = NULL;
> +    int img_size = -1;
> +
> +    mr = memory_region_find(sysmem, 0, 1).mr;
> +    if (!mr) {
> +        error_setg(errp, "Failed to find memory region at address 0");
> +        return -1;
> +    }
> +
> +    ram_ptr = memory_region_get_ram_ptr(mr);
> +    if (!ram_ptr) {
> +        error_setg(errp, "No RAM found");
> +        goto unref_mr;
> +    }
> +
> +    netboot_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netboot_fw);
> +    if (netboot_filename == NULL) {
> +        error_setg(errp, "Could not find network bootloader");
> +        goto unref_mr;
> +    }
> +
> +    img_size = load_elf_ram(netboot_filename, NULL, NULL, &ipl->start_addr,
> +                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
> +
> +    if (img_size < 0) {
> +        img_size = load_image_size(netboot_filename, ram_ptr, ram_size);
> +        ipl->start_addr = KERN_IMAGE_START;
> +    }
> +
> +    if (img_size < 0) {
> +        error_setg(errp, "Failed to load network bootloader");
> +    }
> +
> +    g_free(netboot_filename);
> +
> +unref_mr:
> +    memory_region_unref(mr);
> +    return img_size;
> +}
> +
> +static bool is_virtio_net_device(IplParameterBlock *iplb)
> +{
> +    uint8_t cssid;
> +    uint8_t ssid;
> +    uint16_t devno;
> +    uint16_t schid;
> +    SubchDev *sch = NULL;
> +
> +    if (iplb->pbt != S390_IPL_TYPE_CCW) {
> +        return false;
> +    }
> +
> +    devno = be16_to_cpu(iplb->ccw.devno);
> +    ssid = iplb->ccw.ssid & 3;
> +
> +    for (schid = 0; schid < MAX_SCHID; schid++) {
> +        for (cssid = 0; cssid < MAX_CSSID; cssid++) {
> +            sch = css_find_subch(1, cssid, ssid, schid);
> +
> +            if (sch && sch->devno == devno) {
> +                return sch->id.cu_model == VIRTIO_ID_NET;
> +            }
> +        }
> +    }
> +   return false;

The above line has only 3 instead of 4 spaces. I wonder why checkpatch
does not complain here...?

> +}
> +
>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl = get_ipl_device();
>  
>      ipl->iplb = *iplb;
>      ipl->iplb_valid = true;
> +    ipl->netboot = is_virtio_net_device(iplb);
>  }
>  
>  IplParameterBlock *s390_ipl_get_iplb(void)
> @@ -288,6 +369,7 @@ void s390_reipl_request(void)
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl = get_ipl_device();
> +    Error *err = NULL;
>  
>      cpu->env.psw.addr = ipl->start_addr;
>      cpu->env.psw.mask = IPL_PSW_MASK;
> @@ -298,6 +380,13 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              ipl->iplb_valid = s390_gen_initial_iplb(ipl);
>          }
>      }
> +    if (ipl->netboot) {
> +        if (load_netboot_image(&err) < 0) {
> +            error_report_err(err);
> +            vm_stop(RUN_STATE_INTERNAL_ERROR);
> +        }
> +        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;

Not sure whether it matters, but in case of early errors during
load_netboot_image(), ipl->start_addr could be used uninitialized here.
Maybe you should move the "ipl->start_addr = KERN_IMAGE_START;" there at
the beginning of the function, to make it also the default value for the
other error cases?

> +    }
>  }
>  
>  static void s390_ipl_reset(DeviceState *dev)
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 4ad9a7c05e..46930e4c64 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -16,7 +16,8 @@
>  #include "cpu.h"
>  
>  struct IplBlockCcw {
> -    uint8_t  reserved0[85];
> +    uint64_t netboot_start_addr;
> +    uint8_t  reserved0[77];
>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -100,6 +101,7 @@ struct S390IPLState {
>      IplParameterBlock iplb;
>      bool iplb_valid;
>      bool reipl_requested;
> +    bool netboot;
>  
>      /*< public >*/
>      char *kernel;
> 

 Thomas
