Received: from eggs.gnu.org ([2001:4830:134:3::10]:38907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPOD-0003pu-04
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:42:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gSPO7-0001Or-V1
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:42:08 -0500
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:60898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gSPO7-0001M7-Jp
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 11:42:03 -0500
Received: from player797.ha.ovh.net (unknown [10.109.146.19])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 6F3A3E44CF
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:42:01 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-34-clg@kaod.org>
	<20181129041734.GI14697@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c04f8dac-3d36-a436-4480-3ea0badd997c@kaod.org>
Date: Thu, 29 Nov 2018 17:41:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181129041734.GI14697@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 33/36] spapr: introduce routines to
 delete the KVM IRQ device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/29/18 5:17 AM, David Gibson wrote:
> On Fri, Nov 16, 2018 at 11:57:26AM +0100, C=E9dric Le Goater wrote:
>> If a new interrupt mode is chosen by CAS, the machine generates a
>> reset to reconfigure. At this point, the connection with the previous
>> KVM device needs to be closed and a new connection needs to opened
>> with the KVM device operating the chosen interrupt mode.
>>
>> New routines are introduced to destroy the XICS and XIVE KVM
>> devices. They make use of a new KVM device ioctl which destroys the
>> device and also disconnects the IRQ presenters from the VCPUs.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/ppc/spapr_xive.h |  1 +
>>  include/hw/ppc/xics.h       |  1 +
>>  linux-headers/linux/kvm.h   |  2 ++
>>  hw/intc/spapr_xive_kvm.c    | 54 +++++++++++++++++++++++++++++++++++
>>  hw/intc/xics_kvm.c          | 57 ++++++++++++++++++++++++++++++++++++=
+
>>  5 files changed, 115 insertions(+)
>>
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 1d134a681326..c913c0aed08a 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -108,5 +108,6 @@ void spapr_xive_mmio_map(sPAPRXive *xive);
>>  #define XIVE_TCTX_KVM(obj)   OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_=
TCTX_KVM)
>> =20
>>  void spapr_xive_kvm_init(sPAPRXive *xive, Error **errp);
>> +void spapr_xive_kvm_fini(sPAPRXive *xive, Error **errp);
>> =20
>>  #endif /* PPC_SPAPR_XIVE_H */
>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
>> index 9958443d1984..a5468c6eb6e3 100644
>> --- a/include/hw/ppc/xics.h
>> +++ b/include/hw/ppc/xics.h
>> @@ -205,6 +205,7 @@ void icp_resend(ICPState *ss);
>>  typedef struct sPAPRMachineState sPAPRMachineState;
>> =20
>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp);
>> +int xics_kvm_fini(sPAPRMachineState *spapr, Error **errp);
>>  void xics_spapr_init(sPAPRMachineState *spapr);
>> =20
>>  Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index 59fa8d8d7f39..b7a74c58d0db 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>=20
> linux-headers updates separate.

yes.=20

>=20
>> @@ -1309,6 +1309,8 @@ struct kvm_s390_ucas_mapping {
>>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_at=
tr)
>>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_at=
tr)
>> =20
>> +#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_create_de=
vice)
>> +
>>  /*
>>   * ioctls for vcpu fds
>>   */
>> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
>> index cb2aa6e81274..0672d8bcbc6b 100644
>> --- a/hw/intc/spapr_xive_kvm.c
>> +++ b/hw/intc/spapr_xive_kvm.c
>> @@ -55,6 +55,16 @@ static void kvm_cpu_enable(CPUState *cs)
>>      QLIST_INSERT_HEAD(&kvm_enabled_cpus, enabled_cpu, node);
>>  }
>> =20
>> +static void kvm_cpu_disable_all(void)
>> +{
>> +    KVMEnabledCPU *enabled_cpu, *next;
>> +
>> +    QLIST_FOREACH_SAFE(enabled_cpu, &kvm_enabled_cpus, node, next) {
>> +        QLIST_REMOVE(enabled_cpu, node);
>> +        g_free(enabled_cpu);
>> +    }
>> +}
>> +
>>  /*
>>   * XIVE Thread Interrupt Management context (KVM)
>>   */
>> @@ -864,6 +874,50 @@ void spapr_xive_kvm_init(sPAPRXive *xive, Error *=
*errp)
>>      kvm_gsi_direct_mapping =3D true;
>>  }
>> =20
>> +void spapr_xive_kvm_fini(sPAPRXive *xive, Error **errp)
>> +{
>> +    XiveSource *xsrc =3D &xive->source;
>> +    struct kvm_create_device xive_destroy_device =3D {
>> +        .fd =3D xive->fd,
>> +        .type =3D KVM_DEV_TYPE_XIVE,
>> +        .flags =3D 0,
>> +    };
>> +    size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
>> +    int rc;
>> +
>> +    /* The KVM XIVE device is not in use */
>> +    if (xive->fd =3D=3D -1) {
>> +        return;
>> +    }
>> +
>> +    if (!kvm_enabled() || !kvmppc_has_cap_xive()) {
>> +        error_setg(errp,
>> +                   "IRQ_XIVE capability must be present for KVM XIVE =
device");
>> +        return;
>=20
> If we're here, xive->fd, checked above, definitely shouldn't have been
> valid, so you can just assert().

ok.

>=20
>> +    }
>> +
>> +    /* Clear the KVM mapping */
>> +    sysbus_mmio_unmap(SYS_BUS_DEVICE(xsrc), 0);
>> +    munmap(xsrc->esb_mmap, esb_len);
>> +    sysbus_mmio_unmap(SYS_BUS_DEVICE(xive), 0);
>> +    munmap(xive->tm_mmap, 4ull << TM_SHIFT);
>> +
>> +    /* Destroy the KVM device. This also clears the VCPU presenters *=
/
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xive_destroy_=
device);
>> +    if (rc < 0) {
>> +        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for =
XIVE");
>> +    }
>> +    close(xive->fd);
>> +    xive->fd =3D -1;
>> +
>> +    kvm_kernel_irqchip =3D false;
>> +    kvm_msi_via_irqfd_allowed =3D false;
>> +    kvm_gsi_direct_mapping =3D false;
>> +
>> +    /* Clear the local list of presenter (hotplug) */
>> +    kvm_cpu_disable_all();
>> +}
>> +
>>  static void spapr_xive_kvm_realize(DeviceState *dev, Error **errp)
>>  {
>>      sPAPRXive *xive =3D SPAPR_XIVE_KVM(dev);
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index eabc901a4556..a7e3ec32a761 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -50,6 +50,16 @@ typedef struct KVMEnabledICP {
>>  static QLIST_HEAD(, KVMEnabledICP)
>>      kvm_enabled_icps =3D QLIST_HEAD_INITIALIZER(&kvm_enabled_icps);
>> =20
>> +static void kvm_disable_icps(void)
>> +{
>> +    KVMEnabledICP *enabled_icp, *next;
>> +
>> +    QLIST_FOREACH_SAFE(enabled_icp, &kvm_enabled_icps, node, next) {
>> +        QLIST_REMOVE(enabled_icp, node);
>> +        g_free(enabled_icp);
>> +    }
>> +}
>> +
>>  /*
>>   * ICP-KVM
>>   */
>> @@ -475,6 +485,53 @@ fail:
>>      return -1;
>>  }
>> =20
>> +int xics_kvm_fini(sPAPRMachineState *spapr, Error **errp)
>> +{
>> +    int rc;
>> +    struct kvm_create_device xics_create_device =3D {
>> +        .fd =3D kernel_xics_fd,
>> +        .type =3D KVM_DEV_TYPE_XICS,
>> +        .flags =3D 0,
>> +    };
>> +
>> +    /* The KVM XICS device is not in use */
>> +    if (kernel_xics_fd =3D=3D -1) {
>> +        return 0;
>> +    }
>> +
>> +    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ=
_XICS)) {
>> +        error_setg(errp,
>> +                   "KVM and IRQ_XICS capability must be present for K=
VM XICS device");
>> +        return -1;
>=20
> Same comment as above.
>=20
>> +    }
>> +
>> +    rc =3D kvm_vm_ioctl(kvm_state, KVM_DESTROY_DEVICE, &xics_create_d=
evice);
>> +    if (rc < 0) {
>> +        error_setg_errno(errp, -rc, "Error on KVM_DESTROY_DEVICE for =
XICS");
>> +    }
>> +    close(kernel_xics_fd);
>> +    kernel_xics_fd =3D -1;
>> +
>> +    spapr_rtas_register(RTAS_IBM_SET_XIVE, NULL, 0);
>> +    spapr_rtas_register(RTAS_IBM_GET_XIVE, NULL, 0);
>> +    spapr_rtas_register(RTAS_IBM_INT_OFF, NULL, 0);
>> +    spapr_rtas_register(RTAS_IBM_INT_ON, NULL, 0);
>> +
>> +    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>> +    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>> +    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
>> +    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
>> +
>> +    kvm_kernel_irqchip =3D false;
>> +    kvm_msi_via_irqfd_allowed =3D false;
>> +    kvm_gsi_direct_mapping =3D false;
>> +
>> +    /* Clear the presenter from the VCPUs */
>> +    kvm_disable_icps();
>> +
>> +    return rc;
>> +}
>> +
>>  static void xics_kvm_register_types(void)
>>  {
>>      type_register_static(&ics_kvm_info);
>=20
