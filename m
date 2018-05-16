Received: from eggs.gnu.org ([2001:4830:134:3::10]:45477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fItsV-0005Wh-Fq
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fItsS-0003DS-3R
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47232
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fItsR-0003Cy-Tn
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4GAdYqP133912
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:41:46 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j0k07rbaq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 06:41:46 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Wed, 16 May 2018 04:41:45 -0600
References: <1525782303-16940-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1525782303-16940-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<b43bdfdb-4c00-646d-efbd-1f411350929e@linux.ibm.com>
	<5b4c089d-a586-c76b-e1d7-6c2f2183b69b@linux.vnet.ibm.com>
	<1442f59a-f422-c76e-f6dc-ea9d677d0202@linux.ibm.com>
	<7c2a81a7-2e01-7265-6071-8958901b38db@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 16 May 2018 06:41:35 -0400
MIME-Version: 1.0
In-Reply-To: <7c2a81a7-2e01-7265-6071-8958901b38db@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <980d7f87-8494-cf2c-5563-a901ed794bee@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 3/6] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, pmorel@linux.ibm.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net

On 05/16/2018 05:23 AM, David Hildenbrand wrote:
> On 16.05.2018 11:05, Pierre Morel wrote:
>> On 15/05/2018 17:03, Tony Krowiak wrote:
>>> On 05/15/2018 08:00 AM, Pierre Morel wrote:
>>>> On 08/05/2018 14:25, Tony Krowiak wrote:
>>>>> A new CPU model feature and two new CPU model facilities are
>>>>> introduced to support AP devices for a KVM guest.
>>>>>
>>>>> CPU model features:
>>>>>
>>>>> 1. The KVM_S390_VM_CPU_FEAT_AP CPU model feature indicates that
>>>>>      AP facilities are installed. This feature will be enabled by
>>>>>      the kernel only if the AP facilities are installed on the linux
>>>>>      host. This feature must be turned on from userspace to access
>>>>>      AP devices from the KVM guest. The QEMU command line to turn
>>>>>      this feature looks something like this:
>>>>>
>>>>>      qemu-system-s390x ... -cpu xxx,ap=on
>>>>>
>>>>>      This feature will be supported for zEC12 and newer CPU models.
>>>>>      The feature will not be supported for older models due to
>>>>>      testability issues.
>>>>>
>>>>> CPU model facilities:
>>>>>
>>>>> 1. The S390_FEAT_AP_QUERY_CONFIG_INFO feature indicates the AP Query
>>>>>      Configuration Information (QCI) facility is installed. This feature
>>>>>      will be enabled by the kernel only if the QCI is installed on
>>>>>      the host.
>>>>>
>>>>> 2. The S390_FEAT_AP_FACILITY_TEST feature indicates that the AP
>>>>>      Facility Test (APFT) facility is installed. This feature will
>>>>>      be enabled by the kernel only if the APFT facility is installed
>>>>>      on the host.
>>>>>
>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>>> ---
>>>>>    target/s390x/cpu_features.c     |    3 +++
>>>>>    target/s390x/cpu_features_def.h |    3 +++
>>>>>    target/s390x/cpu_models.c       |    2 ++
>>>>>    target/s390x/gen-features.c     |    3 +++
>>>>>    target/s390x/kvm.c              |    1 +
>>>>>    5 files changed, 12 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>>>>> index 3b9e274..f344323 100644
>>>>> --- a/target/s390x/cpu_features.c
>>>>> +++ b/target/s390x/cpu_features.c
>>>>> @@ -40,8 +40,10 @@ static const S390FeatDef s390_features[] = {
>>>>>        FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status
>>>>> facility"),
>>>>>        FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE
>>>>> facility"),
>>>>>        FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11,
>>>>> "Configuration-topology facility"),
>>>>> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query AP
>>>>> Configuration facility"),
>>>> Not a big deal, but why forget the I for "Information" in the long
>>>> description for APQCI
>>> I'll add 'Information'.
>>>
>>>> Also why not just "QCI" (I think it was already asked)
>>> It was a suggestion from Reinhard with which I agreed. We may know
>>> that QCI is an AP function,
>>> but most administrators will have no idea. Prepending the 'ap' informs
>>> that QCI is an
>>> AP function related to the CPU model feature for AP.
>> QCI is the official name and will be refered as this in the official
>> documentation (if it is).
>> Most admin will use libvirt anyway and the one which will try to use
>> qemu will look for
>> apqci in the official documentation and will not find it.
>> I do not think it is a good idea, but technically does not change anything.
>> Keep my RB even you stay by apqci or change for qci.
>>
> For the SIE features I decided to not name them sie_$feat
>
> So we have e.g. siif instead of sie_siif. I primarily did this to have
> shorter feature names and the rational was that the short version (siif)
> was sufficient to guess the full name and where it belongs to.
>
> e.g. siif == "Shared IPTE-interlock facility" (we sticked to the f in
> there, as siif was a commonly used term if I remember correctly). There
> is only one shared ipte-interlock facility.
>
> "qci" (or Query Configuration facility) does _not_ indicate to which
> part of the system this belongs. zPCI? sclp? ap?
>
> This should be "apqci" or "qapcf". Or "ap_qci". "qci", on its own is not
> sufficient in my opinion.

It is settled then ... I'll stick with apqci

>
