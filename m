Received: from eggs.gnu.org ([2001:4830:134:3::10]:40839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMFi-0004ZV-6d
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMFf-0004uG-2e
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:36:14 -0400
Date: Fri, 22 Sep 2017 21:36:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922113600.GT4998@umbus.fritz.box>
References: <87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<15582716-0d6e-aa7e-e429-08e1078765a4@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a6Ri6/t33sscKOaw"
Content-Disposition: inline
In-Reply-To: <15582716-0d6e-aa7e-e429-08e1078765a4@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix cores per chip for multiple
 cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, benh@kernel.crashing.org


--a6Ri6/t33sscKOaw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 12:56:40PM +0200, C=E9dric Le Goater wrote:
> On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote:
> > David Gibson <david@gibson.dropbear.id.au> writes:
> >=20
> >>>>>
> >>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has t=
he
> >>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores li=
ke
> >>>>> this:
> >>>>>
> >>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &error=
_fatal);
> >>>>>
> >>>>> Even when there were multiple cpus (-smp 4), when the guest boots u=
p, we
> >>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_thr=
eads
> >>>>> was 1), which is wrong as per the command-line that was provided.
> >>>>
> >>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> >>>> thread.  If you can't supply 4 sockets you should error, but you
> >>>> shouldn't go and change the number of cores per socket.
> >>>
> >>> OK, that makes sense now. And I do see that smp_cpus is 4 in the above
> >>> case. Now looking more into it, i see that powernv has something call=
ed
> >>> "num_chips", isnt this same as sockets ? Do we need num_chips separat=
ely?
> >>
> >> Ah, yes, I see.  It's probably still reasonable to keep num_chips as
> >> an internal variable, rather than using (smp_cpus / smp_cores /
> >> smp_threads) everywhere.  But we shouldn't have it as a direct
> >> user-settable property, instead setting it from the -smp command line
> >> option.
> >=20
> > Something like the below works till num_chips=3D2, after that guest does
> > not boot up. This might be some limitation within the OS, Cedric might
> > have some clue. Otherwise, I see that multiple chips are created with
> > single core having single thread.
> >=20
> >     ppc/pnv: Use num_chips for multiple sockets
> >    =20
> >     When the user does not provide the cpu topology, e.g. "-smp 4", mac=
hine fails to
> >     initialize 4 cpus. QEMU assumes smp_threads and smp_cores both as 1=
=2E Make sure
> >     that we initialize multiple chips for this.
>=20
> -smp 4          would give a machine with 4 sockets with 1 core
> -smp 4,cores=3D4  would give a machine with 1 socket  with 4 cores
>=20
> correct ?

That's right.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--a6Ri6/t33sscKOaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE9Z4ACgkQbDjKyiDZ
s5JrPA/+Pmr6ms5YFTwKQrSyNmHIC9tStL1DhqC60Ao3f+WI/rzolkLok2TZN8ep
Ht0RjZ8tqtxBH7AdY38az2NUd5POL2g+lOIMKjCZffN0/M4zi4JU03M/Whdonnnb
hNSlZ04Q1MiZPmDtz3/Ta+4jG+3R4uwtsv2arrd91SUdf86WC5b8A2yJYQA7GS49
oSP48Q5UCWExsR1IpPI8EtHSut3cqYMJU4Ds9f/2TQsc3aqVYYh1T0F69T7ajheu
ouZepgfBiIjyD37EJG+g5PffLl/GcXZ8kvcv/1W6+QApgEPQ9IpXcRhkXtxqFCm4
magopno6Ed6DfroUY0ajvV+ORUkk7yDh5KT1/5/g54RvbiyoB4ocDIQ23kdCXPSd
8kbje4Ti1Cf7o8XsmF/9YS6Urmd0v1a3OEV0nvOEonDlnmmVjHBfHDGj+8cBMb2Q
kBIRgJ1gs1/0g3ljZcm6AFAvzihMVTWq+7dkvBtK8tg8/7ztepr/LzT+jKkuT5qa
tqCcemihSMjNmrqWoC42ML5Z/45Brb31Z+QzjLWEYJoceUC7DR86vDouVAgxFjCZ
4OfME4PvDJeyiCoGIa/XWU/3NpRmJZcZUejklxaK0Thcsy/q1HuEzHMg4x9CmmKP
7OSh7vk2b9zsmxFyNj2oEGuQ408RlhMtn3/n+Niu9nn+NxHliaw=
=CdXr
-----END PGP SIGNATURE-----

--a6Ri6/t33sscKOaw--
