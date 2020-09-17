Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA68C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73992075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTL4OpCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73992075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIupf-00078c-Ml
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIuXW-0006Gv-NE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kIuXR-00013Y-6W
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 10:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600351528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AEO/Ywr/S+BDVLDie2YE6CfI2puhF16qbGPgHHcxi4=;
 b=eTL4OpCm+wW8Fx2S+XVbSJ4pheJa70nKq07nHM0EhgPzAqNyozso/jTqfPuHluLIHGGXq+
 Umb/R8zP/MNuZ1Eil0ROre8teTPa4uqFti0RH6DSC2xGHpXJmd9eFiMIphrH5zxPnLEkrL
 DtsC8zNSLOJoZUPO1+WWCBQ81d+PaPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-yj7kLlxXO9KqrkhBqWeVfg-1; Thu, 17 Sep 2020 10:05:25 -0400
X-MC-Unique: yj7kLlxXO9KqrkhBqWeVfg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6F4A1084C81;
 Thu, 17 Sep 2020 14:05:23 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 777075DE51;
 Thu, 17 Sep 2020 14:05:21 +0000 (UTC)
Date: Thu, 17 Sep 2020 16:05:15 +0200
From: Andrew Jones <drjones@redhat.com>
To: Ying Fang <fangying1@huawei.com>
Subject: Re: [RFC PATCH 02/12] target/arm/kvm64: make MPIDR consistent with
 CPU Topology
Message-ID: <20200917140515.eg2s7nz2vm2mhktd@kamzik.brq.redhat.com>
References: <20200917032033.2020-1-fangying1@huawei.com>
 <20200917032033.2020-3-fangying1@huawei.com>
 <20200917075330.7sx3xm7gd4mwqqtq@kamzik.brq.redhat.com>
 <20200917105934.3rki6xwv5t4glxxi@kamzik.brq.redhat.com>
 <a6c1ab83-0853-30c2-089c-8e2a667cbdad@huawei.com>
MIME-Version: 1.0
In-Reply-To: <a6c1ab83-0853-30c2-089c-8e2a667cbdad@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=drjones@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, zhang.zhanghailiang@huawei.com,
 qemu-devel@nongnu.org, alex.chen@huawei.com, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, alistair.francis@wdc.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 09:19:34PM +0800, Ying Fang wrote:
> 
> 
> On 9/17/2020 6:59 PM, Andrew Jones wrote:
> > On Thu, Sep 17, 2020 at 09:53:35AM +0200, Andrew Jones wrote:
> > > On Thu, Sep 17, 2020 at 11:20:23AM +0800, Ying Fang wrote:
> > > > MPIDR helps to provide an additional PE identification in a multiprocessor
> > > > system. This patch adds support for setting MPIDR from userspace, so that
> > > > MPIDR is consistent with CPU topology configured.
> > > > 
> > > > Signed-off-by: Ying Fang <fangying1@huawei.com>
> > > > ---
> > > >   target/arm/kvm64.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> > > >   1 file changed, 38 insertions(+), 8 deletions(-)
> > > > 
> > > > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > > > index ef1e960285..fcce261a10 100644
> > > > --- a/target/arm/kvm64.c
> > > > +++ b/target/arm/kvm64.c
> > > > @@ -757,10 +757,46 @@ static int kvm_arm_sve_set_vls(CPUState *cs)
> > > >   #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
> > > > +static int kvm_arm_set_mp_affinity(CPUState *cs)
> > > > +{
> > > > +    uint64_t mpidr;
> > > > +    ARMCPU *cpu = ARM_CPU(cs);
> > > > +
> > > > +    if (kvm_check_extension(kvm_state, KVM_CAP_ARM_MP_AFFINITY)) {
> > > > +        /* Make MPIDR consistent with CPU topology */
> > > > +        MachineState *ms = MACHINE(qdev_get_machine());
> > > > +
> > > > +        mpidr = (kvm_arch_vcpu_id(cs) % ms->smp.threads) << ARM_AFF0_SHIFT;
> > > 
> > > We should query KVM first to determine if it wants guests to see their PEs
> > > as threads or not. If not, and ms->smp.threads is > 1, then that's an
> > > error. And, in any case, if ms->smp.threads == 1, then we shouldn't waste
> > > aff0 on it, as that could reduce IPI broadcast performance.
> > > 
> > > > +        mpidr |= ((kvm_arch_vcpu_id(cs) / ms->smp.threads % ms->smp.cores)
> > > > +                                    & 0xff) << ARM_AFF1_SHIFT;
> > > > +        mpidr |= (kvm_arch_vcpu_id(cs) / (ms->smp.cores * ms->smp.threads)
> > > > +                                    & 0xff) << ARM_AFF2_SHIFT;
> > 
> > Also, as pointed out in the KVM thread, we should not be attempting to
> > describe topology with the MPIDR at all. Alexandru pointed out [*] as
> > evidence for that.
> > 
> > However, we do need to consider the limits on Aff0 imposed by the GIC.
> > See hw/arm/virt.c:virt_cpu_mp_affinity() for how we currently do it
> > for TCG. We should do something similar for KVM guests when we're taking
> > full control of the MPIDR.
> > 
> > [*] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?id=3102bc0e6ac7
> > 
> > Thanks,
> > drew
> 
> Thanks for your information on MPIDR. As described in [*], MPIDR cannot
> be trusted as the actual topology. After applying:
> arm64: topology: Stop using MPIDR for topology information
> 
> Can we just use topology information from ACPI or fdt as topology and ignore
> MPIDR ?

Well the MPIDR will still be used as a unique identifier and it must
still confirm to the architecture (e.g. 0-15 for Aff0 for gicv3), but,
yes, the point is that the guest kernel should never try to use it for
topology information. The guest kernel should only use DT or ACPI.

Thanks,
drew

> 
> > 
> > > > +
> > > > +        /* Override mp affinity when KVM is in use */
> > > > +        cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
> > > > +
> > > > +        /* Bit 31 is RES1 indicates the ARMv7 Multiprocessing Extensions */
> > > > +        mpidr |= (1ULL << 31);
> > > > +        return kvm_vcpu_ioctl(cs, KVM_ARM_SET_MP_AFFINITY, &mpidr);
> > > > +    } else {
> > > > +        /*
> > > > +         * When KVM_CAP_ARM_MP_AFFINITY is not supported, it means KVM has its
> > > > +         * own idea about MPIDR assignment, so we override our defaults with
> > > > +         * what we get from KVM.
> > > > +         */
> > > > +        int ret = kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr);
> > > > +        if (ret) {
> > > > +            error_report("failed to set MPIDR");
> > > 
> > > We don't need this error, kvm_get_one_reg() has trace support already.
> > > Anyway, the wording is wrong since it says 'set' instead of 'get'.
> > > 
> > > > +            return ret;
> > > > +        }
> > > > +        cpu->mp_affinity = mpidr & ARM32_AFFINITY_MASK;
> > > > +        return ret;
> > > > +    }
> > > > +}
> > > > +
> > > >   int kvm_arch_init_vcpu(CPUState *cs)
> > > >   {
> > > >       int ret;
> > > > -    uint64_t mpidr;
> > > >       ARMCPU *cpu = ARM_CPU(cs);
> > > >       CPUARMState *env = &cpu->env;
> > > > @@ -814,16 +850,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
> > > >           }
> > > >       }
> > > > -    /*
> > > > -     * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
> > > > -     * Currently KVM has its own idea about MPIDR assignment, so we
> > > > -     * override our defaults with what we get from KVM.
> > > > -     */
> > > > -    ret = kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr);
> > > > +    ret = kvm_arm_set_mp_affinity(cs);
> > > >       if (ret) {
> > > >           return ret;
> > > >       }
> > > > -    cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
> > > >       kvm_arm_init_debug(cs);
> > > > -- 
> > > > 2.23.0
> > > > 
> > > > 
> > > 
> > > Thanks,
> > > drew
> > 
> > .
> > 
> 


