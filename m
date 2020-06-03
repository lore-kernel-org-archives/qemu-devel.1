Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A567FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:17:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 703C020772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rj5A0rkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703C020772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSKZ-0005GE-Na
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jgSJk-0004Ov-KN
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:16:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38106
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jgSJj-0001T3-0c
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 08:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591186581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hoHEzGpH6bSPhWfRRXOU8VlmxhtKDd7jGf7vq6j+uno=;
 b=Rj5A0rkI5Xx9LAx2G/WXiGcKKNCpqA+BfR3gDNSmt6KcH12fIZcYzJCMQmbUpPFHifHZnY
 G5heYxdADRgcGTYxgV99GHQGH6zylMTxcSA3vsnJA7w+W+3UI+uOFmnJWVL9xBpFuO1LAT
 aTWHN6X4IdoGLvZdR6G5RJvwqrnrJTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-8kYjKiyXPw29hQKfAmISjw-1; Wed, 03 Jun 2020 08:16:19 -0400
X-MC-Unique: 8kYjKiyXPw29hQKfAmISjw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0DBB108BD09;
 Wed,  3 Jun 2020 12:16:16 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.196.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB671579A3;
 Wed,  3 Jun 2020 12:16:08 +0000 (UTC)
Date: Wed, 3 Jun 2020 14:16:06 +0200
From: Andrew Jones <drjones@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
 VCPUs
Message-ID: <20200603121606.bj3mjlqsstzbu7py@kamzik.brq.redhat.com>
References: <b2e401cd17fe49d792d09b31bd726e35@huawei.com>
 <20200603093745.dwfb55ny34az7rez@kamzik.brq.redhat.com>
 <6bacdd359e504ed8924e67ed125bf15d@huawei.com>
MIME-Version: 1.0
In-Reply-To: <6bacdd359e504ed8924e67ed125bf15d@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:35
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 03, 2020 at 11:45:22AM +0000, Salil Mehta wrote:
> Hi Andrew,
> Many thanks for the reply.
> 
> > From: Andrew Jones [mailto:drjones@redhat.com]
> > Sent: Wednesday, June 3, 2020 10:38 AM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; Peter Maydell
> > <peter.maydell@linaro.org>; Igor Mammedov <imammedo@redhat.com>;
> > mst@redhat.com
> > Subject: Re: [Question] Regarding PMU initialization within the QEMU for ARM
> > VCPUs
> > 
> > On Mon, Jun 01, 2020 at 03:04:33PM +0000, Salil Mehta wrote:
> > > Hello,
> > > I could see below within function fdt_add_pmu_nodes() part of
> > > hw/arm/virt.c during virt machine initialization time:
> > >
> > > Observation:
> > > In below function, support of PMU feature is being checked for
> > > each vcpu and if the PMU is found part of the features then PMU
> > > is initialized with in the host/KVM. But if there is even one
> > > vcpu which is found to not support the PMU then loop is exited
> > > and PMU is not initialized for the rest of the vcpus as well.
> > >
> > > Questions:
> > > Q1. Not sure what is the logic of the premature exit and not
> > >     continuing with further checks and initialization of other
> > >     VCPU PMUs?
> > 
> > KVM requires all VCPUs to have a PMU if one does. If the ARM ARM
> > says it's possible to have PMUs for only some CPUs, then, for TCG,
> > the restriction could be relaxed. I expect it will take more than
> > just removing the check for things to work though.
> 
> Got it. Many thanks for this info.
> 
> During virt machine init we take cpu type from (-cpu <cpu-type>)
> option and it should apply evenly to all of the vcpus. Therefore,
> I can assume all of the processors to be identical for now. This
> combined with the KVM restriction you mentioned above means for
> PMU we could only have Enable-for-All OR Enable-for-none config
> for all of the vcpus being booted even though we at different
> places do have per-vcpu specific check like below available
> 
> /* MADT */
> static void
> build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> {
> [...]
> 
>     for (i = 0; i < vms->smp_cpus; i++) {
>         AcpiMadtGenericCpuInterface *gicc = acpi_data_push(table_data,
>                                                            sizeof(*gicc));
>         [...]
> 
>         if (arm_feature(&armcpu->env, ARM_FEATURE_PMU)) {---> This check
>             gicc->performance_interrupt = cpu_to_le32(PPI(VIRTUAL_PMU_IRQ));
>         }
>  [...]
> }
> 
> Do per-vcpu feature check for PMU even makes sense till we allow
> heterogeneous support of processors or relax the PMU enablement
> on the per-vcpu basis within the KVM?

It may not be necessary now or ever to test more than one CPU for the
PMU feature, but without a good reason to change it to a machine
property then I'd prefer we always to the N-1 pointless checks. The
feature is a CPU feature, not a machine feature, so, IMO, it should
remain something configured and tested at the CPU level, not the machine
level.

> 
> 
> 
> > 
> > > Q2. Does it even makes sense to have PMUs initialized for some
> > >     vcpus and not for others unless we have heterogeneous system?
> > 
> > I don't know, but it doesn't sound like a configuration I'd like
> > to see.
> 
> 
> sure. but in the existing code we do prematurely exit after we
> discover first vcpu amongst the possible vcpus not supporting
> PMU feature. This looks abnormal as well?

Are you trying to configure heterogeneous mach-virt machines? Or machines
that only provide PMUs to some CPUs? If not, then I'm not sure why this
would be a problem. Indeed it's likely a pointless check and, instead of
silently returning, it should output a warning or even assert. Otherwise,
I don't see a problem with it, since we want to be sure we're dealing with
the type of configuration we expect, i.e. one where each CPU has a PMU if
any CPU has a PMU.

Thanks,
drew


