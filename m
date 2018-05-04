Received: from eggs.gnu.org ([2001:4830:134:3::10]:58361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEShR-0004W3-R2
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:52:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEShQ-0002dG-At
	for qemu-devel@nongnu.org; Fri, 04 May 2018 00:52:05 -0400
Date: Fri, 4 May 2018 14:44:16 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504044416.GS13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
	<20180503053944.GS13229@umbus.fritz.box>
	<e1ab26c9-013f-c645-c89f-dbd36f139d0e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zGX6P/PxmcOG18lb"
Content-Disposition: inline
In-Reply-To: <e1ab26c9-013f-c645-c89f-dbd36f139d0e@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 06/35] spapr/xive: introduce a XIVE
 interrupt presenter model
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


--zGX6P/PxmcOG18lb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 05:10:48PM +0200, C=E9dric Le Goater wrote:
> On 05/03/2018 07:39 AM, David Gibson wrote:
> > On Thu, Apr 26, 2018 at 07:15:29PM +0200, C=E9dric Le Goater wrote:
> >> On 04/26/2018 11:27 AM, C=E9dric Le Goater wrote:
> >>> On 04/26/2018 09:11 AM, David Gibson wrote:
> >>>> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
> > [snip]
> >>>>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
> >>>>> +                                   uint64_t value, unsigned size)
> >>>>> +{
> >>>>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >>>>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
> >>>>> +    int i;
> >>>>> +
> >>>>> +    if (offset >=3D TM_SPC_ACK_EBB) {
> >>>>> +        xive_tm_write_special(nvt, offset, value, size);
> >>>>> +        return;
> >>>>> +    }
> >>>>> +
> >>>>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
> >>>>
> >>>> Why have this if you have separate OS and user regions as you appear
> >>>> to do below?
> >>>
> >>> This is another problem we are trying to solve.=20
> >>>
> >>> The registers a CPU can access depends on the TIMA view it is using.=
=20
> >>> The OS TIMA view only sees the OS ring registers. The HV view sees al=
l.=20
> >>
> >> So, I gave a deeper look at the specs and I understood a little more=
=20
> >> details of the concepts behind. You need to do frequent round-trips=20
> >> to this document ... =20
> >>
> >> These registers are accessible through four aligned pages, each exposi=
ng=20
> >> a different view of the registers. First page (page address ending=20
> >> in 0b00) gives access to the entire context and is reserved for the=20
> >> ring 0 security monitor. The second (page address ending in 0b01)=20
> >> is for the hypervisor, ring 1. The third (page address ending in 0b10)=
=20
> >> is for the operating system, ring 2. The fourth (page address ending=
=20
> >> in 0b11) is for user level, ring 3.
> >>
> >> The sPAPR machine runs at the OS privilege and therefore can only=20
> >> accesses the OS and the User rings, 2 and 3. The others are for
> >> hypervisor levels.
> >=20
> > Ok, that much is what I thought.  What I'm less clear on is what each
> > page looks like compared to the others.  Previously I thought each one
> > had the same registers,=20
>=20
> yes.
>=20
> > just manipulating the corresponding ring. =20
>=20
> no.=20
>=20
> > Are you saying instead that each ring's page basically has a subset=20
> > of the registers in the next most privileged page?
>=20
> That's the idea.=20

Ah, ok.

> The registers are defined as follow :
>=20
> 	QW-0 User     =20
> 	QW-1 O/S     =20
> 	QW-2 Pool  =20
> 	QW-3 Physical=20
>=20
> and the pages :
>=20
> - 0006030203180000 security monitor=20
>   can access all registers=20
>=20
> - 0006030203190000 hv
>   can access all registers minus the secure regs
>=20
> - 00060302031a0000 os
>   can access some of the OS (QW1) and User (QW0) registers
> =20
> - 00060302031b0000 user
>   can access NSR reg of User (QW0) registers

I can see two reasonable ways of doing this:

A)

Have a single set of read/write functions.  These implement all the
registers but take a "privilege level" parameter which controls which
will actually work.  Those could then be wired up in one of two ways:

  A1) Single memory region.  The accessor derives the priv level from
  the relevant address bits, before masking it down to a single
  register page.  Then, as above

  A2) Multiple memory regions with the same accessor functions but
  different opaque pointer.  The accessor gets the priv level from
  its opaque pointer, then the address is just within a single ring's
  page.

B)

Separate memory regions with separate accessors.  The ring-0 accessor
implements the ring-0 registers, then calls the ring-1 accessor
function for everything else.  ring-1 calls ring-2 and so forth.

> On sPAPR, we can remap the os/user pages to some other base address=20
> but we should keep the same page offset.

Sure.

>=20
>=20
> >> I will try to come with a better implementation of the model and
> >> make sure the ring numbers are respected. I am not sure we should=20
> >> have only one memory region or four distinct ones with their
> >> own ops. There are some differences in the load/store of each view.
> >=20
> > Right.  I'm not clear at this point if that's for good reasons, or
> > just because IBM's hardware designers don't seem to have gotten the
> > hang of Don't Repeat Yourself.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zGX6P/PxmcOG18lb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrr5R0ACgkQbDjKyiDZ
s5L7rBAAwMTox1D81dqTeP0MHRps4DqC/ZQiUdpydyhIeocQwsaKZQhx5/RPlacf
SMwxR0hbvKNpiYxSwli855vqzI8fQNUgZYLzJI3IMWhlaHP7HVbWM0BuW69+jA5U
IpC1I+B4uByW+bVYRC+CWVY1QlRvliWnzW9k/ZGozR9bTRWs1pD6q945eTIU62+i
DY53G/SE2x4wBxHQL1nHRtfo8HbNJOH8+7lSdu1Lntsa05IjxMAfMCIDOfHE+eeq
D/lIF2+xOhJtJF/tRRNRBKphfdY5iERgUY2J56dXefCcFruBv2rRe0R68BLWvXJ2
I6VIhpQSKfaJbdC45c3KVp7hk+z7qRXyqo/TA7Z6acShJQ8KvamJKQkwgahgTibl
nuFiDs8/ep2c9+d/jCsk/HzBj01lPpD38sA3Jote6uPL2//0WFCHoY1YXJPMvfOv
PztTCkYsXeMSQfHuI+hKcP2lWiqL/I6o2JHcWAaMUwMdWwITjImmGigD9PAPzSXX
UmW/M6SAIT36yim4GVNAOjXEWS+FpYBk0/KgswcaBIvslbhdp5xpXEZEvFqh1rxq
ScG56ALhuEbE+XsckAgDbsMtsWWM6TB52rX4HA6uX9aAJgWMKguQF9uCqarFCfpE
cmhl1HRPDpPYp2NxfOwkZ474ygYEDzGp+pVjouK/3ZhvPyEUANw=
=UOB/
-----END PGP SIGNATURE-----

--zGX6P/PxmcOG18lb--
