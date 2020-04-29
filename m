Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5041C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF7B20787
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3kUyfn+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF7B20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jThik-00088A-MR
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jThED-0003xZ-Ul
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jThCm-0005Lt-Ee
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:33:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jThCl-0005LH-Uw
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588145547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1swq+jE5ZtlSlN58JozpAHsWiU889IXpG6QD2b5QpM=;
 b=P3kUyfn+QaI0lVGZR56oQTm+5NwKf+XHSQgQblOgE3Hm7yjm4KD+uYNEFRem7vaPsbwAlY
 RcT85TwgA0TmKU6oMsvFiLRoInsTbUCYazIQYEhPtvLMclBJDssqPEmbureUe2AALiAgEx
 v0SnmLqcxfWr1LkvRxBhrEydnVTNij0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-uJ0T2q7PNXaHNa9ks5hKoQ-1; Wed, 29 Apr 2020 03:32:25 -0400
X-MC-Unique: uJ0T2q7PNXaHNa9ks5hKoQ-1
Received: by mail-wm1-f69.google.com with SMTP id n17so660949wmi.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 00:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TY16dmGigatDRdnLDGUMP9OZrb2nXIKiLtIJ5EoL/Hs=;
 b=NVofpQvzNDD0kw7vChb7n5FWlUIRWDUAo/o4yXFs680nnjDhZXFaJw674TgIxzRccs
 Fi+Bwwe9z1WgczTLwr15ErkMGsj7dCrSzJyDmGXjMMxpXIlbV2xjfri/w5ZO7t2B17Rp
 le7SP3gTz9ehAS6f6URUzDAHozvpkVyjXgTZ5kenEOS5DZDO+FFv+ySCE+clNuXPCVQJ
 vtEEFE2DIchJ/GtnYY+mMBeor+FH3oquwN6M1mpYoKeeniLgq+jd+aXY4kBYStADTPNB
 jv8bOhqEn+Y//yZG7rBGvYnFrORB00jyal6Aj15NpR11ckKqM891Q7p9TcHJkgTI3Mw3
 Mkvg==
X-Gm-Message-State: AGi0PuZ+VKXZQlckDaHiBqdoqsDgMOqMETUXY57EPOJEWm5l9IPQouod
 e5n4YkoMYpiy+zH4Nunu5WQJq6GUHYhfAIhF7Cwzio+qf9GlULVOb3detyii4FAfYmOFpAWNIFA
 zFFnxMrEo8AHEQ3Q=
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr37020512wro.259.1588145544121; 
 Wed, 29 Apr 2020 00:32:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypLIj6dc13O0UiiTTEUteVzUBsEyeJ3CPMWskRJrT/I891TsfxqrFOKqPWJckXvsGxysREXxAQ==
X-Received: by 2002:adf:f0d2:: with SMTP id x18mr37020468wro.259.1588145543822; 
 Wed, 29 Apr 2020 00:32:23 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id g186sm6649680wme.7.2020.04.29.00.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 00:32:23 -0700 (PDT)
Subject: Re: [PATCH] s390x/kvm: help valgrind in several places
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>
References: <20200428183109.89439-1-borntraeger@de.ibm.com>
 <2a9751b5-3b0b-2982-0756-3083cea22f31@redhat.com>
 <beb31760-962a-c68c-a343-7aee0dca0530@de.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ce893ba5-3f73-67d8-656a-fb709b8c2d97@redhat.com>
Date: Wed, 29 Apr 2020 09:32:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <beb31760-962a-c68c-a343-7aee0dca0530@de.ibm.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

+Paolo

On 4/29/20 9:21 AM, Christian Borntraeger wrote:
>=20
> On 29.04.20 09:00, Philippe Mathieu-Daud=E9 wrote:
>> Hi Christian,
>>
>> On 4/28/20 8:31 PM, Christian Borntraeger wrote:
>>> We need some little help in the code to reduce the valgrind noise.
>>> - some designated initializers for the cpu model features and subfuncti=
ons
>>
>> ^ This could go as trivial patch while we discuss the rest.
>=20
> I can certainly split.

If you split then please directly include "Reviewed-by: Philippe=20
Mathieu-Daud=E9 <philmd@redhat.com>" to the it.

>=20
>>
>>> - mark memory as defined for sida memory reads
>>>
>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>> ---
>>
>> I couldn't apply this patch, then figured out it targets s390-next.
>>
>>>  =A0 target/s390x/kvm.c | 15 +++++++++++++--
>>>  =A0 1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 69881a0da0..bcd0ee0d14 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -52,6 +52,10 @@
>>>  =A0 #include "hw/s390x/s390-virtio-hcall.h"
>>>  =A0 #include "hw/s390x/pv.h"
>>>  =A0 +#ifdef CONFIG_VALGRIND_H
>>> +#include <valgrind/memcheck.h>
>>> +#endif
>>> +
>>>  =A0 #ifndef DEBUG_KVM
>>>  =A0 #define DEBUG_KVM=A0 0
>>>  =A0 #endif
>>> @@ -875,6 +879,13 @@ int kvm_s390_mem_op_pv(S390CPU *cpu, uint64_t offs=
et, void *hostbuf,
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 error_report("KVM_S390_MEM_OP failed: %s",=
 strerror(-ret));
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 abort();
>>>  =A0=A0=A0=A0=A0 }
>>
>> What about kvm_s390_mem_op()?
>=20
> I have not triggered something in here, but you are right, there should b=
e cases where we make conditions
> depend of that content. Will change my testing and add something here as =
well.
>>
>>> +
>>> +#ifdef CONFIG_VALGRIND_H
>>> +=A0=A0=A0 if (!is_write) {
>>> +=A0=A0=A0=A0=A0=A0=A0 VALGRIND_MAKE_MEM_DEFINED(hostbuf, len);
>>> +=A0=A0=A0 }
>>> +#endif
>>
>> I agree with this macro usage, but think it should be widely accessible =
by the whole codebase (and other targets).
>>
>> "exec/memory.h" is for MemoryRegion and AddressSpace. Maybe "exec/ram_ad=
dr.h" is a better place for common helpers.
>>
>> If Valgrind is only confused under KVM, the "sysemu/kvm.h" is the obviou=
s place.
>=20
> This macro IS available for the whole codebase if you include valgrind/me=
mcheck.h.
> We used it in the past (before 2.2) for kvm memory.
> See commit 541be9274e8ef227fb1b50ce124fd2cc2dce81a5 (kvm/valgrind: don't =
mark memory as initialized).
>=20
> The only thing that we could discuss is introducing a new global function=
 like
> valgrind_make_mem_defined that would hide the ifdefs.
> Is there interest in such a thing?
> It is likely that these corner cases (valgrind not able to see that this =
is defined) are more likely
> o happen with KVM.  But it would be useful for anything not only KVM.

Correct. What I wanted to say here is, if we can use this code=20
elsewhere, then it is worth adding a global helper (generic or KVM).

If you reuse this code twice, having an inlined function makes the code=20
more readable anyway.

See for example in util/coroutine-ucontext.c:

static inline void valgrind_stack_deregister(CoroutineUContext *co)
{
     VALGRIND_STACK_DEREGISTER(co->valgrind_stack_id);
}

Maybe we could have something like:

static inline void valgrind_define_memory(void *ptr,
                                           size_t size,
                                           bool is_defined)
{
     if (is_defined) {
         VALGRIND_MAKE_MEM_DEFINED(ptr, size);
     }
}

>=20
>>
>>> +
>>>  =A0=A0=A0=A0=A0 return ret;
>>>  =A0 }
>>>  =A0 @@ -2165,7 +2176,7 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>>>  =A0 =A0 static int query_cpu_subfunc(S390FeatBitmap features)
>>>  =A0 {
>>> -=A0=A0=A0 struct kvm_s390_vm_cpu_subfunc prop;
>>> +=A0=A0=A0 struct kvm_s390_vm_cpu_subfunc prop =3D {};
>>>  =A0=A0=A0=A0=A0 struct kvm_device_attr attr =3D {
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 .group =3D KVM_S390_VM_CPU_MODEL,
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 .attr =3D KVM_S390_VM_CPU_MACHINE_SUBFUNC,
>>> @@ -2292,7 +2303,7 @@ static int kvm_to_feat[][2] =3D {
>>>  =A0 =A0 static int query_cpu_feat(S390FeatBitmap features)
>>>  =A0 {
>>> -=A0=A0=A0 struct kvm_s390_vm_cpu_feat prop;
>>> +=A0=A0=A0 struct kvm_s390_vm_cpu_feat prop =3D {};
>>>  =A0=A0=A0=A0=A0 struct kvm_device_attr attr =3D {
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 .group =3D KVM_S390_VM_CPU_MODEL,
>>>  =A0=A0=A0=A0=A0=A0=A0=A0=A0 .attr =3D KVM_S390_VM_CPU_MACHINE_FEAT,
>>>
>>
>=20


