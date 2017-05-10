Received: from eggs.gnu.org ([2001:4830:134:3::10]:55509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8HXr-0008F5-8e
	for qemu-devel@nongnu.org; Tue, 09 May 2017 22:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8HXp-0008MV-WA
	for qemu-devel@nongnu.org; Tue, 09 May 2017 22:40:07 -0400
Date: Wed, 10 May 2017 11:15:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510011526.GR25748@umbus.fritz.box>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-24-git-send-email-imammedo@redhat.com>
	<20170508054004.GE25748@umbus.fritz.box>
	<20170509175829.23fcc112@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="teKjxxMjPsACTz/N"
Content-Disposition: inline
In-Reply-To: <20170509175829.23fcc112@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 23/24] numa: add '-numa cpu,
 ...' option for property based node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>


--teKjxxMjPsACTz/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 05:58:29PM +0200, Igor Mammedov wrote:
> On Mon, 8 May 2017 15:40:04 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, May 03, 2017 at 02:57:17PM +0200, Igor Mammedov wrote:
> > > legacy cpu to node mapping is using cpu index values to map
> > > VCPU to node with help of '-numa node,nodeid=3Dnode,cpus=3Dx[-y]'
> > > option. However cpu index is internal concept and QEMU users
> > > have to guess /reimplement qemu's logic/ to map it to
> > > a concrete cpu socket/core/thread to make sane CPUs
> > > placement across numa nodes.
> > >=20
> > > This patch allows to map cpu objects to numa nodes using
> > > the same properties as used for cpus with -device/device_add
> > > (socket-id/core-id/thread-id/node-id).
> > >=20
> > > At present valid properties/values to address CPUs could be
> > > fetched using hotpluggable-cpus monitor/qmp command, it will
> > > require user to start qemu twice when creating domain to fetch
> > > possible CPUs for a machine type/-smp layout first and
> > > then the second time with numa explicit mapping for actual
> > > usage. The first step results could be saved and reused to
> > > set/change mapping later as far as machine type/-smp stays
> > > the same.
> > >=20
> > > Proposed impl. supports exact and wildcard matching to
> > > simplify CLI and allow to set mapping for a specific cpu
> > > or group of cpu objects specified by matched properties.
> > >=20
> > > For example:
> > >=20
> > >    # exact mapping x86
> > >    -numa cpu,node-id=3Dx,socket-id=3Dy,core-id=3Dz,thread-id=3Dn
> > >=20
> > >    # exact mapping SPAPR
> > >    -numa cpu,node-id=3Dx,core-id=3Dy
> > >=20
> > >    # wildcard mapping, all cpu objects that match socket-id=3Dy
> > >    # are mapped to node-id=3Dx
> > >    -numa cpu,node-id=3Dx,socket-id=3Dy
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > v2:
> > >   - use new NumaCpuOptions instead of CpuInstanceProperties in
> > >     NumaOptions, so that in future we could decouple both
> > >     if needed. (Eduardo Habkost <ehabkost@redhat.com>)
> > >   - clarify effect of NumaCpuOptions.node-id in qapi-schema.json
> > > ---
> > >  numa.c           | 25 +++++++++++++++++++++++++
> > >  qapi-schema.json | 21 +++++++++++++++++++--
> > >  qemu-options.hx  | 23 ++++++++++++++++++++++-
> > >  3 files changed, 66 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/numa.c b/numa.c
> > > index 40e9f44..61521f5 100644
> > > --- a/numa.c
> > > +++ b/numa.c
> > > @@ -227,6 +227,7 @@ static int parse_numa(void *opaque, QemuOpts *opt=
s, Error **errp)
> > >      NumaOptions *object =3D NULL;
> > >      MachineState *ms =3D opaque;
> > >      Error *err =3D NULL;
> > > +    CpuInstanceProperties cpu;
> > > =20
> > >      {
> > >          Visitor *v =3D opts_visitor_new(opts);
> > > @@ -246,6 +247,30 @@ static int parse_numa(void *opaque, QemuOpts *op=
ts, Error **errp)
> > >          }
> > >          nb_numa_nodes++;
> > >          break;
> > > +    case NUMA_OPTIONS_TYPE_CPU:
> > > +        if (!object->u.cpu.has_node_id) {
> > > +            error_setg(&err, "Missing mandatory node-id property");
> > > +            goto end;
> > > +        }
> > > +        if (!numa_info[object->u.cpu.node_id].present) {
> > > +            error_setg(&err, "Invalid node-id=3D%" PRId64 ", NUMA no=
de must be "
> > > +                "defined with -numa node,nodeid=3DID before it's use=
d with "
> > > +                "-numa cpu,node-id=3DID", object->u.cpu.node_id);
> > > +            goto end;
> > > +        }
> > > +
> > > +        memset(&cpu, 0, sizeof(cpu));
> > > +        cpu.has_node_id =3D object->u.cpu.has_node_id;
> > > +        cpu.node_id =3D object->u.cpu.node_id;
> > > +        cpu.has_socket_id =3D object->u.cpu.has_socket_id;
> > > +        cpu.socket_id =3D object->u.cpu.socket_id;
> > > +        cpu.has_core_id =3D object->u.cpu.has_core_id;
> > > +        cpu.core_id =3D object->u.cpu.core_id;
> > > +        cpu.has_thread_id =3D object->u.cpu.has_thread_id;
> > > +        cpu.thread_id =3D object->u.cpu.thread_id;
> > > +
> > > +        machine_set_cpu_numa_node(ms, &cpu, &err); =20
> >=20
> > It's possible I've confused myself by not looking at this whole series
> > at once.
> >=20
> > But, would it be possible to make a single machine hook which maps a
> > constructed cpu property set to a "canonical" cpu property set from
> > the table of CPU slots (or errors, of course).  That would let you do
> > what you need here, and I suspect in other places, without multiple
> > hooks.
> Not sure that get question.
>=20
> if it's about machine_set_cpu_numa_node() than it's a single generic
> setter of MachineState::possible_cpus(node-id) from non machine code
> and the only place it's supposed to be used is from numa configuration
> code. I don't see any need to reuse it for something/somewhere else
> so far.
>=20
> More over it's not 1:1 mapping wrt input:affected slots,
> it's 1:[1-n] where input could affect multiple slots.

Ah, good point.

> I think I've tried to get machine return a list of cpu slots
> and then deal with them in numa.c but result looked messy and
> not to my liking.
> Eventually I stopped on machine_set_cpu_numa_node() variant
> as the cleanest for now.

Ok, makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--teKjxxMjPsACTz/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEmmrAAoJEGw4ysog2bOSezQQAKjQBG5/QXs1IJ3n/AgpSiv/
ef1UKIcy4bWGJpaPdpDC6sJ1z3PrtjB3fkEmY8upJFLkjMDGnOVorS2vZnPDaimT
iCKJRrjYqB/0c9EGWWJIkrpIw4yqCypjvB6zk9pEl896jyzJH7gjtw4cKJM9XvyA
Rq4O193GV1qPKd2Oylv7vb+kmcEApAIelduFIZJ/fl+BydjDTyYx5tniADez/kGT
X37U9nq9AHRkww9WA10aAP2i4fu6wOAKS0nDBwruwXPMyXQymOp6/vQo4Rz9trHv
W/P1EVHSWrhsYwKX2ODnssZdSlC04Kfz7/SZ0Wd3QC67KBLi88vWOf+SKrzTmywg
b2IiYyKZQKw4NXfXypGoyjXAJkhHqaa9hXIWRoZabi5N/Ay+7b7+ISpxD4tS4Gqr
i7Pw6bTgCTSfNT7RcejwPFmvlSrr5sZpR3QbAHRCPWqJRRcKk40sVlZyK+L7vyQe
vLGFTXJIxrWibDwpWxpqWMfe4VMARzuSWjAKrcRBRc2zoVURCaagec9dZUci0AZr
SQX6vXVtWzPIWyK+Emjhit17Cn85G5fXIbMarO0L8JgOP5SrbKIL3vo6VIMy4TM8
qgjcd5EPX6+KTIRCqcU6kXySLe/yQBv8e7Vg0sHnKF5ofBJx/KUzMvGbH8bcLE43
Ad33qqQk423AX7bo/BtA
=/ILG
-----END PGP SIGNATURE-----

--teKjxxMjPsACTz/N--
