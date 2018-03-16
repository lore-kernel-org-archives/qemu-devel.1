Received: from eggs.gnu.org ([2001:4830:134:3::10]:46042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewkKf-0006rH-B7
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:03:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1ewkKZ-0005Yf-Nn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:03:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1ewkKZ-0005XZ-Dn
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 04:03:15 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2G811Mn070591
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:03:13 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gr8smapq6-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 04:03:12 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 08:03:10 -0000
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 09:03:04 +0100
MIME-Version: 1.0
In-Reply-To: <1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <56fde90b-7984-d376-042d-226ed9df4bae@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 16/03/2018 00:24, Tony Krowiak wrote:
> If the CPU model indicates that AP facility is installed on
> the guest (i.e., -cpu xxxx,ap=3Don), then the expectation is that
> the AP bus running in the guest will initialize; however, if the
> AP instructions are not being interpreted by the firmware, then
> they will be intercepted and routed back to QEMU for handling.
> If a handler is not defined to process the intercepted instruciton,
> then an operation exception will be injected into the
> guest, in which case the AP bus will not initialize.
>
> There are two situations where AP instructions will not be
> interpreted:
>
> 1. The guest is not configured with a vfio-ap device (i.e.,
>     -device vfio-ap,sysfsdev=3D$path-to-mdev). The realize function for
>     the vfio-ap device enables interpretive execution of AP
>     instructions.
>
> 2. The guest is a second level guest but the first level guest has
>     not enabled interpretive execution.
>
> This patch introduces AP instruction handlers to ensure the AP bus
> module initializes on the guest when the AP facility is installed
> on the guest but AP instructions are not being interpreted. The logic
> incorporated is:
>
> * If the CPU model indicates AP instructions are
>    installed
>
>    * Set the status response code for the instruction to indicate that
>      the APQN contained in the instruction is not valid. This is
>      a valid response because there will be no devices configured for
>      the guest in any of the above scenarios.
>
> * Else return an error from the handler. This will result in an
>    operation being injected into the guest and the AP bus will not
>    initialize on the guest. That is commensurate with how things work
>    today.
>
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
> ---
>   hw/vfio/ap.c                 |   45 +++++++++++++++++++++++++++++++++=
+++++++++
>   include/hw/s390x/ap-device.h |    6 +++++
>   target/s390x/kvm.c           |   14 +++++++++++++
>   3 files changed, 65 insertions(+), 0 deletions(-)
>
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index b397bb1..88e744d 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -148,6 +148,51 @@ static void vfio_ap_unrealize(DeviceState *dev, Er=
ror **errp)
>       kvm_s390_set_interpret_ap(0);
>   }
>
> +int ap_device_handle_nqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }
> +
> +    return -EOPNOTSUPP;
> +}
> +
> +int ap_device_handle_dqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +
> +    if (s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }
> +
> +    return -EOPNOTSUPP;
> +}
> +
> +int ap_device_handle_pqap(S390CPU *cpu)
> +{
> +    CPUS390XState *env =3D &cpu->env;
> +    int fc =3D 4 & (env->regs[0] >> 24);
> +
> +    /*
> +     * The Query Configuration Information (QCI) function (fc =3D=3D 4=
) does not
> +     * set a response code in reg 1, so check for that along with the
> +     * AP feature.
> +     */
> +    if ((fc !=3D 4) && s390_has_feat(S390_FEAT_AP)) {
> +        env->regs[1] =3D 0x10000;
> +
> +        return 0;
> +    }
> +
> +    return -EOPNOTSUPP;
> +}
> +
>   static Property vfio_ap_properties[] =3D {
>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>       DEFINE_PROP_END_OF_LIST(),
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.=
h
> index 693df90..d45ae38 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -11,6 +11,8 @@
>   #ifndef HW_S390X_AP_DEVICE_H
>   #define HW_S390X_AP_DEVICE_H
>
> +#include "cpu.h"
> +
>   #define AP_DEVICE_TYPE       "ap-device"
>
>   typedef struct APDevice {
> @@ -35,4 +37,8 @@ static inline APDevice *to_ap_dev(DeviceState *dev)
>   #define AP_DEVICE_CLASS(klass) \
>       OBJECT_CLASS_CHECK(APDeviceClass, (klass), AP_DEVICE_TYPE)
>
> +int ap_device_handle_nqap(S390CPU *cpu);
> +int ap_device_handle_dqap(S390CPU *cpu);
> +int ap_device_handle_pqap(S390CPU *cpu);
> +
>   #endif /* HW_S390X_AP_DEVICE_H */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2812e28..a636394 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -50,6 +50,7 @@
>   #include "exec/memattrs.h"
>   #include "hw/s390x/s390-virtio-ccw.h"
>   #include "hw/s390x/s390-virtio-hcall.h"
> +#include "hw/s390x/ap-device.h"
>
>   #ifndef DEBUG_KVM
>   #define DEBUG_KVM  0
> @@ -88,6 +89,9 @@
>   #define PRIV_B2_CHSC                    0x5f
>   #define PRIV_B2_SIGA                    0x74
>   #define PRIV_B2_XSCH                    0x76
> +#define PRIV_B2_NQAP                    0xad
> +#define PRIV_B2_DQAP                    0xae
> +#define PRIV_B2_PQAP                    0xaf
>
>   #define PRIV_EB_SQBS                    0x8a
>   #define PRIV_EB_PCISTB                  0xd0
> @@ -1245,6 +1249,16 @@ static int handle_b2(S390CPU *cpu, struct kvm_ru=
n *run, uint8_t ipa1)
>       case PRIV_B2_SCLP_CALL:
>           rc =3D kvm_sclp_service_call(cpu, run, ipbh0);
>           break;
> +    case PRIV_B2_NQAP:
> +        rc =3D ap_device_handle_nqap(cpu);
> +        break;
> +    case PRIV_B2_DQAP:
> +        rc =3D ap_device_handle_dqap(cpu);
> +        break;
> +    case PRIV_B2_PQAP:
> +        rc =3D ap_device_handle_pqap(cpu);
> +        break;
> +        break;

one too much

>       default:
>           rc =3D -1;
>           DPRINTF("KVM: unhandled PRIV: 0xb2%x\n", ipa1);


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
