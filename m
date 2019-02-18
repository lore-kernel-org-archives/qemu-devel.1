Received: from eggs.gnu.org ([209.51.188.92]:33736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvnGp-0003PV-RW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:04:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gvnGo-00031Z-Tf
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:03:59 -0500
References: <20190205173306.20483-1-eric.auger@redhat.com>
	<20190205173306.20483-8-eric.auger@redhat.com>
	<CAFEAcA9OWQuuqO31-uzTuu-9XSdVkH7UvXdFA1GdvD9emoS0=Q@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <6799d205-cb29-9974-eaf2-1b5020b3a41a@redhat.com>
Date: Mon, 18 Feb 2019 19:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9OWQuuqO31-uzTuu-9XSdVkH7UvXdFA1GdvD9emoS0=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 07/18] kvm: add
 kvm_arm_get_max_vm_phys_shift
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Igor Mammedov <imammedo@redhat.com>, David Hildenbrand <david@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jones <drjones@redhat.com>

Hi Peter,
On 2/14/19 6:15 PM, Peter Maydell wrote:
> On Tue, 5 Feb 2019 at 17:33, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> Add the kvm_arm_get_max_vm_phys_shift() helper that returns the
>> log of the maximum IPA size supported by KVM. This capability
>> needs to be known to create the VM with a specific IPA max size
>> (kvm_type passed along KVM_CREATE_VM ioctl.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>> v4 -> v5:
>> - return 40 if the host does not support the capability
>>
>> v3 -> v4:
>> - s/s/ms in kvm_arm_get_max_vm_phys_shift function comment
>> - check KVM_CAP_ARM_VM_IPA_SIZE extension
>>
>> v1 -> v2:
>> - put this in ARM specific code
>> ---
>>  target/arm/kvm.c     | 10 ++++++++++
>>  target/arm/kvm_arm.h | 13 +++++++++++++
>>  2 files changed, 23 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index e00ccf9c98..fc1dd3ec6a 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -18,6 +18,7 @@
>>  #include "qemu/error-report.h"
>>  #include "sysemu/sysemu.h"
>>  #include "sysemu/kvm.h"
>> +#include "sysemu/kvm_int.h"
>>  #include "kvm_arm.h"
>>  #include "cpu.h"
>>  #include "trace.h"
>> @@ -162,6 +163,15 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>>      env->features = arm_host_cpu_features.features;
>>  }
>>
>> +int kvm_arm_get_max_vm_phys_shift(MachineState *ms)
>> +{
>> +    KVMState *s = KVM_STATE(ms->accelerator);
>> +    int ret;
>> +
>> +    ret = kvm_check_extension(s, KVM_CAP_ARM_VM_IPA_SIZE);
> 
> Why not name the function the same as the extension name?
> 
>> +    return ret > 0 ? ret : 40;
>> +}
>> +
>>  int kvm_arch_init(MachineState *ms, KVMState *s)
>>  {
>>      /* For ARM interrupt delivery is always asynchronous,
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 6393455b1d..0728bbfa6b 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -207,6 +207,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf);
>>   */
>>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>>
>> +/**
>> + * kvm_arm_get_max_vm_phys_shift - Returns log2 of the max IPA size
>> + * supported by KVM
> 
> This is the number of bits in the IPA address space,
> right (ie 40 for a 40-bit IPA, and so on) ? If so, then
> I think "Return number of bits in the IPA address space"
> might be clearer.

It actually returns the MAX number of bits in the IPA address space
supported by the host kernel. What about naming this function
"kvm_arm_get_max_vm_ipa_size".

Thanks

Eric
> 
>> + *
>> + * @ms: Machine state handle
>> + */
>> +int kvm_arm_get_max_vm_phys_shift(MachineState *ms);
> 
> thanks
> -- PMM
> 
