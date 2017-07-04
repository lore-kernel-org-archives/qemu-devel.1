Received: from eggs.gnu.org ([2001:4830:134:3::10]:37843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSPEL-0006Tv-Te
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dSPEL-0005bX-0k
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 10:55:10 -0400
Date: Wed, 5 Jul 2017 00:54:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170704145454.GI2180@umbus.fritz.box>
References: <20170621091848.28256-1-david@gibson.dropbear.id.au>
	<20170621091848.28256-3-david@gibson.dropbear.id.au>
	<20170622113215.146bc3b8@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Content-Disposition: inline
In-Reply-To: <20170622113215.146bc3b8@bahia.lab.toulouse-stg.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] spapr: Refactor spapr_drc_detach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, sursingh@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:32:15AM +0200, Greg Kurz wrote:
> On Wed, 21 Jun 2017 17:18:45 +0800
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This function has two unused parameters - remove them.
> >=20
>=20
> It's ok for the d argument but I'm not sure about errp... Indeed it isn't=
 used
> in the current code, but looking at the paths below spapr_drc_detach(), we
> have:
>=20
> spapr_drc_detach()
>  spapr_drc_release()
>   spapr_core_release()
>    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>=20
> and
>=20
> spapr_drc_detach()
>  spapr_drc_release()
>   spapr_lmb_release()
>    hotplug_handler_unplug(hotplug_ctrl, dev, &error_abort);
>=20
> Shouldn't we pass the errp down to hotplug_handler_unplug() instead of
> aborting ?

So, at first I thought you were right, and was going to rewrite on
that basis.

Then I realized that calling hotplug_handler_unplug() is a bizarrely
roundabout way of doing what we need anyway (usually the unplug
handler is never called if there is an unplug_request() handler).
Once we expand those out to what they actually call, the errors
disappear again.  I'll do that in the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW6w8AAoJEGw4ysog2bOSWUIQAKbtlLEieL3bv2Ptw84mC/Nx
xAFwvzyrbgioKXXcvruoqgoikg7LGxyC8kTHvpYysY+0BWwIgO96OCls2vpJvcmU
klQvJe6R2MSp3DdFSj80hpjsOSY+dgpRFTMKIUi9yFtu/Rs1z5KHPcK8G3sgXOBU
XmJENS3LLyG6hJlaVQe6vhJ6Cx8g1LnrPKxngkYECgH8WWxKHcEI5kjw9leKJYMD
p5OttjJI//o/JUUdcEaCh2lj9u0id6XafNO+rqpA0AHXbe4Xcj8LQ8rqixy4sIh/
FJC1nMvnIdu6jRRpHfNXunE3Z9OJvuY/nuyx2jko49oLTn9oo9P8MZ3CbCiaMPzA
D8BOSUSUerz9CCBlFWBawNx0oQVROYM7MI6HhBd52xB7zPnNtO0iLPRPEgvvKPFg
njG9S48lVZlhky2uWQxJlFk/y9vyWUSdp24zH9c/k8nWBrUUxoG5Gm4reGpQy/dQ
kPPZgMncHcz45g0gx2oFQzp6afwr89gxsu3emutrvK3f0fe3KftSUVvMdnBzf5nw
UHm5FBLpGMe+88kX7ULjumDx4xZJ4udJZ24Y3aH7VkY0ghFTRjCTr5C0f78ri7rM
f4H8WRsTwum2L4C9/rSVzpijRCObMaVnHxLQWsF4ar6brAKICgckehLgTIFFJTM5
CLtqePlBJdELcs+omNoL
=9+kj
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
