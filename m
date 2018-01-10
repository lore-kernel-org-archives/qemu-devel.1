Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ7m8-0005wR-Kw
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZ7m5-0008S9-Lx
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 23:14:04 -0500
Date: Wed, 10 Jan 2018 15:13:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180110041345.GQ2131@umbus.fritz.box>
References: <20180109092103.18458-1-sjitindarsingh@gmail.com>
	<20180109092103.18458-2-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YzdYn+D7cUqe+VA3"
Content-Disposition: inline
In-Reply-To: <20180109092103.18458-2-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [QEMU-PPC] [RFC 1/3] hw/ppc/spapr_caps: Rework
 spapr_caps to use uint8 internal representation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, paulus@ozlabs.org


--YzdYn+D7cUqe+VA3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 08:21:01PM +1100, Suraj Jitindar Singh wrote:
> Currently spapr_caps are tied to boolean values (on or off). This patch
> reworks the caps so that they can have any value between 0 and 127,
> inclusive. This allows more capabilities with various values to be
> represented in the same way internally. Capabilities are numbered in
> ascending order. The internal representation of capability values is an
> array of uint8s in the sPAPRMachineState, indexed by capability number.
> Note: The MSB (0x80) of a capability is reserved to track whether the
>       capability was set from the command line.
>=20
> Capabilities can have their own name, description, options, getter and
> setter functions, type and allow functions. They also each have their own
> section in the migration stream. Capabilities are only migrated if they
> were explictly set on the command line, with the assumption that
> otherwise the default will match.
>=20
> On migration we ensure that the capability value on the destination
> is greater than or equal to the capability value from the source. So
> long at this remains the case then the migration is considered
> compatible and allowed to continue.
>=20
> This patch implements generic getter and setter functions for boolean
> capabilities. It also converts the existings cap-htm, cap-vsx and
> cap-dfp capabilities to this new format.
> ---
>  hw/ppc/spapr.c         |  19 +--
>  hw/ppc/spapr_caps.c    | 335 ++++++++++++++++++++++++++++---------------=
------
>  include/hw/ppc/spapr.h |  41 +++---
>  3 files changed, 222 insertions(+), 173 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d1acfe8858..7fa45729ba 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -320,7 +320,7 @@ static void spapr_populate_pa_features(sPAPRMachineSt=
ate *spapr,
>           */
>          pa_features[3] |=3D 0x20;
>      }
> -    if (spapr_has_cap(spapr, SPAPR_CAP_HTM) && pa_size > 24) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_HTM) && pa_size > 24) {

I'd prefer to see explicit >0 or !=3D0 to emphasise that the returned
value is now an integer not a bool.

>          pa_features[24] |=3D 0x80;    /* Transactional memory support */
>      }
>      if (legacy_guest && pa_size > 40) {
> @@ -563,7 +563,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>       *
>       * Only CPUs for which we create core types in spapr_cpu_core.c
>       * are possible, and all of those have VMX */
> -    if (spapr_has_cap(spapr, SPAPR_CAP_VSX)) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_VSX)) {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 2)));
>      } else {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,vmx", 1)));
> @@ -572,7 +572,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      /* Advertise DFP (Decimal Floating Point) if available
>       *   0 / no property =3D=3D no DFP
>       *   1               =3D=3D DFP available */
> -    if (spapr_has_cap(spapr, SPAPR_CAP_DFP)) {
> +    if (spapr_get_cap(spapr, SPAPR_CAP_DFP)) {
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
> =20
> @@ -1762,7 +1762,9 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> -        &vmstate_spapr_caps,
> +        &vmstate_spapr_cap_htm,
> +        &vmstate_spapr_cap_vsx,
> +        &vmstate_spapr_cap_dfp,
>          NULL
>      }
>  };
> @@ -2323,8 +2325,6 @@ static void spapr_machine_init(MachineState *machin=
e)
>      char *filename;
>      Error *resize_hpt_err =3D NULL;
> =20
> -    spapr_caps_validate(spapr, &error_fatal);
> -
>      msi_nonbroken =3D true;
> =20
>      QLIST_INIT(&spapr->phbs);
> @@ -3834,7 +3834,9 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>       */
>      mc->numa_mem_align_shift =3D 28;
> =20
> -    smc->default_caps =3D spapr_caps(SPAPR_CAP_VSX | SPAPR_CAP_DFP);
> +    smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
> +    smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_ON;
>      spapr_caps_add_properties(smc, &error_abort);
>  }
> =20
> @@ -3916,8 +3918,7 @@ static void spapr_machine_2_11_class_options(Machin=
eClass *mc)
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> =20
>      spapr_machine_2_12_class_options(mc);
> -    smc->default_caps =3D spapr_caps(SPAPR_CAP_HTM | SPAPR_CAP_VSX
> -                                   | SPAPR_CAP_DFP);
> +    smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_ON;
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
>  }
> =20
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9d070a306c..af40f2e469 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -35,33 +35,71 @@
>  typedef struct sPAPRCapabilityInfo {
>      const char *name;
>      const char *description;
> -    uint64_t flag;
> +    const char *options;
> +    int index;
> =20
> +    /* Getter and Setter Function Pointers */
> +    ObjectPropertyAccessor *get;
> +    ObjectPropertyAccessor *set;
> +    const char *type;
>      /* Make sure the virtual hardware can support this capability */
> -    void (*allow)(sPAPRMachineState *spapr, Error **errp);
> -
> -    /* If possible, tell the virtual hardware not to allow the cap to
> -     * be used at all */
> -    void (*disallow)(sPAPRMachineState *spapr, Error **errp);
> +    void (*allow)(sPAPRMachineState *spapr, uint8_t val, Error **errp);

I think we need a new name for this since it can both allow and
disallow.  Maybe 'apply'?

>  } sPAPRCapabilityInfo;
> =20
> -static void cap_htm_allow(sPAPRMachineState *spapr, Error **errp)
> +static void spapr_cap_get_bool(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
> +{
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    bool value =3D spapr_get_cap(spapr, cap->index) =3D=3D SPAPR_CAP_ON;
> +
> +    visit_type_bool(v, name, &value, errp);
> +}
> +
> +static void spapr_cap_set_bool(Object *obj, Visitor *v, const char *name,
> +                               void *opaque, Error **errp)
>  {
> +    sPAPRCapabilityInfo *cap =3D opaque;
> +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> +    bool value;
> +    Error *local_err =3D NULL;
> +
> +    visit_type_bool(v, name, &value, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    spapr->cmd_line_caps.caps[cap->index] =3D (value ? SPAPR_CAP_ON :
> +                                                     SPAPR_CAP_OFF) |
> +                                             SPAPR_CAP_CMD_LINE;
> +}
> +
> +static void cap_htm_allow(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
> +{
> +    if (!val) {
> +        /* TODO: We don't support disabling htm yet */
> +        return;
> +    }

A downside of fusing allow and disallow is that we can't now apply the
rule that failure to allow is an error but failure to disallow is only
a warning in the common code.  Oh well.

>      if (tcg_enabled()) {
>          error_setg(errp,
> -                   "No Transactional Memory support in TCG, try cap-htm=
=3Doff");
> +                   "No Transactional Memory support in TCG, try cap-htm=
=3D0");
>      } else if (kvm_enabled() && !kvmppc_has_cap_htm()) {
>          error_setg(errp,
> -"KVM implementation does not support Transactional Memory, try cap-htm=
=3Doff"
> +"KVM implementation does not support Transactional Memory, try cap-htm=
=3D0"
>              );
>      }
>  }
> =20
> -static void cap_vsx_allow(sPAPRMachineState *spapr, Error **errp)
> +static void cap_vsx_allow(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    if (!val) {
> +        /* TODO: We don't support disabling vsx yet */
> +        return;
> +    }
>      /* Allowable CPUs in spapr_cpu_core.c should already have gotten
>       * rid of anything that doesn't do VMX */
>      g_assert(env->insns_flags & PPC_ALTIVEC);
> @@ -70,37 +108,51 @@ static void cap_vsx_allow(sPAPRMachineState *spapr, =
Error **errp)
>      }
>  }
> =20
> -static void cap_dfp_allow(sPAPRMachineState *spapr, Error **errp)
> +static void cap_dfp_allow(sPAPRMachineState *spapr, uint8_t val, Error *=
*errp)
>  {
>      PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
>      CPUPPCState *env =3D &cpu->env;
> =20
> +    if (!val) {
> +        /* TODO: We don't support disabling dfp yet */
> +        return;
> +    }
>      if (!(env->insns_flags2 & PPC2_DFP)) {
>          error_setg(errp, "DFP support not available, try cap-dfp=3Doff");
>      }
>  }
> =20
> -static sPAPRCapabilityInfo capability_table[] =3D {
> -    {
> +
> +sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
> +    [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
>          .description =3D "Allow Hardware Transactional Memory (HTM)",
> -        .flag =3D SPAPR_CAP_HTM,
> +        .options =3D "",

It's not really clear to me what the options field is for.

> +        .index =3D SPAPR_CAP_HTM,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
>          .allow =3D cap_htm_allow,
> -        /* TODO: add cap_htm_disallow */
>      },
> -    {
> +    [SPAPR_CAP_VSX] =3D {
>          .name =3D "vsx",
>          .description =3D "Allow Vector Scalar Extensions (VSX)",
> -        .flag =3D SPAPR_CAP_VSX,
> +        .options =3D "",
> +        .index =3D SPAPR_CAP_VSX,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
>          .allow =3D cap_vsx_allow,
> -        /* TODO: add cap_vsx_disallow */
>      },
> -    {
> +    [SPAPR_CAP_DFP] =3D {
>          .name =3D "dfp",
>          .description =3D "Allow Decimal Floating Point (DFP)",
> -        .flag =3D SPAPR_CAP_DFP,
> +        .options =3D "",
> +        .index =3D SPAPR_CAP_DFP,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
>          .allow =3D cap_dfp_allow,
> -        /* TODO: add cap_dfp_disallow */
>      },
>  };
> =20
> @@ -115,201 +167,192 @@ static sPAPRCapabilities default_caps_with_cpu(sP=
APRMachineState *spapr,
> =20
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_07,
>                            0, spapr->max_compat_pvr)) {
> -        caps.mask &=3D ~SPAPR_CAP_HTM;
> +        caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
>      }
> =20
>      if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_2_06,
>                            0, spapr->max_compat_pvr)) {
> -        caps.mask &=3D ~SPAPR_CAP_VSX;
> -        caps.mask &=3D ~SPAPR_CAP_DFP;
> +        caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_OFF;
> +        caps.caps[SPAPR_CAP_DFP] =3D SPAPR_CAP_OFF;
>      }
> =20
>      return caps;
>  }
> =20
> -static bool spapr_caps_needed(void *opaque)
> -{
> -    sPAPRMachineState *spapr =3D opaque;
> -
> -    return (spapr->forced_caps.mask !=3D 0) || (spapr->forbidden_caps.ma=
sk !=3D 0);
> -}
> -
>  /* This has to be called from the top-level spapr post_load, not the
>   * caps specific one.  Otherwise it wouldn't be called when the source
>   * caps are all defaults, which could still conflict with overridden
>   * caps on the destination */
>  int spapr_caps_post_migration(sPAPRMachineState *spapr)
>  {
> -    uint64_t allcaps =3D 0;
>      int i;
>      bool ok =3D true;
>      sPAPRCapabilities dstcaps =3D spapr->effective_caps;
>      sPAPRCapabilities srccaps;
> =20
>      srccaps =3D default_caps_with_cpu(spapr, first_cpu);
> -    srccaps.mask |=3D spapr->mig_forced_caps.mask;
> -    srccaps.mask &=3D ~spapr->mig_forbidden_caps.mask;
> +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> +        if (spapr->mig_caps.caps[i] & SPAPR_CAP_CMD_LINE) {
> +            srccaps.caps[i] =3D spapr->mig_caps.caps[i] & ~SPAPR_CAP_CMD=
_LINE;
> +        }
> +    }
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
>          sPAPRCapabilityInfo *info =3D &capability_table[i];
> =20
> -        allcaps |=3D info->flag;
> -
> -        if ((srccaps.mask & info->flag) && !(dstcaps.mask & info->flag))=
 {
> -            error_report("cap-%s=3Don in incoming stream, but off in des=
tination",
> -                         info->name);
> +        if (srccaps.caps[i] > dstcaps.caps[i]) {
> +            error_report("cap-%s higher level (%d) in incoming stream th=
an on destination (%d)",
> +                         info->name, srccaps.caps[i], dstcaps.caps[i]);
>              ok =3D false;
>          }
> =20
> -        if (!(srccaps.mask & info->flag) && (dstcaps.mask & info->flag))=
 {
> -            warn_report("cap-%s=3Doff in incoming stream, but on in dest=
ination",
> -                         info->name);
> +        if (srccaps.caps[i] < dstcaps.caps[i]) {
> +            warn_report("cap-%s lower level (%d) in incoming stream than=
 on destination (%d)",
> +                         info->name, srccaps.caps[i], dstcaps.caps[i]);
>          }
>      }
> =20
> -    if (spapr->mig_forced_caps.mask & ~allcaps) {
> -        error_report(
> -            "Unknown capabilities 0x%"PRIx64" enabled in incoming stream=
",
> -            spapr->mig_forced_caps.mask & ~allcaps);
> -        ok =3D false;
> -    }
> -    if (spapr->mig_forbidden_caps.mask & ~allcaps) {
> -        warn_report(
> -            "Unknown capabilities 0x%"PRIx64" disabled in incoming strea=
m",
> -            spapr->mig_forbidden_caps.mask & ~allcaps);
> -    }
> -
>      return ok ? 0 : -EINVAL;
>  }
> =20
> -static int spapr_caps_pre_save(void *opaque)
> +static bool spapr_cap_htm_needed(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> =20
> -    spapr->mig_forced_caps =3D spapr->forced_caps;
> -    spapr->mig_forbidden_caps =3D spapr->forbidden_caps;
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_HTM] & SPAPR_CAP_CMD_L=
INE);
> +}
> +
> +static int spapr_cap_htm_pre_save(void *opaque)

Having to have a separate needed, pre_save and pre_load for each cap
will be a pain.  I hope we can find a way to do this in common.

> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_HTM] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_HTM];
>      return 0;
>  }
> =20
> -static int spapr_caps_pre_load(void *opaque)
> +static int spapr_cap_htm_pre_load(void *opaque)
>  {
>      sPAPRMachineState *spapr =3D opaque;
> =20
> -    spapr->mig_forced_caps =3D spapr_caps(0);
> -    spapr->mig_forbidden_caps =3D spapr_caps(0);
> +    spapr->mig_caps.caps[SPAPR_CAP_HTM] =3D 0;
>      return 0;
>  }
> =20
> -const VMStateDescription vmstate_spapr_caps =3D {
> -    .name =3D "spapr/caps",
> +const VMStateDescription vmstate_spapr_cap_htm =3D {
> +    .name =3D "spapr/cap_htm",

I'd suggest spapr/caps/htm - and a common vmstate_spapr_caps to hold
the subsections for convenience rather than putting them straight
under the master spapr one.

>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .needed =3D spapr_caps_needed,
> -    .pre_save =3D spapr_caps_pre_save,
> -    .pre_load =3D spapr_caps_pre_load,
> +    .needed =3D spapr_cap_htm_needed,
> +    .pre_save =3D spapr_cap_htm_pre_save,
> +    .pre_load =3D spapr_cap_htm_pre_load,
>      .fields =3D (VMStateField[]) {
> -        VMSTATE_UINT64(mig_forced_caps.mask, sPAPRMachineState),
> -        VMSTATE_UINT64(mig_forbidden_caps.mask, sPAPRMachineState),
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_HTM], sPAPRMachineState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> =20
> -void spapr_caps_reset(sPAPRMachineState *spapr)
> +static bool spapr_cap_vsx_needed(void *opaque)
>  {
> -    Error *local_err =3D NULL;
> -    sPAPRCapabilities caps;
> -    int i;
> +    sPAPRMachineState *spapr =3D opaque;
> =20
> -    /* First compute the actual set of caps we're running with.. */
> -    caps =3D default_caps_with_cpu(spapr, first_cpu);
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_VSX] & SPAPR_CAP_CMD_L=
INE);
> +}
> =20
> -    /* Remove unnecessary forced/forbidden bits (this will help us
> -     * with migration) */
> -    spapr->forced_caps.mask &=3D ~caps.mask;
> -    spapr->forbidden_caps.mask &=3D caps.mask;

I don't think you have an equivalent of this in the new code, which
means that an explicitly set property could prevent migration, even if
it actually has the default value.

> +static int spapr_cap_vsx_pre_save(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +
> +    spapr->mig_caps.caps[SPAPR_CAP_VSX] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_VSX];
> +    return 0;
> +}
> =20
> -    caps.mask |=3D spapr->forced_caps.mask;
> -    caps.mask &=3D ~spapr->forbidden_caps.mask;
> +static int spapr_cap_vsx_pre_load(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> =20
> -    spapr->effective_caps =3D caps;
> +    spapr->mig_caps.caps[SPAPR_CAP_VSX] =3D 0;
> +    return 0;
> +}
> =20
> -    /* .. then apply those caps to the virtual hardware */
> +const VMStateDescription vmstate_spapr_cap_vsx =3D {
> +    .name =3D "spapr/cap_vsx",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_vsx_needed,
> +    .pre_save =3D spapr_cap_vsx_pre_save,
> +    .pre_load =3D spapr_cap_vsx_pre_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_VSX], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> -        sPAPRCapabilityInfo *info =3D &capability_table[i];
> +static bool spapr_cap_dfp_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> =20
> -        if (spapr->effective_caps.mask & info->flag) {
> -            /* Failure to allow a cap is fatal - if the guest doesn't
> -             * have it, we'll be supplying an incorrect environment */
> -            if (info->allow) {
> -                info->allow(spapr, &error_fatal);
> -            }
> -        } else {
> -            /* Failure to enforce a cap is only a warning.  The guest
> -             * shouldn't be using it, since it's not advertised, so it
> -             * doesn't get to complain about weird behaviour if it
> -             * goes ahead anyway */
> -            if (info->disallow) {
> -                info->disallow(spapr, &local_err);
> -            }
> -            if (local_err) {
> -                warn_report_err(local_err);
> -                local_err =3D NULL;
> -            }
> -        }
> -    }
> +    return !!(spapr->cmd_line_caps.caps[SPAPR_CAP_DFP] & SPAPR_CAP_CMD_L=
INE);
>  }
> =20
> -static void spapr_cap_get(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static int spapr_cap_dfp_pre_save(void *opaque)
>  {
> -    sPAPRCapabilityInfo *cap =3D opaque;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> -    bool value =3D spapr_has_cap(spapr, cap->flag);
> -
> -    /* TODO: Could this get called before effective_caps is finalized
> -     * in spapr_caps_reset()? */
> +    sPAPRMachineState *spapr =3D opaque;
> =20
> -    visit_type_bool(v, name, &value, errp);
> +    spapr->mig_caps.caps[SPAPR_CAP_DFP] =3D
> +        spapr->cmd_line_caps.caps[SPAPR_CAP_DFP];
> +    return 0;
>  }
> =20
> -static void spapr_cap_set(Object *obj, Visitor *v, const char *name,
> -                          void *opaque, Error **errp)
> +static int spapr_cap_dfp_pre_load(void *opaque)
>  {
> -    sPAPRCapabilityInfo *cap =3D opaque;
> -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> -    bool value;
> -    Error *local_err =3D NULL;
> -
> -    visit_type_bool(v, name, &value, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    sPAPRMachineState *spapr =3D opaque;
> =20
> -    if (value) {
> -        spapr->forced_caps.mask |=3D cap->flag;
> -    } else {
> -        spapr->forbidden_caps.mask |=3D cap->flag;
> -    }
> +    spapr->mig_caps.caps[SPAPR_CAP_DFP] =3D 0;
> +    return 0;
>  }
> =20
> -void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp)
> +const VMStateDescription vmstate_spapr_cap_dfp =3D {
> +    .name =3D "spapr/cap_dfp",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_cap_dfp_needed,
> +    .pre_save =3D spapr_cap_dfp_pre_save,
> +    .pre_load =3D spapr_cap_dfp_pre_load,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT8(mig_caps.caps[SPAPR_CAP_DFP], sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +void spapr_caps_reset(sPAPRMachineState *spapr)
>  {
> -    uint64_t allcaps =3D 0;
> +    sPAPRCapabilities caps;
>      int i;
> =20
> -    for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
> -        g_assert((allcaps & capability_table[i].flag) =3D=3D 0);
> -        allcaps |=3D capability_table[i].flag;
> +    /* First compute the actual set of caps we're running with.. */
> +    caps =3D default_caps_with_cpu(spapr, first_cpu);
> +
> +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> +        /* Check if set from command line and override default if so */
> +        if (spapr->cmd_line_caps.caps[i] & SPAPR_CAP_CMD_LINE) {
> +            caps.caps[i] =3D spapr->cmd_line_caps.caps[i] & ~SPAPR_CAP_C=
MD_LINE;
> +        }
>      }
> =20
> -    g_assert((spapr->forced_caps.mask & ~allcaps) =3D=3D 0);
> -    g_assert((spapr->forbidden_caps.mask & ~allcaps) =3D=3D 0);
> +    spapr->effective_caps =3D caps;
> =20
> -    if (spapr->forced_caps.mask & spapr->forbidden_caps.mask) {
> -        error_setg(errp, "Some sPAPR capabilities set both on and off");
> -        return;
> +    /* .. then apply those caps to the virtual hardware */
> +
> +    for (i =3D 0; i < SPAPR_CAP_NUM; i++) {
> +        sPAPRCapabilityInfo *info =3D &capability_table[i];
> +
> +        /*
> +         * If the allow function can't set the desired level and think's=
 it's

Nit, s/think's/thinks/

> +         * fatal, it should cause that.
> +         */
> +        info->allow(spapr, spapr->effective_caps.caps[i], &error_fatal);
>      }
>  }
> =20
> @@ -322,17 +365,19 @@ void spapr_caps_add_properties(sPAPRMachineClass *s=
mc, Error **errp)
>      for (i =3D 0; i < ARRAY_SIZE(capability_table); i++) {
>          sPAPRCapabilityInfo *cap =3D &capability_table[i];
>          const char *name =3D g_strdup_printf("cap-%s", cap->name);
> +        char *desc;
> =20
> -        object_class_property_add(klass, name, "bool",
> -                                  spapr_cap_get, spapr_cap_set, NULL,
> -                                  cap, &local_err);
> +        object_class_property_add(klass, name, cap->type,
> +                                  cap->get, cap->set,
> +                                  NULL, cap, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
>          }
> =20
> -        object_class_property_set_description(klass, name, cap->descript=
ion,
> -                                              &local_err);
> +        desc =3D g_strdup_printf("%s%s", cap->description, cap->options);
> +        object_class_property_set_description(klass, name, desc, &local_=
err);
> +        g_free(desc);
>          if (local_err) {
>              error_propagate(errp, local_err);
>              return;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 26ac17e641..2804fbbf12 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -57,17 +57,26 @@ typedef enum {
>  /* These bits go in the migration stream, so they can't be reassigned */
> =20
>  /* Hardware Transactional Memory */
> -#define SPAPR_CAP_HTM               0x0000000000000001ULL
> -
> +#define SPAPR_CAP_HTM                   0x00
>  /* Vector Scalar Extensions */
> -#define SPAPR_CAP_VSX               0x0000000000000002ULL
> -
> +#define SPAPR_CAP_VSX                   0x01
>  /* Decimal Floating Point */
> -#define SPAPR_CAP_DFP               0x0000000000000004ULL
> +#define SPAPR_CAP_DFP                   0x02
> +/* Num Caps */
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_DFP + 1)
> +
> +/*
> + * Capability Values
> + * NOTE: All execpt the immediately following MUST be less than 128 (0x8=
0)
> + */
> +#define SPAPR_CAP_CMD_LINE              0x80
> +/* Bool Caps */
> +#define SPAPR_CAP_OFF                   0x00
> +#define SPAPR_CAP_ON                    0x01
> =20
>  typedef struct sPAPRCapabilities sPAPRCapabilities;
>  struct sPAPRCapabilities {
> -    uint64_t mask;
> +    uint8_t caps[SPAPR_CAP_NUM];
>  };
> =20
>  /**
> @@ -149,9 +158,8 @@ struct sPAPRMachineState {
> =20
>      const char *icp_type;
> =20
> -    sPAPRCapabilities forced_caps, forbidden_caps;
> -    sPAPRCapabilities mig_forced_caps, mig_forbidden_caps;
> -    sPAPRCapabilities effective_caps;
> +    sPAPRCapabilities cmd_line_caps, effective_caps;
> +    sPAPRCapabilities mig_caps;
>  };
> =20
>  #define H_SUCCESS         0
> @@ -752,21 +760,16 @@ qemu_irq spapr_qirq(sPAPRMachineState *spapr, int i=
rq);
>  /*
>   * Handling of optional capabilities
>   */
> -extern const VMStateDescription vmstate_spapr_caps;
> -
> -static inline sPAPRCapabilities spapr_caps(uint64_t mask)
> -{
> -    sPAPRCapabilities caps =3D { mask };
> -    return caps;
> -}
> +extern const VMStateDescription vmstate_spapr_cap_htm;
> +extern const VMStateDescription vmstate_spapr_cap_vsx;
> +extern const VMStateDescription vmstate_spapr_cap_dfp;
> =20
> -static inline bool spapr_has_cap(sPAPRMachineState *spapr, uint64_t cap)
> +static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
>  {
> -    return !!(spapr->effective_caps.mask & cap);
> +    return spapr->effective_caps.caps[cap];
>  }
> =20
>  void spapr_caps_reset(sPAPRMachineState *spapr);
> -void spapr_caps_validate(sPAPRMachineState *spapr, Error **errp);
>  void spapr_caps_add_properties(sPAPRMachineClass *smc, Error **errp);
>  int spapr_caps_post_migration(sPAPRMachineState *spapr);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YzdYn+D7cUqe+VA3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpVkvQACgkQbDjKyiDZ
s5LX4RAAqF3wJ3+Ike+/J/9ZsO47r0dMZzOveykXwZ/u7QWFbuYKqP9vmxlmw4A8
hLUEhfbXLLN0u6LRD7aKGNBbVOmyFMf789WYVtfR5VRoZQjYHfNCOrwolxWG6xWT
vLtfXl2Ne/JNTTB5gogHiGSRyAQzK/7ogRI8Knes1W0urV4+/2tC8f2SNbPeNjS/
DWGiFz4NQCmMXzkiJTvbjRPNH6BIUvLQ/d8IoPht5U10HXAA+3NjRuYt/9pSQKUa
9xkBbzzJRwGppcIDzcDhwx5UEGjTZmu5IoFDzx5bZRrLU2j8O7MvxkO8pcZqG/TG
ZFgQuLpo5KiDASV4HKm+PNiCLZeilVV3KxSVI+55dsoIGuT+nw9U1/3ZxeORkFTu
viLwOPhFPlDM6S9NtSrZsYedClefHpgA2cDIn1210z/tQKYc8cXj320+vtQX4pCN
vMztkDsYDwi7HmwOfqLcmO3/gotBMC+0zTWIjhlKxedkVN1WApBrpHDVt95pkxnX
Vycbd3GZjeOTKXBC0QrCRzo4Empaddo5UYOhUeamTYsBEJrd/tpoWkMmGnHNedZG
mYxLn6vJQt/X6CnQsPz86YPJp9G/OSUldfjI+6QZ1G2qMZT38cb50X2hEHaAjAUK
WsmcYGHIStEiveS2FXFlUjlRfYAA2zTNNItl8uSp6uMXps/fQOo=
=aBWe
-----END PGP SIGNATURE-----

--YzdYn+D7cUqe+VA3--
