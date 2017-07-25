Received: from eggs.gnu.org ([2001:4830:134:3::10]:54655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRb-0000qT-PG
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZpRa-000608-JH
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 22:19:31 -0400
Date: Tue, 25 Jul 2017 12:19:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170725021921.GE9471@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-10-git-send-email-clg@kaod.org>
	<20170724044948.GF17228@umbus.fritz.box>
	<1500876571.10674.58.camel@kernel.crashing.org>
	<20170724063905.GN17228@umbus.fritz.box>
	<6443f6d1-7e30-cb8c-0e18-a2aa7bd32ef9@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ryJZkp9/svQ58syV"
Content-Disposition: inline
In-Reply-To: <6443f6d1-7e30-cb8c-0e18-a2aa7bd32ef9@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 09/26] ppc/xive: add an overall memory
 region for the ESBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--ryJZkp9/svQ58syV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 03:27:18PM +0200, C=E9dric Le Goater wrote:
> On 07/24/2017 08:39 AM, David Gibson wrote:
> > On Mon, Jul 24, 2017 at 04:09:31PM +1000, Benjamin Herrenschmidt wrote:
> >> On Mon, 2017-07-24 at 14:49 +1000, David Gibson wrote:
> >>> On Wed, Jul 05, 2017 at 07:13:22PM +0200, C=E9dric Le Goater wrote:
> >>>> Each source adds its own ESB mempry region to the overall ESB memory
> >>>> region of the controller. It will be mapped in the CPU address space
> >>>> when XIVE is activated.
> >>>>
> >>>> The default mapping address for the ESB memory region is the same one
> >>>> used on baremetal.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  hw/intc/xive-internal.h |  5 +++++
> >>>>  hw/intc/xive.c          | 44 ++++++++++++++++++++++++++++++++++++++=
+++++-
> >>>>  2 files changed, 48 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
> >>>> index 8e755aa88a14..c06be823aad0 100644
> >>>> --- a/hw/intc/xive-internal.h
> >>>> +++ b/hw/intc/xive-internal.h
> >>>> @@ -98,6 +98,7 @@ struct XIVE {
> >>>>      SysBusDevice parent;
> >>>> =20
> >>>>      /* Properties */
> >>>> +    uint32_t     chip_id;
> >>>
> >>> So there is a XIVE object per chip.  How does this work on PAPR?  One
> >>> logical chip/XIVE, or something more complex?
> >>
> >> One global XIVE for PAPR. For the MMIOs, the way it works is that:
> >>
> >>  - For MMIOs pertaining to a specific interrupt or queue, there's an H-
> >> call that will return the proper "guest physical" address. For qemu
> >> with KVM we'll have to probably create a single chunk of qemu address
> >> space (a single mem region) that contains individual pages mapped with
> >> MAP_FIXED originating from the different HW bits, we still need to sort
> >> out how exactly we'll do that in practice.
> >>
> >>  - For the TIMA (the presentation MMIOs), those are always at the same
> >> physical address for everybody (so for a guest it's a single memory
> >> region we'll map to that physical address), the HW "knows" which HW
> >> thread is talking to it (and the hypervisor tells the HW which vcpu is
> >> running on a given HW thread at a given point in time). That address is
> >> obtained from the device-tree
> >=20
> > Ok.  That leaves "chip_id" as a rather surprising thing to see in an
> > object which will appear on PAPR.
>=20
> We could also pass the address as a property instead of the chip-id when
> creating the XIVE object. May be better for sPAPR.

Yes, I think that sounds like a much better option.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ryJZkp9/svQ58syV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll2qqkACgkQbDjKyiDZ
s5IfCRAAh9gumiRl+we/dJYhcPxisyd7BtBcGgaB1/Zfz7nQdBHO55aFib9Wucug
YNT6WzUiOaSXgE0FxS9FP4znukgoGnNabXqgxOvp0nizTTbNqaYEupJbl6VGqKnV
aNSsTrvlthyT6wre1oAG5izon7IedlNhUnu1XKLu2fFIeByAKoMuzbS8YT5cCvPn
WfRxxP7L+h6JLWKFvBj304xsT5EwHhTUbYMgPn6ZXeQg8jJrHu58hs6VEij3PN1M
oGjH462D6/d2eLHM6QavmaETeK6BykONgX9J5iMNA72eqi+pUlnG2o/voBs55mkj
bkgYvdRX25d+C5E7sEXP6VOX39xSgSOs6iIoxbfC3h4tRPL0f+xV7l+v0HRysiFO
GAY34RABlFLa65nMK9DZlk5vzJLTjjmKhr696ro1pqg6xxgNL6ctGwrIvwO7QHSk
YA44xoO8Tm/PtawbvctGuyPqfiHvt03nvnQw2LC7uMo5E5mew9HxjPeZxmkxufIy
4F7AsDZ3kPc4FVtzZBYcagfGSEN3QD1TnaK7kj+kT8xicyCOfAJ2L3IOKrUwgmY4
PowqHrL26eqZ+mCjEne4sdhCmt53Wwl8Y6ECt5H0vN97F25Z4vyeiormcyYlVWi8
odzpQ0EFpd8FpUsxdXAhLGDYTJRw2nJ3KYSVV5R0FnCbUpwCw6U=
=X7o+
-----END PGP SIGNATURE-----

--ryJZkp9/svQ58syV--
