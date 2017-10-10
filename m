Received: from eggs.gnu.org ([2001:4830:134:3::10]:38945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU2-0004OQ-8v
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e1kU0-0004Wn-8T
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 22:41:26 -0400
Date: Tue, 10 Oct 2017 13:07:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171010020740.GJ2668@umbus.fritz.box>
References: <1507578671-158758-1-git-send-email-imammedo@redhat.com>
	<1507578671-158758-19-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Content-Disposition: inline
In-Reply-To: <1507578671-158758-19-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 18/24] ppc: spapr: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2017 at 09:51:05PM +0200, Igor Mammedov wrote:
> use generic cpu_model parsing introduced by
>  (6063d4c0f vl.c: convert cpu_model to cpu type and set of global propert=
ies before machine_init())
>=20
> it allows to:
>   * replace sPAPRMachineClass::tcg_default_cpu with
>     MachineClass::default_cpu_type
>   * drop cpu_parse_cpu_model() from hw/ppc/spapr.c and reuse
>     one in vl.c
>   * simplify spapr_get_cpu_core_type() by removing
>     not needed anymore recurrsion since alias look up
>     happens earlier at vl.c and spapr_get_cpu_core_type()
>     works only with resulted from that cpu type.
>   * spapr no more needs to parse/depend on being phased out
>     MachineState::cpu_model, all tha parsing done by generic
>     code and target specific callback.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> PS:
>   patch is a little bit big but it's hard to split it due
>   to dependencies, so pls bear with it.
>=20
> v2:
>   - limit setting default cpu type to 'host' type only for spapr machine
>   - split out ppc_cpu_lookup_alias() movement into separate patch
> ---
>  include/hw/ppc/spapr.h          |  1 -
>  include/hw/ppc/spapr_cpu_core.h |  2 +-
>  target/ppc/cpu.h                |  1 -
>  hw/ppc/spapr.c                  | 16 ++++------------
>  hw/ppc/spapr_cpu_core.c         | 30 ++++++++++--------------------
>  target/ppc/kvm.c                | 11 ++++++++---
>  target/ppc/translate_init.c     |  2 +-
>  7 files changed, 24 insertions(+), 39 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 8ca4f94..9d21ca9 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -60,7 +60,6 @@ struct sPAPRMachineClass {
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> -    const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
>      bool pre_2_10_has_unused_icps;
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20
> diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_cpu_c=
ore.h
> index 42765de..f2d48d6 100644
> --- a/include/hw/ppc/spapr_cpu_core.h
> +++ b/include/hw/ppc/spapr_cpu_core.h
> @@ -37,5 +37,5 @@ typedef struct sPAPRCPUCoreClass {
>      const char *cpu_type;
>  } sPAPRCPUCoreClass;
> =20
> -char *spapr_get_cpu_core_type(const char *model);
> +const char *spapr_get_cpu_core_type(const char *cpu_type);
>  #endif
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 64aef17..989761b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1278,7 +1278,6 @@ extern const struct VMStateDescription vmstate_ppc_=
cpu;
> =20
>  /***********************************************************************=
******/
>  void ppc_translate_init(void);
> -const char *ppc_cpu_lookup_alias(const char *alias);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
>     signal handlers to inform the virtual CPU of exceptions. non zero
>     is returned if the signal was handled by the virtual CPU.  */
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 30b4934..355f216 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2129,7 +2129,7 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>  {
>      MachineState *machine =3D MACHINE(spapr);
>      MachineClass *mc =3D MACHINE_GET_CLASS(machine);
> -    char *type =3D spapr_get_cpu_core_type(machine->cpu_model);
> +    const char *type =3D spapr_get_cpu_core_type(machine->cpu_type);
>      int smt =3D kvmppc_smt_threads();
>      const CPUArchIdList *possible_cpus;
>      int boot_cores_nr =3D smp_cpus / smp_threads;
> @@ -2184,7 +2184,6 @@ static void spapr_init_cpus(sPAPRMachineState *spap=
r)
>              object_property_set_bool(core, true, "realized", &error_fata=
l);
>          }
>      }
> -    g_free(type);
>  }
> =20
>  static void spapr_set_vsmt_mode(sPAPRMachineState *spapr, Error **errp)
> @@ -2369,12 +2368,6 @@ static void ppc_spapr_init(MachineState *machine)
>      }
> =20
>      /* init CPUs */
> -    if (machine->cpu_model =3D=3D NULL) {
> -        machine->cpu_model =3D kvm_enabled() ? "host" : smc->tcg_default=
_cpu;
> -    }
> -
> -    cpu_parse_cpu_model(TYPE_POWERPC_CPU, machine->cpu_model);
> -
>      spapr_set_vsmt_mode(spapr, &error_fatal);
> =20
>      spapr_init_cpus(spapr);
> @@ -3265,7 +3258,7 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
>      Error *local_err =3D NULL;
>      CPUCore *cc =3D CPU_CORE(dev);
> -    char *base_core_type =3D spapr_get_cpu_core_type(machine->cpu_model);
> +    const char *base_core_type =3D spapr_get_cpu_core_type(machine->cpu_=
type);
>      const char *type =3D object_get_typename(OBJECT(dev));
>      CPUArchId *core_slot;
>      int index;
> @@ -3311,7 +3304,6 @@ static void spapr_core_pre_plug(HotplugHandler *hot=
plug_dev, DeviceState *dev,
>      numa_cpu_pre_plug(core_slot, dev, &local_err);
> =20
>  out:
> -    g_free(base_core_type);
>      error_propagate(errp, local_err);
>  }
> =20
> @@ -3610,7 +3602,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> =20
>      smc->dr_lmb_enabled =3D true;
> -    smc->tcg_default_cpu =3D "power8_v2.0";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
>      mc->has_hotpluggable_cpus =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
> @@ -3856,7 +3848,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> =20
>      spapr_machine_2_8_class_options(mc);
> -    smc->tcg_default_cpu =3D "power7_v2.3";
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power7_v2.3");
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
>      smc->phb_placement =3D phb_placement_2_7;
>  }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index b5bbb6a..6c176c8 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -61,29 +61,19 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, =
PowerPCCPU *cpu,
>   * Return the sPAPR CPU core type for @model which essentially is the CPU
>   * model specified with -cpu cmdline option.
>   */
> -char *spapr_get_cpu_core_type(const char *model)
> +const char *spapr_get_cpu_core_type(const char *cpu_type)
>  {
> -    char *core_type;
> -    gchar **model_pieces =3D g_strsplit(model, ",", 2);
> -    gchar *cpu_model =3D g_ascii_strdown(model_pieces[0], -1);
> -    g_strfreev(model_pieces);
> -
> -    core_type =3D g_strdup_printf("%s-" TYPE_SPAPR_CPU_CORE, cpu_model);
> -
> -    /* Check whether it exists or whether we have to look up an alias na=
me */
> -    if (!object_class_by_name(core_type)) {
> -        const char *realmodel;
> -
> -        g_free(core_type);
> -        core_type =3D NULL;
> -        realmodel =3D ppc_cpu_lookup_alias(cpu_model);
> -        if (realmodel) {
> -            core_type =3D spapr_get_cpu_core_type(realmodel);
> -        }
> +    int len =3D strlen(cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
> +    char *core_type =3D g_strdup_printf(SPAPR_CPU_CORE_TYPE_NAME("%.*s"),
> +                                      len, cpu_type);
> +    ObjectClass *oc =3D object_class_by_name(core_type);
> +
> +    g_free(core_type);
> +    if (!oc) {
> +        return NULL;
>      }
> -    g_free(cpu_model);
> =20
> -    return core_type;
> +    return object_class_get_name(oc);
>  }
> =20
>  static void spapr_cpu_core_unrealizefn(DeviceState *dev, Error **errp)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index cb5777a..48dc3f7 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -123,7 +123,7 @@ static bool kvmppc_is_pr(KVMState *ks)
>      return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
>  }
> =20
> -static int kvm_ppc_register_host_cpu_type(void);
> +static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> =20
>  int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
> @@ -163,7 +163,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>                          "VM to stall at times!\n");
>      }
> =20
> -    kvm_ppc_register_host_cpu_type();
> +    kvm_ppc_register_host_cpu_type(ms);
> =20
>      return 0;
>  }
> @@ -2487,12 +2487,13 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>      return pvr_pcc;
>  }
> =20
> -static int kvm_ppc_register_host_cpu_type(void)
> +static int kvm_ppc_register_host_cpu_type(MachineState *ms)
>  {
>      TypeInfo type_info =3D {
>          .name =3D TYPE_HOST_POWERPC_CPU,
>          .class_init =3D kvmppc_host_cpu_class_init,
>      };
> +    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      PowerPCCPUClass *pvr_pcc;
>      ObjectClass *oc;
>      DeviceClass *dc;
> @@ -2504,6 +2505,10 @@ static int kvm_ppc_register_host_cpu_type(void)
>      }
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> +    if (object_dynamic_cast(ms, TYPE_SPAPR_MACHINE)) {
> +        /* override TCG default cpu type with 'host' cpu model */
> +        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> +    }
> =20
>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 17ac95b..7b9bf6a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10060,7 +10060,7 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32=
_t pvr)
>      return pcc;
>  }
> =20
> -const char *ppc_cpu_lookup_alias(const char *alias)
> +static const char *ppc_cpu_lookup_alias(const char *alias)
>  {
>      int ai;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlncK2sACgkQbDjKyiDZ
s5LodBAAuFAcdAP/cr3Hd4IYy9t1pjUlKFwjh9SgN+PZpi1sgcPZ7vxjwzhIejgF
VBLd1L22mwtJEwEWs6q81VymuN4/RtBx9aIDoDMIf0xRPPuNpaILRnOPTKwz3nUK
cJ0TYgfT2psldpF8P+NgyMXE4YD7rmvBnZLy7EUqs3xj7QN/1weOt2BC3NPxT6ZD
FIv3fs3ic4e4k2A2orunDgA3vgMSwWCGRoH9EI4XY2IyiQ0LzXu71VBRxZ0nFF/2
NmmWi+6aC4IFk/sOYg8B2STc3izRiqxcPxQs0iXIdEARs3KLKws0eQMvlW01N824
hrbPVknUDcdBtrZf7BGPlfKbRNGuLTCVsj+dDmQxl+RY9NYmv2vzhPpyd2JOox6I
Gt1WQhfUGU1vfMktcrnk6937jR/6GGwdKxWIIII66uY5tlGbtjm7t2Erp2UYpbPM
M0/iB9J4SRq6/GqE5rOl0hbf+S6rQgt72mCUCvhy9fh5hiUUME0QhWI11UosAz+e
DDcYY91hlMTJ+TSkC4ayIAL0Kd91kxnrwdxs6qaQqO17WHytV7ufcUMuKYO762xX
3lbkLKmxR1zNU95gUVghdnz6XhC67OLB+iKBzA34sGZWt5ihULlr6rYLE/bXgnhH
7sLH2LL893iuPiDFj/gBT+OlIeUAiZnLK8O6hQE419mWb7GfzoI=
=TP9s
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
