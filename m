Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132E9C433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:32:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAF7206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 08:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAF7206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs14u-00024d-5O
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 04:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47368)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hs13O-00014m-J8
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hs13N-0001Ah-Jv
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:30:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:57412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hs13N-0001A3-AI
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 04:30:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Jul 2019 01:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,322,1559545200"; d="scan'208";a="182657268"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga002.jf.intel.com with ESMTP; 29 Jul 2019 01:30:41 -0700
Date: Mon, 29 Jul 2019 16:30:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20190729083019.GC2255@richard>
References: <20190728131304.1282-1-richardw.yang@linux.intel.com>
 <20190728131304.1282-4-richardw.yang@linux.intel.com>
 <690fd825-3553-6dee-5ff4-2ad7652afe46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690fd825-3553-6dee-5ff4-2ad7652afe46@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: Re: [Qemu-devel] [PATCH 3/3] memory-device: break the loop if tmp
 exceed the hinted range
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: imammedo@redhat.com, mst@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 29, 2019 at 09:49:37AM +0200, David Hildenbrand wrote:
>On 28.07.19 15:13, Wei Yang wrote:
>> The memory-device list built by memory_device_build_list is ordered by
>> its address, this means if the tmp range exceed the hinted range, all
>> the following range will not overlap with it.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  hw/mem/memory-device.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 413b514586..aea47ab3e8 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -180,7 +180,7 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
>>                  range_make_empty(&new);
>>                  break;
>>              }
>> -        } else if (!hint) {
>> +        } else if (!hint || range_lob(&tmp) > range_upb(&new)) {
>>              break;
>>          }
>>      }
>> 
>
>Lower bound is inclusive, upper bound is exclusive. Shouldn't this be
>
>range_lob(&tmp) >= range_upb(&new)
>

Per my understanding, a range with start = 0, size = 0x10000, is represented

    [0, 0xffff]

So if I have another range [0xffff, 0x1ffff], they seems to overlap. The range
[0x10000, 0x1ffff] doesn't overlap with [0, 0xffff].

My original comparison looks right. Do I miss some point?

>Also, I wonder if patch #2 is now really needed?
>

Hmm... I think you are right.

I am afraid without Patch #2, the condition check is not that intuitive. Would
this bring some confusion for audience and maintenance?

I am not sure the percentage of occurrence when hint is provided, while the
generated code for check NULL is less than compare two values.

>-- 
>
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me

