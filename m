Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF69C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 12:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C955206D4
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 12:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1tv9Pzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C955206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1qCw-0000Yt-Ky
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 08:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k1qBu-0008PE-7L
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 08:00:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21114
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1k1qBr-0004MV-4g
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 08:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596283237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hrURly2xk2D/FYVjZApiB8Ay4FmZVXkCfdQZJQzIjc8=;
 b=d1tv9PziRifZEBNz4ihQEXlfm+pcOToCd4igFvR/tfvRuhKt6RptCLSnrQLousX7hx41cD
 dNL6kgYKfvd3liU9RDc9kSgTgMXUNpRt/CheicS40qB6PWMhENBDTbTSJ9N2DOA1aV5t4k
 R3q5LbNd36+D5DoT9W+cukyrEzU39rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-LuD7u6sdP1iZaFYUXjeqNg-1; Sat, 01 Aug 2020 08:00:35 -0400
X-MC-Unique: LuD7u6sdP1iZaFYUXjeqNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D91F18839E3;
 Sat,  1 Aug 2020 12:00:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.209])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 056C687E16;
 Sat,  1 Aug 2020 12:00:32 +0000 (UTC)
Date: Sat, 1 Aug 2020 14:00:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] hw/arm/virt: Implement kvm-steal-time
Message-ID: <20200801120030.puzdwi4deczjm6gh@kamzik.brq.redhat.com>
References: <20200711101033.47371-1-drjones@redhat.com>
 <20200711101033.47371-4-drjones@redhat.com>
 <CAFEAcA8h+6btvjvx=j5v7Gn12+bros_UgFScKHaWVxh0dmi-Qw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8h+6btvjvx=j5v7Gn12+bros_UgFScKHaWVxh0dmi-Qw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 07:11:30
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 31, 2020 at 03:54:07PM +0100, Peter Maydell wrote:
> On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
> > We add the kvm-steal-time CPU property and implement it for machvirt.
> > A tiny bit of refactoring was also done to allow pmu and pvtime to
> > use the same vcpu device helper functions.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> 
> Hi; I'm forwarding a couple of comments here from Beata,
> (whose secondment with Linaro is coming to an end so she won't
> have access to her Linaro email address to continue the conversation):
> 
> 
> >  static void virt_cpu_post_init(VirtMachineState *vms)
> >  {
> > -    bool aarch64, pmu;
> > +    bool aarch64, pmu, steal_time;
> >      CPUState *cpu;
> >
> >      aarch64 = object_property_get_bool(OBJECT(first_cpu), "aarch64", NULL);
> >      pmu = object_property_get_bool(OBJECT(first_cpu), "pmu", NULL);
> > +    steal_time = object_property_get_bool(OBJECT(first_cpu),
> > +                                          "kvm-steal-time", NULL);
> >
> >      if (kvm_enabled()) {
> > +        hwaddr pvtime_base = vms->memmap[VIRT_PVTIME].base;
> > +        hwaddr pvtime_size = vms->memmap[VIRT_PVTIME].size;
> > +
> > +        if (steal_time) {
> > +            MemoryRegion *pvtime = g_new(MemoryRegion, 1);
> > +
> > +            memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
> > +            memory_region_add_subregion(get_system_memory(), pvtime_base,
> > +                                        pvtime);
> > +        }
> 
> B: I'm not sure whether it wouldn't be useful to have the area
> allocated with size determined by number of VCPUs instead of having
> pre-defined size.

We can't go smaller than one host-sized page, so this 64k region is the
smallest we can go. The assert in the next hunk, which was snipped
out of the reply, ensures that 64k is large enough to cover the maximum
number of VCPUs that could ever be configured. I don't think there's
anything else we should do at this time. If the pvtime structure grows,
or if we increase the maximum number of VCPUs to be larger than 1024,
then we can revisit this in order to determine when additional 64k pages
should be allocated.

For now, if it would help, I could extend the comment (which was also
snipped) to mention that 64k was chosen because it's the maximum host
page size, and that at least one host-sized page must be allocated for
this region.

> 
> > +        if (vmc->kvm_no_steal_time &&
> > +            object_property_find(cpuobj, "kvm-steal-time", NULL)) {
> > +            object_property_set_bool(cpuobj, false, "kvm-steal-time", NULL);
> > +        }
> > +
> >          if (vmc->no_pmu && object_property_find(cpuobj, "pmu", NULL)) {
> >              object_property_set_bool(cpuobj, "pmu", false, NULL);
> >          }
> > @@ -2528,6 +2558,7 @@ static void virt_machine_5_0_options(MachineClass *mc)
> >      mc->numa_mem_supported = true;
> >      vmc->acpi_expose_flash = true;
> >      mc->auto_enable_numa_with_memdev = false;
> > +    vmc->kvm_no_steal_time = true;
> >  }
> >  DEFINE_VIRT_MACHINE(5, 0)
> >
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> > index 54bcf17afd35..b5153afedcdf 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -80,6 +80,7 @@ enum {
> >      VIRT_PCDIMM_ACPI,
> >      VIRT_ACPI_GED,
> >      VIRT_NVDIMM_ACPI,
> > +    VIRT_PVTIME,
> >      VIRT_LOWMEMMAP_LAST,
> >  };
> >
> > @@ -126,6 +127,7 @@ typedef struct {
> >      bool no_ged;   /* Machines < 4.2 has no support for ACPI GED device */
> >      bool kvm_no_adjvtime;
> >      bool acpi_expose_flash;
> > +    bool kvm_no_steal_time;
> 
> B: It is slightly confusing : using kvm_no_steal_time vs kvm_steal_time
> 
> P: I have to admit I get confused about which sense this flag
> should have. I think the sense of the flags in this struct is
> "the false case is the one that the older virt boards had",
> so original virt didn't have an ITS or a PMU and so we have
> no_its and no_pmu. Similarly here old virt didn't have steal-time
> and so we want a no_ flag (ie the patch is correct). Why
> kvm_no_steal_time rather than no_kvm_steal_time, though ?

Correct. We want the default value of the boolean (false) to mean
"not disabled", so the boolean must have a negative name in order
to mean "disabled" when it is true. I'm not opposed to
no_kvm_steal_time vs. kvm_no_steal_time, since the property name
is "kvm-steal-time". I think I ended up with the 'kvm' and 'no'
swapped by copy+pasting kvm_no_adjvtime. However that one is
appropriately named because the property name is "kvm-no-adjvtime".
I'll change this for v2.

> 
> >  } VirtMachineClass;
> 
> > +void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
> > +{
> > +    struct kvm_device_attr attr = {
> > +        .group = KVM_ARM_VCPU_PVTIME_CTRL,
> > +        .attr = KVM_ARM_VCPU_PVTIME_IPA,
> > +        .addr = (uint64_t)&ipa,
> > +    };
> > +
> > +    if (!ARM_CPU(cs)->kvm_steal_time) {
> > +        return;
> > +    }
> > +    if (!kvm_arm_set_device_attr(cs, &attr, "PVTIME IPA")) {
> > +        error_report("failed to init PVTIME IPA");
> > +        abort();
> > +    }
> > +}
> 
> B: I am probably missing smth but .. there is a trigger missing to
> update the stats
> and write them back to pre-allocated guest memory.
> Looking at the kernel code the stats are updated upon pending
> VCPU request :
> in arch/arm64/kvm/arm.c:
> static void check_vcpu_requests(struct kvm_vcpu *vcpu) {
>         ...
>          if (kvm_check_request(KVM_REQ_RECORD_STEAL, vcpu))
>                 kvm_update_stolen_time(vcpu);
> }

kvm_arch_vcpu_load() unconditionally makes that request when pvtime
is enabled.

Thanks,
drew


