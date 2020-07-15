Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C71206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 09:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Poaqf1GU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C71206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvdzA-000692-Oq
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 05:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvdwI-00024A-Vd
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:42:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56339
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jvdwG-0006Zm-7X
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 05:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594806170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9WszTE0m/ezS/6il4mmWE/U9Wa9FN6Pbl7jvCZa18xs=;
 b=Poaqf1GUd6XsUANt7b7WGIncI5EQz4HU4t7uFku5Llm43OhUFYBy7IhBGPHvSiyaKhEmPO
 yJLXD15MiHVvxjwVB6MJcjuUV+W0pB3yLSQFLiAL+ZDXA4ZOuyGdlQbTIK1tf9uXCTUkP/
 gGLXzQ9cMY1KL6qJ+3YI0l6q679V5PI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-5AFVs-EbO_qOujvblLQuZQ-1; Wed, 15 Jul 2020 05:42:46 -0400
X-MC-Unique: 5AFVs-EbO_qOujvblLQuZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF9DC80040A;
 Wed, 15 Jul 2020 09:42:44 +0000 (UTC)
Received: from [10.36.115.47] (ovpn-115-47.ams2.redhat.com [10.36.115.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02FF4100164C;
 Wed, 15 Jul 2020 09:42:37 +0000 (UTC)
Subject: Re: [PATCH RFC 2/5] s390x: implement diag260
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>
References: <20200713091243.GB4359@osiris>
 <07E9FD5B-F07F-415B-9C00-A2A882F07CBC@redhat.com>
 <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 WNyWQQ==
Organization: Red Hat GmbH
Message-ID: <a0b52f65-d253-c51b-6dfc-0a61f939c759@redhat.com>
Date: Wed, 15 Jul 2020 11:42:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <92b1a2a6-2348-d4ff-6d20-35f3bfef710a@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13.07.20 13:08, Christian Borntraeger wrote:
> On 13.07.20 12:27, David Hildenbrand wrote:
>>
>>
>>> Am 13.07.2020 um 11:12 schrieb Heiko Carstens <hca@linux.ibm.com>:
>>>
>>> ﻿On Fri, Jul 10, 2020 at 05:24:07PM +0200, David Hildenbrand wrote:
>>>>> On 10.07.20 17:18, Heiko Carstens wrote:
>>>>> On Fri, Jul 10, 2020 at 02:12:33PM +0200, David Hildenbrand wrote:
>>>>>>> Note: Reading about diag260 subcode 0xc, we could modify Linux to query
>>>>>>> the maximum possible pfn via diag260 0xc. Then, we maybe could avoid
>>>>>>> indicating maxram size via SCLP, and keep diag260-unaware OSs keep
>>>>>>> working as before. Thoughts?
>>>>>>
>>>>>> Implemented it, seems to work fine.
>>>>>
>>>>> The returned value would not include standby/reserved memory within
>>>>> z/VM. So this seems not to work.
>>>>
>>>> Which value exactly are you referencing? diag 0xc returns two values.
>>>> One of them seems to do exactly what we need.
>>>>
>>>> See
>>>> https://github.com/davidhildenbrand/linux/commit/a235f9fb20df7c04ae89bc0d134332d1a01842c7
>>>>
>>>> for my current Linux approach.
>>>>
>>>>> Also: why do you want to change this
>>>>
>>>> Which change exactly do you mean?
>>>>
>>>> If we limit the value returned via SCLP to initial memory, we cannot
>>>> break any guest (e.g., Linux pre 4.2, kvm-unit-tests). diag260 is then
>>>> purely optional.
>>>
>>> Ok, now I see the context. Christian added my just to cc on this
>>> specific patch.
>>
>> I tried to Cc you an all patches but the mail bounced with unknown address (maybe I messed up).
>>
>>> So if I understand you correctly, then you want to use diag 260 in
>>> order to figure out how much memory is _potentially_ available for a
>>> guest?
>>
>> Yes, exactly.
>>
>>>
>>> This does not fit to the current semantics, since diag 260 returns the
>>> address of the highest *currently* accessible address. That is: it
>>> does explicitly *not* include standby memory or anything else that
>>> might potentially be there.
>>
>> The confusing part is that it talks about „adressible“ and not „accessible“. Now that I understood the „DEFINE STORAGE ...“ example, it makes sense that the values change with reserved/standby memory.
>>
>> I agree that reusing that interface might not be what we want. I just seemed too easy to avoid creating something new :)
>>
>>>
>>> So you would need a different interface to tell the guest about your
>>> new hotplug memory interface. If sclp does not work, then maybe a new
>>> diagnose(?).
>>>
>>
>> Yes, I think a new Diagnose makes sense. I‘ll have a look next week to figure out which codes/subcodes we could use. @Christian @Conny any ideas/pointers?> 
> 
> Wouldnt sclp be the right thing to provide the max increment number? (and thus the max memory address)
> And then (when I got the discussion right) use diag 260 to get the _current_ value.

So, in summary, we want to indicate to the guest a memory region that
will be used to place memory devices ("device memory region"). The
region might have holes and the memory within this region might have
different semantics than ordinary system memory. Memory that belongs to
memory devices should only be detected+used if the guest OS has support
for them (e.g., virtio-mem, virtio-pmem, ...). An unmodified guest
(e.g., no virtio-mem driver) should not accidentally make use of such
memory.

We need a way to
a) Tell the guest about boot memory (currently ram_size)
b) Tell the guest about the maximum possible ram address, including
device memory. (We could also indicate the special "device memory
region" explicitly)


AFAIK, we have three options:


1. Indicate maxram_size via SCLP, indicate ram_size via diag260(0x10)

This is what this series (RFCv1 does).

Advantages:
- No need for a new diag. No need for memory sensing kernel changes.
Disadvantages
- Older guests without support for diag260 (<v4.2, kvm-unit-tests) will
  assume all memory is accessible. Bad.
- The semantics of the value returned in ry via diag260(0xc) is somewhat
  unclear. Should we return the end address of the highest memory
  device? OTOH, an unmodified guest OS (without support for memory
  devices) should not have to care at all about any such memory.
- If we ever want to also support standby memory, we might be in
  trouble. (see below)

2. Indicate ram_size via SCLP, indicate device memory region
   (currently maxram_size) via new DIAG

Advantages:
- Unmodified guests won't use/sense memory belonging to memory devices.
- We can later have standby memory + memory devices co-exist.
Disadvantages
- Need a new DIAG.

3. Indicate maxram_size and ram_size via SCLP (using the SCLP standby
   memory)

I did not look into the details, because -ENODOCUMENTATION. At least we
would run into some alignment issues (again, having to align
ram_size/maxram_size to storage increments - which would no longer be
1MB). We would run into issues later, trying to also support standby memory.



I guess 1) would mostly work, one just has to run a suitable guest
inside the VM. This is no different to running under z/VM where querying
diag260 is required. The nice thing about 2) would be, that we can
easily implement standby memory. Something like:

-m 2G,maxram_size=20G,standbyram_size=4G

[ 2G boot RAM ][ 4G standby RAM ][ 14G device memory ]
                                 ^ via SCLP maximum increment
                                                     ^ via new DIAG

-- 
Thanks,

David / dhildenb


