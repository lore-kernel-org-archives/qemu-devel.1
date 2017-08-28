Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dmFvx-0007nF-JQ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dmFvr-0007m7-V5
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:02:13 -0400
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:58785)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dmFvr-0007jq-O6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 05:02:07 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 14B7F1148A4
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 11:02:00 +0200 (CEST)
Date: Mon, 28 Aug 2017 11:01:54 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170828110154.476f05e9@bahia>
In-Reply-To: <150296903004.12575.16996499098384404656.stgit@bahia.lan>
References: <150296903004.12575.16996499098384404656.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/0nz2zq3F0.I25QKGH3JtLI9";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: fallback to raw mode
 if best compat mode cannot be set during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/0nz2zq3F0.I25QKGH3JtLI9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Aug 2017 13:23:50 +0200
Greg Kurz <groug@kaod.org> wrote:

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
> ---

Ping ?

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
>=20


--Sig_/0nz2zq3F0.I25QKGH3JtLI9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWaPcAgAKCRAC/DrrAQHb
wn9JAJwPTBmB51+CK8eZV+OzUTaqrzN/qwCfcoXzY11OqVAoiZuOqjMaMPkZt50=
=PPDb
-----END PGP SIGNATURE-----

--Sig_/0nz2zq3F0.I25QKGH3JtLI9--
