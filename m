Received: from eggs.gnu.org ([2001:4830:134:3::10]:49897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAbvu-0001oC-MP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dAbvq-0000mf-Oq
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:50:34 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:44983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dAbvq-0000kk-HZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:50:30 -0400
Received: from player693.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 897FBD29CD
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 14:50:20 +0200 (CEST)
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
	<20170426070034.10727-20-david@gibson.dropbear.id.au>
	<0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1a7e5576-6464-6d5b-f4a8-44dceb8a17af@kaod.org>
Date: Tue, 16 May 2017 14:50:10 +0200
MIME-Version: 1.0
In-Reply-To: <0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/48] spapr: allocate the ICPState object
 from under sPAPRCPUCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org

On 05/16/2017 02:03 PM, Laurent Vivier wrote:
> On 26/04/2017 09:00, David Gibson wrote:
>> From: C=C3=A9dric Le Goater <clg@kaod.org>
>>
>> Today, all the ICPs are created before the CPUs, stored in an array
>> under the sPAPR machine and linked to the CPU when the core threads
>> are realized. This modeling brings some complexity when a lookup in
>> the array is required and it can be simplified by allocating the ICPs
>> when the CPUs are.
>>
>> This is the purpose of this proposal which introduces a new 'icp_type'
>> field under the machine and creates the ICP objects of the right type
>> (KVM or not) before the PowerPCCPU object are.
>>
>> This change allows more cleanups : the removal of the icps array under
>> the sPAPR machine and the removal of the xics_get_cpu_index_by_dt_id()
>> helper.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>> ---
>>  hw/intc/xics.c          | 11 -----------
>>  hw/ppc/spapr.c          | 47 ++++++++++++++--------------------------=
-------
>>  hw/ppc/spapr_cpu_core.c | 18 ++++++++++++++----
>>  include/hw/ppc/spapr.h  |  2 +-
>>  include/hw/ppc/xics.h   |  2 --
>>  5 files changed, 29 insertions(+), 51 deletions(-)
>>
>=20
> This commit breaks CPU re-hotplugging with KVM
>=20
> the sequence "device_add, device_del, device_add" brings to the
> following error message:
>=20
>     Unable to connect CPUx to kernel XICS: Device or resource busy
>=20
> It comes from icp_kvm_cpu_setup():
>=20
> ...
>     ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd=
,
>                               kvm_arch_vcpu_id(cs));
>     if (ret < 0) {
>         error_report("Unable to connect CPU%ld to kernel XICS: %s",
>                      kvm_arch_vcpu_id(cs), strerror(errno));
>         exit(1);
>     }
> ..
>=20
> It should be protected by cap_irq_xics_enabled:
>=20
> ...
>     /*
>      * If we are reusing a parked vCPU fd corresponding to the CPU
>      * which was hot-removed earlier we don't have to renable
>      * KVM_CAP_IRQ_XICS capability again.
>      */
>     if (icp->cap_irq_xics_enabled) {
>         return;
>     }
>
> ...
>     ret =3D kvm_vcpu_enable_cap(...);
> ...
>     icp->cap_irq_xics_enabled =3D true;
> ...
>=20
> But since this commit, "icp" is a new object on each call:
>=20
> spapr_cpu_core_realize_child()
> ...
>     obj =3D object_new(spapr->icp_type);
> ...
>     xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
>     ...
>             icpc->cpu_setup(icp, cpu); -> icp_kvm_cpu_setup()
>     ...
> ...
>=20
> and "cap_irq_xics_enabled" is reinitialized.
>=20
> Any idea how to fix that?

it seems that a cleanup is not done in the kernel. We are missing
a way to call kvmppc_xics_free_icp() from QEMU. Today the only
way is to destroy the vcpu.=20

Else we need to reintroduce the array of icps (again) to keep some=20
xics state ... but that just sucks :/ Let me think about it.=20


C.
