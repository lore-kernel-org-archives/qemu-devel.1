Received: from eggs.gnu.org ([2001:4830:134:3::10]:54762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS8-0005Ar-T4
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHpS4-0005Q6-Ld
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 06:13:56 -0500
Date: Thu, 23 Nov 2017 22:08:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171123110858.GC22454@umbus.fritz.box>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-6-clg@kaod.org>
	<20171114104224.63ed5e87@bahia.lan>
	<20171117045053.GB26448@umbus.fritz.box>
	<41544cd8-4b95-4ae1-2edf-9e34cc5b0700@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <41544cd8-4b95-4ae1-2edf-9e34cc5b0700@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 05/11] spapr: introduce an IRQ
 allocator using a bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2017 at 08:19:23AM +0100, C=E9dric Le Goater wrote:
> On 11/17/2017 05:50 AM, David Gibson wrote:
> > On Tue, Nov 14, 2017 at 10:42:24AM +0100, Greg Kurz wrote:
> >> On Fri, 10 Nov 2017 15:20:11 +0000
> >> C=E9dric Le Goater <clg@kaod.org> wrote:
> >>
> >>> Let's define a new set of XICSFabric IRQ operations for the latest
> >>> pseries machine. These simply use a a bitmap 'irq_map' as a IRQ number
> >>> allocator.
> >>>
> >>> The previous pseries machines keep the old set of IRQ operations using
> >>> the ICSIRQState array.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> ---
> >>>
> >>>  Changes since v2 :
> >>>
> >>>  - introduced a second set of XICSFabric IRQ operations for older
> >>>    pseries machines
> >>>
> >>>  hw/ppc/spapr.c         | 76 ++++++++++++++++++++++++++++++++++++++++=
++++++----
> >>>  include/hw/ppc/spapr.h |  3 ++
> >>>  2 files changed, 74 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 4bdceb45a14f..4ef0b73559ca 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -1681,6 +1681,22 @@ static const VMStateDescription vmstate_spapr_=
patb_entry =3D {
> >>>      },
> >>>  };
> >>> =20
> >>> +static bool spapr_irq_map_needed(void *opaque)
> >>> +{
> >>> +    return true;
> >>
> >> I see that the next patch adds some code to avoid sending the
> >> bitmap if it doesn't contain state, but I guess you should also
> >> explicitly have this function to return false for older machine
> >> types (see remark below).
> >=20
> > I don't see that you should need to migrate this at all.  The machine
> > needs to reliably allocate the same interrupts each time, and that
> > means source and dest should have the same allocations without
> > migrating data.
>=20
> ok. so we need to make sure that hot plugging devices or CPUs does
> not break that scheme. This is not the case today if you don't follow
> the exact same order on the monitor.

Ok, that's already broken then :/.

AFAIK plugging CPUs shouldn't matter though.  Plugging devices might -
which is exactly why the approach of using an irq "allocator" as such
isn't a very good one.  We might have to have something for MSI-X,
which will then require migration of some data, but we shouldn't need
it for the intx and other fixed interrupts.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloWrEoACgkQbDjKyiDZ
s5JAbA/+LHFXWHu8l6TLsyPI6kLcZKUsrLd/l+N4+or1ioTxcyHunlOC0tD3Ls19
ptvIjQO8WPtWwIRyqTznqkQGP0rhQYwPIGP6bXYJlQEBYbBYha5gwpwAVEtSCgXx
zjHi/3Pm+b2ERR/vUUFyr2evUauIRaRFSZifWIpIPDWze+WdB6PN+Rk8UCR3q4z9
p7I073G9c4T8Q3dilFlrRMwiX6IGMyeHFK/ePl2/Q7+3QF7KtCs7zhqoylcVYrYL
sNY++99skjdiYTOPwovzUHlgbA5nZg91U3nGUFqmz46UokVMCLk9G7xmlFEr7MlS
mUSNjJ9IkDWLZuooDcK92IK2Z4AHi/dyUB+ZfdAZ49tKRkVuZKDMWD2PtKyWhbw7
7ehqUbWkZYvF48pcQaT0QeYX7nw1vhMy+8VJ4PA0z9TFwMAYw0hq50H1uikUNhMU
+Iz62LLmYbD5/nqfRCfNQJN1v6v5DGlzJFcT0dQ0xTz7RwbXF9HIWzyUSWa+Lnds
4vCB2+ojsTiZ+YoiBSfDTTfDQnK9WKhA8xvS9HwqQw8o4qF4DStgxTjilnDewdWs
PktsVJMUXJXXbgdRqOh2cJwbNOnOuxl4DhDWSol1bhL6PMeQmwdvS54m6chRZhx6
r5Z2IVGUEM2y1TX70oZ4MZlfsxhEJhS6eYlWQhF3zBqvZ59XLM0=
=Dv7u
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
