Received: from eggs.gnu.org ([209.51.188.92]:56075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH9sf-000410-KC
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH9r2-0002HR-IF
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:25:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH9r2-0002Gc-7n
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:25:40 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IGJBv1109209
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 12:25:37 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxstps83y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 12:25:37 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 17:25:34 +0100
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<20190418113110.160664-8-borntraeger@de.ibm.com>
	<2a98f8a0-15bc-aa3d-f4ad-71059d65dad8@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 18:25:30 +0200
MIME-Version: 1.0
In-Reply-To: <2a98f8a0-15bc-aa3d-f4ad-71059d65dad8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d38a2297-2ef0-47a8-6145-ec9ca13ac853@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] s390x/cpumodel: deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>



On 18.04.19 17:36, David Hildenbrand wrote:
> On 18.04.19 13:31, Christian Borntraeger wrote:
>> add the deflate conversion facility.
> 
> Nit:
> 
> "s390x/cpumodel: add Deflate-conversion facility"
> 
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/cpu_features.c     |  9 +++++++++
>>  target/s390x/cpu_features.h     |  1 +
>>  target/s390x/cpu_features_def.h |  7 +++++++
>>  target/s390x/gen-features.c     | 12 ++++++++++++
>>  target/s390x/kvm.c              |  6 ++++++
>>  5 files changed, 35 insertions(+)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index e0a4769c19..5f37e655fe 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -110,6 +110,7 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("cmmnt", S390_FEAT_TYPE_STFL, 147, "CMM: ESSA-enhancement (no translate) facility"),
>>      FEAT_INIT("vxeh2", S390_FEAT_TYPE_STFL, 148, "Vector Enhancements facility 2"),
>>      FEAT_INIT("esort-base", S390_FEAT_TYPE_STFL, 150, "Enhanced-sort facility (excluding subfunctions)"),
>> +    FEAT_INIT("deflate-base", S390_FEAT_TYPE_STFL, 151, "Deflate-conversion facility (excluding subfunctions)"),
>>      FEAT_INIT("vxbeh", S390_FEAT_TYPE_STFL, 152, "Vector BCD enhancements facility 1"),
>>      FEAT_INIT("msa9-base", S390_FEAT_TYPE_STFL, 155, "Message-security-assist-extension-9 facility (excluding subfunctions)"),
>>      FEAT_INIT("etoken", S390_FEAT_TYPE_STFL, 156, "Etoken facility"),
>> @@ -347,6 +348,11 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("sortl-32", S390_FEAT_TYPE_SORTL, 130, "SORTL 32 input lists"),
>>      FEAT_INIT("sortl-128", S390_FEAT_TYPE_SORTL, 132, "SORTL 128 input lists"),
>>      FEAT_INIT("sortl-f0", S390_FEAT_TYPE_SORTL, 192, "SORTL format 0 parameter-block"),
>> +
>> +    FEAT_INIT("dfltcc-gdht", S390_FEAT_TYPE_DFLTCC, 1, "DFLTCC GDHT"),
>> +    FEAT_INIT("dfltcc-cmpr", S390_FEAT_TYPE_DFLTCC, 2, "DFLTCC CMPR"),
>> +    FEAT_INIT("dfltcc-xpnd", S390_FEAT_TYPE_DFLTCC, 4, "DFLTCC XPND"),
>> +    FEAT_INIT("dfltcc-f0", S390_FEAT_TYPE_DFLTCC, 192, "DFLTCC format 0 parameter-block"),
>>  };
> 
> Just wonder, "format 0 parameter-block" is actually a feature right,
> like "format 0 can be used". Can we hide format-0, IOW could that be
> like "query" and always supported? (especially due to backwards
> compatibility)

It hopefully will be there forever but since the CSSKE thing I would not
bet on that. So I see your point but making this explicit seems a bit
safer.
