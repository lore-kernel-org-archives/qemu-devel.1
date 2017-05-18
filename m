Received: from eggs.gnu.org ([2001:4830:134:3::10]:39203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGLC-00072j-NZ
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGL9-0006X1-JF
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:59:22 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:34341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBGL9-0006Wk-9X
	for qemu-devel@nongnu.org; Thu, 18 May 2017 03:59:19 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id A3C0DD329A
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 09:59:16 +0200 (CEST)
Date: Thu, 18 May 2017 09:59:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518095908.185ae9ab@bahia.lan>
In-Reply-To: <20170518054522.13141-2-david@gibson.dropbear.id.au>
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
	<20170518054522.13141-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6WjHaUf4jWhwOnPPavO4len";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 1/3] pseries: Split CAS PVR negotiation out
 into a separate function
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

--Sig_/6WjHaUf4jWhwOnPPavO4len
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2017 15:45:20 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Guests of the qemu machine type go through a feature negotiation process
> known as "client architecture support" (CAS) during early boot.  This does
> a number of things, one of which is finding a CPU compatibility mode which
> can be supported by both guest and host.
>=20
> In fact the CPU negotiation is probably the single most complex part of t=
he
> CAS process, so this splits it out into a helper function.  We've recently
> made some mistakes in maintaining backward compatibility for old machine
> types here.  Splitting this out will also make it easier to fix this.
>=20
> This also adds a possibly useful error message if the negotiation fails
> (i.e. if there isn't a CPU mode that's suitable for both guest and host).
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_hcall.c | 49 ++++++++++++++++++++++++++++++++--------------=
---
>  1 file changed, 32 insertions(+), 17 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 2daace4..77d2d66 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1044,19 +1044,13 @@ static target_ulong h_signal_sys_reset(PowerPCCPU=
 *cpu,
>      }
>  }
> =20
> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> -                                                  sPAPRMachineState *spa=
pr,
> -                                                  target_ulong opcode,
> -                                                  target_ulong *args)
> +static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong *addr,
> +                              Error **errp)
>  {
> -    target_ulong list =3D ppc64_phys_to_real(args[0]);
> -    target_ulong ov_table;
>      bool explicit_match =3D false; /* Matched the CPU's real PVR */
>      uint32_t max_compat =3D cpu->max_compat;
>      uint32_t best_compat =3D 0;
>      int i;
> -    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> -    bool guest_radix;
> =20
>      /*
>       * We scan the supplied table of PVRs looking for two things
> @@ -1066,9 +1060,9 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      for (i =3D 0; i < 512; ++i) {
>          uint32_t pvr, pvr_mask;
> =20
> -        pvr_mask =3D ldl_be_phys(&address_space_memory, list);
> -        pvr =3D ldl_be_phys(&address_space_memory, list + 4);
> -        list +=3D 8;
> +        pvr_mask =3D ldl_be_phys(&address_space_memory, *addr);
> +        pvr =3D ldl_be_phys(&address_space_memory, *addr + 4);
> +        *addr +=3D 8;
> =20
>          if (~pvr_mask & pvr) {
>              break; /* Terminator record */
> @@ -1087,17 +1081,38 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>          /* We couldn't find a suitable compatibility mode, and either
>           * the guest doesn't support "raw" mode for this CPU, or raw
>           * mode is disabled because a maximum compat mode is set */
> -        return H_HARDWARE;
> +        error_setg(errp, "Couldn't negotiate a suitable PVR during CAS");
> +        return 0;
>      }
> =20
>      /* Parsing finished */
>      trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
> =20
> -    /* Update CPUs */
> -    if (cpu->compat_pvr !=3D best_compat) {
> -        Error *local_err =3D NULL;
> +    return best_compat;
> +}
> =20
> -        ppc_set_compat_all(best_compat, &local_err);
> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> +                                                  sPAPRMachineState *spa=
pr,
> +                                                  target_ulong opcode,
> +                                                  target_ulong *args)
> +{
> +    /* Working address in data buffer */
> +    target_ulong addr =3D ppc64_phys_to_real(args[0]);
> +    target_ulong ov_table;
> +    uint32_t cas_pvr;
> +    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> +    bool guest_radix;
> +    Error *local_err =3D NULL;
> +
> +    cas_pvr =3D cas_check_pvr(cpu, &addr, &local_err);
> +    if (local_err) {
> +        error_report_err(local_err);
> +        return H_HARDWARE;
> +    }
> +
> +    /* Update CPUs */
> +    if (cpu->compat_pvr !=3D cas_pvr) {
> +        ppc_set_compat_all(cas_pvr, &local_err);
>          if (local_err) {
>              error_report_err(local_err);
>              return H_HARDWARE;
> @@ -1105,7 +1120,7 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      }
> =20
>      /* For the future use: here @ov_table points to the first option vec=
tor */
> -    ov_table =3D list;
> +    ov_table =3D addr;
> =20
>      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
>      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);


--Sig_/6WjHaUf4jWhwOnPPavO4len
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdVEwACgkQAvw66wEB28LF6ACeKkGm58XPiiKVlsNwhWN1xsRl
wmoAoJnGytjAQQPsE1ofERfNm4xOB2eP
=jTBt
-----END PGP SIGNATURE-----

--Sig_/6WjHaUf4jWhwOnPPavO4len--
