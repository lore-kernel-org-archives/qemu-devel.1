Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSSi-0001AP-Hj
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSSh-0002d7-4a
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:35:40 -0400
Date: Fri, 4 Aug 2017 12:35:30 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170804023530.GF6553@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
	<1499841917.20288.2.camel@gmail.com>
	<20170713012118.GT4083@umbus.fritz.box>
	<20170803192806.782ebf5b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <20170803192806.782ebf5b@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] target/ppc: Only set PCR in kvm
 if actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 07:28:06PM +0200, Greg Kurz wrote:
> On Thu, 13 Jul 2017 11:21:18 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Jul 12, 2017 at 04:45:17PM +1000, Suraj Jitindar Singh wrote:
> > > On Mon, 2017-07-03 at 19:20 +1000, David Gibson wrote: =20
> > > > On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh wrot=
e: =20
> > > > > On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote: =20
> > > > > > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh
> > > > > > wrote: =20
> > > > > > > The Processor Compatibility Register (PCR) I used to set the
> > > > > > > compatibility mode of the processor using the SET_ONE_REG ioc=
tl
> > > > > > > on
> > > > > > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when=
 a
> > > > > > > compat
> > > > > > > mode was actually in use, however a recent patch made it
> > > > > > > unconditional.
> > > > > > > Calling this in KVM_PR fails as there is no handler for that
> > > > > > > call
> > > > > > > and it
> > > > > > > is thus impossible to start a machine with KVM_PR.
> > > > > > >=20
> > > > > > > Change ppc_set_compat() so that the ioctl is only actually
> > > > > > > called
> > > > > > > if a
> > > > > > > compat mode is in use. This means that a KVM_PR guest can boo=
t.
> > > > > > > Additionally the current behaviour for KVM_HV is preserved
> > > > > > > where a
> > > > > > > compat
> > > > > > > mode of 0 set pcr and arch_compat in the vcore struct to zero,
> > > > > > > both
> > > > > > > of
> > > > > > > which are initialised to zero anyway.
> > > > > > >=20
> > > > > > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")
> > > > > > >=20
> > > > > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com=
> =20
> > > > > >=20
> > > > > > This doesn't seem quite right.=A0=A0With this change, how would=
 we
> > > > > > ever
> > > > > > turn compatibility mode _off_ (which could happen on reset if
> > > > > > nothing =20
> > > > >=20
> > > > > Oh yeah, didn't really think about that.
> > > > >  =20
> > > > > > else).=A0=A0Really we should add this pseudo-register to KVM PR,
> > > > > > although
> > > > > > I'm fine with also having a qemu workaround to let it work with
> > > > > > older
> > > > > > PR versions. =20
> > > > >=20
> > > > > How do you feel about having a check and only calling the ioctl if
> > > > > the
> > > > > KVM in use is HV? =20
> > > >=20
> > > > Don't really like it.=A0=A0For one thing, we want to avoid explicit=
ly
> > > > checking for KVM PR - we should check specific capabilities instead.
> > > > For another, it means on PR we're silently ignoring the compatibili=
ty
> > > > mode which isn't really right.
> > > >=20
> > > > I think the right approach here is to only call the ioctl() if the
> > > > compatibility mode has actually changed.=A0=A0That should make it w=
ork in
> > > > the cases the original patch did, which is.. actually very few, giv=
en
> > > > the new CAS logic. =20
> > >=20
> > > I think this is the right approach. There is no point calling the ioc=
tl
> > > if nothing changed. Additionally this fixes KVM_PR in the interim
> > > assuming no max-cpu-compat is specified on the command line. =20
> >=20
> > Right, that's the idea.
> >=20
> > > > Really the right fix is to implement the set compat mode ioctl() in
> > > > KVM PR. =20
> > >=20
> > > This would be the ideal fix however I suggest the implementation of
> > > that would be to simply ignore it- given the main use case of KVM_PR =
is
> > > nested and that means we can't actually set the PCR since it's
> > > hypervisor privileged. =20
> >=20
> > Yeah, as we discussed on IRC, I tend to agree.  I don't love the idea
> > of silently presenting something other than requested.  However, we
> > don't really have much choice and we do already have precedent.  PR
> > tries to match the CPU requested in the PVR, but won't always be able
> > to do so exactly (if the host CPU supports userspace instructions the
> > requested PVR doesn't).  This doesn't really change the situation,
> > except that we have a (PVR+PCR) combination instead of just a PVR that
> > we're trying, and not completely suceeding, in matching.
> >=20
>=20
> Does it make sense at all to use compat mode with KVM_PR since it
> requires hypervisor privilege, that we're supposed not to have ?

Uh.. what?  Availability of the PCR is a question of the guest
environment, and PR (at least potentially) supports various different
guest environments, both with and without (apparent) hypervisor
capability.

> Shouldn't we check for kvm_get_one_reg(KVM_REG_PPC_ARCH_COMPAT) and
> don't try to do any compat stuff if it isn't supported ? This would
> include exiting QEMU if max-cpu-compat was passed on the cmdline.

Oh.. right.. that's actually what I meant by setting the PCR.  PCR
setting from the userspace side via PPC_ARCH_COMPAT, rather than PCR
setting from the guest side.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmD3XEACgkQbDjKyiDZ
s5L+Fw/+KHBz5sXdWs6Kc/TZCUAZfMqsfyj+IVwVseqvaMNsokcmFb36y4Ln1R4R
KaGEMx0XOdbOHqW8xBU5ZPWaHd1UbfWI4gEwfa6KrqNjWG7nzThtxW6e3aThxDp7
qvBsOeOrbIcQhM/X47sG/JXb1i5+bxXqZCS7ytzITGz1lZpfABsx4BgkuWN7IFoy
VNZFTu8vsH1Pf+yTKWNsrcxmFer3dXEhw6tTemJOAXsSEk33fwCLSVd1QzO53cSy
eJln02Fbu/PWAWZ8DZBpF2hQJMaO3Rf1nk7f6HWNw1SuQqcg+eeql4qIAqBjU9R2
oItHc5bo067Tt47YgVahOfVeNJKdBW9c649GB6s2F5XvXulGw67wIFWyBzECW8qR
pqkf0uPWGr0aeB+Yc8A7ZhDvAB2d0JVWXo/s5jw7f0HLwajezgHWczLWDHcJS/W+
eW0lInkVW583IHfgT9ivFOQhvEQt/S0U46++R4cxAWQqA8Cc7Oq24r1ulh3USKwU
5DZariFkySRteziGO7Eo6hi6VZOz/gIfTyqwV9GykMNKzM9Nq77qLB1Qpase37CZ
af95P9s0dEhiPPDD6hAVXUvloDgNffx3wNrZ1zxEuT4fiFU652PAJFw4QcuWcM7v
FDg5OR5ME2SCpzBlL1nYrYR/E9j5GwfLdBu6SdieMZWpNH/uBZc=
=CLVe
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
