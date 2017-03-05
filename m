Received: from eggs.gnu.org ([2001:4830:134:3::10]:55864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckhi0-00022C-Um
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ckhhx-0008PZ-Pl
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:45:08 -0500
Received: from ozlabs.org ([103.22.144.67]:46363)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1ckhhx-0008PN-44
	for qemu-devel@nongnu.org; Sun, 05 Mar 2017 20:45:05 -0500
Date: Mon, 6 Mar 2017 10:34:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170305233440.GC12030@umbus.fritz.box>
References: <1487928416-131310-1-git-send-email-imammedo@redhat.com>
	<20170303184104.59e9dd63@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline
In-Reply-To: <20170303184104.59e9dd63@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: ensure that all threads within core
 are on the same NUMA node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 06:41:04PM +0100, Igor Mammedov wrote:
> On Fri, 24 Feb 2017 10:26:56 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > Threads within a core shouldn't be on different
> > NUMA nodes, so if user has misconfgured command
> > line, fail QEMU at start up to force user fix it.
> >=20
> > For now use the first thread on the core as source
> > of core's node-id. Later when cpu-numa refactoring
> > lands  it will be switched to core's node-id from
> > possible_cpus[].
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ping,
>=20
> David could you review/merge maybe adding to commit
> message:
>=20
> "
> patch prevents the same issues as commit 20bb648d
> fixes, only instead of default mapping it adds
> check for manually configured NUMA node mapping
> "

Ok, merged.  I'll try to send that up today, just in time for the hard free=
ze.

>=20
> > ---
> > Enforcement is necessary to ensure that it would be
> > possible to map legacy CPU index based CLI mapping
> > to core based one and replace numa_info[XXX].node_cpu
> > with possible_cpus[] as storage for mapping info.
> >=20
> > CC: qemu-ppc@nongnu.org
> > CC: lvivier@redhat.com
> > CC: David Gibson <david@gibson.dropbear.id.au>
> > CC: thuth@redhat.com
> > CC: mdroth@linux.vnet.ibm.com
> > CC: agraf@suse.de
> > ---
> >  hw/ppc/spapr_cpu_core.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 55cd045..1499a8b 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -50,8 +50,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, =
PowerPCCPU *cpu,
> >                             Error **errp)
> >  {
> >      CPUPPCState *env =3D &cpu->env;
> > -    CPUState *cs =3D CPU(cpu);
> > -    int i;
> > =20
> >      /* Set time-base frequency to 512 MHz */
> >      cpu_ppc_tb_init(env, SPAPR_TIMEBASE_FREQ);
> > @@ -70,12 +68,6 @@ static void spapr_cpu_init(sPAPRMachineState *spapr,=
 PowerPCCPU *cpu,
> >          }
> >      }
> > =20
> > -    /* Set NUMA node for the added CPUs  */
> > -    i =3D numa_get_node_for_cpu(cs->cpu_index);
> > -    if (i < nb_numa_nodes) {
> > -            cs->numa_node =3D i;
> > -    }
> > -
> >      xics_cpu_setup(spapr->xics, cpu);
> > =20
> >      qemu_register_reset(spapr_cpu_reset, cpu);
> > @@ -159,11 +151,13 @@ static void spapr_cpu_core_realize(DeviceState *d=
ev, Error **errp)
> >      const char *typename =3D object_class_get_name(scc->cpu_class);
> >      size_t size =3D object_type_get_instance_size(typename);
> >      Error *local_err =3D NULL;
> > +    int core_node_id =3D numa_get_node_for_cpu(cc->core_id);;
> >      void *obj;
> >      int i, j;
> > =20
> >      sc->threads =3D g_malloc0(size * cc->nr_threads);
> >      for (i =3D 0; i < cc->nr_threads; i++) {
> > +        int node_id;
> >          char id[32];
> >          CPUState *cs;
> > =20
> > @@ -172,6 +166,19 @@ static void spapr_cpu_core_realize(DeviceState *de=
v, Error **errp)
> >          object_initialize(obj, size, typename);
> >          cs =3D CPU(obj);
> >          cs->cpu_index =3D cc->core_id + i;
> > +
> > +        /* Set NUMA node for the added CPUs  */
> > +        node_id =3D numa_get_node_for_cpu(cs->cpu_index);
> > +        if (node_id !=3D core_node_id) {
> > +            error_setg(&local_err, "Invalid node-id=3D%d of thread[cpu=
-index: %d]"
> > +                " on CPU[core-id: %d, node-id: %d], node-id must be th=
e same",
> > +                 node_id, cs->cpu_index, cc->core_id, core_node_id);
> > +            goto err;
> > +        }
> > +        if (node_id < nb_numa_nodes) {
> > +            cs->numa_node =3D node_id;
> > +        }
> > +
> >          snprintf(id, sizeof(id), "thread[%d]", i);
> >          object_property_add_child(OBJECT(sc), id, obj, &local_err);
> >          if (local_err) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYvKCOAAoJEGw4ysog2bOS8+cQALSs+mmYKjHMvGoK9fnBHOq4
LdVwIgzxn16aU/SmP3GLmQn2pMsGapTDCqFdzcgUursb4Rzg27jqfhQVj4ecB7Ry
Lhl11tsaAu3D/5ObLGN6vyqS9GvMcGgwPI14smPxxK2R5XsJCJt2mLIHhdVRmi6K
og6XOXW3uMXxHRPNM1KdGWX2l24LS5mTOg1p5JohdLZSIfTQB0VOn4/bOFeyjTBz
o1vx97E0lQitKWqOOV9PxOiCdRKhSuWTNiP0U3sHqkAxjzNcVYe3zqI9GrbZ7OJz
hothUYYgqBsG5vxaVC8jNY6O9kNUx0mLH6TzSfAB5NKtbVYNHk2rZvo7dpPOthqb
VaHxZ1ULpNsNCgU+kyQsca4AD5Wo9NPFZUW9TzT46Xkf7Xuw5kz6bCy8M+J2uwHi
ORO4lpjxBsTgFhtn72TQdiZXVKBIrUmjS1QJiAUSNbU8XBOTt0SvKlaUUvjjIdwN
NsN8+Og5xmgFwwD6YefQI6cxagcYmMRGW1S+FMN5yPTcgxMOSDQ1rs3kz2bRTCVJ
O1kAGE2A+qVgZtEDXSNP0Xylpal4P7dvEAjGEf0OJg1nW7mmOYoh/gwtvEXHnqbw
bRys9ol+WctVPpdS/pwEgvgDIL+P9qEEmj+0kyWJqiTi4Y4GryZW8rEnN5Bu0J8+
2pgTrqq8+kPp4xdQPxPH
=k6bR
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--
