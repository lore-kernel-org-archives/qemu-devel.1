Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D941C4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C663208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iM71vzX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C663208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfX9-0002Fp-3r
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfWJ-0001ks-1K
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfWH-0005rz-7c
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiucKqhwr2yW5rmLfiSdDIhVjZX2uU2nMYoBw1Qb9UA=;
 b=iM71vzX1L6XohN8reZWIFTbkgErEyujKkxtuujr/89sGb3xLzJVDMsLSB+/6V/PPqzi8pH
 j96rxX2GiUrTT2NoVBKbHfswJJblw1vV5KD+RaE25KI+3J0gpOD15VosCIIPXWs+nFrGdi
 rzVSRZRPTFxHpQ9tsbdgKXrtz+Vyea4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-AcfRm_hzPnS-Gu0y2K5XsQ-1; Tue, 22 Sep 2020 06:27:30 -0400
X-MC-Unique: AcfRm_hzPnS-Gu0y2K5XsQ-1
Received: by mail-ej1-f72.google.com with SMTP id w17so6043387eja.10
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=GiucKqhwr2yW5rmLfiSdDIhVjZX2uU2nMYoBw1Qb9UA=;
 b=H37isRZ3DYoRg+pdZ6reTnjoYF50xseDYlBV3dKItardHdehO2gQ+f/gY/wl+ymtqW
 gFrJknRRXUO2y16MJt/X9hIbE+9z8ISnkh4Gkye5ohXZH4n7eov2fKejoQgGhQloCu1k
 WGW+QhZghuo9Mk5nrG//L/U/sU7TffAncOGrEEHLoBT3iigtnMHwfhzHmoiiRgZ7rS9K
 OswLuZaTbKGknoFKu9JeXJNKtrzhswJJj3Re8l+VhjlAlSq7NLZX/TJJjNQ3PB84llys
 Ijv/8pBJjotCq8iChqgqrrozsFRaZ6tY5JY4Atf0fSvddPNaXYJ9R6qiQ974yrfDpNMI
 mynw==
X-Gm-Message-State: AOAM531+UdTpxs0o/ft8VUZ2E4Yyk0aucleF6WNPtK+eXgZ8WU2JIB2J
 u+qpezr17i0PSziKIa/tKMDwvtfR+bLsIRVdg+1hm0FFN+2sADiEVlJOZI97NdK0jqzreHYyopC
 ctaTxV5asEmKXPnI=
X-Received: by 2002:a50:eb92:: with SMTP id y18mr3054954edr.373.1600770449391; 
 Tue, 22 Sep 2020 03:27:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsOa113+kAnSLURvH5VWliFxJlizB3s20U9E5BmQ+bWtcAhoQ89uqjYw6NKhlxlFtYnjtYDQ==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr3054942edr.373.1600770449216; 
 Tue, 22 Sep 2020 03:27:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id l21sm11416264ejg.124.2020.09.22.03.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:27:28 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH RFC 09/22] i386: add reserved FEAT_HYPERV_ECX CPUID leaf
In-Reply-To: <20200918222515.GI57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-10-vkuznets@redhat.com>
 <20200918222515.GI57321@habkost.net>
Date: Tue, 22 Sep 2020 12:27:27 +0200
Message-ID: <87h7rqf6nk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Sep 04, 2020 at 04:54:18PM +0200, Vitaly Kuznetsov wrote:
>> As a preparation to expanding Hyper-V CPU features early, add
>> reserved FEAT_HYPERV_ECX CPUID leaf.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  target/i386/cpu.c | 5 +++++
>>  target/i386/cpu.h | 1 +
>>  target/i386/kvm.c | 2 ++
>>  3 files changed, 8 insertions(+)
>> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index ef3c672cf415..70588571ccb1 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -974,6 +974,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>          },
>>          .cpuid = { .eax = 0x40000003, .reg = R_EBX, },
>>      },
>> +    [FEAT_HYPERV_ECX] = {
>> +        .type = CPUID_FEATURE_WORD,
>> +        /* reserved */
>
> What does "reserved" mean here?

This is actually from TLFS, these bits are currently reserved and there
are no features represented by them. We can, of course, short-circuit
this to '0' but I'd prefer to keep it for consistency. I can change to
something like 'Reserved as of TLFS v6.0b' to make it clear. 

>
>> +        .cpuid = { .eax = 0x40000003, .reg = R_ECX, },
>> +    },
>>      [FEAT_HYPERV_EDX] = {
>>          .type = CPUID_FEATURE_WORD,
>>          .feat_names = {
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index 095d0bf75493..39e0e89aa41f 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -521,6 +521,7 @@ typedef enum FeatureWord {
>>      FEAT_KVM_HINTS,     /* CPUID[4000_0001].EDX */
>>      FEAT_HYPERV_EAX,    /* CPUID[4000_0003].EAX */
>>      FEAT_HYPERV_EBX,    /* CPUID[4000_0003].EBX */
>> +    FEAT_HYPERV_ECX,    /* CPUID[4000_0003].ECX */
>>      FEAT_HYPERV_EDX,    /* CPUID[4000_0003].EDX */
>>      FEAT_HV_RECOMM_EAX, /* CPUID[4000_0004].EAX */
>>      FEAT_HV_NESTED_EAX, /* CPUID[4000_000A].EAX */
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 96ac719adca1..259be2d514dd 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1251,6 +1251,7 @@ static int hyperv_handle_properties(CPUState *cs,
>>          if (c) {
>>              env->features[FEAT_HYPERV_EAX] = c->eax;
>>              env->features[FEAT_HYPERV_EBX] = c->ebx;
>> +            env->features[FEAT_HYPERV_ECX] = c->ecx;
>>              env->features[FEAT_HYPERV_EDX] = c->edx;
>>          }
>>  
>> @@ -1350,6 +1351,7 @@ static int hyperv_handle_properties(CPUState *cs,
>>      c->function = HV_CPUID_FEATURES;
>>      c->eax = env->features[FEAT_HYPERV_EAX];
>>      c->ebx = env->features[FEAT_HYPERV_EBX];
>> +    c->ecx = env->features[FEAT_HYPERV_ECX];
>>      c->edx = env->features[FEAT_HYPERV_EDX];
>>  
>>      c = &cpuid_ent[cpuid_i++];
>> -- 
>> 2.25.4
>> 

-- 
Vitaly


