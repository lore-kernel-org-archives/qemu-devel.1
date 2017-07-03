Received: from eggs.gnu.org ([2001:4830:134:3::10]:47116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRxWq-0000GD-Lj
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dRxWp-0001qW-KO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 05:20:24 -0400
Date: Mon, 3 Jul 2017 19:20:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170703092007.GW13989@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
	<20170630040317.GA13989@umbus.fritz.box>
	<1499051918.2398.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8YbZbqleQryf2nq"
Content-Disposition: inline
In-Reply-To: <1499051918.2398.1.camel@gmail.com>
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


--B8YbZbqleQryf2nq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 01:18:38PM +1000, Suraj Jitindar Singh wrote:
> On Fri, 2017-06-30 at 14:03 +1000, David Gibson wrote:
> > On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh wrote:
> > > The Processor Compatibility Register (PCR) I used to set the
> > > compatibility mode of the processor using the SET_ONE_REG ioctl on
> > > KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when a
> > > compat
> > > mode was actually in use, however a recent patch made it
> > > unconditional.
> > > Calling this in KVM_PR fails as there is no handler for that call
> > > and it
> > > is thus impossible to start a machine with KVM_PR.
> > >=20
> > > Change ppc_set_compat() so that the ioctl is only actually called
> > > if a
> > > compat mode is in use. This means that a KVM_PR guest can boot.
> > > Additionally the current behaviour for KVM_HV is preserved where a
> > > compat
> > > mode of 0 set pcr and arch_compat in the vcore struct to zero, both
> > > of
> > > which are initialised to zero anyway.
> > >=20
> > > Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")
> > >=20
> > > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > This doesn't seem quite right.=A0=A0With this change, how would we ever
> > turn compatibility mode _off_ (which could happen on reset if nothing
>=20
> Oh yeah, didn't really think about that.
>=20
> > else).=A0=A0Really we should add this pseudo-register to KVM PR, althou=
gh
> > I'm fine with also having a qemu workaround to let it work with older
> > PR versions.
>=20
> How do you feel about having a check and only calling the ioctl if the
> KVM in use is HV?

Don't really like it.  For one thing, we want to avoid explicitly
checking for KVM PR - we should check specific capabilities instead.
For another, it means on PR we're silently ignoring the compatibility
mode which isn't really right.

I think the right approach here is to only call the ioctl() if the
compatibility mode has actually changed.  That should make it work in
the cases the original patch did, which is.. actually very few, given
the new CAS logic.

Really the right fix is to implement the set compat mode ioctl() in
KVM PR.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B8YbZbqleQryf2nq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWgxEAAoJEGw4ysog2bOSqL0QAMCrQQ2aHcB/ylA0W8iUzTMj
sVJfKqJWc2O1ND3eHr/GSqgJ7yGJwYGXjHjtjFrNinPO+X7y81fiYFtabJWKrulx
R0Ee0l20TOhnQ/fLcfRlzHlnUBit+y2jJ/ImWLv4K5MPAAcHDC2MalXEjTeoN4bM
pI/Iv1kaj9hzilpSaZWCTtHnLXoRO9nlmnkaUM8nUgaUq/w0M2KSCOSu4wY1HoKq
MHAzAA+ujz6zCH0hsrF0ziBYAI6JPOHLHXN6AZfh0MlP6ihGlwKSlbCc1NXYWo+T
ndPpkrlZtVlvb05Z+FsprrwKCOT0tqhigkZyQhGdSkDOUAfFqjClwmjX3ORUYkaW
jjDboQxaXVZg1RsPHJRCNbb96myj3Vmcn4StfO4LnVov6fEf1GuXJrmACT9kJijm
bMNohdRkFxUZY9nkwZ6e7qGGz5paemVptFGPQfFAWe2ppj9T9PM0fWTfIuchZUr0
Z8U5GHGZRPcsxBDg8KrKq6gIH8K/fUnZdMRUDjYvZ06L2fUFePXoJrmUerAEtaz7
mstDZQiKesB65ZYck354nW1Le44FBef+vcjqpZQVi5OgHsva40ifwnwpNYvdJrGZ
tYU7PBeo+CfnG1rVs8up7HMq/rzw4Ie4nzgW15wOk1044Q/QdExPbO0aI7mPKEqL
a4vUMXgKRaJMUBrccjUb
=ybZL
-----END PGP SIGNATURE-----

--B8YbZbqleQryf2nq--
