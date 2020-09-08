Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF75BC43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28FCC21532
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf6RNWjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FCC21532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFbse-0004mx-DU
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 07:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbs4-000422-99
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:33:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58545
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kFbs0-0000VO-K9
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 07:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599564783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ULBwfiITgvP0PMMbu6gRU7ITRT+vhl+4mDhD2Lj5GlA=;
 b=Jf6RNWjya9J1gh0nDphGJcMh3CEVV0I2Ym+1dq7QXdwEKiePUZQrA4+RWi11IghpxpPqCR
 0xmGRjpXHohZt1sGLyc4769N31ywsQJL8Rw5WYdoniQkHy3iGhbeKL6Hb1aoXbFQ2/qAXj
 NnDzSENJkkXkEellwx6PHgwPZYliJfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-Z9MjkeUiPruqx2hBLtXS6g-1; Tue, 08 Sep 2020 07:33:01 -0400
X-MC-Unique: Z9MjkeUiPruqx2hBLtXS6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EBD1802B61;
 Tue,  8 Sep 2020 11:33:00 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EA1C9CBA;
 Tue,  8 Sep 2020 11:32:55 +0000 (UTC)
Date: Tue, 8 Sep 2020 13:32:53 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v2 10/12] target/arm/cpu: spe: Enable spe to work with
 host cpu
Message-ID: <20200908113253.b6owlcu62hypp6aw@kamzik.brq.redhat.com>
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <26b4ace9ea3c5b43d14802d6fc5ceea90befbcc8.1599549462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <26b4ace9ea3c5b43d14802d6fc5ceea90befbcc8.1599549462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
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

On Tue, Sep 08, 2020 at 08:13:28AM +0000, Haibo Xu wrote:
> Turn on the spe cpu property by default if host cpu
> support it, i.e. we can now do '-cpu max|host' to add
> the vSPE, and '-cpu max|host,spe=off' to remove it.
> 
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  target/arm/cpu.c   |  3 +++
>  target/arm/cpu.h   |  2 ++
>  target/arm/cpu64.c |  7 ++++++-
>  target/arm/kvm64.c | 12 ++++++++++++
>  4 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 786cc6134c..58f12d6eb5 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2271,6 +2271,9 @@ static void arm_host_initfn(Object *obj)
>      kvm_arm_set_cpu_features_from_host(cpu);
>      if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
>          aarch64_add_sve_properties(obj);
> +
> +        cpu->has_spe = ON_OFF_AUTO_AUTO;
> +        aarch64_add_spe_properties(obj);

Why not put the assignment of has_spe into aarch64_add_spe_properties()?

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
> index 4997c4a3c0..d38c55e2ca 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -621,6 +621,11 @@ static void arm_spe_set(Object *obj, bool value, Error **errp)
>      ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>  }
>  
> +void aarch64_add_spe_properties(Object *obj)
> +{
> +    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -772,7 +777,7 @@ static void aarch64_max_initfn(Object *obj)
>                          cpu_max_set_sve_max_vq, NULL, NULL);
>  
>      cpu->has_spe = ON_OFF_AUTO_AUTO;
> -    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
> +    aarch64_add_spe_properties(obj);

If TCG doesn't support this cpu feature then this should be in the
kvm_enabled() part of this function.


>  }
>  
>  static const ARMCPUInfo aarch64_cpus[] = {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index 5a2032fc9e..3f0a09c05b 100644
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
> +    if (!spe_supported) {
> +        t = ahcf->isar.id_aa64dfr0;
> +        t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, 0);
> +        ahcf->isar.id_aa64dfr0 = t;
> +    }
> 

If this works then there's a bug with the KVM implementation. get-one-reg
shouldn't expose SPE unless userspace has enabled it, which we're not
doing on the scratch vcpu. That's why we set, not clear, the ID bits for
SVE.

 
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

Thanks,
drew


