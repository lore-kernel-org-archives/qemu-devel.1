Received: from eggs.gnu.org ([2001:4830:134:3::10]:50401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0yV-0000qB-Tp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:17:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT0yQ-0002Un-Mb
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:17:51 -0400
Received: from 6.mo173.mail-out.ovh.net ([46.105.43.93]:52287)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT0yQ-0002Tv-Fh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:17:46 -0400
Received: from player770.ha.ovh.net (unknown [10.109.122.124])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 321EAC5787
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:17:45 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-4-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <90ea65cd-f5f9-a169-ef71-40dd1186ef36@kaod.org>
Date: Wed, 13 Jun 2018 10:17:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180613065707.30766-4-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/7] pnv_core: Allocate cpu thread objects
 individually
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 06/13/2018 08:57 AM, David Gibson wrote:
> Currently, we allocate space for all the cpu objects within a single co=
re
> in one big block.  This was copied from an older version of the spapr c=
ode
> and requires some ugly pointer manipulation to extract the individual
> objects.
>=20
> This design was due to a misunderstanding of qemu lifetime conventions =
and
> has already been changed in spapr (in 94ad93bd "spapr_cpu_core: instant=
iate
> CPUs separately".
>=20
> Make an equivalent change in pnv_core to get rid of the nasty pointer
> arithmetic.
>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Ah nice cleanup :)

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c              |  4 ++--
>  hw/ppc/pnv_core.c         | 11 +++++------
>  include/hw/ppc/pnv_core.h |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 0314881316..0b9508d94d 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -121,9 +121,9 @@ static int get_cpus_node(void *fdt)
>   */
>  static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
>  {
> -    CPUState *cs =3D CPU(DEVICE(pc->threads));
> +    PowerPCCPU *cpu =3D pc->threads[0];
> +    CPUState *cs =3D CPU(cpu);
>      DeviceClass *dc =3D DEVICE_GET_CLASS(cs);
> -    PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>      int smt_threads =3D CPU_CORE(pc)->nr_threads;
>      CPUPPCState *env =3D &cpu->env;
>      PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index efb68226bb..59309e149c 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -151,7 +151,6 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      PnvCore *pc =3D PNV_CORE(OBJECT(dev));
>      CPUCore *cc =3D CPU_CORE(OBJECT(dev));
>      const char *typename =3D pnv_core_cpu_typename(pc);
> -    size_t size =3D object_type_get_instance_size(typename);
>      Error *local_err =3D NULL;
>      void *obj;
>      int i, j;
> @@ -165,11 +164,11 @@ static void pnv_core_realize(DeviceState *dev, Er=
ror **errp)
>          return;
>      }
> =20
> -    pc->threads =3D g_malloc0(size * cc->nr_threads);
> +    pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
>      for (i =3D 0; i < cc->nr_threads; i++) {
> -        obj =3D pc->threads + i * size;
> +        obj =3D object_new(typename);
> =20
> -        object_initialize(obj, size, typename);
> +        pc->threads[i] =3D POWERPC_CPU(obj);
> =20
>          snprintf(name, sizeof(name), "thread[%d]", i);
>          object_property_add_child(OBJECT(pc), name, obj, &local_err);
> @@ -185,7 +184,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
>      }
> =20
>      for (j =3D 0; j < cc->nr_threads; j++) {
> -        obj =3D pc->threads + j * size;
> +        obj =3D OBJECT(pc->threads[j]);
> =20
>          pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
>          if (local_err) {
> @@ -200,7 +199,7 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
> =20
>  err:
>      while (--i >=3D 0) {
> -        obj =3D pc->threads + i * size;
> +        obj =3D OBJECT(pc->threads[i]);
>          object_unparent(obj);
>      }
>      g_free(pc->threads);
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index e337af7a3a..447ae761f7 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -34,7 +34,7 @@ typedef struct PnvCore {
>      CPUCore parent_obj;
> =20
>      /*< public >*/
> -    void *threads;
> +    PowerPCCPU **threads;
>      uint32_t pir;
> =20
>      MemoryRegion xscom_regs;
>=20
