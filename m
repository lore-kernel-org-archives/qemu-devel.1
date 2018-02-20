Received: from eggs.gnu.org ([2001:4830:134:3::10]:52290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoAdT-0003aI-Hl
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:19:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eoAdQ-0007UL-8V
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:19:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eoAdP-0007Tn-Ve
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 11:19:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1KGH7GD062531
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:19:14 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g8n5fdyv4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 20 Feb 2018 11:19:13 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 20 Feb 2018 16:19:11 -0000
References: <20180220150713.6056-1-pasic@linux.vnet.ibm.com>
	<20180220165323.02898d8a.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 20 Feb 2018 17:19:07 +0100
MIME-Version: 1.0
In-Reply-To: <20180220165323.02898d8a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <1ece5b3f-6cc9-66f7-aae3-b0907ebdb91d@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 1/1] 390x/cpumodel: document
 S390FeatDef.bit not applicable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 02/20/2018 04:53 PM, Cornelia Huck wrote:
> On Tue, 20 Feb 2018 16:07:13 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> The 'bit' field of the 'S390FeatDef' structure is not applicable to all
>> it's instances. Currently a this field is not applicable, and remains
> 
> s/it's/its/
> 
> s/a this/this/

Will do.

> 
>> unused, iff the feature is of type S390_FEAT_TYPE_MISC. Having the value 0
>> specified for multiple such feature definition  was a little confusing,
>> as it's a perfectly legit bit value, and as usually the value of the bit
>> field is ought to be unique for each feature.
>>
>> Let's document this, and hopefully reduce the potential for confusion.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>
>> Hi!
>>
>> This may be an overkill. A comment where the misc features
>> are defined would do to, but I think this is nicer. So
>> I decided to try it with this approach first.
> 
> Is there likely to be anything else than FEAT_MISC _not_ using .bit? If
> not, would it be better to at a comment to the FEAT_MISC definition?
> 

I think, that anything not using .bit is likely to get modeled as
FEAT_MISC that is why I think a comment to where the FEAT_MISC features
are defined is an option. I don't think commenting the definition
of S390_FEAT_TYPE_MISC (that is the definition of enum S390FeatType) would help,
as what looks weird is the definition of the features (that
currently have all the .bit value 0, but that does not matter).

The point is we need to supply 'bit' to  FEAT_INIT() because of
formal reasons, even if it makes no sense to specify 'bit' for the
given feature.

I've done what I've done because it seemed the most idiomatic solution
(we used to call such 'special values' extremal elements in school).
But I'm fine with commenting the definitions (look for [HERE] below).

>>
>> ---
>>  target/s390x/cpu_features.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
>> index a5619f2893..34fddfe78b 100644
>> --- a/target/s390x/cpu_features.c
>> +++ b/target/s390x/cpu_features.c
>> @@ -23,6 +23,13 @@
>>          .desc = _desc,                               \
>>      }
>>  
>> +/*
>> + * For some feature types (e.g. S390_FEAT_TYPE_MISC) S390FeatDef.bit
>> + * is not applicable, as there is no corresponding feature block. See
>> + * s390_fill_feat_block() and it's usages.
>> + */
>> +#define FEAT_BIT_NA -1
>> +
>>  /* indexed by feature number for easy lookup */
>>  static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("esan3", S390_FEAT_TYPE_STFL, 0, "Instructions marked as n3"),
>> @@ -123,8 +130,8 @@ static const S390FeatDef s390_features[] = {
>>      FEAT_INIT("ib", S390_FEAT_TYPE_SCLP_CPU, 42, "SIE: Intervention bypass facility"),
>>      FEAT_INIT("cei", S390_FEAT_TYPE_SCLP_CPU, 43, "SIE: Conditional-external-interception facility"),
>>  
[HERE]
>> -    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, 0, "DAT-enhancement facility 2"),
>> -    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, 0, "Collaborative-memory-management facility"),
>> +    FEAT_INIT("dateh2", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "DAT-enhancement facility 2"),
>> +    FEAT_INIT("cmm", S390_FEAT_TYPE_MISC, FEAT_BIT_NA, "Collaborative-memory-management facility"),
>>  
>>      FEAT_INIT("plo-cl", S390_FEAT_TYPE_PLO, 0, "PLO Compare and load (32 bit in general registers)"),
>>      FEAT_INIT("plo-clg", S390_FEAT_TYPE_PLO, 1, "PLO Compare and load (64 bit in parameter list)"),
> 
