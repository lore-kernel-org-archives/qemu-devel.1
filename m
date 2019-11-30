Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7259EC432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:58:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0582075C
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 08:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aq4e29uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0582075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iayaV-0000PL-Pw
	for qemu-devel@archiver.kernel.org; Sat, 30 Nov 2019 03:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iayP2-0003nA-Nk
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iayOz-000463-K9
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38499
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iayOz-00044X-3p
 for qemu-devel@nongnu.org; Sat, 30 Nov 2019 03:46:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575103612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IcUoPLnLCCQYKbAEba8CM92HrhcnVga6pUy/wnWOGOM=;
 b=Aq4e29uYBPi6/qXt1Y3nabkcMEImv1NNXMTp9izCfQurmaOWSyGn1NM4hBT6endQp+M6fx
 BPfwF9maEKGMMbO8G0dztYTBGppCtk6rp5MvZCyIaUZ1Tuq6s9k9e1qATqEBVVbUtZmdJj
 +CIBUpbA9mHymsJ6KlLym8byaUEAVaE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-gj3nyB2YOMi8Q0Qcy0jqBg-1; Sat, 30 Nov 2019 03:46:50 -0500
Received: by mail-wr1-f69.google.com with SMTP id l20so7076119wrc.13
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2019 00:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IcUoPLnLCCQYKbAEba8CM92HrhcnVga6pUy/wnWOGOM=;
 b=IM/U4zW0fIz1RzYuf5+gQIl7A7Il7Ip72Pgx4Nj8xLg2km7u5DM76Cclk2mtzs1BUX
 77waQDM7t+12oTRDQ8ShURZhIDwCiPj7aN4TTd4Y6eStGPV11f1892ElyB7X5k3bucpu
 VozVN+ZIhMHrxlay2NRhnpp/5Zkahv2V1EVdd9ydY9MiHD01RHiguN4riggzlTwpeueM
 ZQVNuL7FgIV8W5f+NuDjhH7QlknN22467amb2SUkL4MG8wyceucNfnqzpTTz1/n7z/Vr
 Xxh5O2WV9JigOGTykIQhun63Jl8dpd8XKumMMIuRfb4Oc9dPtV2SQiltigucaHZXycOG
 MKmg==
X-Gm-Message-State: APjAAAVAI1/bVj//TdnFiHrYjkIxOHb/lLBTp/qVI3udQp04gcX20MKk
 J5dgu7BODFym6hJdHp3lmdjdr82mKgN95+W9wpeHiDTIo4F4h0y83/isI6aOplrXka1W7xh20qK
 OV75yQ27zrjlU8Us=
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr57607040wrr.174.1575103609415; 
 Sat, 30 Nov 2019 00:46:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwamOoF3NCaCticX1ohgF7EN1/Y7xLpjN7Qpgir4cufXuzV8QNcDTbdWh0g0I8wYjRv+Sj8qw==
X-Received: by 2002:adf:fe0c:: with SMTP id n12mr57607026wrr.174.1575103609168; 
 Sat, 30 Nov 2019 00:46:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8cc3:8abd:4519:2cd6?
 ([2001:b07:6468:f312:8cc3:8abd:4519:2cd6])
 by smtp.gmail.com with ESMTPSA id d67sm15803856wmd.13.2019.11.30.00.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Nov 2019 00:46:48 -0800 (PST)
Subject: Re: [PATCH v2 5/5] hvf: save away type as well as vector so we can
 reinject them
To: Cameron Esfahani <dirty@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
 <e07e6085d8ab9054e58f85ae58e112df6adc024d.1574625592.git.dirty@apple.com>
 <eb3a2de7-fcfe-f0d5-8534-1c59ff40f61e@redhat.com>
 <5F8C8B54-3653-4417-9A08-E724032294F9@apple.com>
 <cdc4958b-6ef5-aee2-1cf2-8cb59ca031fe@redhat.com>
 <4EA34107-C294-47F4-8747-5407588BCA5C@apple.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad54c701-7aef-362c-1580-416b9e41bc29@redhat.com>
Date: Sat, 30 Nov 2019 09:46:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <4EA34107-C294-47F4-8747-5407588BCA5C@apple.com>
Content-Language: en-US
X-MC-Unique: gj3nyB2YOMi8Q0Qcy0jqBg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/11/19 09:31, Cameron Esfahani wrote:
> So far so good.  Without any workaround, I could get it to fail
> within a few seconds.  With your change, I've been running for a few
> minutes without a problem.  But, this is on my laptop, so I'll wait
> until I can test it on a wider-range of machines at work next week.
> If it continues to work, I'll update my patch to include this fix.

Great!  Note that there was a follow-up hunk in another email.

> Now, can you help me understand why this approach is better than what
> I had written?  When we're in hvf_store_events(), we have vector type
> and number.  All the information we need to reinject later.  So why
> not save vector type away, instead of attempting to reconstruct it
> from other information (env->ins_len) in hvf_inject_interrupts()?

No huge reason, I agree.  However, the event injection code in the
Android emulator was broken for pretty much every corner case, so when
we rewrote it in QEMU for Summer of Code we took KVM as a model (commit
b7394c8394, "i386: hvf: refactor event injection code for hvf",
2017-12-22).  Keeping the code similar can help with debugging, so I
prefer having the same meaning for env->interrupt_injected and
env->exception_nr across HVF and KVM.

I didn't write the code for KVM, so I cannot really say why they chose
to not save the event type.

Thanks,

Paolo

> 
> Cameron Esfahani
> dirty@apple.com
> 
> "There are times in the life of a nation when the only place a decent man can find himself is in prison."
> 
> 
> 
>> On Nov 28, 2019, at 5:56 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 26/11/19 21:04, Cameron Esfahani wrote:
>>> Our test case was booting many concurrent macOS VMs under heavy
>>> system load.  I don't know if I could create one to replicate that.
>>
>> Does this work?
>>
>> diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
>> index 1485b95776..26c6c3a49f 100644
>> --- a/target/i386/hvf/x86hvf.c
>> +++ b/target/i386/hvf/x86hvf.c
>> @@ -357,7 +357,11 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
>>     bool have_event = true;
>>     if (env->interrupt_injected != -1) {
>>         vector = env->interrupt_injected;
>> -        intr_type = VMCS_INTR_T_SWINTR;
>> +        if (env->ins_len) {
>> +            intr_type = VMCS_INTR_T_SWINTR;
>> +        } else {
>> +            intr_type = VMCS_INTR_T_HWINTR;
>> +        }
>>     } else if (env->exception_nr != -1) {
>>         vector = env->exception_nr;
>>         if (vector == EXCP03_INT3 || vector == EXCP04_INTO) {
>>
>> Thanks,
>>
>> Paolo
>>
> 


