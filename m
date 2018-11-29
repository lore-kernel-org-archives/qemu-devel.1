Received: from eggs.gnu.org ([2001:4830:134:3::10]:37337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gSUFf-0007W5-Md
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:53:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gSUFa-0005Hc-JH
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:53:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52088
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gSUFa-0005HO-DB
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 16:53:34 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wATLnhF1127356
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:53:34 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p2p55nyg9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 16:53:33 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 29 Nov 2018 21:53:33 -0000
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-7-git-send-email-pmorel@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 29 Nov 2018 16:53:28 -0500
MIME-Version: 1.0
In-Reply-To: <1542904555-1136-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <555d039d-16ef-f279-fd48-f0d422f7905a@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] s390x/vfio: ap: Implementing AP
 Queue Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On 11/22/18 11:35 AM, Pierre Morel wrote:
> We intercept the PQAP(AQIC) instruction and transform
> the guest's AQIC command parameters for the host AQIC
> parameters.
> 
> Doing this we use the standard adapter interface to provide
> the adapter NIB, indicator and ISC.
> 
> We define new structures, APCard and APQueue to keep track of
> the ISC, route and indicator address and we add an array of
> APCards in the APDevice.
> 
> We call the VFIO ioctl to set or clear the interruption
> according to the "i" bit of the parameter.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   hw/vfio/ap.c                 | 117 ++++++++++++++++++++++++++++++++++++++++++-
>   include/hw/s390x/ap-device.h |  63 +++++++++++++++++++++++
>   target/s390x/kvm.c           |  31 ++++++++++++
>   3 files changed, 210 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 94e5a1a..20d2e5f 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -4,6 +4,7 @@
>    * Copyright 2018 IBM Corp.
>    * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
>    *            Halil Pasic <pasic@linux.ibm.com>
> + *            Pierre Morel <pmorel@linux.ibm.com>
>    *
>    * This work is licensed under the terms of the GNU GPL, version 2 or (at
>    * your option) any later version. See the COPYING file in the top-level
> @@ -14,7 +15,6 @@
>   #include <sys/ioctl.h>
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "hw/sysbus.h"
>   #include "hw/vfio/vfio.h"
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/s390x/ap-device.h"
> @@ -27,6 +27,8 @@
>   #include "sysemu/sysemu.h"
>   #include "hw/s390x/ap-bridge.h"
>   #include "exec/address-spaces.h"
> +#include "hw/s390x/s390_flic.h"
> +#include "hw/s390x/css.h"
>   
>   #define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>   
> @@ -35,6 +37,117 @@ typedef struct VFIOAPDevice {
>       VFIODevice vdev;
>   } VFIOAPDevice;
>   
> +static uint32_t ap_pqap_clear_irq(VFIODevice *vdev, APQueue *apq)
> +{
> +    struct vfio_ap_aqic param;
> +    uint32_t retval;
> +
> +    param.apqn = apq->apqn;
> +    param.isc = apq->isc;
> +    param.argsz = sizeof(param);
> +
> +    retval = ioctl(vdev->fd, VFIO_AP_CLEAR_IRQ, &param);
> +    switch (retval) {
> +    case 0:    /* Fall through and return the instruction status */

Unnecessary comment, we can see the code is going to fall through and
return status. Sorry, I know its a nit.

> +        release_indicator(&apq->routes.adapter, apq->nib);
> +    case -EIO: /* The case the PQAP instruction failed with status */

We know it's a case statement, so leave off the "The case the".

> +        return  param.status;
> +    default:   /* The case the ioctl call failed without isuing instruction */

Same here.

> +        break;
> +    }
> +    return ap_reg_set_status(AP_RC_INVALID_ADDR);
> +}
> +
> +static uint32_t ap_pqap_set_irq(VFIODevice *vdev, APQueue *apq, uint64_t g_nib)
> +{
> +    struct vfio_ap_aqic param;
> +    uint32_t retval;
> +    uint32_t id;
> +
> +    id = css_get_adapter_id(CSS_IO_ADAPTER_AP, apq->isc);
> +    if (id == -1) {
> +        return ap_reg_set_status(AP_RC_INVALID_ADDR);
> +    }
> +    apq->routes.adapter.adapter_id = id;
> +    apq->nib = get_indicator(ldq_p(&g_nib), 8);
> +
> +    retval = map_indicator(&apq->routes.adapter, apq->nib);
> +    if (retval) {
> +        return ap_reg_set_status(AP_RC_INVALID_ADDR);
> +    }
> +
> +    param.apqn = apq->apqn;
> +    param.isc = apq->isc;
> +    param.nib = g_nib;
> +    param.adapter_id = id;
> +    param.argsz = sizeof(param);
> +
> +    retval =  ioctl(vdev->fd, VFIO_AP_SET_IRQ, &param);
> +    switch (retval) {
> +    case -EIO: /* The case the PQAP instruction failed with status */

We know it's a case statement, so leave off the "The case the".

> +        release_indicator(&apq->routes.adapter, apq->nib);
> +    case 0:    /* Fall through and return the instruction status */

Unnecessary comment, the code speaks for itself.

> +        return  param.status;
> +    default:   /* The case the ioctl call failed without isuing instruction */

We know it's a case statement, so leave off the "The case the".

> +        break;
> +    }
> +    release_indicator(&apq->routes.adapter, apq->nib);
> +    return ap_reg_set_status(AP_RC_INVALID_ADDR);
> +}
> +
> +static int ap_pqap_aqic(CPUS390XState *env)
> +{
> +    uint64_t g_nib = env->regs[2];
> +    uint8_t apid = ap_reg_get_apid(env->regs[0]);
> +    uint8_t apqi = ap_reg_get_apqi(env->regs[0]);
> +    uint32_t retval;
> +    APDevice *ap = s390_get_ap();

To be consistent with the naming convention in the rest of
this file, can you name this variable 'apdev'?

> +    VFIODevice *vdev;
> +    VFIOAPDevice *ap_vdev;

To be consistent with the naming convention in the rest of
this file, can you name this variable 'vapdev'?

> +    APQueue *apq;
> +
> +    ap_vdev = DO_UPCAST(VFIOAPDevice, apdev, ap);

Where is 'apdev' defined/initialized?

> +    vdev = &ap_vdev->vdev;
> +    apq = &ap->card[apid].queue[apqi];
> +    apq->isc = ap_reg_get_isc(env->regs[1]);
> +    apq->apqn = (apid << 8) | apqi;
> +
> +    if (ap_reg_get_ir(env->regs[1])) {
> +        retval = ap_pqap_set_irq(vdev, apq, g_nib);
> +    } else {
> +        retval = ap_pqap_clear_irq(vdev, apq);
> +    }
> +
> +    env->regs[1] = retval;
> +    if (retval & AP_STATUS_RC_MASK) {
> +        return 3;
> +    }
> +
> +    return 0;
> +}
> +
> +/*
> + * ap_pqap
> + * @env: environment pointing to registers
> + * return value: Code Condition
> + */
> +int ap_pqap(CPUS390XState *env)
> +{
> +    int cc = 0;
> +
> +    switch (ap_reg_get_fc(env->regs[0])) {
> +    case AQIC:
> +        if (!s390_has_feat(S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL)) {
> +            return -PGM_OPERATION;

Shouldn't this be PGM_SPECIFICATION?

> +        }
> +        cc = ap_pqap_aqic(env);
> +        break;
> +    default:
> +        return -PGM_OPERATION;
> +    }
> +    return cc;
> +}
> +
>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>   {
>       vdev->needs_reset = false;
> @@ -106,6 +219,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           goto out_get_dev_err;
>       }
>   
> +    css_register_io_adapters(CSS_IO_ADAPTER_AP, true, false,
> +                             0, &error_abort);
>       return;
>   
>   out_get_dev_err:
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index 5f3c840..8a36780 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -12,8 +12,25 @@
>   
>   #define AP_DEVICE_TYPE       "ap-device"
>   
> +#define MAX_AP_CARD 256
> +#define MAX_AP_DOMAIN 256
> +
> +#include "hw/s390x/s390_flic.h"
> +#include "hw/s390x/css.h"
> +typedef struct APQueue {
> +    AdapterRoutes routes;
> +    IndAddr *nib;
> +    uint16_t apqn;
> +    uint8_t isc;
> +} APQueue;
> +
> +typedef struct APCard {
> +    APQueue queue[MAX_AP_DOMAIN];

This seems to be an unnecessary allocation of memory, particularly
if there is only a few queues. I understand this
maps to the concept of a matrix and makes for quick retrieval of
an APQueue, but I think it would be more efficient to use something
like a GTree, or a GHashTable both of which would save you space and
allow for fairly quick retrieval.

> +} APCard;
> +
>   typedef struct APDevice {
>       DeviceState parent_obj;
> +    APCard card[MAX_AP_CARD];

See comment above concerning the 'queue' field in the
APCard structure. I would also name this field 'cards'
since it represents all APCard objects.

>   } APDevice;
>   
>   #define AP_DEVICE(obj) \
> @@ -21,4 +38,50 @@ typedef struct APDevice {
>   
>   APDevice *s390_get_ap(void);
>   
> +#include "cpu.h"
> +int ap_pqap(CPUS390XState *env);
> +
> +/* AP PQAP commands definitions */
> +#define AQIC 0x03
> +
> +#define AP_AQIC_ZERO_BITS 0x0ff0000
> +
> +/* Register 0 hold the command and APQN */
> +static inline uint8_t ap_reg_get_apid(uint64_t r)
> +{
> +        return (r >> 8) & 0xff;
> +}
> +
> +static inline uint8_t ap_reg_get_apqi(uint64_t r)
> +{
> +        return r & 0xff;
> +}
> +
> +static inline uint16_t ap_reg_get_fc(uint64_t r)
> +{
> +        return (r >> 24) & 0xff;
> +}
> +
> +static inline uint16_t ap_reg_get_ir(uint64_t r)
> +{
> +        return (r >> 47) & 0x01;
> +}
> +
> +static inline uint16_t ap_reg_get_isc(uint64_t r)
> +{
> +        return r  & 0x7;
> +}
> +
> +/* AP status returned by the AP PQAP commands */
> +#define AP_STATUS_RC_MASK 0x00ff0000
> +#define AP_RC_APQN_INVALID 0x01
> +#define AP_RC_INVALID_ADDR 0x06
> +#define AP_RC_BAD_STATE    0x07
> +
> +/* Register 1 as input hold the AQIC information */
> +static inline uint32_t ap_reg_set_status(uint8_t status)

This function does not set anything, but returns an APQSW.
Maybe it should be named ap_reg_get_status_word or ap_reg_get_apqsw
or ap_reg_get_status.

> +{
> +        return status << 16;
> +}
> +
>   #endif /* HW_S390X_AP_DEVICE_H */
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26a..a4b5d90 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -45,6 +45,7 @@
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> +#include "hw/s390x/ap-device.h"
>   #include "hw/s390x/ipl.h"
>   #include "hw/s390x/ebcdic.h"
>   #include "exec/memattrs.h"
> @@ -88,6 +89,7 @@
>   #define PRIV_B2_CHSC                    0x5f
>   #define PRIV_B2_SIGA                    0x74
>   #define PRIV_B2_XSCH                    0x76
> +#define PRIV_B2_PQAP                    0xaf
>   
>   #define PRIV_EB_SQBS                    0x8a
>   #define PRIV_EB_PCISTB                  0xd0
> @@ -1154,6 +1156,32 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>       return 0;
>   }
>   
> +static int kvm_ap_pqap(S390CPU *cpu, uint16_t ipbh0)
> +{
> +    CPUS390XState *env = &cpu->env;
> +    int r;
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        kvm_s390_program_interrupt(cpu, PGM_PRIVILEGED);
> +        return 0;
> +    }
> +
> +    if (env->regs[0] & AP_AQIC_ZERO_BITS) {
> +        kvm_s390_program_interrupt(cpu, PGM_SPECIFICATION);
> +        return 0;
> +    }

This check does not belong here; for example, if the PQAP(TAPQ)
instruction is intercepted and the T bit (bit 40) is set, a
specification exception would be erroneously recognized. This check
should be done in the ap_pqap_aqic() function.

> +
> +    r = ap_pqap(&cpu->env);
> +
> +    if (r < 0) {
> +        kvm_s390_program_interrupt(cpu, -r);
> +    } else {
> +        setcc(cpu, r);
> +    }
> +
> +    return 0;
> +}
> +
>   static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
>   {
>       CPUS390XState *env = &cpu->env;
> @@ -1216,6 +1244,9 @@ static int handle_b2(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
>       case PRIV_B2_SCLP_CALL:
>           rc = kvm_sclp_service_call(cpu, run, ipbh0);
>           break;
> +    case PRIV_B2_PQAP:
> +        rc = kvm_ap_pqap(cpu, ipbh0);
> +        break;
>       default:
>           rc = -1;
>           DPRINTF("KVM: unhandled PRIV: 0xb2%x\n", ipa1);
> 
