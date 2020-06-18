Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A7420B1F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 08:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGQpmxwF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A7420B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlqND-0001kq-PC
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 04:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jlqMb-0001C7-V1
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:57:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56179
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jlqMY-0005aN-SQ
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 04:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592470653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wqDesyDEKvVE0arFjXLzrboQB8n4OlGRbAZdAmnqecc=;
 b=IGQpmxwFGysMzJa7mSrntR4WU6ki38FxpCCqtpLP58lFxER7SF10sW0xPtw36MsgbL15Es
 ZZ/nsrgI+UPDQjXpSygocaurea7lUMHqFBYS0J/PcSFNLMf0jltTaAgMOdF32ze8/Ju6GF
 OyUWscMV1PkufoifnWwOYRfpzAJyv28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-nDrm9QDzPK-zvyR-WUdb0Q-1; Thu, 18 Jun 2020 04:57:31 -0400
X-MC-Unique: nDrm9QDzPK-zvyR-WUdb0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83ECE107ACCA;
 Thu, 18 Jun 2020 08:57:30 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.195.14])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E31285D9D3;
 Thu, 18 Jun 2020 08:57:28 +0000 (UTC)
Date: Thu, 18 Jun 2020 10:57:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/arm/kvm: Check supported feature per accelerator
 (not per vCPU)
Message-ID: <20200618085726.ti2hny6554l4l5kt@kamzik.brq.redhat.com>
References: <20200617130800.26355-1-philmd@redhat.com>
 <20200617152319.l77b4kdzwcftx7by@kamzik.brq.redhat.com>
 <69f9adc8-28ec-d949-60aa-ba760ea210a9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69f9adc8-28ec-d949-60aa-ba760ea210a9@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Haibo Xu <haibo.xu@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 07:37:42PM +0200, Paolo Bonzini wrote:
> On 17/06/20 17:23, Andrew Jones wrote:
> >>
> >> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
> >> argument (already realized/valid at this point) instead of a
> >> CPUState argument.
> > I'd rather not do that. IMO, a CPU feature test should operate on CPU,
> > not an "accelerator".
> 
> If it's a test that the feature is enabled (e.g. via -cpu) then I agree.  
> For something that ends up as a KVM_CHECK_EXTENSION or KVM_ENABLE_CAP on 
> the KVM fd, however, I think passing an AccelState is better.

I can live with that justification as long as we don't support
heterogeneous VCPU configurations. And, if that ever happens, then I
guess we'll be reworking a lot more than just the interface of these
cpu feature probes.

Thanks,
drew


> kvm_arm_pmu_supported case is clearly the latter, even the error message
> hints at that:
> 
> +        if (kvm_enabled() && !kvm_arm_pmu_supported(current_accel())) {
>              error_setg(errp, "'pmu' feature not supported by KVM on this host");
>              return;
>          }
> 
> but the same is true of kvm_arm_aarch32_supported and kvm_arm_sve_supported.
> 
> Applying the change to kvm_arm_pmu_supported as you suggest below would be
> a bit of a bandaid because it would not have consistent prototypes.  Sp
> for Philippe's patch
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Thanks,
> 
> Paolo
> 
> > How that test is implemented is another story.
> > If the CPUState isn't interesting, but it points to something that is,
> > or there's another function that uses globals to get the job done, then
> > fine, but the callers of a CPU feature test shouldn't need to know that.
> > 
> > I think we should just revert d70c996df23f and then apply the same
> > change to kvm_arm_pmu_supported() that other similar functions got
> > with 4f7f589381d5.
> 
> 


