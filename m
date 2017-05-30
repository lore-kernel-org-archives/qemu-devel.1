Received: from eggs.gnu.org ([2001:4830:134:3::10]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFkCJ-0007s5-Li
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:40:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFkCF-0004KN-6m
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:40:43 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:56373)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFkCE-0004I4-GH
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:40:39 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7038C1001FF
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 18:40:30 +0200 (CEST)
Date: Tue, 30 May 2017 18:40:22 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530184022.4d17218a@bahia.ttt.fr.ibm.com>
In-Reply-To: <1496161442-96665-7-git-send-email-imammedo@redhat.com>
References: <1496161442-96665-1-git-send-email-imammedo@redhat.com>
	<1496161442-96665-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/TwaYBt3u1oFZ_zhMq79sY_d";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 6/7] spapr: cleanup
 spapr_fixup_cpu_numa_dt() usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/TwaYBt3u1oFZ_zhMq79sY_d
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 18:24:01 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> even though spapr_fixup_cpu_numa_dt() has no effect on FDT
> if numa is disabled, don't call it uselessly. It makes it
> obvious at call sites that function is need only when numa

s/need/needed

> is enabled.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 34bb03d..96a2a74 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -178,10 +178,8 @@ static int spapr_fixup_cpu_smt_dt(void *fdt, int off=
set, PowerPCCPU *cpu,
>      return ret;
>  }
> =20
> -static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, CPUState *cs)
> +static int spapr_fixup_cpu_numa_dt(void *fdt, int offset, PowerPCCPU *cp=
u)
>  {
> -    int ret =3D 0;
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      int index =3D ppc_get_vcpu_dt_id(cpu);
>      uint32_t associativity[] =3D {cpu_to_be32(0x5),
>                                  cpu_to_be32(0x0),
> @@ -191,12 +189,8 @@ static int spapr_fixup_cpu_numa_dt(void *fdt, int of=
fset, CPUState *cs)
>                                  cpu_to_be32(index)};
> =20
>      /* Advertise NUMA via ibm,associativity */
> -    if (nb_numa_nodes > 1) {
> -        ret =3D fdt_setprop(fdt, offset, "ibm,associativity", associativ=
ity,
> +    return fdt_setprop(fdt, offset, "ibm,associativity", associativity,
>                            sizeof(associativity));
> -    }
> -
> -    return ret;
>  }
> =20
>  /* Populate the "ibm,pa-features" property */
> @@ -321,9 +315,11 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachin=
eState *spapr)
>              return ret;
>          }
> =20
> -        ret =3D spapr_fixup_cpu_numa_dt(fdt, offset, cs);
> -        if (ret < 0) {
> -            return ret;
> +        if (nb_numa_nodes > 1) {
> +            ret =3D spapr_fixup_cpu_numa_dt(fdt, offset, cpu);
> +            if (ret < 0) {
> +                return ret;
> +            }
>          }
> =20
>          ret =3D spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt);
> @@ -538,7 +534,9 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>      _FDT((fdt_setprop(fdt, offset, "ibm,pft-size",
>                        pft_size_prop, sizeof(pft_size_prop))));
> =20
> -    _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cs));
> +    if (nb_numa_nodes > 1) {
> +        _FDT(spapr_fixup_cpu_numa_dt(fdt, offset, cpu));
> +    }
> =20
>      _FDT(spapr_fixup_cpu_smt_dt(fdt, offset, cpu, compat_smt));
> =20


--Sig_/TwaYBt3u1oFZ_zhMq79sY_d
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktoHYACgkQAvw66wEB28JlrwCfU4yPte3Enl81bZ9orbUKLwZh
HfwAmgMTv6N9i+uKzPiHku7PIljsbqhU
=apUd
-----END PGP SIGNATURE-----

--Sig_/TwaYBt3u1oFZ_zhMq79sY_d--
