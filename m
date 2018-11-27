Received: from eggs.gnu.org ([2001:4830:134:3::10]:35469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRaTo-0004tp-2s
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:20:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRaTl-0004qM-UA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 05:20:32 -0500
Date: Tue, 27 Nov 2018 16:07:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181127050736.GN2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-8-clg@kaod.org>
	<20181123050858.GA10448@umbus.fritz.box>
	<8f6de3b8-b1df-f5e6-cfd8-aeca93a521b6@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Content-Disposition: inline
In-Reply-To: <8f6de3b8-b1df-f5e6-cfd8-aeca93a521b6@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 07/36] ppc/xive: introduce the XIVE
 interrupt thread context
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


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 25, 2018 at 09:35:08PM +0100, C=E9dric Le Goater wrote:
> On 11/23/18 6:08 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:57:00AM +0100, C=E9dric Le Goater wrote:
> >> Each POWER9 processor chip has a XIVE presenter that can generate four
> >> different exceptions to its threads:
> >>
> >>   - hypervisor exception,
> >>   - O/S exception
> >>   - Event-Based Branch (EBB)
> >>   - msgsnd (doorbell).
> >>
> >> Each exception has a state independent from the others called a Thread
> >> Interrupt Management context. This context is a set of registers which
> >> lets the thread handle priority management and interrupt acknowledgment
> >> among other things. The most important ones being :
> >>
> >>   - Interrupt Priority Register  (PIPR)
> >>   - Interrupt Pending Buffer     (IPB)
> >>   - Current Processor Priority   (CPPR)
> >>   - Notification Source Register (NSR)
> >>
> >> These registers are accessible through a specific MMIO region, called
> >> the Thread Interrupt Management Area (TIMA), four aligned pages, each
> >> exposing a different view of the registers. First page (page address
> >> ending in 0b00) gives access to the entire context and is reserved for
> >> the ring 0 security monitor. The second (page address ending in 0b01)
> >> is for the hypervisor, ring 1. The third (page address ending in 0b10)
> >> is for the operating system, ring 2. The fourth (page address ending
> >> in 0b11) is for user level, ring 3.
> >>
> >> The thread interrupt context is modeled with a XiveTCTX object
> >> containing the values of the different exception registers. The TIMA
> >> region is mapped at the same address for each CPU.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/xive.h      |  36 +++
> >>  include/hw/ppc/xive_regs.h |  82 +++++++
> >>  hw/intc/xive.c             | 443 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 561 insertions(+)
> >>
> >> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> >> index 24301bf2076d..5987f26ddb98 100644
> >> --- a/include/hw/ppc/xive.h
> >> +++ b/include/hw/ppc/xive.h
> >> @@ -238,4 +238,40 @@ typedef struct XiveENDSource {
> >>  void xive_end_reset(XiveEND *end);
> >>  void xive_end_pic_print_info(XiveEND *end, uint32_t end_idx, Monitor =
*mon);
> >> =20
> >> +/*
> >> + * XIVE Thread interrupt Management (TM) context
> >> + */
> >> +
> >> +#define TYPE_XIVE_TCTX "xive-tctx"
> >> +#define XIVE_TCTX(obj) OBJECT_CHECK(XiveTCTX, (obj), TYPE_XIVE_TCTX)
> >> +
> >> +/*
> >> + * XIVE Thread interrupt Management register rings :
> >> + *
> >> + *   QW-0  User       event-based exception state
> >> + *   QW-1  O/S        OS context for priority management, interrupt a=
cks
> >> + *   QW-2  Pool       hypervisor context for virtual processor being =
dispatched
> >> + *   QW-3  Physical   for the security monitor to manage the entire c=
ontext
> >=20
> > That last description is misleading, AIUI the hypervisor can and does
> > make use of the physical ring as well as the pool ring.
>=20
> yes. The description is from the spec. I will rephrase.=20
>=20
> >=20
> >> + */
> >> +#define TM_RING_COUNT           4
> >> +#define TM_RING_SIZE            0x10
> >> +
> >> +typedef struct XiveTCTX {
> >> +    DeviceState parent_obj;
> >> +
> >> +    CPUState    *cs;
> >> +    qemu_irq    output;
> >> +
> >> +    uint8_t     regs[TM_RING_COUNT * TM_RING_SIZE];
> >=20
> > I'm a bit dubious about representing the state with a full buffer like
> > this.  Isn't a fair bit of this space reserved or derived values which
> > aren't backed by real state?
>=20
> Under sPAPR only the TM_QW1_OS ring is accessed but the TM_QW0_USER=20
> will also be when we support EBB.
>=20
> When running under the PowerNV machine, all rings could be accessed.
> Today only 2 and 3 are.

It's not the fact that all rings are exposed that I'm talking about.
What I mean is that some of the logical register address space isn't
actually by actually modifiable registers.  For example the HW CAM
bits are hardwired to a value which can be derived from elsewhere.
Likewise the "highest pending priority" register or whatever it's
called is AFAICT calculated on read from the CPPR and IPB.

So the thing I'm questioning is having actual storage bytes associated
with logical registers which are actually derived from other state.

> It seemed correct to expose all registers under the thread interrupt
> context model and filter the accesses with the TIMA. It fits the HW
> well.

> >> +
> >> +    XiveRouter  *xrtr;
> >=20
> > What's this for?  AFAIK a TCTX isn't associated with a particular
> > routing unit.
>=20
> I should have added the pointer in patch 11 where it is used. This is=20
> to let the sPAPR XIVE controller model reset the OS CAM line with the=20
> VP identifier.

> The TCTX belong to the IVPE XIVE subengine and as the IVRE and IVPE are=
=20
> modeled under the XiveRouter, it's not suprising to see this '*xrtr'=20
> back pointer. But I agree we might not need.  Let's talk about it when=20
> you reach patch 11.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv80RYACgkQbDjKyiDZ
s5LXMxAAqAwal56hycPrdpD9Mtbzdq2lybkOBqPSdyKb7NofhERxFCTjPqTOK5ti
V1fwTS57957FZ4jECuj2WxqvEYGdT1EUfVZEG3ffsFMDnsDrmmlhtxjzcKFsLi0n
40jmM2xXwQzl6AL0N2xCWnpA0RkZedXpnjPKpE/CNp2hMVkcXbucFavQBd7kIYnV
ceQA8CDrgzoRQc9bzBWydiU80qgDrS9yEvq4XGNxwAJADSgvNhoimJ92tO6EotRU
UEzv14Hmi5jLOEdRg5ESJE8uKQ1UoK8BnFXS70FAIkQbxst4zskTmKWBukQYWGOz
qYlpnM2sCOrlR0pA49IuszvmD2QAU+BG9MxYyXLuUal/4md0JZSVaqdotpSuQXqr
IW//QtHGBJCE49n5L8YPYn2CKX73jiLdRPIORhx0JRunJhSSPaKiXJ6fGJbMuNEQ
5CWdZ4doGEMEJT/aL+YkpTDDk0VIQK5EBtt4b1pbmuTe0fw3H070DdQnlDKz+yZj
phtHFwo3xgH98kqVYKe5+e840AQdirSUlQOWvWVTTu9SAZM5hf9a/KqTHrXRPv9R
wjss1ro7x6Rk6VKW8KUQLfJutzTZHO/op95VKay1qRaKvLXt2bdevV0Wobh8GWWM
3/TkqPWezbARdrQEsJ3RQt8ajoeOBuiF9RhCf4c4ayDkvq+imhA=
=+je3
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
