Received: from eggs.gnu.org ([2001:4830:134:3::10]:41151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fnk9m-0000nc-L3
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fnk9i-0002mk-MR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 08:35:10 -0400
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180809002335.GK7429@umbus.fritz.box>
References: <20180808155919.12972-1-bharata@linux.ibm.com>
	<20180809002335.GK7429@umbus.fritz.box>
Message-ID: <153381809870.13636.6434595806199633248@sif>
Date: Thu, 09 Aug 2018 07:34:58 -0500
Subject: Re: [Qemu-devel] [PATCH] spapr_cpu_core: vmstate_[un]register
 per-CPU data from (un)realizefn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, groug@kaod.org, sathnaga@linux.vnet.ibm.com, qemu-stable@nongnu.org

Quoting David Gibson (2018-08-08 19:23:35)
> On Wed, Aug 08, 2018 at 09:29:19PM +0530, Bharata B Rao wrote:
> > VMStateDescription vmstate_spapr_cpu_state was added by commit
> > b94020268e0b6 (spapr_cpu_core: migrate per-CPU data) to migrate per-CPU
> > data with the required vmstate registration and unregistration calls.
> > However the unregistration is being done only from vcpu creation error =
path
> > and not from CPU delete path.
> > =

> > This causes migration to fail with the following error if migration is
> > attempted after a CPU unplug like this:
> > Unknown savevm section or instance 'spapr_cpu' 16
> > Additionally this leaves the source VM unresponsive after migration fai=
lure.
> > =

> > Fix this by ensuring the vmstate_unregister happens during CPU removal.
> > Fixing this becomes easier when vmstate (un)registration calls are move=
d to
> > vcpu (un)realize functions which is what this patch does.
> > =

> > Fixes: https://bugs.launchpad.net/qemu/+bug/1785972
> > Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> =

> Applied to ppc-for-3.1.
> =

> Unfortunately, despite being a clear regression, I think it's too late
> for 3.0 :(.
> =

> Mike, can you queue this for 3.0.1 as too, thanks?

Sure, will do.

> =

> > ---
> >  hw/ppc/spapr_cpu_core.c | 62 +++++++++++++++++++++++++----------------=
--------
> >  1 file changed, 32 insertions(+), 30 deletions(-)
> > =

> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 993759db47..bb88a3ce4e 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -113,26 +113,6 @@ const char *spapr_get_cpu_core_type(const char *cp=
u_type)
> >      return object_class_get_name(oc);
> >  }
> >  =

> > -static void spapr_unrealize_vcpu(PowerPCCPU *cpu)
> > -{
> > -    qemu_unregister_reset(spapr_cpu_reset, cpu);
> > -    object_unparent(cpu->intc);
> > -    cpu_remove_sync(CPU(cpu));
> > -    object_unparent(OBJECT(cpu));
> > -}
> > -
> > -static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
> > -{
> > -    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > -    CPUCore *cc =3D CPU_CORE(dev);
> > -    int i;
> > -
> > -    for (i =3D 0; i < cc->nr_threads; i++) {
> > -        spapr_unrealize_vcpu(sc->threads[i]);
> > -    }
> > -    g_free(sc->threads);
> > -}
> > -
> >  static bool slb_shadow_needed(void *opaque)
> >  {
> >      sPAPRCPUState *spapr_cpu =3D opaque;
> > @@ -207,10 +187,34 @@ static const VMStateDescription vmstate_spapr_cpu=
_state =3D {
> >      }
> >  };
> >  =

> > +static void spapr_unrealize_vcpu(PowerPCCPU *cpu, sPAPRCPUCore *sc)
> > +{
> > +    if (!sc->pre_3_0_migration) {
> > +        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machin=
e_data);
> > +    }
> > +    qemu_unregister_reset(spapr_cpu_reset, cpu);
> > +    object_unparent(cpu->intc);
> > +    cpu_remove_sync(CPU(cpu));
> > +    object_unparent(OBJECT(cpu));
> > +}
> > +
> > +static void spapr_cpu_core_unrealize(DeviceState *dev, Error **errp)
> > +{
> > +    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(OBJECT(dev));
> > +    CPUCore *cc =3D CPU_CORE(dev);
> > +    int i;
> > +
> > +    for (i =3D 0; i < cc->nr_threads; i++) {
> > +        spapr_unrealize_vcpu(sc->threads[i], sc);
> > +    }
> > +    g_free(sc->threads);
> > +}
> > +
> >  static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spa=
pr,
> > -                               Error **errp)
> > +                               sPAPRCPUCore *sc, Error **errp)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > +    CPUState *cs =3D CPU(cpu);
> >      Error *local_err =3D NULL;
> >  =

> >      object_property_set_bool(OBJECT(cpu), true, "realized", &local_err=
);
> > @@ -233,6 +237,11 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sP=
APRMachineState *spapr,
> >          goto error_unregister;
> >      }
> >  =

> > +    if (!sc->pre_3_0_migration) {
> > +        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
> > +                         cpu->machine_data);
> > +    }
> > +
> >      return;
> >  =

> >  error_unregister:
> > @@ -272,10 +281,6 @@ static PowerPCCPU *spapr_create_vcpu(sPAPRCPUCore =
*sc, int i, Error **errp)
> >      }
> >  =

> >      cpu->machine_data =3D g_new0(sPAPRCPUState, 1);
> > -    if (!sc->pre_3_0_migration) {
> > -        vmstate_register(NULL, cs->cpu_index, &vmstate_spapr_cpu_state,
> > -                         cpu->machine_data);
> > -    }
> >  =

> >      object_unref(obj);
> >      return cpu;
> > @@ -290,9 +295,6 @@ static void spapr_delete_vcpu(PowerPCCPU *cpu, sPAP=
RCPUCore *sc)
> >  {
> >      sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
> >  =

> > -    if (!sc->pre_3_0_migration) {
> > -        vmstate_unregister(NULL, &vmstate_spapr_cpu_state, cpu->machin=
e_data);
> > -    }
> >      cpu->machine_data =3D NULL;
> >      g_free(spapr_cpu);
> >      object_unparent(OBJECT(cpu));
> > @@ -325,7 +327,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >      }
> >  =

> >      for (j =3D 0; j < cc->nr_threads; j++) {
> > -        spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
> > +        spapr_realize_vcpu(sc->threads[j], spapr, sc, &local_err);
> >          if (local_err) {
> >              goto err_unrealize;
> >          }
> > @@ -334,7 +336,7 @@ static void spapr_cpu_core_realize(DeviceState *dev=
, Error **errp)
> >  =

> >  err_unrealize:
> >      while (--j >=3D 0) {
> > -        spapr_unrealize_vcpu(sc->threads[j]);
> > +        spapr_unrealize_vcpu(sc->threads[j], sc);
> >      }
> >  err:
> >      while (--i >=3D 0) {
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
