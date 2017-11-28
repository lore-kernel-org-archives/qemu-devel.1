Received: from eggs.gnu.org ([2001:4830:134:3::10]:58370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJeKT-0003ID-Dm
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eJeKN-0005Fm-KO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:45:33 -0500
References: <1511816136-30068-1-git-send-email-walling@linux.vnet.ibm.com>
	<1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e36ef8c1-3122-9416-8f86-442387a46b6d@redhat.com>
Date: Tue, 28 Nov 2017 12:45:23 +0100
MIME-Version: 1.0
In-Reply-To: <1511816136-30068-4-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 3/5] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 27.11.2017 21:55, Collin L. Walling wrote:
> Set boot menu options for an s390 guest and store them in
> the iplb. These options are set via the QEMU command line
> option:
>=20
>     -boot menu=3Don|off[,splash-time=3DX]
>=20
> or via the libvirt domain xml:
>=20
>     <os>
>       <bootmenu enable=3D'yes|no' timeout=3D'X'/>
>     </os>
>=20
> Where X represents some positive integer representing
> milliseconds.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          | 23 +++++++++++++++++++++++
>  hw/s390x/ipl.h          |  8 ++++++--
>  pc-bios/s390-ccw/iplb.h |  8 ++++++--
>  3 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..0ca9e37 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -23,6 +23,8 @@
>  #include "hw/s390x/ebcdic.h"
>  #include "ipl.h"
>  #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/cutils.h"
> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define KERN_PARM_AREA                  0x010480UL
> @@ -219,6 +221,23 @@ static Property s390_ipl_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void s390_ipl_set_boot_menu(uint8_t *boot_menu_enabled,
> +                                   uint16_t *boot_menu_timeout)
> +{
> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
> +    const char *p;
> +    long result =3D 0;
> +
> +    *boot_menu_enabled =3D qemu_opt_get_bool(opts, "menu", false);
> +
> +    if (*boot_menu_enabled) {
> +        p =3D qemu_opt_get(opts, "splash-time");
> +        qemu_strtol(p, NULL, 10, &result);

It's maybe better to check the return code of qemu_strtol to see whether
the option contained a valid number? An additional check for negative
numbers would also be fine, I think.

> +        *boot_menu_timeout =3D result;
> +    }
> +}
> +
>  static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
> @@ -245,6 +264,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl=
)
>              ipl->iplb.pbt =3D S390_IPL_TYPE_CCW;
>              ipl->iplb.ccw.devno =3D cpu_to_be16(ccw_dev->sch->devno);
>              ipl->iplb.ccw.ssid =3D ccw_dev->sch->ssid & 3;
> +            s390_ipl_set_boot_menu(&ipl->iplb.ccw.boot_menu_enabled,
> +                                   &ipl->iplb.ccw.boot_menu_timeout);
>          } else if (sd) {
>              SCSIBus *bus =3D scsi_bus_from_device(sd);
>              VirtIOSCSI *vdev =3D container_of(bus, VirtIOSCSI, bus);
> @@ -266,6 +287,8 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl=
)
>              ipl->iplb.scsi.channel =3D cpu_to_be16(sd->channel);
>              ipl->iplb.scsi.devno =3D cpu_to_be16(ccw_dev->sch->devno);
>              ipl->iplb.scsi.ssid =3D ccw_dev->sch->ssid & 3;
> +            s390_ipl_set_boot_menu(&ipl->iplb.scsi.boot_menu_enabled,
> +                                   &ipl->iplb.scsi.boot_menu_timeout);
>          } else {
>              return false; /* unknown device */
>          }
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8a705e0..7c960b1 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -17,7 +17,9 @@
> =20
>  struct IplBlockCcw {
>      uint64_t netboot_start_addr;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[74];
> +    uint8_t  boot_menu_enabled;
> +    uint16_t boot_menu_timeout;

Could you please try to keep the fields aligned to their natural
alignment? I.e. swap the two new entries, so that timeout comes before
enabled?

>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -51,7 +53,9 @@ struct IplBlockQemuScsi {
>      uint32_t lun;
>      uint16_t target;
>      uint16_t channel;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[74];
> +    uint8_t  boot_menu_enabled;
> +    uint16_t boot_menu_timeout;

dito

>      uint8_t  ssid;
>      uint16_t devno;
>  } QEMU_PACKED;

 Thomas
