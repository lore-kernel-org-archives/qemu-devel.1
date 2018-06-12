Received: from eggs.gnu.org ([2001:4830:134:3::10]:33763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSfaI-0005dV-Rg
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fSfaF-00052k-Kk
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:27:26 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:40147)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fSfaF-00052N-A2
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 05:27:23 -0400
Received: from player688.ha.ovh.net (unknown [10.109.108.43])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 97D011BE1C8
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 11:27:21 +0200 (CEST)
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<20180612064503.14282-33-david@gibson.dropbear.id.au>
	<20180612111617.023c3f68@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a3cf19cb-f7e5-7555-7c0a-45fb53a9d9ba@kaod.org>
Date: Tue, 12 Jun 2018 11:27:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180612111617.023c3f68@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 32/33] xics_kvm: use KVM helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com

On 06/12/2018 11:16 AM, Greg Kurz wrote:
> On Tue, 12 Jun 2018 16:45:02 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> The KVM helpers hide the low level interface used to communicate to
>> the XICS KVM device and provide a good cleanup to the XICS KVM models.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/intc/xics_kvm.c | 52 +++++++++++++--------------------------------=
-
>>  1 file changed, 14 insertions(+), 38 deletions(-)
>>
>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
>> index 89fb20e2c5..8bdf6afe82 100644
>> --- a/hw/intc/xics_kvm.c
>> +++ b/hw/intc/xics_kvm.c
>> @@ -56,10 +56,6 @@ static QLIST_HEAD(, KVMEnabledICP)
>>  static void icp_get_kvm_state(ICPState *icp)
>>  {
>>      uint64_t state;
>> -    struct kvm_one_reg reg =3D {
>> -        .id =3D KVM_REG_PPC_ICP_STATE,
>> -        .addr =3D (uintptr_t)&state,
>> -    };
>>      int ret;
>> =20
>>      /* ICP for this CPU thread is not in use, exiting */
>> @@ -67,7 +63,7 @@ static void icp_get_kvm_state(ICPState *icp)
>>          return;
>>      }
>> =20
>> -    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_GET_ONE_REG, &reg);
>> +    ret =3D kvm_get_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
>>      if (ret !=3D 0) {
>>          error_report("Unable to retrieve KVM interrupt controller sta=
te"
>>                  " for CPU %ld: %s", kvm_arch_vcpu_id(icp->cs), strerr=
or(errno));
>> @@ -96,10 +92,6 @@ static void icp_synchronize_state(ICPState *icp)
>>  static int icp_set_kvm_state(ICPState *icp, int version_id)
>>  {
>>      uint64_t state;
>> -    struct kvm_one_reg reg =3D {
>> -        .id =3D KVM_REG_PPC_ICP_STATE,
>> -        .addr =3D (uintptr_t)&state,
>> -    };
>>      int ret;
>> =20
>>      /* ICP for this CPU thread is not in use, exiting */
>> @@ -111,7 +103,7 @@ static int icp_set_kvm_state(ICPState *icp, int ve=
rsion_id)
>>          | ((uint64_t)icp->mfrr << KVM_REG_PPC_ICP_MFRR_SHIFT)
>>          | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SH=
IFT);
>> =20
>> -    ret =3D kvm_vcpu_ioctl(icp->cs, KVM_SET_ONE_REG, &reg);
>> +    ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
>>      if (ret !=3D 0) {
>>          error_report("Unable to restore KVM interrupt controller stat=
e (0x%"
>>                  PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(i=
cp->cs),
>> @@ -185,21 +177,15 @@ static const TypeInfo icp_kvm_info =3D {
>>  static void ics_get_kvm_state(ICSState *ics)
>>  {
>>      uint64_t state;
>> -    struct kvm_device_attr attr =3D {
>> -        .flags =3D 0,
>> -        .group =3D KVM_DEV_XICS_GRP_SOURCES,
>> -        .addr =3D (uint64_t)(uintptr_t)&state,
>> -    };
>>      int i;
>> +    Error *local_err =3D NULL;
>> =20
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D &ics->irqs[i];
>> -        int ret;
>> -
>> -        attr.attr =3D i + ics->offset;
>> =20
>> -        ret =3D ioctl(kernel_xics_fd, KVM_GET_DEVICE_ATTR, &attr);
>> -        if (ret !=3D 0) {
>> +        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>> +                          i + ics->offset, &state, false, &local_err)=
;
>> +        if (local_err) {
>>              error_report("Unable to retrieve KVM interrupt controller=
 state"
>>                      " for IRQ %d: %s", i + ics->offset, strerror(errn=
o));
>>              exit(1);
>> @@ -255,19 +241,13 @@ static void ics_synchronize_state(ICSState *ics)
>>  static int ics_set_kvm_state(ICSState *ics, int version_id)
>>  {
>>      uint64_t state;
>> -    struct kvm_device_attr attr =3D {
>> -        .flags =3D 0,
>> -        .group =3D KVM_DEV_XICS_GRP_SOURCES,
>> -        .addr =3D (uint64_t)(uintptr_t)&state,
>> -    };
>>      int i;
>> +    Error *local_err =3D NULL;
>> =20
>>      for (i =3D 0; i < ics->nr_irqs; i++) {
>>          ICSIRQState *irq =3D &ics->irqs[i];
>>          int ret;
>> =20
>> -        attr.attr =3D i + ics->offset;
>> -
>>          state =3D irq->server;
>>          state |=3D (uint64_t)(irq->saved_priority & KVM_XICS_PRIORITY=
_MASK)
>>              << KVM_XICS_PRIORITY_SHIFT;
>> @@ -293,8 +273,9 @@ static int ics_set_kvm_state(ICSState *ics, int ve=
rsion_id)
>>                  state |=3D KVM_XICS_QUEUED;
>>          }
>> =20
>> -        ret =3D ioctl(kernel_xics_fd, KVM_SET_DEVICE_ATTR, &attr);
>> -        if (ret !=3D 0) {
>> +        kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>> +                          i + ics->offset, &state, true, &local_err);
>> +        if (local_err) {
>>              error_report("Unable to restore KVM interrupt controller =
state"
>>                      " for IRQs %d: %s", i + ics->offset, strerror(err=
no));
>>              return ret;
>=20
> This breaks build on CentOS 7.5 with gcc-4.8.5-28.el7_5.1.ppc64le:
>=20
> hw/intc/xics_kvm.c: In function =E2=80=98ics_set_kvm_state=E2=80=99:
> hw/intc/xics_kvm.c:281:13: error: =E2=80=98ret=E2=80=99 may be used uni=
nitialized in this
>  function [-Werror=3Dmaybe-uninitialized]
>              return ret;

curiously, a newer compiler gcc7.3.1 didn't see anything.

> Also, if kvm_device_access() has set local_err, then it should be used =
or
> freed. I think that what you need to do here is something like:
>=20
>=20
>         ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOUR=
CES,
>                                 i + ics->offset, &state, true, &local_e=
rr);
>         if (local_err) {
>             error_reportf_err(local_err, "Unable to restore KVM interru=
pt"
>                               " controller state for IRQs %d: ",
>                               i + ics->offset);
>             return ret;
>         }
>=20
> This also happens to fix the return value of ics_set_kvm_state()
> which is propagated as is to VMState, and thus should be a negative
> errno.

I will see what I can do for that. Cooking a fix.

Thanks,

C.

>> @@ -391,10 +372,6 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMach=
ineState *spapr,
>>  int xics_kvm_init(sPAPRMachineState *spapr, Error **errp)
>>  {
>>      int rc;
>> -    struct kvm_create_device xics_create_device =3D {
>> -        .type =3D KVM_DEV_TYPE_XICS,
>> -        .flags =3D 0,
>> -    };
>> =20
>>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ=
_XICS)) {
>>          error_setg(errp,
>> @@ -431,20 +408,19 @@ int xics_kvm_init(sPAPRMachineState *spapr, Erro=
r **errp)
>>          goto fail;
>>      }
>> =20
>> -    /* Create the kernel ICP */
>> -    rc =3D kvm_vm_ioctl(kvm_state, KVM_CREATE_DEVICE, &xics_create_de=
vice);
>> +    /* Create the KVM XICS device */
>> +    rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
>>      if (rc < 0) {
>>          error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for X=
ICS");
>>          goto fail;
>>      }
>> =20
>> -    kernel_xics_fd =3D xics_create_device.fd;
>> -
>> +    kernel_xics_fd =3D rc;
>>      kvm_kernel_irqchip =3D true;
>>      kvm_msi_via_irqfd_allowed =3D true;
>>      kvm_gsi_direct_mapping =3D true;
>> =20
>> -    return rc;
>> +    return 0;
>> =20
>>  fail:
>>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>=20
