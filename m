Received: from eggs.gnu.org ([2001:4830:134:3::10]:49119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YfA-0002NN-DE
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:04:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1Yf4-0003FW-3t
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:04:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1Yf3-0003F9-RI
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:04:02 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99E1mLh051155
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 10:03:55 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg617r85c-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:03:54 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 15:03:52 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-4-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009104244.02d60070.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 16:03:49 +0200
MIME-Version: 1.0
In-Reply-To: <20171009104244.02d60070.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <957e266f-53e1-82e1-a619-9bed7bce3e00@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/5] s390x/intc: Emulate Adapter
 Interrupt Suppression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 09/10/2017 10:42, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 15:49:37 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> Emulate the Adapter Interrupt Suppression in the KVM FLIC interface wh=
en
>> the kernel does not support AIS.
>>
>> When the kernel KVM does not support AIS, we can not support VFIO PCI
>> devices but we still can support emulated devices if we emulate AIS
>> inside QEMU.
>> Let's emulate AIS, allowing to use emulated PCI devices without KVM AI=
S
>> support.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   hw/intc/s390_flic.c     |  3 +-
>>   hw/intc/s390_flic_kvm.c | 76 +++++++++++++++++++++++++++++++++++++++=
+---------
>>   2 files changed, 64 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
>> index 6eaf178..33a7cde 100644
>> --- a/hw/intc/s390_flic.c
>> +++ b/hw/intc/s390_flic.c
>> @@ -185,8 +185,7 @@ static void s390_flic_common_realize(DeviceState *=
dev, Error **errp)
>>                      " (%d > %d)", max_batch, ADAPTER_ROUTES_MAX_GSI);
>>           return;
>>       }
>> -
>> -    fs->ais_supported =3D s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRES=
SION);
>> +    fs->ais_supported =3D false;
>>   }
>>  =20
>>   static void s390_flic_class_init(ObjectClass *oc, void *data)
>> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
>> index 7ead17a..fd1aa22 100644
>> --- a/hw/intc/s390_flic_kvm.c
>> +++ b/hw/intc/s390_flic_kvm.c
>> @@ -33,6 +33,8 @@ typedef struct KVMS390FLICState {
>>  =20
>>       uint32_t fd;
>>       bool clear_io_supported;
>> +    uint8_t simm;
>> +    uint8_t nimm;
>>   } KVMS390FLICState;
>=20
> Instead of duplicating this, move simm/nimm into the common flic state?

OK.

>=20
>>  =20
>>   DeviceState *s390_flic_kvm_create(void)
>> @@ -164,11 +166,24 @@ static int kvm_s390_modify_ais_mode(S390FLICStat=
e *fs, uint8_t isc,
>>           .addr =3D (uint64_t)&req,
>>       };
>>  =20
>> -    if (!fs->ais_supported) {
>> -        return -ENOSYS;
>> +    if (fs->ais_supported) {
>> +        return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno :=
 0;
>>       }
>>  =20
>> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
>> +    /* Kernel does not support AIS, emulate it here */
>> +    switch (mode) {
>> +    case SIC_IRQ_MODE_ALL:
>> +        flic->simm &=3D ~AIS_MODE_MASK(isc);
>> +        flic->nimm &=3D ~AIS_MODE_MASK(isc);
>> +        break;
>> +    case SIC_IRQ_MODE_SINGLE:
>> +        flic->simm |=3D AIS_MODE_MASK(isc);
>> +        flic->nimm &=3D ~AIS_MODE_MASK(isc);
>> +        break;
>> +    default:
>> +        return -EINVAL;
>> +    }
>=20
> That's just the same as for the qemu flic. What about creating a
> wrapper (to be called from css.c) in the common flic code that calls a
> specific callback (only needed for kvm) and falls back to emulating if
> it was not successful?

Yes, OK.

>=20
>> +    return 0;
>>   }
>>  =20
>>   static int kvm_s390_inject_airq(S390FLICState *fs, uint8_t type,
>> @@ -180,12 +195,23 @@ static int kvm_s390_inject_airq(S390FLICState *f=
s, uint8_t type,
>>           .group =3D KVM_DEV_FLIC_AIRQ_INJECT,
>>           .attr =3D id,
>>       };
>> +    uint32_t io_int_word =3D (isc << 27) | IO_INT_WORD_AI;
>>  =20
>> -    if (!fs->ais_supported) {
>> -        return -ENOSYS;
>> +    if (fs->ais_supported) {
>> +        return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno :=
 0;
>>       }
>>  =20
>> -    return ioctl(flic->fd, KVM_SET_DEVICE_ATTR, &attr) ? -errno : 0;
>> +    /* Kernel does not support AIS, emulate it here */
>> +    if (flags && (flic->nimm & AIS_MODE_MASK(isc))) {
>> +        return 0;
>> +    }
>> +
>> +    s390_io_interrupt(0, 0, 0, io_int_word);
>> +
>> +    if (flags && (flic->simm & AIS_MODE_MASK(isc))) {
>> +        flic->nimm |=3D AIS_MODE_MASK(isc);
>> +    }
>=20
> Same here: I think doing this in the generic flic would make sense.

OK

>=20
>> +    return 0;
>>   }
>>  =20
>>   /**
>> @@ -557,6 +583,32 @@ static void kvm_s390_flic_realize(DeviceState *de=
v, Error **errp)
>>       test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
>>       flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
>>                                               KVM_HAS_DEVICE_ATTR, tes=
t_attr);
>> +    /* To support ais we need all these three FLIC attributes */
>> +    test_attr.group =3D KVM_DEV_FLIC_AISM;
>> +    ret =3D !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
>> +    flic_state->parent_obj.ais_supported &=3D ret;
>> +
>> +    test_attr.group =3D KVM_DEV_FLIC_AIRQ_INJECT;
>> +    ret =3D !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
>> +    flic_state->parent_obj.ais_supported &=3D ret;
>> +
>> +    test_attr.group =3D KVM_DEV_FLIC_AISM_ALL;
>> +    ret &=3D !ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr);
>> +    flic_state->parent_obj.ais_supported &=3D ret;
>> +
>> +    /* For buggy kernels we need to really test that the attribute is=
 supported */
>=20
> Ugh.
>=20
>> +    {
>> +        struct kvm_s390_ais_req req =3D {
>> +            .mode =3D SIC_IRQ_MODE_ALL,
>> +        };
>> +        struct kvm_device_attr attr =3D {
>> +            .group =3D KVM_DEV_FLIC_AISM,
>> +            .addr =3D (uint64_t)&req,
>> +        };
>> +        ret =3D !ioctl(flic_state->fd, KVM_SET_DEVICE_ATTR, &attr);
>> +    }
>> +    flic_state->parent_obj.ais_supported &=3D ret;
>> +
>>       return;
>>   fail:
>>       error_propagate(errp, errp_local);
>> @@ -578,13 +630,11 @@ static void kvm_s390_flic_reset(DeviceState *dev=
)
>>  =20
>>       flic_disable_wait_pfault(flic);
>>  =20
>> -    if (fs->ais_supported) {
>> -        for (isc =3D 0; isc <=3D MAX_ISC; isc++) {
>> -            rc =3D kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL=
);
>> -            if (rc) {
>> -                error_report("Failed to reset ais mode for isc %d: %s=
",
>> -                             isc, strerror(-rc));
>> -            }
>> +    for (isc =3D 0; isc <=3D MAX_ISC; isc++) {
>> +        rc =3D kvm_s390_modify_ais_mode(fs, isc, SIC_IRQ_MODE_ALL);
>> +        if (rc) {
>> +            error_report("Failed to reset ais mode for isc %d: %s",
>> +                         isc, strerror(-rc));
>>           }
>>       }
>>  =20
>=20
>=20

OK, I promote the simm/nimm to the common flic state .

Thanks for review.
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
