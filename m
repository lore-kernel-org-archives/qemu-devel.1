Received: from eggs.gnu.org ([2001:4830:134:3::10]:55294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dedtx-0004MF-7a
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dedtt-0000EY-1N
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:00:41 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:36953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dedts-0000C0-MW
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 05:00:36 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5E90E8B6E5
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 11:00:27 +0200 (CEST)
Date: Mon, 7 Aug 2017 11:00:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170807110018.25ddce73@bahia.lan>
In-Reply-To: <20170804023530.GF6553@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
	<1499841917.20288.2.camel@gmail.com>
	<20170713012118.GT4083@umbus.fritz.box>
	<20170803192806.782ebf5b@bahia.lan>
	<20170804023530.GF6553@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Tlgeg07Uu_FbeefZjrym=kF";
	protocol="application/pgp-signature"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/Tlgeg07Uu_FbeefZjrym=kF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Aug 2017 12:35:30 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Aug 03, 2017 at 07:28:06PM +0200, Greg Kurz wrote:
> > On Thu, 13 Jul 2017 11:21:18 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Wed, Jul 12, 2017 at 04:45:17PM +1000, Suraj Jitindar Singh wrote:=
 =20
> > > > On Mon, 2017-07-03 at 19:20 +1000, David Gibson wrote:   =20
> > > > > On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh wr=
ote:   =20
> > > > > > On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote:   =20
> > > > > > > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh
> > > > > > > wrote:   =20
> > > > > > > > The Processor Compatibility Register (PCR) I used to set the
> > > > > > > > compatibility mode of the processor using the SET_ONE_REG i=
octl
> > > > > > > > on
> > > > > > > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called wh=
en a
> > > > > > > > compat
> > > > > > > > mode was actually in use, however a recent patch made it
> > > > > > > > unconditional.
> > > > > > > > Calling this in KVM_PR fails as there is no handler for that
> > > > > > > > call
> > > > > > > > and it
> > > > > > > > is thus impossible to start a machine with KVM_PR.
> > > > > > > >=20
> > > > > > > > Change ppc_set_compat() so that the ioctl is only actually
> > > > > > > > called
> > > > > > > > if a
> > > > > > > > compat mode is in use. This means that a KVM_PR guest can b=
oot.
> > > > > > > > Additionally the current behaviour for KVM_HV is preserved
> > > > > > > > where a
> > > > > > > > compat
> > > > > > > > mode of 0 set pcr and arch_compat in the vcore struct to ze=
ro,
> > > > > > > > both
> > > > > > > > of
> > > > > > > > which are initialised to zero anyway.
> > > > > > > >=20
> > > > > > > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode=
")
> > > > > > > >=20
> > > > > > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.c=
om>   =20
> > > > > > >=20
> > > > > > > This doesn't seem quite right.=C2=A0=C2=A0With this change, h=
ow would we
> > > > > > > ever
> > > > > > > turn compatibility mode _off_ (which could happen on reset if
> > > > > > > nothing   =20
> > > > > >=20
> > > > > > Oh yeah, didn't really think about that.
> > > > > >    =20
> > > > > > > else).=C2=A0=C2=A0Really we should add this pseudo-register t=
o KVM PR,
> > > > > > > although
> > > > > > > I'm fine with also having a qemu workaround to let it work wi=
th
> > > > > > > older
> > > > > > > PR versions.   =20
> > > > > >=20
> > > > > > How do you feel about having a check and only calling the ioctl=
 if
> > > > > > the
> > > > > > KVM in use is HV?   =20
> > > > >=20
> > > > > Don't really like it.=C2=A0=C2=A0For one thing, we want to avoid =
explicitly
> > > > > checking for KVM PR - we should check specific capabilities inste=
ad.
> > > > > For another, it means on PR we're silently ignoring the compatibi=
lity
> > > > > mode which isn't really right.
> > > > >=20
> > > > > I think the right approach here is to only call the ioctl() if the
> > > > > compatibility mode has actually changed.=C2=A0=C2=A0That should m=
ake it work in
> > > > > the cases the original patch did, which is.. actually very few, g=
iven
> > > > > the new CAS logic.   =20
> > > >=20
> > > > I think this is the right approach. There is no point calling the i=
octl
> > > > if nothing changed. Additionally this fixes KVM_PR in the interim
> > > > assuming no max-cpu-compat is specified on the command line.   =20
> > >=20
> > > Right, that's the idea.
> > >  =20
> > > > > Really the right fix is to implement the set compat mode ioctl() =
in
> > > > > KVM PR.   =20
> > > >=20
> > > > This would be the ideal fix however I suggest the implementation of
> > > > that would be to simply ignore it- given the main use case of KVM_P=
R is
> > > > nested and that means we can't actually set the PCR since it's
> > > > hypervisor privileged.   =20
> > >=20
> > > Yeah, as we discussed on IRC, I tend to agree.  I don't love the idea
> > > of silently presenting something other than requested.  However, we
> > > don't really have much choice and we do already have precedent.  PR
> > > tries to match the CPU requested in the PVR, but won't always be able
> > > to do so exactly (if the host CPU supports userspace instructions the
> > > requested PVR doesn't).  This doesn't really change the situation,
> > > except that we have a (PVR+PCR) combination instead of just a PVR that
> > > we're trying, and not completely suceeding, in matching.
> > >  =20
> >=20
> > Does it make sense at all to use compat mode with KVM_PR since it
> > requires hypervisor privilege, that we're supposed not to have ? =20
>=20
> Uh.. what?  Availability of the PCR is a question of the guest
> environment, and PR (at least potentially) supports various different
> guest environments, both with and without (apparent) hypervisor
> capability.
>=20

I mean mtpcr/mfpcr only work when the CPU is in hypervisor state, and PR
is supposed to be *mostly* used nested, ie, without hypervisor privilege.
Thus, I don't see the point in implementing PPC_ARCH_COMPAT in PR... but
I'm probably missing something :)

> > Shouldn't we check for kvm_get_one_reg(KVM_REG_PPC_ARCH_COMPAT) and
> > don't try to do any compat stuff if it isn't supported ? This would
> > include exiting QEMU if max-cpu-compat was passed on the cmdline. =20
>=20
> Oh.. right.. that's actually what I meant by setting the PCR.  PCR
> setting from the userspace side via PPC_ARCH_COMPAT, rather than PCR
> setting from the guest side.
>=20

--Sig_/Tlgeg07Uu_FbeefZjrym=kF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmILCIACgkQAvw66wEB28JW5gCfZQ8MAukw0upIHzxJgq3Ml+ng
0zMAn03sLuP8EdrjUlLgxoovoDWFufwo
=D2Z8
-----END PGP SIGNATURE-----

--Sig_/Tlgeg07Uu_FbeefZjrym=kF--
