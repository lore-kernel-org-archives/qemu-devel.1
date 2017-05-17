Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB1K5-0006l1-90
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dB1K2-0003zK-6n
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:57:13 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:34496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dB1K1-0003yf-U9
	for qemu-devel@nongnu.org; Wed, 17 May 2017 11:57:10 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 52BEBD2C24
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 17:57:08 +0200 (CEST)
Date: Wed, 17 May 2017 17:56:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170517175657.0c0f7666@bahia.lan>
In-Reply-To: <20170517063547.23876-2-david@gibson.dropbear.id.au>
References: <20170517063547.23876-1-david@gibson.dropbear.id.au>
	<20170517063547.23876-2-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/3uPbAmmRb09YrlEWu78vAxg";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC 1/2] pseries: Split CAS PVR
 negotiation out into a separate function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: abologna@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com

--Sig_/3uPbAmmRb09YrlEWu78vAxg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 May 2017 16:35:46 +1000
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
> (i.e. if there is CPU mode that's suitable for both guest and host).

s/if there is/if there isn't a/ ?

>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_hcall.c | 43 +++++++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 0d608d6..007ae8d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1047,19 +1047,13 @@ static target_ulong h_signal_sys_reset(PowerPCCPU=
 *cpu,
>      }
>  }
> =20
> -static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> -                                                  sPAPRMachineState *spa=
pr,
> -                                                  target_ulong opcode,
> -                                                  target_ulong *args)
> +static uint32_t cas_check_pvr(PowerPCCPU *cpu, target_ulong list,
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
> @@ -1090,26 +1084,43 @@ static target_ulong h_client_architecture_support=
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
> +
> +static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
> +                                                  sPAPRMachineState *spa=
pr,
> +                                                  target_ulong opcode,
> +                                                  target_ulong *args)
> +{
> +    /* @ov_table points to the first option vector */
> +    target_ulong ov_table =3D ppc64_phys_to_real(args[0]);
> +    uint32_t cas_pvr;
> +    sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
> +    bool guest_radix;
> +    Error *local_err =3D NULL;
> =20
> -        ppc_set_compat_all(best_compat, &local_err);
> +    cas_pvr =3D cas_check_pvr(cpu, ov_table, &local_err);

Shouldn't cas_check_pvr() take a target_ulong * so that we can get
the address of the first option vector...

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
>          }
>      }
> =20
> -    /* For the future use: here @ov_table points to the first option vec=
tor */
> -    ov_table =3D list;
> -

... and address Laurent's comment ?

>      ov1_guest =3D spapr_ovec_parse_vector(ov_table, 1);
>      ov5_guest =3D spapr_ovec_parse_vector(ov_table, 5);
>      if (spapr_ovec_test(ov5_guest, OV5_MMU_BOTH)) {


--Sig_/3uPbAmmRb09YrlEWu78vAxg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkccsoACgkQAvw66wEB28JUZQCdEl3H2cTK1ETFnVEqoBynFokk
D/0An05FRZh8PMQfpGZronCOB9hgl+1f
=sH6E
-----END PGP SIGNATURE-----

--Sig_/3uPbAmmRb09YrlEWu78vAxg--
