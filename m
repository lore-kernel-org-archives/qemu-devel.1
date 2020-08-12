Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D6E2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BqNIp6rn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D6E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5npX-0000uA-Iw
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noS-0007zW-Oq
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noR-00031p-4c
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUI2eX2F8fREXvOyu01ciqIblEGplxdpBlJ23wcYhzk=;
 b=BqNIp6rnH55oIwmkz3mtr6s+eYrf+XGTffGBAw0Ejx9u9VfkhZEHUsjCvfMZW4JdVeavKc
 XL5HCzpf7IyM0fhH5UQatan5eZhoD/C/RRQrtPefWs2tsqXYsKZyWoVGGQ/mKjVepwbKFf
 IK0BUVmbWymHab7eBjPGXCycBgFBILw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-e7YTDgXHPjOKzG5iOOTAQw-1; Wed, 12 Aug 2020 06:16:46 -0400
X-MC-Unique: e7YTDgXHPjOKzG5iOOTAQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E5CD106B20A;
 Wed, 12 Aug 2020 10:16:45 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EE365D6BD;
 Wed, 12 Aug 2020 10:16:44 +0000 (UTC)
Subject: Re: [PATCH v2 2/5] target/arm/kvm: Make uncalled stubs explicitly
 unreachable
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-3-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b26a7bf5-ad7c-9376-78ab-600b7ea9fed8@redhat.com>
Date: Wed, 12 Aug 2020 12:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805091640.11134-3-drjones@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 06:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 8/5/20 11:16 AM, Andrew Jones wrote:
> When we compile without KVM support !defined(CONFIG_KVM) we generate
> stubs for functions that the linker will still encounter. Sometimes
> these stubs can be executed safely and are placed in paths where they
> get executed with or without KVM. Other functions should never be
> called without KVM. Those functions should be guarded by kvm_enabled(),
> but should also be robust to refactoring mistakes. Putting a
> g_assert_not_reached() in the function should help. Additionally,
> the g_assert_not_reached() calls may actually help the linker remove
> some code.
> 
> We remove the stubs for kvm_arm_get/put_virtual_time(), as they aren't
> necessary at all - the only caller is in kvm.c
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  target/arm/kvm_arm.h | 44 +++++++++++++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 17 deletions(-)
> 
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index adb38514bf20..0da00eb6b20c 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -344,16 +344,10 @@ int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
>  
>  #else
>  
> -static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> -{
> -    /*
> -     * This should never actually be called in the "not KVM" case,
> -     * but set up the fields to indicate an error anyway.
> -     */
> -    cpu->kvm_target = QEMU_KVM_ARM_TARGET_NONE;
> -    cpu->host_cpu_probe_failed = true;
> -}
> -
> +/*
> + * It's safe to call these functions without KVM support.
> + * They should either do nothing or return "not supported".
> + */
>  static inline void kvm_arm_add_vcpu_properties(Object *obj) {}
this one also is guarded by kvm_enabled() in target/arm/cpu.c
don't you want to add g_assert_not_reached()?
>  
>  static inline bool kvm_arm_aarch32_supported(void)
> @@ -371,23 +365,39 @@ static inline bool kvm_arm_sve_supported(void)
>      return false;
>  }
>  
> +/*
> + * These functions should never actually be called without KVM support.
> + */
> +static inline void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}
> +
>  static inline int kvm_arm_get_max_vm_ipa_size(MachineState *ms)
>  {
> -    return -ENOENT;
> +    g_assert_not_reached();
>  }
>  
>  static inline int kvm_arm_vgic_probe(void)
>  {
> -    return 0;
> +    g_assert_not_reached();
>  }
>  
> -static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq) {}
> -static inline void kvm_arm_pmu_init(CPUState *cs) {}
> +static inline void kvm_arm_pmu_set_irq(CPUState *cs, int irq)
> +{
> +    g_assert_not_reached();
> +}
>  
> -static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map) {}
> +static inline void kvm_arm_pmu_init(CPUState *cs)
> +{
> +    g_assert_not_reached();
> +}
> +
> +static inline void kvm_arm_sve_get_vls(CPUState *cs, unsigned long *map)
> +{
> +    g_assert_not_reached();
> +}
>  
> -static inline void kvm_arm_get_virtual_time(CPUState *cs) {}
> -static inline void kvm_arm_put_virtual_time(CPUState *cs) {}
>  #endif
>  
>  static inline const char *gic_class_name(void)
> 

Besides,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


