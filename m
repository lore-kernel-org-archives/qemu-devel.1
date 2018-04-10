Received: from eggs.gnu.org ([2001:4830:134:3::10]:33737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kug-0006XW-2D
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5kuc-0003tR-Vb
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 00:29:46 -0400
Date: Tue, 10 Apr 2018 14:23:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180410042355.GH3361@umbus.fritz.box>
References: <1522938923-96058-1-git-send-email-spopovyc@redhat.com>
	<1522938923-96058-2-git-send-email-spopovyc@redhat.com>
	<20180406035249.GA10482@in.ibm.com>
	<1d1893fc-1484-86e0-ed1b-f9cf7b35fbb5@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cfJ13FhsvNR/yOpm"
Content-Disposition: inline
In-Reply-To: <1d1893fc-1484-86e0-ed1b-f9cf7b35fbb5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 2.13 1/2] Revert "spapr: Don't allow
 memory hotplug to memory less nodes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Serhii Popovych <spopovyc@redhat.com>
Cc: bharata@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--cfJ13FhsvNR/yOpm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 06, 2018 at 08:48:55AM +0300, Serhii Popovych wrote:
> Bharata B Rao wrote:
> > On Thu, Apr 05, 2018 at 10:35:22AM -0400, Serhii Popovych wrote:
> >> This reverts commit b556854bd8524c26b8be98ab1bfdf0826831e793.
> >>
> >> Leave change @node type from uint32_t to to int from reverted commit
> >> because node < 0 is always false.
> >>
> >> Signed-off-by: Serhii Popovych <spopovyc@redhat.com>
> >> ---
> >>  hw/ppc/spapr.c | 22 ----------------------
> >>  1 file changed, 22 deletions(-)
> >>
> >> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >> index 2c0be8c..3ad4545 100644
> >> --- a/hw/ppc/spapr.c
> >> +++ b/hw/ppc/spapr.c
> >> @@ -3477,28 +3477,6 @@ static void spapr_machine_device_plug(HotplugHa=
ndler *hotplug_dev,
> >>              return;
> >>          }
> >>
> >> -        /*
> >> -         * Currently PowerPC kernel doesn't allow hot-adding memory to
> >> -         * memory-less node, but instead will silently add the memory
> >> -         * to the first node that has some memory. This causes two
> >> -         * unexpected behaviours for the user.
> >> -         *
> >> -         * - Memory gets hotplugged to a different node than what the=
 user
> >> -         *   specified.
> >> -         * - Since pc-dimm subsystem in QEMU still thinks that memory=
 belongs
> >> -         *   to memory-less node, a reboot will set things accordingly
> >> -         *   and the previously hotplugged memory now ends in the rig=
ht node.
> >> -         *   This appears as if some memory moved from one node to an=
other.
> >> -         *
> >> -         * So until kernel starts supporting memory hotplug to memory=
-less
> >> -         * nodes, just prevent such attempts upfront in QEMU.
> >> -         */
> >> -        if (nb_numa_nodes && !numa_info[node].node_mem) {
> >> -            error_setg(errp, "Can't hotplug memory to memory-less nod=
e %d",
> >> -                       node);
> >> -            return;
> >> -        }
> >> -
> >=20
> > If you remove this unconditionally, wouldn't it be a problem in case
> > of newer QEMU with older guest kernels ?
>=20
> Yes, that definitely would affect guest kernels without such support. We
> probably need to add some capability to test for guest kernel
> functionality presence.

Hm, maybe.

So first, we should check when the guest side support came in.  If
it's old enough we might not care.

PAPR does include a mechanism for negotiating guest/host
capabilities.  However, I don't think it has a bit for this specific
feature, so I can't really see a way to do this cleanly.

I don't think we necessarily have to handle that case: it's not like
we can reasonably workaround *every* possible guest bug/limitation
=66rom the host side.  If you want to create a system with a memory-less
node you need an OS that can handle that, nothing really special there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cfJ13FhsvNR/yOpm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrMPFsACgkQbDjKyiDZ
s5JR0xAAuv3NjUp1trvpBCNPzFNQJKFw9yVbPfyUbDxVDMqCFme4NknrNgvUPfWJ
nKpXaxvSLdtwGCMH1AkHyv6iFoIIBcj4Ea9NUdGilyiueTXUiyWpLxCJ/pZnnDMu
0aSR1oPYrOWK+7WIO5ldiphmaDN0sTQ+Ed42kDLGxCTynsiLnRy6BUM5m8PhS01h
Dc8eWgH5Miz6QyAj54kdH3WFJa5xqAkyutiJLYTKFXlxB9TGRPbtZHuAX9t0d7vG
CUS3+fGEAbo+UEIAsn0wn7b7CJ2biDsLw+BngacPlaQw/EvrBm+MM8XLnxxftzWQ
Q7XWbiE4z9JmgI82FXUjoc2Xu46mSwpbjq1M8krGnLbvWRJKCH5XxWGoJaU90ccQ
sMr5rksP8DwPfGsHJi8jetkbx5ka+iKqCS45uPrDHBO3tMfBA/sPfpTnuPKJCQ9r
drvzxTG31OwyGR3Jk7S3va3EzKXC7+HGTad2Rdn7FYJVosK+55WL1tWbMsTPTaWX
t8XhOwD2wkhSdShKIPUyOXEB8YNHZewSxz2gddUruK/TFF2DzKXXXG3fQrWyrYv9
mE0DUqP9pywGvdiN4ey2jGThEhLt3ubPs8145tzMWqHXmcWTISw2d2sfBp65KfkC
7fQBAxbj8ndT6XsvLHOXiawbPpB9zaSbd/ltQf02rKCbJ/Mpj10=
=jH1R
-----END PGP SIGNATURE-----

--cfJ13FhsvNR/yOpm--
