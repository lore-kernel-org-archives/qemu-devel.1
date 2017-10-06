Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0OBg-0001gr-84
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1e0OBc-00036O-Se
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 04:40:52 -0400
Date: Fri, 6 Oct 2017 10:40:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171006104044.582876b8@nial.brq.redhat.com>
In-Reply-To: <20171005210537.0632f841@bahia.lan>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-13-git-send-email-imammedo@redhat.com>
	<20171005210537.0632f841@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 12/23] ppc: move '-cpu foo,
 compat=xxx' parsing into ppc_cpu_parse_featurestr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "open list:ppce500" <qemu-ppc@nongnu.org>, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

On Thu, 5 Oct 2017 21:05:37 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu,  5 Oct 2017 18:24:39 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > there is a dedicated callback CPUClass::parse_features
> > which purpose is to convert -cpu features into a set of
> > global properties AND deal with compat/legacy features
> > that couldn't be directly translated into CPU's properties.
> > 
> > Create ppc variant of it (ppc_cpu_parse_featurestr) and
> > move 'compat=val' handling from spapr_cpu_core.c into it.
> > That removes a dependency of board/core code on cpu_model
> > parsing and would let to reuse common -cpu parsing
> > introduced by 6063d4c0
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/ppc/spapr.h      |  1 -
> >  target/ppc/cpu-qom.h        |  1 +
> >  hw/ppc/spapr.c              |  2 +-
> >  hw/ppc/spapr_cpu_core.c     | 50 --------------------------------------
> >  target/ppc/translate_init.c | 58 +++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 60 insertions(+), 52 deletions(-)
> > 
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index c1b365f..8ca4f94 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -659,7 +659,6 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRConnectorType drc_type,
> >                                              uint32_t count, uint32_t index);
> >  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_type,
> >                                                 uint32_t count, uint32_t index);
> > -void spapr_cpu_parse_features(sPAPRMachineState *spapr);
> >  int spapr_hpt_shift_for_ramsize(uint64_t ramsize);
> >  void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
> >                            Error **errp);
> > diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> > index d0cf6ca..429b47f 100644
> > --- a/target/ppc/cpu-qom.h
> > +++ b/target/ppc/cpu-qom.h
> > @@ -181,6 +181,7 @@ typedef struct PowerPCCPUClass {
> >      DeviceRealize parent_realize;
> >      DeviceUnrealize parent_unrealize;
> >      void (*parent_reset)(CPUState *cpu);
> > +    void (*parent_parse_features)(const char *type, char *str, Error **errp);
> >  
> >      uint32_t pvr;
> >      bool (*pvr_match)(struct PowerPCCPUClass *pcc, uint32_t pvr);
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index ff87f15..01b3012 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2366,7 +2366,7 @@ static void ppc_spapr_init(MachineState *machine)
> >          machine->cpu_model = kvm_enabled() ? "host" : smc->tcg_default_cpu;
> >      }
> >  
> > -    spapr_cpu_parse_features(spapr);
> > +    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
> >  
> >      spapr_set_vsmt_mode(spapr, &error_fatal);
> >  
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 3dea5ff..427d47f 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -21,56 +21,6 @@
> >  #include "sysemu/hw_accel.h"
> >  #include "qemu/error-report.h"
> >  
> > -void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > -{
> > -    /*
> > -     * Backwards compatibility hack:
> > -     *
> > -     *   CPUs had a "compat=" property which didn't make sense for
> > -     *   anything except pseries.  It was replaced by "max-cpu-compat"
> > -     *   machine option.  This supports old command lines like
> > -     *       -cpu POWER8,compat=power7
> > -     *   By stripping the compat option and applying it to the machine
> > -     *   before passing it on to the cpu level parser.
> > -     */
> > -    gchar **inpieces;
> > -    gchar *newprops;
> > -    int i, j;
> > -    gchar *compat_str = NULL;
> > -
> > -    inpieces = g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> > -
> > -    /* inpieces[0] is the actual model string */
> > -    i = 1;
> > -    j = 1;
> > -    while (inpieces[i]) {
> > -        if (g_str_has_prefix(inpieces[i], "compat=")) {
> > -            /* in case of multiple compat= options */
> > -            g_free(compat_str);
> > -            compat_str = inpieces[i];
> > -        } else {
> > -            j++;
> > -        }
> > -
> > -        i++;
> > -        /* Excise compat options from list */
> > -        inpieces[j] = inpieces[i];
> > -    }
> > -
> > -    if (compat_str) {
> > -        char *val = compat_str + strlen("compat=");
> > -
> > -        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> > -                                &error_fatal);
> > -
> > -    }
> > -
> > -    newprops = g_strjoinv(",", inpieces);
> > -    cpu_parse_cpu_model(TYPE_POWERPC_CPU, newprops);
> > -    g_free(newprops);
> > -    g_strfreev(inpieces);
> > -}
> > -
> >  static void spapr_cpu_reset(void *opaque)
> >  {
> >      PowerPCCPU *cpu = opaque;
> > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > index c6399a3..5ee91e8 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -10313,6 +10313,62 @@ static ObjectClass *ppc_cpu_class_by_name(const char *name)
> >  
> >      return NULL;
> >  }  
> 
> Maybe add en empty line here ?
sure

> 
> > +static void ppc_cpu_parse_featurestr(const char *typename, char *features,
> > +                                     Error **errp)
> > +{
> > +    const PowerPCCPUClass *pcc;
> > +    char *compat_str = NULL;
> > +    char *s = features;
> > +    char **inpieces;
> > +    Error *local_err = NULL;
> > +    int i;
> > +
> > +    if (!features) {
> > +        return;
> > +    }
> > +
> > +    /*
> > +     * Backwards compatibility hack:
> > +     *
> > +     *   CPUs had a "compat=" property which didn't make sense for
> > +     *   anything except pseries.  It was replaced by "max-cpu-compat"
> > +     *   machine option.  This supports old command lines like
> > +     *       -cpu POWER8,compat=power7
> > +     *   By stripping the compat option and applying it to the machine
> > +     *   before passing it on to the cpu level parser.
> > +     */
> > +    inpieces = g_strsplit(features, ",", 0);
> > +    *s = '\0';
> > +    for (i = 0; inpieces[i]; i++) {
> > +        if (g_str_has_prefix(inpieces[i], "compat=")) {
> > +            compat_str = inpieces[i];
> > +            continue;
> > +        }
> > +        if ((i != 0) && (s != features)) {
> > +            s = g_stpcpy(s, ",");
> > +        }
> > +        s = g_stpcpy(s, inpieces[i]);
> > +    }
> > +
> > +    if (compat_str) {
> > +        Object *machine = qdev_get_machine();
> > +        if (machine) {  
> 
> Can qdev_get_machine() return NULL really ? Shouldn't this be
> object_dynamic_cast(machine, TYPE_MACHINE) instead, in case
> we're running a user-only emulator ?
ok, I'll fix it like suggested

> 
> > +            char *v = compat_str + strlen("compat=");
> > +            object_property_set_str(machine, v, "max-cpu-compat", &local_err);
> > +        } else {
> > +            error_setg(&local_err, "Not supported property: %s", compat_str);
> > +        }
> > +    }
> > +    g_strfreev(inpieces);
> > +    if (local_err) {
> > +        error_propagate(errp, local_err);
> > +        return;
> > +    }
> > +
> > +    /* do property processing with generic handler */
> > +    pcc = POWERPC_CPU_CLASS(object_class_by_name(typename));
> > +    pcc->parent_parse_features(typename, features, errp);
> > +}
> >  
> >  const char *ppc_cpu_lookup_alias(const char *alias)
> >  {
> > @@ -10706,6 +10762,8 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
> >      cc->reset = ppc_cpu_reset;
> >  
> >      cc->class_by_name = ppc_cpu_class_by_name;
> > +    pcc->parent_parse_features = cc->parse_features;
> > +    cc->parse_features = ppc_cpu_parse_featurestr;
> >      cc->has_work = ppc_cpu_has_work;
> >      cc->do_interrupt = ppc_cpu_do_interrupt;
> >      cc->cpu_exec_interrupt = ppc_cpu_exec_interrupt;  
> 
