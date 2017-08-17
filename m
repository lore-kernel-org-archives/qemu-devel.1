Received: from eggs.gnu.org ([2001:4830:134:3::10]:39161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diIMV-0008WI-Lb
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diIMS-0007et-JB
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 06:49:15 -0400
Date: Thu, 17 Aug 2017 17:52:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817075236.GI5509@umbus.fritz.box>
References: <20170815202846.24749-1-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Content-Disposition: inline
In-Reply-To: <20170815202846.24749-1-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc: disable hotplug before CAS is
 completed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, lvivier@redhat.com


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2017 at 05:28:46PM -0300, Daniel Henrique Barboza wrote:
> This patch is a follow up on the discussions that started with
> Laurent's patch series "spapr: disable hotplugging without OS" [1]
> and discussions made at patch "spapr: reset DRCs on migration
> pre_load" [2].
>=20
> At this moment, we do not support CPU/memory hotplug in early
> boot stages, before CAS. The reason is that the hotplug event
> can't be handled at SLOF level (or even in PRELAUNCH runstate) and
> at the same time can't be canceled. This leads to devices being
> unable to be hot unplugged and, in some cases, guest kernel Ooops.
> After CAS, with the FDT in place, the guest can handle the hotplug
> events and everything works as usual.
>=20
> An attempt to try to support hotplug before CAS was made, but not
> successful. The key difference in the current code flow between a
> coldplugged and a hotplugged device, in the PRELAUNCH state, is that
> the coldplugged device is registered at the base FDT, allowing its
> DRC to go straight to CONFIGURED state. In theory, this can also be
> done with a hotplugged device if we can add it to the base of the
> existing FDT. However, tampering with the FDT after writing in the
> guest memory, besides being a dubitable idea, is also not
> possible. The FDT is written in ppc_spapr_reset and there is no
> way to retrieve it - we can calculate the fdt_address but the
> fdt_size isn't stored. Storing the fdt_size to allow for
> later retrieval is yet another state that would need to be
> migrated. In short, it is not worth the trouble.
>=20
> All this said, this patch opted to disable CPU/mem hotplug at early
> boot stages. CAS detection is made by checking if there are
> any bits set in ov5_cas to avoid adding an extra state that
> would need tracking/migration. The patch also makes sure that
> it doesn't interfere with hotplug in the INMIGRATE state.
>=20
> [1] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg05226.html
> [2] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01989.html
>=20
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

I don't think this is a good idea.

1) After my DRC cleanups, early hotplug works just fine for me.  I'm
not sure why it isn't for you: we need to understand that before
proceeding.

2) libvirt actually uses early hotplug fairly often (before even
starting the firmware).  At the moment this works - at least in some
cases (see above), though there are some wrinkles to work out.  This
will break it completely and require an entirely different approach to
fix again.

3) There's no fundamental reason early hotplug shouldn't work - the
event will just be queued until the OS boots and processes it.

I know I suggested disabling early hotplug earlier, but that was
before I'd dug into the DRC layer and properly understood what was
going on here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmVS0IACgkQbDjKyiDZ
s5I1mhAAi5sRqFK0Ae4R1aGKbBwNGq2JZi2ZcTx8pt1vKJ0+zKqXzMSl4tujeVAp
DE/QoLUVP8lBCMNcw/hugCSU00k6qcL7kYvRVrc43SMgKH1+x019op8r32Xr7+8Y
UhLKfjw89UZyT3DF+SDevRWh2ciRYt1YD2KTyTVd6S/dqmyg/Xj7ANrczHhQmTI4
37EW/872+KoqJ5mv2UsuPmGAXY3eb8lkpMO/xXpOVkVcALFGvBcdrbflBehz6nAc
ZI2RsKGa01rdpcEvMkWWOaZfVCYiHZgJTgDGAThGOFoitACUQDsQXSnUfeUDoufX
TTXXHLDcEjTqXEn2o7D/mcd1Ui2t1ScjuzoAcGXXrcgqUE1wj1X1S+Ag6NxSPS8L
Z/dMcyGeCvj1ASrNorvfuKs5OanifakOFSsXPRFRUkHLELNmg7zHGsflhboJJMvS
JiKgh9jBtGD8VyYf2C/lg5qnrkYAlOnEnHvUz1e2lP+tgvNFjUbwgeJexlOfBBfY
C0OyWdNf0UtSXKfsLIe+Cy1RY6i259z6BK+MTbHUcctSR/Uysw8Mz64JZGeg3inz
18rqXSJjI+HICjywJKFH4khrNdUJbwkbwchdYbCQADRu/VdTCY2t16zGndiOAAAd
ZJU1bGfMBpG59svFB9Qo9xAZiz5mo02vfSR8gM02aGHBNwLaPUE=
=N+JJ
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
