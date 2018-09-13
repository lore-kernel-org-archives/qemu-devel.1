Received: from eggs.gnu.org ([2001:4830:134:3::10]:38691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0S6Z-0006jR-Um
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1g0S6W-0008Vj-9M
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:56:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1g0S6R-0007p3-Ae
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 09:56:16 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8DDt9Ia062994
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 09:55:50 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mfpn0f0y5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 09:55:49 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Thu, 13 Sep 2018 09:55:44 -0400
References: <1536782900-17656-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1536782900-17656-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<15669236-8b87-4e6d-69be-ae2975aa7bb2@redhat.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Thu, 13 Sep 2018 09:55:35 -0400
MIME-Version: 1.0
In-Reply-To: <15669236-8b87-4e6d-69be-ae2975aa7bb2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <c33114ec-9033-5f77-0655-edd9879fd7aa@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 3/6] s390x/kvm:
 enable/disable AP instruction interpretation for guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, cohuck@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, fiuczy@linux.ibm.com, eskultet@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, jjherne@linux.vnet.ibm.com, mimu@linux.ibm.com, heiko.carstens@de.ibm.com, eric.auger@redhat.com, alex.williamson@redhat.com, bjsdjshi@linux.vnet.ibm.com, rth@twiddle.net, mjrosato@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, alifm@linux.vnet.ibm.com, qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, pbonzini@redhat.com

On 09/13/2018 01:28 AM, Thomas Huth wrote:
> On 2018-09-12 22:08, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> Let's use the KVM_SET_DEVICE_ATTR ioctl to enable or disable
>> hardware interpretation of AP instructions executed on the guest.
>> If the S390_FEAT_AP feature is installed, AP instructions will
>> be interpreted by default; otherwise, they will be intercepted.
>> This attribute setting may be overridden by a device. For example,
>> a device may want to provide AP instructions to the guest (i.e.,
>> S390_FEAT_AP turned on), but it may want to emulate them. In this
>> case, the AP instructions executed on the guest must be
>> intercepted; so when the device is realized, it must disable
>> interpretation.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   target/s390x/kvm.c |   16 ++++++++++++++++
>>   1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index c4bd84d..28a3900 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2297,6 +2297,19 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>>                  S390_FEAT_MAX);
>>   }
>>   
>> +static void kvm_s390_configure_apie(int interpret)
> In case you respin, maybe use "bool interpret" instead of "int interpret"?
>
>   Thomas

Will do

>
>> +{
>> +    uint64_t attr = KVM_S390_VM_CRYPTO_DISABLE_APIE;
>> +
>> +    if (interpret) {
>> +        attr = KVM_S390_VM_CRYPTO_ENABLE_APIE;
>> +    }
>> +
>> +    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
>> +            kvm_s390_set_attr(attr);
>> +    }
>> +}
>> +
>>   void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>>   {
>>       struct kvm_s390_vm_cpu_processor prop  = {
>> @@ -2346,6 +2359,9 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>>       if (test_bit(S390_FEAT_CMM, model->features)) {
>>           kvm_s390_enable_cmma();
>>       }
>> +
>> +    /* configure hardware interpretation of AP instructions */
>> +    kvm_s390_configure_apie(test_bit(S390_FEAT_AP, model->features));
>>   }
>>   
>>   void kvm_s390_restart_interrupt(S390CPU *cpu)
>>
