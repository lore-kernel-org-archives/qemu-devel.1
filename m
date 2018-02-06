Received: from eggs.gnu.org ([2001:4830:134:3::10]:57215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eizTN-00044p-3W
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eizTI-0000N7-7D
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 04:23:29 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0c40e592-32e7-315e-fbad-1969c90b9b01@redhat.com>
Date: Tue, 6 Feb 2018 10:23:08 +0100
MIME-Version: 1.0
In-Reply-To: <1517864246-11101-6-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 05/12] s390-ccw: move
 auxiliary IPL data to separate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com, eblake@redhat.com

On 05.02.2018 21:57, Collin L. Walling wrote:
> The s390-ccw firmware needs some information in support of the
> boot process which is not available on the native machine.
> Examples are the netboot firmware load address and now the
> boot menu parameters.
>=20
> While storing that data in unused fields of the IPL parameter block
> works, that approach could create problems if the parameter block
> definition should change in the future. Because then a guest could
> overwrite these fields using the set IPLB diagnose.
>=20
> In fact the data in question is of more global nature and not really
> tied to an IPL device, so separating it is rather logical.
>=20
> This commit introduces a new structure to hold firmware relevant
> IPL parameters set by QEMU. The data is stored at location 204 (dec)
> and can contain up to 7 32-bit words. This area is available to
> programming in the z/Architecture Principles of Operation and
> can thus safely be used by the firmware until the IPL has completed.

Sounds like a good idea.

> Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
> ---
>  hw/s390x/ipl.c          | 18 +++++++++++++++++-
>  hw/s390x/ipl.h          | 11 +++++++++--
>  pc-bios/s390-ccw/iplb.h | 12 ++++++++++--
>  pc-bios/s390-ccw/main.c |  6 +++++-
>  4 files changed, 41 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 0d06fc1..3e3c3b8 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -399,6 +399,20 @@ void s390_reipl_request(void)
>      qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
>  }
> =20
> +static void s390_ipl_prepare_qipl(S390CPU *cpu)
> +{
> +    S390IPLState *ipl =3D get_ipl_device();
> +    uint8_t *addr;
> +    uint64_t len =3D 4096;
> +
> +    addr =3D cpu_physical_memory_map(cpu->env.psa, &len, 1);
> +    if (!addr || len < 204 + sizeof(QemuIplParameters)) {
> +        error_report("Cannot set QEMU IPL parameters");

I think you should return or exit() here. Otherwise the memcpy below
accesses an illegal memory range.

> +    }
> +    memcpy(addr + 204, &ipl->iplb.qipl, sizeof(QemuIplParameters));
> +    cpu_physical_memory_unmap(addr, len, 1, len);
> +}
> +
>  void s390_ipl_prepare_cpu(S390CPU *cpu)
>  {
>      S390IPLState *ipl =3D get_ipl_device();
> @@ -418,8 +432,10 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              error_report_err(err);
>              vm_stop(RUN_STATE_INTERNAL_ERROR);
>          }
> -        ipl->iplb.ccw.netboot_start_addr =3D cpu_to_be64(ipl->start_ad=
dr);
> +        ipl->iplb.qipl.netboot_start_addr =3D cpu_to_be64(ipl->start_a=
ddr);
>      }
> +    s390_ipl_prepare_qipl(cpu);
> +
>  }
> =20
>  static void s390_ipl_reset(DeviceState *dev)
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 8a705e0..68dcaf8 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -16,8 +16,7 @@
>  #include "cpu.h"
> =20
>  struct IplBlockCcw {
> -    uint64_t netboot_start_addr;
> -    uint8_t  reserved0[77];
> +    uint8_t  reserved0[85];
>      uint8_t  ssid;
>      uint16_t devno;
>      uint8_t  vm_flags;
> @@ -59,6 +58,13 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
> =20
>  #define DIAG308_FLAGS_LP_VALID 0x80
> =20
> +struct QemuIplParameters {
> +    uint8_t  reserved1[4];
> +    uint64_t netboot_start_addr;
> +    uint8_t  reserved2[16];
> +} QEMU_PACKED;
> +typedef struct QemuIplParameters QemuIplParameters;
> +
>  union IplParameterBlock {
>      struct {
>          uint32_t len;
> @@ -74,6 +80,7 @@ union IplParameterBlock {
>              IplBlockFcp fcp;
>              IplBlockQemuScsi scsi;
>          };
> +        QemuIplParameters qipl;
>      } QEMU_PACKED;

Sorry if I get that wrong, but if you store that within
IplParameterBlock, the information is still passed via DIAG 0x308, isn't
it? (see handle_diag_308(), case 6). Is that really what was intended her=
e?

[...]
> diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
> index e857ce4..825a1a3 100644
> --- a/pc-bios/s390-ccw/main.c
> +++ b/pc-bios/s390-ccw/main.c
> @@ -16,6 +16,7 @@ char stack[PAGE_SIZE * 8] __attribute__((__aligned__(=
PAGE_SIZE)));
>  static SubChannelId blk_schid =3D { .one =3D 1 };
>  IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
>  static char loadparm[8] =3D { 0, 0, 0, 0, 0, 0, 0, 0 };
> +QemuIplParameters qipl;
> =20
>  /*
>   * Priniciples of Operations (SA22-7832-09) chapter 17 requires that
> @@ -81,6 +82,7 @@ static void virtio_setup(void)
>      uint16_t dev_no;
>      char ldp[] =3D "LOADPARM=3D[________]\n";
>      VDev *vdev =3D virtio_get_device();
> +    QemuIplParameters *early_qipl =3D (QemuIplParameters *)204;

Could you please introduce a proper #define for that magic 204 value
(and use it in s390_ipl_prepare_qipl, too)? ... so that it is later
easier to grep for this.

>      /*
>       * We unconditionally enable mss support. In every sane configurat=
ion,
> @@ -93,6 +95,8 @@ static void virtio_setup(void)
>      memcpy(ldp + 10, loadparm, 8);
>      sclp_print(ldp);
> =20
> +    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
> +
>      if (store_iplb(&iplb)) {
>          switch (iplb.pbt) {
>          case S390_IPL_TYPE_CCW:
> @@ -127,7 +131,7 @@ static void virtio_setup(void)
> =20
>      if (virtio_get_device_type() =3D=3D VIRTIO_ID_NET) {
>          sclp_print("Network boot device detected\n");
> -        vdev->netboot_start_addr =3D iplb.ccw.netboot_start_addr;
> +        vdev->netboot_start_addr =3D qipl.netboot_start_addr;
>      } else {
>          virtio_blk_setup_device(blk_schid);
> =20
>=20

 Thomas
