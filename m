Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C1820838
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 10:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Ir8F6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C1820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5o7V-0001d3-Qe
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 06:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5o6f-00015b-9J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:35:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20901
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k5o6d-0005YS-5Q
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 06:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597228538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6LI9S2Xqy9W3erUgeV4WYm+W6IiPk1y+K2W7dGerZk=;
 b=d8Ir8F6HlUNN9vjPApeomwp49Qe4aKQfVxcGGNAyO750prKfw8zvbFuxjdyFINBN8QjxI9
 JpfpvkJNhf59fsUR3wneJwP6YSFrP9lyaJTXf1NO27TIUQhwI/rPAmcd28WqZx7mbLw8b+
 ImHuFhJ/m0m6NyoXbRCY06k6ajEMIfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-k4TAYwcHM42eK_MmTRgpdQ-1; Wed, 12 Aug 2020 06:35:34 -0400
X-MC-Unique: k4TAYwcHM42eK_MmTRgpdQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98B7A1876531;
 Wed, 12 Aug 2020 10:35:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A1A21002395;
 Wed, 12 Aug 2020 10:35:29 +0000 (UTC)
Date: Wed, 12 Aug 2020 12:35:26 +0200
From: Andrew Jones <drjones@redhat.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 4/5] hw/arm/virt: Move kvm pmu setup to
 virt_cpu_post_init
Message-ID: <20200812103526.nxzyky4qussutkai@kamzik.brq.redhat.com>
References: <20200805091640.11134-1-drjones@redhat.com>
 <20200805091640.11134-5-drjones@redhat.com>
 <d6eda3c9-54cb-58fc-46b0-7fcc3409b0d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d6eda3c9-54cb-58fc-46b0-7fcc3409b0d5@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 03:52:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 12, 2020 at 12:16:31PM +0200, Auger Eric wrote:
> Hi Drew,
> On 8/5/20 11:16 AM, Andrew Jones wrote:
> > Move the KVM PMU setup part of fdt_add_pmu_nodes() to
> > virt_cpu_post_init(), which is a more appropriate location. Now
> > fdt_add_pmu_nodes() is also named more appropriately, because it
> > no longer does anything but fdt node creation.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  hw/arm/virt.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> > 
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 2cba21fe3ad9..6797eb397a7a 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -521,21 +521,12 @@ static void fdt_add_gic_node(VirtMachineState *vms)
> >  
> >  static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> >  {
> > -    CPUState *cpu;
> > -    ARMCPU *armcpu;
> > +    ARMCPU *armcpu = ARM_CPU(first_cpu);
> >      uint32_t irqflags = GIC_FDT_IRQ_FLAGS_LEVEL_HI;
> >  
> > -    CPU_FOREACH(cpu) {
> > -        armcpu = ARM_CPU(cpu);
> > -        if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> > -            return;
> > -        }
> > -        if (kvm_enabled()) {
> > -            if (kvm_irqchip_in_kernel()) {
> > -                kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> > -            }
> > -            kvm_arm_pmu_init(cpu);
> > -        }
> > +    if (!arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {
> > +        assert(!object_property_get_bool(OBJECT(armcpu), "pmu", NULL));
> I don't rget the relevance of the assert. If the PMU is set, isn't is
> the consequence of arm_set_pmu?

It's just defensive coding to ensure the property matches the feature
flag.

> > +        return;
> >      }
> >  
> >      if (vms->gic_version == VIRT_GIC_VERSION_2) {
> > @@ -544,7 +535,6 @@ static void fdt_add_pmu_nodes(const VirtMachineState *vms)
> >                               (1 << vms->smp_cpus) - 1);
> >      }
> >  
> > -    armcpu = ARM_CPU(qemu_get_cpu(0));
> >      qemu_fdt_add_subnode(vms->fdt, "/pmu");
> >      if (arm_feature(&armcpu->env, ARM_FEATURE_V8)) {
> >          const char compat[] = "arm,armv8-pmuv3";
> > @@ -1678,11 +1668,23 @@ static void finalize_gic_version(VirtMachineState *vms)
> >   */
> >  static void virt_cpu_post_init(VirtMachineState *vms)
> >  {
> > -    bool aarch64;
> > +    bool aarch64, pmu;
> > +    CPUState *cpu;
> >  
> >      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> > +    pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> >  
> > -    if (!kvm_enabled()) {
> > +    if (kvm_enabled()) {
> > +        CPU_FOREACH(cpu) {
> > +            if (pmu) {
> > +                assert(arm_feature(&ARM_CPU(cpu)->env, ARM_FEATURE_PMU));
> same here?

It's the same defensive check. Actually the check in fdt_add_pmu_nodes()
can definitely be removed, since this check will have already caught
anything before fdt_add_pmu_nodes() can run. We could probably just
remove both though.

> > +                if (kvm_irqchip_in_kernel()) {
> > +                    kvm_arm_pmu_set_irq(cpu, PPI(VIRTUAL_PMU_IRQ));
> > +                }
> > +                kvm_arm_pmu_init(cpu);
> > +            }
> > +        }
> > +    } else {
> >          if (aarch64 && vms->highmem) {
> >              int requested_pa_size = 64 - clz64(vms->highest_gpa);
> >              int pamax = arm_pamax(ARM_CPU(first_cpu));
> > 
> Thanks
> 
> Eric

Thanks,
drew


