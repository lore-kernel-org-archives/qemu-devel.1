Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD2C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:13:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 979A720874
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HV2qyHAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 979A720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKlqo-00088u-LF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56574)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKlN7-0008UT-UK
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:42:29 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKlN5-0003wL-AQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 12:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600792944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iC8G1whfqPByL39Es6pKKfyv7XS871I1AqRax9as92w=;
 b=HV2qyHAR5ATHcqVSVIz2gG8EaJL2DoFbLLf/Hx/AeSLPuwcFr/96QKc7gwUCKvh6R1YjgH
 Onih5Z/7fjBIv1qFLqpP9YTzNj++kFsaEDOX0+hFe4VAONmyuEaLH9Dp01QGKt/gp6p8uF
 cDmtPK+LrJiTlRK4+xwkPzZG28ANV0w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-jSgA8F3xP9qM9CTbiaB3zg-1; Tue, 22 Sep 2020 12:42:20 -0400
X-MC-Unique: jSgA8F3xP9qM9CTbiaB3zg-1
Received: by mail-wm1-f71.google.com with SMTP id r10so1323376wmh.0
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 09:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=iC8G1whfqPByL39Es6pKKfyv7XS871I1AqRax9as92w=;
 b=bugokpZOddUS+cJyzYi2Q2nAMDD/a56y2Q2kfH0lIAwc6agxVRlUC3e/Ca1FirUC9j
 pzewLeBXhspkWxQ8/6Cxnt8QXgOCimcP1oy8Ricj/s8xMgpV3v7wViXv9OGyUhppQQDK
 vIOB3Ue7N7o4CvS0fta37jEj7xUhnqlhyuzHg7UvLTsg9XBu8VID7QUaM52e37/xXwTr
 kxcD22qFa9vW7fv5dOSfwDqYHeVfHPg14bFOeOzRJAKZQnNkjowolFqj8zbPUUszMWaF
 jrA0SrsdUDEUO1k+Higjk+Y7P6Slh/p9zAZ+3jx4RGulhra03ScaXIkZ5jo7TuC3ojA1
 Wytw==
X-Gm-Message-State: AOAM531HiV2O6bTg2cyF01cXrBUJpXuWWbgOEeyI4bc+GUUH81bedp32
 yNTLV7pZc2iehQHmbpRTCloUBLWc4XWaAT1r72Z6t1hnrBv8uLuZjs4rKHEF2bgjUDePfHjBeuu
 9PiYEKJp/dqFW2qA=
X-Received: by 2002:adf:fa02:: with SMTP id m2mr6306461wrr.273.1600792938783; 
 Tue, 22 Sep 2020 09:42:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSvIwNCluQ4FAdd7gj+dZFejqLTr9QQqBoSt51Uv0sBnAa3cF1jWqs2VgojAtFDe4WXBTOyA==
X-Received: by 2002:adf:fa02:: with SMTP id m2mr6306426wrr.273.1600792938539; 
 Tue, 22 Sep 2020 09:42:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id u63sm5469043wmb.13.2020.09.22.09.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 09:42:18 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN if
 kernel-irqchip=off
In-Reply-To: <20200922161055.GY57321@habkost.net>
References: <20200922151455.1763896-1-ehabkost@redhat.com>
 <87v9g5es9n.fsf@vitty.brq.redhat.com> <20200922161055.GY57321@habkost.net>
Date: Tue, 22 Sep 2020 18:42:17 +0200
Message-ID: <87pn6depau.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 12:04:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, 1896263@bugs.launchpad.net,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200922164217.zxR3kqiiBninlqa5-nQ-9YnDubJuccRz96ZaFgu1nO8@z>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Tue, Sep 22, 2020 at 05:38:12PM +0200, Vitaly Kuznetsov wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>> 
>> > This addresses the following crash when running Linux v5.8
>> > with kernel-irqchip=off:
>> >
>> >   qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
>> >   qemu-system-x86_64: ../target/i386/kvm.c:2714: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
>> >
>> > There is a kernel-side fix for the issue too (kernel commit
>> > d831de177217 "KVM: x86: always allow writing '0' to
>> > MSR_KVM_ASYNC_PF_EN"), but it's nice to simply not trigger
>> > the bug if running an older kernel.
>> >
>> > Fixes: https://bugs.launchpad.net/bugs/1896263
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> > ---
>> >  target/i386/kvm.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> > index 9efb07e7c83..1492f41349f 100644
>> > --- a/target/i386/kvm.c
>> > +++ b/target/i386/kvm.c
>> > @@ -2818,7 +2818,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
>> >          kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
>> >          kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
>> >          kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
>> > -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
>> > +        /*
>> > +         * Some kernel versions (v5.8) won't let MSR_KVM_ASYNC_PF_EN to be set
>> > +         * at all if kernel-irqchip=off, so don't try to set it in that case.
>> > +         */
>> > +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF) &&
>> > +            kvm_irqchip_in_kernel()) {
>> >              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
>> >          }
>> >          if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
>> 
>> I'm not sure kvm_irqchip_in_kernel() was required before we switched to
>> interrupt-based APF (as we were always injecting #PF) but with
>> kernel-5.8+ this should work. [...]
>
> Were guests able to set MSR_KVM_ASYNC_PF_EN to non-zero with
> kernel-irqchip=off on hosts running Linux <= 5.7? 

lapic_in_kernel() check appeared in kernel with the following commit:

commit 9d3c447c72fb2337ca39f245c6ae89f2369de216
Author: Wanpeng Li <wanpengli@tencent.com>
Date:   Mon Jun 29 18:26:31 2020 +0800

    KVM: X86: Fix async pf caused null-ptr-deref

which was post-interrupt-based-APF. I *think* it was OK to enable APF
with !lapic_in_kernel() before (at least I don't see what would not
allow that).

> I am assuming
> kvm-asyncpf never worked with kernel-irqchip=off (and enabling it
> by default with kernel-irqchip=off was a mistake).
>
>
>>                         [...] We'll need to merge this with
>> 
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg02963.html
>> (queued by Paolo) and
>> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg06196.html
>> which fixes a bug in it.
>> 
>> as kvm_irqchip_in_kernel() should go around both KVM_FEATURE_ASYNC_PF
>> and KVM_FEATURE_ASYNC_PF_INT I believe.
>
> Shouldn't we just disallow kvm-asyncpf-int=on if kernel-irqchip=off?

(Sarcasm: if disallowing 'kernel-irqchip=off' is not an option, then)
yes, we probably can, but kvm-asyncpf-int=on is the default we have so
we can't just implicitly change it underneath or migration will break...

-- 
Vitaly


