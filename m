Received: from eggs.gnu.org ([2001:4830:134:3::10]:34478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddFNZ-0001RY-62
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:37:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ddFNU-0006sG-O8
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:37:29 -0400
Received: from 9.mo7.mail-out.ovh.net ([46.105.60.248]:51532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ddFNU-0006oB-HP
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 08:37:24 -0400
Received: from player788.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 0ABDB62DF9
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 14:37:22 +0200 (CEST)
Date: Thu, 3 Aug 2017 14:37:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170803143715.33d0a62c@bahia.lan>
In-Reply-To: <4646e612ef5efb4f17f07eaec18e940f7ae93382.1501740002.git.sam.bobroff@au1.ibm.com>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<4646e612ef5efb4f17f07eaec18e940f7ae93382.1501740002.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Bt6lwlxxblybH1v2T4U=nXw";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: Fix bug in
 h_signal_sys_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

--Sig_/Bt6lwlxxblybH1v2T4U=nXw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Aug 2017 16:28:27 +1000
Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:

> The unicast case in h_signal_sys_reset() seems to be broken:
> rather than selecting the target CPU, it looks like it will pick
> either the first CPU or fail to find one at all.
>=20
> Fix it by using the search function rather than open coding the
> search.
>=20

Heh the open coded search is using cpu where it should have been using
POWERPC_CPU(cs) =3D> it can only succeed if a the vCPU is signalling itself.

> This was found by inspection; the code appears to be unused because
> the Linux kernel only uses the broadcast target.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  hw/ppc/spapr_hcall.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 72ea5a8247..07b3da8dc4 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1431,11 +1431,10 @@ static target_ulong h_signal_sys_reset(PowerPCCPU=
 *cpu,
> =20
>      } else {
>          /* Unicast */
> -        CPU_FOREACH(cs) {
> -            if (cpu->cpu_dt_id =3D=3D target) {
> -                run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_=
NULL);
> -                return H_SUCCESS;
> -            }
> +        cs =3D CPU(ppc_get_vcpu_by_dt_id(target));
> +        if (cs) {
> +            run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NULL=
);
> +            return H_SUCCESS;
>          }
>          return H_PARAMETER;
>      }


--Sig_/Bt6lwlxxblybH1v2T4U=nXw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmDGPsACgkQAvw66wEB28JTigCeIWVE2OCFDksNVHhi6n9/+kk5
wAMAoJzPn6rfl94FOmR4Rq2JyJP63jyM
=88Z+
-----END PGP SIGNATURE-----

--Sig_/Bt6lwlxxblybH1v2T4U=nXw--
