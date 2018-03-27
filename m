Received: from eggs.gnu.org ([2001:4830:134:3::10]:50363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kAk-0002eV-8e
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f0kAf-0001Aj-49
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:41:38 -0400
Received: from 6.mo68.mail-out.ovh.net ([46.105.63.100]:44173)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f0kAe-00016d-SP
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 04:41:33 -0400
Received: from player762.ha.ovh.net (unknown [10.109.105.151])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 25C4BD767E
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 10:41:23 +0200 (CEST)
References: <20180327043741.7705-1-david@gibson.dropbear.id.au>
	<20180327043741.7705-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e275a984-23ff-03de-d29a-cda2a2b0f4e0@kaod.org>
Date: Tue, 27 Mar 2018 10:41:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180327043741.7705-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC for-2.13 03/12] target/ppc: Pass cpu instead
 of env to ppc_create_page_sizes_prop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, groug@kaod.org
Cc: agraf@suse.de, qemu-devel@nongnu.org, benh@kernel.crashing.org, bharata@linux.vnet.ibm.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 03/27/2018 06:37 AM, David Gibson wrote:
> As a rule we prefer to pass PowerPCCPU instead of CPUPPCState, and this
> change will make some things simpler later on.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/fdt.c         | 5 +++--
>  hw/ppc/pnv.c         | 4 ++--
>  hw/ppc/spapr.c       | 4 ++--
>  include/hw/ppc/fdt.h | 2 +-
>  4 files changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/fdt.c b/hw/ppc/fdt.c
> index 2ffc5866e4..2721603ffa 100644
> --- a/hw/ppc/fdt.c
> +++ b/hw/ppc/fdt.c
> @@ -13,9 +13,10 @@
>  #include "hw/ppc/fdt.h"
> =20
>  #if defined(TARGET_PPC64)
> -size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
> -                                     size_t maxsize)
> +size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
> +                                  size_t maxsize)
>  {
> +    CPUPPCState *env =3D &cpu->env;
>      size_t maxcells =3D maxsize / sizeof(uint32_t);
>      int i, j, count;
>      uint32_t *p =3D prop;
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 98ee3c607a..5a79b24828 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -209,8 +209,8 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc,=
 void *fdt)
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
> =20
> -    page_sizes_prop_size =3D ppc_create_page_sizes_prop(env, page_size=
s_prop,
> -                                                  sizeof(page_sizes_pr=
op));
> +    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_size=
s_prop,
> +                                                      sizeof(page_size=
s_prop));
>      if (page_sizes_prop_size) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
>                             page_sizes_prop, page_sizes_prop_size)));
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 2c0be8c898..a35bffd524 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -581,8 +581,8 @@ static void spapr_populate_cpu_dt(CPUState *cs, voi=
d *fdt, int offset,
>          _FDT((fdt_setprop_cell(fdt, offset, "ibm,dfp", 1)));
>      }
> =20
> -    page_sizes_prop_size =3D ppc_create_page_sizes_prop(env, page_size=
s_prop,
> -                                                  sizeof(page_sizes_pr=
op));
> +    page_sizes_prop_size =3D ppc_create_page_sizes_prop(cpu, page_size=
s_prop,
> +                                                      sizeof(page_size=
s_prop));
>      if (page_sizes_prop_size) {
>          _FDT((fdt_setprop(fdt, offset, "ibm,segment-page-sizes",
>                            page_sizes_prop, page_sizes_prop_size)));
> diff --git a/include/hw/ppc/fdt.h b/include/hw/ppc/fdt.h
> index bd5b0a8c3d..a8cd85069f 100644
> --- a/include/hw/ppc/fdt.h
> +++ b/include/hw/ppc/fdt.h
> @@ -23,7 +23,7 @@
>          }                                                          \
>      } while (0)
> =20
> -size_t ppc_create_page_sizes_prop(CPUPPCState *env, uint32_t *prop,
> +size_t ppc_create_page_sizes_prop(PowerPCCPU *cpu, uint32_t *prop,
>                                    size_t maxsize);
> =20
>  #endif /* PPC_FDT_H */
>=20
