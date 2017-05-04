Received: from eggs.gnu.org ([2001:4830:134:3::10]:58874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6K7u-0006K1-94
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d6K7s-0001Fh-SW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:01:14 -0400
Date: Fri, 5 May 2017 02:49:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170504164952.GH14413@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-7-git-send-email-imammedo@redhat.com>
	<20170503144644.GM3482@thinpad.lan.raisama.net>
	<20170503181217.1757e128@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline
In-Reply-To: <20170503181217.1757e128@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/24] spapr: add node-id property to
 sPAPR core
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2017 at 06:12:17PM +0200, Igor Mammedov wrote:
> On Wed, 3 May 2017 11:46:44 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Wed, May 03, 2017 at 02:57:00PM +0200, Igor Mammedov wrote:
> > > it will allow switching from cpu_index to core based numa
> > > mapping in follow up patches.
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au> =20
> >=20
> > Have you considered adding this to TYPE_CPU instead of
> > duplicating the same code on multiple architectures/boards?
> it was in TYPE_CPU at RFC time, but it adds public node-id
> property to every CPU.
> So I've rewrote it they way it would affect only necessary CPUs,
>=20
> it might be possible to generalize node_id sanity checks at
> pre_plug time into a common wrapper, I can do it on top so
> it would be visible what it's generalized (or an extra patch on
> respin)

Note that the spapr cpu core type here is *not* a descendent of
TYPE_CPU (the threads under it are).

>=20
> >=20
> > > ---
> > >  include/hw/ppc/spapr_cpu_core.h |  1 +
> > >  include/qom/cpu.h               |  2 ++
> > >  hw/ppc/spapr.c                  | 17 +++++++++++++++++
> > >  hw/ppc/spapr_cpu_core.c         | 11 ++++++++---
> > >  4 files changed, 28 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/include/hw/ppc/spapr_cpu_core.h b/include/hw/ppc/spapr_c=
pu_core.h
> > > index 3c35665..93051e9 100644
> > > --- a/include/hw/ppc/spapr_cpu_core.h
> > > +++ b/include/hw/ppc/spapr_cpu_core.h
> > > @@ -27,6 +27,7 @@ typedef struct sPAPRCPUCore {
> > > =20
> > >      /*< public >*/
> > >      void *threads;
> > > +    int node_id;
> > >  } sPAPRCPUCore;
> > > =20
> > >  typedef struct sPAPRCPUCoreClass {
> > > diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> > > index 5d10359..55214ce 100644
> > > --- a/include/qom/cpu.h
> > > +++ b/include/qom/cpu.h
> > > @@ -258,6 +258,8 @@ typedef void (*run_on_cpu_func)(CPUState *cpu, ru=
n_on_cpu_data data);
> > > =20
> > >  struct qemu_work_item;
> > > =20
> > > +#define CPU_UNSET_NUMA_NODE_ID -1
> > > +
> > >  /**
> > >   * CPUState:
> > >   * @cpu_index: CPU index (informative).
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 33405a0..7f58ee4 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2824,9 +2824,11 @@ static void spapr_core_pre_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> > >      MachineClass *mc =3D MACHINE_GET_CLASS(hotplug_dev);
> > >      Error *local_err =3D NULL;
> > >      CPUCore *cc =3D CPU_CORE(dev);
> > > +    sPAPRCPUCore *sc =3D SPAPR_CPU_CORE(dev);
> > >      char *base_core_type =3D spapr_get_cpu_core_type(machine->cpu_mo=
del);
> > >      const char *type =3D object_get_typename(OBJECT(dev));
> > >      CPUArchId *core_slot;
> > > +    int node_id;
> > >      int index;
> > > =20
> > >      if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
> > > @@ -2861,6 +2863,21 @@ static void spapr_core_pre_plug(HotplugHandler=
 *hotplug_dev, DeviceState *dev,
> > >          goto out;
> > >      }
> > > =20
> > > +    node_id =3D numa_get_node_for_cpu(cc->core_id);
> > > +    if (node_id =3D=3D nb_numa_nodes) {
> > > +        /* by default CPUState::numa_node was 0 if it's not set via =
CLI
> > > +         * keep it this way for now but in future we probably should
> > > +         * refuse to start up with incomplete numa mapping */
> > > +        node_id =3D 0;
> > > +    }
> > > +    if (sc->node_id =3D=3D CPU_UNSET_NUMA_NODE_ID) {
> > > +        sc->node_id =3D node_id;
> > > +    } else if (sc->node_id !=3D node_id) {
> > > +        error_setg(&local_err, "node-id %d must match numa node spec=
ified"
> > > +            "with -numa option for cpu-index %d", sc->node_id, cc->c=
ore_id);
> > > +        goto out;
> > > +    }
> > > +
> > >  out:
> > >      g_free(base_core_type);
> > >      error_propagate(errp, local_err);
> > > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > > index 4389ef4..9de7a56 100644
> > > --- a/hw/ppc/spapr_cpu_core.c
> > > +++ b/hw/ppc/spapr_cpu_core.c
> > > @@ -176,7 +176,6 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> > >      const char *typename =3D object_class_get_name(scc->cpu_class);
> > >      size_t size =3D object_type_get_instance_size(typename);
> > >      Error *local_err =3D NULL;
> > > -    int core_node_id =3D numa_get_node_for_cpu(cc->core_id);;
> > >      void *obj;
> > >      int i, j;
> > > =20
> > > @@ -194,10 +193,10 @@ static void spapr_cpu_core_realize(DeviceState =
*dev, Error **errp)
> > > =20
> > >          /* Set NUMA node for the added CPUs  */
> > >          node_id =3D numa_get_node_for_cpu(cs->cpu_index);
> > > -        if (node_id !=3D core_node_id) {
> > > +        if (node_id !=3D sc->node_id) {
> > >              error_setg(&local_err, "Invalid node-id=3D%d of thread[c=
pu-index: %d]"
> > >                  " on CPU[core-id: %d, node-id: %d], node-id must be =
the same",
> > > -                 node_id, cs->cpu_index, cc->core_id, core_node_id);
> > > +                 node_id, cs->cpu_index, cc->core_id, sc->node_id);
> > >              goto err;
> > >          }
> > >          if (node_id < nb_numa_nodes) {
> > > @@ -263,6 +262,11 @@ static const char *spapr_core_models[] =3D {
> > >      "POWER9_v1.0",
> > >  };
> > > =20
> > > +static Property spapr_cpu_core_properties[] =3D {
> > > +    DEFINE_PROP_INT32("node-id", sPAPRCPUCore, node_id, CPU_UNSET_NU=
MA_NODE_ID),
> > > +    DEFINE_PROP_END_OF_LIST()
> > > +};
> > > +
> > >  void spapr_cpu_core_class_init(ObjectClass *oc, void *data)
> > >  {
> > >      DeviceClass *dc =3D DEVICE_CLASS(oc);
> > > @@ -270,6 +274,7 @@ void spapr_cpu_core_class_init(ObjectClass *oc, v=
oid *data)
> > > =20
> > >      dc->realize =3D spapr_cpu_core_realize;
> > >      dc->unrealize =3D spapr_cpu_core_unrealizefn;
> > > +    dc->props =3D spapr_cpu_core_properties;
> > >      scc->cpu_class =3D cpu_class_by_name(TYPE_POWERPC_CPU, data);
> > >      g_assert(scc->cpu_class);
> > >  }
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZC1utAAoJEGw4ysog2bOSBNkP/3AAnAk2Sm178UDji1kdUcuC
y6eCM9GiWrjhkMa4TA1MT+DSAtn203Mxmq+eKtVVayyRUfiJs1DEZp9tnuJL0sQU
3DzbFx0vL7M89GUHmNEss7QIGIUntE73fLIfnhkm/RWT6q2vwR/sjI9+xQC0vKkE
QlPbeB1YxiRT//yg8JUFYjOW20pwJJjyImB5tJtKI8zaaoQnsQIdPVdCFhUWLnwL
Shio+fCpJB1L/zIheNTjFvcJA0UbJZ14j16ZTUwALcVOBbE0YuoxdUup4BLVZLIf
lD1CXy8Vy+PVyyQS+kPKJjKE8B8/zlwwwhW2eG0e1aqmE+VpL7pqHN7+uBOC8mU6
IZZqauZY7NzYy7aWg8woH1aGLvS+TB7954G2832h1QMnC06gqIxILJP7wAJHCzJs
+p9vTi+EjkhSqECfupmmSHGH71uBr5Pn6DyN01rcZq6lrFBeMzluUrIe4hdlgU14
ESWton628Gqn3qg4yLSBPH21uXP9ZOGUoBSWxzf79Uc+0u5dzB3kY+7XZHOl0CJO
FZqEP7JBhYJ7ZR2I34VwTENIDEBvFwB0Lx6yzNpuA5tStt0JETbg3GHHgGBa24sL
oL39hbRBYSyLdUpxa1Epj06T0YcMOv6hPHwfZEJFeJCJXKyL3wWmnFGYdtWYo9uA
nnnbRYE4ZNsOuqSVIoZS
=LiJy
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--
