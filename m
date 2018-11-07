Received: from eggs.gnu.org ([2001:4830:134:3::10]:57986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gKWqb-0005h2-Pj
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 18:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gKWqW-0001eB-1H
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 18:02:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gKWqV-0001O9-NX
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 18:02:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA7MsVb0042937
	for <qemu-devel@nongnu.org>; Wed, 7 Nov 2018 18:02:23 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2nm8gqsse3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 07 Nov 2018 18:02:22 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 7 Nov 2018 23:02:21 -0000
Reply-To: pmorel@linux.ibm.com
References: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
	<1541154621-22423-6-git-send-email-pmorel@linux.ibm.com>
	<20181107143944.69cad7ef.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 8 Nov 2018 00:02:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181107143944.69cad7ef.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <29a2919c-908c-0ef8-9e04-63d9e9284700@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

On 07/11/2018 14:39, Cornelia Huck wrote:
> On Fri,  2 Nov 2018 11:30:21 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
>=20
>> We intercept the PQAP(AQIC) instruction and transform
>> the guest's AQIC command parameters for the host AQIC
>> parameters.
>>
>> Doing this we use the standard adapter interface to provide
>> the adapter NIB, indicator and ISC.
>>
>> We define a new structure, APQueue to keep track of
>> the route and indicator address and we add an array of
>> AP Queues in the VFIOAPDevice.
>>
>> We call the VFIO ioctl to set or clear the interruption
>> according to the "i" bit of the parameter.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   hw/vfio/ap.c                 | 92 ++++++++++++++++++++++++++++++++++=
+-
>>   include/hw/s390x/ap-device.h | 46 ++++++++++++++++++
>>   2 files changed, 137 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index d8d9cadc46..67a46e163e 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -27,17 +27,90 @@
>>   #include "sysemu/sysemu.h"
>>   #include "hw/s390x/ap-bridge.h"
>>   #include "exec/address-spaces.h"
>> +#include "hw/s390x/s390_flic.h"
>> +#include "hw/s390x/css.h"
>>  =20
>>   #define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>>  =20
>>   typedef struct VFIOAPDevice {
>>       APDevice apdev;
>>       VFIODevice vdev;
>> +    QTAILQ_ENTRY(VFIOAPDevice) sibling;
>> +    APQueue apq[MAX_AP][MAX_DOMAIN];
>>   } VFIOAPDevice;
>>  =20
>>   #define VFIO_AP_DEVICE(obj) \
>>           OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)
>>  =20
>> +VFIOAPDevice *vfio_apdev;
>> +static APDevice *matrix;
>=20
> Why do you need those variables? Can't you get the target device in a
> different way?
>=20
>> +
>> +static int ap_aqic(CPUS390XState *env)
>=20
> <bikeshed>I think ap_pqap_aqic would be slightly better.</bikeshed>

agreed.

>=20
>> +{
>> +    struct pqap_cmd cmd =3D reg2cmd(env->regs[0]);
>> +    struct ap_status status =3D reg2status(env->regs[1]);
>=20
> I don't really like those reg2<whatever> helpers; they obfuscate things
> IMO.
>=20

I agree, I will use masks and uint64_t/uint32_t.


> Also: These are internal structs and not copied from Linux, right? Then
> they should be CamelCase.
>=20
>> +    uint64_t guest_nib =3D env->regs[2];
>=20
> Another point: What about endianness? Even though this is kvm-only, I
> would like an emulation of an instruction to be endian-clean. (Maybe it
> also needs a different split?)

OK, I will look at this

>=20
>> +    struct vfio_ap_aqic param =3D {};
>> +    int retval;
>> +    VFIODevice *vdev;
>> +    VFIOAPDevice *ap_vdev;
>> +    APQueue *apq;
>> +
>> +    ap_vdev =3D DO_UPCAST(VFIOAPDevice, apdev, matrix);
>> +    apq =3D &ap_vdev->apq[cmd.apid][cmd.apqi];
>> +    vdev =3D &ap_vdev->vdev;
>> +
>> +    if (status.irq) {
>> +        if (apq->nib) {
>> +            status.rc =3D AP_RC_BAD_STATE;
>> +            goto error;
>> +        }
>> +    } else {
>> +        if (!apq->nib) {
>> +            status.rc =3D AP_RC_BAD_STATE;
>> +            goto error;
>> +        }
>> +    }
>=20
> Maybe
>      if (!!status.irq =3D=3D !!apq->nib) {
>          status.rc =3D AP_RC_BAD_STATE;
>          goto error;
>      }
> ?

:)

>=20
>> +    if (!guest_nib) {
>> +        status.rc =3D AP_RC_INVALID_ADDR;
>> +        goto error;
>> +    }
>> +
>> +    apq->routes.adapter.adapter_id =3D css_get_adapter_id(
>> +                                       CSS_IO_ADAPTER_AP, status.isc)=
;
>> +
>> +    apq->nib =3D get_indicator(ldq_p(&guest_nib), 8);
>> +
>> +    retval =3D map_indicator(&apq->routes.adapter, apq->nib);
>> +    if (retval) {
>> +        status.rc =3D AP_RC_INVALID_ADDR;
>> +        env->regs[1] =3D status2reg(status);
>=20
> I do not like the backwards conversion macros, either :(
>=20
>> +        goto error;
>> +    }
>> +
>> +    param.cmd =3D env->regs[0];
>> +    param.status =3D env->regs[1];
>> +    param.nib =3D env->regs[2];
>> +    param.adapter_id =3D apq->routes.adapter.adapter_id;
>> +    param.argsz =3D sizeof(param);
>> +
>> +    retval =3D ioctl(vdev->fd, VFIO_AP_SET_IRQ, &param);
>> +    status =3D reg2status(param.status);
>> +    if (retval) {
>> +        goto err_ioctl;
>> +    }
>> +
>> +    env->regs[1] =3D param.status;
>> +
>> +    return 0;
>> +err_ioctl:
>> +    release_indicator(&apq->routes.adapter, apq->nib);
>> +    apq->nib =3D NULL;
>> +error:
>> +    env->regs[1] =3D status2reg(status);
>> +    return 0;
>> +}
>> +
>>   /*
>>    * ap_pqap
>>    * @env: environment pointing to registers
>> @@ -45,7 +118,20 @@ typedef struct VFIOAPDevice {
>>    */
>>   int ap_pqap(CPUS390XState *env)
>>   {
>> -    return -PGM_OPERATION;
>> +    struct pqap_cmd cmd =3D reg2cmd(env->regs[0]);
>=20
> Dito on the macro.
>=20
>> +    int cc =3D 0;
>> +
>> +    switch (cmd.fc) {
>=20
> This probably needs some endian handling as well.
>=20
>> +    case AQIC:
>=20
> What about calling this PQAP_AQCI?

I can use it , however the function itself is called ap_pqap()
so we already know it is about PQAP...


>=20
>> +        if (!s390_has_feat(S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL)) {
>> +            return -PGM_OPERATION;
>> +        }
>> +        cc =3D ap_aqic(env);
>> +        break;
>> +    default:
>> +        return -PGM_OPERATION;
>> +    }
>> +    return cc;
>>   }
>>  =20
>>   static void vfio_ap_compute_needs_reset(VFIODevice *vdev)
>> @@ -119,6 +205,9 @@ static void vfio_ap_realize(DeviceState *dev, Erro=
r **errp)
>>           goto out_get_dev_err;
>>       }
>>  =20
>> +    matrix =3D apdev;
>=20
> Huh?

OK, sorry, I can do better. (I hope)

>=20
>> +    css_register_io_adapters(CSS_IO_ADAPTER_AP, true, false,
>> +                             0, &error_abort);
>>       return;
>>  =20
>>   out_get_dev_err:
>> @@ -135,6 +224,7 @@ static void vfio_ap_unrealize(DeviceState *dev, Er=
ror **errp)
>>       VFIOGroup *group =3D vapdev->vdev.group;
>>  =20
>>       vfio_ap_put_device(vapdev);
>> +    matrix =3D NULL;
>>       vfio_put_group(group);
>>   }
>>  =20
>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device=
.h
>> index a83ea096c7..bc2b7bcd8e 100644
>> --- a/include/hw/s390x/ap-device.h
>> +++ b/include/hw/s390x/ap-device.h
>> @@ -28,4 +28,50 @@ typedef struct APDevice {
>>   #include "cpu.h"
>>   int ap_pqap(CPUS390XState *env);
>>  =20
>> +#define MAX_AP 256
>> +#define MAX_DOMAIN 256
>> +
>> +#include "hw/s390x/s390_flic.h"
>> +#include "hw/s390x/css.h"
>> +typedef struct APQueue {
>> +    uint32_t apid;
>> +    uint32_t apqi;
>> +    AdapterRoutes routes;
>> +    IndAddr *nib;
>> +} APQueue;
>> +
>> +/* AP PQAP commands definitions */
>> +#define AQIC 0x03
>> +
>> +struct pqap_cmd {
>> +    uint32_t unused;
>> +    uint8_t fc;
>> +    unsigned t:1;
>> +    unsigned reserved:7;
>=20
> It is better to make this an uint8_t and define an accessor for the 't'
> bit.

OK

>=20
>> +    uint8_t apid;
>> +    uint8_t apqi;
>> +};
>=20
> Also, please use typedef and CamelCase :)

right, more camels

>=20
>> +/* AP status returned by the AP PQAP commands */
>> +#define AP_RC_APQN_INVALID 0x01
>> +#define AP_RC_INVALID_ADDR 0x06
>> +#define AP_RC_BAD_STATE    0x07
>> +
>> +struct ap_status {
>> +    uint16_t pad;
>> +    unsigned irq:1;
>> +    unsigned pad2:15;
>> +    unsigned e:1;
>> +    unsigned r:1;
>> +    unsigned f:1;
>> +    unsigned unused:4;
>> +    unsigned i:1;
>> +    unsigned char rc;
>> +    unsigned reserved:13;
>> +    unsigned isc:3;
>> +};
>=20
> Dito on bitfields and CamelCase :)

OK again, even more Camels

Thanks,
Pierre

>=20
>> +
>> +#define reg2cmd(reg) (*(struct pqap_cmd *)&(reg))
>> +#define status2reg(status) (*((uint64_t *)&status))
>> +#define reg2status(reg) (*(struct ap_status *)&(reg))
>> +
>>   #endif /* HW_S390X_AP_DEVICE_H */
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
