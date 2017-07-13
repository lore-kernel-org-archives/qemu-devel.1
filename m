Received: from eggs.gnu.org ([2001:4830:134:3::10]:52590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVT8C-00081h-4I
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dVT87-0002fp-To
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:41:28 -0400
Date: Thu, 13 Jul 2017 11:21:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170713012118.GT4083@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
	<20170703092007.GW13989@umbus.fritz.box>
	<1499841917.20288.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EcLUEBHJhOmOUQ0C"
Content-Disposition: inline
In-Reply-To: <1499841917.20288.2.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Only set PCR in kvm if
 actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--EcLUEBHJhOmOUQ0C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 04:45:17PM +1000, Suraj Jitindar Singh wrote:
> On Mon, 2017-07-03 at 19:20 +1000, David Gibson wrote:
> > On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh wrote:
> > > On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote:
> > > > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh
> > > > wrote:
> > > > > The Processor Compatibility Register (PCR) I used to set the
> > > > > compatibility mode of the processor using the SET_ONE_REG ioctl
> > > > > on
> > > > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when a
> > > > > compat
> > > > > mode was actually in use, however a recent patch made it
> > > > > unconditional.
> > > > > Calling this in KVM_PR fails as there is no handler for that
> > > > > call
> > > > > and it
> > > > > is thus impossible to start a machine with KVM_PR.
> > > > >=20
> > > > > Change ppc_set_compat() so that the ioctl is only actually
> > > > > called
> > > > > if a
> > > > > compat mode is in use. This means that a KVM_PR guest can boot.
> > > > > Additionally the current behaviour for KVM_HV is preserved
> > > > > where a
> > > > > compat
> > > > > mode of 0 set pcr and arch_compat in the vcore struct to zero,
> > > > > both
> > > > > of
> > > > > which are initialised to zero anyway.
> > > > >=20
> > > > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")
> > > > >=20
> > > > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > >=20
> > > > This doesn't seem quite right.=A0=A0With this change, how would we
> > > > ever
> > > > turn compatibility mode _off_ (which could happen on reset if
> > > > nothing
> > >=20
> > > Oh yeah, didn't really think about that.
> > >=20
> > > > else).=A0=A0Really we should add this pseudo-register to KVM PR,
> > > > although
> > > > I'm fine with also having a qemu workaround to let it work with
> > > > older
> > > > PR versions.
> > >=20
> > > How do you feel about having a check and only calling the ioctl if
> > > the
> > > KVM in use is HV?
> >=20
> > Don't really like it.=A0=A0For one thing, we want to avoid explicitly
> > checking for KVM PR - we should check specific capabilities instead.
> > For another, it means on PR we're silently ignoring the compatibility
> > mode which isn't really right.
> >=20
> > I think the right approach here is to only call the ioctl() if the
> > compatibility mode has actually changed.=A0=A0That should make it work =
in
> > the cases the original patch did, which is.. actually very few, given
> > the new CAS logic.
>=20
> I think this is the right approach. There is no point calling the ioctl
> if nothing changed. Additionally this fixes KVM_PR in the interim
> assuming no max-cpu-compat is specified on the command line.

Right, that's the idea.

> > Really the right fix is to implement the set compat mode ioctl() in
> > KVM PR.
>=20
> This would be the ideal fix however I suggest the implementation of
> that would be to simply ignore it- given the main use case of KVM_PR is
> nested and that means we can't actually set the PCR since it's
> hypervisor privileged.

Yeah, as we discussed on IRC, I tend to agree.  I don't love the idea
of silently presenting something other than requested.  However, we
don't really have much choice and we do already have precedent.  PR
tries to match the CPU requested in the PVR, but won't always be able
to do so exactly (if the host CPU supports userspace instructions the
requested PVR doesn't).  This doesn't really change the situation,
except that we have a (PVR+PCR) combination instead of just a PVR that
we're trying, and not completely suceeding, in matching.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EcLUEBHJhOmOUQ0C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZZssMAAoJEGw4ysog2bOSxZwP/1220Gtv1D+eM/fUYM5+eUDO
3sE9XhEG05r2OVmNAdMM645A0EQCbCCFzciumOxppcWFSBaSEA1NnKUnm/ep9l2l
zuzaf7Cy0g4KfBTo/SGJ3iaLJevaOdCR7Yfz9tyj1o+eVhrupMA+Zx1/nhAkjLz3
fytYsvAEg5eW2t4LP9VB1c6YFr99/yV/kUG+RbFGRoAGQjzCcbXAQSqgxKjb2Y46
0s08qRpC63Xfh768GF4FQHF96rmgKtj96ZMFQa21SIM7xUwV4uDqpQfF58Err8mf
gwz8Wn/ypk9OUQhrN+M5QP3+OZiVYi+abzfqBF8NqmRDzJzwZXEJF7/9yKmjR54N
qF69j21jZl6SeeNsgQ0BgWAFJ2pSHoZtLSFpMKjCumIlkZajj+pw8UzFcpL6FZFf
kFmuSzIO7/5BHKH9eyGJj+kuu6QhvK01GEh1iUy2DJu1maYdoKiQScjMG6+pFwpB
8E8oS7JGS+0O/P0xSnDbHwRQq8kBMb72bWQxhGEkSu/bGQaf/NchazM4gwOmSfjf
irkn3+/NPA8HwF36WXNzGQd7C1ZaidRIQiqb+Du111O6NzsYj+LlaadFxmB+tzqw
yYUt0mH3T33LsUs/08ms6sEDVPPr0h7lwYGjYTR++tO4qnSGFVEAzQsq05qGTYR3
c1sTtXJkLVN6RygPzonU
=7cfg
-----END PGP SIGNATURE-----

--EcLUEBHJhOmOUQ0C--
