Received: from eggs.gnu.org ([2001:4830:134:3::10]:51276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeIE-0005qw-B1
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dmeI8-0001Gu-C8
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 07:02:50 -0400
Date: Tue, 29 Aug 2017 17:38:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170829073800.GO2578@umbus.fritz.box>
References: <150296903004.12575.16996499098384404656.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Content-Disposition: inline
In-Reply-To: <150296903004.12575.16996499098384404656.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v2] spapr: fallback to raw mode if best
 compat mode cannot be set during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 01:23:50PM +0200, Greg Kurz wrote:
> KVM PR doesn't allow to set a compat mode. This causes ppc_set_compat_all=
()
> to fail and we return H_HARDWARE to the guest right away.
>=20
> This is excessive: even if we favor compat mode since commit 152ef803ceb1=
9,
> we should at least fallback to raw mode if the guest supports it.
>=20
> This patch modifies cas_check_pvr() so that it also reports that the real
> PVR was found in the table supplied by the guest. Note that this is only
> makes sense if raw mode isn't explicitely disabled (ie, the user didn't
> set the machine "max-cpu-compat" property). If this is the case, we can
> simply ignore ppc_set_compat_all() failures, and let the guest run in raw
> mode.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> v2: - initialize raw_mode_supported to silent patchew

I hesitated about this, because making guest visible changes based on
host abilities can get really messy.  However we already have a bunch
of things like that in CAS, and we already migrate the compatibility
state, so I think it should be ok.

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_hcall.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 07b3da8dc4cd..2f4c4f59e110 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1441,7 +1441,8 @@ static target_ulong h_signal_sys_reset(PowerPCCPU *=
cpu,
>  }
> =20
>  static uint32_t cas_check_pvr(sPAPRMachineState *spapr, PowerPCCPU *cpu,
> -                              target_ulong *addr, Error **errp)
> +                              target_ulong *addr, bool *raw_mode_support=
ed,
> +                              Error **errp)
>  {
>      bool explicit_match =3D false; /* Matched the CPU's real PVR */
>      uint32_t max_compat =3D spapr->max_compat_pvr;
> @@ -1481,6 +1482,8 @@ static uint32_t cas_check_pvr(sPAPRMachineState *sp=
apr, PowerPCCPU *cpu,
>          return 0;
>      }
> =20
> +    *raw_mode_supported =3D explicit_match;
> +
>      /* Parsing finished */
>      trace_spapr_cas_pvr(cpu->compat_pvr, explicit_match, best_compat);
> =20
> @@ -1499,8 +1502,9 @@ static target_ulong h_client_architecture_support(P=
owerPCCPU *cpu,
>      sPAPROptionVector *ov1_guest, *ov5_guest, *ov5_cas_old, *ov5_updates;
>      bool guest_radix;
>      Error *local_err =3D NULL;
> +    bool raw_mode_supported =3D false;
> =20
> -    cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &local_err);
> +    cas_pvr =3D cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &l=
ocal_err);
>      if (local_err) {
>          error_report_err(local_err);
>          return H_HARDWARE;
> @@ -1510,8 +1514,14 @@ static target_ulong h_client_architecture_support(=
PowerPCCPU *cpu,
>      if (cpu->compat_pvr !=3D cas_pvr) {
>          ppc_set_compat_all(cas_pvr, &local_err);
>          if (local_err) {
> -            error_report_err(local_err);
> -            return H_HARDWARE;
> +            /* We fail to set compat mode (likely because running with K=
VM PR),
> +             * but maybe we can fallback to raw mode if the guest suppor=
ts it.
> +             */
> +            if (!raw_mode_supported) {
> +                error_report_err(local_err);
> +                return H_HARDWARE;
> +            }
> +            local_err =3D NULL;
>          }
>      }
> =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmlGdgACgkQbDjKyiDZ
s5ITUxAAhDNIzA/eYjDFOsHZNgzPfn05+20PgIszc2HLO7OAlJq0lx3wCjQ4WvLu
ZFAClUJUGxkJIeTHUHXQP/NqB3Aw/ghvjrpcK420KvrbHLXXeFlmBi4tPX2a5GV5
E0RUohyjd/EwzHBEEDLtZMzRiR28IVverHFFPuEfT8anog74C/E0hyPQumQmrGz9
RC9KzKgk1moq7YINDV1jNs+cMU2ujIpkHnZaPZlzvFsvxu7fjKaEd3wU/fhtLoi/
uSdUYPG54HD9tU5PQkL9/3ssluU9t7Lsinv7xvytjA0TLyPkPBxkBSY+RQkE10/Y
Je0rodx+1JX0OOx5V5m248dSSjlbeIj5TChvyhLOiHk2v1Otlzqr6kAUftyC+unK
/UPWnR+p8qVY2zpQ9OwcqpkbYk75lM7Bu4IOFyBKq3kzx04gAJoxlaPITQkguQ/C
9d7c13skkrv19wRFej7xgmwPhfVYEWNn8WbnCJQF1mCwQ1fp4xN+1dpIrtR7GDJT
9ATZK5GLlGUlPV7LJIhuMhgpEFWy9PAJwrrql5rRcISMAni7tbkJ36GTn8ddN4qZ
FmhjsvKtMDg4HeovHu7/nI83vx5JA1dOAcqIyBcnAtRV7n3ut/N9LldsQgswC+Oa
+w+b2sCjx2bgUZLer3SUYASCZWp/9gOjDglq73boaj49TQXnnfY=
=rFhj
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
