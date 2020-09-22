Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600BC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C65208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 10:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWO+6NyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C65208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKfaB-0003iV-VR
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 06:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfYv-0003AE-L6
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKfYu-0006Ad-1O
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 06:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600770615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tQaJ0aggWGudDKfMOsaTf6G5YzJLFw+62F+PgtDgPc4=;
 b=QWO+6NyC7ZwcfpZtb12XEs+pmtOXgVMvO7sLy5EZ9Iqrf/QdtTYpL6fFs5vH+YAKRK8wwW
 xJZdcapmiMLxkx/F6PIk/hWUYjSuiWeBf0jbtoRQ6GcEyYFZrBSQ2TsL6cjHvK4anyv2r2
 2SwGmvXiUKdNEai7VyBXlNFZL1MSOMg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-Hb0TjU42MJKwjWBoWZh84g-1; Tue, 22 Sep 2020 06:30:13 -0400
X-MC-Unique: Hb0TjU42MJKwjWBoWZh84g-1
Received: by mail-ed1-f71.google.com with SMTP id c3so5586193eds.6
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 03:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=tQaJ0aggWGudDKfMOsaTf6G5YzJLFw+62F+PgtDgPc4=;
 b=D+MYT1+iAM1gfe+mt5PePdvcwSAIKwYWd0s+/sFa0iiQRwIzibpHRz8vMoCkxC/4g5
 d0ZFpt96rYVMSyiWDxJVwgXR5Q3kqSqAkzQVC4TwsrI3h6o47UsLdPS9R0XQyv5OpaEh
 aBOHXc1lP9vdpD8ve/oa0G+Itjhdsx4OJdnTz/7kYMvZetHy97dsecYeC2lNnsKmI8AY
 BePkE+Ug/6gg9d+B0w3lxZmdLRrOrKf+l2tIMvsT44xVHhy1uMfD0g7diX/DlZ2wbSEk
 iMZ0G4yrcU85ahrrsQ6f10l804nbHdoKuajyMWUlwtRnsi7/kUe+rmACbnv/TNjQGZfU
 OkDg==
X-Gm-Message-State: AOAM5337TFMC1/9K5joR1gITIRVN4r5Uphw/mQLTxHjUhNRHT4Fuuw75
 snvsuSKOFv1L3SXSdJL1v5SRTBhFjyNTuOFm/JPnKiQ4HKbYY1L1pEVZsYgSkJOTc/vkvcp3zJK
 F7lSlYrEIhLyN4T8=
X-Received: by 2002:a17:906:ae45:: with SMTP id
 lf5mr3947906ejb.339.1600770612137; 
 Tue, 22 Sep 2020 03:30:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzW5QpsMDSU3Um0cL6+g8xDkwSfo6AmvX//M+Xp5xxRTVYN2nvDEEbQaJMhGj+Uu68WYrJC9g==
X-Received: by 2002:a17:906:ae45:: with SMTP id
 lf5mr3947889ejb.339.1600770611935; 
 Tue, 22 Sep 2020 03:30:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id m10sm10875181ejx.123.2020.09.22.03.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 03:30:11 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH RFC 12/22] i386: always fill Hyper-V CPUID feature leaves
 from X86CPU data
In-Reply-To: <20200918223217.GJ57321@habkost.net>
References: <20200904145431.196885-1-vkuznets@redhat.com>
 <20200904145431.196885-13-vkuznets@redhat.com>
 <20200918223217.GJ57321@habkost.net>
Date: Tue, 22 Sep 2020 12:30:10 +0200
Message-ID: <87eemuf6j1.fsf@vitty.brq.redhat.com>
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

> On Fri, Sep 04, 2020 at 04:54:21PM +0200, Vitaly Kuznetsov wrote:
>> We have all the required data in X86CPU already and as we are about to
>> split hyperv_handle_properties() into hyperv_expand_features()/
>> hyperv_fill_cpuids() we can remove the blind copy. The functional change
>> is that QEMU won't pass CPUID leaves it doesn't currently know about
>> to the guest but arguably this is a good change.
>
> Is it, though?  Maybe we don't want it to be the default, but a
> blind passthrough mode that copies all CPUID leaves would be
> useful for testing new features.
>

We already have Hyper-V features which require extra work to get enabled
(SynIC, EVMCS). Passing corresponding feature bits to guests without
actually enabling these features in KVM will likely break them. So a pure
'blind passthrough' mode is not possible. 

>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  target/i386/kvm.c | 9 ---------
>>  1 file changed, 9 deletions(-)
>> 
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 87b83a2aa2cb..b7f0e200a75f 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1221,9 +1221,6 @@ static int hyperv_handle_properties(CPUState *cs,
>>      }
>>  
>>      if (cpu->hyperv_passthrough) {
>> -        memcpy(cpuid_ent, &cpuid->entries[0],
>> -               cpuid->nent * sizeof(cpuid->entries[0]));
>> -
>>          c = cpuid_find_entry(cpuid, HV_CPUID_VENDOR_AND_MAX_FUNCTIONS, 0);
>>          if (c) {
>>              cpu->hyperv_vendor_id[0] = c->ebx;
>> @@ -1325,12 +1322,6 @@ static int hyperv_handle_properties(CPUState *cs,
>>          goto free;
>>      }
>>  
>> -    if (cpu->hyperv_passthrough) {
>> -        /* We already copied all feature words from KVM as is */
>> -        r = cpuid->nent;
>> -        goto free;
>> -    }
>> -
>>      c = &cpuid_ent[cpuid_i++];
>>      c->function = HV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>>      c->eax = hyperv_feat_enabled(cpu, HYPERV_FEAT_EVMCS) ?
>> -- 
>> 2.25.4
>> 

-- 
Vitaly


