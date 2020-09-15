Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ADEC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B1E02076C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEeUR79P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B1E02076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4VT-0000Cu-JA
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI4UP-0007oQ-2N
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:30:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59995
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI4UM-0006AT-Vj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600151450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2WTrRHSPDlolkAGT7SYc//RQuVXkp30lSQQRzG1Qxs=;
 b=PEeUR79PtcFzSNN9z86G9hGScj93hFVp5u4pYOE2fe/0upXecjQExTnVZD20sXdVIaRPa7
 rPxCS3tT6Z7AtDhL1nF6hyUshLFtkoBfs246aRNagaBKlWTVmlFAbxGQQL7wf7G2fIfPL7
 su2Iwcjfa5zJ1UiS66zxI0cvZEUNlCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-x_NHtQacMXm8qa-yHrdi5A-1; Tue, 15 Sep 2020 02:30:48 -0400
X-MC-Unique: x_NHtQacMXm8qa-yHrdi5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37CA61091064;
 Tue, 15 Sep 2020 06:30:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87BC65DD6E;
 Tue, 15 Sep 2020 06:30:45 +0000 (UTC)
Date: Tue, 15 Sep 2020 08:30:42 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v3 10/12] target/arm/cpu: spe: Enable spe to work with
 host cpu
Message-ID: <20200915063042.wy63x4hyzavaibvf@kamzik.brq.redhat.com>
References: <cover.1600135462.git.haibo.xu@linaro.org>
 <b9c848142d25ce4556fe14fc60a4bc73dd1683d2.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b9c848142d25ce4556fe14fc60a4bc73dd1683d2.1600135462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:14:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 03:11:46AM +0000, Haibo Xu wrote:
> Turn on the spe cpu property by default if host cpu
> support it, i.e. we can now do '-cpu max|host' to add
> the vSPE, and '-cpu max|host,spe=off' to remove it.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  target/arm/cpu.c   |  1 +
>  target/arm/cpu.h   |  2 ++
>  target/arm/cpu64.c | 10 +++++++---
>  target/arm/kvm64.c | 12 ++++++++++++
>  4 files changed, 22 insertions(+), 3 deletions(-)


Reviewed-by: Andrew Jones <drjones@redhat.com>

> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 786cc6134c..05a4b7d208 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2271,6 +2271,7 @@ static void arm_host_initfn(Object *obj)
>      kvm_arm_set_cpu_features_from_host(cpu);
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
> +        aarch64_add_spe_properties(obj);
>      }
>      arm_cpu_post_init(obj);
>  }
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 395a1e5df8..5a3ea876c8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1040,6 +1040,7 @@ void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64);
>  void aarch64_add_sve_properties(Object *obj);
> +void aarch64_add_spe_properties(Object *obj);
>  
>  /*
>   * SVE registers are encoded in KVM's memory in an endianness-invariant format.
> @@ -1071,6 +1072,7 @@ static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>                                           int n, bool a)
>  { }
>  static inline void aarch64_add_sve_properties(Object *obj) { }
> +static inline void aarch64_add_spe_properties(Object *obj) { }
>  #endif
>  
>  #if !defined(CONFIG_TCG)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 4997c4a3c0..04daeb901d 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -621,6 +621,12 @@ static void arm_spe_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>  
> +void aarch64_add_spe_properties(Object *obj)
> +{
> +    ARM_CPU(obj)->has_spe = ON_OFF_AUTO_AUTO;
> +    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -632,6 +638,7 @@ static void aarch64_max_initfn(Object *obj)
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> +        aarch64_add_spe_properties(obj);
>      } else {
>          uint64_t t;
>          uint32_t u;
> @@ -770,9 +777,6 @@ static void aarch64_max_initfn(Object *obj)
>      aarch64_add_sve_properties(obj);
>      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                          cpu_max_set_sve_max_vq, NULL, NULL);
> -
> -    cpu->has_spe = ON_OFF_AUTO_AUTO;
> -    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
>  }
>  
>  static const ARMCPUInfo aarch64_cpus[] = {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 5a2032fc9e..20269efeff 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -515,6 +515,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       */
>      int fdarray[3];
>      bool sve_supported;
> +    bool spe_supported;
>      uint64_t features = 0;
>      uint64_t t;
>      int err;
> @@ -655,6 +656,8 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      }
>  
>      sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
> +    spe_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION,
> +                                      KVM_CAP_ARM_SPE_V1) > 0;
>  
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);
>  
> @@ -668,6 +671,11 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>          t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
>          ahcf->isar.id_aa64pfr0 = t;
>      }
> +    if (spe_supported) {
> +        t = ahcf->isar.id_aa64dfr0;
> +        t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, 1);
> +        ahcf->isar.id_aa64dfr0 = t;
> +    }
>  
>      /*
>       * We can assume any KVM supporting CPU is at least a v8
> @@ -830,6 +838,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          assert(kvm_arm_sve_supported());
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
> +    if (cpu_isar_feature(aa64_spe, cpu)) {
> +        assert(kvm_arm_spe_supported());
> +        cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SPE_V1;
> +    }
>  
>      /* Do KVM_ARM_VCPU_INIT ioctl */
>      ret = kvm_arm_vcpu_init(cs);
> -- 
> 2.17.1
> 
> 


