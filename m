Received: from eggs.gnu.org ([2001:4830:134:3::10]:51651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6Deu-0001Mb-W1
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:06:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d6Deq-0007VN-Qc
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:06:52 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:55043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d6Deq-0007Ti-G9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:06:48 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EDC6CEBA46
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 12:06:46 +0200 (CEST)
Date: Thu, 4 May 2017 12:06:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170504120632.0322a959@bahia>
In-Reply-To: <20170427072843.8089-3-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
	<20170427072843.8089-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Cl+8C0e9hxwU_MlQWOJqHmW";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 2/4] pseries: Move CPU
 compatibility property to machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, qemu-devel@nongnu.org, armbru@redhat.com, qemu-ppc@nongnu.org, abologna@redhat.com

--Sig_/Cl+8C0e9hxwU_MlQWOJqHmW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2017 17:28:41 +1000
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
> The option was used with -cpu.  So, to maintain compatibility, this patch
> adds a hack to the cpu option parsing to strip out any compat options
> supplied with -cpu and set them on the machine property instead of the new
> removed cpu property.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Yet another comment about the impact on tests/qom-test, as already
mentioned during RFCv2.

>  hw/ppc/spapr.c              |  6 +++-
>  hw/ppc/spapr_cpu_core.c     | 41 ++++++++++++++++++++--
>  hw/ppc/spapr_hcall.c        |  2 +-
>  include/hw/ppc/spapr.h      | 12 ++++---
>  target/ppc/compat.c         | 65 +++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h            |  6 ++--
>  target/ppc/translate_init.c | 84 +++++++++++++--------------------------=
------
>  7 files changed, 145 insertions(+), 71 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 80d12d0..547fa27 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2117,7 +2117,7 @@ static void ppc_spapr_init(MachineState *machine)
>          machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_default=
_cpu;
>      }
> =20
> -    ppc_cpu_parse_features(machine->cpu_model);
> +    spapr_cpu_parse_features(spapr);
> =20
>      spapr_init_cpus(spapr);
> =20
> @@ -2480,6 +2480,10 @@ static void spapr_machine_initfn(Object *obj)
>                                      " place of standard EPOW events when=
 possible"
>                                      " (required for memory hot-unplug su=
pport)",
>                                      NULL);
> +
> +    object_property_add(obj, "max-cpu-compat", "str",
> +                        ppc_compat_prop_get, ppc_compat_prop_set,
> +                        NULL, &spapr->max_compat_pvr, &error_fatal);
>  }
> =20
>  static void spapr_machine_finalizefn(Object *obj)
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 4389ef4..ba610bc 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -20,6 +20,43 @@
>  #include "sysemu/numa.h"
>  #include "qemu/error-report.h"
> =20
> +void spapr_cpu_parse_features(sPAPRMachineState *spapr)
> +{
> +    /*
> +     * Backwards compatibility hack:
> +
> +     *   CPUs had a "compat=3D" property which didn't make sense for
> +     *   anything except pseries.  It was replaced by "max-cpu-compat"
> +     *   machine option.  This supports old command lines like
> +     *       -cpu POWER8,compat=3Dpower7
> +     *   By stripping the compat option and applying it to the machine
> +     *   before passing it on to the cpu level parser.
> +     */
> +    gchar **inpieces;
> +    int n, i;
> +    gchar *compat_str =3D NULL;
> +
> +    inpieces =3D g_strsplit(MACHINE(spapr)->cpu_model, ",", 0);
> +    n =3D g_strv_length(inpieces);
> +
> +    /* inpieces[0] is the actual model string */
> +    for (i =3D 0; i < n; i++) {
> +        if (g_str_has_prefix(inpieces[i], "compat=3D")) {
> +            compat_str =3D inpieces[i];
> +        }
> +    }
> +
> +    if (compat_str) {
> +        char *val =3D compat_str + strlen("compat=3D");
> +        object_property_set_str(OBJECT(spapr), val, "max-cpu-compat",
> +                                &error_fatal);
> +    }
> +
> +    ppc_cpu_parse_features(MACHINE(spapr)->cpu_model);
> +
> +    g_strfreev(inpieces);
> +}
> +
>  static void spapr_cpu_reset(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> @@ -70,10 +107,10 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
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
> index 9f18f75..d4dc12b 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1059,7 +1059,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      target_ulong list =3D ppc64_phys_to_real(args[0]);
>      target_ulong ov_table;
>      bool explicit_match =3D false; /* Matched the CPU's real PVR */
> -    uint32_t max_compat =3D cpu->max_compat;
> +    uint32_t max_compat =3D spapr->max_compat_pvr;
>      uint32_t best_compat =3D 0;
>      int i;
>      sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 5802f88..40d5f89 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -86,16 +86,19 @@ struct sPAPRMachineState {
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
> @@ -633,6 +636,7 @@ void spapr_hotplug_req_add_by_count_indexed(sPAPRDRCo=
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
> index e8ec1e1..476dead 100644
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
> @@ -45,18 +48,21 @@ static const CompatInfo compat_table[] =3D {
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
> @@ -189,3 +195,62 @@ int ppc_compat_max_threads(PowerPCCPU *cpu)
> =20
>      return n_threads;
>  }
> +
> +void ppc_compat_prop_get(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
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
> +void ppc_compat_prop_set(Object *obj, Visitor *v, const char *name,
> +                         void *opaque, Error **errp)
> +{
> +    Error *error =3D NULL;
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
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index e0ff041..e953e75 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1185,7 +1185,6 @@ typedef struct PPCVirtualHypervisorClass PPCVirtual=
HypervisorClass;
>   * PowerPCCPU:
>   * @env: #CPUPPCState
>   * @cpu_dt_id: CPU index used in the device tree. KVM uses this index too
> - * @max_compat: Maximal supported logical PVR from the command line
>   * @compat_pvr: Current logical PVR, zero if in "raw" mode
>   *
>   * A PowerPC CPU.
> @@ -1197,7 +1196,6 @@ struct PowerPCCPU {
> =20
>      CPUPPCState env;
>      int cpu_dt_id;
> -    uint32_t max_compat;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
>      Object *intc;
> @@ -1369,6 +1367,10 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t comp=
at_pvr, Error **errp);
>  void ppc_set_compat_all(uint32_t compat_pvr, Error **errp);
>  #endif
>  int ppc_compat_max_threads(PowerPCCPU *cpu);
> +void ppc_compat_prop_get(Object *obj, Visitor *v,
> +                         const char *name, void *opaque, Error **err);
> +void ppc_compat_prop_set(Object *obj, Visitor *v,
> +                         const char *name, void *opaque, Error **err);
>  #endif /* defined(TARGET_PPC64) */
> =20
>  #include "exec/cpu-all.h"
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index e82e3e6..a92c825 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8413,73 +8413,35 @@ POWERPC_FAMILY(POWER5P)(ObjectClass *oc, void *da=
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
> -    }
> -
> -    g_free(value);
> +    error_report("CPU 'compat' property is deprecated and has no effect;=
 use max-cpu-compat machine property instead");

This causes some extra verbosity in qom-test:

/ppc64/qom/ref405ep: OK
/ppc64/qom/none: OK
/ppc64/qom/virtex-ml507: OK
/ppc64/qom/powernv: CPU 'compat' property is deprecated and has no effect; =
use max-cpu-compat machine property instead
OK
/ppc64/qom/ppce500: OK
/ppc64/qom/mpc8544ds: OK
/ppc64/qom/bamboo: OK
/ppc64/qom/g3beige: OK
/ppc64/qom/pseries-2.10: CPU 'compat' property is deprecated and has no eff=
ect; use max-cpu-compat machine property instead
OK
/ppc64/qom/prep: OK
/ppc64/qom/pseries-2.9: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/mac99: OK
/ppc64/qom/pseries-2.6: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.7: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.8: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.4: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.5: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.2: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/taihu: OK
/ppc64/qom/pseries-2.3: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/pseries-2.1: CPU 'compat' property is deprecated and has no effe=
ct; use max-cpu-compat machine property instead
OK
/ppc64/qom/40p: OK

This can be avoided with a trivial check:

    if (!qtest_enabled()) {
        error_report("CPU 'compat' property is deprecated and has no effect=
; use max-cpu-compat machine property instead");
    }

> +    visit_type_null(v, name, errp);
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


--Sig_/Cl+8C0e9hxwU_MlQWOJqHmW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkK/SgACgkQAvw66wEB28LaqgCcDHeHmwbxBevLS3xJOuYuupnw
q0oAoJQBkWa6Er40Nhh87dKjELn9TdlX
=Q5FO
-----END PGP SIGNATURE-----

--Sig_/Cl+8C0e9hxwU_MlQWOJqHmW--
