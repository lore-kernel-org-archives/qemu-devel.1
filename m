Received: from eggs.gnu.org ([209.51.188.92]:36553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJDSc-000620-IG
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:41:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJDSa-0004X8-SH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:40:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33142
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJDSa-0004U3-Kd
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 04:40:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O8dsjj076823
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:40:54 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s2gpjtp24-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:40:53 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 24 Apr 2019 09:40:52 +0100
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 24 Apr 2019 10:40:46 +0200
MIME-Version: 1.0
In-Reply-To: <d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
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



On 23.04.19 14:11, David Hildenbrand wrote:
> On 18.04.19 13:31, Christian Borntraeger wrote:
>> Adding generation 15.
>>
>> Some interesting aspects:
>> - conditional SSKE and bpb are deprecated. This patch set addresses that
>>   for csske.
>> - no name yet for gen15, I suggest to use the assigned numbers and
>>   provide an alias later on. (I have split out this into a separate
>>   patch)
>>
>> Christian Borntraeger (10):
>>   linux header sync
>>   s390x/cpumodel: remove CSSKE from base model
>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility 3
>>   s390x/cpumodel: msa9 facility
>>   s390x/cpumodel: vector enhancements
>>   s390x/cpumodel: enhanced sort facility
>>   s390x/cpumodel: deflate
>>   s390x/cpumodel: add gen15 defintions
>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>>   s390x/cpumodel: do not claim csske for expanded models in qmp
>>
>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>>  linux-headers/asm-s390/kvm.h    |  5 +-
>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>>  target/s390x/cpu_features.h     |  3 ++
>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>>  target/s390x/cpu_models.c       | 35 ++++++++++++
>>  target/s390x/cpu_models.h       |  1 +
>>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++++++++-
>>  target/s390x/kvm.c              | 18 +++++++
>>  9 files changed, 263 insertions(+), 2 deletions(-)
>>
> 
> I guess to handle deprecation of CSSKE:
> 
> 1. Remove it from the base + default model of the gen15, keep it in the
> max model. This is completely done in target/s390x/gen-features.c.
> Existing base models are not modified.
> 
> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g. z14
> will work. We can backport this to distros/stable.

Yes, I have already implemented that, still doing some testing and polishinh.
> 
> 
> CPU model expansion:
> 
> cpu_info_from_model() should already properly be based on the base
> features. "gen15" vs. "gen15,csske=on" should be automatically generated
> when expanding.
> 
> CPU model baseline:
> 
> s390_find_cpu_def() should make sure that CSSKE is basically ignored
> when determining maximum model, however it will properly be indicated if
> both models had the feature.
> 
> CPU model comparison:
> 
> Should work as expected. Availability of CSSKE will be considered when
> calculating the result.
> 
> gen14,csske=on and gen15,csske=off will result in
> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
> 
> gen14,csske=off and gen15,csske=off should result in
> CPU_MODEL_COMPARE_RESULT_SUBSET
> 
> gen14,csske=on and gen15,csske=on should result in
> CPU_MODEL_COMPARE_RESULT_SUBSET
> 
> Forward migration:
> 
> Now, the only issue is when csske is actually turned of in future
> machines. We would e.g. have
> 
> gen15,csske=on and gen16,csske=off
> 
> While baselining will work correctly (gen15,csske=off), forward
> migration is broken (comparison will properly indicate
> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ripping
> out features. Same applies to BPB.
> 
> 
> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
> expanded models in qmp" tried to address this, however I am not really
> happy with this approach. We should not play such tricks when expanding
> the host model. "-cpu host" and "-cpu $expanded_host" would be
> different,

We discussed this some time ago and I think we agreed that for host passthrough
it is ok to be different that host-model (e.g. passing through the cpuid, passing
through all non-hypervisor managed features etc).


> that is really confusing, especially think about baselining
> or comparing against "host", where your patch does not apply..
> 
> 
> Whenever users would specify "-cpu gen15", everything would be fine in
> regards to forward migration. Maybe clients really have to be taught
> about upcoming forward migration issues. "Don't use the host model, make
> sure bpa and csske are disabled".


the thing is, I think the host-model is actually the preferred setting so I
would like to have this forward-migrateable as well. I will focus on patches
1-9 first and lets have a side discussion on patch 10.
