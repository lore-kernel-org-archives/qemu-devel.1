Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FFBC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:12:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B921206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/IDAQWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B921206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4Cj-0004M0-DJ
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI4BJ-0003Ol-R4
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:11:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI4BH-0003Zh-L9
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600150266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ehjLp9+ink0kA2VBhO0sRZiYhxp+98C2vbv/FiUj2Nw=;
 b=b/IDAQWmEWd6HDtuiFHtPDR7bEEeyZCyxnJ4yI6sLf/+8AXk7IHyUAL5U6eZDwFnPtPdNt
 Dzec6FUWc4y3hMOEJm5Z2/bsbwpPULM9hRWsVZ5zxJkmUlY2G7L18J/EmP3mwAQKuZCBn/
 RPYqy4ITW9E2dhFJfUb0OGMedzN6Rwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-eV7UwSB4Mkm7Fn3GEQkLeg-1; Tue, 15 Sep 2020 02:11:04 -0400
X-MC-Unique: eV7UwSB4Mkm7Fn3GEQkLeg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBF7A425CD;
 Tue, 15 Sep 2020 06:11:02 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 151FE7B7B3;
 Tue, 15 Sep 2020 06:11:00 +0000 (UTC)
Date: Tue, 15 Sep 2020 08:10:58 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v3 03/12] target/arm/cpu: spe: Add an option to turn
 on/off vSPE support
Message-ID: <20200915061058.zl7dbgmcjh5icu74@kamzik.brq.redhat.com>
References: <cover.1600135462.git.haibo.xu@linaro.org>
 <90fec9ff0da7595f52caccf052c019d9359c8724.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
In-Reply-To: <90fec9ff0da7595f52caccf052c019d9359c8724.1600135462.git.haibo.xu@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
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

On Tue, Sep 15, 2020 at 03:11:39AM +0000, Haibo Xu wrote:
> Adds a spe=[on/off] option to enable/disable vSPE support in
> guest vCPU.
> 
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> ---
>  target/arm/cpu.c   |  6 ++++++
>  target/arm/cpu.h   | 13 ++++++++++++
>  target/arm/cpu64.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index c179e0752d..f211958eaa 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1310,6 +1310,12 @@ void arm_cpu_finalize_features(ARMCPU *cpu, Error **errp)
>              error_propagate(errp, local_err);
>              return;
>          }
> +
> +        arm_cpu_spe_finalize(cpu, &local_err);
> +        if (local_err != NULL) {
> +            error_propagate(errp, local_err);
> +            return;
> +        }
>      }
>  }
>  
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index a1c7d8ebae..baf2bbcee8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -24,6 +24,7 @@
>  #include "hw/registerfields.h"
>  #include "cpu-qom.h"
>  #include "exec/cpu-defs.h"
> +#include "qapi/qapi-types-common.h"
>  
>  /* ARM processors have a weak memory model */
>  #define TCG_GUEST_DEFAULT_MO      (0)
> @@ -196,9 +197,11 @@ typedef struct {
>  #ifdef TARGET_AARCH64
>  # define ARM_MAX_VQ    16
>  void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
> +void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp);
>  #else
>  # define ARM_MAX_VQ    1
>  static inline void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp) { }
> +static inline void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp) { }
>  #endif
>  
>  typedef struct ARMVectorReg {
> @@ -829,6 +832,8 @@ struct ARMCPU {
>      bool has_el3;
>      /* CPU has PMU (Performance Monitor Unit) */
>      bool has_pmu;
> +    /* CPU has SPE (Statistical Profiling Extension) */
> +    OnOffAuto has_spe;
>      /* CPU has VFP */
>      bool has_vfp;
>      /* CPU has Neon */
> @@ -3869,6 +3874,14 @@ static inline bool isar_feature_aa64_pmu_8_4(const ARMISARegisters *id)
>          FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMUVER) != 0xf;
>  }
>  
> +/*
> + * Currently we don't differentiate between the ARMv8.2-SPE and ARMv8.3-SPE.
> + */
> +static inline bool isar_feature_aa64_spe(const ARMISARegisters *id)
> +{
> +    return FIELD_EX64(id->id_aa64dfr0, ID_AA64DFR0, PMSVER) != 0;
> +}
> +
>  static inline bool isar_feature_aa64_rcpc_8_3(const ARMISARegisters *id)
>  {
>      return FIELD_EX64(id->id_aa64isar1, ID_AA64ISAR1, LRCPC) != 0;
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 3c2b3d9599..4997c4a3c0 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -572,6 +572,55 @@ void aarch64_add_sve_properties(Object *obj)
>      }
>  }
>  
> +void arm_cpu_spe_finalize(ARMCPU *cpu, Error **errp)
> +{
> +    uint64_t t;
> +    uint32_t value = 0;
> +
> +    if (cpu->has_spe == ON_OFF_AUTO_AUTO) {
> +        if (kvm_enabled() && kvm_arm_spe_supported()) {
> +            cpu->has_spe = ON_OFF_AUTO_ON;
> +        } else {
> +            cpu->has_spe = ON_OFF_AUTO_OFF;
> +        }
> +    } else if (cpu->has_spe == ON_OFF_AUTO_ON) {
> +        if (!kvm_enabled() || !kvm_arm_spe_supported()) {
> +            error_setg(errp, "'spe' cannot be enabled on this host");
> +            return;
> +        }
> +    }
> +
> +    /*
> +     * According to the ARM ARM, the ID_AA64DFR0[PMSVER] currently
> +     * support 3 values:
> +     *
> +     * 0b0000: SPE not implemented
> +     * 0b0001: ARMv8.2-SPE implemented
> +     * 0b0010: ARMv8.3-SPE implemented
> +     *
> +     * But the kernel KVM API didn't expose all these 3 values, and
> +     * we can only get whether the SPE feature is supported or not.
> +     * So here we just set the PMSVER to 1 if this feature was supported.
> +     */
> +    if (cpu->has_spe == ON_OFF_AUTO_ON) {
> +        value = 1;
> +    }
> +
> +    t = cpu->isar.id_aa64dfr0;
> +    t = FIELD_DP64(t, ID_AA64DFR0, PMSVER, value);
> +    cpu->isar.id_aa64dfr0 = t;
> +}
> +
> +static bool arm_spe_get(Object *obj, Error **errp)
> +{
> +    return ARM_CPU(obj)->has_spe != ON_OFF_AUTO_OFF;
> +}
> +
> +static void arm_spe_set(Object *obj, bool value, Error **errp)
> +{
> +    ARM_CPU(obj)->has_spe = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -721,6 +770,9 @@ static void aarch64_max_initfn(Object *obj)
>      aarch64_add_sve_properties(obj);
>      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                          cpu_max_set_sve_max_vq, NULL, NULL);
> +
> +    cpu->has_spe = ON_OFF_AUTO_AUTO;
> +    object_property_add_bool(obj, "spe", arm_spe_get, arm_spe_set);
>  }

The cover-letter says we're only providing the 'spe' property for KVM
enabled guests, but we're adding it here in the common part of the
max init function. It should be added in the kvm_enabled() part only.

Thanks,
drew

>  
>  static const ARMCPUInfo aarch64_cpus[] = {
> -- 
> 2.17.1
> 
> 


