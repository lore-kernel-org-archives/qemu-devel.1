Received: from eggs.gnu.org ([2001:4830:134:3::10]:39823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGNP-00088a-WD
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGNM-00076n-PI
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:01:40 -0400
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:53592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBGNM-00076R-CW
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:01:36 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 14957D32A9
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:01:31 +0200 (CEST)
Date: Thu, 18 May 2017 10:01:23 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518100123.461f0d1d@bahia.lan>
In-Reply-To: <20170518054522.13141-3-david@gibson.dropbear.id.au>
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
	<20170518054522.13141-3-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oNsbEBhn60Wb0XFMTOk1QGh";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/3] pseries: Restore PVR negotiation logic
 for pre-2.9 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/oNsbEBhn60Wb0XFMTOk1QGh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2017 15:45:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> "pseries" guests go through a hypervisor<->guest feature negotiation duri=
ng
> early boot.  Part of this is finding a CPU compatibility mode which works
> for both.
>=20
> In 152ef80 "pseries: Rewrite CAS PVR compatibility logic" this logic was
> changed to strongly prefer architecture defined CPU compatibility modes,
> rather than CPU "raw" modes.  However, this change was made universally,
> which introduces a guest visible change for the previously existing machi=
ne
> types (pseries-2.8 and earlier).  That's never supposed to happen.
>=20
> This corrects the behaviour, reverting to the old PVR negotiation logic
> for machine types prior to pseries-2.9.
>=20
> Fixes: 152ef803ceb1959e2380a1da7736b935b109222e
> Reported-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         |  3 ++
>  hw/ppc/spapr_hcall.c   | 90 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  include/hw/ppc/spapr.h |  1 +
>  3 files changed, 93 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 35dceb0..ad8ddf2 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3313,9 +3313,12 @@ static void spapr_machine_2_8_instance_options(Mac=
hineState *machine)
> =20
>  static void spapr_machine_2_8_class_options(MachineClass *mc)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_2_9_class_options(mc);
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_8);
>      mc->numa_mem_align_shift =3D 23;
> +    smc->pre_2_9_cas_pvr =3D true;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 77d2d66..a790da7 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1044,6 +1044,89 @@ static target_ulong h_signal_sys_reset(PowerPCCPU =
*cpu,
>      }
>  }
> =20
> +/*
> + * Old logic for PVR negotiation, used old <2.9 machine types for
> + * compatibility with old qemu versions
> + */
> +#define get_compat_level(cpuver) (                  \
> +        ((cpuver) =3D=3D CPU_POWERPC_LOGICAL_2_05) ? 2050 : \
> +        ((cpuver) =3D=3D CPU_POWERPC_LOGICAL_2_06) ? 2060 :  \
> +        ((cpuver) =3D=3D CPU_POWERPC_LOGICAL_2_06_PLUS) ? 2061 :    \
> +        ((cpuver) =3D=3D CPU_POWERPC_LOGICAL_2_07) ? 2070 : 0)
> +
> +static void cas_handle_compat_cpu(PowerPCCPUClass *pcc, uint32_t pvr,
> +                                  unsigned max_lvl, unsigned *compat_lvl,
> +                                  unsigned *compat_pvr)
> +{
> +    unsigned lvl =3D get_compat_level(pvr);
> +    bool is205, is206, is207;
> +
> +    if (!lvl) {
> +        return;
> +    }
> +
> +    /* If it is a logical PVR, try to determine the highest level */
> +    is205 =3D (pcc->pcr_supported & PCR_COMPAT_2_05) &&
> +        (lvl =3D=3D get_compat_level(CPU_POWERPC_LOGICAL_2_05));
> +    is206 =3D (pcc->pcr_supported & PCR_COMPAT_2_06) &&
> +        ((lvl =3D=3D get_compat_level(CPU_POWERPC_LOGICAL_2_06)) ||
> +         (lvl =3D=3D get_compat_level(CPU_POWERPC_LOGICAL_2_06_PLUS)));
> +    is207 =3D (pcc->pcr_supported & PCR_COMPAT_2_07) &&
> +        (lvl =3D=3D get_compat_level(CPU_POWERPC_LOGICAL_2_07));
> +
> +    if (is205 || is206 || is207) {
> +        if (!max_lvl) {
> +            /* User did not set the level, choose the highest */
> +            if (*compat_lvl <=3D lvl) {
> +                *compat_lvl =3D lvl;
> +                *compat_pvr =3D pvr;
> +            }
> +        } else if (max_lvl >=3D lvl) {
> +            /* User chose the level, don't set higher than this */
> +            *compat_lvl =3D lvl;
> +            *compat_pvr =3D pvr;
> +        }
> +    }
> +}
> +
> +static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *cpu, target_ulong *add=
r,
> +                                      Error **errp)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    int counter;
> +    unsigned max_lvl =3D get_compat_level(cpu->max_compat);
> +    bool cpu_match =3D false;
> +    unsigned compat_lvl =3D 0, compat_pvr =3D 0;
> +
> +    for (counter =3D 0; counter < 512; ++counter) {
> +        uint32_t pvr, pvr_mask;
> +
> +        pvr_mask =3D ldl_be_phys(&address_space_memory, *addr);
> +        pvr =3D ldl_be_phys(&address_space_memory, *addr + 4);
> +        *addr +=3D 8;
> +
> +        if (~pvr_mask & pvr) {
> +            break; /* Terminator record */
> +        }
> +
> +        trace_spapr_cas_pvr_try(pvr);
> +        if (!max_lvl &&
> +            ((cpu->env.spr[SPR_PVR] & pvr_mask) =3D=3D (pvr & pvr_mask))=
) {
> +            cpu_match =3D true;
> +            compat_pvr =3D 0;
> +        } else if (pvr =3D=3D cpu->compat_pvr) {
> +            cpu_match =3D true;
> +            compat_pvr =3D cpu->compat_pvr;
> +        } else if (!cpu_match) {
> +            cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compa=
t_pvr);
> +        }
> +    }
> +
> +    trace_spapr_cas_pvr(cpu->compat_pvr, cpu_match, compat_pvr);
> +
> +    return compat_pvr;
> +}
> +
>  static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
>                                Error **errp)
>  {
> @@ -1096,6 +1179,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>                                                    target_ulong opcode,
>                                                    target_ulong *args)
>  {
> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
>      /* Working address in data buffer */
>      target_ulong addr =3D ppc64_phys_to_real(args[0]);
>      target_ulong ov_table;
> @@ -1104,7 +1188,11 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      bool guest_radix;
>      Error *local_err =3D NULL;
> =20
> -    cas_pvr =3D cas_check_pvr(cpu, &addr, &local_err);
> +    if (smc->pre_2_9_cas_pvr) {
> +        cas_pvr =3D cas_check_pvr_pre_2_9(cpu, &addr, &local_err);
> +    } else {
> +        cas_pvr =3D cas_check_pvr(cpu, &addr, &local_err);
> +    }
>      if (local_err) {
>          error_report_err(local_err);
>          return H_HARDWARE;
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 93c4cfc..f875dc4 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -52,6 +52,7 @@ struct sPAPRMachineClass {
>      /*< public >*/
>      bool dr_lmb_enabled;       /* enable dynamic-reconfig/hotplug of LMB=
s */
>      bool use_ohci_by_default;  /* use USB-OHCI instead of XHCI */
> +    bool pre_2_9_cas_pvr;      /* Use old logic for PVR compat negotiati=
on */
>      const char *tcg_default_cpu; /* which (TCG) CPU to simulate by defau=
lt */
>      void (*phb_placement)(sPAPRMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio,=20


--Sig_/oNsbEBhn60Wb0XFMTOk1QGh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdVNMACgkQAvw66wEB28Js7gCeOiNArvKPYt74WH288QjAKyc3
BKMAnji32SZc4WdxFbmc/aMy2yPJpjSL
=liEy
-----END PGP SIGNATURE-----

--Sig_/oNsbEBhn60Wb0XFMTOk1QGh--
