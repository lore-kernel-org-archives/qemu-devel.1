Received: from eggs.gnu.org ([2001:4830:134:3::10]:34986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHIQ-0000xu-TT
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAHIN-0000IW-1g
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:52:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48768
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fAHIM-0000IE-RV
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:52:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MFmZRF078553
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:52:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk1xqrs0-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:52:53 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 22 Apr 2018 11:52:53 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
	<28f80970-6cd3-d28d-df3a-2f80b5252f00@redhat.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 11:52:45 -0400
MIME-Version: 1.0
In-Reply-To: <28f80970-6cd3-d28d-df3a-2f80b5252f00@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <4b888e9c-8ef0-fc17-a7c1-2eb949ee3260@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 04/18/2018 07:03 AM, David Hildenbrand wrote:
> On 18.04.2018 12:55, Halil Pasic wrote:
>>
>> On 04/15/2018 09:07 PM, Tony Krowiak wrote:
>>> A new CPU model feature and two new CPU model facilities are
>>> introduced to support AP devices for a KVM guest.
>> [..]
>>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>>> index 3b9e274..5ee3a2d 100644
>>> --- a/target/s390x/cpu_features.c
>>> +++ b/target/s390x/cpu_features.c
>>> @@ -40,8 +40,10 @@ static const S390FeatDef s390_features[] = {
>>>        FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status facility"),
>>>        FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE facility"),
>>>        FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, "Configuration-topology facility"),
>>> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query AP Configuration facility"),
>> Why did you change this form qci to apqci. Too may people found the
>> qci good?
> If the facility is called "Query AP Configuration facility" it should be
> qapc
>
> Where does the term "qci" come from ?

It comes from the name of the function Query AP Configuration 
Information which
is identified by the initials QCI.

>
>>>        FEAT_INIT("ipter", S390_FEAT_TYPE_STFL, 13, "IPTE-range facility"),
>>>        FEAT_INIT("nonqks", S390_FEAT_TYPE_STFL, 14, "Nonquiescing key-setting facility"),
>>> +    FEAT_INIT("apft", S390_FEAT_TYPE_STFL, 15, "Adjunct Processor Facilities Test facility"),
>>>        FEAT_INIT("etf2", S390_FEAT_TYPE_STFL, 16, "Extended-translation facility 2"),
>>>        FEAT_INIT("msa-base", S390_FEAT_TYPE_STFL, 17, "Message-security-assist facility (excluding subfunctions)"),
>>>        FEAT_INIT("ldisp", S390_FEAT_TYPE_STFL, 18, "Long-displacement facility"),
>>> @@ -129,6 +131,7 @@ static const S390FeatDef s390_features[] = {
>>>
>>>        FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
>>>        FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility"),
>>> +    FEAT_INIT_MISC("ap", "AP facilities installed"),
>> Why plural ('facilities')? Would not s/facilities/instructions be more end-user
>> friendly?
>>
>> Regards,
>> Halil
>>
>
