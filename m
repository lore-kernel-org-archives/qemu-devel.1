Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4245EC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C1E20679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqXUopJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C1E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46zl-0003Np-5W
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56134)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j46yM-0001cQ-LX
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j46yK-0004FX-Pe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:47:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46965
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j46yI-0004Di-Sr
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582048066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kjKBIhoTTidU+FupA78S2evj3eCjsBh8yUTE4Js91o=;
 b=WqXUopJ9Vi8CyaRgJWzMnDI4RWdzK7n/pk40EsSv92+dgEgK7lD4q3Rp0hraQRL/eUoRWR
 cvpYZtf+C20Fnfw+TnsTPHyNoLRBW0cIGNOQ/2cbCx7M+g11AfupdKMNxCJZSj5tNcnyP7
 BMOYd2JO4dJQvcnuMWGNbeoGfPYtf04=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-yfTxhLvmPSuxoXtLFPzjjg-1; Tue, 18 Feb 2020 12:47:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id o24so390201wmh.0
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5kjKBIhoTTidU+FupA78S2evj3eCjsBh8yUTE4Js91o=;
 b=FdXH7uqzJbOkkTFUa3xYQwJm5TzmU7VLHuFscWsiIC/jVf9gRYX5ljaDO/ZkhK8Pc3
 TH69naE73Y7V3h1F3yBkxPO2gt2zdj8GUb6hhwWkuAAoqi9bS9CaVdv93vIoP+K3Fdwv
 CwEDANPxbjrB+KAlnuHcCE464+HzZuM4BXtLfAwWAfjSa7RaaVDhXIdGCs3wBKVSrnMA
 OxcuVuSDpwuZYQS97U2OLdRRRfD+7NiVd0/i3JwhDM3t6IoM1YQYAoFrAd4oK95rvSMo
 P6763exilRMhr14j3ecG7ICv0OiaqN3JE3KdiU3NvOXAIrssro21TwphFs5KDwnUYfsI
 HIdg==
X-Gm-Message-State: APjAAAVANZ8aO6DLgildnczxdQIgm4+fbMzAAkooqBY/glSrlcfbHTqi
 2NTXvK6ND/KFULEXHocZR0mYS/O7FNpkkz8RZYUO+RYQ6rfSNFltUeoRoE3OxHk03rhe1CddG8p
 aPGqgukjpChRNRZM=
X-Received: by 2002:a05:600c:2104:: with SMTP id
 u4mr4367470wml.93.1582048063265; 
 Tue, 18 Feb 2020 09:47:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgPoCPNWqdRWxxxlv5m5qb2kca+QONzuSaxHOJTlTzKHB2ZOY2ORJdnCv42m80J8gLowgW1Q==
X-Received: by 2002:a05:600c:2104:: with SMTP id
 u4mr4367454wml.93.1582048063019; 
 Tue, 18 Feb 2020 09:47:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id t128sm4511467wmf.28.2020.02.18.09.47.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:47:42 -0800 (PST)
Subject: Re: [PATCH RFC] target/i386: filter out VMX_PIN_BASED_POSTED_INTR
 when enabling SynIC
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20200218144415.94722-1-vkuznets@redhat.com>
 <9b4b46c2-e2cf-a3d5-70e4-c8772bf6734f@redhat.com>
 <87k14j962l.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5a3159d-4cab-ef94-bbfc-e9120324cd3e@redhat.com>
Date: Tue, 18 Feb 2020 18:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87k14j962l.fsf@vitty.brq.redhat.com>
Content-Language: en-US
X-MC-Unique: yfTxhLvmPSuxoXtLFPzjjg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, Liran Alon <liran.alon@oracle.com>,
 Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/02/20 18:08, Vitaly Kuznetsov wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 18/02/20 15:44, Vitaly Kuznetsov wrote:
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>> RFC: This is somewhat similar to eVMCS breakage and it is likely possible
>>> to fix this in KVM. I decided to try QEMU first as this is a single
>>> control and unlike eVMCS we don't need to keep a list of things to disable.
>>
>> I think you should disable "virtual-interrupt delivery" instead (which
>> in turn requires "process posted interrupts" to be zero).  That is the
>> one that is incompatible with AutoEOI interrupts.
> 
> I'm fighting the symptoms, not the cause :-) My understanding is that
> when SynIC is enabled for CPU0 KVM does
> 
> kvm_vcpu_update_apicv()
> 	vmx_refresh_apicv_exec_ctrl()
> 		pin_controls_set()
> 
> for *all* vCPUs (KVM_REQ_APICV_UPDATE). I'm not sure why
> SECONDARY_EXEC_APIC_REGISTER_VIRT/SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY
> are not causing problems and only PIN_BASED_POSTED_INTR does as we clear
> them all (not very important atm).

Let's take a step back, what is the symptom, i.e. how does it fail?
Because thinking more about it, since we have separate VMCS we can set
PIN_BASED_POSTED_INTR and SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY just fine
in the vmcs02.  The important part is to unconditionally call
vmx_deliver_nested_posted_interrupt.

Something like

	if (kvm_x86_ops->deliver_posted_interrupt(vcpu, vector)) {
                kvm_lapic_set_irr(vector, apic);
                kvm_make_request(KVM_REQ_EVENT, vcpu);
                kvm_vcpu_kick(vcpu);
        }

and in vmx_deliver_posted_interrupt

        r = vmx_deliver_nested_posted_interrupt(vcpu, vector);
        if (!r)
                return 0;

	if (!vcpu->arch.apicv_active)
                return -1;
        ...
        return 0;

Paolo


