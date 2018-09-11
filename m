Received: from eggs.gnu.org ([2001:4830:134:3::10]:51231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzd0I-0006BV-B8
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fzd0F-0005z4-MG
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:22:30 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fzd0F-0005yH-Dz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 03:22:27 -0400
Received: from player738.ha.ovh.net (unknown [10.109.143.189])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id E7D1FF8B3C
	for <qemu-devel@nongnu.org>; Tue, 11 Sep 2018 09:22:24 +0200 (CEST)
Date: Tue, 11 Sep 2018 09:22:18 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180911092218.7987b688@bahia.lan>
In-Reply-To: <20180911015246.GH7978@umbus.fritz.box>
References: <20180910110222.8162-1-clg@kaod.org>
	<20180910170253.50f4cd88@bahia.lan>
	<90b8c81e-bd7b-8516-7e27-69d77ba59b72@kaod.org>
	<20180911015246.GH7978@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/KMWUtZc.aevo+2_wW3k/etB";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/3] spapr: introduce a new sPAPRIrq backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/KMWUtZc.aevo+2_wW3k/etB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Sep 2018 11:52:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Sep 10, 2018 at 07:24:47PM +0200, C=C3=A9dric Le Goater wrote:
> > On 09/10/2018 05:02 PM, Greg Kurz wrote: =20
> > > On Mon, 10 Sep 2018 13:02:19 +0200
> > > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> > >  =20
> > >> Hello,
> > >>
> > >> This series adds a new sPAPRIrq backend increasing the number of
> > >> available IRQ numbers in pseries-3.1 machines. This change is an
> > >> opportunity to also fix the "ibm,pe-total-#msi" and remove the old
> > >> XICS_IRQS_SPAPR definition.
> > >> =20
> > >=20
> > > This cleanup looks sane but I still have a concern with the semantics=
 of
> > > "ibm,pe-total-#msi".
> > >=20
> > > According to LoPAPR:
> > >=20
> > > "ibm,pe-total-#msi"
> > >=20
> > > property name defines the maximum number of Message Signaled Interrup=
ts (MSI plus MSI-X) that are available
> > > to the PE below this device tree node. This number only indicates the=
 number of available interrupts, not the num-
> > > ber assigned. The number assigned for an IOA may be obtained by Funct=
ion 0 (Query only) of the ibm,change-msi
> > > RTAS call.
> > > prop-encoded-array: Maximum number of interrupts encoded as with enco=
de-int.
> > >=20
> > > IIUC, the PHB is given ibm,pe-total-#msi MSIs that it can assign to d=
evices.
> > >=20
> > > But we currently have only one global allocator in the machine, so ha=
ving
> > > each PHB advertising the full range of the allocator still looks weir=
d. =20
> >=20
> > yes. Multiple PHBs share the same IRQ number space and in this
> > case the advertised number "ibm,pe-total-#msi" does not reflect=20
> > the maximum number of allocatable interrupts per PHB.
> >=20
> > The patch improves only the value for one PHB and, as of today,=20
> > it is still wrong when Multiple PHBs are involved.
> >  =20
> > > Shouldn't this be divided by the number of PHBs ? Or should we have o=
ne
> > > separate allocator for each PHB ? =20
> >=20
> > That would mean segmenting the IRQ number space and I am not=20
> > fond of this solution because we have plenty of space to share:
> >=20
> > 	0xd00 MSIs
> >=20
> > When we find a scenario reaching this limit, I think what we=20
> > should do is to dynamically extend the IRQ number space in QEMU=20
> > and in KVM. It should not be a problem.
> >=20
> > We could also downsize "ibm,pe-total-#msi". It is quite big
> > today. some controllers do have a lot of IRQs but no more=20
> > that a hundred. I might be wrong. =20
>=20
> Yeah, this is my take as well.  The spec sort of implies, but doesn't
> explicitly state a per-PHB allocation of MSIs.  But there's not really
> a good reason to partition the irqs that way.  So it may be a bit fast
> and loose w.r.t. PAPR, but as long as we have plenty of MSIs available
> I think using a shared pool is unlikely to cause problems in practice.
>=20

Fair enough. Thanks for the clarification.

Cheers,

--
Greg

--Sig_/KMWUtZc.aevo+2_wW3k/etB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAluXbSoACgkQcdTV5YIv
c9b9Nw//ZIBGJ0JRoOFSE/uqHAugT5DCvM3IY6KktxxBUkQTjeGR4ONWJKx0sl60
lsZsCQSu8vT0hIqUbxJcrzT6fmtOF4fuOLwAVvyVYZH0mPY5slvm3u8ke/YfGv5a
d4KdgNZzH/Vs5nsXPpzoVE2fgaDCE0HRa8EDLZ3wkTOgb3n/qF9CQr8PXJDGZps3
YgoVjGazqb2GyolnUKR6BhhW9lRG6xVBKtI1Y2b3SBZAKylu4sa1O7jqqF+5mVx3
r7aV+cw5cx/e3NPzrQbLp9Q0R2qrq0l7pMKcdsdRWR6krpaoh5bFuih2sDYzSxPy
sJpFTsCCOtwZvfKXS+gEhQI0jmTq5dHIYWmphE5IDfObiOlhEIpNMH/SXJvP8hhz
B4vbOaY2xXdZOye6reR+/++tjrnldwNRsyZP1d+CdSLgKK616zYBP6lYTEv5f2WE
REKeXU5IvnhnWZYWkHGNbb6ythVmueQXwPXxmzhtaeATZI+/jQbB9pl/9WaulMks
+HxJH5XuqRec/z1Mav1X5SsxYUHLWewgcLWmAgLGTeqERZJvzPJuHLRLUVV1o9qE
F5djpGDe/9fOX/HMfuiujiJHTeE4yovdYo/aui+VxZAhwnyboABXkFEhlXdsd1XR
cvIBVJCEOlUdUDyiZ+a/qBc9d9Ik2k6XKBFBprdB+rWZUFc/QKQ=
=l9MZ
-----END PGP SIGNATURE-----

--Sig_/KMWUtZc.aevo+2_wW3k/etB--
