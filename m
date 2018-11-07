Received: from eggs.gnu.org ([2001:4830:134:3::10]:60632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKO3v-00079X-F6
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKO3p-0001ec-Iz
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:40:03 -0500
Date: Wed, 7 Nov 2018 14:39:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181107143944.69cad7ef.cohuck@redhat.com>
In-Reply-To: <1541154621-22423-6-git-send-email-pmorel@linux.ibm.com>
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
	<1541154621-22423-6-git-send-email-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/5] s390x/vfio: ap: Implementing AP
 Queue Interrupt Control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On Fri,  2 Nov 2018 11:30:21 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> We intercept the PQAP(AQIC) instruction and transform
> the guest's AQIC command parameters for the host AQIC
> parameters.
> 
> Doing this we use the standard adapter interface to provide
> the adapter NIB, indicator and ISC.
> 
> We define a new structure, APQueue to keep track of
> the route and indicator address and we add an array of
> AP Queues in the VFIOAPDevice.
> 
> We call the VFIO ioctl to set or clear the interruption
> according to the "i" bit of the parameter.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  hw/vfio/ap.c                 | 92 +++++++++++++++++++++++++++++++++++-
>  include/hw/s390x/ap-device.h | 46 ++++++++++++++++++
>  2 files changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index d8d9cadc46..67a46e163e 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -27,17 +27,90 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/s390x/ap-bridge.h"
>  #include "exec/address-spaces.h"
> +#include "hw/s390x/s390_flic.h"
> +#include "hw/s390x/css.h"
>  
>  #define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>  
>  typedef struct VFIOAPDevice {
>      APDevice apdev;
>      VFIODevice vdev;
> +    QTAILQ_ENTRY(VFIOAPDevice) sibling;
> +    APQueue apq[MAX_AP][MAX_DOMAIN];
>  } VFIOAPDevice;
>  
>  #define VFIO_AP_DEVICE(obj) \
>          OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>  
> +VFIOAPDevice *vfio_apdev;
> +static APDevice *matrix;

Why do you need those variables? Can't you get the target device in a
different way?

> +
> +static int ap_aqic(CPUS390XState *env)

<bikeshed>I think ap_pqap_aqic would be slightly better.</bikeshed>

> +{
> +    struct pqap_cmd cmd = reg2cmd(env->regs[0]);
> +    struct ap_status status = reg2status(env->regs[1]);

I don't really like those reg2<whatever> helpers; they obfuscate things
IMO.

Also: These are internal structs and not copied from Linux, right? Then
they should be CamelCase.

> +    uint64_t guest_nib = env->regs[2];

Another point: What about endianness? Even though this is kvm-only, I
would like an emulation of an instruction to be endian-clean. (Maybe it
also needs a different split?)

> +    struct vfio_ap_aqic param = {};
> +    int retval;
> +    VFIODevice *vdev;
> +    VFIOAPDevice *ap_vdev;
> +    APQueue *apq;
> +
> +    ap_vdev = DO_UPCAST(VFIOAPDevice, apdev, matrix);
> +    apq = &ap_vdev->apq[cmd.apid][cmd.apqi];
> +    vdev = &ap_vdev->vdev;
> +
> +    if (status.irq) {
> +        if (apq->nib) {
> +            status.rc = AP_RC_BAD_STATE;
> +            goto error;
> +        }
> +    } else {
> +        if (!apq->nib) {
> +            status.rc = AP_RC_BAD_STATE;
> +            goto error;
> +        }
> +    }

Maybe
    if (!!status.irq == !!apq->nib) {
        status.rc = AP_RC_BAD_STATE;
        goto error;
    }
?

> +    if (!guest_nib) {
> +        status.rc = AP_RC_INVALID_ADDR;
> +        goto error;
> +    }
> +
> +    apq->routes.adapter.adapter_id = css_get_adapter_id(
> +                                       CSS_IO_ADAPTER_AP, status.isc);
> +
> +    apq->nib = get_indicator(ldq_p(&guest_nib), 8);
> +
> +    retval = map_indicator(&apq->routes.adapter, apq->nib);
> +    if (retval) {
> +        status.rc = AP_RC_INVALID_ADDR;
> +        env->regs[1] = status2reg(status);

I do not like the backwards conversion macros, either :(

> +        goto error;
> +    }
> +
> +    param.cmd = env->regs[0];
> +    param.status = env->regs[1];
> +    param.nib = env->regs[2];
> +    param.adapter_id = apq->routes.adapter.adapter_id;
> +    param.argsz = sizeof(param);
> +
> +    retval = ioctl(vdev->fd, VFIO_AP_SET_IRQ, &param);
> +    status = reg2status(param.status);
> +    if (retval) {
> +        goto err_ioctl;
> +    }
> +
> +    env->regs[1] = param.status;
> +
> +    return 0;
> +err_ioctl:
> +    release_indicator(&apq->routes.adapter, apq->nib);
> +    apq->nib = NULL;
> +error:
> +    env->regs[1] = status2reg(status);
> +    return 0;
> +}
> +
>  /*
>   * ap_pqap
>   * @env: environment pointing to registers
> @@ -45,7 +118,20 @@ typedef struct VFIOAPDevice {
>   */
>  int ap_pqap(CPUS390XState *env)
>  {
> -    return -PGM_OPERATION;
> +    struct pqap_cmd cmd = reg2cmd(env->regs[0]);

Dito on the macro.

> +    int cc = 0;
> +
> +    switch (cmd.fc) {

This probably needs some endian handling as well.

> +    case AQIC:

What about calling this PQAP_AQCI?

> +        if (!s390_has_feat(S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL)) {
> +            return -PGM_OPERATION;
> +        }
> +        cc = ap_aqic(env);
> +        break;
> +    default:
> +        return -PGM_OPERATION;
> +    }
> +    return cc;
>  }
>  
>  static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
> @@ -119,6 +205,9 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>          goto out_get_dev_err;
>      }
>  
> +    matrix = apdev;

Huh?

> +    css_register_io_adapters(CSS_IO_ADAPTER_AP, true, false,
> +                             0, &error_abort);
>      return;
>  
>  out_get_dev_err:
> @@ -135,6 +224,7 @@ static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>      VFIOGroup *group = vapdev->vdev.group;
>  
>      vfio_ap_put_device(vapdev);
> +    matrix = NULL;
>      vfio_put_group(group);
>  }
>  
> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
> index a83ea096c7..bc2b7bcd8e 100644
> --- a/include/hw/s390x/ap-device.h
> +++ b/include/hw/s390x/ap-device.h
> @@ -28,4 +28,50 @@ typedef struct APDevice {
>  #include "cpu.h"
>  int ap_pqap(CPUS390XState *env);
>  
> +#define MAX_AP 256
> +#define MAX_DOMAIN 256
> +
> +#include "hw/s390x/s390_flic.h"
> +#include "hw/s390x/css.h"
> +typedef struct APQueue {
> +    uint32_t apid;
> +    uint32_t apqi;
> +    AdapterRoutes routes;
> +    IndAddr *nib;
> +} APQueue;
> +
> +/* AP PQAP commands definitions */
> +#define AQIC 0x03
> +
> +struct pqap_cmd {
> +    uint32_t unused;
> +    uint8_t fc;
> +    unsigned t:1;
> +    unsigned reserved:7;

It is better to make this an uint8_t and define an accessor for the 't'
bit.

> +    uint8_t apid;
> +    uint8_t apqi;
> +};

Also, please use typedef and CamelCase :)

> +/* AP status returned by the AP PQAP commands */
> +#define AP_RC_APQN_INVALID 0x01
> +#define AP_RC_INVALID_ADDR 0x06
> +#define AP_RC_BAD_STATE    0x07
> +
> +struct ap_status {
> +    uint16_t pad;
> +    unsigned irq:1;
> +    unsigned pad2:15;
> +    unsigned e:1;
> +    unsigned r:1;
> +    unsigned f:1;
> +    unsigned unused:4;
> +    unsigned i:1;
> +    unsigned char rc;
> +    unsigned reserved:13;
> +    unsigned isc:3;
> +};

Dito on bitfields and CamelCase :)

> +
> +#define reg2cmd(reg) (*(struct pqap_cmd *)&(reg))
> +#define status2reg(status) (*((uint64_t *)&status))
> +#define reg2status(reg) (*(struct ap_status *)&(reg))
> +
>  #endif /* HW_S390X_AP_DEVICE_H */
