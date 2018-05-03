Received: from eggs.gnu.org ([2001:4830:134:3::10]:33646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE72T-0003SI-Gv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fE72Q-0000cy-Be
	for qemu-devel@nongnu.org; Thu, 03 May 2018 01:44:21 -0400
Date: Thu, 3 May 2018 15:39:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180503053944.GS13229@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-7-clg@kaod.org>
	<20180426071129.GJ8800@umbus.fritz.box>
	<9273a240-6518-155f-ed78-79abe53761e3@kaod.org>
	<4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kVhvBuyIzNBvw9vr"
Content-Disposition: inline
In-Reply-To: <4e3ece34-2373-c887-affe-f793b585599a@kaod.org>
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


--kVhvBuyIzNBvw9vr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 07:15:29PM +0200, C=E9dric Le Goater wrote:
> On 04/26/2018 11:27 AM, C=E9dric Le Goater wrote:
> > On 04/26/2018 09:11 AM, David Gibson wrote:
> >> On Thu, Apr 19, 2018 at 02:43:02PM +0200, C=E9dric Le Goater wrote:
[snip]
> >>> +static void xive_tm_os_write(void *opaque, hwaddr offset,
> >>> +                                   uint64_t value, unsigned size)
> >>> +{
> >>> +    PowerPCCPU *cpu =3D POWERPC_CPU(current_cpu);
> >>> +    XiveNVT *nvt =3D XIVE_NVT(cpu->intc);
> >>> +    int i;
> >>> +
> >>> +    if (offset >=3D TM_SPC_ACK_EBB) {
> >>> +        xive_tm_write_special(nvt, offset, value, size);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    if (TM_RING(offset) !=3D TM_QW1_OS) {
> >>
> >> Why have this if you have separate OS and user regions as you appear
> >> to do below?
> >=20
> > This is another problem we are trying to solve.=20
> >=20
> > The registers a CPU can access depends on the TIMA view it is using.=20
> > The OS TIMA view only sees the OS ring registers. The HV view sees all.=
=20
>=20
> So, I gave a deeper look at the specs and I understood a little more=20
> details of the concepts behind. You need to do frequent round-trips=20
> to this document ... =20
>=20
> These registers are accessible through four aligned pages, each exposing=
=20
> a different view of the registers. First page (page address ending=20
> in 0b00) gives access to the entire context and is reserved for the=20
> ring 0 security monitor. The second (page address ending in 0b01)=20
> is for the hypervisor, ring 1. The third (page address ending in 0b10)=20
> is for the operating system, ring 2. The fourth (page address ending=20
> in 0b11) is for user level, ring 3.
>=20
> The sPAPR machine runs at the OS privilege and therefore can only=20
> accesses the OS and the User rings, 2 and 3. The others are for
> hypervisor levels.

Ok, that much is what I thought.  What I'm less clear on is what each
page looks like compared to the others.  Previously I thought each one
had the same registers, just manipulating the corresponding ring.  Are
you saying instead that each ring's page basically has a subset of the
registers in the next most privileged page?

> I will try to come with a better implementation of the model and
> make sure the ring numbers are respected. I am not sure we should=20
> have only one memory region or four distinct ones with their
> own ops. There are some differences in the load/store of each view.

Right.  I'm not clear at this point if that's for good reasons, or
just because IBM's hardware designers don't seem to have gotten the
hang of Don't Repeat Yourself.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kVhvBuyIzNBvw9vr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrqoKAACgkQbDjKyiDZ
s5K/EQ/6ArKejVwxFguqKAqJw+tTTVaNhrnLvBxYpDU/vBUeHg6J1djjg0/fzjZl
hw6Lt+dOm4pryNojsYMcW597BhiQqJz9oYH9gE5LVfBb7dzBW68lmvtz/uwJKveW
IvNJ4EyQr9JzwhqReFQQ04VoDAf7zNntV8qNRgTEQLu6ecN8wXXWsjUcKc4Rqyjm
yn8CXsCFsJHkNgutSIPLzpR/mOUDJWQU7clAGP2McDIIcpb3o7/oulL20hzO2pBJ
DEb6DH+2eDLECUFOOTeqsJgm1esEjnQbIY2MrQEIbPNpEsBeEoXujUi0MJwlprR6
ABH2wcdYvmCfzc1Q9tQvUqhXkuZeQvm6OFkSl9oU4jG46zlBPWrNL3KvTzdoBj8r
Z5RaIaxx6N73hPU+/UyXA7DesYIOjj5bPShrhyTnafP7azUYHd+k/LoVx9szXeZJ
zflIY64KAELXPN3e474SB+ZD4JjDuCHYACtITxJDKjJZSkUw5ZtwI6nMpWDUecmU
foyJoGzGB1wL8LHey/1PRLKQdDA6CRiZtDuAmoqCf6dZATiRYCjSrZtyLKvn3T1V
Lxuse7Lp2soN5iJqqaRJru69f3CiYudOGy6+EbgKFS805+z+kvaOUrwb19syyNc/
ZfQCRm1BC0Xv52c0drAs461bYeY3KueuwL257MTixoN/KuX4LD4=
=eB3I
-----END PGP SIGNATURE-----

--kVhvBuyIzNBvw9vr--
