Received: from eggs.gnu.org ([2001:4830:134:3::10]:60364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHsI-0001o5-2t
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:40:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVHsD-0006eM-2M
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:40:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37854)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVHsC-0006dP-Pj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:40:13 -0400
References: <1499864265-144136-1-git-send-email-borntraeger@de.ibm.com>
	<1499864265-144136-11-git-send-email-borntraeger@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c70ce5b2-cbf0-e0c0-0697-8ffac5446dea@redhat.com>
Date: Wed, 12 Jul 2017 15:40:02 +0200
MIME-Version: 1.0
In-Reply-To: <1499864265-144136-11-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/11] s390x/sic: realize SIC handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, Fei Li <sherrylf@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 12.07.2017 14:57, Christian Borntraeger wrote:
> From: Fei Li <sherrylf@linux.vnet.ibm.com>
>=20
> Currently, we do nothing for the SIC instruction, but we need to
> implement it properly. Let's add proper handling in the backend code.
>=20
> Co-authored-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/css.c         | 26 ++++++++++++++++++++++++++
>  hw/s390x/trace-events  |  1 +
>  include/hw/s390x/css.h |  2 ++
>  target/s390x/kvm.c     | 16 +++++++++++++++-
>  4 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 1fcbc84..7b82176 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -521,6 +521,32 @@ void css_conditional_io_interrupt(SubchDev *sch)
>      }
>  }
> =20
> +int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode)
> +{
> +    S390FLICState *fs =3D s390_get_flic();
> +    S390FLICStateClass *fsc =3D S390_FLIC_COMMON_GET_CLASS(fs);
> +    int r;
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        r =3D -PGM_PRIVILEGED;
> +        goto out;

Why not simply:

           return -PGM_PRIVILEGED;

?

Same for the other goto below ... and then you also do not need the "r"
variable anymore.

> +    }
> +
> +    trace_css_do_sic(mode, isc);
> +    switch (mode) {
> +    case SIC_IRQ_MODE_ALL:
> +    case SIC_IRQ_MODE_SINGLE:
> +        break;
> +    default:
> +        r =3D -PGM_OPERAND;
> +        goto out;
> +    }
> +
> +    r =3D fsc->modify_ais_mode(fs, isc, mode) ? -PGM_OPERATION : 0;
> +out:
> +    return r;
> +}
> +
>  void css_adapter_interrupt(uint8_t isc)
>  {
>      uint32_t io_int_word =3D (isc << 27) | IO_INT_WORD_AI;
> diff --git a/hw/s390x/trace-events b/hw/s390x/trace-events
> index 84ea964..f07e974 100644
> --- a/hw/s390x/trace-events
> +++ b/hw/s390x/trace-events
> @@ -8,6 +8,7 @@ css_new_image(uint8_t cssid, const char *default_cssid)=
 "CSS: add css image %02x
>  css_assign_subch(const char *do_assign, uint8_t cssid, uint8_t ssid, u=
int16_t schid, uint16_t devno) "CSS: %s %x.%x.%04x (devno %04x)"
>  css_io_interrupt(int cssid, int ssid, int schid, uint32_t intparm, uin=
t8_t isc, const char *conditional) "CSS: I/O interrupt on sch %x.%x.%04x =
(intparm %08x, isc %x) %s"
>  css_adapter_interrupt(uint8_t isc) "CSS: adapter I/O interrupt (isc %x=
)"
> +css_do_sic(uint16_t mode, uint8_t isc) "CSS: set interruption mode %x =
on isc %x"
> =20
>  # hw/s390x/virtio-ccw.c
>  virtio_ccw_interpret_ccw(int cssid, int ssid, int schid, int cmd_code)=
 "VIRTIO-CCW: %x.%x.%04x: interpret command %x"
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index e028960..5ee6d52 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -12,6 +12,7 @@
>  #ifndef CSS_H
>  #define CSS_H
> =20
> +#include "cpu.h"

Not sure, but it's a little bit strange that the channel sub-system now
depends on the CPU ... maybe the check for problem state should rather
be done in kvm.c instead?
Or should css_do_sic() rather reside in s390-pci-inst.c or in ioinst.c
instead?

>  #include "hw/s390x/adapter.h"
>  #include "hw/s390x/s390_flic.h"
>  #include "hw/s390x/ioinst.h"
> @@ -165,6 +166,7 @@ typedef enum {
>      CSS_IO_ADAPTER_TYPE_NUMS,
>  } CssIoAdapterType;
> =20
> +int css_do_sic(CPUS390XState *env, uint8_t isc, uint16_t mode);
>  uint32_t css_get_adapter_id(CssIoAdapterType type, uint8_t isc);
>  void css_register_io_adapters(CssIoAdapterType type, bool swap, bool m=
askable,
>                                uint8_t flags, Error **errp);
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 7a2a7c0..78ebe83 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1206,7 +1206,21 @@ static int kvm_stpcifc_service_call(S390CPU *cpu=
, struct kvm_run *run)
> =20
>  static int kvm_sic_service_call(S390CPU *cpu, struct kvm_run *run)
>  {
> -    /* NOOP */
> +    CPUS390XState *env =3D &cpu->env;
> +    uint8_t r1 =3D (run->s390_sieic.ipa & 0x00f0) >> 4;
> +    uint8_t r3 =3D run->s390_sieic.ipa & 0x000f;
> +    uint8_t isc;
> +    uint16_t mode;
> +    int r;
> +
> +    cpu_synchronize_state(CPU(cpu));
> +    mode =3D env->regs[r1] & 0xffff;
> +    isc =3D (env->regs[r3] >> 27) & 0x7;
> +    r =3D css_do_sic(env, isc, mode);
> +    if (r) {
> +        enter_pgmcheck(cpu, -r);
> +    }
> +
>      return 0;
>  }

 Thomas
