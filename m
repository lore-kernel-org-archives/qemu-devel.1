Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002BC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39E0720731
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 07:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT6raCre"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39E0720731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI5SB-0004SR-1p
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 03:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI5Qu-0003iB-Ja
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:31:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57601
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kI5Qs-00056W-2C
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 03:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600155077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+SUOQ4HllaTI6EgOEoM0vBxraz7MhS02dV6rnRn8yRU=;
 b=hT6raCreI3K8XxGHns+rE6/N86TJObiGlByxruH9Ix+0hhRCp7F6+iYOxtau0t/sue2HgO
 38soM9st+3cmZPlBfG/gyNL5/C4F+HDadESbbjCSR7iu+sClgUW4Q/dh4od+AtU/U5f4qh
 ihNonByCfYMnnlmc7kSqtbMwRq4Zd4g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-TmNfgcAWONmc7d2NN7RaSA-1; Tue, 15 Sep 2020 03:31:11 -0400
X-MC-Unique: TmNfgcAWONmc7d2NN7RaSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A65E8014D8;
 Tue, 15 Sep 2020 07:31:10 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.136])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23BC5DD6E;
 Tue, 15 Sep 2020 07:31:08 +0000 (UTC)
Date: Tue, 15 Sep 2020 09:31:05 +0200
From: Andrew Jones <drjones@redhat.com>
To: Haibo Xu <haibo.xu@linaro.org>
Subject: Re: [PATCH v3 07/12] hw/arm/virt: Move post cpu realize check into
 its own function
Message-ID: <20200915073105.32zci2lukwgljvw4@kamzik.brq.redhat.com>
References: <cover.1600135462.git.haibo.xu@linaro.org>
 <20eedb95441ecec7b23527cde78aa5b63c67b400.1600135462.git.haibo.xu@linaro.org>
 <20200915062219.dtnl6p3nan76xvv7@kamzik.brq.redhat.com>
 <CAJc+Z1Gk2pjiaMKxohj80x1YkvTw4eNW7BZxp_ztsF8E68pYeg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1Gk2pjiaMKxohj80x1YkvTw4eNW7BZxp_ztsF8E68pYeg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:29:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 15, 2020 at 03:03:49PM +0800, Haibo Xu wrote:
> On Tue, 15 Sep 2020 at 14:22, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 03:11:43AM +0000, Haibo Xu wrote:
> > > From: Andrew Jones <drjones@redhat.com>
> > >
> > > We'll add more to this new function in coming patches so we also
> > > state the gic must be created and call it below create_gic().
> > >
> > > No functional change intended.
> > >
> > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> > > ---
> > >  hw/arm/virt.c | 38 ++++++++++++++++++++++----------------
> > >  1 file changed, 22 insertions(+), 16 deletions(-)
> >
> > This still isn't the right version of this patch. You need
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg727591.html
> >
> 
> My fault! Very sorry for forgetting to address that in this version.
> Shall I re-send this patch with the fix? Or fix it in the next version?

I can wait. It'll be awhile before this series can be merged anyway, since
the KVM patches haven't been merged yet.

Thanks,
drew

> 
> > >
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index 3f6d26c531..2ffcb073af 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1672,6 +1672,26 @@ static void finalize_gic_version(VirtMachineState *vms)
> > >      }
> > >  }
> > >
> > > +static void virt_cpu_post_init(VirtMachineState *vms)
> > > +{
> > > +    bool aarch64;
> > > +
> > > +    aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> > > +
> > > +    if (!kvm_enabled()) {
> > > +        if (aarch64 && vms->highmem) {
> > > +            int requested_pa_size = 64 - clz64(vms->highest_gpa);
> > > +            int pamax = arm_pamax(ARM_CPU(first_cpu));
> > > +
> > > +            if (pamax < requested_pa_size) {
> > > +                error_report("VCPU supports less PA bits (%d) than requested "
> > > +                            "by the memory map (%d)", pamax, requested_pa_size);
> > > +                exit(1);
> > > +            }
> > > +        }
> > > +     }
> > > +}
> > > +
> > >  static void machvirt_init(MachineState *machine)
> > >  {
> > >      VirtMachineState *vms = VIRT_MACHINE(machine);
> > > @@ -1890,22 +1910,6 @@ static void machvirt_init(MachineState *machine)
> > >      fdt_add_timer_nodes(vms);
> > >      fdt_add_cpu_nodes(vms);
> > >
> > > -   if (!kvm_enabled()) {
> > > -        ARMCPU *cpu = ARM_CPU(first_cpu);
> > > -        bool aarch64 = object_property_get_bool(OBJECT(cpu), "aarch64", NULL);
> > > -
> > > -        if (aarch64 && vms->highmem) {
> > > -            int requested_pa_size, pamax = arm_pamax(cpu);
> > > -
> > > -            requested_pa_size = 64 - clz64(vms->highest_gpa);
> > > -            if (pamax < requested_pa_size) {
> > > -                error_report("VCPU supports less PA bits (%d) than requested "
> > > -                            "by the memory map (%d)", pamax, requested_pa_size);
> > > -                exit(1);
> > > -            }
> > > -        }
> > > -    }
> > > -
> > >      memory_region_add_subregion(sysmem, vms->memmap[VIRT_MEM].base,
> > >                                  machine->ram);
> > >      if (machine->device_memory) {
> > > @@ -1917,6 +1921,8 @@ static void machvirt_init(MachineState *machine)
> > >
> > >      create_gic(vms);
> > >
> > > +    virt_cpu_post_init(vms);
> > > +
> > >      fdt_add_pmu_nodes(vms);
> > >
> > >      create_uart(vms, VIRT_UART, sysmem, serial_hd(0));
> > > --
> > > 2.17.1
> > >
> > >
> >
> 


