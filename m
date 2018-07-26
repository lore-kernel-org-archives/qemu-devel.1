Received: from eggs.gnu.org ([2001:4830:134:3::10]:37677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fifPw-0003TA-RT
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fifPt-0007Ks-SD
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 08:30:52 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180726050746.GC12001@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180726050746.GC12001@umbus.fritz.box>
Message-ID: <153260823426.10934.15915467115866182748@sif>
Date: Thu, 26 Jul 2018 07:30:34 -0500
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org

Quoting David Gibson (2018-07-26 00:07:46)
> On Thu, May 03, 2018 at 11:20:44PM -0500, Michael Roth wrote:
> > In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> > via a runstate hook so we can restore it on qmp_cont(). If a migration
> > occurs in between those events we end up saving it again, this time
> > based on the current timebase the guest would be seeing had it been
> > running. This has the effect of advancing the guest timebase while
> > it is stopped, which is not what the code intends.
> > =

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
> =

> Sorry, this fell off my radar for ages, but I've finally had a chance
> to look at it properly.

No problem, I had assumed it just wasn't deemed needed based on the
discussion.

> =

> I'm not totally convinced this handle all the possible edge cases
> correctly, but I am convinced it gives behaviour that's more correct
> than we have now.  It doesn't introduce changes to the interface or
> migration stream that would break things in future, so I've applied it
> to ppc-for-3.1.

There's a flaw with the patch that Greg pointed out to me previously
in that it doesn't just avoid the presave hook when vm_stop is issued
manually via monitor, but also when vm_stop is issued by the migration
code itself. The latter wasn't intentional. I'm not sure if we currently
have a good way to distinguish between the 2 cases to rectify that.

As the patch currently stands it is effectively a revert of the
Laurent's original patch.

FWIW, the RCU-related crashes mentioned in the original commit turned
out to be a separate issue that was exacerbated by RCU stall warnings
messages (which *would* be less likely with this patch). So this would
be more about user experience and spurious log messages than an actual
known bug fix. I am still of the opinion that we shouldn't resave the
clock if the vm_stop was manually-issued; it's just that the current
patch oversteps that goal.

> =

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
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
