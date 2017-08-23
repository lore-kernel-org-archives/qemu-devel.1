Received: from eggs.gnu.org ([2001:4830:134:3::10]:58113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJuy-0007Hv-06
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJuu-0000Nv-17
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:53:12 -0400
Date: Wed, 23 Aug 2017 10:52:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170823005234.GJ5379@umbus.fritz.box>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<1815e11378b48532e902e0138a58557c297c3eb2.1503249785.git.balaton@eik.bme.hu>
	<088c08f0-d4cd-e1c2-6715-3aeb33b7f4b9@redhat.com>
	<alpine.BSF.2.21.1708221158550.67133@zero.eik.bme.hu>
	<af0775b0-401b-81a6-7178-40e32680dc01@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wHh0aNzodMFDTGdO"
Content-Disposition: inline
In-Reply-To: <af0775b0-401b-81a6-7178-40e32680dc01@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/15] hw/ide: Emulate SiI3112 SATA
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>


--wHh0aNzodMFDTGdO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 22, 2017 at 03:01:18PM -0400, John Snow wrote:
>=20
>=20
> On 08/22/2017 07:08 AM, BALATON Zoltan wrote:
> > Hello,
> >=20
> > Thanks for the review.
> >=20
> > On Mon, 21 Aug 2017, John Snow wrote:
> >> On 08/20/2017 01:23 PM, BALATON Zoltan wrote:
> >>> This is a common generic PCI SATA conroller that is also used in PCs
> >>> but more importantly guests running on the Sam460ex board prefer this
> >>> card and have a driver for it (unlike for other SATA controllers
> >>> already emulated).
> >>
> >> Oh, interesting. This is basically an alternative to the PCI BMDMA
> >> interface and not really an alternative to AHCI. It doesn't really seem
> >=20
> > Yes, this is a simple PCI SATA interface similar to IDE and not like
> > AHCI. I think it's an updated version of the CMD640 IDE interface or
> > more closely related to that. The Linux driver references CMD680 as well
> > so it's probably a SATA version of that chip.
> >=20
> >> to use any of the SATA-specific interfaces to SATA drives (cough, not
> >> that we currently emulate a difference in QEMU... ATA and SATA both are
> >> simply IDEState*) so this really seems like another PCI IDE interface
> >> akin to the PCI BMDMA adapter we already have.
> >>
> >> It's just that guests will think they're using SATA, except... not. Not
> >> a big deal, *I think*...
> >>
> >> ...It isn't a problem that our support for NCQ commands is tied to AHC=
I,
> >> is it? Some of our current "SATA" support is tied very directly to AHCI
> >> (see is_ncq() in ahci.c) -- is that relevant here?
> >=20
> > I don't think any of the clients on Sam460ex tries to use NCQ so maybe
> > it's OK. Linux might have a better driver but I'm not sure. This could
> > be fixed later. Although I've seen a hang in Linux which I haven't
> > debugged yet and don't know what causes it or if it's related to SATA at
> > all.
> >=20
> > I'm not sure I've implemented everything correctly but at least the
> > firmware of the board can find disks and load files to boot OSes so
> > basic functions should be working. There are some other bugs elsewhere
> > which prevent me from testing more OSes at the moment. One of them is
> > QEMU crashing sometimes while accessing this SATA controller but it's
> > triggered from TCG generated code and depends on some timing because it
> > goes away if I change code running in the client or add some debug logs.
> > This is described here:
> >=20
>=20
> "Elsewhere" as in "Not seemingly related to this controller," it seems.
>=20
> > http://lists.nongnu.org/archive/html/qemu-ppc/2017-08/msg00249.html
> >=20
> > You don't happen to have an idea or seen similar before, do you? (Likely
> > it's not related to IDE but more likely some io memory region
> > interaction with TCG.)
> >=20
>=20
> Sorry, the traces look foreign to me.
>=20
> > I intend to improve this device model later when found necessary but I
> > don't have much free time for it now so I'd like to submit it now to get
> > some more testing and maybe contributions from others.
> >=20
>=20
> Sure, but be advised that if the device causes problems outside of this
> use case and there's nobody willing or able to review it, that it may
> get removed again.
>=20
> I don't have a lot of free time to go through the register list point by
> point and make sure this is implemented correctly either, but if this
> helps your work I'm OK not holding it up.

That's been pretty much my view on most of this.  I have neither the
at-hand knowledge of the hardware, nor time to look it up to give a
detailed review.  But if it's replacing a complete lack of support and
there's nothing obviously bogus, seems reasonable to let it in.

Jon, do you want me to queue this driver in my tree (for 2.11,
obviously), or do you want to take it through another tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wHh0aNzodMFDTGdO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmc0dIACgkQbDjKyiDZ
s5LQaBAArNpTaztuICjd5e+HZqNDi6lA4jGqbjGvzSvRrxItmjJp+dY7aOmObjl2
6f63czPeSYeSZg6iL78q5PiEZ6H0Y/TPmfNQBAknvrWIPMO6z5xLsdlS62WKkBsQ
OW58Wo3AEA8ko84q2reo/FbZ8lQal9XS5+S+dmwkJqAxtWgwF03PXgmd5vWzshTe
6ZBS/XUH2L/itvT94xsKseDi13eIyw6hcThUWQF6zezEiV85EGe0zJVNxirT4aBi
3ZZIk+ime14+VQL43gZ90TOkCDeJenyrH4PQocFwBOY/lFRyifTD30+yEq4DSq14
HhY3yaKC9EeCp4LCPXCoPhGkeOUUovhc5S1IuDi+eVFt8SRtwbDKfKC7aJ4Ab9+5
BKXe+L78ATl2hfrJnlUCLWj0gcDaTblCu8dDQBHinsj1T2pZ9/15ullZy9zZndYH
dRmk3WQUZgM1Y1irZ2V5/a31g64BveWo/Hf9cHyCICfMm8ziTBtZPP/Uc3G2DQFD
gsBHPc1uVeQA4tVV6o7uCIPm7SQlncy3vfF0h7JaFlEvRU823l3IezhB9ZIzykJM
bgy5FQ96Mo3nB7vYKO7uF5sUyq7eHrDzBBZqz7HULXscZLiHFn5B/aEwDW9CnK7Q
CBnS+Vq9C+AwMTa10rh/fpBldbXuSeDQ1Jxzneo88Emw0wTk8H8=
=MNqP
-----END PGP SIGNATURE-----

--wHh0aNzodMFDTGdO--
