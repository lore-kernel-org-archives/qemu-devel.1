Received: from eggs.gnu.org ([209.51.188.92]:54190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJysh-0002Au-BH
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJysc-00046a-Kg
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:19:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35030
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJysc-00043v-Bz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 07:18:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3QBBQKM065515
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:18:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s4013bbq1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 07:18:56 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 26 Apr 2019 12:18:54 +0100
References: <20190426111003.21246-1-borntraeger@de.ibm.com>
	<20190426111003.21246-10-borntraeger@de.ibm.com>
	<c07b4807-787b-3420-1cae-fb29f56dd9b4@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 26 Apr 2019 13:18:49 +0200
MIME-Version: 1.0
In-Reply-To: <c07b4807-787b-3420-1cae-fb29f56dd9b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <41f2c4a5-7f40-3155-ba8c-e92d0c80b53e@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 09/10] s390x/cpumodel: disable csske and
 bpb from gen15 cpu models onwards
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



On 26.04.19 13:18, David Hildenbrand wrote:
> On 26.04.19 13:10, Christian Borntraeger wrote:
>> These facilities are deprecated and no longer needed.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  target/s390x/gen-features.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 6260f56dc1..c346b76bdf 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -13,6 +13,7 @@
>>  
>>  #include <inttypes.h>
>>  #include <stdio.h>
>> +#include <string.h>
>>  #include "cpu_features_def.h"
>>  
>>  #define ARRAY_SIZE(array) (sizeof(array) / sizeof(array[0]))
>> @@ -833,6 +834,11 @@ static void set_bits(uint64_t list[], BitSpec bits)
>>      }
>>  }
>>  
>> +static inline void clear_bit(uint64_t list[], unsigned long nr)
>> +{
>> +    list[nr / 64] &= ~(1ULL << (nr % 64));
>> +}
>> +
>>  static void print_feature_defs(void)
>>  {
>>      uint64_t base_feat[S390_FEAT_MAX / 64 + 1] = {};
>> @@ -843,6 +849,12 @@ static void print_feature_defs(void)
>>      printf("\n/* CPU model feature list data */\n");
>>  
>>      for (i = 0; i < ARRAY_SIZE(CpuFeatDef); i++) {
>> +        /* With gen15 CSSKE and BPB are deprecated */
>> +        if (strcmp(CpuFeatDef[i].name, "S390_FEAT_LIST_GEN15_GA1") == 0) {
>> +            clear_bit(base_feat, S390_FEAT_CONDITIONAL_SSKE);
>> +            clear_bit(default_feat, S390_FEAT_CONDITIONAL_SSKE);
>> +            clear_bit(default_feat, S390_FEAT_BPB);
>> +        }
>>          set_bits(base_feat, CpuFeatDef[i].base_bits);
>>          /* add the base to the default features */
>>          set_bits(default_feat, CpuFeatDef[i].base_bits);
>>
> 
> Can you squash that into the previous patch, so it doesn't look like the
> case model is suddenly changed?

can do. I wanted it to be separate for better review.
