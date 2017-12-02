Received: from eggs.gnu.org ([2001:4830:134:3::10]:38073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8n7-0003nZ-So
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:29:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eL8n3-0005Yr-1H
	for qemu-devel@nongnu.org; Sat, 02 Dec 2017 09:29:17 -0500
Message-ID: <1512224930.2224.55.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 02 Dec 2017 08:28:50 -0600
In-Reply-To: <c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
	<c620afca-f6df-b3ed-8317-c805ec66b31b@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: "list@suse.de:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org

On Wed, 2017-11-29 at 17:23 +0100, C=C3=A9dric Le Goater wrote:
> On 11/29/2017 02:56 PM, C=C3=A9dric Le Goater wrote:
> > > > > > +    switch (offset) {
> > > > > > +    case 0:
> > > > > > +        spapr_xive_source_eoi(xive, lisn);
> > > > >=20
> > > > > Hrm.  I don't love that you're dealing with clearing that LSI b=
it
> > > > > here, but setting it at a different level.
> > > > >=20
> > > > > The state machines are doing my head in a bit, is there any way
> > > > > you could derive the STATUS_SENT bit from the PQ bits?
> > > >=20
> > > > Yes. I should.=20
> > > >=20
> > > > I am also lacking a guest driver to exercise these LSIs so I didn=
't
> > > > pay a lot of attention to level interrupts. Any idea ?
> > >=20
> > > How about an old-school emulated PCI device?  Maybe rtl8139?
> >=20
> > Perfect. The current model is working but I will see how I can=20
> > improve it to use the PQ bits instead.
>=20
> Using the PQ bits is simplifying the model but we still have to=20
> maintain an array to store the IRQ type.=20
>=20
> There are 3 unused bits in the IVE descriptor, bits[1-3]: =20
>=20
>   #define IVE_VALID       PPC_BIT(0)
>   #define IVE_EQ_BLOCK    PPC_BITMASK(4, 7)        /* Destination EQ bl=
ock# */
>   #define IVE_EQ_INDEX    PPC_BITMASK(8, 31)       /* Destination EQ in=
dex */
>   #define IVE_MASKED      PPC_BIT(32)              /* Masked */
>   #define IVE_EQ_DATA     PPC_BITMASK(33, 63)      /* Data written to t=
he EQ */
>=20
> We could hijack one of them to store the LSI type and get rid of=20
> the type array. Would you object to that ?=20

This won't work well if/when you implement a real HW XIVE.

Another option is to have different source objects for LSIs and MSIs.

Cheers,
Ben.
>=20
> C.
