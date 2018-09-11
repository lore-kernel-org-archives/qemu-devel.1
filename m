Received: from eggs.gnu.org ([2001:4830:134:3::10]:44171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzY17-00026a-1g
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 22:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fzXrP-0007dj-4J
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 21:53:02 -0400
Date: Tue, 11 Sep 2018 11:52:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180911015246.GH7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910170253.50f4cd88@bahia.lan>
	<90b8c81e-bd7b-8516-7e27-69d77ba59b72@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
In-Reply-To: <90b8c81e-bd7b-8516-7e27-69d77ba59b72@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: introduce a new sPAPRIrq backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 10, 2018 at 07:24:47PM +0200, C=E9dric Le Goater wrote:
> On 09/10/2018 05:02 PM, Greg Kurz wrote:
> > On Mon, 10 Sep 2018 13:02:19 +0200
> > C=E9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> Hello,
> >>
> >> This series adds a new sPAPRIrq backend increasing the number of
> >> available IRQ numbers in pseries-3.1 machines. This change is an
> >> opportunity to also fix the "ibm,pe-total-#msi" and remove the old
> >> XICS_IRQS_SPAPR definition.
> >>
> >=20
> > This cleanup looks sane but I still have a concern with the semantics of
> > "ibm,pe-total-#msi".
> >=20
> > According to LoPAPR:
> >=20
> > "ibm,pe-total-#msi"
> >=20
> > property name defines the maximum number of Message Signaled Interrupts=
 (MSI plus MSI-X) that are available
> > to the PE below this device tree node. This number only indicates the n=
umber of available interrupts, not the num-
> > ber assigned. The number assigned for an IOA may be obtained by Functio=
n 0 (Query only) of the ibm,change-msi
> > RTAS call.
> > prop-encoded-array: Maximum number of interrupts encoded as with encode=
-int.
> >=20
> > IIUC, the PHB is given ibm,pe-total-#msi MSIs that it can assign to dev=
ices.
> >=20
> > But we currently have only one global allocator in the machine, so havi=
ng
> > each PHB advertising the full range of the allocator still looks weird.
>=20
> yes. Multiple PHBs share the same IRQ number space and in this
> case the advertised number "ibm,pe-total-#msi" does not reflect=20
> the maximum number of allocatable interrupts per PHB.
>=20
> The patch improves only the value for one PHB and, as of today,=20
> it is still wrong when Multiple PHBs are involved.
>=20
> > Shouldn't this be divided by the number of PHBs ? Or should we have one
> > separate allocator for each PHB ?
>=20
> That would mean segmenting the IRQ number space and I am not=20
> fond of this solution because we have plenty of space to share:
>=20
> 	0xd00 MSIs
>=20
> When we find a scenario reaching this limit, I think what we=20
> should do is to dynamically extend the IRQ number space in QEMU=20
> and in KVM. It should not be a problem.
>=20
> We could also downsize "ibm,pe-total-#msi". It is quite big
> today. some controllers do have a lot of IRQs but no more=20
> that a hundred. I might be wrong.

Yeah, this is my take as well.  The spec sort of implies, but doesn't
explicitly state a per-PHB allocation of MSIs.  But there's not really
a good reason to partition the irqs that way.  So it may be a bit fast
and loose w.r.t. PAPR, but as long as we have plenty of MSIs available
I think using a shared pool is unlikely to cause problems in practice.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluXH+4ACgkQbDjKyiDZ
s5KXoxAAvM+Ebj+7NrQzkWZapA3TwMLf9JRlU3VbaYwa9UHAGAHHbtl1RWth120p
SmprLoYeJuPIgmi+gRSxhIkQwRtZ//OpPRMhYprdCOpzUjpib23LlPgrlz/C1tIh
wh43hwNdLkRROQ937KxyJExeULr8CINqGaIoOEN7U4KNK5fCqPhexyv3uDERu+En
Zccf311g2mevkM7dSf3FooWjSVP8hBVZh1y8SMngGU7dONREPos+aKY8b3SPNQCG
DDEuA0pzZN5q14aYUlrlHZJpWKZ1PrKpGRNIvkSaTMkuCQ9AnOOr3wd0rwvKr+4z
MA/YgP3yKKgvGeCVCaj95YG7hCGaAGa/lXQFhVHnQEdQ/hIR4vOhWSs5/HFDqwpD
4VAv/DBtXll3xWvefCRFAmFJtOgTHFdR/y5LPCfAtTatMSGqVTs+ajX79v8FVSgL
kDqwznHDuKAN1sooJjLUNJbBsf51IFbowpZ5o8egQRlu3DFWXkpl7GN8JMa2Vkmz
y+2TmXtg3/DZ9JVdb1R9prmwljABlCJqOH2l6q5hKIrePmkEtBZUbHorXlcs6g7a
9HocEYlWn82eCNvlPwUTDzJJq1tSItCrA1/kfcySzk9h/aIA7ORJYrsOTpI6VVRQ
v1FNzne57lJ9AJMMLM4hJf5WKU/plIo/MtgRtCaVMmudBZXS7l0=
=TwrB
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
