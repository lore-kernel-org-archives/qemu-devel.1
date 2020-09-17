Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D57C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D298F206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCQYz62Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D298F206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIy0r-0003Wl-Nf
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 13:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIxxQ-0000uF-RZ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:44:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kIxxP-00037y-2O
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 13:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600364670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/yqIInjnTal9RXjvDBvExWKgy52J0VRy7RBX+TE8S7A=;
 b=aCQYz62Zs7fbRqQXa57ekZXlDcPXSIkDeXqxI6CQeEkW1J094o5Z8a6qgsCo5lWWC8Uc4y
 6hHwxH0mipQU8E1ymgEyYoVqT+Ga6RIlsBWgNT52+8m+VrLiEyi/MY1fHQJ8G/hh9G4Pi5
 Ks/2ev5Ib9FC3PO+7vCnv/KJRUElW/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-A0C3sWcCNFudyKkEB7s4vw-1; Thu, 17 Sep 2020 13:44:27 -0400
X-MC-Unique: A0C3sWcCNFudyKkEB7s4vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B2E9100CAB8;
 Thu, 17 Sep 2020 17:44:26 +0000 (UTC)
Received: from work-vm (ovpn-114-108.ams2.redhat.com [10.36.114.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11C5560C57;
 Thu, 17 Sep 2020 17:44:12 +0000 (UTC)
Date: Thu, 17 Sep 2020 18:44:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH] target/i386: always create kvmclock device
Message-ID: <20200917174410.GU2793@work-vm>
References: <20200917111306.819263-1-vkuznets@redhat.com>
 <20200917122559.e7i5o64k7rw7urdh@tartarus>
 <87ft7gh6gy.fsf@vitty.brq.redhat.com>
 <20200917144237.GK2793@work-vm>
 <875z8ch2m6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <875z8ch2m6.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Antoine Damhet <antoine.damhet@blade-group.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
> >> Antoine Damhet <antoine.damhet@blade-group.com> writes:
> >> 
> >> > On Thu, Sep 17, 2020 at 01:13:06PM +0200, Vitaly Kuznetsov wrote:
> >> >> QEMU's kvmclock device is only created when KVM PV feature bits for
> >> >> kvmclock (KVM_FEATURE_CLOCKSOURCE/KVM_FEATURE_CLOCKSOURCE2) are
> >> >> exposed to the guest. With 'kvm=off' cpu flag the device is not
> >> >> created and we don't call KVM_GET_CLOCK/KVM_SET_CLOCK upon migration.
> >> >> It was reported that without these call at least Hyper-V TSC page
> >> >> clocksouce (which can be enabled independently) gets broken after
> >> >> migration.
> >> >> 
> >> >> Switch to creating kvmclock QEMU device unconditionally, it seems
> >> >> to always make sense to call KVM_GET_CLOCK/KVM_SET_CLOCK on migration.
> >> >> Use KVM_CAP_ADJUST_CLOCK check instead of CPUID feature bits.
> >> >> 
> >> >> Reported-by: Antoine Damhet <antoine.damhet@blade-group.com>
> >> >> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> >> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> >> ---
> >> >>  hw/i386/kvm/clock.c    | 6 +-----
> >> >>  target/i386/kvm.c      | 5 +++++
> >> >>  target/i386/kvm_i386.h | 1 +
> >> >>  3 files changed, 7 insertions(+), 5 deletions(-)
> >> >> 
> >> >> diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> >> >> index 64283358f91d..526c9ea5172b 100644
> >> >> --- a/hw/i386/kvm/clock.c
> >> >> +++ b/hw/i386/kvm/clock.c
> >> >> @@ -330,11 +330,7 @@ static const TypeInfo kvmclock_info = {
> >> >>  /* Note: Must be called after VCPU initialization. */
> >> >>  void kvmclock_create(void)
> >> >>  {
> >> >> -    X86CPU *cpu = X86_CPU(first_cpu);
> >> >> -
> >> >> -    if (kvm_enabled() &&
> >> >> -        cpu->env.features[FEAT_KVM] & ((1ULL << KVM_FEATURE_CLOCKSOURCE) |
> >> >> -                                       (1ULL << KVM_FEATURE_CLOCKSOURCE2))) {
> >> >> +    if (kvm_enabled() && kvm_has_adjust_clock()) {
> >> >
> >> > Shouldn't the old check used when machine type <= 5.1 in order to avoid
> >> > migration incompatibility ?
> >> 
> >> Hm, when the check fails we just don't create the device and no error is
> >> reported, so even if we have kvmclock data in the migration stream but
> >> fail to create it migration will still succeed, right? (not a migration
> >> expert here :-)
> >
> > When the migration stream is parsed, it'll try and find a "kvmclock"
> > device to pass the data it's reading to; if one doesn't exist it'll
> > fail.
> 
> This may happen with an older machine type when the destination is
> running an unfixed QEMU and the source has the fix, right?

Yes I think so.

> The solution
> would be to introduce a flag for older machine types (or for new ones)
> like 'kvmclock_always'.

Yep sounds the normal answer.
(You might want to try it first to trigger the bug)

> > The other question is in the incoming direction from an older VM;
> > you'll have a kvm clock created here, but you won't load the kvm clock
> > state from the migration stream - what is this clock going to do?
> 
> This is not really a problem I believe: the clock was absent on the
> source and things somehow worked for the guest so even if we don't
> initialize kvmclock properly on the destination nothing bad is expected.

OK.

Dave

> >
> > Dave
> >
> >> >
> >> >>          sysbus_create_simple(TYPE_KVM_CLOCK, -1, NULL);
> >> >>      }
> >> >>  }
> >> >> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> >> >> index 4a8b3a41c1bc..20b31b65307b 100644
> >> >> --- a/target/i386/kvm.c
> >> >> +++ b/target/i386/kvm.c
> >> >> @@ -143,6 +143,11 @@ bool kvm_has_adjust_clock_stable(void)
> >> >>      return (ret == KVM_CLOCK_TSC_STABLE);
> >> >>  }
> >> >>  
> >> >> +bool kvm_has_adjust_clock(void)
> >> >> +{
> >> >> +    return kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
> >> >> +}
> >> >> +
> >> >>  bool kvm_has_exception_payload(void)
> >> >>  {
> >> >>      return has_exception_payload;
> >> >> diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
> >> >> index 064b8798a26c..0fce4e51d2d6 100644
> >> >> --- a/target/i386/kvm_i386.h
> >> >> +++ b/target/i386/kvm_i386.h
> >> >> @@ -34,6 +34,7 @@
> >> >>  
> >> >>  bool kvm_allows_irq0_override(void);
> >> >>  bool kvm_has_smm(void);
> >> >> +bool kvm_has_adjust_clock(void);
> >> >>  bool kvm_has_adjust_clock_stable(void);
> >> >>  bool kvm_has_exception_payload(void);
> >> >>  void kvm_synchronize_all_tsc(void);
> >> >> -- 
> >> >> 2.25.4
> >> >> 
> >> >> 
> >> 
> >> -- 
> >> Vitaly
> >> 
> 
> -- 
> Vitaly
> 
-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


