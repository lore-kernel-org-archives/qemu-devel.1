Received: from eggs.gnu.org ([2001:4830:134:3::10]:48446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ75-0005vW-Ot
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:35:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eGZ71-0006zw-Ok
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 18:34:59 -0500
Date: Mon, 20 Nov 2017 10:17:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171119231751.GD19214@umbus.fritz.box>
References: <150789430473.4410.10317971414202753256.stgit@bahia.lan>
	<20171014093337.GG28032@umbus.fritz.box>
	<20171016102638.6977381f@nial.brq.redhat.com>
	<20171017061609.GL2776@umbus.fritz.box>
	<20171106160307.215d3cbd@bahia>
	<20171106190455.GA12514@umbus.fritz.box>
	<20171114085943.5f2439a9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
In-Reply-To: <20171114085943.5f2439a9@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] spapr_cpu_core: instantiate
 CPUs separately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 14, 2017 at 08:59:43AM +0100, Greg Kurz wrote:
> On Tue, 7 Nov 2017 06:04:55 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Nov 06, 2017 at 04:03:07PM +0100, Greg Kurz wrote:
> > > On Tue, 17 Oct 2017 17:16:09 +1100
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Mon, Oct 16, 2017 at 10:26:38AM +0200, Igor Mammedov wrote: =20
> > > > > On Sat, 14 Oct 2017 20:33:37 +1100
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >    =20
> > > > > > On Fri, Oct 13, 2017 at 01:31:44PM +0200, Greg Kurz wrote:   =
=20
> > > > > > > The current code assumes that only the CPU core object holds a
> > > > > > > reference on each individual CPU object, and happily frees th=
eir
> > > > > > > allocated memory when the core is unrealized. This is dangero=
us
> > > > > > > as some other code can legitimely keep a pointer to a CPU if =
it
> > > > > > > calls object_ref(), but it would end up with a dangling point=
er.
> > > > > > >=20
> > > > > > > Let's allocate all CPUs with object_new() and let QOM frees t=
hem
> > > > > > > when their reference count reaches zero. This greatly simplif=
y the
> > > > > > > code as we don't have to fiddle with the instance size anymor=
e.
> > > > > > >=20
> > > > > > > Signed-off-by: Greg Kurz <groug@kaod.org>     =20
> > > > > >=20
> > > > > > So, I'm pretty sure my first drafts of the core stuff did thing=
s this
> > > > > > waym and it got nacked, for QOM lifetime reasons that I never r=
eally
> > > > > > understood.   =20
> > > > > From what I remember, Andreas would like to see composite CPU obj=
ect
> > > > > allocated in one go and then its children initialized with object=
_initialize()
> > > > > so that no more allocation were needed.   =20
> > > >=20
> > > > Ah, ok.
> > > >  =20
> > > > > That potentially would benefit hotplug, since we could gracefully
> > > > > fail object creation early if there is not enough memory.   =20
> > > >=20
> > > > Yeah, it sounds nice, but I don't see how we can do it.  In order to
> > > > do that the core object has to have enough space for all the thread=
s,
> > > > which means we need both the size of each thread object and the num=
ber
> > > > of them.  The size we have (and will be easier to handle after Igor=
's
> > > > cleanups).  The number, we don't.
> > > >  =20
> > > > > But the way it's implemented currently doesn't really match that =
initial
> > > > > goal as array for threads is dynamically allocated later
> > > > > and then we need to dance around it with pointer arithmetic.
> > > > >=20
> > > > > BTW: almost any allocation failure in qemu currently
> > > > > is fatal so whether we fail on array alloc or on individual
> > > > > object_new() won't make any difference.
> > > > >=20
> > > > > I'd rather see this clean up merged as it simplifies code
> > > > > in these case.   =20
> > > >=20
> > > > Ok, works for me.
> > > >  =20
> > >=20
> > > Since we're in soft freeze already, I guess this won't go to 2.11. Ma=
ybe it's
> > > time to create ppc-for-2.12 and apply it there ? =20
> >=20
> > Yeah, sounds like a plan.
> >=20
>=20
> Friendly reminder: can you push this to ppc-for-2.12 so that it doesn't f=
all
> through the cracks ? :)

Uh.. sorry.  I thought there was another spin of this coming.  Can you
resend, and I'll apply to ppc-for-2.12.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloSER8ACgkQbDjKyiDZ
s5I9hhAAk24FdsksJZsvXzPuDr1Ug+gQvv7dPekjrhW9fShV99QJFXGKdcteH8hs
2qKDQjkpfYoumNSX+5DK8pU2WK10JkGHPmICYm8hcGExtalM9QsOhE/bJjOpyf8h
q7munm0kHFVhaXXPVI8RhLaKaokae+XKeji1+opm8rBgh/A5kIDnnfKd0I6bM6T+
QEoesjUpBvUDS3QCFMiNODMsO6e9vdh6humgd0Dco+53HQ9h6YZcnNG5DLwKc5DC
nv9TodHBebUuqBaY5xuNv2SxudhblP0brIKdS+htNdyx1zSbhOWvLKrfEEeHIFRL
Odc/NghDN/Y1T5XQUEBbFazxFMMLibWLW5pYaxxkkDgYYpy64xLfbWauxTCwZwXW
ChW4HjkfNtnCrVdVtehNRdoL2lBXhku6GSdEkMRhRMOThspcUKa51kC9JOaROMEK
MdMrK3Vrt2bC0IUzEMxTr8YkknskoBfiQHC8CFgA0mQ2yYB2dD3PVdvYJw3Y2mbE
OMJcq0hrDov3KZDJJw9VgFXz6jxC8kKO7lM5AqtlzsSguTBjQzg0IrJT5Y8HJpEb
c+egNuwd6LytgJRRSI4hJQkEmppqNzSVnVwf7L/XXo3+iwcHk37D+Nvz1sWDbNcG
0VCagk8rSukP/ZhuX+MDmpgLTF3Xsg9QaWV5uBN96s05Mi3LaJY=
=SsbM
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--
