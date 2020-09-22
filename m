Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE37C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB29A2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 17:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLbGWOc0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB29A2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKm29-0007N7-Nf
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 13:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKm07-0006UT-Fw
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:22:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKm04-0001Ic-JD
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 13:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600795363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KigQAlr6UDmkQYx0L4r7q/CQ87ZmKU7WeTN3EhF7o1U=;
 b=QLbGWOc06aIEF4vW99+PH1zAhVrqTkR1dEersUn5jCnIYlHZWnj9k+cEDCr1e9PsE1USx+
 vErYyiejC90hbPHMFivnCBc3EIfmta316kc+8cBmgEDsh5Yby4BL5jeh13bYRoTpnLOlgN
 bICJ8Ir8X4mUYnGuf2CCepL7xpwobgA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-iB7jGidHOHy5WQMu-BGUQg-1; Tue, 22 Sep 2020 13:22:35 -0400
X-MC-Unique: iB7jGidHOHy5WQMu-BGUQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1E1802B5E;
 Tue, 22 Sep 2020 17:22:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2177614F5;
 Tue, 22 Sep 2020 17:22:30 +0000 (UTC)
Date: Tue, 22 Sep 2020 13:22:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] i386: Don't try to set MSR_KVM_ASYNC_PF_EN if
 kernel-irqchip=off
Message-ID: <20200922172229.GB57321@habkost.net>
References: <20200922151455.1763896-1-ehabkost@redhat.com>
 <87v9g5es9n.fsf@vitty.brq.redhat.com>
 <20200922161055.GY57321@habkost.net>
 <87pn6depau.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pn6depau.fsf@vitty.brq.redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
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

On Tue, Sep 22, 2020 at 06:42:17PM +0200, Vitaly Kuznetsov wrote:
> Eduardo Habkost <ehabkost@redhat.com> writes:
> 
> > On Tue, Sep 22, 2020 at 05:38:12PM +0200, Vitaly Kuznetsov wrote:
> >> Eduardo Habkost <ehabkost@redhat.com> writes:
> >> 
> >> > This addresses the following crash when running Linux v5.8
> >> > with kernel-irqchip=off:
> >> >
> >> >   qemu-system-x86_64: error: failed to set MSR 0x4b564d02 to 0x0
> >> >   qemu-system-x86_64: ../target/i386/kvm.c:2714: kvm_buf_set_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> >> >
> >> > There is a kernel-side fix for the issue too (kernel commit
> >> > d831de177217 "KVM: x86: always allow writing '0' to
> >> > MSR_KVM_ASYNC_PF_EN"), but it's nice to simply not trigger
> >> > the bug if running an older kernel.
> >> >
> >> > Fixes: https://bugs.launchpad.net/bugs/1896263
> >> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >> > ---
> >> >  target/i386/kvm.c | 7 ++++++-
> >> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> >> > index 9efb07e7c83..1492f41349f 100644
> >> > --- a/target/i386/kvm.c
> >> > +++ b/target/i386/kvm.c
> >> > @@ -2818,7 +2818,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> >> >          kvm_msr_entry_add(cpu, MSR_IA32_TSC, env->tsc);
> >> >          kvm_msr_entry_add(cpu, MSR_KVM_SYSTEM_TIME, env->system_time_msr);
> >> >          kvm_msr_entry_add(cpu, MSR_KVM_WALL_CLOCK, env->wall_clock_msr);
> >> > -        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF)) {
> >> > +        /*
> >> > +         * Some kernel versions (v5.8) won't let MSR_KVM_ASYNC_PF_EN to be set
> >> > +         * at all if kernel-irqchip=off, so don't try to set it in that case.
> >> > +         */
> >> > +        if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_ASYNC_PF) &&
> >> > +            kvm_irqchip_in_kernel()) {
> >> >              kvm_msr_entry_add(cpu, MSR_KVM_ASYNC_PF_EN, env->async_pf_en_msr);
> >> >          }
> >> >          if (env->features[FEAT_KVM] & (1 << KVM_FEATURE_PV_EOI)) {
> >> 
> >> I'm not sure kvm_irqchip_in_kernel() was required before we switched to
> >> interrupt-based APF (as we were always injecting #PF) but with
> >> kernel-5.8+ this should work. [...]
> >
> > Were guests able to set MSR_KVM_ASYNC_PF_EN to non-zero with
> > kernel-irqchip=off on hosts running Linux <= 5.7? 
> 
> lapic_in_kernel() check appeared in kernel with the following commit:
> 
> commit 9d3c447c72fb2337ca39f245c6ae89f2369de216
> Author: Wanpeng Li <wanpengli@tencent.com>
> Date:   Mon Jun 29 18:26:31 2020 +0800
> 
>     KVM: X86: Fix async pf caused null-ptr-deref
> 
> which was post-interrupt-based-APF. I *think* it was OK to enable APF
> with !lapic_in_kernel() before (at least I don't see what would not
> allow that).

If it was possible, did KVM break live migration of
kernel-irqchip=off guests that enabled APF?  This would mean my
patch is replacing a crash with a silent migration bug.  Not nice
either way.

> 
> > I am assuming
> > kvm-asyncpf never worked with kernel-irqchip=off (and enabling it
> > by default with kernel-irqchip=off was a mistake).
> >
> >
> >>                         [...] We'll need to merge this with
> >> 
> >> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg02963.html
> >> (queued by Paolo) and
> >> https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg06196.html
> >> which fixes a bug in it.
> >> 
> >> as kvm_irqchip_in_kernel() should go around both KVM_FEATURE_ASYNC_PF
> >> and KVM_FEATURE_ASYNC_PF_INT I believe.
> >
> > Shouldn't we just disallow kvm-asyncpf-int=on if kernel-irqchip=off?
> 
> (Sarcasm: if disallowing 'kernel-irqchip=off' is not an option, then)

I'm working on it.  :-)

> yes, we probably can, but kvm-asyncpf-int=on is the default we have so
> we can't just implicitly change it underneath or migration will break...

kvm-asyncpf-int wasn't merged yet, was it?  This means we don't
have compatibility issues to care about.

-- 
Eduardo


