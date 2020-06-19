Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E221C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E11D207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bt+04yyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E11D207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFne-0005Jb-4d
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmFip-0005yM-FU
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39232
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jmFim-0006fW-OK
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XuVUEB/HHj+ZCH96gGwr17u9+WvD8C9D+pqMxPSv6Dg=;
 b=bt+04yyXIlfkuLslO8DReN0VOew0Nv8CtwYyaTy0jXAoxZ9unSugtPsd4VXjgzsQpv52Ry
 iizvVeEVHYDFaOG/UEwc5+GJj3j6Qd90rXG+TvWh69B8Cki5JSaIa1mcs3wbLRR51JMEmD
 dx+NLSBy7pVMb9ZrSNbcGY42j74UF+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-zchMHTCUONqyecVqXWvy8Q-1; Fri, 19 Jun 2020 08:02:10 -0400
X-MC-Unique: zchMHTCUONqyecVqXWvy8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 196C318FE866;
 Fri, 19 Jun 2020 12:02:09 +0000 (UTC)
Received: from work-vm (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5141C5BAC9;
 Fri, 19 Jun 2020 12:02:05 +0000 (UTC)
Date: Fri, 19 Jun 2020 13:02:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] target/arm: Check supported KVM features globally
 (not per vCPU)
Message-ID: <20200619120202.GH2690@work-vm>
References: <20200619095542.2095-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619095542.2095-1-philmd@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 03:15:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Haibo Xu <haibo.xu@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daudé (philmd@redhat.com) wrote:
> Since commit d70c996df23f, when enabling the PMU we get:
> 
>   $ qemu-system-aarch64 -cpu host,pmu=on -M virt,accel=kvm,gic-version=3
>   Segmentation fault (core dumped)
> 
>   Thread 1 "qemu-system-aar" received signal SIGSEGV, Segmentation fault.
>   0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>   2588        ret = ioctl(s->fd, type, arg);
>   (gdb) bt
>   #0  0x0000aaaaaae356d0 in kvm_ioctl (s=0x0, type=44547) at accel/kvm/kvm-all.c:2588
>   #1  0x0000aaaaaae31568 in kvm_check_extension (s=0x0, extension=126) at accel/kvm/kvm-all.c:916
>   #2  0x0000aaaaaafce254 in kvm_arm_pmu_supported (cpu=0xaaaaac214ab0) at target/arm/kvm.c:213
>   #3  0x0000aaaaaafc0f94 in arm_set_pmu (obj=0xaaaaac214ab0, value=true, errp=0xffffffffe438) at target/arm/cpu.c:1111
>   #4  0x0000aaaaab5533ac in property_set_bool (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", opaque=0xaaaaac222730, errp=0xffffffffe438) at qom/object.c:2170
>   #5  0x0000aaaaab5512f0 in object_property_set (obj=0xaaaaac214ab0, v=0xaaaaac223a80, name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1328
>   #6  0x0000aaaaab551e10 in object_property_parse (obj=0xaaaaac214ab0, string=0xaaaaac11b4c0 "on", name=0xaaaaac11a970 "pmu", errp=0xffffffffe438) at qom/object.c:1561
>   #7  0x0000aaaaab54ee8c in object_apply_global_props (obj=0xaaaaac214ab0, props=0xaaaaac018e20, errp=0xaaaaabd6fd88 <error_fatal>) at qom/object.c:407
>   #8  0x0000aaaaab1dd5a4 in qdev_prop_set_globals (dev=0xaaaaac214ab0) at hw/core/qdev-properties.c:1218
>   #9  0x0000aaaaab1d9fac in device_post_init (obj=0xaaaaac214ab0) at hw/core/qdev.c:1050
>   ...
>   #15 0x0000aaaaab54f310 in object_initialize_with_type (obj=0xaaaaac214ab0, size=52208, type=0xaaaaabe237f0) at qom/object.c:512
>   #16 0x0000aaaaab54fa24 in object_new_with_type (type=0xaaaaabe237f0) at qom/object.c:687
>   #17 0x0000aaaaab54fa80 in object_new (typename=0xaaaaabe23970 "host-arm-cpu") at qom/object.c:702
>   #18 0x0000aaaaaaf04a74 in machvirt_init (machine=0xaaaaac0a8550) at hw/arm/virt.c:1770
>   #19 0x0000aaaaab1e8720 in machine_run_board_init (machine=0xaaaaac0a8550) at hw/core/machine.c:1138
>   #20 0x0000aaaaaaf95394 in qemu_init (argc=5, argv=0xffffffffea58, envp=0xffffffffea88) at softmmu/vl.c:4348
>   #21 0x0000aaaaaada3f74 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at softmmu/main.c:48
> 
> This is because in frame #2, cpu->kvm_state is still NULL
> (the vCPU is not yet realized).
> 
> KVM has a hard requirement of all cores supporting the same
> feature set. We only need to check if the accelerator supports
> a feature, not each vCPU individually.
> 
> Fix by kvm_arm_<FEATURE>_supported() functions take a AccelState
> argument (already realized/valid at this point) instead of a
> CPUState argument.
> 
> Reported-by: Haibo Xu <haibo.xu@linaro.org>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Use global kvm_state (bonzini)
> 
> Paolo, does this break migration of encrypted memory assumptions?
> 
> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Supersedes: <20200617130800.26355-1-philmd@redhat.com>

I'm not seeing the relevance to migration.

Dave

> ---
>  target/arm/kvm_arm.h | 21 +++++++++------------
>  target/arm/cpu.c     |  2 +-
>  target/arm/cpu64.c   | 10 +++++-----
>  target/arm/kvm.c     |  4 ++--
>  target/arm/kvm64.c   | 14 +++++---------
>  5 files changed, 22 insertions(+), 29 deletions(-)
> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 48bf5e16d5..a4ce4fd93d 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -269,29 +269,26 @@ void kvm_arm_add_vcpu_properties(Object *obj);
>  
>  /**
>   * kvm_arm_aarch32_supported:
> - * @cs: CPUState
>   *
> - * Returns: true if the KVM VCPU can enable AArch32 mode
> + * Returns: true if KVM can enable AArch32 mode
>   * and false otherwise.
>   */
> -bool kvm_arm_aarch32_supported(CPUState *cs);
> +bool kvm_arm_aarch32_supported(void);
>  
>  /**
>   * kvm_arm_pmu_supported:
> - * @cs: CPUState
>   *
> - * Returns: true if the KVM VCPU can enable its PMU
> + * Returns: true if KVM can enable the PMU
>   * and false otherwise.
>   */
> -bool kvm_arm_pmu_supported(CPUState *cs);
> +bool kvm_arm_pmu_supported(void);
>  
>  /**
>   * kvm_arm_sve_supported:
> - * @cs: CPUState
>   *
> - * Returns true if the KVM VCPU can enable SVE and false otherwise.
> + * Returns true if KVM can enable SVE and false otherwise.
>   */
> -bool kvm_arm_sve_supported(CPUState *cs);
> +bool kvm_arm_sve_supported(void);
>  
>  /**
>   * kvm_arm_get_max_vm_ipa_size:
> @@ -359,17 +356,17 @@ static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>  
>  static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
>  
> -static inline bool kvm_arm_aarch32_supported(CPUState *cs)
> +static inline bool kvm_arm_aarch32_supported(void)
>  {
>      return false;
>  }
>  
> -static inline bool kvm_arm_pmu_supported(CPUState *cs)
> +static inline bool kvm_arm_pmu_supported(void)
>  {
>      return false;
>  }
>  
> -static inline bool kvm_arm_sve_supported(CPUState *cs)
> +static inline bool kvm_arm_sve_supported(void)
>  {
>      return false;
>  }
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 5b7a36b5d7..e44e18062c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1108,7 +1108,7 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
>      ARMCPU *cpu = ARM_CPU(obj);
>  
>      if (value) {
> -        if (kvm_enabled() && !kvm_arm_pmu_supported(CPU(cpu))) {
> +        if (kvm_enabled() && !kvm_arm_pmu_supported()) {
>              error_setg(errp, "'pmu' feature not supported by KVM on this host");
>              return;
>          }
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 778cecc2e6..a0c1d8894b 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -266,7 +266,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>  
>      /* Collect the set of vector lengths supported by KVM. */
>      bitmap_zero(kvm_supported, ARM_MAX_VQ);
> -    if (kvm_enabled() && kvm_arm_sve_supported(CPU(cpu))) {
> +    if (kvm_enabled() && kvm_arm_sve_supported()) {
>          kvm_arm_sve_get_vls(CPU(cpu), kvm_supported);
>      } else if (kvm_enabled()) {
>          assert(!cpu_isar_feature(aa64_sve, cpu));
> @@ -473,7 +473,7 @@ static void cpu_max_set_sve_max_vq(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    if (kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +    if (kvm_enabled() && !kvm_arm_sve_supported()) {
>          error_setg(errp, "cannot set sve-max-vq");
>          error_append_hint(errp, "SVE not supported by KVM on this host\n");
>          return;
> @@ -519,7 +519,7 @@ static void cpu_arm_set_sve_vq(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
>          error_setg(errp, "cannot enable %s", name);
>          error_append_hint(errp, "SVE not supported by KVM on this host\n");
>          return;
> @@ -556,7 +556,7 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    if (value && kvm_enabled() && !kvm_arm_sve_supported(CPU(cpu))) {
> +    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
>          error_setg(errp, "'sve' feature not supported by KVM on this host");
>          return;
>      }
> @@ -751,7 +751,7 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
>       * uniform execution state like do_interrupt.
>       */
>      if (value == false) {
> -        if (!kvm_enabled() || !kvm_arm_aarch32_supported(CPU(cpu))) {
> +        if (!kvm_enabled() || !kvm_arm_aarch32_supported()) {
>              error_setg(errp, "'aarch64' feature cannot be disabled "
>                               "unless KVM is enabled and 32-bit EL1 "
>                               "is supported");
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index eef3bbd1cc..7c672c78b8 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -208,9 +208,9 @@ void kvm_arm_add_vcpu_properties(Object *obj)
>      }
>  }
>  
> -bool kvm_arm_pmu_supported(CPUState *cpu)
> +bool kvm_arm_pmu_supported(void)
>  {
> -    return kvm_check_extension(cpu->kvm_state, KVM_CAP_ARM_PMU_V3);
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_PMU_V3);
>  }
>  
>  int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index f09ed9f4df..3dc494aaa7 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -652,18 +652,14 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>      return true;
>  }
>  
> -bool kvm_arm_aarch32_supported(CPUState *cpu)
> +bool kvm_arm_aarch32_supported(void)
>  {
> -    KVMState *s = KVM_STATE(current_accel());
> -
> -    return kvm_check_extension(s, KVM_CAP_ARM_EL1_32BIT);
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_EL1_32BIT);
>  }
>  
> -bool kvm_arm_sve_supported(CPUState *cpu)
> +bool kvm_arm_sve_supported(void)
>  {
> -    KVMState *s = KVM_STATE(current_accel());
> -
> -    return kvm_check_extension(s, KVM_CAP_ARM_SVE);
> +    return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
>  }
>  
>  QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
> @@ -798,7 +794,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
>          env->features &= ~(1ULL << ARM_FEATURE_PMU);
>      }
>      if (cpu_isar_feature(aa64_sve, cpu)) {
> -        assert(kvm_arm_sve_supported(cs));
> +        assert(kvm_arm_sve_supported());
>          cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_SVE;
>      }
>  
> -- 
> 2.21.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


