Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F8C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:57:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3EF2087C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9suInEh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3EF2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbJr-0007ci-AE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbIo-0006by-I2
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:56:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40378
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbIm-0004T6-VF
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599562600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GIbNL/nVH5BNe+CWhBWkidXimhE+y5MW5kJvjNQ4FpI=;
 b=O9suInEhYvgH3m9zuudSZyfounuCykPLOcwE68FpGofARrI4YFTBkdKtuH5C+XDFYUzBy3
 42ZZEpSqTB0B+lXGL5kxajd3uVkYVS426i4T4YK98wlOE6M3yz2CLvOXk/MJHHJf0fpqwO
 p/zlPZA19S6OGUQuhyBcnn84KFZ49CM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-Uoa5l87BOjOghEpUzOdnbA-1; Tue, 08 Sep 2020 06:56:37 -0400
X-MC-Unique: Uoa5l87BOjOghEpUzOdnbA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA977AF200;
 Tue,  8 Sep 2020 10:56:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A52C82461;
 Tue,  8 Sep 2020 10:56:33 +0000 (UTC)
Date: Tue, 8 Sep 2020 12:56:31 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 05/12] target/arm/kvm: spe: Unify device attr
 operation helper
Message-ID: <20200908105631.etggiu56l65ohlyq@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <45eecae26272efc7a09837573cd5278296b58dc5.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <45eecae26272efc7a09837573cd5278296b58dc5.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 00:33:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 08:13:23AM +0000, Haibo Xu wrote:
> From: Andrew Jones <drjones@redhat.com>
> 
> Rename kvm_arm_pmu_set_attr() to kvm_arm_set_device_attr(),
> So both the vPMU and vSPE device can share the same API.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>

Looks like a faithful port of what I posted as a hunk of another patch, so
I'll accept the authorship. Please also add you s-b though.

Thanks,
drew

> ---
>  target/arm/kvm64.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index ef1e960285..8ffd31ffdf 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -397,19 +397,20 @@ static CPUWatchpoint *find_hw_watchpoint(CPUState *cpu, target_ulong addr)
>      return NULL;
>  }
>  
> -static bool kvm_arm_pmu_set_attr(CPUState *cs, struct kvm_device_attr *attr)
> +static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
> +                                    const char *name)
>  {
>      int err;
>  
>      err = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, attr);
>      if (err != 0) {
> -        error_report("PMU: KVM_HAS_DEVICE_ATTR: %s", strerror(-err));
> +        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
>          return false;
>      }
>  
>      err = kvm_vcpu_ioctl(cs, KVM_SET_DEVICE_ATTR, attr);
>      if (err != 0) {
> -        error_report("PMU: KVM_SET_DEVICE_ATTR: %s", strerror(-err));
> +        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
>          return false;
>      }
>  
> @@ -426,7 +427,7 @@ void kvm_arm_pmu_init(CPUState *cs)
>      if (!ARM_CPU(cs)->has_pmu) {
>          return;
>      }
> -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> +    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
>          error_report("failed to init PMU");
>          abort();
>      }
> @@ -443,7 +444,7 @@ void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
>      if (!ARM_CPU(cs)->has_pmu) {
>          return;
>      }
> -    if (!kvm_arm_pmu_set_attr(cs, &attr)) {
> +    if (!kvm_arm_set_device_attr(cs, &attr, "PMU")) {
>          error_report("failed to set irq for PMU");
>          abort();
>      }
> -- 
> 2.17.1
> 
> 


