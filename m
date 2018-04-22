Received: from eggs.gnu.org ([2001:4830:134:3::10]:58607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAH9e-0005kK-RZ
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:43:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1fAH9a-0002iR-VW
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:43:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1fAH9a-0002i7-NV
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 11:43:50 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MFfR63090387
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:43:49 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk2nynwc-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 11:43:49 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 22 Apr 2018 11:43:48 -0400
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 22 Apr 2018 11:43:40 -0400
MIME-Version: 1.0
In-Reply-To: <819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bf3ac9e4-1f53-0372-450d-1a84f780d25e@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 04/18/2018 06:55 AM, Halil Pasic wrote:
>
>
> On 04/15/2018 09:07 PM, Tony Krowiak wrote:
>> A new CPU model feature and two new CPU model facilities are
>> introduced to support AP devices for a KVM guest.
> [..]
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index 3b9e274..5ee3a2d 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -40,8 +40,10 @@ static const S390FeatDef s390_features[] = {
>>       FEAT_INIT("srs", S390_FEAT_TYPE_STFL, 9, "Sense-running-status 
>> facility"),
>>       FEAT_INIT("csske", S390_FEAT_TYPE_STFL, 10, "Conditional-SSKE 
>> facility"),
>>       FEAT_INIT("ctop", S390_FEAT_TYPE_STFL, 11, 
>> "Configuration-topology facility"),
>> +    FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Query AP 
>> Configuration facility"),
>
> Why did you change this form qci to apqci. Too may people found the
> qci good?
>
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
>> @@ -129,6 +131,7 @@ static const S390FeatDef s390_features[] = {
>>
>>       FEAT_INIT_MISC("dateh2", "DAT-enhancement facility 2"),
>>       FEAT_INIT_MISC("cmm", "Collaborative-memory-management facility"),
>> +    FEAT_INIT_MISC("ap", "AP facilities installed"),
>
> Why plural ('facilities')? Would not s/facilities/instructions be more 
> end-user
> friendly?

It's a matter of opinion. I prefer facilities because AP is comprised of 
not only
instructions, but also AP processors.

>
>
> Regards,
> Halil
