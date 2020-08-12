Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3582C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6BF2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhEF1pxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6BF2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5nyj-0006Kp-Kq
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5nxz-0005n1-1T
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:26:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5nxw-0004YT-HO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LeoH579yIlvqbo9BdYkGUtcrLYiZxYC+3+AjxHS+R38=;
 b=IhEF1pxX8j0yM83A7ytNbvuz2pZGr3kaUb37dtaOpqugX2CN6RYJnLi7BzFDBGXevQ3OFK
 gk63hhtXtGqEdtE5/s6n3Xpwzsu1HqS+icrh60oM3G9J0j/EMv2retMJQP1JlKb45cNItz
 6Oj+yN0nf/8XFByWLBNzUJiuNjzH/OU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-zTYkTZT3PoaqLLGsiP1Wxg-1; Wed, 12 Aug 2020 06:26:38 -0400
X-MC-Unique: zTYkTZT3PoaqLLGsiP1Wxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2765C106B242;
 Wed, 12 Aug 2020 10:26:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 12BFF5D6BD;
 Wed, 12 Aug 2020 10:26:31 +0000 (UTC)
Date: Wed, 12 Aug 2020 12:26:24 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 2/5] target/arm/kvm: Make uncalled stubs explicitly
 unreachable
Message-ID: <20200812102624.zali24olzg5zeqqd@kamzik.brq.redhat.com>
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-3-drjones@redhat.com>
 <b26a7bf5-ad7c-9376-78ab-600b7ea9fed8@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b26a7bf5-ad7c-9376-78ab-600b7ea9fed8@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 04:27:07
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 12:16:43PM +0200, Auger Eric wrote:
> Hi Drew,
> 
> On 8/5/20 11:16 AM, Andrew Jones wrote:
> > When we compile without KVM support !defined(CONFIG_KVM) we generate
> > stubs for functions that the linker will still encounter. Sometimes
> > these stubs can be executed safely and are placed in paths where they
> > get executed with or without KVM. Other functions should never be
> > called without KVM. Those functions should be guarded by kvm_enabled(),
> > but should also be robust to refactoring mistakes. Putting a
> > g_assert_not_reached() in the function should help. Additionally,
> > the g_assert_not_reached() calls may actually help the linker remove
> > some code.
> > 
> > We remove the stubs for kvm_arm_get/put_virtual_time(), as they aren't
> > necessary at all - the only caller is in kvm.c
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  target/arm/kvm_arm.h | 44 +++++++++++++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 17 deletions(-)
> > 
> > diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> > index adb38514bf20..0da00eb6b20c 100644
> > --- a/target/arm/kvm_arm.h
> > +++ b/target/arm/kvm_arm.h
> > @@ -344,16 +344,10 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
> >  
> >  #else
> >  
> > -static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> > -{
> > -    /*
> > -     * This should never actually be called in the "not KVM" case,
> > -     * but set up the fields to indicate an error anyway.
> > -     */
> > -    cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
> > -    cpu->host_cpu_probe_failed = true;
> > -}
> > -
> > +/*
> > + * It's safe to call these functions without KVM support.
> > + * They should either do nothing or return "not supported".
> > + */
> >  static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
> this one also is guarded by kvm_enabled() in target/arm/cpu.c
> don't you want to add g_assert_not_reached()?

Yes, that would make sense. I'll do that for v3.

> >  
> >  static inline bool kvm_arm_aarch32_supported(void)
> > @@ -371,23 +365,39 @@ static inline bool kvm_arm_sve_supported(void)
> >      return false;
> >  }
> >  
> > +/*
> > + * These functions should never actually be called without KVM support.
> > + */
> > +static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> >  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
> >  {
> > -    return -ENOENT;
> > +    g_assert_not_reached();
> >  }
> >  
> >  static inline int kvm_arm_vgic_probe(void)
> >  {
> > -    return 0;
> > +    g_assert_not_reached();
> >  }
> >  
> > -static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
> > -static inline void kvm_arm_pmu_init(CPUState *cs) {}
> > +static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> > +{
> > +    g_assert_not_reached();
> > +}
> >  
> > -static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
> > +static inline void kvm_arm_pmu_init(CPUState *cs)
> > +{
> > +    g_assert_not_reached();
> > +}
> > +
> > +static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
> > +{
> > +    g_assert_not_reached();
> > +}
> >  
> > -static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
> > -static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
> >  #endif
> >  
> >  static inline const char *gic_class_name(void)
> > 
> 
> Besides,
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks,
drew


