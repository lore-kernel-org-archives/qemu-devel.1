Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58278ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1844A21835
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGdVsxVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1844A21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9j5-0003N9-8z
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8tD-00078I-Eu
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msys.mizuma@gmail.com>) id 1iL8tB-0004ZT-GY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:44:39 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:33301)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <msys.mizuma@gmail.com>)
 id 1iL8tB-0004ZK-Ac; Thu, 17 Oct 2019 12:44:37 -0400
Received: by mail-qt1-x843.google.com with SMTP id r5so4593435qtd.0;
 Thu, 17 Oct 2019 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=Ys1njczrPcbKnqx2HQkX/N/uEI8FqKy+qZSOaPd0hS0=;
 b=XGdVsxVLMlooQFFuk2UrPpODBlbFQsku5hF9q7nENBj6vZUZsNDt3Yo8XZJzSp3Mfn
 trxesmb8o3B5qQv4QDFEztsJWa9MwtnIeA0/YLQJ48AOPPHwCnNxYhMn7aVbLTCfelO2
 Fv0dO0re98M0weKWIi8/pEFmFse62TXvLqdlAs6mQAsuoxE+nSkG1Ws/nAqIgdESxEPL
 y1Ux7wmcQ1AahiYswHypsz9cIfDnIvBq7m/Y3AwPjmGPunufkeIRxjXRu/SCphIvrlnq
 qAMZ+AMI2Mub6GT9p5LPIlyr6GVLcQFPFfD+triQMuypn8A9VTufyhRtJhcfi3lon3CA
 jcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=Ys1njczrPcbKnqx2HQkX/N/uEI8FqKy+qZSOaPd0hS0=;
 b=Btd7WrtWxcm+AswUgnAygJ90Wi7qvLALCLVwBd0W2U9xF5CUqB9fYwijY2XACqy4wi
 5fzpFnsH1g5aRKYKVyBZgrudgPLDn9muxj89fu/CeaLeQZE709voo4XKhP+YnII716DE
 d8GXokYNrJHklyUWOQNF8AxYjD1rXV3jej7dl8neN/R4yTWO2M0RWRndQ1+3dd+CjGZ1
 h6djzWBjDUyZFkq6w63U2Pc4zJNI7ryVBQReZ5GJaz3UqMzClZPWDXHkgcrWqQzUCHNw
 m/LZvd82fsEWuYBOTXUsL7nP71gd7zWq4sHzyyNaBTE2W35gx3rfpysQlywb4IAAAS3V
 POqQ==
X-Gm-Message-State: APjAAAU6bMMTM63tv0vDjgBEqUcdJ2VHVAsHPO0/5HEbnDZu86hP7LK/
 WsNSbd9+UwMt9OjhLUh4OQ==
X-Google-Smtp-Source: APXvYqxunJbaknBbBax1MXIan9Esba9IxCMVzyZJtvGP/Fbn5WXsc82ORracuSD2sN9S0Bzpgd6asA==
X-Received: by 2002:ad4:4583:: with SMTP id x3mr5007818qvu.162.1571330676590; 
 Thu, 17 Oct 2019 09:44:36 -0700 (PDT)
Received: from gabell (nat-pool-bos-t.redhat.com. [66.187.233.206])
 by smtp.gmail.com with ESMTPSA id g45sm1692331qtc.9.2019.10.17.09.44.35
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 09:44:36 -0700 (PDT)
Date: Thu, 17 Oct 2019 12:44:33 -0400
From: Masayoshi Mizuma <msys.mizuma@gmail.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 9/9] target/arm/kvm: host cpu: Add support for sve<N>
 properties
Message-ID: <20191017164432.mni6zcjnp566htgs@gabell>
References: <20191016085408.24360-1-drjones@redhat.com>
 <20191016085408.24360-10-drjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016085408.24360-10-drjones@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 16, 2019 at 10:54:08AM +0200, Andrew Jones wrote:
> Allow cpu 'host' to enable SVE when it's available, unless the
> user chooses to disable it with the added 'sve=off' cpu property.
> Also give the user the ability to select vector lengths with the
> sve<N> properties. We don't adopt 'max' cpu's other sve property,
> sve-max-vq, because that property is difficult to use with KVM.
> That property assumes all vector lengths in the range from 1 up
> to and including the specified maximum length are supported, but
> there may be optional lengths not supported by the host in that
> range. With KVM one must be more specific when enabling vector
> lengths.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

This patch works well on aarch64 with SVE machine, thanks!
Please feel free to add:

    Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

- Masa

> ---
>  docs/arm-cpu-features.rst | 19 ++++++++++++-------
>  target/arm/cpu.c          |  3 +++
>  target/arm/cpu.h          |  2 ++
>  target/arm/cpu64.c        | 33 +++++++++++++++++----------------
>  target/arm/kvm64.c        | 14 +++++++++++++-
>  tests/arm-cpu-features.c  | 21 +++++++++++----------
>  6 files changed, 58 insertions(+), 34 deletions(-)
> 
> diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> index bed218d44619..1b367e22e16e 100644
> --- a/docs/arm-cpu-features.rst
> +++ b/docs/arm-cpu-features.rst
> @@ -272,31 +272,36 @@ SVE CPU Property Examples
>  
>       $ qemu-system-aarch64 -M virt -cpu max
>  
> -  3) Only enable the 128-bit vector length::
> +  3) When KVM is enabled, implicitly enable all host CPU supported vector
> +     lengths with the `host` CPU type::
> +
> +     $ qemu-system-aarch64 -M virt,accel=kvm -cpu host
> +
> +  4) Only enable the 128-bit vector length::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve128=on
>  
> -  4) Disable the 512-bit vector length and all larger vector lengths,
> +  5) Disable the 512-bit vector length and all larger vector lengths,
>       since 512 is a power-of-two.  This results in all the smaller,
>       uninitialized lengths (128, 256, and 384) defaulting to enabled::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve512=off
>  
> -  5) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
> +  6) Enable the 128-bit, 256-bit, and 512-bit vector lengths::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve128=on,sve256=on,sve512=on
>  
> -  6) The same as (5), but since the 128-bit and 256-bit vector
> +  7) The same as (6), but since the 128-bit and 256-bit vector
>       lengths are required for the 512-bit vector length to be enabled,
>       then allow them to be auto-enabled::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve512=on
>  
> -  7) Do the same as (6), but by first disabling SVE and then re-enabling it::
> +  8) Do the same as (7), but by first disabling SVE and then re-enabling it::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve512=on,sve=on
>  
> -  8) Force errors regarding the last vector length::
> +  9) Force errors regarding the last vector length::
>  
>       $ qemu-system-aarch64 -M virt -cpu max,sve128=off
>       $ qemu-system-aarch64 -M virt -cpu max,sve=off,sve128=off,sve=on
> @@ -308,5 +313,5 @@ The examples in "SVE CPU Property Examples" exhibit many ways to select
>  vector lengths which developers may find useful in order to avoid overly
>  verbose command lines.  However, the recommended way to select vector
>  lengths is to explicitly enable each desired length.  Therefore only
> -example's (1), (3), and (5) exhibit recommended uses of the properties.
> +example's (1), (4), and (6) exhibit recommended uses of the properties.
>  
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 48c18871f6ea..0c4465880ddd 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2669,6 +2669,9 @@ static void arm_host_initfn(Object *obj)
>      ARMCPU *cpu = ARM_CPU(obj);
>  
>      kvm_arm_set_cpu_features_from_host(cpu);
> +    if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
> +        aarch64_add_sve_properties(obj);
> +    }
>      arm_cpu_post_init(obj);
>  }
>  
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 11162484465a..5b9c3e4cd73d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -974,11 +974,13 @@ int aarch64_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq);
>  void aarch64_sve_change_el(CPUARMState *env, int old_el,
>                             int new_el, bool el0_a64);
> +void aarch64_add_sve_properties(Object *obj);
>  #else
>  static inline void aarch64_sve_narrow_vq(CPUARMState *env, unsigned vq) { }
>  static inline void aarch64_sve_change_el(CPUARMState *env, int o,
>                                           int n, bool a)
>  { }
> +static inline void aarch64_add_sve_properties(Object *obj) { }
>  #endif
>  
>  #if !defined(CONFIG_TCG)
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index c161a146ff0d..68baf0482ffa 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -594,6 +594,21 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>      cpu->isar.id_aa64pfr0 = t;
>  }
>  
> +void aarch64_add_sve_properties(Object *obj)
> +{
> +    uint32_t vq;
> +
> +    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> +                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
> +
> +    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> +        char name[8];
> +        sprintf(name, "sve%d", vq * 128);
> +        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> +                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> +    }
> +}
> +
>  /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
>   * otherwise, a CPU with as many features enabled as our emulation supports.
>   * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
> @@ -602,17 +617,11 @@ static void cpu_arm_set_sve(Object *obj, Visitor *v, const char *name,
>  static void aarch64_max_initfn(Object *obj)
>  {
>      ARMCPU *cpu = ARM_CPU(obj);
> -    uint32_t vq;
> -    uint64_t t;
>  
>      if (kvm_enabled()) {
>          kvm_arm_set_cpu_features_from_host(cpu);
> -        if (kvm_arm_sve_supported(CPU(cpu))) {
> -            t = cpu->isar.id_aa64pfr0;
> -            t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
> -            cpu->isar.id_aa64pfr0 = t;
> -        }
>      } else {
> +        uint64_t t;
>          uint32_t u;
>          aarch64_a57_initfn(obj);
>  
> @@ -712,17 +721,9 @@ static void aarch64_max_initfn(Object *obj)
>  #endif
>      }
>  
> -    object_property_add(obj, "sve", "bool", cpu_arm_get_sve,
> -                        cpu_arm_set_sve, NULL, NULL, &error_fatal);
> +    aarch64_add_sve_properties(obj);
>      object_property_add(obj, "sve-max-vq", "uint32", cpu_max_get_sve_max_vq,
>                          cpu_max_set_sve_max_vq, NULL, NULL, &error_fatal);
> -
> -    for (vq = 1; vq <= ARM_MAX_VQ; ++vq) {
> -        char name[8];
> -        sprintf(name, "sve%d", vq * 128);
> -        object_property_add(obj, name, "bool", cpu_arm_get_sve_vq,
> -                            cpu_arm_set_sve_vq, NULL, NULL, &error_fatal);
> -    }
>  }
>  
>  struct ARMCPUInfo {
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index c93bbee425ae..876184b8fe4d 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -488,7 +488,9 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       * and then query that CPU for the relevant ID registers.
>       */
>      int fdarray[3];
> +    bool sve_supported;
>      uint64_t features = 0;
> +    uint64_t t;
>      int err;
>  
>      /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
> @@ -578,13 +580,23 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>                                ARM64_SYS_REG(3, 0, 0, 3, 2));
>      }
>  
> +    sve_supported = ioctl(fdarray[0], KVM_CHECK_EXTENSION, KVM_CAP_ARM_SVE) > 0;
> +
>      kvm_arm_destroy_scratch_host_vcpu(fdarray);
>  
>      if (err < 0) {
>          return false;
>      }
>  
> -   /* We can assume any KVM supporting CPU is at least a v8
> +    /* Add feature bits that can't appear until after VCPU init. */
> +    if (sve_supported) {
> +        t = ahcf->isar.id_aa64pfr0;
> +        t = FIELD_DP64(t, ID_AA64PFR0, SVE, 1);
> +        ahcf->isar.id_aa64pfr0 = t;
> +    }
> +
> +    /*
> +     * We can assume any KVM supporting CPU is at least a v8
>       * with VFPv4+Neon; this in turn implies most of the other
>       * feature bits.
>       */
> diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
> index 61694e2f8e0c..92668efb8f56 100644
> --- a/tests/arm-cpu-features.c
> +++ b/tests/arm-cpu-features.c
> @@ -356,7 +356,7 @@ static void sve_tests_sve_off_kvm(const void *data)
>  {
>      QTestState *qts;
>  
> -    qts = qtest_init(MACHINE "-accel kvm -cpu max,sve=off");
> +    qts = qtest_init(MACHINE "-accel kvm -cpu host,sve=off");
>  
>      /*
>       * We don't know if this host supports SVE so we don't
> @@ -365,8 +365,8 @@ static void sve_tests_sve_off_kvm(const void *data)
>       * and that using sve<N>=off to explicitly disable vector
>       * lengths is OK too.
>       */
> -    assert_sve_vls(qts, "max", 0, NULL);
> -    assert_sve_vls(qts, "max", 0, "{ 'sve128': false }");
> +    assert_sve_vls(qts, "host", 0, NULL);
> +    assert_sve_vls(qts, "host", 0, "{ 'sve128': false }");
>  
>      qtest_quit(qts);
>  }
> @@ -433,8 +433,8 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>              "We cannot guarantee the CPU type 'cortex-a15' works "
>              "with KVM on this host", NULL);
>  
> -        assert_has_feature(qts, "max", "sve");
> -        resp = do_query_no_props(qts, "max");
> +        assert_has_feature(qts, "host", "sve");
> +        resp = do_query_no_props(qts, "host");
>          kvm_supports_sve = resp_get_feature(resp, "sve");
>          vls = resp_get_sve_vls(resp);
>          qobject_unref(resp);
> @@ -445,7 +445,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>              sprintf(max_name, "sve%d", max_vq * 128);
>  
>              /* Enabling a supported length is of course fine. */
> -            assert_sve_vls(qts, "max", vls, "{ %s: true }", max_name);
> +            assert_sve_vls(qts, "host", vls, "{ %s: true }", max_name);
>  
>              /* Get the next supported length smaller than max-vq. */
>              vq = 64 - __builtin_clzll(vls & ~BIT_ULL(max_vq - 1));
> @@ -454,7 +454,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>                   * We have at least one length smaller than max-vq,
>                   * so we can disable max-vq.
>                   */
> -                assert_sve_vls(qts, "max", (vls & ~BIT_ULL(max_vq - 1)),
> +                assert_sve_vls(qts, "host", (vls & ~BIT_ULL(max_vq - 1)),
>                                 "{ %s: false }", max_name);
>  
>                  /*
> @@ -464,7 +464,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>                   */
>                  sprintf(name, "sve%d", vq * 128);
>                  error = g_strdup_printf("cannot disable %s", name);
> -                assert_error(qts, "max", error,
> +                assert_error(qts, "host", error,
>                               "{ %s: true, %s: false }",
>                               max_name, name);
>                  g_free(error);
> @@ -477,7 +477,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>              vq = __builtin_ffsll(vls);
>              sprintf(name, "sve%d", vq * 128);
>              error = g_strdup_printf("cannot disable %s", name);
> -            assert_error(qts, "max", error, "{ %s: false }", name);
> +            assert_error(qts, "host", error, "{ %s: false }", name);
>              g_free(error);
>  
>              /* Get an unsupported length. */
> @@ -489,13 +489,14 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
>              if (vq <= SVE_MAX_VQ) {
>                  sprintf(name, "sve%d", vq * 128);
>                  error = g_strdup_printf("cannot enable %s", name);
> -                assert_error(qts, "max", error, "{ %s: true }", name);
> +                assert_error(qts, "host", error, "{ %s: true }", name);
>                  g_free(error);
>              }
>          } else {
>              g_assert(vls == 0);
>          }
>      } else {
> +        assert_has_not_feature(qts, "host", "sve");
>          assert_error(qts, "host",
>                       "'pmu' feature not supported by KVM on this host",
>                       "{ 'pmu': true }");
> -- 
> 2.21.0
> 
> 

