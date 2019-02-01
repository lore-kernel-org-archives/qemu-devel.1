Received: from eggs.gnu.org ([209.51.188.92]:41305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gpWFl-0000lx-IM
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gpWFk-0002pc-MH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:40:57 -0500
References: <20190123101458.12478-1-eric.auger@redhat.com>
	<20190123101458.12478-8-eric.auger@redhat.com>
	<85896c69-2434-ee08-331a-2216704d25e0@gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a6ff5732-5ba2-89aa-77ab-327c22dfbca0@redhat.com>
Date: Fri, 1 Feb 2019 11:30:48 +0100
MIME-Version: 1.0
In-Reply-To: <85896c69-2434-ee08-331a-2216704d25e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 07/18] kvm: add
 kvm_arm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <jiakernel2@gmail.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com, david@gibson.dropbear.id.au

Hi Hia,

On 1/29/19 3:25 PM, Jia He wrote:
> Hi Eric
>=20
> On 2019/1/23 18:14, Eric Auger wrote:
>> Add the kvm_arm_get_max_vm_phys_shift() helper that returns the
>> log of the maximum IPA size supported by KVM. This capability
>> needs to be known to create the VM with a specific IPA max size
>> (kvm_type passed along KVM_CREATE_VM ioctl.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v3 -> v4:
>> - s/s/ms in kvm_arm_get_max_vm_phys_shift function comment
>> - check KVM_CAP_ARM_VM_IPA_SIZE extension
>>
>> v1 -> v2:
>> - put this in ARM specific code
>> ---
>> =C2=A0 target/arm/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++++++++
>> =C2=A0 target/arm/kvm_arm.h | 16 ++++++++++++++++
>> =C2=A0 2 files changed, 24 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index e00ccf9c98..877c588ef5 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -18,6 +18,7 @@
>> =C2=A0 #include "qemu/error-report.h"
>> =C2=A0 #include "sysemu/sysemu.h"
>> =C2=A0 #include "sysemu/kvm.h"
>> +#include "sysemu/kvm_int.h"
>> =C2=A0 #include "kvm_arm.h"
>> =C2=A0 #include "cpu.h"
>> =C2=A0 #include "trace.h"
>> @@ -162,6 +163,13 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *c=
pu)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->features =3D arm_host_cpu_features=
.features;
>> =C2=A0 }
>> =C2=A0 +int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
>> +{
>> +=C2=A0=C2=A0=C2=A0 KVMState *s =3D KVM_STATE(ms->accelerator);
>> +
>> +=C2=A0=C2=A0=C2=A0 return kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_S=
IZE);
>=20
> If KVM_CAP_ARM_VM_IPA_SIZE is not supported in host kernel, would it be
>=20
> better if kvm_arm_get_max_vm_phys_shift returns a default value
>=20
> (e.g. 40),instead of an errno?
Yes I can change that. At the moment kvm_check_extension() should return
0 if the KVM_CAP_ARM_VM_IPA_SIZE entry is not supported by the kernel.

Thanks

Eric
>=20
> ---
> Cheers,
> Jia He
>=20
>> +}
>> +
>> =C2=A0 int kvm_arch_init(MachineState *ms, KVMState *s)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For ARM interrupt delivery is always=
 asynchronous,
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 6393455b1d..5969c41f83 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -207,6 +207,17 @@ bool
>> kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
>> =C2=A0=C2=A0 */
>> =C2=A0 void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>> =C2=A0 +/**
>> + * kvm_arm_get_max_vm_phys_shift - Returns log2 of the max IPA size
>> + * supported by KVM
>> + *
>> + * @ms: Machine state handle
>> + *
>> + * Return the max number of IPA bits or a negative value if
>> + * the host kernel does not expose this value.
>> + */
>> +int kvm_arm_get_max_vm_phys_shift(MachineState *ms);
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * kvm_arm_sync_mpstate_to_kvm
>> =C2=A0=C2=A0 * @cpu: ARMCPU
>> @@ -239,6 +250,11 @@ static inline void
>> kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu->host_cpu_probe_failed =3D true;
>> =C2=A0 }
>> =C2=A0 +static inline int kvm_arm_get_max_vm_phys_shift(MachineState *=
ms)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return -ENOENT;
>> +}
>> +
>> =C2=A0 static inline int kvm_arm_vgic_probe(void)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>=20
