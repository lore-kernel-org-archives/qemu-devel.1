Received: from eggs.gnu.org ([2001:4830:134:3::10]:33747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dVFJ2-00071D-Nj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1dVFIz-0002z8-N5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 06:55:44 -0400
Message-ID: <1499856934.13989.38.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 12 Jul 2017 12:55:34 +0200
In-Reply-To: <20170704104722.499d4e86@bahia.lan>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, libvir-list@redhat.com

[libvir-list added to the loop]

On Tue, 2017-07-04 at 10:47 +0200, Greg Kurz wrote:
> On Tue, 4 Jul 2017 17:29:01 +1000 David Gibson <david@gibson.dropbear.i=
d.au> wrote:
> > On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
> > >=C2=A0
> > > The sPAPR machine always create a default PHB during initialization=
, even
> > > if -nodefaults was passed on the command line. This forces the user=
 to
> > > rely on -global if she wants to set properties of the default PHB, =
such
> > > as numa_node.
> > >=C2=A0
> > > This patch introduces a new machine create-default-phb property to =
control
> > > whether the default PHB must be created or not. It defaults to on i=
n order
> > > to preserve old setups (which is also the motivation to not alter t=
he
> > > current behavior of -nodefaults).
> > >=C2=A0
> > > If create-default-phb is set to off, the default PHB isn't created,=
 nor
> > > any other device usually created with it. It is mandatory to provid=
e
> > > a PHB on the command line to be able to use PCI devices (otherwise =
QEMU
> > > won't start). For example, the following creates a PHB with the sam=
e
> > > mappings as the default PHB and also sets the NUMA affinity:
> > >=C2=A0
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries,create-default=
-phb=3Doff \
> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,nodeid=3D0 -device spapr-pc=
i-host-bridge,index=3D0,numa_node=3D0
> >=C2=A0
> > So, I agree that the distinction between default devices that are
> > disabled with -nodefaults and default devices that aren't is a big
> > mess in qemu configuration.=C2=A0=C2=A0But on the other hand this onl=
y addresses
> > one tiny aspect of that, and in the meantime means we will silently
> > ignore some other configuration options in some conditions.
> >=C2=A0
> > So, what's the immediate benefit / use case for this?
>=C2=A0
> With the current code base, the only way to set properties of the defau=
lt
> PHB, is to pass -global spapr-pci-host-bridge.prop=3Dvalue for each pro=
perty.
> The immediate benefit of this patch is to unify the way libvirt passes
> PHB description to the command line:
>=C2=A0
> ie, do:
>=C2=A0
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries,create-default-phb=
=3Doff \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Da,pr=
op2=3Db,prop3=3Dc \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Dd,pr=
op2=3De,prop3=3Df
>=C2=A0
> instead of:
>=C2=A0
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop1=3Da \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop2=3Db \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop3=3Dc \
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Dd,pr=
op2=3De,prop3=3Df

So, I'm thinking about this mostly in terms of NUMA nodes
because that's the use case I'm aware of.

The problem with using -global is not that it requires using
a different syntax to set properties for the default PHB,
but rather that such properties are then inherited by all
other PHBs unless explicitly overridden. Not creating the
default PHB at all would solve the issue.

On the other hand, libvirt would then need to either

=C2=A0 1) only allow setting NUMA nodes for PHBs if QEMU supports
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the new option, leaving QEMU < 2.10 users b=
ehind; or

=C2=A0 2) implement handling for both the new and old behavior.

I'm not sure we could get away with 1), and going for 2)
means more work both for QEMU and libvirt developers for
very little actual gain, so I'd be inclined to scrap this
and just build the libvirt glue on top of the existing
interface.

That is, of course, unless

=C2=A0 1) having a random selection of PHBs not assigned to any
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NUMA node is a sensible use case. This is s=
omething
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0we just can't do reliably with the current =
interface:
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0we can decide to set the NUMA node only for=
 say, PHBs
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A01 and 3 leaving 0 and 2 alone, but once we =
set it for
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the default PHB we *have* to set it for all=
 remaining
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ones as well. libvirt will by default assig=
n emulated
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devices to the default PHB, so I would rath=
er expect
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0users to leave that one alone and set a NUM=
A node for
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0all other PHBs; or

=C2=A0 2) there are other properties outside of numa_node we
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0might want to deal with; or

=C2=A0 3) it turns out it's okay to require a recent QEMU :)

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
