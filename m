Received: from eggs.gnu.org ([2001:4830:134:3::10]:60899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emxpI-000589-Sf
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:26:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emxpF-0008I1-OB
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 03:26:32 -0500
References: <1518818879-18608-1-git-send-email-walling@linux.vnet.ibm.com>
	<1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce6141a7-5071-ea5a-01b8-f432672e2f77@redhat.com>
Date: Sat, 17 Feb 2018 09:26:13 +0100
MIME-Version: 1.0
In-Reply-To: <1518818879-18608-7-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v7 06/12] s390-ccw: parse and
 set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, mihajlov@linux.vnet.ibm.com
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 16.02.2018 23:07, Collin L. Walling wrote:
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
> Any value set for loadparm will override all boot menu options.
> If loadparm=3DPROMPT, then the menu will be enabled without a
> timeout.
>=20
> The absence of any boot options on the command line will flag
> to later use the zipl boot loader values.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

You've managed to add new bugs here. Please drop my Reviewed-by again.

> ---
>  hw/s390x/ipl.c          | 48 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>  hw/s390x/ipl.h          |  9 +++++++--
>  pc-bios/s390-ccw/iplb.h |  6 ++++--
>  3 files changed, 59 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 31565ce..c8109f5 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -23,6 +23,9 @@
>  #include "hw/s390x/ebcdic.h"
>  #include "ipl.h"
>  #include "qemu/error-report.h"
> +#include "qemu/config-file.h"
> +#include "qemu/cutils.h"
> +#include "qemu/option.h"
> =20
>  #define KERN_IMAGE_START                0x010000UL
>  #define KERN_PARM_AREA                  0x010480UL
> @@ -219,6 +222,50 @@ static Property s390_ipl_properties[] =3D {
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> +static void s390_ipl_set_boot_menu(IplParameterBlock *iplb)
> +{
> +    QemuOptsList *plist =3D qemu_find_opts("boot-opts");
> +    QemuOpts *opts =3D QTAILQ_FIRST(&plist->head);
> +    uint8_t *flags;
> +    uint32_t *timeout;
> +    const char *tmp;
> +    unsigned long splash_time =3D 0;
> +
> +    switch (iplb->pbt) {
> +    case S390_IPL_TYPE_CCW:
> +    case S390_IPL_TYPE_QEMU_SCSI:
> +        flags =3D &iplb->qipl.boot_menu_flags;
> +        timeout =3D &iplb->qipl.boot_menu_timeout;
> +        break;
> +    default:
> +        error_report("boot menu is not supported for this device type.=
");
> +        return;
> +    }
> +
> +    /* In the absence of -boot menu, use zipl parameters */
> +    if (!qemu_opt_get(opts, "menu")) {
> +        *flags =3D BOOT_MENU_FLAG_ZIPL_OPTS;
> +    } else if (boot_menu) {
> +        *flags =3D BOOT_MENU_FLAG_CMD_OPTS;
> +
> +        tmp =3D qemu_opt_get(opts, "splash-time");
> +
> +        if (tmp && qemu_strtoul(tmp, NULL, 10, &splash_time)) {
> +            error_report("splash-time is invalid, forcing it to 0.");
> +            splash_time =3D 0;

The earlier version of this patch used "*timeout =3D 0", which was OK. No=
w
you've changed it to the local variable splash_time, but also kept the
return statement below. This is bad. Either change it back to *timeout
or drop the return statement.

> +            return;
> +        }
> +
> +        if (splash_time > 0xffffffff) {
> +            error_report("splash-time is too large, forcing it to max =
value.");
> +            splash_time =3D 0xffffffff;
> +            return;

dito.

> +        }
> +
> +        *timeout =3D cpu_to_be32(splash_time);
> +    }
> +}
> +
>  static bool s390_gen_initial_iplb(S390IPLState *ipl)
>  {
>      DeviceState *dev_st;
> @@ -435,6 +482,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>          }
>          ipl->iplb.qipl.netboot_start_addr =3D cpu_to_be64(ipl->start_a=
ddr);
>      }
> +    s390_ipl_set_boot_menu(&ipl->iplb);
>      s390_ipl_prepare_qipl(cpu);
> =20
>  }
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 74469b1..f632c59 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -60,6 +60,9 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
> =20
>  #define QIPL_ADDRESS  0xcc
> =20
> +#define BOOT_MENU_FLAG_CMD_OPTS  0x80
> +#define BOOT_MENU_FLAG_ZIPL_OPTS 0x40
> +
>  /*
>   * The QEMU IPL Parameters will be stored 32-bit word aligned.
>   * Placement of data fields in this area must account for
> @@ -67,9 +70,11 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   * The entire structure must not be larger than 28 bytes.
>   */
>  struct QemuIplParameters {
> -    uint8_t  reserved1[4];
> +    uint8_t  boot_menu_flags;
> +    uint8_t  reserved1[3];
> +    uint32_t boot_menu_timeout;
>      uint64_t netboot_start_addr;
> -    uint8_t  reserved2[16];
> +    uint8_t  reserved2[12];
>  } QEMU_PACKED;
>  typedef struct QemuIplParameters QemuIplParameters;
> =20
> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
> index a23237e..0e39aa0 100644
> --- a/pc-bios/s390-ccw/iplb.h
> +++ b/pc-bios/s390-ccw/iplb.h
> @@ -81,9 +81,11 @@ extern IplParameterBlock iplb __attribute__((__align=
ed__(PAGE_SIZE)));
>   * The entire structure must not be larger than 28 bytes.
>   */
>  struct QemuIplParameters {
> -    uint8_t  reserved1[4];
> +    uint8_t  boot_menu_flags;
> +    uint8_t  reserved1[3];
> +    uint32_t boot_menu_timeout;
>      uint64_t netboot_start_addr;
> -    uint8_t  reserved2[16];
> +    uint8_t  reserved2[12];
>  } __attribute__ ((packed));
>  typedef struct QemuIplParameters QemuIplParameters;

I think Victor's original intention was to get netboot_start_addr
aligned in the lowcore memory. Now it's rather aligned in the host
memory. Quite confusing, but I think I'd rather prefer Victor's idea to
keep it aligned in the lowcore (since that's the "architected" part).

Maybe it's better if we do not declare this as a packed struct at all,
and then instead of doing a memcpy of the whole struct, we set the
fields manually one by one on the host side into the lowcore, and read
the fields manually one by one on the guest side? That's more
cumbersome, but avoids future confusion about the alignments here...

 Thomas
