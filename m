Received: from eggs.gnu.org ([2001:4830:134:3::10]:34705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVGhx-0003b3-A5
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dVGhu-0000Fp-5V
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:25:33 -0400
Received: from 2.mo68.mail-out.ovh.net ([46.105.52.162]:55082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dVGht-0000De-Rp
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:25:30 -0400
Received: from player750.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 0F2376C21A
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 14:25:25 +0200 (CEST)
Date: Wed, 12 Jul 2017 14:25:17 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170712142517.5db95655@bahia.lan>
In-Reply-To: <1499856934.13989.38.camel@redhat.com>
References: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
	<20170704072901.GA2180@umbus.fritz.box>
	<20170704104722.499d4e86@bahia.lan>
	<1499856934.13989.38.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5T=wcQUIgfYFJzLBkIMcBf1";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, libvir-list@redhat.com

--Sig_/5T=wcQUIgfYFJzLBkIMcBf1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Jul 2017 12:55:34 +0200
Andrea Bolognani <abologna@redhat.com> wrote:

> [libvir-list added to the loop]
>=20
> On Tue, 2017-07-04 at 10:47 +0200, Greg Kurz wrote:
> > On Tue, 4 Jul 2017 17:29:01 +1000 David Gibson <david@gibson.dropbear.i=
d.au> wrote: =20
> > > On Mon, Jul 03, 2017 at 06:48:25PM +0200, Greg Kurz wrote: =20
> > > >=C2=A0
> > > > The sPAPR machine always create a default PHB during initialization=
, even
> > > > if -nodefaults was passed on the command line. This forces the user=
 to
> > > > rely on -global if she wants to set properties of the default PHB, =
such
> > > > as numa_node.
> > > >=C2=A0
> > > > This patch introduces a new machine create-default-phb property to =
control
> > > > whether the default PHB must be created or not. It defaults to on i=
n order
> > > > to preserve old setups (which is also the motivation to not alter t=
he
> > > > current behavior of -nodefaults).
> > > >=C2=A0
> > > > If create-default-phb is set to off, the default PHB isn't created,=
 nor
> > > > any other device usually created with it. It is mandatory to provide
> > > > a PHB on the command line to be able to use PCI devices (otherwise =
QEMU
> > > > won't start). For example, the following creates a PHB with the same
> > > > mappings as the default PHB and also sets the NUMA affinity:
> > > >=C2=A0
> > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries,create-default=
-phb=3Doff \
> > > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-numa node,nodeid=3D0 -device spapr-pc=
i-host-bridge,index=3D0,numa_node=3D0 =20
> > >=C2=A0
> > > So, I agree that the distinction between default devices that are
> > > disabled with -nodefaults and default devices that aren't is a big
> > > mess in qemu configuration.=C2=A0=C2=A0But on the other hand this onl=
y addresses
> > > one tiny aspect of that, and in the meantime means we will silently
> > > ignore some other configuration options in some conditions.
> > >=C2=A0
> > > So, what's the immediate benefit / use case for this? =20
> >=C2=A0
> > With the current code base, the only way to set properties of the defau=
lt
> > PHB, is to pass -global spapr-pci-host-bridge.prop=3Dvalue for each pro=
perty.
> > The immediate benefit of this patch is to unify the way libvirt passes
> > PHB description to the command line:
> >=C2=A0
> > ie, do:
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries,create-default-phb=
=3Doff \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Da,pr=
op2=3Db,prop3=3Dc \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Dd,pr=
op2=3De,prop3=3Df
> >=C2=A0
> > instead of:
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-machine type=3Dpseries \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop1=3Da \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop2=3Db \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-global spapr-pci-host-bridge.prop3=3Dc \
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device spapr-pci-host-bridge,prop1=3Dd,pr=
op2=3De,prop3=3Df =20
>=20
> So, I'm thinking about this mostly in terms of NUMA nodes
> because that's the use case I'm aware of.
>=20

This is the initial motivation behind this patch indeed.

> The problem with using -global is not that it requires using
> a different syntax to set properties for the default PHB,
> but rather that such properties are then inherited by all
> other PHBs unless explicitly overridden.

Yeah, I should have mentioned that.

> Not creating the
> default PHB at all would solve the issue.
>=20
> On the other hand, libvirt would then need to either
>=20
> =C2=A0 1) only allow setting NUMA nodes for PHBs if QEMU supports
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the new option, leaving QEMU < 2.10 users b=
ehind; or
>=20
> =C2=A0 2) implement handling for both the new and old behavior.
>=20
> I'm not sure we could get away with 1), and going for 2)
> means more work both for QEMU and libvirt developers for
> very little actual gain, so I'd be inclined to scrap this
> and just build the libvirt glue on top of the existing
> interface.
>=20

Makes sense.

> That is, of course, unless
>=20
> =C2=A0 1) having a random selection of PHBs not assigned to any
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NUMA node is a sensible use case. This is s=
omething
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0we just can't do reliably with the current =
interface:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0we can decide to set the NUMA node only for=
 say, PHBs
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A01 and 3 leaving 0 and 2 alone, but once we =
set it for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0the default PHB we *have* to set it for all=
 remaining
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ones as well. libvirt will by default assig=
n emulated
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devices to the default PHB, so I would rath=
er expect
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0users to leave that one alone and set a NUM=
A node for
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0all other PHBs; or
>=20

I agree.

> =C2=A0 2) there are other properties outside of numa_node we
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0might want to deal with; or
>=20

Dunno... and anyway, since we can have several PHBs, it is
probably easier to leave the default one alone.

> =C2=A0 3) it turns out it's okay to require a recent QEMU :)
>=20

I guess having a recent QEMU is always better :) but you're the one
to say if it is okay for libvirt users.

> --=C2=A0
> Andrea Bolognani / Red Hat / Virtualization


--Sig_/5T=wcQUIgfYFJzLBkIMcBf1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllmFS0ACgkQAvw66wEB28JCeQCeIT/vzBviOUQbxth1qfW4FCq+
M5IAnRS3+B7biDdFsZhgC093QU+vs0Gk
=h8/+
-----END PGP SIGNATURE-----

--Sig_/5T=wcQUIgfYFJzLBkIMcBf1--
