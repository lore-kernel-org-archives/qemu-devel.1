Received: from eggs.gnu.org ([2001:4830:134:3::10]:47559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRSte-0001lI-3O
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 21:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRStZ-0001Fl-RG
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 21:14:42 -0500
Date: Tue, 27 Nov 2018 12:54:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181127015402.GM2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122041119.GD10448@umbus.fritz.box>
	<5e4a0824-a014-c0c3-89f5-40aab83268f9@kaod.org>
	<20181123035036.GW10448@umbus.fritz.box>
	<31b6201b-420a-8560-19bd-8eab9dd2f3de@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HVCoas+krw6dou6l"
Content-Disposition: inline
In-Reply-To: <31b6201b-420a-8560-19bd-8eab9dd2f3de@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 04/36] ppc/xive: introduce the
 XiveRouter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--HVCoas+krw6dou6l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 09:06:07AM +0100, C=E9dric Le Goater wrote:
> On 11/23/18 4:50 AM, David Gibson wrote:
> > On Thu, Nov 22, 2018 at 08:53:00AM +0100, C=E9dric Le Goater wrote:
> >> On 11/22/18 5:11 AM, David Gibson wrote:
> >>> On Fri, Nov 16, 2018 at 11:56:57AM +0100, C=E9dric Le Goater
> wrote:
[snip]
> >>> So as far as I can see so far, the XiveFabric interface will
> >>> essentially have to be implemented on the router object, so I'm not
> >>> seeing much point to having the interface rather than just a direct
> >>> call on the router object.  But I haven't read the whole series yet,
> >>> so maybe I'm missing something.
> >>
> >> The PSIHB and PHB4 models are using it but there are not in the series.
> >>
> >> I can send the PSIHB patch in the next version if you like, it's the=
=20
> >> patch right after PnvXive. It's attached below for the moment. Look at=
=20
> >> pnv_psi_notify().
> >=20
> > Hrm, I see.  This seems like a really convoluted way of achieving what
> > you need here.  We want to abstract exactly how the source delivers
> > notifies,=20
>=20
> on sPAPR, I agree that the forwarding of event notification could be a=20
> simple XiveRouter call but the XiveRouter covers both machines :/
>=20
> On PowerNV, HW uses MMIOs to forward events and only the device knows=20
> about the IRQ number offset in the global IRQ number space and the=20
> notification port to use for the MMIO store. A PowerNV XIVE source=20
> would forward the event notification to a piece of logic which sends=20
> a PowerBUS event notification message. How it reaches the XIVE IC is
> beyong QEMU as it would means modeling the PowerBUS.=20
>=20
> > but doing it with an interface on some object that's not necessarily
> > either the source or the router seems odd. =20
> There is no direct link between the device owing the source and the=20
> XIVE controller, they could be on the same Power chip but the routing=20
> could be done by some other chips. This scenario is covered btw.
>=20
> See it as a connector object.
>=20
> > At the very least the names need to change (of both interface and > pro=
perty for the target object).
>=20
> I am fine with renaming it. With the above explanations, if they are=20
> clear enough, how do see them ?

TBH, I didn't find the info above particularly illuminating.  However,
I think perusing the code has finally gotten my head around the model
(sorry it's taken so long).  I think two things were confusing me.

1) The name had be thinking in terms of the XicsFabric, but the
function here is totally different.

2) I was thinking of the XiveSource as handling all source-side irq
related logic, but I guess it's real function is a bit more limited.
As I now understand it, it's only really handling the ESB and
immediately surrounding logic - the "owning" device (e.g. PHB or PSI)
is responsible for the connection "up the stack" as it were.

So, I'm ok with the model.  Just to verify that my understanding is
correct, can you confirm my reasoning below:

  * For PowerNV, we'd generally expect the notify function to be
    implemented by the "owning" device.  For the XIVE internal source,
    that would be the XiveRouter itself, immediately triggering the
    right EAS.  For the PHB and PSI irq sources, that will code in the
    PHB/PSI which performs the MMIO to poke a router.

  * For PAPR, for simplicity, we'd expect to wire all sources direct
    to a single system-wide router object.

I definitely think it needs a name change though.  "XiveNotify"
perhaps?  And the property to configure it on the XiveSource, maybe
"notify" or "notify_via".

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HVCoas+krw6dou6l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv8o7gACgkQbDjKyiDZ
s5KG2A/9GpwZwRxozy1c1EyWqfShVvA7XLoNgUxOFahhX0eB8wEJUo/TPdj9VSaD
4OvWLAiYfBRC3Uy6yApxx3FVC5dlBL+ycyvu/Ns7nFw11XlCQtyk+vHRsYQKjtsD
GnkUKzrNnImN6xhemhQgLe1NaYRhmAfAHnQSw6cS++F4zKaBzgsyHVmGOt6tUH7l
cvWw8QVy9ye4M66IrfhYK35d0LigfM98SM+0S7P2CYO18UdrQS3HSjsTmn/WmQ6S
yrKnGDinRZawmBsCKeN+ghSIPgzVNJdqhZkAq1a0mJMY5RE8HRQhJLuDeojQE7B2
XaPFRz0oYjrqGZckEil98lRKbKuLB8N1UZXdnY9un4/WHXn3zKS791Ax5zL+fkku
Swqnv2WAdLwi3ef8x6wtEoehGVwBF4Zrq1ZEpqehgRlIcGW9m24Qj4wCR2KyP0UF
0NfKTkM3Hpdk8TI5iO4z99GqFlO1jrSmGYA7ROtDBVYqYTIUWF2uqYG8Mi7g02/U
7xmODLLcQXG1ug0raOSaKwbXcw0owM+biw/1TUAX8ro2+O2HvDlAt4yoFXbZ2QMy
5m2j7DJz83IDaQubeiF6CdrWCAqaklcCmA1Qm08LDWFfEy5FZe37bVBQVTu6dX6k
3kZUWmcDb83ySOVFDnRkJ2ouDGsRw4rybAkbExpi5PyfMy/WsPQ=
=6LKy
-----END PGP SIGNATURE-----

--HVCoas+krw6dou6l--
