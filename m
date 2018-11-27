Received: from eggs.gnu.org ([2001:4830:134:3::10]:43974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRnlF-00034l-AS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:31:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gRnlB-00085e-W7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 19:31:25 -0500
Date: Wed, 28 Nov 2018 09:56:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181127225611.GQ2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-5-clg@kaod.org>
	<20181122044450.GF10448@umbus.fritz.box>
	<121d4f915a03c2e734feebceda023947aedb78a3.camel@kernel.crashing.org>
	<20181123011005.GU10448@umbus.fritz.box>
	<12f3da3b-3761-a26f-4460-65d3c978f52d@kaod.org>
	<20181126054429.GH2251@umbus.fritz.box>
	<81ec65f1-f524-10af-8729-9abf890b4ee4@kaod.org>
	<20181127001118.GL2251@umbus.fritz.box>
	<e76b169e-eb36-e9c3-46a3-666f9de612e3@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A7FgPGrDEcSmmdo/"
Content-Disposition: inline
In-Reply-To: <e76b169e-eb36-e9c3-46a3-666f9de612e3@kaod.org>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--A7FgPGrDEcSmmdo/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 08:30:15AM +0100, C=E9dric Le Goater wrote:
> On 11/27/18 1:11 AM, David Gibson wrote:
> > On Mon, Nov 26, 2018 at 10:39:44AM +0100, C=E9dric Le Goater wrote:
> >> On 11/26/18 6:44 AM, David Gibson wrote:
> >>> On Fri, Nov 23, 2018 at 11:28:24AM +0100, C=E9dric Le Goater wrote:
> >>>> On 11/23/18 2:10 AM, David Gibson wrote:
> >>>>> On Thu, Nov 22, 2018 at 05:50:07PM +1100, Benjamin Herrenschmidt wr=
ote:
> >>>>>> On Thu, 2018-11-22 at 15:44 +1100, David Gibson wrote:
> >>>>>>>
> >>>>>>> Sorry, didn't think of this in my first reply.
> >>>>>>>
> >>>>>>> 1) Does the hardware ever actually write back to the EAS?  I know=
 it
> >>>>>>> does for the END, but it's not clear why it would need to for the
> >>>>>>> EAS.  If not, we don't need the setter.
> >>>>>>
> >>>>>> Nope, though the PAPR model will via hcalls
> >>>>>
> >>>>> Right, bit AIUI the set_eas hook is about abstracting PAPR vs bare
> >>>>> metal details.  Since the hcall knows it's PAPR it can just update =
the
> >>>>> backing information for the EAS directly, and no need for an
> >>>>> abstracted hook.
> >>>>
> >>>> Indeed, the first versions of the XIVE patchset did not use such hoo=
ks,=20
> >>>> but when discussed we said we wanted abstract methods for the router=
=20
> >>>> to validate the overall XIVE model, which is useful for PowerNV.=20
> >>>>
> >>>> We can change again and have the hcalls get/set directly in the EAT
> >>>> and ENDT. It would certainly simplify the sPAPR model.
> >>>
> >>> I think that's the better approach.
> >>
> >> ok. let's keep that in mind for  :=20
> >>
> >>  [PATCH v5 11/36] spapr/xive: use the VCPU id as a NVT identifier
> >>  [PATCH v5 16/36] spapr: add hcalls support for the XIVE exploitation
> >>
> >> which are using the XiveRouter methods to access the controller EAT=20
> >> and ENDT. I thought that was good practice to validate the model but=
=20
> >> we can use direct sPAPR table accessors or none at all.
> >=20
> > Ok.  Consistency is good as a general rule, but I don't think it makes
> > sense to force the EAT and the ENDT into the same model. =20
>=20
> What do you mean by model ? the QEMU machine IC model ?

Oh, sorry, nothing that formal.  By "model" I just meant the same
pattern of accessor hooks.  They certainly do belong in the same qemu
object.

> > The EAT is
> > pure configuration, whereas the the ENDT has both configuration and
> > status.  Or to look at it another way, the EAT is purely software
> > controlled, whereas the ENDT is at least partially hardware
> > controlled.
>=20
> yes but the EAT and the ENDT are XIVE internal tables of the same XIVE=20
> sub-engine, the IVRE, Interrupt Virtualization Routing Engine, formely=20
> known as VC, for Virtualization Controller. the EAS is just an entry=20
> point to the ENDT. I don't see why we would use different models for=20
> them.
>=20
> > (I realize that gets a bit fuzzy when considering PAPR, but I think
> > from the point of view of the XIVE model it makes sense to treat the
> > PAPR hypervisor logic as "software", even though it's "hardware" from t=
he
> > guest point of view).
>=20
> That I agree but the resulting code is too ugly in the hcalls. Tell me=20
> when you reach patch 11, which links the machine IC model sPAPRXive to=20
> the generic XiveRouter and also check patch 16 introducing the hcalls,=20
> which update the XIVE internal tables.
>=20
> Thanks,
>=20
> C.=20
>=20
> =20
> >>
> >>
> >> I think these prereq patches could be merged now :
> >>
> >>  [PATCH v5 12/36] spapr: initialize VSMT before initializing the IRQ
> >>  [PATCH v5 13/36] spapr: introduce a spapr_irq_init() routine
> >>  [PATCH v5 14/36] spapr: modify the irq backend 'init' method
> >>
> >> This one also :
> >>
> >>  [PATCH v5 21/36] spapr: extend the sPAPR IRQ backend for XICS
> >>
> >> Thanks,
> >>
> >> C.=20
> >>
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A7FgPGrDEcSmmdo/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlv9y4sACgkQbDjKyiDZ
s5JA6hAAmSaqdIQoXxdjDZ8y7UVm5DjCQrYJNLD7hcwrG+VtDTHsmBc2JaA9pc1o
rCBYQSgSRWpFlx1QC62RccZJJElnKePgryljZQ4BXs8JAVwZco31NBJM4v6EBQbV
Jyc6V/yusKRnFSMGnsCRQx6LdSuhK+ogHkTgBaQx+a2+At3wjRvNIl9IIz6wAw6y
abgDPMa6of2EX+Q5AJd/TX0jbI5njiUKL0WHAk4ny4u+myVmcwKSMpQQYKr5eDpd
ch07U2yqHrF/n6wKuW7lPdoJKRCzC8DfgK74ZDSn5ajFJkrqlTvKyDr7fV4cHuv8
yBGSa2nbGx86kL6ANwPq/q/DIyeqSks0rhXJSCEq/o4wfeJJabNIcFd9ayrbG50m
Fh4A35hrOvQQ7HpW4I5iGganMuVEdTrExALk908EQhNNwPTPSkEAWnf+cEx+PExd
DI/iekCWj/JdM6zcUDOOi9bf+6i2yC6vsifNDrT2qcbXZ6Fon9iR4lJlGBGXG249
opK3sJD1U9bMlVa4u4uQBFfJitxTvNKVw+2xNjckyAC0/z0UPan2BxI8UsVNWveQ
TTlB1AfgLQPJXEzK5YIYXyd66t8vaZe0ZSjWOHYIvADujy6GLGshmJ9WF73C5wsV
BxxLGQM1gBQFcWm8CUG5l/ArU/VSJPh7NjNr2VIJ/HxDAZsdzJU=
=wlB8
-----END PGP SIGNATURE-----

--A7FgPGrDEcSmmdo/--
