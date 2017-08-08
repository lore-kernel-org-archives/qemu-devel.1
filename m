Received: from eggs.gnu.org ([2001:4830:134:3::10]:56047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexwB-0007Oy-FH
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dexw5-0007ll-U8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 02:24:19 -0400
Date: Tue, 8 Aug 2017 16:21:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170808062106.GC25081@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
	<1499841917.20288.2.camel@gmail.com>
	<20170713012118.GT4083@umbus.fritz.box>
	<20170803192806.782ebf5b@bahia.lan>
	<20170804023530.GF6553@umbus.fritz.box>
	<20170807110018.25ddce73@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <20170807110018.25ddce73@bahia.lan>
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


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 11:00:18AM +0200, Greg Kurz wrote:
> On Fri, 4 Aug 2017 12:35:30 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Aug 03, 2017 at 07:28:06PM +0200, Greg Kurz wrote:
> > > On Thu, 13 Jul 2017 11:21:18 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Wed, Jul 12, 2017 at 04:45:17PM +1000, Suraj Jitindar Singh wrot=
e: =20
> > > > > On Mon, 2017-07-03 at 19:20 +1000, David Gibson wrote:   =20
> > > > > > On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh =
wrote:   =20
> > > > > > > On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote:   =20
> > > > > > > > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Si=
ngh
> > > > > > > > wrote:   =20
> > > > > > > > > The Processor Compatibility Register (PCR) I used to set =
the
> > > > > > > > > compatibility mode of the processor using the SET_ONE_REG=
 ioctl
> > > > > > > > > on
> > > > > > > > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called =
when a
> > > > > > > > > compat
> > > > > > > > > mode was actually in use, however a recent patch made it
> > > > > > > > > unconditional.
> > > > > > > > > Calling this in KVM_PR fails as there is no handler for t=
hat
> > > > > > > > > call
> > > > > > > > > and it
> > > > > > > > > is thus impossible to start a machine with KVM_PR.
> > > > > > > > >=20
> > > > > > > > > Change ppc_set_compat() so that the ioctl is only actually
> > > > > > > > > called
> > > > > > > > > if a
> > > > > > > > > compat mode is in use. This means that a KVM_PR guest can=
 boot.
> > > > > > > > > Additionally the current behaviour for KVM_HV is preserved
> > > > > > > > > where a
> > > > > > > > > compat
> > > > > > > > > mode of 0 set pcr and arch_compat in the vcore struct to =
zero,
> > > > > > > > > both
> > > > > > > > > of
> > > > > > > > > which are initialised to zero anyway.
> > > > > > > > >=20
> > > > > > > > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mo=
de")
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail=
=2Ecom>   =20
> > > > > > > >=20
> > > > > > > > This doesn't seem quite right.=A0=A0With this change, how w=
ould we
> > > > > > > > ever
> > > > > > > > turn compatibility mode _off_ (which could happen on reset =
if
> > > > > > > > nothing   =20
> > > > > > >=20
> > > > > > > Oh yeah, didn't really think about that.
> > > > > > >    =20
> > > > > > > > else).=A0=A0Really we should add this pseudo-register to KV=
M PR,
> > > > > > > > although
> > > > > > > > I'm fine with also having a qemu workaround to let it work =
with
> > > > > > > > older
> > > > > > > > PR versions.   =20
> > > > > > >=20
> > > > > > > How do you feel about having a check and only calling the ioc=
tl if
> > > > > > > the
> > > > > > > KVM in use is HV?   =20
> > > > > >=20
> > > > > > Don't really like it.=A0=A0For one thing, we want to avoid expl=
icitly
> > > > > > checking for KVM PR - we should check specific capabilities ins=
tead.
> > > > > > For another, it means on PR we're silently ignoring the compati=
bility
> > > > > > mode which isn't really right.
> > > > > >=20
> > > > > > I think the right approach here is to only call the ioctl() if =
the
> > > > > > compatibility mode has actually changed.=A0=A0That should make =
it work in
> > > > > > the cases the original patch did, which is.. actually very few,=
 given
> > > > > > the new CAS logic.   =20
> > > > >=20
> > > > > I think this is the right approach. There is no point calling the=
 ioctl
> > > > > if nothing changed. Additionally this fixes KVM_PR in the interim
> > > > > assuming no max-cpu-compat is specified on the command line.   =
=20
> > > >=20
> > > > Right, that's the idea.
> > > >  =20
> > > > > > Really the right fix is to implement the set compat mode ioctl(=
) in
> > > > > > KVM PR.   =20
> > > > >=20
> > > > > This would be the ideal fix however I suggest the implementation =
of
> > > > > that would be to simply ignore it- given the main use case of KVM=
_PR is
> > > > > nested and that means we can't actually set the PCR since it's
> > > > > hypervisor privileged.   =20
> > > >=20
> > > > Yeah, as we discussed on IRC, I tend to agree.  I don't love the id=
ea
> > > > of silently presenting something other than requested.  However, we
> > > > don't really have much choice and we do already have precedent.  PR
> > > > tries to match the CPU requested in the PVR, but won't always be ab=
le
> > > > to do so exactly (if the host CPU supports userspace instructions t=
he
> > > > requested PVR doesn't).  This doesn't really change the situation,
> > > > except that we have a (PVR+PCR) combination instead of just a PVR t=
hat
> > > > we're trying, and not completely suceeding, in matching.
> > > >  =20
> > >=20
> > > Does it make sense at all to use compat mode with KVM_PR since it
> > > requires hypervisor privilege, that we're supposed not to have ? =20
> >=20
> > Uh.. what?  Availability of the PCR is a question of the guest
> > environment, and PR (at least potentially) supports various different
> > guest environments, both with and without (apparent) hypervisor
> > capability.
> >=20
>=20
> I mean mtpcr/mfpcr only work when the CPU is in hypervisor state, and PR
> is supposed to be *mostly* used nested, ie, without hypervisor
> privilege.

It tends to be used that way, but it doesn't have to be.

> Thus, I don't see the point in implementing PPC_ARCH_COMPAT in PR... but
> I'm probably missing something :)

Well, qemu expects to be able to set ARCH_COMPAT for a pseries guest,
if that guest is going into a compatibility mode (which it usually
does these days).  We don't want userspace to have to be constantly
checking which KVM implementation its working against, so it makes
sense for PR to implement the call, even if it's a no-op because it
can't really implement the PCR fully.

>=20
> > > Shouldn't we check for kvm_get_one_reg(KVM_REG_PPC_ARCH_COMPAT) and
> > > don't try to do any compat stuff if it isn't supported ? This would
> > > include exiting QEMU if max-cpu-compat was passed on the cmdline. =20
> >=20
> > Oh.. right.. that's actually what I meant by setting the PCR.  PCR
> > setting from the userspace side via PPC_ARCH_COMPAT, rather than PCR
> > setting from the guest side.
> >=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmJWFEACgkQbDjKyiDZ
s5L6fw/+OiSmHYRaDTRHPvoA2kadwyY9F3lyXBUhHwUBabdFZckiWNxSy9YKffsI
R411U8hG2MwmfS47TDlzegnLiEm+lZrIRHkwnJRdENH8MJTdSoXKPA1pxjcWQ+fa
Uo0OgaBo01/1sNGkJAaLq2w6xhBjS17GExr7U8Q7Zm9E3R0rTjiZAwEQaXoawJLe
i6TQK6vqvarnpLRndadK2npZUzumZuOL8y/JCJvN7fb01cydpPgnhV9/0Kkhhl0S
hHkxoTUpeMLHRhcNxz699t7lzXSaxqIV+nB8n352zcudT1uB2BhDuY1BrBvvSZzu
L1+uO37+c0eKpZzI5IhHjAcxK/zH3aPrkEy1k18UGHv+eEiAQ0KPmmqxlE+nWWG0
CK0lizsPWu8s/2s7lQ1jjkghZjssxQIleaeFP1wH7uITu0W9c3Je+wBzINbCTkFs
ixqL/dbAYuC/SHX8DDlJ4os5NeWZ0t8/urk6oTTF9laa9qcm21LB4mhUlTuXfKeX
ZQxooeTPEcbhB5bghRqYG6tXS9mlBD004i7nuhxxaGRPi/SD+GXwRTI6I2DfgiGb
YkdW4AkcszJPil4f1GiBobpYFSiRzFR7nIlJpsDAjBG3iBMhZUoU73XLvS6rl8fM
aNkgDZhkjhHsT55RnY/uCDvK5/yVU9E9BJjrom2yAHFnx+cZit0=
=Zrso
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
