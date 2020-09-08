Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A7C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:36:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 789DB21741
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T89tCBx5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789DB21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbup-00065z-ID
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbtz-0005PW-IC
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:35:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52015
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbtx-0000li-V5
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599564905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CH7yjQyNRgW+ZBkO+ZLU5ukDSXEg0SqcvPWAV6CIDN0=;
 b=T89tCBx5g8k9i7sl7umuERbRukUrKmGdw9I1kpA8if4NmKVM75pc8HV/yQ4n99Dtjvm2NS
 InpzI4QzFv2SFH70V6g1loRum7gXZ3txGs5LPFKagyGzih5050xxXkEmkmIbF/RjiQ0fH2
 FGtTyZH0Gww3DplaggXMJB3eOUPq5Gg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-kRBSe7UCNUmNDeZ1R21qmg-1; Tue, 08 Sep 2020 07:35:03 -0400
X-MC-Unique: kRBSe7UCNUmNDeZ1R21qmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F1AC18BA280;
 Tue,  8 Sep 2020 11:35:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC67D60DA0;
 Tue,  8 Sep 2020 11:35:00 +0000 (UTC)
Date: Tue, 8 Sep 2020 13:34:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 11/12] target/arm/kvm: spe: Enable userspace irqchip
 support.
Message-ID: <20200908113458.2fdhbs7lpw63fvnv@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <6aaa406b824d0c427acbc3f3abfbbe841f3bb93c.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <6aaa406b824d0c427acbc3f3abfbbe841f3bb93c.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 08, 2020 at 08:13:29AM +0000, Haibo Xu wrote:
> Since the current kernel patches haven't enabled the
> userspace irqchip support, this patch is not verified yet!
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  linux-headers/linux/kvm.h | 1 +
>  target/arm/kvm.c          | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index 8840cbb01c..35ef0ae842 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1672,6 +1672,7 @@ struct kvm_assigned_msix_entry {
>  #define KVM_ARM_DEV_EL1_VTIMER		(1 << 0)
>  #define KVM_ARM_DEV_EL1_PTIMER		(1 << 1)
>  #define KVM_ARM_DEV_PMU			(1 << 2)
> +#define KVM_ARM_DEV_SPE			(1 << 3)

kernel header changes should be separate patches

>  
>  struct kvm_hyperv_eventfd {
>  	__u32 conn_id;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 58f991e890..7950ff1d83 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -820,6 +820,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
>              switched_level &= ~KVM_ARM_DEV_PMU;
>          }
>  
> +        if (switched_level & KVM_ARM_DEV_SPE) {
> +            qemu_set_irq(cpu->spe_interrupt,
> +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
> +            switched_level &= ~KVM_ARM_DEV_SPE;
> +        }
>          if (switched_level) {
>              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
>                            __func__, switched_level);
> -- 
> 2.17.1
> 

Otherwise 

Reviewed-by: Andrew Jones <drjones@redhat.com>


