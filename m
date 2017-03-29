Received: from eggs.gnu.org ([2001:4830:134:3::10]:60091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct3g4-0008Re-ET
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ct3g3-0004Cy-2w
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 22:49:40 -0400
Date: Wed, 29 Mar 2017 13:27:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170329022723.GO21068@umbus.fritz.box>
References: <1490189568-167621-1-git-send-email-imammedo@redhat.com>
	<1490189568-167621-23-git-send-email-imammedo@redhat.com>
	<20170328051602.GK21068@umbus.fritz.box>
	<20170328130911.78c2edc6@Igors-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="acOuGx3oQeOcSZJu"
Content-Disposition: inline
In-Reply-To: <20170328130911.78c2edc6@Igors-MacBook-Pro.local>
Subject: Re: [Qemu-devel] [PATCH for-2.10 22/23] numa: add '-numa cpu,
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org


--acOuGx3oQeOcSZJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 01:09:11PM +0200, Igor Mammedov wrote:
> On Tue, 28 Mar 2017 16:16:02 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Mar 22, 2017 at 02:32:47PM +0100, Igor Mammedov wrote:
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
> >=20
> > What's the rationale for adding a new CLI, rather than adding node-id
> > properties to the appropriate objects with -device, -global or -set as
> > appropriate?
>  '-global' applies to all cpus, while '-device,-set' applies to present
>  at boot time cpus only. So they do not work for the case of possible but
>  not present at boot time objects.

Ah!  Of course.

> For ACPI based targets, we need to have
>  numa mapping at boot time to build ACPI SRAT table.
>  I don't know if it's important for spapr/fdt,

Not in the same way.  For spapr the device tree fragment for the new
cpu is supplied to the guest at hotplug time rather than having to be
in the initial device tree.  So for us, node could be supplied with
device_add.

> but it uses current predefined
>  mapping with -numa node,cpus=3Dx-y and new CLI hides from user internal
>  cpu_index and allows to use the same properties as we use for -device cp=
u,...
>  to define mapping to numa nodes for present/possible cpus.
>=20
> >=20
> > > ---
> > >  numa.c           | 13 +++++++++++++
> > >  qapi-schema.json |  7 +++++--
> > >  qemu-options.hx  | 23 ++++++++++++++++++++++-
> > >  3 files changed, 40 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/numa.c b/numa.c
> > > index 088fae3..588586b 100644
> > > --- a/numa.c
> > > +++ b/numa.c
> > > @@ -246,6 +246,19 @@ static int parse_numa(void *opaque, QemuOpts *op=
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
> > > +        machine_set_cpu_numa_node(ms, &object->u.cpu, &err);
> > > +        break;
> > >      default:
> > >          abort();
> > >      }
> > > diff --git a/qapi-schema.json b/qapi-schema.json
> > > index a6b5955..a9a1d5e 100644
> > > --- a/qapi-schema.json
> > > +++ b/qapi-schema.json
> > > @@ -5673,10 +5673,12 @@
> > >  ##
> > >  # @NumaOptionsType:
> > >  #
> > > +# @cpu: property based CPU(s) to node mapping (Since: 2.10)
> > > +#
> > >  # Since: 2.1
> > >  ##
> > >  { 'enum': 'NumaOptionsType',
> > > -  'data': [ 'node' ] }
> > > +  'data': [ 'node', 'cpu' ] }
> > > =20
> > >  ##
> > >  # @NumaOptions:
> > > @@ -5689,7 +5691,8 @@
> > >    'base': { 'type': 'NumaOptionsType' },
> > >    'discriminator': 'type',
> > >    'data': {
> > > -    'node': 'NumaNodeOptions' }}
> > > +    'node': 'NumaNodeOptions',
> > > +    'cpu': 'CpuInstanceProperties' }}
> > > =20
> > >  ##
> > >  # @NumaNodeOptions:
> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index 99af8ed..2185c34 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -139,13 +139,16 @@ ETEXI
> > > =20
> > >  DEF("numa", HAS_ARG, QEMU_OPTION_numa,
> > >      "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dn=
ode]\n"
> > > -    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3D=
node]\n", QEMU_ARCH_ALL)
> > > +    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3D=
node]\n"
> > > +    "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-=
id=3Dz]\n", QEMU_ARCH_ALL)
> > >  STEXI
> > >  @item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{las=
tcpu}]][,nodeid=3D@var{node}]
> > >  @itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{l=
astcpu}]][,nodeid=3D@var{node}]
> > > +@itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=
=3D@var{y}][,thread-id=3D@var{z}]
> > >  @findex -numa
> > >  Define a NUMA node and assign RAM and VCPUs to it.
> > > =20
> > > +Legacy VCPU assignment uses @samp{cpus} option where
> > >  @var{firstcpu} and @var{lastcpu} are CPU indexes. Each
> > >  @samp{cpus} option represent a contiguous range of CPU indexes
> > >  (or a single VCPU if @var{lastcpu} is omitted). A non-contiguous
> > > @@ -159,6 +162,24 @@ a NUMA node:
> > >  -numa node,cpus=3D0-2,cpus=3D5
> > >  @end example
> > > =20
> > > +@samp{cpu} option is new alternative to @samp{cpus} option
> > > +uses @samp{socket-id|core-id|thread-id} properties to assign
> > > +CPU objects to a @var{node} using topology layout properties of CPU.
> > > +Set of properties is machine specific, and depends on used machine
> > > +type/@samp{smp} options. It could be queried with @samp{hotpluggable=
-cpus}
> > > +monitor command.
> > > +@samp{node-id} property specifies @var{node} to which CPU object
> > > +will be assigned, it's required for @var{node} to be declared
> > > +with @samp{node} option before it's used with @samp{cpu} option.
> > > +
> > > +For example:
> > > +@example
> > > +-M pc \
> > > +-smp 1,sockets=3D2,maxcpus=3D2 \
> > > +-numa node,nodeid=3D0 -numa node,nodeid=3D1 \
> > > +-numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=
=3D1
> > > +@end example
> > > +
> > >  @samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> > >  assigns RAM from a given memory backend device to a node. If
> > >  @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--acOuGx3oQeOcSZJu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2xuLAAoJEGw4ysog2bOSe0sP/0rWYxT7Gem+xHYwEg7vEkdc
cT5Ok6JuMqmmPvimR0uLTyIIh7L+ErsX5EVWBphZzZzcGMYcD6qZhqUdVneuwlqM
H7o0Vv0CjXGc9ry0ijBnCpyRakD3d8x1w03eJ+9EiF8fXFEAM4O2eA2L8iDZPChX
q5gBklt53+pFXXkeDb2LVViGWm94OWJ/qtfSe84j5bzylUW07tgLmou6ED3Fmkpq
DvQ/zpMv62ZkrdIgJNbvp1ahsIHK6Gw/8I8FeuX27CO6nyDRrVRdIjxG8nCeSkvc
X3nf3kaCdasny1Di3ka9E/T5vvpIHIkihUhK11bOD3X5lYI/XZsG25otxb0fdwhs
NAZ5VfAMR40ULJdSUr4FEVZ+u+v8IfhSmLuu8jQcIh/xkFCrkbyi0hjNRyNivuSP
w/0COYPqAGkHymVD90EKohLzcIXkCJGqxvfS26t5IX0Zphvv8Nf6JJLDN+JD5u/f
4VQKvjroPW1xlLIn1DUvYUh1MLDk+ovnUhuU6M8ByAeTNHPSKsVdWsTMQikIfJ/P
W2cNfNpapw1vZE6sg5OW8eEVHwl4JxLqbCKzbyj1VHO/1tNDysTDDvyodzDChNsN
ouX0cnXhHzbaGy5dSPuyIv96Y0sP0YxmJvN7q87lfqcKH75GCdeq30W1KhiwASPW
ZvkOftXXzoCm4kbNz6o/
=0doi
-----END PGP SIGNATURE-----

--acOuGx3oQeOcSZJu--
