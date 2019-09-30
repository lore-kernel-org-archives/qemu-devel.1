Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F163BC4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61E32086A
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 07:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C61E32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEpq5-0005d5-2r
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 03:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41221)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEpoz-0004vM-8A
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEpox-0008On-SM
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:10:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iEpox-0008NT-LD
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 03:10:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8U78txP139716
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:10:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vb9uypjk6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 03:10:06 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 30 Sep 2019 08:10:04 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 30 Sep 2019 08:10:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8U79VKV23396832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2019 07:09:31 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1191B11C05C;
 Mon, 30 Sep 2019 07:10:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC91711C04A;
 Mon, 30 Sep 2019 07:09:59 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.146])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 30 Sep 2019 07:09:59 +0000 (GMT)
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
To: Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com> <20190925032700.GI28074@xz-x1>
 <20190925135105.6e5f249a@redhat.com> <20190925235235.GV28074@xz-x1>
 <20190927153320.2edc683c@redhat.com> <20190928012808.GA31218@xz-x1>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date: Mon, 30 Sep 2019 09:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190928012808.GA31218@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19093007-0016-0000-0000-000002B1F59E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093007-0017-0000-0000-00003312CED8
Message-Id: <63e706b4-4a6a-3be5-6bb7-9c744d269d98@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28.09.19 03:28, Peter Xu wrote:
> On Fri, Sep 27, 2019 at 03:33:20PM +0200, Igor Mammedov wrote:
>> On Thu, 26 Sep 2019 07:52:35 +0800
>> Peter Xu <peterx@redhat.com> wrote:
>>
>>> On Wed, Sep 25, 2019 at 01:51:05PM +0200, Igor Mammedov wrote:
>>>> On Wed, 25 Sep 2019 11:27:00 +0800
>>>> Peter Xu <peterx@redhat.com> wrote:
>>>>   
>>>>> On Tue, Sep 24, 2019 at 10:47:51AM -0400, Igor Mammedov wrote:  
>>>>>> s390 was trying to solve limited KVM memslot size issue by abusing
>>>>>> memory_region_allocate_system_memory(), which breaks API contract
>>>>>> where the function might be called only once.
>>>>>>
>>>>>> Beside an invalid use of API, the approach also introduced migration
>>>>>> issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
>>>>>> migration stream as separate RAMBlocks.
>>>>>>
>>>>>> After discussion [1], it was agreed to break migration from older
>>>>>> QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
>>>>>> and considered to be not actually used downstream).
>>>>>> Migration should keep working for guests with less than 8TB and for
>>>>>> more than 8TB with QEMU 4.2 and newer binary.
>>>>>> In case user tries to migrate more than 8TB guest, between incompatible
>>>>>> QEMU versions, migration should fail gracefully due to non-exiting
>>>>>> RAMBlock ID or RAMBlock size mismatch.
>>>>>>
>>>>>> Taking in account above and that now KVM code is able to split too
>>>>>> big MemorySection into several memslots, partially revert commit
>>>>>>  (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
>>>>>> and use kvm_set_max_memslot_size() to set KVMSlot size to
>>>>>> KVM_SLOT_MAX_BYTES.
>>>>>>
>>>>>> 1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times
>>>>>>
>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
>>>>>
>>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>>>
>>>>> IMHO it would be good to at least mention bb223055b9 in the commit
>>>>> message even if not with a "Fixed:" tag.  May be amended during commit
>>>>> if anyone prefers.  
>>>>
>>>> /me confused, bb223055b9 is mentioned in commit message  
>>>
>>> I'm sorry, I overlooked that.
>>>
>>>>    
>>>>> Also, this only applies the split limitation to s390.  Would that be a
>>>>> good thing to some other archs as well?  
>>>>
>>>> Don't we have the similar bitmap size issue in KVM for other archs?  
>>>
>>> Yes I thought we had.  So I feel like it would be good to also allow
>>> other archs to support >8TB mem as well.  Thanks,
>> Another question, Is there another archs with that much RAM that are
>> available/used in real life (if not I'd wait for demand to arise first)?
> 
> I don't know, so it was a pure question besides the series.  Sorry if
> that holds your series somehow, it was not my intention.
> 
>>
>> If we are to generalize it to other targets, then instead of using
>> arbitrary memslot max size per target, we could just hardcode or get
>> from KVM, max supported size of bitmap and use that to calculate
>> kvm_max_slot_size depending on target page size.
> 
> Right, I think if so hard code would be fine for now, and probably can
> with a smallest one across all archs (should depend on the smallest
> page size, I guess).
> 
>>
>> Then there wouldn't be need for having machine specific code
>> to care about it and pick/set arbitrary values.
>>
>> Another aspect to think about if we are to enable it for
>> other targets is memslot accounting. It doesn't affect s390
>> but other targets that support memory hotplug now assume 1:1
>> relation between memoryregion:memslot, which currently holds
>> true but would need to amended in case split is enabled there.
> 
> I didn't know this.  So maybe it makes more sense to have s390 only
> here.  Thanks,

OK. So shall I take the series as is via the s390 tree?
I would like to add the following patch on top if nobody minds:

Subject: [PATCH 1/1] s390/kvm: split kvm mem slots at 4TB

Instead of splitting at an unaligned address, we can simply split at
4TB.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/kvm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index ad2dd14f7e78..611f56f4b5ac 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -126,12 +126,11 @@
 /*
  * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
  * as the dirty bitmap must be managed by bitops that take an int as
- * position indicator. If we have a guest beyond that we will split off
- * new subregions. The split must happen on a segment boundary (1MB).
+ * position indicator. This would end at an unaligned  address
+ * (0x7fffff00000). As future variants might provide larger pages
+ * and to make all addresses properly aligned, let us split at 4TB.
  */
-#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
-#define SEG_MSK (~0xfffffULL)
-#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
+#define KVM_SLOT_MAX_BYTES 4096UL*1024*1024*1024
 
 static CPUWatchpoint hw_watchpoint;
 /*
-- 
2.21.0





