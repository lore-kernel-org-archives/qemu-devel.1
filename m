Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1ABC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 211502395C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+vUjUYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 211502395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfTU-0008Jj-6l
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfSf-0007UW-T8
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfSc-00055U-IT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ua9NWhLhqHHrxEpmDckfJjcCngvUwGYs9BEm2jZrXcM=;
 b=d+vUjUYaMY97XLCDnTDLUoIWZ5HLeElb7gLx9ZxbVNXZ9CQlQotos9QVzHxCoriVDWqZkQ
 pDZ7CpHjWoSPsE8AX2KjeXTejcaRAPSBwSeXHFQ6K2mbXo4Dkj843PiqQJtAy2Y45HKX/i
 YOC9IAvaRmI5KHwuyH5nHJWca3cJHBo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-97YgrjC0OsyRVOG2SewOHw-1; Tue, 22 Sep 2020 06:23:43 -0400
X-MC-Unique: 97YgrjC0OsyRVOG2SewOHw-1
Received: by mail-ed1-f69.google.com with SMTP id b12so5608024edw.15
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=Ua9NWhLhqHHrxEpmDckfJjcCngvUwGYs9BEm2jZrXcM=;
 b=l9X2sQjX9ccy8g72e3Yje7V7lfCzWpLZVuzH1Uc4vujO9KhiL2dX5ZsEjLwC/6Mws/
 S6lXFIq7gHO9xEQ6nTwABIJqkqPdg+cn+2BMd7wxvFVkED9cfo+O647NU//udnOUTToa
 bSFGvZXuZRulLg7+h4qa0u9Mx/cbe1z8l4ykkihWIh3iWCwTrgjDGMLtydsVbHxcYZyd
 e5HOcjZHnZdWLvChRYcMpwAKc0MUSJeT9rn1k4syA5KH4AFVNwWBTm3GFWXg6v7aNuTz
 wgD8GF6xxzSq0/JPIoFPB9puIPfqa2maNPN8GsVEdrJdFnU/2oSd+NlzMnOkTiYJxp+x
 ZMXA==
X-Gm-Message-State: AOAM531jzllDFTxSzpACHUwFi//pXiiyLli79dpHANvX2kGHZvQcwKxh
 Y4sA6MxX8zd7KnXXV+TpmS781VpnLBPseLa2v8qQRq5slRiZRZz62eoqEXcLP80mMg+nUev8DjO
 /+e3WlqJme1loIuY=
X-Received: by 2002:a17:906:2747:: with SMTP id
 a7mr3997479ejd.301.1600770222477; 
 Tue, 22 Sep 2020 03:23:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+NXTdXAUyrN1tC5GCqEMI7HN6X5HogeipE5JWjvC3lG3s83Q7Ih2luC/hjOKFZ7nf+cJwsw==
X-Received: by 2002:a17:906:2747:: with SMTP id
 a7mr3997460ejd.301.1600770222226; 
 Tue, 22 Sep 2020 03:23:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id lo25sm10903698ejb.53.2020.09.22.03.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:23:41 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH RFC 03/22] i386: move hyperv_vendor_id initialization to
 x86_cpu_realizefn()
In-Reply-To: <20200918221454.GC57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-4-vkuznets@redhat.com>
 <20200918221454.GC57321@habkost.net>
Date: Tue, 22 Sep 2020 12:23:40 +0200
Message-ID: <87k0wmf6tv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
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

> On Fri, Sep 04, 2020 at 04:54:12PM +0200, Vitaly Kuznetsov wrote:
>> As a preparation to expanding Hyper-V CPU features early, move
>> hyperv_vendor_id initialization to x86_cpu_realizefn().
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  target/i386/cpu.c | 15 ++++++++++++++-
>>  target/i386/cpu.h |  3 ++-
>>  target/i386/kvm.c | 25 ++++++++++---------------
>>  3 files changed, 26 insertions(+), 17 deletions(-)
>> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 14489def2177..07e9da9e567e 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -6625,6 +6625,19 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>>          }
>>      }
>>  
>> +    if (!cpu->hyperv_vendor) {
>> +        memcpy(cpu->hyperv_vendor_id, "Microsoft Hv", 12);
>> +    } else {
>> +        size_t len = strlen(cpu->hyperv_vendor);
>> +
>> +        if (len > 12) {
>> +            warn_report("hv-vendor-id truncated to 12 characters");
>> +            len = 12;
>> +        }
>> +        memset(cpu->hyperv_vendor_id, 0, 12);
>> +        memcpy(cpu->hyperv_vendor_id, cpu->hyperv_vendor, len);
>> +    }
>> +
>
> The change makes sense, but considering that we'll have a lot of
> new code added to x86_cpu_realizefn(), I would prefer to create a
> separate x86_cpu_hyperv_realize() function to make
> x86_cpu_realizefn() a bit more readable.
>

Agreed.

>
>>      if (cpu->ucode_rev == 0) {
>>          /* The default is the same as KVM's.  */
>>          if (IS_AMD_CPU(env)) {
>> @@ -7313,7 +7326,7 @@ static Property x86_cpu_properties[] = {
>>      DEFINE_PROP_UINT32("min-xlevel2", X86CPU, env.cpuid_min_xlevel2, 0),
>>      DEFINE_PROP_UINT64("ucode-rev", X86CPU, ucode_rev, 0),
>>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>> -    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor_id),
>> +    DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
>>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
>>      DEFINE_PROP_BOOL("l3-cache", X86CPU, enable_l3_cache, true),
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index d3097be6a50a..903994818093 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1654,11 +1654,12 @@ struct X86CPU {
>>      uint64_t ucode_rev;
>>  
>>      uint32_t hyperv_spinlock_attempts;
>> -    char *hyperv_vendor_id;
>> +    char *hyperv_vendor;
>>      bool hyperv_synic_kvm_only;
>>      uint64_t hyperv_features;
>>      bool hyperv_passthrough;
>>      OnOffAuto hyperv_no_nonarch_cs;
>> +    uint32_t hyperv_vendor_id[3];
>>  
>>      bool check_cpuid;
>>      bool enforce_cpuid;
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 205b68bc0ce8..47779c5e1efd 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1225,6 +1225,13 @@ static int hyperv_handle_properties(CPUState *cs,
>>          memcpy(cpuid_ent, &cpuid->entries[0],
>>                 cpuid->nent * sizeof(cpuid->entries[0]));
>>  
>> +        c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
>> +        if (c) {
>> +            cpu->hyperv_vendor_id[0] = c->ebx;
>> +            cpu->hyperv_vendor_id[1] = c->ecx;
>> +            cpu->hyperv_vendor_id[2] = c->edx;
>> +        }
>> +
>
> I can't find the equivalent of this code in the current tree?  Is
> hyperv vendor ID broken when using hv-passthrough today?
>
> Maybe this could be done as a separate patch, as it changes
> behavior of hv-passthrough?

(this and similar changes in other patches) Actually we don't change
anything. Before this series and with hv-passthrough we just don't
reflect host's CPUIDs in our internal QEMU structures so
e.g. X86CPU->hyperv_vendor remains 'Microsoft Hv' while in reality
guest sees what kernel told us ("Linux KVM Hv" BTW). We just copy
everything we get from KVM_GET_SUPPORTED_HV_CPUID into guest's CPUIDs.
This is fine as we didn't actually need the information in QEMU but
to achieve the goal of the series we need to keep proper in-QEMU
representation.

The real change is that post-series QEMU is not enabling any Hyper-V
features which it doesn't know about while pre-series it was actually
doing this. This is arguably a good change: enabling new features may
require some additional work (e.g. enabling capabilities in KVM) and
without it just passing CPUID feature bits the guest may get confused.

>
>>          c = cpuid_find_entry(cpuid, HV_CPUID_FEATURES, 0);
>>          if (c) {
>>              env->features[FEAT_HYPERV_EAX] = c->eax;
>> @@ -1299,23 +1306,11 @@ static int hyperv_handle_properties(CPUState *cs,
>>  
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>> -    if (!cpu->hyperv_vendor_id) {
>> -        memcpy(signature, "Microsoft Hv", 12);
>> -    } else {
>> -        size_t len = strlen(cpu->hyperv_vendor_id);
>> -
>> -        if (len > 12) {
>> -            error_report("hv-vendor-id truncated to 12 characters");
>> -            len = 12;
>> -        }
>> -        memset(signature, 0, 12);
>> -        memcpy(signature, cpu->hyperv_vendor_id, len);
>> -    }
>>      c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
>>          HV_CPUID_NESTED_FEATURES : HV_CPUID_IMPLEMENT_LIMITS;
>> -    c->ebx = signature[0];
>> -    c->ecx = signature[1];
>> -    c->edx = signature[2];
>> +    c->ebx = cpu->hyperv_vendor_id[0];
>> +    c->ecx = cpu->hyperv_vendor_id[1];
>> +    c->edx = cpu->hyperv_vendor_id[2];
>>  
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_INTERFACE;
>> -- 
>> 2.25.4
>> 

-- 
Vitaly


