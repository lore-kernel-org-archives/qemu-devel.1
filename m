Received: from eggs.gnu.org ([2001:4830:134:3::10]:35263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5VuN-00027P-2Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:23:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5VuJ-0003tu-1Y
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:23:55 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:53679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5VuI-0003ro-O7
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:23:50 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 35EC3EB0BC
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 13:23:45 +0200 (CEST)
Date: Tue, 2 May 2017 13:23:27 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170502132327.79ad1821@bahia>
In-Reply-To: <20170501023304.GA13773@umbus.fritz.box>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
	<149331383157.32299.15205293262497477837@loki>
	<20170501023304.GA13773@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/abt/6=rXxXz4o7Y+kYEE3jk";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv3 2/4] pseries: Move CPU compatibility
 property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, aik@ozlabs.ru, clg@kaod.org, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/abt/6=rXxXz4o7Y+kYEE3jk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 May 2017 12:33:04 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Apr 27, 2017 at 12:23:51PM -0500, Michael Roth wrote:
> > Quoting David Gibson (2017-04-27 02:28:41) =20
> > > Server class POWER CPUs have a "compat" property, which is used to se=
t the
> > > backwards compatibility mode for the processor.  However, this only m=
akes
> > > sense for machine types which don't give the guest access to hypervis=
or
> > > privilege - otherwise the compatibility level is under the guest's co=
ntrol.
> > >=20
> > > To reflect this, this removes the CPU 'compat' property and instead
> > > creates a 'max-cpu-compat' property on the pseries machine.  Strictly
> > > speaking this breaks compatibility, but AFAIK the 'compat' option was
> > > never (directly) used with -device or device_add.
> > >=20
> > > The option was used with -cpu.  So, to maintain compatibility, this p=
atch
> > > adds a hack to the cpu option parsing to strip out any compat options
> > > supplied with -cpu and set them on the machine property instead of th=
e new
> > > removed cpu property. =20
> >=20
> > "now-deprecated cpu property" maybe? =20
>=20
> Good idea.
>=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > ---
> > >  hw/ppc/spapr.c              |  6 +++-
> > >  hw/ppc/spapr_cpu_core.c     | 41 ++++++++++++++++++++--
> > >  hw/ppc/spapr_hcall.c        |  2 +-
> > >  include/hw/ppc/spapr.h      | 12 ++++---
> > >  target/ppc/compat.c         | 65 +++++++++++++++++++++++++++++++++++
> > >  target/ppc/cpu.h            |  6 ++--
> > >  target/ppc/translate_init.c | 84 +++++++++++++----------------------=
----------
> > >  7 files changed, 145 insertions(+), 71 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 80d12d0..547fa27 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2117,7 +2117,7 @@ static void ppc_spapr_init(MachineState *machin=
e)
> > >          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_def=
ault_cpu;
> > >      }
> > >=20
> > > -    ppc_cpu_parse_features(machine->cpu_model);
> > > +    spapr_cpu_parse_features(spapr);
> > >=20
> > >      spapr_init_cpus(spapr);
> > >=20
> > > @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
> > >                                      " place of standard EPOW events =
when possible"
> > >                                      " (required for memory hot-unplu=
g support)",
> > >                                      NULL);
> > > +
> > > +    object_property_add(obj, "max-cpu-compat", "str",
> > > +                        ppc_compat_prop_get, ppc_compat_prop_set,
> > > +                        NULL, &spapr->max_compat_pvr, &error_fatal);
> > >  }
> > >=20
> > >  static void spapr_machine_finalizefn(Object *obj)
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 4389ef4..ba610bc 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -20,6 +20,43 @@
> > >  #include "sysemu/numa.h"
> > >  #include "qemu/error-report.h"
> > >=20
> > > +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> > > +{
> > > +    /*
> > > +     * Backwards compatibility hack:
> > > + =20
> >=20
> > Missing "*" =20
>=20
> Oops, fixed.
>=20
> > > +     *   CPUs had a "compat=3D" property which didn't make sense for
> > > +     *   anything except pseries.  It was replaced by "max-cpu-compa=
t"
> > > +     *   machine option.  This supports old command lines like
> > > +     *       -cpu POWER8,compat=3Dpower7
> > > +     *   By stripping the compat option and applying it to the machi=
ne
> > > +     *   before passing it on to the cpu level parser.
> > > +     */
> > > +    gchar **inpieces;
> > > +    int n, i;
> > > +    gchar *compat_str =3D NULL;
> > > +
> > > +    inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> > > +    n =3D g_strv_length(inpieces);
> > > +
> > > +    /* inpieces[0] is the actual model string */ =20
> >=20
> > The comment seems a bit out of place unless we start with i =3D 1 =20
>=20
> A good point.  Yes, it should start from i=3D1.
>=20
> > > +    for (i =3D 0; i < n; i++) {
> > > +        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> > > +            compat_str =3D inpieces[i];
> > > +        }
> > > +    }
> > > +
> > > +    if (compat_str) {
> > > +        char *val =3D compat_str + strlen("compat=3D");
> > > +        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> > > +                                &error_fatal);
> > > +    }
> > > +
> > > +    ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
> > > +
> > > +    g_strfreev(inpieces);
> > > +}
> > > +
> > >  static void spapr_cpu_reset(void *opaque)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > > @@ -70,10 +107,10 @@ static void spapr_cpu_init(sPAPRMachineState *sp=
apr, PowerPCCPU *cpu,
> > >      /* Enable PAPR mode in TCG or KVM */
> > >      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> > >=20
> > > -    if (cpu->max_compat) {
> > > +    if (spapr->max_compat_pvr) {
> > >          Error *local_err =3D NULL;
> > >=20
> > > -        ppc_set_compat(cpu, cpu->max_compat, &local_err);
> > > +        ppc_set_compat(cpu, spapr->max_compat_pvr, &local_err);
> > >          if (local_err) {
> > >              error_propagate(errp, local_err);
> > >              return;
> > > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > > index 9f18f75..d4dc12b 100644
> > > --- a/hw/ppc/spapr_hcall.c
> > > +++ b/hw/ppc/spapr_hcall.c
> > > @@ -1059,7 +1059,7 @@ static target_ulong h_client_architecture_suppo=
rt(PowerPCCPU *cpu,
> > >      target_ulong list =3D ppc64_phys_to_real(args[0]);
> > >      target_ulong ov_table;
> > >      bool explicit_match =3D false; /* Matched the CPU's real PVR */
> > > -    uint32_t max_compat =3D cpu->max_compat;
> > > +    uint32_t max_compat =3D spapr->max_compat_pvr;
> > >      uint32_t best_compat =3D 0;
> > >      int i;
> > >      sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_upd=
ates;
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 5802f88..40d5f89 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -86,16 +86,19 @@ struct sPAPRMachineState {
> > >      uint64_t rtc_offset; /* Now used only during incoming migration =
*/
> > >      struct PPCTimebase tb;
> > >      bool has_graphics;
> > > -    sPAPROptionVector *ov5;         /* QEMU-supported option vectors=
 */
> > > -    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option v=
ectors */
> > > -    bool cas_reboot;
> > > -    bool cas_legacy_guest_workaround;
> > >=20
> > >      Notifier epow_notifier;
> > >      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
> > >      bool use_hotplug_event_source;
> > >      sPAPREventSource *event_sources;
> > >=20
> > > +    /* ibm,client-architecture-support option negotiation */
> > > +    bool cas_reboot;
> > > +    bool cas_legacy_guest_workaround;
> > > +    sPAPROptionVector *ov5;         /* QEMU-supported option vectors=
 */
> > > +    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option v=
ectors */
> > > +    uint32_t max_compat_pvr;
> > > +
> > >      /* Migration state */
> > >      int htab_save_index;
> > >      bool htab_first_pass;
> > > @@ -633,6 +636,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPR=
DRConnectorType drc_type,
> > >                                              uint32_t count, uint32_t=
 index);
> > >  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType =
drc_type,
> > >                                                 uint32_t count, uint3=
2_t index);
> > > +void spapr_cpu_parse_features(sPAPRMachineState *spapr);
> > >  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
> > >                                      sPAPRMachineState *spapr);
> > >=20
> > > diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> > > index e8ec1e1..476dead 100644
> > > --- a/target/ppc/compat.c
> > > +++ b/target/ppc/compat.c
> > > @@ -24,9 +24,11 @@
> > >  #include "sysemu/cpus.h"
> > >  #include "qemu/error-report.h"
> > >  #include "qapi/error.h"
> > > +#include "qapi/visitor.h"
> > >  #include "cpu-models.h"
> > >=20
> > >  typedef struct {
> > > +    const char *name;
> > >      uint32_t pvr;
> > >      uint64_t pcr;
> > >      uint64_t pcr_level;
> > > @@ -38,6 +40,7 @@ static const CompatInfo compat_table[] =3D {
> > >       * Ordered from oldest to newest - the code relies on this
> > >       */
> > >      { /* POWER6, ISA2.05 */
> > > +        .name =3D "power6",
> > >          .pvr =3D CPU_POWERPC_LOGICAL_2_05,
> > >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06=
 |
> > >                 PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
> > > @@ -45,18 +48,21 @@ static const CompatInfo compat_table[] =3D {
> > >          .max_threads =3D 2,
> > >      },
> > >      { /* POWER7, ISA2.06 */
> > > +        .name =3D "power7",
> > >          .pvr =3D CPU_POWERPC_LOGICAL_2_06,
> > >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06=
 | PCR_TM_DIS,
> > >          .pcr_level =3D PCR_COMPAT_2_06,
> > >          .max_threads =3D 4,
> > >      },
> > >      {
> > > +        .name =3D "power7+",
> > >          .pvr =3D CPU_POWERPC_LOGICAL_2_06_PLUS,
> > >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06=
 | PCR_TM_DIS,
> > >          .pcr_level =3D PCR_COMPAT_2_06,
> > >          .max_threads =3D 4,
> > >      },
> > >      { /* POWER8, ISA2.07 */
> > > +        .name =3D "power8",
> > >          .pvr =3D CPU_POWERPC_LOGICAL_2_07,
> > >          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
> > >          .pcr_level =3D PCR_COMPAT_2_07,
> > > @@ -189,3 +195,62 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
> > >=20
> > >      return n_threads;
> > >  }
> > > +
> > > +void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
> > > +                         void *opaque, Error **errp)
> > > +{
> > > +    uint32_t compat_pvr =3D *((uint32_t *)opaque);
> > > +    const char *value;
> > > +
> > > +    if (!compat_pvr) {
> > > +        value =3D "";
> > > +    } else {
> > > +        const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
> > > +
> > > +        g_assert(compat);
> > > +
> > > +        value =3D compat->name;
> > > +    }
> > > +
> > > +    visit_type_str(v, name, (char **)&value, errp);
> > > +}
> > > +
> > > +void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
> > > +                         void *opaque, Error **errp)
> > > +{
> > > +    Error *error =3D NULL;
> > > +    char *value;
> > > +    uint32_t compat_pvr;
> > > +
> > > +    visit_type_str(v, name, &value, &error);
> > > +    if (error) {
> > > +        error_propagate(errp, error);
> > > +        return;
> > > +    }
> > > +
> > > +    if (strcmp(value, "") =3D=3D 0) {
> > > +        compat_pvr =3D 0;
> > > +    } else {
> > > +        int i;
> > > +        const CompatInfo *compat =3D NULL;
> > > +
> > > +        for (i =3D 0; i < ARRAY_SIZE(compat_table); i++) {
> > > +            if (strcmp(value, compat_table[i].name) =3D=3D 0) {
> > > +                compat =3D &compat_table[i];
> > > +                break;
> > > +
> > > +            }
> > > +        }
> > > +
> > > +        if (!compat) {
> > > +            error_setg(errp, "Invalid compatibility mode \"%s\"", va=
lue);
> > > +            goto out;
> > > +        }
> > > +        compat_pvr =3D compat->pvr;
> > > +    }
> > > +
> > > +    *((uint32_t *)opaque) =3D compat_pvr;
> > > +
> > > +out:
> > > +    g_free(value);
> > > +}
> > > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > > index e0ff041..e953e75 100644
> > > --- a/target/ppc/cpu.h
> > > +++ b/target/ppc/cpu.h
> > > @@ -1185,7 +1185,6 @@ typedef struct PPCVirtualHypervisorClass PPCVir=
tualHypervisorClass;
> > >   * PowerPCCPU:
> > >   * @env: #CPUPPCState
> > >   * @cpu_dt_id: CPU index used in the device tree. KVM uses this inde=
x too
> > > - * @max_compat: Maximal supported logical PVR from the command line
> > >   * @compat_pvr: Current logical PVR, zero if in "raw" mode
> > >   *
> > >   * A PowerPC CPU.
> > > @@ -1197,7 +1196,6 @@ struct PowerPCCPU {
> > >=20
> > >      CPUPPCState env;
> > >      int cpu_dt_id;
> > > -    uint32_t max_compat;
> > >      uint32_t compat_pvr;
> > >      PPCVirtualHypervisor *vhyp;
> > >      Object *intc;
> > > @@ -1369,6 +1367,10 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t =
compat_pvr, Error **errp);
> > >  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
> > >  #endif
> > >  int ppc_compat_max_threads(PowerPCCPU *cpu);
> > > +void ppc_compat_prop_get(Object *obj, Visitor *v,
> > > +                         const char *name, void *opaque, Error **err=
);
> > > +void ppc_compat_prop_set(Object *obj, Visitor *v,
> > > +                         const char *name, void *opaque, Error **err=
);
> > >  #endif /* defined(TARGET_PPC64) */
> > >=20
> > >  #include "exec/cpu-all.h"
> > > diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> > > index e82e3e6..a92c825 100644
> > > --- a/target/ppc/translate_init.c
> > > +++ b/target/ppc/translate_init.c
> > > @@ -8413,73 +8413,35 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void=
 *data)
> > >      pcc->l1_icache_size =3D 0x10000;
> > >  }
> > >=20
> > > -static void powerpc_get_compat(Object *obj, Visitor *v, const char *=
name,
> > > -                               void *opaque, Error **errp)
> > > -{
> > > -    char *value =3D (char *)"";
> > > -    Property *prop =3D opaque;
> > > -    uint32_t *max_compat =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > > -
> > > -    switch (*max_compat) {
> > > -    case CPU_POWERPC_LOGICAL_2_05:
> > > -        value =3D (char *)"power6";
> > > -        break;
> > > -    case CPU_POWERPC_LOGICAL_2_06:
> > > -        value =3D (char *)"power7";
> > > -        break;
> > > -    case CPU_POWERPC_LOGICAL_2_07:
> > > -        value =3D (char *)"power8";
> > > -        break;
> > > -    case 0:
> > > -        break;
> > > -    default:
> > > -        error_report("Internal error: compat is set to %x", *max_com=
pat);
> > > -        abort();
> > > -        break;
> > > -    }
> > > -
> > > -    visit_type_str(v, name, &value, errp);
> > > -}
> > > -
> > > -static void powerpc_set_compat(Object *obj, Visitor *v, const char *=
name,
> > > -                               void *opaque, Error **errp)
> > > +/*
> > > + * The CPU used to have a "compat" property which set the
> > > + * compatibility mode PVR.  However, this was conceptually broken - =
it
> > > + * only makes sense on the pseries machine type (otherwise the guest
> > > + * owns the PCR and can control the compatibility mode itself).  It's
> > > + * been replaced with the 'max-cpu-compat' property on the pseries
> > > + * machine type.  For backwards compatibility, pseries specially
> > > + * parses the -cpu parameter and converts old compat=3D parameters i=
nto
> > > + * the appropriate machine parameters.  This stub implementation of
> > > + * the parameter catches any uses on explicitly created CPUs.
> > > + */
> > > +static void getset_compat_deprecated(Object *obj, Visitor *v, const =
char *name,
> > > +                                     void *opaque, Error **errp)
> > >  {
> > > -    Error *error =3D NULL;
> > > -    char *value =3D NULL;
> > > -    Property *prop =3D opaque;
> > > -    uint32_t *max_compat =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> > > -
> > > -    visit_type_str(v, name, &value, &error);
> > > -    if (error) {
> > > -        error_propagate(errp, error);
> > > -        return;
> > > -    }
> > > -
> > > -    if (strcmp(value, "power6") =3D=3D 0) {
> > > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_05;
> > > -    } else if (strcmp(value, "power7") =3D=3D 0) {
> > > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_06;
> > > -    } else if (strcmp(value, "power8") =3D=3D 0) {
> > > -        *max_compat =3D CPU_POWERPC_LOGICAL_2_07;
> > > -    } else {
> > > -        error_setg(errp, "Invalid compatibility mode \"%s\"", value);
> > > -    }
> > > -
> > > -    g_free(value);
> > > +    error_report("CPU 'compat' property is deprecated and has no eff=
ect; use max-cpu-compat machine property instead"); =20
> >=20
> > Isn't the "and has no effect" portion a bit misleading? AFAICT it does
> > have an effect still, it just shouldn't be used anymore. =20
>=20
> No.  Used as a property on the CPU object it really does have no
> effect.  It's just that if you attach it to -cpu XXX, rather than to a
> -device specific-cpu-type, then it gets automatically translated to
> the new machine property.  These calls should only be triggered in the
> second case.
>=20

But they also get triggered in the -cpu case... When passing

-cpu host,compat=3Dpower7 -machine type=3Dpseries,accel=3Dkvm

one gets:

qemu-system-ppc64: CPU 'compat' property is deprecated and has no effect; u=
se max-cpu-compat machine property instead
qemu-system-ppc64: can't apply global host-powerpc64-cpu.compat=3Dpower7: I=
nvalid parameter type for 'compat', expected: null

> > > +    visit_type_null(v, name, errp);

Because the null string input visitor from patch 1/4 expects an empty
string:

+    if (!siv->string || siv->string[0]) {
+        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
+                   "null");
+    }

and the error gets propagated all the way up.

I had suggested to break the propagation with:

+    visit_type_null(v, name, NULL);

You can find the discussion here:

http://patchwork.ozlabs.org/patch/705734/

> > >  }
> > >=20
> > > -static PropertyInfo powerpc_compat_propinfo =3D {
> > > +static PropertyInfo ppc_compat_deprecated_propinfo =3D {
> > >      .name =3D "str",
> > > -    .description =3D "compatibility mode, power6/power7/power8",
> > > -    .get =3D powerpc_get_compat,
> > > -    .set =3D powerpc_set_compat,
> > > +    .description =3D "compatibility mode (deprecated)",
> > > +    .get =3D getset_compat_deprecated,
> > > +    .set =3D getset_compat_deprecated,
> > >  };
> > > -
> > > -#define DEFINE_PROP_POWERPC_COMPAT(_n, _s, _f) \
> > > -    DEFINE_PROP(_n, _s, _f, powerpc_compat_propinfo, uint32_t)
> > > -
> > >  static Property powerpc_servercpu_properties[] =3D {
> > > -    DEFINE_PROP_POWERPC_COMPAT("compat", PowerPCCPU, max_compat),
> > > +    {
> > > +        .name =3D "compat",
> > > +        .info =3D &ppc_compat_deprecated_propinfo,
> > > +    },
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  =20
> >  =20
>=20


--Sig_/abt/6=rXxXz4o7Y+kYEE3jk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkIbC8ACgkQAvw66wEB28JObQCeI6RIyvqhwW4Izpk/sEYvzdly
jbIAn3GEtt7rbYGlejzueSz8w/vFW6Tr
=6aKp
-----END PGP SIGNATURE-----

--Sig_/abt/6=rXxXz4o7Y+kYEE3jk--
