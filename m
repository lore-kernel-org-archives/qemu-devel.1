Received: from eggs.gnu.org ([2001:4830:134:3::10]:39130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffi4m-0004EM-7k
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ffi4j-0003Mt-5Y
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58670
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ffi4i-0003L5-T3
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 04:44:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w6I8d52B142866
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 04:44:44 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ka0h04dpe-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 04:44:43 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 18 Jul 2018 09:44:42 +0100
References: <20180718082425.14834-1-david@redhat.com>
	<148539ec-691f-5822-509f-d11dbfa3f88b@de.ibm.com>
	<873c35d4-5a5f-d095-9485-4fb7ec8b746f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 18 Jul 2018 10:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <873c35d4-5a5f-d095-9485-4fb7ec8b746f@redhat.com>
Content-Language: en-US
Message-Id: <46dcb3bc-4f7f-74cb-2351-7ad2f95ea461@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/cpumodel: fix
 segmentation fault when baselining models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Chris Venteicher <cventeic@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>



On 07/18/2018 10:40 AM, David Hildenbrand wrote:
> On 18.07.2018 10:39, Christian Borntraeger wrote:
>>
>>
>> On 07/18/2018 10:24 AM, David Hildenbrand wrote:
>>> Usually, when baselining two CPU models, whereby one of them has base
>>> CPU features disabled (e.g. z14-base,msa=off), we fallback to an older
>>> model that did not have these features in the base model. We always try to
>>> create a "sane" CPU model (as far as possible), and one part of it is that
>>> removing base features is no good and to be avoided.
>>>
>>> Now, if we disable base features that were part of a z900, we're out of
>>> luck. We won't find a CPU model and QEMU will segfault. This is a
>>> scenario that should never happen in real life, but it can be used to
>>> crash QEMU.
>>>
>>> So let's make something like this:
>>>
>>> { "execute": "query-cpu-model-baseline",
>>>   "arguments" : { "modela": { "name": "z14-base", "props": {"esan3" : false}},
>>>                   "modelb": { "name": "z14"}} }
>>>
>>> Produce:
>>>
>>> {"return": {"model": {"name": "z900-base", "props": {"esan3": false}}}}
>>>
>>> Instead of segfaulting.
>>>
>>> This could of course be improved (e.g. to z14-base,esan3=false), however
>>> as this ususally won't happen, let's just avoid crashes.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>  target/s390x/cpu_models.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
>>> index cfdbccf46d..13a5d4f095 100644
>>> --- a/target/s390x/cpu_models.c
>>> +++ b/target/s390x/cpu_models.c
>>> @@ -716,6 +716,12 @@ CpuModelBaselineInfo *arch_query_cpu_model_baseline(CpuModelInfo *infoa,
>>>  
>>>      model.def = s390_find_cpu_def(cpu_type, max_gen, max_gen_ga,
>>>                                    model.features);
>>> +
>>> +    /* models without early base features (esan3) are bad - fallback to z900 */
>>> +    if (!model.def) {
>>> +        model.def = s390_find_cpu_def(0x2064, 7, 1, NULL);
>>> +    }
>>> +
>>
>> Is there a way to not even return z900 but retuning an empty model (e.g. no model that 
>> matches) ?
> 
> An error would be an alternative.

As N3 means new in zarch (and backported to ESA390 mode), there is no machine without N3.
So I would prefer an error.
