Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A8C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E79206D4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 08:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VoiehPrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E79206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNXfU-0001Nl-LU
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 04:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNXeE-0000HF-9R
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNXeB-0007fZ-6n
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 04:39:36 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601455174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT16yEm/XJJBR5dcNHMvxBxWnX83JyTH5ezRhnmbZ1g=;
 b=VoiehPrc1ly6NVEY9kkIl7uSpi8flsBGFiMgRfZ1A1mJGcWI1taf/4KXMCK1piClrAflxC
 p5ut1UvGumajgcHecd84iutJf4mz7XtAABvcwwRMvCCk0wChMIPAjyBlNZ1/omkbZiW9MV
 tqm8tS1zKx9KAVOWey6mc1MnyQoWP3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-wu501G9hOH64Knj9pz18tQ-1; Wed, 30 Sep 2020 04:39:30 -0400
X-MC-Unique: wu501G9hOH64Knj9pz18tQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ED0B1868421;
 Wed, 30 Sep 2020 08:39:29 +0000 (UTC)
Received: from [10.36.113.210] (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8FEA610013BD;
 Wed, 30 Sep 2020 08:39:28 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] hw/arm/virt: Move kvm pmu setup to
 virt_cpu_post_init
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200916092620.19161-1-drjones@redhat.com>
 <20200916092620.19161-4-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b2170ffe-ce3f-10c7-37ab-fb0a6b7d0e0a@redhat.com>
Date: Wed, 30 Sep 2020 10:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200916092620.19161-4-drjones@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,

On 9/16/20 11:26 AM, Andrew Jones wrote:
> Move the KVM PMU setup part of fdt_add_pmu_nodes() to
> virt_cpu_post_init(), which is a more appropriate location. Now
> fdt_add_pmu_nodes() is also named more appropriately, because it
> no longer does anything but fdt node creation.
> 
> No functional change intended.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/virt.c | 34 ++++++++++++++++++----------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 2cba21fe3ad9..6797eb397a7a 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -521,21 +521,12 @@ static void fdt_add_gic_node(VirtMachineState *vms)
>  
>  static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>  {
> -    CPUState *cpu;
> -    ARMCPU *armcpu;
> +    ARMCPU *armcpu = ARM_CPU(first_cpu);
>      uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
>  
> -    CPU_FOREACH(cpu) {
> -        armcpu = ARM_CPU(cpu);
> -        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> -            return;
> -        }
> -        if (kvm_enabled()) {
> -            if (kvm_irqchip_in_kernel()) {
> -                kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> -            }
> -            kvm_arm_pmu_init(cpu);
> -        }
> +    if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> +        assert(!object_property_get_bool(OBJECT(armcpu), "pmu", NULL));
> +        return;
>      }
>  
>      if (vms->gic_version == VIRT_GIC_VERSION_2) {
> @@ -544,7 +535,6 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
>                               (1 << vms->smp_cpus) - 1);
>      }
>  
> -    armcpu = ARM_CPU(qemu_get_cpu(0));
>      qemu_fdt_add_subnode(vms->fdt, "/pmu");
>      if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
>          const char compat[] = "arm,armv8-pmuv3";
> @@ -1678,11 +1668,23 @@ static void finalize_gic_version(VirtMachineState *vms)
>   */
>  static void virt_cpu_post_init(VirtMachineState *vms)
>  {
> -    bool aarch64;
> +    bool aarch64, pmu;
> +    CPUState *cpu;
>  
>      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> +    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
>  
> -    if (!kvm_enabled()) {
> +    if (kvm_enabled()) {
> +        CPU_FOREACH(cpu) {
> +            if (pmu) {
> +                assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
> +                if (kvm_irqchip_in_kernel()) {
> +                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> +                }
> +                kvm_arm_pmu_init(cpu);
> +            }
> +        }
> +    } else {
>          if (aarch64 && vms->highmem) {
>              int requested_pa_size = 64 - clz64(vms->highest_gpa);
>              int pamax = arm_pamax(ARM_CPU(first_cpu));
> 


