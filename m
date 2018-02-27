Received: from eggs.gnu.org ([2001:4830:134:3::10]:44822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqjr8-0006S5-IT
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:20:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqjr4-0000vr-Ug
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:20:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1eqjr4-0000vJ-AR
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 13:19:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RIEAt2072938
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:19:56 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd9wc05du-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 13:19:56 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 11:19:55 -0700
References: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1519746259-27710-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<20180227172750.287cf563.cohuck@redhat.com>
	<603c3118-63b3-c144-56e1-3e6301936c9b@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 13:19:46 -0500
MIME-Version: 1.0
In-Reply-To: <603c3118-63b3-c144-56e1-3e6301936c9b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <879f6c34-291d-76d1-1145-caa853c31cc9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 02/27/2018 11:49 AM, Halil Pasic wrote:
>
> On 02/27/2018 05:27 PM, Cornelia Huck wrote:
>> On Tue, 27 Feb 2018 10:44:19 -0500
>> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
>>> A new CPU model feature and two new CPU model facilities are
>>> introduced to support AP devices for a KVM guest.
>>>
>>> CPU model features:
>>>
>>> 1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
>>>     AP facilities are installed. This feature will be enabled by
>>>     the kernel only if the AP facilities are installed on the linux
>>>     host. This feature must be turned on from userspace to access
>>>     AP devices from the KVM guest. The QEMU command line to turn
>>>     this feature looks something like this:
>>>
>>> 	qemu-system-s390x ... -cpu xxx,ap=on
>>>
>>> CPU model facilities:
>>>
>>> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
>>>     Configuration Information (QCI) facility is installed. This feature
>>>     will be enabled by the kernel only if the QCI is installed on
>>>     the host. This facility will be set by QEMU only if the
>>>     KVM_S390_VM_CPU_FEAT_AP CPU model feature is turned on.
>>>     (see CPU model features above)
>>>
>>> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
>>>     Test Facility (APFT) facility is installed. This feature will
>>>     be enabled by the kernel only if the APFT facility is installed
>>>     on the host. This facility will be set by QEMU for the KVM guest
>>>     only if the KVM_S390_VM_CPU_FEAT_AP CPU model feature is turned on.
>>>     (see CPU model features above)
>>>
> This may needs to be reworded. See my comments below.
>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   hw/vfio/ap.c                    |    9 +++++++++
>>>   linux-headers/asm-s390/kvm.h    |    1 +
>>>   target/s390x/cpu_features.c     |    3 +++
>>>   target/s390x/cpu_features_def.h |    3 +++
>>>   target/s390x/cpu_models.c       |   12 ++++++++++++
>>>   target/s390x/gen-features.c     |    3 +++
>>>   target/s390x/kvm.c              |    6 ++++++
>>>   7 files changed, 37 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 8aa5221..b93f7d9 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -19,6 +19,7 @@
>>>   #include "hw/s390x/ap-device.h"
>>>   #include "qemu/error-report.h"
>>>   #include "qemu/queue.h"
>>> +#include "cpu.h"
>>>   
>>>   #define VFIO_AP_DEVICE_TYPE      "vfio-ap"
>>>   #define AP_SYSFSDEV_PROP_NAME    "sysfsdev"
>>> @@ -87,6 +88,14 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>       Error *local_err = NULL;
>>>       int ret;
>>>   
>>> +    if (!s390_has_feat(S390_FEAT_AP)) {
>>> +        error_setg(&local_err, "Invalid device configuration: ");
>> "AP support not available" ?
>>
>> [The hint is not visible in every circumstance IIRC]
>>
> I agree, it does not make sense to split this into a message and
> a hint.
>
> [..]
>
>>> @@ -900,6 +902,16 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
>>>       cpu->model->cpu_id_format = max_model->cpu_id_format;
>>>       cpu->model->cpu_ver = max_model->cpu_ver;
>>>   
>>> +    /*
>>> +     * If the AP facilities are not installed on the guest, then it makes
>>
>> "not provided in the model" ?
>>
>>> +     * no sense to enable the QCI or APFT facilities because they are only
>>> +     * needed by AP facilities.
>>> +     */
>>> +    if (!test_bit(S390_FEAT_AP, cpu->model->features)) {
>>> +        clear_bit(S390_FEAT_AP_QUERY_CONFIG_INFO, cpu->model->features);
>>> +        clear_bit(S390_FEAT_AP_FACILITIES_TEST, cpu->model->features);
>>> +    }
>>> +
> I don't like this at all. Never liked software that overrules my user input.
> If I say --cpu z13,ap=off,qci=on,apft=on this would silently overrule to
> --cpu z13,ap=off,qci=off,apft=off from the guest perspective. There also might be
> other reasons why this is a bad idea.
>
>>>       check_consistency(cpu->model);
>>>       check_compatibility(max_model, cpu->model, errp);
>>>       if (*errp) {
>>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>>> index 0cdbc15..2d01b52 100644
>>> --- a/target/s390x/gen-features.c
>>> +++ b/target/s390x/gen-features.c
>>> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
>>>       S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>>       S390_FEAT_EDAT_2,
>>>       S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>>> +    S390_FEAT_AP,
>>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>>> +    S390_FEAT_AP_FACILITIES_TEST,
>>>   };
>>>   
>>>   static uint16_t full_GEN12_GA2[] = {
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index e13c890..ae20ed8 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -2105,6 +2105,7 @@ static int kvm_to_feat[][2] = {
>>>       { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>>>       { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
>>>       { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
>>> +    { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},
>>>   };
>>>   
>>>   static int query_cpu_feat(S390FeatBitmap features)
>>> @@ -2214,6 +2215,11 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>>           error_setg(errp, "KVM: Error querying CPU features: %d", rc);
>>>           return;
>>>       }
>>> +    /* AP facilities support is required to enable QCI and APFT support */
>>> +    if (!test_bit(S390_FEAT_AP, model->features)) {
>>> +        clear_bit(S390_FEAT_AP_QUERY_CONFIG_INFO, model->features);
>>> +        clear_bit(S390_FEAT_AP_FACILITIES_TEST, model->features);
>>> +    }
>> Hm, do you need this twice?
> In my opinion this has only value if we assume that HW and/or KVM is buggy and
> we are running host model (or it's expansion).
>
> And even the we would get a warning, and nothing bad would happen with a linux
> guest.
It is going, going ..... gone!
>
> While I'm not strongly opposing this, I would not mind it dropped. If we want
> to make sure things are consistent I would prefer the consistency check being
> generating an error (instead of a warning).
>
>>>       /* get supported cpu subfunctions indicated via query / test bit */
>>>       rc = query_cpu_subfunc(model->features);
>>>       if (rc) {
>> I'm leaving a general review of the cpu model things to David.
I'm looking forward to David's comments.
>>
> Except for these it's LGTM (r-b level LGTM).
