Received: from eggs.gnu.org ([2001:4830:134:3::10]:56828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ7AQ-0007Lw-Mz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:39:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZ7AP-0000ym-GG
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 23:39:38 -0500
Date: Tue, 18 Dec 2018 15:29:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218042938.GI23604@umbus.fritz.box>
References: <20181217140055.8545-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
Content-Disposition: inline
In-Reply-To: <20181217140055.8545-1-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: Add H-Call H_HOME_NODE_ASSOCIATIVITY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 03:00:55PM +0100, Laurent Vivier wrote:
> H_HOME_NODE_ASSOCIATIVITY H-Call returns the associativity domain
> designation associated with the identifier input parameter.
>=20
> Remove the warning message from the kernel:
>   VPHN is not supported. Disabling polling..
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

=46rom the looks of PAPR, I suspect this call isn't of much use outside
PowerVM guests, though it probably wouldn't do any harm.

BenH, Paulus, any thoughts?

One nit in implementation: if you implement this hcall, it's supposed
to be advertised by adding hcall-vphn to ibm,hypertas-functions.

> ---
> Based-on: <20181213040126.6768-1-david@gibson.dropbear.id.au>
>           "[PULL 00/27] ppc-for-4.0 queue 20181213"
>=20
>  hw/ppc/spapr_hcall.c   | 39 +++++++++++++++++++++++++++++++++++++++
>  include/hw/ppc/spapr.h |  1 +
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 78fecc8fe9..454ec594fd 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1663,6 +1663,41 @@ static target_ulong h_client_architecture_support(=
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
> +    if ((flags & 0x1) =3D=3D 0) {
> +        return H_PARAMETER;
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
> +#define ASSOCIATIVITY(a, b) (((uint64_t)a << 32) | ((uint64_t)b & 0xffff=
ffff))
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
> @@ -1864,6 +1899,10 @@ static void hypercall_register_types(void)
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

--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYd68ACgkQbDjKyiDZ
s5ISTg//WUXgehfDSrhvD5iNJb3hnPQ84q+KdI1cRZ1AjDdN0i88Y3Q7dtw1S3cb
ONx0bT1D7H9Q/pewKQzIUhVOoYsZqg1XXNy5uyjyl4qN0FVII9F/nOnOkvxquuUu
T1ibeTNY2u06MapH7K4oeFonWtxMlCyck+CWeFKi0AEdO14HI6dp4R50lm4PGoO0
FaPkRTpYlbiL+cr7gCByY/n9DKlc4vBFJCsdDxyxjX9ASvaQPi5fUno6xZVJIOqk
MzeBysJ+rGkxtVVferPisIon9kr+Nz4HnXKEjDRrCb0vsF3v8jmy2g4mN54NvRfd
fqMwwB2NvVo6TvslpLTveJSQFUlPldWjC2F6VpwwB7SErWgRQ/SVwEc31ZsWOFI4
Iorx+lMvsB0RC0LgI4Ioztdi0/NDLKW+C5tXxuAr0NWeKjLy7VZ3XKZK0mt9UGUc
FuhUqD93IyABrdDmnIQqMdLzhk0PLmsTDizalDFdrT5EZkqBciyAN7kVUR8r1gUt
xEA2kFceMe4gLNNdq7ePPWeMa6bHb7c72ahe3Ub8VgTX7Vbu/4bZHUdzSyOHe81V
+S8QOaSA55Goi6ZM8MX6ANVH9v+Ms0pfG3fu+m4Nv5bQ6FA8H4h407M0AGZstfi4
v0z0OQkmjrhNZGG8fLnVwhREwgWMdmd164o/E2j8GA+BvSdTZcU=
=uBuW
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--
