Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507B0C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D601D20760
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWHA0rOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D601D20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0er-0005ac-T6
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kX0Vv-0000na-Bm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kX0Vt-0007ko-5S
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603711086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uNti5dCymq5z91X0KBhUDom162ajlPK1EfS8ApxanW4=;
 b=cWHA0rOGn2HOH+uBhS2TKfHvRxHL8KyPiU+AlefBLheJC3o6kdcWOOhBoGvjF+JnSIM48u
 TT9jldv1iPmZp+++mOYMZ528XFNcujKEsHzl5P8TQstzTAkIbZKEkX0W7k/m/UqU5mssXh
 g/XeFLF6Wh9rJCzzo/NkU5wRqAyrnAo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-aSy49o9APYegnSkhfRZMjw-1; Mon, 26 Oct 2020 07:18:01 -0400
X-MC-Unique: aSy49o9APYegnSkhfRZMjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1924E8B5DC0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:18:00 +0000 (UTC)
Received: from [10.36.113.62] (ovpn-113-62.ams2.redhat.com [10.36.113.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 490CB5B4B8;
 Mon, 26 Oct 2020 11:17:55 +0000 (UTC)
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
From: David Hildenbrand <david@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d7a20a33-0317-467e-6fc6-6528b3b46062@redhat.com>
Date: Mon, 26 Oct 2020 12:17:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <294a987d-b0ef-1b58-98ac-0d4d43075d6e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26.10.20 11:43, David Hildenbrand wrote:
> On 26.10.20 09:49, Vitaly Kuznetsov wrote:
>> Currently, KVM doesn't provide an API to make atomic updates to memmap when
>> the change touches more than one memory slot, e.g. in case we'd like to
>> punch a hole in an existing slot.
>>
>> Reports are that multi-CPU Q35 VMs booted with OVMF sometimes print something
>> like
>>
>> !!!! X64 Exception Type - 0E(#PF - Page-Fault)  CPU Apic ID - 00000003 !!!!
>> ExceptionData - 0000000000000010  I:1 R:0 U:0 W:0 P:0 PK:0 SS:0 SGX:0
>> RIP  - 000000007E35FAB6, CS  - 0000000000000038, RFLAGS - 0000000000010006
>> RAX  - 0000000000000000, RCX - 000000007E3598F2, RDX - 00000000078BFBFF
>> ...
>>
>> The problem seems to be that TSEG manipulations on one vCPU are not atomic
>> from other vCPUs views. In particular, here's the strace:
>>
>> Initial creation of the 'problematic' slot:
>>
>> 10085 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=2146435072, userspace_addr=0x7fb89bf00000}) = 0
>>
>> ... and then the update (caused by e.g. mch_update_smram()) later:
>>
>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=0, userspace_addr=0x7fb89bf00000}) = 0
>> 10090 ioctl(13, KVM_SET_USER_MEMORY_REGION, {slot=6, flags=0, guest_phys_addr=0x100000,
>>    memory_size=2129657856, userspace_addr=0x7fb89bf00000}) = 0
>>
>> In case KVM has to handle any event on a different vCPU in between these
>> two calls the #PF will get triggered.
>>
>> An ideal solution to the problem would probably require KVM to provide a
>> new API to do the whole transaction in one shot but as a band-aid we can
>> just pause all vCPUs to make memory transations atomic.
>>
>> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>> RFC: Generally, memap updates happen only a few times during guest boot but
>> I'm not sure there are no scenarios when pausing all vCPUs is undesireable
>> from performance point of view. Also, I'm not sure if kvm_enabled() check
>> is needed.
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  softmmu/memory.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index fa280a19f7f7..0bf6f3f6d5dc 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -28,6 +28,7 @@
>>  
>>  #include "exec/memory-internal.h"
>>  #include "exec/ram_addr.h"
>> +#include "sysemu/cpus.h"
>>  #include "sysemu/kvm.h"
>>  #include "sysemu/runstate.h"
>>  #include "sysemu/tcg.h"
>> @@ -1057,7 +1058,9 @@ static void address_space_update_topology(AddressSpace *as)
>>  void memory_region_transaction_begin(void)
>>  {
>>      qemu_flush_coalesced_mmio_buffer();
>> -    ++memory_region_transaction_depth;
>> +    if ((++memory_region_transaction_depth == 1) && kvm_enabled()) {
>> +        pause_all_vcpus();
>> +    }
>>  }
>>  
>>  void memory_region_transaction_commit(void)
>> @@ -1087,7 +1090,11 @@ void memory_region_transaction_commit(void)
>>              }
>>              ioeventfd_update_pending = false;
>>          }
>> -   }
>> +
>> +        if (kvm_enabled()) {
>> +            resume_all_vcpus();
>> +        }
>> +    }
>>  }
>>  
>>  static void memory_region_destructor_none(MemoryRegion *mr)
>>
> 
> This is in general unsafe. pause_all_vcpus() will temporarily drop the
> BQL, resulting in bad things happening to caller sites.
> 
> I studies the involved issues quite intensively when wanting to resize
> memory regions from virtio-mem code. It's not that easy.
> 
> Have a look at my RFC for resizing. You can apply something similar to
> other operations.
> 
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg684979.html

Oh, and I even mentioned the case you try to fix here back then

"
Instead of inhibiting during the region_resize(), we could inhibit for the
hole memory transaction (from begin() to commit()). This could be nice,
because also splitting of memory regions would be atomic (I remember there
was a BUG report regarding that), however, I am not sure if that might
impact any RT users.
"

The current patches live in
https://github.com/davidhildenbrand/qemu/commits/virtio-mem-next

Especially

https://github.com/davidhildenbrand/qemu/commit/433fbb3abed20f15030e42f2b2bea7e6b9a15180


I haven't proceeded in upstreaming because I'm still busy with
virtio-mem thingies in the kernel.

-- 
Thanks,

David / dhildenb


