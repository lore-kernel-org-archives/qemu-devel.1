Received: from eggs.gnu.org ([2001:4830:134:3::10]:36295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr7-0003Eb-Qu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dawr6-0007qF-EJ
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 00:26:29 -0400
Date: Fri, 28 Jul 2017 14:02:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170728040257.GI3098@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jaTU8Y2VLE5tlY1O"
Content-Disposition: inline
In-Reply-To: <150100578691.27487.8944448515009831240.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to
 update the XICS phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>


--jaTU8Y2VLE5tlY1O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote:
> The "phandle" property of the XICS node is referenced by the "interrupt-m=
ap"
> property of each PHB node. This is used by the guest OS to setup IRQs for
> all PCI devices.
>=20
> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF converts
> this value to a SLOF specific one, which is then presented to the guest O=
S.
>=20
> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which is u=
sed
> by SLOF to communicate the patched phandle value back to QEMU. This value
> is then cached and preserved accross migration until machine reset.
>=20
> This is required to be able to support PHB hotplug.
>=20
> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, so we
> have to introduce its number even if QEMU currently doesn't implement it.
>=20
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>

Ugh.  I really, really hope we can avoid this, though I don't
immediately see how.  Having to have two way communication between
qemu and SLOF about the device tree contents just seems like opening
the door to endless complexities.

This is basically a consequence of the fact that both qemu and partly
responsible for constructing the device tree for the guest, and that's
not easy to avoid.

Hrm.. Thomas, I know it's not really the OF way, but would it be
feasible to change SLOF to use the phandles as supplied by qemu rather
than creating its own?

> ---
>  hw/ppc/spapr.c         |   25 +++++++++++++++++++++++--
>  hw/ppc/spapr_hcall.c   |   20 ++++++++++++++++++++
>  include/hw/ppc/spapr.h |   11 ++++++++++-
>  3 files changed, 53 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 1a6cd4efeb97..90485054c2e7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -96,8 +96,6 @@
> =20
>  #define MIN_RMA_SLOF            128UL
> =20
> -#define PHANDLE_XICP            0x00001111
> -
>  /* maximum number of hotpluggable PHBs */
>  #define SPAPR_DRC_MAX_PHB       256
> =20
> @@ -1454,6 +1452,7 @@ static void ppc_spapr_reset(void)
>      first_ppc_cpu->env.nip =3D SPAPR_ENTRY_POINT;
> =20
>      spapr->cas_reboot =3D false;
> +    spapr->xics_phandle =3D UINT32_MAX;

Uh, is this defaulting to the phandle being (u32)(-1)?  That's one of
the two explicitly forbidden values for a phandle, so that's probably
not a good idea.

>  }
> =20
>  static void spapr_create_nvram(sPAPRMachineState *spapr)
> @@ -1652,6 +1651,26 @@ static const VMStateDescription vmstate_spapr_patb=
_entry =3D {
>      },
>  };
> =20
> +static bool spapr_xics_phandle_needed(void *opaque)
> +{
> +    sPAPRMachineState *spapr =3D opaque;
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(MACHINE(spapr));
> +
> +    /* Don't break older machine types that don't support PHB hotplug. */
> +    return smc->dr_phb_enabled && spapr->xics_phandle !=3D UINT32_MAX;
> +}
> +
> +static const VMStateDescription vmstate_spapr_xics_phandle =3D {
> +    .name =3D "spapr_xics_phandle",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D spapr_xics_phandle_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(xics_phandle, sPAPRMachineState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
>  static const VMStateDescription vmstate_spapr =3D {
>      .name =3D "spapr",
>      .version_id =3D 3,
> @@ -1671,6 +1690,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_ov5_cas,
>          &vmstate_spapr_patb_entry,
>          &vmstate_spapr_pending_events,
> +        &vmstate_spapr_xics_phandle,
>          NULL
>      }
>  };
> @@ -2702,6 +2722,7 @@ static void spapr_machine_initfn(Object *obj)
> =20
>      spapr->htab_fd =3D -1;
>      spapr->use_hotplug_event_source =3D true;
> +    spapr->xics_phandle =3D UINT32_MAX;
>      object_property_add_str(obj, "kvm-type",
>                              spapr_get_kvm_type, spapr_set_kvm_type, NULL=
);
>      object_property_set_description(obj, "kvm-type",
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72ea5a8247bf..ce8a9eb66b23 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1623,6 +1623,25 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_update_phandle(PowerPCCPU *cpu, sPAPRMachineState =
*spapr,
> +                                     target_ulong opcode, target_ulong *=
args)
> +{
> +    target_ulong old_phandle =3D args[0];
> +    target_ulong new_phandle =3D args[1];
> +
> +    if (new_phandle >=3D UINT32_MAX) {
> +        return H_PARAMETER;
> +    }
> +
> +    /* We only have a "phandle" property in the XICS node at the moment.=
 */
> +    if (old_phandle !=3D (uint32_t) PHANDLE_XICP) {
> +        return H_PARAMETER;
> +    }
> +
> +    spapr->xics_phandle =3D (uint32_t) new_phandle;
> +    return H_SUCCESS;
> +}
> +
>  static spapr_hcall_fn papr_hypercall_table[(MAX_HCALL_OPCODE / 4) + 1];
>  static spapr_hcall_fn kvmppc_hypercall_table[KVMPPC_HCALL_MAX - KVMPPC_H=
CALL_BASE + 1];
> =20
> @@ -1717,6 +1736,7 @@ static void hypercall_register_types(void)
> =20
>      /* qemu/KVM-PPC specific hcalls */
>      spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
> +    spapr_register_hypercall(KVMPPC_H_UPDATE_PHANDLE, h_update_phandle);
> =20
>      /* ibm,client-architecture-support support */
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 8004d9c2ab2c..f09c54d5bb94 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -125,6 +125,8 @@ struct sPAPRMachineState {
> =20
>      bool dr_phb_enabled; /* hotplug / dynamic-reconfiguration of PHBs */
> =20
> +    uint32_t xics_phandle;
> +
>      /*< public >*/
>      char *kvm_type;
>      MemoryHotplugState hotplug_memory;
> @@ -402,7 +404,9 @@ struct sPAPRMachineState {
>  #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
>  /* Client Architecture support */
>  #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
> -#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
> +#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
> +#define KVMPPC_H_UPDATE_PHANDLE (KVMPPC_HCALL_BASE + 0x4)
> +#define KVMPPC_HCALL_MAX        KVMPPC_H_UPDATE_PHANDLE
> =20
>  typedef struct sPAPRDeviceTreeUpdateHeader {
>      uint32_t version_id;
> @@ -707,4 +711,9 @@ void spapr_do_system_reset_on_cpu(CPUState *cs, run_o=
n_cpu_data arg);
> =20
>  #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
> =20
> +/* Boot time value of the "phandle" property of the "interrupt-controlle=
r"
> + * node.
> + */
> +#define PHANDLE_XICP            0x00001111
> +
>  #endif /* HW_SPAPR_H */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jaTU8Y2VLE5tlY1O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll6t24ACgkQbDjKyiDZ
s5JYaxAAmKSg3IGqjqTArwLDw+8Ny31Guv9QIO3TTlh5G2F0mwH/SP9VBHz/ebO/
wwCks15CdZdwpLYAM/PKd+wZCV/B9d0EeFRkRp6Q6kFsMpXDCuoDY7h+Snv2KaMo
e7zVYN7T95fQYoZa32Kwqfr+Vt62ZPLtVXYPmGMKslGeLz51JVckecEIpeS4ZomK
B8Zpy71RfITyIREd8IYv4r0rSzF9idpnHeVU2LkiwBOdqccOWEvpKQrpYHJxOvuN
HWivGB2sB5CWpThY+FWQ+1/WeUMHG9Ct+Bj6zRPAG50P9c4Qjlaw9djA86HcXw6V
HOZ1Ln/Q8osLbdpR587Fbxz2/V2smxtzSxdjwCjg8hef75Ixpz9YYj+Cpjhs9Cnc
L3hvH23OM1Qspl+m2omavgsf4sIog1ZSY9eQsgTqaQBln6twllOuWY1aXXo5ILd3
jAb8i7MrklDcscrhagiPH7I5juKnqdY4JKFSf2qShpZ53g5kE5pSFNTq57FZXC/y
7TeYfEKcROH4Er2JoC1/uE+cbbBrkOz2/cZQ5+DexHTat6O6dgnhWx3Sc7lhcmxT
wmAmCrLgvcibuhgUk+THPvwGs6pF4ixwaPAzrVgNSoLEb2BkKGCJhX0qBVJJLLZS
b9kHDSxjJjgVqTAk1RdYAjTtTPwuq6yKWrsQJDq5TXDhkR5z+KI=
=ukfq
-----END PGP SIGNATURE-----

--jaTU8Y2VLE5tlY1O--
