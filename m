Received: from eggs.gnu.org ([2001:4830:134:3::10]:51495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT142-0004gS-9l
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fT13y-0006hv-8s
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:34 -0400
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:38488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fT13y-0006gg-2X
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:30 -0400
Received: from player788.ha.ovh.net (unknown [10.109.108.125])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 42C29CD832
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 10:23:27 +0200 (CEST)
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
	<20180613065707.30766-6-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e872d169-10dd-55aa-a0bc-5973263925f5@kaod.org>
Date: Wed, 13 Jun 2018 10:23:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180613065707.30766-6-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/7] pnv: Add cpu unrealize path
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
> Currently we don't have any unrealize path for pnv cpu cores.  We get a=
way
> with this because we don't yet support cpu hotplug for pnv.
>=20
> However, we're going to want it eventually, and in the meantime, it mak=
es
> it non-obvious why there are a bunch of allocations on the realize() pa=
th
> that don't have matching frees.
>=20
> So, implement the missing unrealize path.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  hw/ppc/pnv_core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index c9648fd1ad..c70dbbe056 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -192,6 +192,26 @@ err:
>      error_propagate(errp, local_err);
>  }
> =20
> +static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
> +{
> +    qemu_unregister_reset(pnv_cpu_reset, cpu);
> +    object_unparent(cpu->intc);
> +    cpu_remove_sync(CPU(cpu));
> +    object_unparent(OBJECT(cpu));
> +}
> +
> +static void pnv_core_unrealize(DeviceState *dev, Error **errp)
> +{
> +    PnvCore *pc =3D PNV_CORE(dev);
> +    CPUCore *cc =3D CPU_CORE(dev);
> +    int i;
> +
> +    for (i =3D 0; i < cc->nr_threads; i++) {
> +        pnv_unrealize_vcpu(pc->threads[i]);
> +    }
> +    g_free(pc->threads);
> +}
> +
>  static Property pnv_core_properties[] =3D {
>      DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
>      DEFINE_PROP_END_OF_LIST(),
> @@ -202,6 +222,7 @@ static void pnv_core_class_init(ObjectClass *oc, vo=
id *data)
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> =20
>      dc->realize =3D pnv_core_realize;
> +    dc->unrealize =3D pnv_core_unrealize;
>      dc->props =3D pnv_core_properties;
>  }
> =20
>=20
