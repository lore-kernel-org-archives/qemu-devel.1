Received: from eggs.gnu.org ([2001:4830:134:3::10]:37331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfpsp-00079k-KH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:28:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cfpsm-00016D-7H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:28:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cfpsl-00015o-VH
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:28:08 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-4-cornelia.huck@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d8c1475a-765b-e980-cb48-255c29efdaf6@redhat.com>
Date: Mon, 20 Feb 2017 16:28:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170220141943.8426-4-cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] s390x/ipl: Load network boot image
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

On 20.02.2017 15:19, Cornelia Huck wrote:
> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>=20
> Load the network boot image into guest RAM when the boot
> device selected is a network device. Use some of the reserved
> space in IplBlockCcw to store the start address of the netboot
> image.
>=20
> A user could also use 'chreipl'(diag 308/5) to change the boot device.
> So every time we update the IPLB, we need to verify if the selected
> boot device is a network device so we can appropriately load the
> network boot image.
>=20
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
> ---
>  hw/s390x/ipl.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  hw/s390x/ipl.h |  4 ++-
>  2 files changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index fd656718a7..80e05cc7a5 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -20,6 +20,7 @@
>  #include "hw/s390x/virtio-ccw.h"
>  #include "hw/s390x/css.h"
>  #include "ipl.h"
> +#include "qemu/error-report.h"
> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define KERN_PARM_AREA                  0x010480UL
> @@ -227,6 +228,12 @@ static bool s390_gen_initial_iplb(S390IPLState *ip=
l)
>                  TYPE_VIRTIO_CCW_DEVICE);
>          SCSIDevice *sd =3D (SCSIDevice *) object_dynamic_cast(OBJECT(d=
ev_st),
>                                                              TYPE_SCSI_=
DEVICE);
> +        VirtIONet *vn =3D (VirtIONet *) object_dynamic_cast(OBJECT(dev=
_st),
> +                                                          TYPE_VIRTIO_=
NET);
> +
> +        if (vn) {
> +            ipl->netboot =3D true;
> +        }
>          if (virtio_ccw_dev) {
>              CcwDevice *ccw_dev =3D CCW_DEVICE(virtio_ccw_dev);
> =20
> @@ -259,12 +266,84 @@ static bool s390_gen_initial_iplb(S390IPLState *i=
pl)
>      return false;
>  }
> =20
> +static int load_netboot_image(void)
> +{
> +

Please remove that empty line above.

> +    S390IPLState *ipl =3D get_ipl_device();
> +    char *netboot_filename;
> +    MemoryRegion *sysmem =3D  get_system_memory();
> +    MemoryRegion *mr =3D NULL;
> +    void *ram_ptr =3D NULL;
> +    int img_size =3D -1;
> +
> +    mr =3D memory_region_find(sysmem, 0, 1).mr;
> +    if (!mr) {
> +        error_report("Failed to find memory region at address 0");
> +        goto out;

<bikeshedpainting>I'd prefer a "return -1 here</bikeshedpainting>

> +    }
> +
> +    ram_ptr =3D memory_region_get_ram_ptr(mr);
> +    if (!ram_ptr) {
> +        error_report("No RAM found");
> +        goto unref_mr;
> +    }
> +
> +    netboot_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, ipl->netb=
oot_fw);
> +    if (netboot_filename =3D=3D NULL) {
> +        error_report("Could not find network bootloader");
> +        goto unref_mr;
> +    }

So you're doing error_report() here already ...

> +    img_size =3D load_elf_ram(netboot_filename, NULL, NULL, &ipl->star=
t_addr,
> +                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false)=
;
> +
> +    if (img_size < 0) {
> +        img_size =3D load_image_size(netboot_filename, ram_ptr, ram_si=
ze);
> +        ipl->start_addr =3D KERN_IMAGE_START;
> +    }
> +
> +    g_free(netboot_filename);
> +
> +unref_mr:
> +    memory_region_unref(mr);
> +out:
> +    return img_size;
> +}
> +
> +static bool is_virtio_net_device(IplParameterBlock *iplb)
> +{
> +    uint8_t cssid;
> +    uint8_t ssid;
> +    uint16_t devno;
> +    uint16_t schid;
> +    SubchDev *sch =3D NULL;
> +
> +    if (iplb->pbt !=3D S390_IPL_TYPE_CCW) {
> +        return false;
> +    }
> +
> +    devno =3D be16_to_cpu(iplb->ccw.devno);
> +    ssid =3D iplb->ccw.ssid & 3;
> +
> +    for (schid =3D 0; schid < MAX_SCHID; schid++) {
> +        for (cssid =3D 0; cssid < MAX_CSSID; cssid++) {
> +            sch =3D css_find_subch(1, cssid, ssid, schid);
> +
> +            if (sch && sch->devno =3D=3D devno) {
> +                return sch->id.cu_model =3D=3D VIRTIO_ID_NET;
> +            }
> +        }
> +    }
> +   return false;
> +}
> +
>  void s390_ipl_update_diag308(IplParameterBlock *iplb)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> =20
>      ipl->iplb =3D *iplb;
>      ipl->iplb_valid =3D true;
> +    ipl->netboot =3D is_virtio_net_device(iplb);
>  }
> =20
>  IplParameterBlock *s390_ipl_get_iplb(void)
> @@ -298,6 +377,13 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              ipl->iplb_valid =3D s390_gen_initial_iplb(ipl);
>          }
>      }
> +    if (ipl->netboot) {
> +        if (load_netboot_image() < 0) {
> +            error_report("Failed to load network bootloader");

... and then you do another error_report here again ... so one error
gets reported with two error message. Wouldn't it be nicer to rather do
error_setg(...) in load_netboot_image() and then report only one error
at this level here?

> +            vm_stop(RUN_STATE_INTERNAL_ERROR);
> +        }
> +        ipl->iplb.ccw.netboot_start_addr =3D ipl->start_addr;
> +    }
>  }
> =20
>  static void s390_ipl_reset(DeviceState *dev)
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 4ad9a7c05e..46930e4c64 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -16,7 +16,8 @@
>  #include "cpu.h"
> =20
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
> =20
>      /*< public >*/
>      char *kernel;
>=20
