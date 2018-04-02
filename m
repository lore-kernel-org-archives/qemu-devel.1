Received: from eggs.gnu.org ([2001:4830:134:3::10]:46116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f31rf-0006Go-6B
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 11:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f31rc-00029E-Rd
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 11:59:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <prvs=063091f310=akrowiak@linux.vnet.ibm.com>)
	id 1f31rc-00025v-Lk
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 11:59:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w32Fsk04115824
	for <qemu-devel@nongnu.org>; Mon, 2 Apr 2018 11:59:17 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h3ne9pb2s-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 11:59:17 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Mon, 2 Apr 2018 11:59:16 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Mon, 2 Apr 2018 11:59:10 -0400
MIME-Version: 1.0
In-Reply-To: <4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <6388f801-9a13-7c5e-686a-0bd2ed20b5a0@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 03/26/2018 04:32 AM, David Hildenbrand wrote:
> On 16.03.2018 00:24, Tony Krowiak wrote:
>> If the CPU model indicates that AP facility is installed on
>> the guest (i.e., -cpu xxxx,ap=on), then the expectation is that
>> the AP bus running in the guest will initialize; however, if the
>> AP instructions are not being interpreted by the firmware, then
>> they will be intercepted and routed back to QEMU for handling.
>> If a handler is not defined to process the intercepted instruciton,
>> then an operation exception will be injected into the
>> guest, in which case the AP bus will not initialize.
>>
>> There are two situations where AP instructions will not be
>> interpreted:
>>
>> 1. The guest is not configured with a vfio-ap device (i.e.,
>>     -device vfio-ap,sysfsdev=$path-to-mdev). The realize function for
>>     the vfio-ap device enables interpretive execution of AP
>>     instructions.
>>
>> 2. The guest is a second level guest but the first level guest has
>>     not enabled interpretive execution.
>>
>> This patch introduces AP instruction handlers to ensure the AP bus
>> module initializes on the guest when the AP facility is installed
>> on the guest but AP instructions are not being interpreted. The logic
>> incorporated is:
>>
>> * If the CPU model indicates AP instructions are
>>    installed
>>
>>    * Set the status response code for the instruction to indicate that
>>      the APQN contained in the instruction is not valid. This is
>>      a valid response because there will be no devices configured for
>>      the guest in any of the above scenarios.
>>
>> * Else return an error from the handler. This will result in an
>>    operation being injected into the guest and the AP bus will not
> s/operation/operation exception/
thanks
>
>>    initialize on the guest. That is commensurate with how things work
>>    today.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   hw/vfio/ap.c                 |   45 ++++++++++++++++++++++++++++++++++++++++++
>>   include/hw/s390x/ap-device.h |    6 +++++
>>   target/s390x/kvm.c           |   14 +++++++++++++
>>   3 files changed, 65 insertions(+), 0 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index b397bb1..88e744d 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -148,6 +148,51 @@ static void vfio_ap_unrealize(DeviceState *dev, Error **errp)
>>       kvm_s390_set_interpret_ap(0);
>>   }
>>   
> I think you are missing cpu_synchronize_state(CPU(cpu)) in all of these
> functions.
I see you negated this in your next response.
>
>> +int ap_device_handle_nqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env = &cpu->env;
>> +
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] = 0x10000;
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +int ap_device_handle_dqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env = &cpu->env;
>> +
>> +    if (s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] = 0x10000;
>> +
>> +        return 0;
>> +    }
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>> +int ap_device_handle_pqap(S390CPU *cpu)
>> +{
>> +    CPUS390XState *env = &cpu->env;
>> +    int fc = 4 & (env->regs[0] >> 24);
>> +
>> +    /*
>> +     * The Query Configuration Information (QCI) function (fc == 4) does not
>> +     * set a response code in reg 1, so check for that along with the
>> +     * AP feature.
>> +     */
>> +    if ((fc != 4) && s390_has_feat(S390_FEAT_AP)) {
>> +        env->regs[1] = 0x10000;
>> +
>> +        return 0;
>> +    }
> This would imply an operation exception in case fc==4, which sounds very
> wrong.
Take a look at my response to Pierre for an answer to this one.
>
> Hard to review without access to documentation. (hard to understand why
> such stuff is to be kept confidential for decades)
You'll have to talk to the powers that be at IBM about that one :)
>
>> +
>> +    return -EOPNOTSUPP;
>> +}
>> +
>>   static Property vfio_ap_properties[] = {
>>       DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
>>       DEFINE_PROP_END_OF_LIST(),
>> diff --git a/include/hw/s390x/ap-device.h b/include/hw/s390x/ap-device.h
>> index 693df90..d45ae38 100644
>> --- a/include/hw/s390x/ap-device.h
>> +++ b/include/hw/s390x/ap-device.h
>> @@ -11,6 +11,8 @@
>>   #ifndef HW_S390X_AP_DEVICE_H
>>   #define HW_S390X_AP_DEVICE_H
>>   
>
