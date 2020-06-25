Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE06C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287712089D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="Rs0a6Bi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287712089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joUSg-0008Au-FD
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joUFc-0000Lz-OP
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:57:20 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:45194 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joUFa-0005hl-3D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:57:20 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 939064C8B6;
 Thu, 25 Jun 2020 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593100633;
 x=1594915034; bh=AYrpaElaEIMFOFr3mVqJdqO2vfsTSgJYgAvxPag1VlM=; b=
 Rs0a6Bi/C8eav7zMj3BoT+BuOiaM4bZJiJXthSoCTtlnUc8lH8Eq14omTHrQeFUh
 j7dMpV453rNT5j5la3RRcF9j5Qn72IRV8wdsQkgmevOWqbEYDRcoqk7XYhKL3Ii9
 AcE0b1SfE2YKsnTW+EaknHgVBW07xAvhvlYbXKFTiCU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJjo36Id4861; Thu, 25 Jun 2020 18:57:13 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9D3164C8A5;
 Thu, 25 Jun 2020 18:57:13 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 18:57:13 +0300
Date: Thu, 25 Jun 2020 18:57:12 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 4/8] i386: hvf: Implement CPU kick
Message-ID: <20200625155712.GI25104@SPB-NB-133.local>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-5-r.bolshakov@yadro.com>
 <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9d63db4e-25a7-9c77-6f05-e5f808b8b33c@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 11:02:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 12:28:26PM +0200, Paolo Bonzini wrote:
> On 25/06/20 00:58, Roman Bolshakov wrote:
> > HVF doesn't have a CPU kick and without it it's not possible to perform
> > an action on CPU thread until a VMEXIT happens. The kick is also needed
> > for timely interrupt delivery.
> > 
> > Existing implementation of CPU kick sends SIG_IPI (aka SIGUSR1) to vCPU
> > thread, but it's different from what hv_vcpu_interrupt does. The latter
> > one results in invocation of mp_cpus_kick() in XNU kernel [1].
> > 
> > While at it, correct type of hvf_fd to the type of hv_vcpuid_t to avoid
> > compilation warnings.
> > 
> > 1. https://opensource.apple.com/source/xnu/xnu-6153.81.5/osfmk/i386/mp.c
> > 
> > Cc: Cameron Esfahani <dirty@apple.com>
> > Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > ---
> >  cpus.c                | 13 +++++++++----
> >  include/hw/core/cpu.h |  2 +-
> >  include/sysemu/hvf.h  |  1 +
> >  target/i386/hvf/hvf.c | 11 +++++++++++
> >  4 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/cpus.c b/cpus.c
> > index 26709677d3..36f38ce5c8 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1783,10 +1783,15 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
> >          return;
> >      }
> >      cpu->thread_kicked = true;
> > -    err = pthread_kill(cpu->thread->thread, SIG_IPI);
> > -    if (err && err != ESRCH) {
> > -        fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> > -        exit(1);
> > +
> > +    if (hvf_enabled()) {
> > +        hvf_vcpu_kick(cpu);
> > +    } else {
> > +        err = pthread_kill(cpu->thread->thread, SIG_IPI);
> > +        if (err && err != ESRCH) {
> > +            fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
> > +            exit(1);
> > +        }
> >      }
> >  #else /* _WIN32 */
> >      if (!qemu_cpu_is_self(cpu)) {
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index b3f4b79318..288a2bd57e 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -438,7 +438,7 @@ struct CPUState {
> >  
> >      struct hax_vcpu_state *hax_vcpu;
> >  
> > -    int hvf_fd;
> > +    unsigned hvf_fd;
> >  
> >      /* track IOMMUs whose translations we've cached in the TCG TLB */
> >      GArray *iommu_notifiers;
> > diff --git a/include/sysemu/hvf.h b/include/sysemu/hvf.h
> > index 1d40a8ec01..aaa00cbf05 100644
> > --- a/include/sysemu/hvf.h
> > +++ b/include/sysemu/hvf.h
> > @@ -25,6 +25,7 @@ extern bool hvf_allowed;
> >  
> >  int hvf_init_vcpu(CPUState *);
> >  int hvf_vcpu_exec(CPUState *);
> > +void hvf_vcpu_kick(CPUState *);
> >  void hvf_cpu_synchronize_state(CPUState *);
> >  void hvf_cpu_synchronize_post_reset(CPUState *);
> >  void hvf_cpu_synchronize_post_init(CPUState *);
> > diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> > index efe9802962..4d254a477a 100644
> > --- a/target/i386/hvf/hvf.c
> > +++ b/target/i386/hvf/hvf.c
> > @@ -966,6 +966,17 @@ int hvf_vcpu_exec(CPUState *cpu)
> >      return ret;
> >  }
> >  
> > +void hvf_vcpu_kick(CPUState *cpu)
> > +{
> > +    hv_return_t err;
> > +
> > +    err = hv_vcpu_interrupt(&cpu->hvf_fd, 1);
> > +    if (err) {
> > +        fprintf(stderr, "qemu:%s error %#x\n", __func__, err);
> > +        exit(1);
> > +    }
> > +}
> > +
> >  bool hvf_allowed;
> >  
> >  static int hvf_accel_init(MachineState *ms)
> > 
> 
> The documentation isn't clear on whether hv_vcpu_interrupt is able to
> interrupt a *subsequent* hv_vcpu_run, similar to WHPX
> WHvCancelRunVirtualProcessor (is it possible to decompile
> hv_vcpu_interrupt and see what it does?).

hv_vcpu_interrupt sends a KICK IPI using mp_cpus_kick() only if the
destination vCPU thread is running as far as I undrestand the
mp_cpus_kick():

void
mp_cpus_kick(cpumask_t cpus)
{
	cpu_t           cpu;
	boolean_t       intrs_enabled = FALSE;

	intrs_enabled = ml_set_interrupts_enabled(FALSE);
	mp_safe_spin_lock(&x86_topo_lock);

	for (cpu = 0; cpu < (cpu_t) real_ncpus; cpu++) {
		if ((cpu == (cpu_t) cpu_number())
		    || ((cpu_to_cpumask(cpu) & cpus) == 0)
		    || !cpu_is_running(cpu)) {
			continue;
		}

		lapic_send_ipi(cpu, LAPIC_VECTOR(KICK));
	}

	simple_unlock(&x86_topo_lock);
	ml_set_interrupts_enabled(intrs_enabled);
}

So, the kick is not delivered to self and in case if destination cpu is
not running. I think it can't interrupt subsequent hv_vcpu_run.

> If not, you can reduce a bit the race window by setting a variable in
> cpu, like
> 
> 	atomic_set(&cpu->deadline, 0);
> 	hv_vcpu_interrupt(...)
> 
> and in the vCPU thread
> 
> 	hv_vcpu_run_until(..., atomic_read(&cpu->deadline));
> 	atomic_set(&cpu->deadline, HV_DEADLINE_FOREVER);
> 

Sure, could you please explain who'll be racing? There's a race if a
kick was sent after VMEXIT, right? So essentially we need a way to
"requeue" a kick that was received outside of hv_vcpu_run to avoid loss
of it?

hv_vcpu_run_until is only available on macOS 10.15+ and we can't use yet
because of three release support rule.
(https://developer.apple.com/documentation/hypervisor/3181548-hv_vcpu_run_until?language=objc)

BTW, I'm totally okay to send v2 if kicks are lost and/or the patch
needs improvements. (and I can address EFER to VMCS Entry Controls
synchronization as well)

Paolo, do you know any particular test in kvm-unit-tests that can
exhibit the issue?

Thanks,
Roman

