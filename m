Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C660AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 833AB2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTFl/c6L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 833AB2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5XVm-0001lB-Nx
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 12:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5XTS-0000Fl-6r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:50:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56435
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5XTP-0003EW-QV
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 12:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597164602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PzPA2ZMDExgUN38xf0J24vMOrGNObxbKrt9vOHFlUo=;
 b=hTFl/c6LUjupfSBJEF29C/6/R4I6/S/HJBjwtg0nPPhdZ7gRl4MRCc4Lwy8iMWrSqdXsJL
 giR5hpFgccU9WoBqbT9kJEzb722OqKrK+oHq3HokyCskRM95KYtAU+bUhqcjZ444aHK8M8
 jFbv7YYf5hC/iHOlr9YEtBZp11qXgPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-2qvoDm5VNQa9CcSlhyiHTw-1; Tue, 11 Aug 2020 12:49:59 -0400
X-MC-Unique: 2qvoDm5VNQa9CcSlhyiHTw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7785B102C803;
 Tue, 11 Aug 2020 16:49:58 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3795610016E8;
 Tue, 11 Aug 2020 16:49:57 +0000 (UTC)
Date: Tue, 11 Aug 2020 18:49:54 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH 7/7] target/arm/cpu: spe: Enable spe to work with host cpu
Message-ID: <20200811164954.s2sdjzpqpdh2orks@kamzik.brq.redhat.com>
References: <cover.1596768588.git.haibo.xu@linaro.org>
 <bf909c1f4904a22be0804cae9fd6f38ba4862563.1596768588.git.haibo.xu@linaro.org>
 <20200810111640.ykejphmuyirncjwv@kamzik.brq.redhat.com>
 <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1F_vFdJuy2kZnj0gZSOd_8-=rSfWFHjQSPU5XEKQ2KZkg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/11 10:41:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 11, 2020 at 11:15:42AM +0800, Haibo Xu wrote:
> > > +    if (!cpu->has_spe || !kvm_enabled()) {
> > > +        unset_feature(env, ARM_FEATURE_SPE);
> > > +    }
> >
> > I don't think this should be necessary.
> >
> 
> Yes, I have tried to remove this check, and the vSPE can still work
> correctly.
> But I don't know whether there are some corner cases that trigger an error.
> The similar logic is added in commit 929e754d5a to enable vPMU support.

I think the PMU logic needs a cleanup, rather than to be imitated.

> 
> > > +
> > >      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> > >          /* Disable the hypervisor feature bits in the processor feature
> > >           * registers if we don't have EL2. These are id_pfr1[15:12] and
> > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > index be045ccc5f..4ea58afc1d 100644
> > > --- a/target/arm/kvm64.c
> > > +++ b/target/arm/kvm64.c
> > > @@ -679,6 +679,7 @@ bool
> kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
> > >      features |= 1ULL << ARM_FEATURE_AARCH64;
> > >      features |= 1ULL << ARM_FEATURE_PMU;
> > >      features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
> > > +    features |= 1ULL << ARM_FEATURE_SPE;
> >
> > No, SPE is not a feature we assume is present in v8.0 CPUs.
> >
> 
> Yes, SPE is an optional feature for v8.2. How about changing to the
> following logic:
> 
> spe_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SPE_V1)
> > 0;
> if (spe_supported) {
>     features |= 1ULL << ARM_FEATURE_SPE;
> }

Yes, except you need to drop the ARM_FEATURE_SPE define and use the ID
register bit instead like "sve_supported" does.

> 
> > >
> > >      ahcf->features = features;
> > >
> > > @@ -826,6 +827,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > >      } else {
> > >          env->features &= ~(1ULL << ARM_FEATURE_PMU);
> > >      }
> > > +    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_SPE_V1)) {
> > > +        cpu->has_spe = false;
> > > +    }
> > > +    if (cpu->has_spe) {
> > > +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
> > > +    } else {
> > > +        env->features &= ~(1ULL << ARM_FEATURE_SPE);
> > > +    }
> >
> > The PMU code above this isn't a good pattern to copy. The SVE code below
> > is better. SVE uses an ID bit and doesn't do the redundant KVM cap check.
> > It'd be nice to cleanup the PMU code (with a separate patch) and then add
> > SPE in a better way.
> >
> 
> I noticed that Peter had sent out a mail
> <https://www.mail-archive.com/qemu-devel@nongnu.org/msg727640.html> to talk
> about the feature-identification strategy.
> So shall we adapt it to the vPMU and vSPE feature?

At least SPE. You'll have to double check that it makes sense to do for
PMU. But, if so, then it should be done with a separate series.

Thanks,
drew


