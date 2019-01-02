Received: from eggs.gnu.org ([208.118.235.92]:47590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXl-0004mS-Mz
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geXXk-00066l-C5
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 22:50:09 -0500
Date: Wed, 2 Jan 2019 14:18:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102031830.GI27457@umbus.fritz.box>
References: <20181219163541.13979-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Content-Disposition: inline
In-Reply-To: <20181219163541.13979-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: Add H-Call
 H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>


--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 19, 2018 at 05:35:41PM +0100, Laurent Vivier wrote:
> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
> designation associated with the identifier input parameter
>=20
> This fixes a crash when we try to hotplug a CPU in memory-less and
> CPU-less numa node. In this case, the kernel tries to online the
> node, but without the information provided by this h-call, the node id,
> it cannot and the CPU is started while the node is not onlined.
>=20
> It also removes the warning message from the kernel:
>   VPHN is not supported. Disabling polling..
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Applied to ppc-for-4.0, thanks.

> ---
>=20
> Notes:
>     v3:
>       add parentheses around a and b
>    =20
>     v2:
>       add hcall-vphn to ibm,hypertas-functions
>       correctly check flags
>       return H_FUNCTION rather than H_PARAMETER
>       update description
>=20
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_hcall.c   | 40 ++++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 42 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 7a0ab2da54..d961272c8a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1049,6 +1049,7 @@ static void spapr_dt_rtas(sPAPRMachineState *spapr,=
 void *fdt)
>      add_str(hypertas, "hcall-sprg0");
>      add_str(hypertas, "hcall-copy");
>      add_str(hypertas, "hcall-debug");
> +    add_str(hypertas, "hcall-vphn");
>      add_str(qemu_hypertas, "hcall-memop1");
> =20
>      if (!kvm_enabled() || kvmppc_spapr_use_multitce()) {
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 78fecc8fe9..1ae3e6ff5e 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1663,6 +1663,42 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      return H_SUCCESS;
>  }
> =20
> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                              sPAPRMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    target_ulong flags =3D args[0];
> +    target_ulong procno =3D args[1];
> +    PowerPCCPU *tcpu;
> +    int idx;
> +
> +    /* only support procno from H_REGISTER_VPA */
> +    if (flags !=3D 0x1) {
> +        return H_FUNCTION;
> +    }
> +
> +    tcpu =3D spapr_find_cpu(procno);
> +    if (tcpu =3D=3D NULL) {
> +        return H_P2;
> +    }
> +
> +    /* sequence is the same as in the "ibm,associativity" property */
> +
> +    idx =3D 0;
> +#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> +                             ((uint64_t)(b) & 0xffffffff))
> +    args[idx++] =3D ASSOCIATIVITY(0, 0);
> +    args[idx++] =3D ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] =3D ASSOCIATIVITY(procno, -1);
> +    for ( ; idx < 6; idx++) {
> +        args[idx] =3D -1;
> +    }
> +#undef ASSOCIATIVITY
> +
> +    return H_SUCCESS;
> +}
> +
>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>                                                sPAPRMachineState *spapr,
>                                                target_ulong opcode,
> @@ -1864,6 +1900,10 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support=
);
> =20
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> +
> +    /* Virtual Processor Home Node */
> +    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> +                             h_home_node_associativity);
>  }
> =20
>  type_init(hypercall_register_types)
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b1a2515107..eb13e2b614 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -447,6 +447,7 @@ struct sPAPRMachineState {
>  #define H_GET_EM_PARMS          0x2B8
>  #define H_SET_MPP               0x2D0
>  #define H_GET_MPP               0x2D4
> +#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
>  #define H_XIRR_X                0x2FC
>  #define H_RANDOM                0x300
>  #define H_SET_MODE              0x31C

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsLYMACgkQbDjKyiDZ
s5LrQQ//YPetdKHWvqIYcW9m0hshNmLTarBvseytm5g3UIw0CNLXCYwdHF7fwTye
Wvi0Rw+T5A9S70ueM6oQosw0N1Uhbf1YJcSl/qmJwyf051y2Lck5QEkS68LWeGX8
ZvyfH2peBKT/teZcRTWdCIL9UpbIjZvlDvi+nNtkHE09736/kMmYDmsQGcgUseAL
JTos0JbfM8J1zmHkMff4uTvoY9RK7GA5sEG5OPkfFgwPZhfetBapVu2h9/Ih6iKM
G5VFQZILluaHfeb9477g4mb2hCMczPv+v2End8tLmlcSOW4s9P42SWjEJ/RM9cAZ
HOmpaUrnurFGYY/OH4YGbZn0tcPGivwHH3ZhaFgWrr31rEca+CbBUGs+7SWctF31
7NR/CgKWGvGejwDUNkYz89QGOVzAPgP6hkOpNMrv03tlphfz5jJkuW7erDEAxCBm
zy0a2XJ6FkYibDG3wjFKV0bXNnxscH37D4J8PIePVUNL2KgrPrU8l0oTryXQ6kvA
3WygPO1n+d7EIMyxvM86KWC5UQtOOol4jEYTk+N0BDYIcrsZ2G+hPHAIMf/f5Xq3
TPpzb0TJYeeIdDBBimyBMvdmnZ+ZNUCcF099pliW+in7bQfKo4M3aaWeSpAQWiVM
wvtsYyb1U3Mdv9OTh2gzwrknE6sFUmwTzlPOEcCAKTJ/ZIeTJJU=
=3SO4
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
