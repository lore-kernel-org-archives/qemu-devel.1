Received: from eggs.gnu.org ([2001:4830:134:3::10]:52814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fEZfU-000765-EX
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1fEZfP-0003YH-Fx
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:18:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1fEZfP-0003XW-6o
	for qemu-devel@nongnu.org; Fri, 04 May 2018 08:18:27 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w44CGDgK134100
	for <qemu-devel@nongnu.org>; Fri, 4 May 2018 08:18:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hrmvry0ta-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 08:18:24 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Fri, 4 May 2018 06:18:24 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180504113724.64b7b1c0@bahia.lan>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180504113724.64b7b1c0@bahia.lan>
Date: Fri, 04 May 2018 07:18:13 -0500
Message-Id: <152543629398.15508.17426624020859105239@sif>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: only save guest
 timebase once after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Quoting Greg Kurz (2018-05-04 04:37:24)
> On Thu,  3 May 2018 23:20:44 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> =

> > In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> > via a runstate hook so we can restore it on qmp_cont(). If a migration
> > occurs in between those events we end up saving it again, this time
> > based on the current timebase the guest would be seeing had it been
> > running. This has the effect of advancing the guest timebase while
> > it is stopped, which is not what the code intends.
> > =

> =

> Hi Mike,
> =

> The current behavior was introduced by:
> =

> commit 42043e4f1241eeb77f87f5816b5cf0b6e9583ed7
> Author: Laurent Vivier <lvivier@redhat.com>
> Date:   Fri Jan 27 13:24:58 2017 +0100
> =

>     spapr: clock should count only if vm is running
> =

> and we have this in the changelog:
> =

>     We keep timebase_pre_save to reduce the clock difference on
>     migration like in:
>         6053a86 kvmclock: reduce kvmclock difference on migration
> =

> =

> So your patch totally negates ^^ ? Also, I can't see a case where

Yah... this is a bit confusing. On one hand, the patch/summary is clearly
trying to avoid the guest time from advancing while it is stopped, which
is in the spirit of this patch. But at the same time it is trying to
compensate for loss of time (relative to host) due to downtime window.

I think the subtlety is in the amount of time... saving at pre_save
rather than vm_stop() compensates for the normal downtime window, which
is *usually* small (5s is the figure they quote in the notes there and
in the motivating 6053a86 "kvmclock: reduce kvmclock difference on
migration"). The delays between vm_stop and vm_cont via something like
virsh suspend/resume is unbounded, unhowever, hence the rationale for
the runstate hook (?).

So maybe small jumps are considered okay, and large ones not? If that's
the reasoning, then this patch is addressing the later, so it's not
necessarily in conflict with that motivation, but the implementation
does negate the small jumps we try to avoid via pre_save hook since
we'll end up keep the version we saved just after vm_stop instead.

I would note that the downtime window itself, while usually small, can
also be quite large. With 1GB hugepages we've seen some guests requiring
downtime windows to be set to 25s until QEMU would start cut-over. Also
rcu_cpu_stall_timeout is configurable...it's possible if we set it to
5s it could trigger on the jump the guest experiences from pre_save (I
haven't tested that though).

Maybe trying to compensate for downtime is a generally bad idea and we
should just leave it up to NTP/etc? Or maybe we should choose a specific
upper bound on how much migration downtime we're willing to compensate
for and enforce that directly? E.g. tb->saved becomes tb->saved_time and
we check the difference in pre_save before calling timebase_save()
again.

> So your patch totally negates ^^ ? Also, I can't see a case where
> timebase_save() could be called from vmstate_save_state() while the
> VM is running, ie, you could drop timebase_pre_save()... or am I
> *probably* missing something ?

Yah, I didn't notice that my patch completely negated the pre_save
hook... for some reason I was thinking that would continue to function
normally if we didn't call qmp_stop() explicitly but that's clearly not
the case. So yah, dropping timebase_pre_save() is essentially what my
patch is doing...

> =

> > Other than simple jumps in time, this has been seen to trigger what
> > appear to be RCU-related crashes in recent kernels when the advance
> > exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> > common operations such as `virsh migrate ... --timeout 60`.
> > =

> > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Cc: Laurent Vivier <lvivier@redhat.com>
> > Cc: qemu-ppc@nongnu.org
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/ppc.c         | 12 ++++++++++++
> >  target/ppc/cpu-qom.h |  1 +
> >  2 files changed, 13 insertions(+)
> > =

> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index ec4be25f49..ff0a107864 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -865,6 +865,15 @@ static void timebase_save(PPCTimebase *tb)
> >      uint64_t ticks =3D cpu_get_host_ticks();
> >      PowerPCCPU *first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> >  =

> > +    /* since we generally save timebase just after the guest
> > +     * has stopped, avoid trying to save it again since we will
> > +     * end up advancing it by the amount of ticks that have
> > +     * elapsed in the host since the initial save
> > +     */
> > +    if (tb->saved) {
> > +        return;
> > +    }
> > +
> >      if (!first_ppc_cpu->env.tb_env) {
> >          error_report("No timebase object");
> >          return;
> > @@ -877,6 +886,7 @@ static void timebase_save(PPCTimebase *tb)
> >       * there is no need to update it from KVM here
> >       */
> >      tb->guest_timebase =3D ticks + first_ppc_cpu->env.tb_env->tb_offse=
t;
> > +    tb->saved =3D true;
> >  }
> >  =

> >  static void timebase_load(PPCTimebase *tb)
> > @@ -908,6 +918,8 @@ static void timebase_load(PPCTimebase *tb)
> >                          &pcpu->env.tb_env->tb_offset);
> >  #endif
> >      }
> > +
> > +    tb->saved =3D false;
> >  }
> >  =

> >  void cpu_ppc_clock_vm_state_change(void *opaque, int running,
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index deaa46a14b..ec2dbcdcae 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -210,6 +210,7 @@ typedef struct PowerPCCPUClass {
> >  typedef struct PPCTimebase {
> >      uint64_t guest_timebase;
> >      int64_t time_of_the_day_ns;
> > +    bool saved;
> >  } PPCTimebase;
> >  =

> >  extern const struct VMStateDescription vmstate_ppc_timebase;
>=20
