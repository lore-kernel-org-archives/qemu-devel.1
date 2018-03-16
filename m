Received: from eggs.gnu.org ([2001:4830:134:3::10]:33279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewqHA-0002lC-QK
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewqH5-000262-RH
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:24:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44796
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ewqH5-00024w-Ln
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:24:03 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GEO1ED122081
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:24:03 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grdxm54ud-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 10:24:02 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 08:24:00 -0600
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<79a17caf-9583-cf0d-1061-08ace784c257@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 10:23:51 -0400
MIME-Version: 1.0
In-Reply-To: <79a17caf-9583-cf0d-1061-08ace784c257@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <def03dc5-1684-c278-7bb8-144fdf747ac7@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/7] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 03/16/2018 05:36 AM, Pierre Morel wrote:
> On 16/03/2018 00:24, Tony Krowiak wrote:
>> A new CPU model feature and two new CPU model facilities are
>> introduced to support AP devices for a KVM guest.
>>
>> CPU model features:
>>
>> 1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
>>     AP facilities are installed. This feature will be enabled by
>>     the kernel only if the AP facilities are installed on the linux
>>     host. This feature must be turned on from userspace to access
>>     AP devices from the KVM guest. The QEMU command line to turn
>>     this feature looks something like this:
>>
>>     qemu-system-s390x ... -cpu xxx,ap=on
>>
>> CPU model facilities:
>>
>> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
>>     Configuration Information (QCI) facility is installed. This feature
>>     will be enabled by the kernel only if the QCI is installed on
>>     the host.
>>
>> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
>>     Facility Test (APFT) facility is installed. This feature will
>>     be enabled by the kernel only if the APFT facility is installed
>>     on the host.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   target/s390x/cpu_features.c     |    3 +++
>>   target/s390x/cpu_features_def.h |    3 +++
>>   target/s390x/cpu_models.c       |    2 ++
>>   target/s390x/gen-features.c     |    3 +++
>>   target/s390x/kvm.c              |    1 +
>>   5 files changed, 12 insertions(+), 0 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index a5619f2..1abe987 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -36,8 +36,10 @@ static const S390FeatDef s390_features[] = {
>>       FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status 
>> facility"),
>>       FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE 
>> facility"),
>>       FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, 
>> "Configuration-topology facility"),
>> +    FEAT_INIT("qci", S390_FEAT_TYPE_STFL, 12, "Query AP 
>> Configuration facility"),
>>       FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range 
>> facility"),
>>       FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing 
>> key-setting facility"),
>> +    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor 
>> Facilities Test facility"),
>>       FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, 
>> "Extended-translation facility 2"),
>>       FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, 
>> "Message-security-assist facility (excluding subfunctions)"),
>>       FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement 
>> facility"),
>> @@ -125,6 +127,7 @@ static const S390FeatDef s390_features[] = {
>>
>>       FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement 
>> facility 2"),
>>       FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, 
>> "Collaborative-memory-management facility"),
>> +    FEAT_INIT("ap", S390_FEAT_TYPE_MISC, 0, "AP facilities installed"),
>
> AFAIK you should use  FEAT_INIT_MISC to initialize misc features now.
> May be rebase on last qemu ?
Yes, I noticed too late that Connie mentioned that in the last round, it 
will be
in the next series.
>
>
>>
>>       FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and 
>> load (32 bit in general registers)"),
>>       FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and 
>> load (64 bit in parameter list)"),
>> diff --git a/target/s390x/cpu_features_def.h 
>> b/target/s390x/cpu_features_def.h
>> index 7c5915c..8998b65 100644
>> --- a/target/s390x/cpu_features_def.h
>> +++ b/target/s390x/cpu_features_def.h
>> @@ -27,8 +27,10 @@ typedef enum {
>>       S390_FEAT_SENSE_RUNNING_STATUS,
>>       S390_FEAT_CONDITIONAL_SSKE,
>>       S390_FEAT_CONFIGURATION_TOPOLOGY,
>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>>       S390_FEAT_IPTE_RANGE,
>>       S390_FEAT_NONQ_KEY_SETTING,
>> +    S390_FEAT_AP_FACILITIES_TEST,
>>       S390_FEAT_EXTENDED_TRANSLATION_2,
>>       S390_FEAT_MSA,
>>       S390_FEAT_LONG_DISPLACEMENT,
>> @@ -118,6 +120,7 @@ typedef enum {
>>       /* Misc */
>>       S390_FEAT_DAT_ENH_2,
>>       S390_FEAT_CMM,
>> +    S390_FEAT_AP,
>>
>>       /* PLO */
>>       S390_FEAT_PLO_CL,
>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>> index cf82589..7e2af09 100644
>> --- a/target/s390x/cpu_models.c
>> +++ b/target/s390x/cpu_models.c
>> @@ -769,6 +769,8 @@ static void check_consistency(const S390CPUModel 
>> *model)
>>           { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
>>           { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
>>           { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
>> +        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
>> +        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
>>       };
>>       int i;
>>
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 0cdbc15..0d5b0f7 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -447,6 +447,9 @@ static uint16_t full_GEN12_GA1[] = {
>>       S390_FEAT_ADAPTER_INT_SUPPRESSION,
>>       S390_FEAT_EDAT_2,
>>       S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2,
>> +    S390_FEAT_AP_QUERY_CONFIG_INFO,
>> +    S390_FEAT_AP_FACILITIES_TEST,
>> +    S390_FEAT_AP,
>>   };
>>
>>   static uint16_t full_GEN12_GA2[] = {
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index fbc887e..33e5ec3 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2178,6 +2178,7 @@ static int kvm_to_feat[][2] = {
>>       { KVM_S390_VM_CPU_FEAT_PFMFI, S390_FEAT_SIE_PFMFI},
>>       { KVM_S390_VM_CPU_FEAT_SIGPIF, S390_FEAT_SIE_SIGPIF},
>>       { KVM_S390_VM_CPU_FEAT_KSS, S390_FEAT_SIE_KSS},
>> +    { KVM_S390_VM_CPU_FEAT_AP, S390_FEAT_AP},
>>   };
>>
>>   static int query_cpu_feat(S390FeatBitmap features)
>
>
