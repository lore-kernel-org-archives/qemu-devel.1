Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75875C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A51E206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 12:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="in68lKJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A51E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiHFA-0003Uy-E1
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 08:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jiHEC-0002jZ-63
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:50:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43822
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jiHE9-0006oL-Sn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 08:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591620607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9zUyJQbTN7z5xayV9m/MH6EG2YWZ+vxnjzp1Io97cq0=;
 b=in68lKJ/Hk05IiJ9Fq0x+mHiGa3u6EzUVL0HWI2k9pTMdD+kxH/tBEckLgesQbLPXJuMos
 zrSLvzqU2I7g0RHk0JWQMj/MRtz0YKAdrzoMPRui9vIn1FOMTc+eqo4kf4Csd4S9uFXq5N
 OVs5VJvZsjWXqm0v8ZMhp7gqm2FIvDk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-XUtcbW9RMtW01oerjW7hyg-1; Mon, 08 Jun 2020 08:50:02 -0400
X-MC-Unique: XUtcbW9RMtW01oerjW7hyg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BCF8461;
 Mon,  8 Jun 2020 12:50:01 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4349910013D0;
 Mon,  8 Jun 2020 12:49:56 +0000 (UTC)
Date: Mon, 8 Jun 2020 14:49:52 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [PATCH v3] target/arm/cpu: adjust virtual time for arm cpu
Message-ID: <20200608124952.lwmko6hmtuckbnlw@kamzik.brq.redhat.com>
References: <20200608121243.2076-1-fangying1@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20200608121243.2076-1-fangying1@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 wu.wubin@huawei.com, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 08, 2020 at 08:12:43PM +0800, Ying Fang wrote:
> From: fangying <fangying1@huawei.com>
> 
> Virtual time adjustment was implemented for virt-5.0 machine type,
> but the cpu property was enabled only for host-passthrough and
> max cpu model. Let's add it for arm cpu which has the generic timer
> feature enabled.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>

This isn't true. I did suggest the way to arrange the code, after
Peter suggested to move the kvm_arm_add_vcpu_properties() call to
arm_cpu_post_init(), but I didn't suggest making this change in general,
which is what this tag means. In fact, I've argued that it's pretty
pointless to do this, since KVM users should be using '-cpu host' or
'-cpu max' anyway. Since I don't need credit for the code arranging,
please just drop the tag. Peter can maybe do that on merge though. Also,
despite not agreeing that we need this change today, as there's nothing
wrong with it and it looks good to me

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew

> Signed-off-by: Ying Fang <fangying1@huawei.com>
> 
> ---
> v3:
> - set kvm-no-adjvtime property in kvm_arm_add_vcpu_properties
> 
> v2:
> - move kvm_arm_add_vcpu_properties into arm_cpu_post_init
> 
> v1:
> - initial commit
> - https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08518.html
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 32bec156f2..5b7a36b5d7 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1245,6 +1245,10 @@ void arm_cpu_post_init(Object *obj)
>      if (arm_feature(&cpu->env, ARM_FEATURE_GENERIC_TIMER)) {
>          qdev_property_add_static(DEVICE(cpu), &arm_cpu_gt_cntfrq_property);
>      }
> +
> +    if (kvm_enabled()) {
> +        kvm_arm_add_vcpu_properties(obj);
> +    }
>  }
>  
>  static void arm_cpu_finalizefn(Object *obj)
> @@ -2029,7 +2033,6 @@ static void arm_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        kvm_arm_add_vcpu_properties(obj);
>      } else {
>          cortex_a15_initfn(obj);
>  
> @@ -2183,7 +2186,6 @@ static void arm_host_initfn(Object *obj)
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
>      }
> -    kvm_arm_add_vcpu_properties(obj);
>      arm_cpu_post_init(obj);
>  }
>  
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index cbc5c3868f..778cecc2e6 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -592,7 +592,6 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        kvm_arm_add_vcpu_properties(obj);
>      } else {
>          uint64_t t;
>          uint32_t u;
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 4bdbe6dcac..eef3bbd1cc 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -194,17 +194,18 @@ static void kvm_no_adjvtime_set(Object *obj, bool value, Error **errp)
>  /* KVM VCPU properties should be prefixed with "kvm-". */
>  void kvm_arm_add_vcpu_properties(Object *obj)
>  {
> -    if (!kvm_enabled()) {
> -        return;
> -    }
> +    ARMCPU *cpu = ARM_CPU(obj);
> +    CPUARMState *env = &cpu->env;
>  
> -    ARM_CPU(obj)->kvm_adjvtime = true;
> -    object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
> -                             kvm_no_adjvtime_set);
> -    object_property_set_description(obj, "kvm-no-adjvtime",
> -                                    "Set on to disable the adjustment of "
> -                                    "the virtual counter. VM stopped time "
> -                                    "will be counted.");
> +    if (arm_feature(env, ARM_FEATURE_GENERIC_TIMER)) {
> +        cpu->kvm_adjvtime = true;
> +        object_property_add_bool(obj, "kvm-no-adjvtime", kvm_no_adjvtime_get,
> +                                 kvm_no_adjvtime_set);
> +        object_property_set_description(obj, "kvm-no-adjvtime",
> +                                        "Set on to disable the adjustment of "
> +                                        "the virtual counter. VM stopped time "
> +                                        "will be counted.");
> +    }
>  }
>  
>  bool kvm_arm_pmu_supported(CPUState *cpu)
> -- 
> 2.23.0
> 
> 


