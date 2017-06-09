Received: from eggs.gnu.org ([2001:4830:134:3::10]:41957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJKOf-0000qJ-8t
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dJKOb-0007Oa-8i
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:56:17 -0400
Received: from 1.mo178.mail-out.ovh.net ([178.33.251.53]:52967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dJKOa-0007O2-Uv
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:56:13 -0400
Received: from player728.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 28F373ED20
	for <qemu-devel@nongnu.org>; Fri,  9 Jun 2017 15:56:10 +0200 (CEST)
Date: Fri, 9 Jun 2017 15:55:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170609155556.1447e151@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170602031507.29881-3-david@gibson.dropbear.id.au>
References: <20170602031507.29881-1-david@gibson.dropbear.id.au>
	<20170602031507.29881-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Nm.U7E3s8ZJuIAzq8FWEypw";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv5 2/4] pseries: Move CPU compatibility
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
Cc: clg@kaod.org, mdroth@linux.vnet.ibm.com, sursingh@redhat.com, bharata@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, abologna@redhat.com, sbobroff@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/Nm.U7E3s8ZJuIAzq8FWEypw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri,  2 Jun 2017 13:15:05 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Server class POWER CPUs have a "compat" property, which is used to set the
> backwards compatibility mode for the processor.  However, this only makes
> sense for machine types which don't give the guest access to hypervisor
> privilege - otherwise the compatibility level is under the guest's contro=
l.
>=20
> To reflect this, this removes the CPU 'compat' property and instead
> creates a 'max-cpu-compat' property on the pseries machine.  Strictly
> speaking this breaks compatibility, but AFAIK the 'compat' option was
> never (directly) used with -device or device_add.
>=20
> The option was used with -cpu.  So, to maintain compatibility, this
> patch adds a hack to the cpu option parsing to strip out any compat
> options supplied with -cpu and set them on the machine property
> instead of the now deprecated cpu property.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Just one trivial style nit in ppc_compat_prop_set().

Reviewed-by: Greg Kurz <groug@kaod.org>

and

Tested-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c              |   6 ++-
>  hw/ppc/spapr_cpu_core.c     |  55 +++++++++++++++++++++++-
>  hw/ppc/spapr_hcall.c        |   8 ++--
>  include/hw/ppc/spapr.h      |  12 ++++--
>  target/ppc/compat.c         | 102 ++++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/cpu.h            |   5 ++-
>  target/ppc/translate_init.c |  86 +++++++++++--------------------------
>  7 files changed, 201 insertions(+), 73 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ab3aab1..3c4e88f 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2134,7 +2134,7 @@ static void ppc_spapr_init(MachineState *machine)
>          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_default=
_cpu;
>      }
> =20
> -    ppc_cpu_parse_features(machine->cpu_model);
> +    spapr_cpu_parse_features(spapr);
> =20
>      spapr_init_cpus(spapr);
> =20
> @@ -2497,6 +2497,10 @@ static void spapr_machine_initfn(Object *obj)
>                                      " place of standard EPOW events when=
 possible"
>                                      " (required for memory hot-unplug su=
pport)",
>                                      NULL);
> +
> +    ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pv=
r,
> +                            "Maximum permitted CPU compatibility mode",
> +                            &error_fatal);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index ff7058e..846d9e7 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -20,6 +20,57 @@
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
> =20
> +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> +{
> +    /*
> +     * Backwards compatibility hack:
> +     *
> +     *   CPUs had a "compat=3D" property which didn't make sense for
> +     *   anything except pseries.  It was replaced by "max-cpu-compat"
> +     *   machine option.  This supports old command lines like
> +     *       -cpu POWER8,compat=3Dpower7
> +     *   By stripping the compat option and applying it to the machine
> +     *   before passing it on to the cpu level parser.
> +     */
> +    gchar **inpieces;
> +    int i, j;
> +    gchar *compat_str =3D NULL;
> +
> +    inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> +
> +    /* inpieces[0] is the actual model string */
> +    i =3D 1;
> +    j =3D 1;
> +    while (inpieces[i]) {
> +        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> +            /* in case of multiple compat=3D options */
> +            g_free(compat_str);
> +            compat_str =3D inpieces[i];
> +        } else {
> +            j++;
> +        }
> +
> +        i++;
> +        /* Excise compat options from list */
> +        inpieces[j] =3D inpieces[i];
> +    }
> +
> +    if (compat_str) {
> +        char *val =3D compat_str + strlen("compat=3D");
> +        gchar *newprops =3D g_strjoinv(",", inpieces);
> +
> +        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> +                                &error_fatal);
> +
> +        ppc_cpu_parse_features(newprops);
> +        g_free(newprops);
> +    } else {
> +        ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
> +    }
> +
> +    g_strfreev(inpieces);
> +}
> +
>  static void spapr_cpu_reset(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -70,10 +121,10 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
>      /* Enable PAPR mode in TCG or KVM */
>      cpu_ppc_set_papr(cpu, PPC_VIRTUAL_HYPERVISOR(spapr));
> =20
> -    if (cpu->max_compat) {
> +    if (spapr->max_compat_pvr) {
>          Error *local_err =3D NULL;
> =20
> -        ppc_set_compat(cpu, cpu->max_compat, &local_err);
> +        ppc_set_compat(cpu, spapr->max_compat_pvr, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index aae5a62..a9bb3ed 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1044,11 +1044,11 @@ static target_ulong h_signal_sys_reset(PowerPCCPU=
 *cpu,
>      }
>  }
> =20
> -static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
> -                              Error **errp)
> +static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> +                              target_ulong *addr, Error **errp)
>  {
>      bool explicit_match =3D false; /* Matched the CPU's real PVR */
> -    uint32_t max_compat =3D cpu->max_compat;
> +    uint32_t max_compat =3D spapr->max_compat_pvr;
>      uint32_t best_compat =3D 0;
>      int i;
> =20
> @@ -1104,7 +1104,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      bool guest_radix;
>      Error *local_err =3D NULL;
> =20
> -    cas_pvr =3D cas_check_pvr(cpu, &addr, &local_err);
> +    cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &local_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return H_HARDWARE;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 98fb78b..4da92e2 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -87,16 +87,19 @@ struct sPAPRMachineState {
>      uint64_t rtc_offset; /* Now used only during incoming migration */
>      struct PPCTimebase tb;
>      bool has_graphics;
> -    sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
> -    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
> -    bool cas_reboot;
> -    bool cas_legacy_guest_workaround;
> =20
>      Notifier epow_notifier;
>      QTAILQ_HEAD(, sPAPREventLogEntry) pending_events;
>      bool use_hotplug_event_source;
>      sPAPREventSource *event_sources;
> =20
> +    /* ibm,client-architecture-support option negotiation */
> +    bool cas_reboot;
> +    bool cas_legacy_guest_workaround;
> +    sPAPROptionVector *ov5;         /* QEMU-supported option vectors */
> +    sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option vecto=
rs */
> +    uint32_t max_compat_pvr;
> +
>      /* Migration state */
>      int htab_save_index;
>      bool htab_first_pass;
> @@ -639,6 +642,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRCo=
nnectorType drc_type,
>                                              uint32_t count, uint32_t ind=
ex);
>  void spapr_hotplug_req_remove_by_count_indexed(sPAPRDRConnectorType drc_=
type,
>                                                 uint32_t count, uint32_t =
index);
> +void spapr_cpu_parse_features(sPAPRMachineState *spapr);
>  void *spapr_populate_hotplug_cpu_dt(CPUState *cs, int *fdt_offset,
>                                      sPAPRMachineState *spapr);
> =20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index e8ec1e1..e72839f 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -24,9 +24,11 @@
>  #include "sysemu/cpus.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> +#include "qapi/visitor.h"
>  #include "cpu-models.h"
> =20
>  typedef struct {
> +    const char *name;
>      uint32_t pvr;
>      uint64_t pcr;
>      uint64_t pcr_level;
> @@ -38,6 +40,7 @@ static const CompatInfo compat_table[] =3D {
>       * Ordered from oldest to newest - the code relies on this
>       */
>      { /* POWER6, ISA2.05 */
> +        .name =3D "power6",
>          .pvr =3D CPU_POWERPC_LOGICAL_2_05,
>          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 |
>                 PCR_COMPAT_2_05 | PCR_TM_DIS | PCR_VSX_DIS,
> @@ -45,24 +48,28 @@ static const CompatInfo compat_table[] =3D {
>          .max_threads =3D 2,
>      },
>      { /* POWER7, ISA2.06 */
> +        .name =3D "power7",
>          .pvr =3D CPU_POWERPC_LOGICAL_2_06,
>          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | P=
CR_TM_DIS,
>          .pcr_level =3D PCR_COMPAT_2_06,
>          .max_threads =3D 4,
>      },
>      {
> +        .name =3D "power7+",
>          .pvr =3D CPU_POWERPC_LOGICAL_2_06_PLUS,
>          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07 | PCR_COMPAT_2_06 | P=
CR_TM_DIS,
>          .pcr_level =3D PCR_COMPAT_2_06,
>          .max_threads =3D 4,
>      },
>      { /* POWER8, ISA2.07 */
> +        .name =3D "power8",
>          .pvr =3D CPU_POWERPC_LOGICAL_2_07,
>          .pcr =3D PCR_COMPAT_3_00 | PCR_COMPAT_2_07,
>          .pcr_level =3D PCR_COMPAT_2_07,
>          .max_threads =3D 8,
>      },
>      { /* POWER9, ISA3.00 */
> +        .name =3D "power9",
>          .pvr =3D CPU_POWERPC_LOGICAL_3_00,
>          .pcr =3D PCR_COMPAT_3_00,
>          .pcr_level =3D PCR_COMPAT_3_00,
> @@ -189,3 +196,98 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
> =20
>      return n_threads;
>  }
> +
> +static void ppc_compat_prop_get(Object *obj, Visitor *v, const char *nam=
e,
> +                                void *opaque, Error **errp)
> +{
> +    uint32_t compat_pvr =3D *((uint32_t *)opaque);
> +    const char *value;
> +
> +    if (!compat_pvr) {
> +        value =3D "";
> +    } else {
> +        const CompatInfo *compat =3D compat_by_pvr(compat_pvr);
> +
> +        g_assert(compat);
> +
> +        value =3D compat->name;
> +    }
> +
> +    visit_type_str(v, name, (char **)&value, errp);
> +}
> +
> +static void ppc_compat_prop_set(Object *obj, Visitor *v, const char *nam=
e,
> +                                void *opaque, Error **errp)
> +{
> +    Error *error =3D NULL;

s/error/local_error maybe ? For consistency with ppc_compat_add_property() =
below.

> +    char *value;
> +    uint32_t compat_pvr;
> +
> +    visit_type_str(v, name, &value, &error);
> +    if (error) {
> +        error_propagate(errp, error);
> +        return;
> +    }
> +
> +    if (strcmp(value, "") =3D=3D 0) {
> +        compat_pvr =3D 0;
> +    } else {
> +        int i;
> +        const CompatInfo *compat =3D NULL;
> +
> +        for (i =3D 0; i < ARRAY_SIZE(compat_table); i++) {
> +            if (strcmp(value, compat_table[i].name) =3D=3D 0) {
> +                compat =3D &compat_table[i];
> +                break;
> +
> +            }
> +        }
> +
> +        if (!compat) {
> +            error_setg(errp, "Invalid compatibility mode \"%s\"", value);
> +            goto out;
> +        }
> +        compat_pvr =3D compat->pvr;
> +    }
> +
> +    *((uint32_t *)opaque) =3D compat_pvr;
> +
> +out:
> +    g_free(value);
> +}
> +
> +void ppc_compat_add_property(Object *obj, const char *name,
> +                             uint32_t *compat_pvr, const char *basedesc,
> +                             Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    gchar *namesv[ARRAY_SIZE(compat_table) + 1];
> +    gchar *names, *desc;
> +    int i;
> +
> +    object_property_add(obj, name, "string",
> +                        ppc_compat_prop_get, ppc_compat_prop_set, NULL,
> +                        compat_pvr, &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
> +    for (i =3D 0; i < ARRAY_SIZE(compat_table); i++) {
> +        /*
> +         * Have to discard const here, because g_strjoinv() takes
> +         * (gchar **), not (const gchar **) :(
> +         */
> +        namesv[i] =3D (gchar *)compat_table[i].name;
> +    }
> +    namesv[ARRAY_SIZE(compat_table)] =3D NULL;
> +
> +    names =3D g_strjoinv(", ", namesv);
> +    desc =3D g_strdup_printf("%s. Valid values are %s.", basedesc, names=
);
> +    object_property_set_description(obj, name, desc, &local_err);
> +
> +    g_free(names);
> +    g_free(desc);
> +
> +out:
> +    error_propagate(errp, local_err);
> +}
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 401e10e..4517b4b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1189,7 +1189,6 @@ typedef struct PPCVirtualHypervisorClass PPCVirtual=
HypervisorClass;
>   * PowerPCCPU:
>   * @env: #CPUPPCState
>   * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
> - * @max_compat: Maximal supported logical PVR from the command line
>   * @compat_pvr: Current logical PVR, zero if in "raw" mode
>   *
>   * A PowerPC CPU.
> @@ -1201,7 +1200,6 @@ struct PowerPCCPU {
> =20
>      CPUPPCState env;
>      int cpu_dt_id;
> -    uint32_t max_compat;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
> @@ -1374,6 +1372,9 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compa=
t_pvr, Error **errp);
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
>  #endif
>  int ppc_compat_max_threads(PowerPCCPU *cpu);
> +void ppc_compat_add_property(Object *obj, const char *name,
> +                             uint32_t *compat_pvr, const char *basedesc,
> +                             Error **errp);
>  #endif /* defined(TARGET_PPC64) */
> =20
>  #include "exec/cpu-all.h"
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 56a0ab2..e837cd2 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -33,6 +33,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/ppc/ppc.h"
>  #include "mmu-book3s-v3.h"
> +#include "sysemu/qtest.h"
> =20
>  //#define PPC_DUMP_CPU
>  //#define PPC_DEBUG_SPR
> @@ -8413,73 +8414,38 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *da=
ta)
>      pcc->l1_icache_size =3D 0x10000;
>  }
> =20
> -static void powerpc_get_compat(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> -{
> -    char *value =3D (char *)"";
> -    Property *prop =3D opaque;
> -    uint32_t *max_compat =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> -
> -    switch (*max_compat) {
> -    case CPU_POWERPC_LOGICAL_2_05:
> -        value =3D (char *)"power6";
> -        break;
> -    case CPU_POWERPC_LOGICAL_2_06:
> -        value =3D (char *)"power7";
> -        break;
> -    case CPU_POWERPC_LOGICAL_2_07:
> -        value =3D (char *)"power8";
> -        break;
> -    case 0:
> -        break;
> -    default:
> -        error_report("Internal error: compat is set to %x", *max_compat);
> -        abort();
> -        break;
> -    }
> -
> -    visit_type_str(v, name, &value, errp);
> -}
> -
> -static void powerpc_set_compat(Object *obj, Visitor *v, const char *name,
> -                               void *opaque, Error **errp)
> +/*
> + * The CPU used to have a "compat" property which set the
> + * compatibility mode PVR.  However, this was conceptually broken - it
> + * only makes sense on the pseries machine type (otherwise the guest
> + * owns the PCR and can control the compatibility mode itself).  It's
> + * been replaced with the 'max-cpu-compat' property on the pseries
> + * machine type.  For backwards compatibility, pseries specially
> + * parses the -cpu parameter and converts old compat=3D parameters into
> + * the appropriate machine parameters.  This stub implementation of
> + * the parameter catches any uses on explicitly created CPUs.
> + */
> +static void getset_compat_deprecated(Object *obj, Visitor *v, const char=
 *name,
> +                                     void *opaque, Error **errp)
>  {
> -    Error *error =3D NULL;
> -    char *value =3D NULL;
> -    Property *prop =3D opaque;
> -    uint32_t *max_compat =3D qdev_get_prop_ptr(DEVICE(obj), prop);
> -
> -    visit_type_str(v, name, &value, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> -        return;
> -    }
> -
> -    if (strcmp(value, "power6") =3D=3D 0) {
> -        *max_compat =3D CPU_POWERPC_LOGICAL_2_05;
> -    } else if (strcmp(value, "power7") =3D=3D 0) {
> -        *max_compat =3D CPU_POWERPC_LOGICAL_2_06;
> -    } else if (strcmp(value, "power8") =3D=3D 0) {
> -        *max_compat =3D CPU_POWERPC_LOGICAL_2_07;
> -    } else {
> -        error_setg(errp, "Invalid compatibility mode \"%s\"", value);
> +    if (!qtest_enabled()) {
> +        error_report("CPU 'compat' property is deprecated and has no eff=
ect; "
> +                     "use max-cpu-compat machine property instead");
>      }
> -
> -    g_free(value);
> +    visit_type_null(v, name, NULL);
>  }
> =20
> -static PropertyInfo powerpc_compat_propinfo =3D {
> +static PropertyInfo ppc_compat_deprecated_propinfo =3D {
>      .name =3D "str",
> -    .description =3D "compatibility mode, power6/power7/power8",
> -    .get =3D powerpc_get_compat,
> -    .set =3D powerpc_set_compat,
> +    .description =3D "compatibility mode (deprecated)",
> +    .get =3D getset_compat_deprecated,
> +    .set =3D getset_compat_deprecated,
>  };
> -
> -#define DEFINE_PROP_POWERPC_COMPAT(_n, _s, _f) \
> -    DEFINE_PROP(_n, _s, _f, powerpc_compat_propinfo, uint32_t)
> -
>  static Property powerpc_servercpu_properties[] =3D {
> -    DEFINE_PROP_POWERPC_COMPAT("compat", PowerPCCPU, max_compat),
> +    {
> +        .name =3D "compat",
> +        .info =3D &ppc_compat_deprecated_propinfo,
> +    },
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20


--Sig_/Nm.U7E3s8ZJuIAzq8FWEypw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk6qOwACgkQAvw66wEB28KiEACglw8GCN8yKCoMn+k3HU0XuD8D
LRgAoJMqkQROntK1IjeSpkUOvnVgonne
=adhS
-----END PGP SIGNATURE-----

--Sig_/Nm.U7E3s8ZJuIAzq8FWEypw--
