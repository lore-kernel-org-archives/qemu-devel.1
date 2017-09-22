Received: from eggs.gnu.org ([2001:4830:134:3::10]:50316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvMpk-0005rC-Cz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:13:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1dvMpg-0002j9-Am
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:13:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1dvMpg-0002hT-1X
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:13:24 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8MC96me114983
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:13:18 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d51jt3ctw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:13:18 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Fri, 22 Sep 2017 13:13:15 +0100
References: <20170922083855.102341-1-borntraeger@de.ibm.com>
	<20170922083855.102341-3-borntraeger@de.ibm.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 14:13:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170922083855.102341-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <5e7ba7d5-82d4-f1e6-532a-37c2c445c227@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH/RFC 2/3] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On 22/09/2017 10:38, Christian Borntraeger wrote:
> Instead of unconditionally enabling the KVM AIS capability
> in the kvm arch init function, do this in the flic realize function
> when we know if migration is available. This requires to initialize
> flic before the CPUs.

I am not sure to agree.

AIS facility is used for PCI (currently only PCI)
We want to support PCI emulation and PCI VFIO


Not having AIS support in the host kernel or not supporting AISM in the=20
host kernel does not affect the emulation.
Neither virtio-pci nor TCG.

The only devices, (currently), which can not work without AIS and is not=20
migratable without AISM are PCI VFIO devices.

Wouldn't it be possible to just refuse to realize these devices when we=20
have no kernel support for AISM?
And accept to migrate without kernel support if they are not used?

Pierre

>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   hw/intc/s390_flic.c          | 11 +++++++++--
>   hw/intc/s390_flic_kvm.c      |  8 +++++++-
>   hw/s390x/s390-virtio-ccw.c   |  8 ++++++--
>   include/hw/s390x/s390_flic.h |  1 +
>   target/s390x/cpu_models.c    |  6 ++++++
>   target/s390x/kvm.c           |  8 +-------
>   6 files changed, 30 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/intc/s390_flic.c b/hw/intc/s390_flic.c
> index 6eaf178..08040fe 100644
> --- a/hw/intc/s390_flic.c
> +++ b/hw/intc/s390_flic.c
> @@ -1,7 +1,7 @@
>   /*
>    * QEMU S390x floating interrupt controller (flic)
>    *
> - * Copyright 2014 IBM Corp.
> + * Copyright 2014,2017 IBM Corp.
>    * Author(s): Jens Freimann <jfrei@linux.vnet.ibm.com>
>    *            Cornelia Huck <cornelia.huck@de.ibm.com>
>    *
> @@ -49,6 +49,13 @@ void s390_flic_init(void)
>       qdev_init_nofail(dev);
>   }
>=20
> +void s390_flic_enable_ais(void)
> +{
> +    S390FLICState *fs =3D s390_get_flic();
> +
> +    fs->ais_supported =3D true;
> +}
> +
>   static int qemu_s390_register_io_adapter(S390FLICState *fs, uint32_t =
id,
>                                            uint8_t isc, bool swap,
>                                            bool is_maskable, uint8_t fl=
ags)
> @@ -186,7 +193,7 @@ static void s390_flic_common_realize(DeviceState *d=
ev, Error **errp)
>           return;
>       }
>=20
> -    fs->ais_supported =3D s390_has_feat(S390_FEAT_ADAPTER_INT_SUPPRESS=
ION);
> +    fs->ais_supported =3D false;
>   }
>=20
>   static void s390_flic_class_init(ObjectClass *oc, void *data)
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index 7ead17a..a655567 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -1,7 +1,7 @@
>   /*
>    * QEMU S390x KVM floating interrupt controller (flic)
>    *
> - * Copyright 2014 IBM Corp.
> + * Copyright 2014,2017 IBM Corp.
>    * Author(s): Jens Freimann <jfrei@linux.vnet.ibm.com>
>    *            Cornelia Huck <cornelia.huck@de.ibm.com>
>    *
> @@ -557,6 +557,12 @@ static void kvm_s390_flic_realize(DeviceState *dev=
, Error **errp)
>       test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
>       flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
>                                               KVM_HAS_DEVICE_ATTR, test=
_attr);
> +    /* try enable the AIS facility */
> +    test_attr.group =3D KVM_DEV_FLIC_AISM_ALL;
> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
> +    }
> +
>       return;
>   fail:
>       error_propagate(errp, errp_local);
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index fafbc6d..11d4dc4 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -279,11 +279,15 @@ static void ccw_init(MachineState *machine)
>       s390_sclp_init();
>       s390_memory_init(machine->ram_size);
>=20
> +    /*
> +     * This might also enable some KVM features like AIS, so it must
> +     * be called before the CPU model
> +     */
> +    s390_flic_init();
> +
>       /* init CPUs (incl. CPU model) early so s390_has_feature() works =
*/
>       s390_init_cpus(machine);
>=20
> -    s390_flic_init();
> -
>       /* get a BUS */
>       css_bus =3D virtual_css_bus_init();
>       s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdli=
ne,
> diff --git a/include/hw/s390x/s390_flic.h b/include/hw/s390x/s390_flic.=
h
> index 7aab6ef..ac4e170 100644
> --- a/include/hw/s390x/s390_flic.h
> +++ b/include/hw/s390x/s390_flic.h
> @@ -90,6 +90,7 @@ void s390_flic_init(void);
>=20
>   S390FLICState *s390_get_flic(void);
>   bool ais_needed(void *opaque);
> +void s390_flic_enable_ais(void);
>=20
>   #ifdef CONFIG_KVM
>   DeviceState *s390_flic_kvm_create(void);
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 5169379..03ff583 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -23,6 +23,7 @@
>   #include "qapi/qobject-input-visitor.h"
>   #include "qapi/qmp/qbool.h"
>   #ifndef CONFIG_USER_ONLY
> +#include "hw/s390x/s390_flic.h"
>   #include "sysemu/arch_init.h"
>   #endif
>=20
> @@ -901,6 +902,11 @@ static inline void apply_cpu_model(const S390CPUMo=
del *model, Error **errp)
>               applied_model =3D *model;
>           }
>       }
> +
> +    if (model &&
> +        test_bit(S390_FEAT_ADAPTER_INT_SUPPRESSION, model->features)) =
{
> +        s390_flic_enable_ais();
> +    }
>   #endif
>   }
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index ebb75ca..6c5c57e 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -311,13 +311,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>           }
>       }
>=20
> -    /*
> -     * The migration interface for ais was introduced with kernel 4.13
> -     * but the capability itself had been active since 4.12. As migrat=
ion
> -     * support is considered necessary let's disable ais in the 2.10
> -     * machine.
> -     */
> -    /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
> +    /* The AIS enablement happens in the flic realize */
>=20
>       qemu_mutex_init(&qemu_sigp_mutex);
>=20


--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
