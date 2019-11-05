Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C3C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D077E2084D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 20:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPfeuv9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D077E2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS58m-0003Qm-ST
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 15:09:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iS57G-0001ok-3x
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iS57D-0003d4-UQ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:07:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iS57D-0003cY-M5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:07:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572984467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSzzAfODqqdhyP2ZzDIF/K8JBP9U+DQM/74JHAYjh48=;
 b=aPfeuv9z5LPmAtP/fS1C4y0UcuDJKmcUcnOdf0EIINcPVrpYe69Ew9x+D70530IgKuTc84
 ntu0KYw6r2Fx4fUA+xXXq1nTm8DdtaSJleNE0UJ2QFJuLxnMlFftutU3hbq4Fb6jxrRYwK
 JEicAvdDeHnZIEInUP/00Sgu310rhQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-HnADu6HjNKSljK8wexc0DA-1; Tue, 05 Nov 2019 15:07:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB112800054;
 Tue,  5 Nov 2019 20:07:42 +0000 (UTC)
Received: from [10.36.116.98] (ovpn-116-98.ams2.redhat.com [10.36.116.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAED19D70;
 Tue,  5 Nov 2019 20:07:41 +0000 (UTC)
Subject: Re: [PATCH] s390x: Properly fetch and test the short psw on diag308
 subc 0/1
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191105184434.16148-1-frankja@linux.ibm.com>
 <76ba0773-b6da-a73a-0a76-9a23f004a9b7@redhat.com>
 <d638849d-638a-797e-a550-9e68e807e2f2@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f62ecfe8-970c-bd53-aec1-7cc18b987f19@redhat.com>
Date: Tue, 5 Nov 2019 21:07:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <d638849d-638a-797e-a550-9e68e807e2f2@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: HnADu6HjNKSljK8wexc0DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05.11.19 20:34, Janosch Frank wrote:
> On 11/5/19 8:29 PM, David Hildenbrand wrote:
>> On 05.11.19 19:44, Janosch Frank wrote:
>>> We need to actually fetch the cpu mask and set it after checking for
>>> psw bit 12 instead of completely ignoring it.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>    target/s390x/cpu.c | 11 +++++++++--
>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>>> index 736a7903e2..0acba843a7 100644
>>> --- a/target/s390x/cpu.c
>>> +++ b/target/s390x/cpu.c
>>> @@ -76,8 +76,15 @@ static bool s390_cpu_has_work(CPUState *cs)
>>>    static void s390_cpu_load_normal(CPUState *s)
>>>    {
>>>        S390CPU *cpu =3D S390_CPU(s);
>>> -    cpu->env.psw.addr =3D ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
>>> -    cpu->env.psw.mask =3D PSW_MASK_32 | PSW_MASK_64;
>>> +    uint64_t spsw =3D ldq_phys(s->as, 0);
>>> +
>>> +    /* Mask out bit 12 and instruction address */
>>> +    cpu->env.psw.mask =3D spsw & 0xfff7ffff80000000UL;
>>> +    cpu->env.psw.addr =3D spsw & 0x7fffffffUL;
>>
>> "set it after checking for psw bit 12" does not match your code.
>=20
> Ok, I need to alter the commit message, see below for the reason.
>=20
>>
>>> +
>>> +    if (!(spsw & 0x8000000000000UL)) {
>>> +        s390_program_interrupt(&cpu->env, PGM_SPECIFICATION, 0, RA_IGN=
ORED);
>>> +    }
>>
>> So, this code is called from s390_machine_reset() via run_on_cpu() - so
>> not from a helper. There is no state to rewind. This feels wrong to me.
>>
>> In tcg_s390_program_interrupt(), we do
>>
>> 1. A cpu_restore_state(), which is bad with a ra of 0
>> 2. A cpu_loop_exit(), which is bad, as we are not in the cpu loop.
>>
>> We *could* do here instead
>>
>> /* This code is not called from the CPU loop, but via run_on_cpu() */
>> if (tcg_enabled()) {
>>       /*
>>        * HW injects a PGM exception with ILC 0. We won't rewind.
>>        */
>>       env->int_pgm_ilen =3D 2;
>>       trigger_pgm_exception(&cpu->env, PGM_SPECIFICATION);
>> } else {
>>       kvm_s390_program_interrupt(env_archcpu(&cpu->env),
>>                                  PGM_SPECIFICATION);
>> }
>>
>>
>> BUT I do wonder if we should actually get a PGM_SPECIFICATION for the
>> *diag* instruction, not on the boot CPU. I think you should check +
>> inject inside handle_diag_308() instead. Then that complicated handling
>> is gone.
>>
>=20
> I'm not completely sure if we are allowed to do that.
> I think we need to load the PSW, so we can indicate the PSW which caused
> the spec exception. At least that's what lpar does and I'll need to
> speak with the architecture designers to verify that we absolutely need
> to do it.

This should fall under "Exceptions Associated with the PSW" - PoP 6-9. I=20
assume we talk about early exceptions.


"For the following error conditions, a program interrup-
tion for a specification exception occurs immediately
after the PSW becomes active:
...
Any of the unassigned bits (0, 2-4, 25-30, or
33-63) is a one.
...
Bit 12 is a one.
...
Bits 31 and 32 are zero and one, respectively,
and bits 64-96 are not all zeros.
...
Bits 31 and 32 are both zero, and bits 64-103 are
not all zeros.
Bits 31 and 32 are one and zero, respectively.
...
Programming Note: Bit 12 of an 8-byte short-format
PSW in storage is inverted when the 16-byte current
PSW is loaded from the following locations:
...
An assigned storage location in the ESA/390-
compatibility mode.
"

The ILC is usually 0 (with exceptions) and the PSW address was updated.


Note: For TCG we miss many of these validity checks. For KVM, most=20
should be triggered when running the VCPU AFAIK (that means, we don't=20
have to check for any other scenarios here). Checking for the special=20
case as given in the programming note should be sufficient.


I'll have to think about how to best handle that for TCG (mazbe what I=20
proposed works). We could ignore TCG for now and add a TODO. Then, just=20
wrap the exception in a "if (kvm_enabled())". You could also document=20
why we only have to check for this very specific bit and not the other=20
bits (handled by HW later).

--=20

Thanks,

David / dhildenb


