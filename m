Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE5C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211862074F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hu/lVZ5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211862074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIlV-00087H-7o
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqIkP-00075H-4e
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52220
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jqIkM-0000ee-5o
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593533071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMPwWcTAKRvAMHpi7Kl/0i59K9HxukC0lMphapLk9sY=;
 b=Hu/lVZ5PDxBbE461SaHpMG2n2NWakG1kNv+WdiQrTvtHcL8/AlQ8vddgNopXLk8h0C+ZCs
 s5daRInYm6ZUgPWFYVtzjGo/92wUW3OQ1DVm/xHDkQu5qCir+zImpNaHI6qJO2h7gPBtp2
 RNyOdFMQN0OiDC67Eu0OlySfMG4Uxb4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-r08K2wfnO9iGvqIXrPG6Kw-1; Tue, 30 Jun 2020 12:04:28 -0400
X-MC-Unique: r08K2wfnO9iGvqIXrPG6Kw-1
Received: by mail-ej1-f69.google.com with SMTP id a26so9146280ejr.7
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 09:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gMPwWcTAKRvAMHpi7Kl/0i59K9HxukC0lMphapLk9sY=;
 b=qN3C5Vu1A5etZqCseEXmWWWuW7aEOVJR4z8zG5v6s4anOvvMpO0uBTYXSoODLHLiYr
 c0qnVycPYeOybh/obyB1CihRltPpiE0+ooeRHd6TzAjvqSQOvUN/nai+d5Ex3CYRx8vM
 XiHXxIEDyvDGucDZ4eJZa3iDEitLFMPN45t1dtNtYsc9gFkCFgYAPXF0RS2oQ9i0wA7w
 qAAX3QKyzB9pr2xaK+sNM5ZujrtP/RBs897vML9SZwVDmBsE8/APEhdLpqrkL2MttwsO
 GZM9sl9pioSQbNT/+YiUhVFKOvim05Umh4LaHEOVGqo8i3BSsY7ivkJxcW5pBxhMUtza
 vusg==
X-Gm-Message-State: AOAM533BNFfdeT69msNUIbtTapyspPcczR+udP9h1KNoSGilryE/88vB
 LFAdI/zrOvzVY1x6S1K856g1eItvDvbZB30wtNAeg+9nG2wIoqKgco4dP/IH924BqNcPUNQ0q2A
 qKxa2yUsi5btmEBU=
X-Received: by 2002:a17:906:fcab:: with SMTP id
 qw11mr18655361ejb.456.1593533065499; 
 Tue, 30 Jun 2020 09:04:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+N10bzT0Hy1EY0WluPIFY0nUNHXJSUIK3h2ouVeG0J3Qp7LXJMR1IS98pwoSxMDa07SIj5w==
X-Received: by 2002:a17:906:fcab:: with SMTP id
 qw11mr18655339ejb.456.1593533065282; 
 Tue, 30 Jun 2020 09:04:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:acad:d1d4:42b8:23e4?
 ([2001:b07:6468:f312:acad:d1d4:42b8:23e4])
 by smtp.gmail.com with ESMTPSA id e4sm2351376ejx.76.2020.06.30.09.04.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 09:04:24 -0700 (PDT)
Subject: Re: [PATCH v2 4/9] i386: hvf: Implement CPU kick
To: Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200630102824.77604-1-r.bolshakov@yadro.com>
 <20200630102824.77604-5-r.bolshakov@yadro.com>
 <d75c6bd1-b588-796b-e238-21ff41fce60d@redhat.com>
 <20200630155059.GA78555@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2ba7aa12-9eba-1cef-93e0-5561f50629b9@redhat.com>
Date: Tue, 30 Jun 2020 18:04:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200630155059.GA78555@SPB-NB-133.local>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/06/20 17:50, Roman Bolshakov wrote:
> On Tue, Jun 30, 2020 at 02:33:42PM +0200, Paolo Bonzini wrote:
>> On 30/06/20 12:28, Roman Bolshakov wrote:
>>> @@ -966,6 +964,20 @@ int hvf_vcpu_exec(CPUState *cpu)
>>>      return ret;
>>>  }
>>>  
>>> +void hvf_vcpu_kick(CPUState *cpu)
>>> +{
>>> +    X86CPU *x86_cpu = X86_CPU(cpu);
>>> +    CPUX86State *env = &x86_cpu->env;
>>> +    hv_return_t err;
>>> +
>>> +    atomic_set(&env->hvf_deadline, 0);
>>> +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
>>> +    if (err) {
>>> +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
>>> +        exit(1);
>>> +    }
>>
>> Can a signal interrupt hv_vcpu_run?  If so you actually don't need
>> hv_vcpu_interrupt at all.
> 
> Existing signal masking and SIG_IPI didn't work IIRC when I tried to add
> a primitive version of gdbstub support.

You can try pthread_kill followed by hv_vcpu_interrupt if it doesn't.
The signal would be delivered after return to userspace.

Paolo

>> You can also require the preemption time, all
>> processor that support HVF have it, but never set it by default.  The
>> deadline can be left at 0 all the time; instead, you toggle the bit in
>> the pin-based controls.  In the signal handler you do:
>>
>> 	if (atomic_xchg(&env->hvf_in_guest, false)) {
>> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
>> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
>> 			| VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
>> 	}
>>
>> In the main loop you do:
>>
>> 	atomic_set(&env->hvf_guest_mode, true);
>> 	smp_mb();
>> 	hv_vcpu_run(...);
>> 	atomic_set(&env->hvf_guest_mode, false);
>>
>> and in the preemption timer vmexit handler:
>> 	
>> 		wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
>> 		      rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
>> 			& ~VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
>>
> 
> Ok, I'll look into that. Thanks for the advices!
> 
> -Roman
> 


