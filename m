Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAB6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A3522272
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UJHbcdQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A3522272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWv0-0005Ci-Ks
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIWty-0004g8-1b
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIWtr-0000AP-FL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600260661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bu4gYb7/byEkLcKmvTbZ8ShzFxwDvBfzyulEj33tGV8=;
 b=UJHbcdQknv2jNc1LfT3SXs4D9Jl8SolnZp8j288fBUDnOdDYpXjJMyrIbBkcKmSOYAB/pF
 k+JpXA8BKpR77ATM+hD1kMgiyvKQwpCZ3wb3CMjCDlir7IYrtlefswIVoAe/vZvuE29Sz1
 3z6GRjX+19/Szk3XWLH3I3ufuaDsLdg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-ytf6EWZaOda9ByPRkG8qpw-1; Wed, 16 Sep 2020 08:51:00 -0400
X-MC-Unique: ytf6EWZaOda9ByPRkG8qpw-1
Received: by mail-wr1-f69.google.com with SMTP id f18so2500222wrv.19
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=bu4gYb7/byEkLcKmvTbZ8ShzFxwDvBfzyulEj33tGV8=;
 b=LD0zwLFfu9XXqi1/DBwaLcbaB+KRVca6QY0igBpkWHExHPfywDe7/y4Y5sFKTDog9s
 3jHte8Z34VqgNyospYn5eKtVOUXq8Lyhz6i9PFhXk+zApRcRVl/hkPVBZ5FNR9cmvfSk
 VOPkUf2o44frq+A6XvoxbseOT+RoaQYXB6NObaoW+xyBW2yCVHiUBcoXUUr9q+GWqUTm
 gyzClX/RwLR/TCoz3/4EPfJGtrikoVITwkeqyiW/derhtUStr8opl/YlWJEzNlORLJ4v
 7crySj7lN5VROwnwVBK3cxZE1Z8kanKJuxVN+OW4ocT6s+wT/KtYbZRbjWPae38c4c9p
 crKg==
X-Gm-Message-State: AOAM531lE0V4JgJSrDhH0ln9lpXZgJjPTP4qXsSiPoWRB/j8FGYLzfCR
 WfJOOlbgWJTf5V9D0esdMu4QpR5Uowj5bn2cs+STyYDiHFsvL96/KnfL9gJRk3R2DX4eUQahm7A
 Yq5f2z2bx8arq/gI=
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr25124190wrm.147.1600260658421; 
 Wed, 16 Sep 2020 05:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqCiUmbdsgB08+TApOuWGFF/Fd0qlcevWhWoglRu1evyr0r69cJ34/X3RuTEYLDg1KsDo0BQ==
X-Received: by 2002:adf:e6c7:: with SMTP id y7mr25124168wrm.147.1600260658173; 
 Wed, 16 Sep 2020 05:50:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id e1sm26019288wrp.49.2020.09.16.05.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 05:50:57 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Antoine Damhet <antoine.damhet@blade-group.com>
Subject: Re: [BUG] Migration hv_time rollback
In-Reply-To: <878sd9j4s1.fsf@vitty.brq.redhat.com>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm> <20200916115950.tsarwvk2dwgiceoe@tartarus>
 <878sd9j4s1.fsf@vitty.brq.redhat.com>
Date: Wed, 16 Sep 2020 14:50:56 +0200
Message-ID: <875z8dj367.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Antoine Damhet <antoine.damhet@blade-group.com> writes:
>
>> On Wed, Sep 16, 2020 at 12:29:56PM +0100, Dr. David Alan Gilbert wrote:
>>> cc'ing in Vitaly who knows about the hv stuff.
>>
>> Thanks
>>
>>> 
>>> * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
>>> > Hi,
>>> > 
>>> > We are experiencing timestamp rollbacks during live-migration of
>>> > Windows 10 guests with the following qemu configuration (linux 5.4.46
>>> > and qemu master):
>>> > ```
>>> > $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=off,hv_time [...]
>>> > ```
>>> 
>>> How big a jump are you seeing, and how did you notice it in the guest?
>>
>> I'm seeing jumps of about the guest uptime (indicating a reset of the
>> counter). It's expected because we won't call `KVM_SET_CLOCK` to
>> restore any value.
>>
>> We first noticed it because after some migrations `dwm.exe` crashes with
>> the "(NTSTATUS) 0x8898009b - QueryPerformanceCounter returned a time in
>> the past." error code.
>>
>> I can also confirm the following hack makes the behavior disappear:
>>
>> ```
>> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
>> index 64283358f9..f334bdf35f 100644
>> --- a/hw/i386/kvm/clock.c
>> +++ b/hw/i386/kvm/clock.c
>> @@ -332,11 +332,7 @@ void kvmclock_create(void)
>>  {
>>      X86CPU *cpu = X86_CPU(first_cpu);
>>
>> -    if (kvm_enabled() &&
>> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
>> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
>> -        sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>> -    }
>> +    sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
>>  }
>>
>
>
> Oh, I think I see what's going on. When you add 'kvm=off'
> cpu->env.features[FEAT_KVM] is reset (see x86_cpu_expand_features()) so
> kvmclock QEMU device is not created and nobody calls KVM_SET_CLOCK on
> migration.
>
> In case we really want to support 'kvm=off' I think we can add Hyper-V
> features check here along with KVM, this should do the job.

Does the untested

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 64283358f91d..e03b2ca6d8f6 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -333,8 +333,9 @@ void kvmclock_create(void)
     X86CPU *cpu = X86_CPU(first_cpu);
 
     if (kvm_enabled() &&
-        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
-                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
+        ((cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
+                                         (1ULL << KVM_FEATURE_CLOCKSOURCE2))) ||
+         (cpu->env.features[FEAT_HYPERV_EAX] & HV_TIME_REF_COUNT_AVAILABLE))) {
         sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
     }
 }

help?

(I don't think we need to remove all 'if (kvm_enabled())' checks from
machine types as 'kvm=off' should not be related).

-- 
Vitaly


