Received: from eggs.gnu.org ([2001:4830:134:3::10]:39154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1firHU-0002pR-VJ
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 21:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1firHR-0006JT-PT
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 21:10:56 -0400
Date: Fri, 27 Jul 2018 11:10:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727011042.GC3694@umbus.fritz.box>
References: <20180504042044.10318-1-mdroth@linux.vnet.ibm.com>
	<20180726050746.GC12001@umbus.fritz.box>
	<153260823426.10934.15915467115866182748@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline
In-Reply-To: <153260823426.10934.15915467115866182748@sif>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: only save guest timebase once
 after stopping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, qemu-stable@nongnu.org


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 07:30:34AM -0500, Michael Roth wrote:
> Quoting David Gibson (2018-07-26 00:07:46)
> > On Thu, May 03, 2018 at 11:20:44PM -0500, Michael Roth wrote:
> > > In some cases (e.g. spapr) we record guest timebase after qmp_stop()
> > > via a runstate hook so we can restore it on qmp_cont(). If a migration
> > > occurs in between those events we end up saving it again, this time
> > > based on the current timebase the guest would be seeing had it been
> > > running. This has the effect of advancing the guest timebase while
> > > it is stopped, which is not what the code intends.
> > >=20
> > > Other than simple jumps in time, this has been seen to trigger what
> > > appear to be RCU-related crashes in recent kernels when the advance
> > > exceeds rcu_cpu_stall_timeout, and it can be triggered by fairly
> > > common operations such as `virsh migrate ... --timeout 60`.
> > >=20
> > > Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Cc: Laurent Vivier <lvivier@redhat.com>
> > > Cc: qemu-ppc@nongnu.org
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> >=20
> > Sorry, this fell off my radar for ages, but I've finally had a chance
> > to look at it properly.
>=20
> No problem, I had assumed it just wasn't deemed needed based on the
> discussion.
>=20
> >=20
> > I'm not totally convinced this handle all the possible edge cases
> > correctly, but I am convinced it gives behaviour that's more correct
> > than we have now.  It doesn't introduce changes to the interface or
> > migration stream that would break things in future, so I've applied it
> > to ppc-for-3.1.
>=20
> There's a flaw with the patch that Greg pointed out to me previously
> in that it doesn't just avoid the presave hook when vm_stop is issued
> manually via monitor, but also when vm_stop is issued by the migration
> code itself. The latter wasn't intentional. I'm not sure if we currently
> have a good way to distinguish between the 2 cases to rectify that.
>=20
> As the patch currently stands it is effectively a revert of the
> Laurent's original patch.
>=20
> FWIW, the RCU-related crashes mentioned in the original commit turned
> out to be a separate issue that was exacerbated by RCU stall warnings
> messages (which *would* be less likely with this patch). So this would
> be more about user experience and spurious log messages than an actual
> known bug fix. I am still of the opinion that we shouldn't resave the
> clock if the vm_stop was manually-issued; it's just that the current
> patch oversteps that goal.

Right, I agree.  Migrating shouldn't advance the time if we've already
explicitly stopped.  But it's not really clear how to accomplish that
:/.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5G06lTa6Jq83wMTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltacRIACgkQbDjKyiDZ
s5JirBAAr2xxPp4ACAvY2wXqxORzOKeXd1qQnZ3d3zm4D2+c1gB11uxzTnhmaZK7
qR0282rfK1mwashEltTjq+wfYtv5vAZwkixgO1UF7z4Vf5Z+G3Q3LbGrUSB68+lh
vRsNXO1fSMF6n+PxyyK0Kql4ImZO48BMUqWtQhlZQ+YnDJ0maNqD7k8jAde9Ek+1
JQXEHHpN82Op0KXifSpvKMkAl8guxjLr664AHU4okll1KtSuuxGjzQojfpvxRlew
M4Lkn69zQrQKKRLcsJXjTbpOhH44t+e6Q4+D8/QWgbvm3q4biVv52Byv+AnVxG65
y4S10IJpV/CTi1X6yyhyFlLv9RxjqWjPusHa2H/ucc2DQ2XvqsNJFZTfs/5j//z1
jH1whXsaaITxRP7bnPYX3c1njZVYqNYKp0WvOBkVne1l+FyWWAhc5OgaNfPeZvqq
qnAAvs54vX/xuhKSAf+Pw4tBDSpC3fCSdisP8xhE+2KEsO/tZCN1RbIPiAHdqNky
rfPpQeIXune5g7Mv6R88izG08MGIHr694+sUR28YYg+hHKH6sOUUtH+hJAEeqf1x
hs2ORXAUiV1tBvvpvBGmL3ao84G7zHBkA/JNl+NGJZjnPGj0KlFIpSBemP42Hkvn
upyYZHeEVEcyCYzIt94uoad1xhiiGAXgH6YJSNitfaIPP5skt6Y=
=wcdy
-----END PGP SIGNATURE-----

--5G06lTa6Jq83wMTw--
