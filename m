Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGT6-00027j-0p
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBGT2-0000iM-Qj
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:07:32 -0400
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:58427)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBGT2-0000ht-He
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:07:28 -0400
Received: from player797.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2964BD32E4
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 10:07:27 +0200 (CEST)
Date: Thu, 18 May 2017 10:07:19 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170518100719.25cda341@bahia.lan>
In-Reply-To: <20170518054522.13141-4-david@gibson.dropbear.id.au>
References: <20170518054522.13141-1-david@gibson.dropbear.id.au>
	<20170518054522.13141-4-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/6gVOkMza5HBWpXeQCET+Iz0";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/3] pseries: Improve tracing of CPU
 compatibility negotiation
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

--Sig_/6gVOkMza5HBWpXeQCET+Iz0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 18 May 2017 15:45:22 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This makes some improvements to the debug tracepoints around the
> negotiation of CPU compatibility mode during CAS.  The traces are
> reorganized to emphasise what the inputs and outputs of the process are,
> then distinguish the internal state of the two possible negotiation paths
> (current and pre-2.8 machine type compatibility).
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_hcall.c | 14 ++++++++------
>  hw/ppc/trace-events  |  6 ++++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index a790da7..cea5d99 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1109,7 +1109,6 @@ static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU *c=
pu, target_ulong *addr,
>              break; /* Terminator record */
>          }
> =20
> -        trace_spapr_cas_pvr_try(pvr);
>          if (!max_lvl &&
>              ((cpu->env.spr[SPR_PVR] & pvr_mask) =3D=3D (pvr & pvr_mask))=
) {
>              cpu_match =3D true;
> @@ -1120,10 +1119,10 @@ static uint32_t cas_check_pvr_pre_2_9(PowerPCCPU =
*cpu, target_ulong *addr,
>          } else if (!cpu_match) {
>              cas_handle_compat_cpu(pcc, pvr, max_lvl, &compat_lvl, &compa=
t_pvr);
>          }
> +        trace_cas_check_pvr_pre_2_9(pvr, pvr_mask, cpu_match,
> +                                    compat_lvl, compat_pvr);
>      }
> =20
> -    trace_spapr_cas_pvr(cpu->compat_pvr, cpu_match, compat_pvr);
> -
>      return compat_pvr;
>  }
> =20
> @@ -1158,6 +1157,7 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, targ=
et_ulong *addr,
>                  best_compat =3D pvr;
>              }
>          }
> +        trace_cas_check_pvr(pvr, pvr_mask, explicit_match, best_compat);
>      }
> =20
>      if ((best_compat =3D=3D 0) && (!explicit_match || max_compat)) {
> @@ -1168,9 +1168,6 @@ static uint32_t cas_check_pvr(PowerPCCPU *cpu, targ=
et_ulong *addr,
>          return 0;
>      }
> =20
> -    /* Parsing finished */
> -    trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
> -
>      return best_compat;
>  }
> =20
> @@ -1188,6 +1185,9 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      bool guest_radix;
>      Error *local_err =3D NULL;
> =20
> +    trace_cas_check_pvr_start(cpu->compat_pvr, cpu->max_compat,
> +                              cpu->env.spr[SPR_PVR]);
> +
>      if (smc->pre_2_9_cas_pvr) {
>          cas_pvr =3D cas_check_pvr_pre_2_9(cpu, &addr, &local_err);
>      } else {
> @@ -1198,6 +1198,8 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>          return H_HARDWARE;
>      }
> =20
> +    trace_cas_check_pvr_complete(cpu->compat_pvr, cas_pvr);
> +
>      /* Update CPUs */
>      if (cpu->compat_pvr !=3D cas_pvr) {
>          ppc_set_compat_all(cas_pvr, &local_err);
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index 43d265f..5329740 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -14,8 +14,10 @@ spapr_cas_failed(unsigned long n) "DT diff buffer is t=
oo small: %ld bytes"
>  spapr_cas_continue(unsigned long n) "Copy changes to the guest: %ld byte=
s"
> =20
>  # hw/ppc/spapr_hcall.c
> -spapr_cas_pvr_try(uint32_t pvr) "%x"
> -spapr_cas_pvr(uint32_t cur_pvr, bool explicit_match, uint32_t new_pvr) "=
current=3D%x, explicit_match=3D%u, new=3D%x"
> +cas_check_pvr_pre_2_9(uint32_t pvr, uint32_t mask, bool match, unsigned =
lvl, uint32_t compat_pvr) "0x%08x/0x%08x match=3D%d lvl=3D%d compat_pvr=3D0=
x%x"
> +cas_check_pvr(uint32_t pvr, uint32_t pvr_mask, bool explicit_match, uint=
32_t best_compat) "0x%08x/0x%08x explicit_match=3D%d best_compat=3D0x%08x"
> +cas_check_pvr_start(uint32_t compat_pvr, uint32_t max_compat, uint32_t p=
hys_pvr) "Initial compat PVR 0x%08x, max compat 0x%08x (real PVR 0x%08x)"
> +cas_check_pvr_complete(uint32_t old_pvr, uint32_t new_pvr) "Compatibilit=
y PVR was 0x%08x, now 0x%08x"
> =20
>  # hw/ppc/spapr_iommu.c
>  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t re=
t) "liobn=3D%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId64


--Sig_/6gVOkMza5HBWpXeQCET+Iz0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkdVjcACgkQAvw66wEB28LVFQCeJg9H+do+3MmuoUJWiPsUsn8V
0bcAniXq2thjxcj0+akMXJK1WDsqBOAK
=iTTG
-----END PGP SIGNATURE-----

--Sig_/6gVOkMza5HBWpXeQCET+Iz0--
