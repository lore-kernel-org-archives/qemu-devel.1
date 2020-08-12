Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A714CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:17:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70FE32076B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNW+9JS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70FE32076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5npP-0000g3-NW
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noJ-0007nJ-E1
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37747
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1k5noG-00030F-6f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597227396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGyRt+gAwo1k7ppeHoo9tW19gqB1qjl1A7Ke+eXAkMo=;
 b=NNW+9JS3bJskbLlexGl2IjXB9n2PoOuuc7tvmvf0KJOlZCCJjgSohTG7n5xCIN2a2AisKe
 XI9rSpNg1X4YCeQEALX98m3zzqup6LUvZsQeKV1HlNwr9DmWTOrEH6piqm0PhEZ7v48jUl
 ACzRnlDcvLNPYOFBXnwE2eiDLy4I0xc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-1RaQ40qLOeGvJhLqNeDXkw-1; Wed, 12 Aug 2020 06:16:35 -0400
X-MC-Unique: 1RaQ40qLOeGvJhLqNeDXkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 17C1B871803;
 Wed, 12 Aug 2020 10:16:34 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDAA56111F;
 Wed, 12 Aug 2020 10:16:32 +0000 (UTC)
Subject: Re: [PATCH v2 4/5] hw/arm/virt: Move kvm pmu setup to
 virt_cpu_post_init
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-5-drjones@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d6eda3c9-54cb-58fc-46b0-7fcc3409b0d5@redhat.com>
Date: Wed, 12 Aug 2020 12:16:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200805091640.11134-5-drjones@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eric.auger@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Drew,
On 8/5/20 11:16 AM, Andrew Jones wrote:
> Move the KVM PMU setup part of fdt_add_pmu_nodes() to
> virt_cpu_post_init(), which is a more appropriate location. Now
> fdt_add_pmu_nodes() is also named more appropriately, because it
> no longer does anything but fdt node creation.
> 
> No functional change intended.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
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
I don't rget the relevance of the assert. If the PMU is set, isn't is
the consequence of arm_set_pmu?
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
same here?
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
Thanks

Eric


