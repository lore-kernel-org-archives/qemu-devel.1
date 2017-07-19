Received: from eggs.gnu.org ([2001:4830:134:3::10]:37882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXglC-0008HR-Uk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dXgl9-0002oP-Nh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 00:38:54 -0400
Date: Wed, 19 Jul 2017 14:38:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170719043820.GY3140@umbus.fritz.box>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
	<1499856934.13989.38.camel@redhat.com>
	<68cfb52b-d4cc-1980-e6f5-a454baf4e2e5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ELMKpCVvjiB+uwRu"
Content-Disposition: inline
In-Reply-To: <68cfb52b-d4cc-1980-e6f5-a454baf4e2e5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, libvir-list@redhat.com


--ELMKpCVvjiB+uwRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 05:09:37PM +0530, Shivaprasad G Bhat wrote:
>=20
>=20
> On 07/12/2017 04:25 PM, Andrea Bolognani wrote:
> > [libvir-list added to the loop]
> >=20
> > On Tue, 2017-07-04 at 10:47 +0200, Greg Kurz wrote:
> > > On Tue, 4 Jul 2017 17:29:01 +1000 David Gibson <david@gibson.dropbear=
=2Eid.au> wrote:
> > > > On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote:
> > > > > The sPAPR machine always create a default PHB during initializati=
on, even
> > > > > if -nodefaults was passed on the command line. This forces the us=
er to
> > > > > rely on -global if she wants to set properties of the default PHB=
, such
> > > > > as numa_node.
> > > > > This patch introduces a new machine create-default-phb property t=
o control
> > > > > whether the default PHB must be created or not. It defaults to on=
 in order
> > > > > to preserve old setups (which is also the motivation to not alter=
 the
> > > > > current behavior of -nodefaults).
> > > > > If create-default-phb is set to off, the default PHB isn't create=
d, nor
> > > > > any other device usually created with it. It is mandatory to prov=
ide
> > > > > a PHB on the command line to be able to use PCI devices (otherwis=
e QEMU
> > > > > won't start). For example, the following creates a PHB with the s=
ame
> > > > > mappings as the default PHB and also sets the NUMA affinity:
> > > > >       -machine type=3Dpseries,create-default-phb=3Doff \
> > > > >       -numa node,nodeid=3D0 -device spapr-pci-host-bridge,index=
=3D0,numa_node=3D0
> > > > So, I agree that the distinction between default devices that are
> > > > disabled with -nodefaults and default devices that aren't is a big
> > > > mess in qemu configuration.  But on the other hand this only addres=
ses
> > > > one tiny aspect of that, and in the meantime means we will silently
> > > > ignore some other configuration options in some conditions.
> > > > So, what's the immediate benefit / use case for this?
>=20
> Setting numa_node for emulated devices is the benefit for now. On x86, I
> figured there is
> no way to set the numa_node for the root controller and the emulated devi=
ces
> sitting there
> all have numa_node set to -1. Only the devices on the pxb can have a
> sensible value specified.

Given that we have the equivalent restriction on x86, I'm not seeing
removing it on Power as a priority.

> Does it mean, the emulated devices/drivers don't care about the numa_node
> they are on?

Probably not.  If nothing else, I expect the slowdown of bad NUMA
affinity is probably not significant compared to the general slowness
of an emulated device. Since the device is also in software, the
standard NUMA stuff on the host may already migrate the relevant
things to match the (host) NUMA node where the guest code is running,
so it may be strictly irrelevant in that sense as well.

> Would it be fine on PPC to disallow setting the NUMA node for the default
> PHB because that is where
> all the emulated devices sit ?
>=20
> > > With the current code base, the only way to set properties of the def=
ault
> > > PHB, is to pass -global spapr-pci-host-bridge.prop=3Dvalue for each p=
roperty.
> > > The immediate benefit of this patch is to unify the way libvirt passes
> > > PHB description to the command line:
> > > ie, do:
> > >       -machine type=3Dpseries,create-default-phb=3Doff \
> > >       -device spapr-pci-host-bridge,prop1=3Da,prop2=3Db,prop3=3Dc \
> > >       -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df
> > > instead of:
> > >       -machine type=3Dpseries \
> > >       -global spapr-pci-host-bridge.prop1=3Da \
> > >       -global spapr-pci-host-bridge.prop2=3Db \
> > >       -global spapr-pci-host-bridge.prop3=3Dc \
> > >       -device spapr-pci-host-bridge,prop1=3Dd,prop2=3De,prop3=3Df
> > So, I'm thinking about this mostly in terms of NUMA nodes
> > because that's the use case I'm aware of.
> >=20
> > The problem with using -global is not that it requires using
> > a different syntax to set properties for the default PHB,
> > but rather that such properties are then inherited by all
> > other PHBs unless explicitly overridden. Not creating the
> > default PHB at all would solve the issue.
> >=20
> > On the other hand, libvirt would then need to either
> >=20
> >    1) only allow setting NUMA nodes for PHBs if QEMU supports
> >       the new option, leaving QEMU < 2.10 users behind; or
> >=20
> >    2) implement handling for both the new and old behavior.
> >=20
> > I'm not sure we could get away with 1), and going for 2)
> > means more work both for QEMU and libvirt developers for
> > very little actual gain, so I'd be inclined to scrap this
> > and just build the libvirt glue on top of the existing
> > interface.
> >=20
> > That is, of course, unless
> >=20
> >    1) having a random selection of PHBs not assigned to any
> >       NUMA node is a sensible use case. This is something
> >       we just can't do reliably with the current interface:
> >       we can decide to set the NUMA node only for say, PHBs
> >       1 and 3 leaving 0 and 2 alone, but once we set it for
> >       the default PHB we *have* to set it for all remaining
> >       ones as well. libvirt will by default assign emulated
> >       devices to the default PHB, so I would rather expect
> >       users to leave that one alone and set a NUMA node for
> >       all other PHBs; or
> >=20
> >    2) there are other properties outside of numa_node we
> >       might want to deal with; or
> >=20
> >    3) it turns out it's okay to require a recent QEMU :)
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ELMKpCVvjiB+uwRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllu4jwACgkQbDjKyiDZ
s5KvlhAAv1KqFHDL6Bv8kLMtx3MQ6GlSYiyeKH8q7k6jFxRkDcjJDdjxStSxkkjI
P7FiPCtC4MP58YA85kOTnuOAk1bqpuamPaATWPwp8+044G+NLuaR7+BQl1rDu2uh
WTnBv/RpQACgELyLjgg0kFZNWGvS90Ia7UK5ph36SL4vUCI5wXDjlatqgjARoYZb
uvsnzNJssey+zCSH5gnQWa8yd6oqd9oSA73+sWmMQUKyfUEfY+zU1eFdmHHgpq75
5lmDLVnwxUQvoTStIZwfi5U3PbqB0zwosfAPvbvEHP4Tfq936xnPE701Ee25d+lr
qvtv4KgVWqNM1fwAIUnBPs4cLDAs9xv2Dsz89XeYky8RYx7YyqQWDM7OrCqzn10F
gD7YUrfklw0I1Yg3Gdm0gUB4YGFfTerVX5TSeUidkWDpzBNiSHfULMO0daVStDFq
gX7VX/F50963KNrrQJIKt9DiDzNjTfBVMjFKIm/uXOn1hgnbqCxTBHAw9LdllaD2
YD3sYhspSOEST7AJVdwaDPzuqvAul4+KeRaC9Rsgaklf8z2/s3vQgRLIuCrYDqKB
XLF4+1sAXAd1P+87E44RnHa0PufSz5uoVlMAyXJV0bi8v6Yn9DNvcZmpEQ6weFpF
NBvYThLi4TrbXPVGalqQwGnbPL2Th5lNHw226iznon+iPfB3mTo=
=DdYE
-----END PGP SIGNATURE-----

--ELMKpCVvjiB+uwRu--
