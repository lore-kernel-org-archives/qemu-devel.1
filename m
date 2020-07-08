Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9350FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:02:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A2B9206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4S6DAFK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A2B9206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtK1T-0000hw-L3
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtJzw-0008Rq-BG
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:01:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36745
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jtJzs-0005FB-BO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594252862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KlhHp/7kWZ3WBnMdu7vyCbLvYFlWuleoFLwyuYzvi8=;
 b=e4S6DAFKdIyWTWFXkNMunE7ZmX+CybjYt8fTcuDT/jg6i1wbAHw3fgOI99JNn0sthKfEkA
 DLqVPRzzKRZWSUQLfh4grZvZbmGRqvOmcCEHpwavy5QkpVK2hb9NRjsDCnXfMFZz4o1elv
 wy/q16p9Ka4iUG8lmX26haxPTrUCQgQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-w6xiifn2PYepgTCqW7TQAA-1; Wed, 08 Jul 2020 03:58:21 -0400
X-MC-Unique: w6xiifn2PYepgTCqW7TQAA-1
Received: by mail-wm1-f72.google.com with SMTP id l5so2180438wml.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 00:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5KlhHp/7kWZ3WBnMdu7vyCbLvYFlWuleoFLwyuYzvi8=;
 b=fT8VjXWP7sibOgRrwxU68RFV6ufknUkgzzHvShcFYjMAZg81VQJyueJqzjBFpY4s+1
 YwtGDbtdPoHAygFJr8+OsjUZzLR3IlzN32jJ6Qjhwc/Tf/x5AuabBpBzcsLpRnwdRnch
 011HUesgTe8MruawiyvOrYGA/0f8Bwjch7JlizY1CTjGGUjYVojsUULXmQttnuzFCnDA
 PzAeEpfo5TnIN0LD62IyhSH7yTNiokRuUEi4ZydVBxsqrmMZUs2RsrOKLw7C6DCEkY2T
 AH8+ww2KruEtf5FmG06sgi0s/mbeyu+ZNrgg6vIn+IsX6wzCAbm/qNjO1EPsv3tkgfVC
 DirA==
X-Gm-Message-State: AOAM533BEMGaQV4j3UsL9He97xvnNNJRx2MkAcwPbR0JZIAO8/GwSHon
 FI4LWRBccZg/NaKOO/2jYJ1SJp5MMGrbVlnHCH+0uuJf9Lb+xmIWZWkNVpHu7PnIBMIWFp5q4nt
 XIqSbjLuC+x6Sclc=
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr55092779wrm.379.1594195100033; 
 Wed, 08 Jul 2020 00:58:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/bedp8bdgAfiWEZDbwZ+FjkgjutqrqAoc7wQPOkSp+/54Hwm/rCEbtrPXfnBGHHiEd/xLUQ==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr55092761wrm.379.1594195099799; 
 Wed, 08 Jul 2020 00:58:19 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c?
 ([2001:b07:6468:f312:9541:9439:cb0f:89c])
 by smtp.gmail.com with ESMTPSA id u84sm4683982wmg.7.2020.07.08.00.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 00:58:19 -0700 (PDT)
Subject: Re: [RFC v2 3/6] cpus: extract out kvm-specific code to accel/kvm
To: Claudio Fontana <cfontana@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20200707135808.9241-1-cfontana@suse.de>
 <20200707135808.9241-4-cfontana@suse.de>
 <dc01dc35-c053-656c-72f5-87cad56706fb@redhat.com>
 <3f7f56ea-7b1d-106d-9f84-2d618aa5e7c9@suse.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ece0b845-fbe2-514f-1207-826c01240f2e@redhat.com>
Date: Wed, 8 Jul 2020 09:58:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3f7f56ea-7b1d-106d-9f84-2d618aa5e7c9@suse.de>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/07/20 09:40, Claudio Fontana wrote:
> Ciao Paolo,
> 
> On 7/7/20 7:01 PM, Paolo Bonzini wrote:
>> On 07/07/20 15:58, Claudio Fontana wrote:
>>> +static void kvm_kick_vcpu_thread(CPUState *cpu)
>>> +{
>>> +    cpus_kick_thread(cpu);
>>> +}
>>> +
>>
>> I would just use cpus_kick_thread instead of wrapping it (and likewise
> 
> Here I left the common code in cpus_kick_thread, which is just used "as is" for kvm,
> but for hax f.e. we have:
> 
> [...]
>
> Maybe we will need additional code that specializes the kick also for HVF?
> 
> I cannot run cpus_kick_thread for _all_ accels, because it is not good for Windows (whpx and hax-windows).

Yeah, I meant just initialize the function pointer with
cpus_kick_thread, instead of having the wrapper, similar to the global
noops.

>> would provide a global function for noop synchronization).
> 
> I will look into providing global noops, thanks!
> 
>> start_vcpu_thread is also a candidate for abstraction, so that
> 
> Thanks, will look into this!
> The accel that I expect will resist this will be tcg, but will try to fit it.

Yes, no problem if some of them are different.

Paolo

> 
>> kvm_start_vcpu_thread(CPUState *cpu) would be just
>>
>> 	qemu_start_vcpu_thread(cpu, "KVM", kvm_vcpu_thread_fn);
>>
>> Paolo
>>
>>
> 
> Ciao,
> 
> Claudio
> 


