Received: from eggs.gnu.org ([2001:4830:134:3::10]:49995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxk-0002Ys-7Q
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvKxe-00023F-8B
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 06:13:36 -0400
Date: Fri, 22 Sep 2017 20:12:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922101201.GG4998@umbus.fritz.box>
References: <87y3pagdg0.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920061756.GJ5520@umbus.fritz.box>
	<87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
In-Reply-To: <e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
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


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 08:07:06AM +0200, C=E9dric Le Goater wrote:
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
> > have some clue.
>=20
> Some controllers might need some more tweaking, PSI, LPC, to elect a=20
> master one.

Uh.. why?

> Anyhow I don't think we want to deduce the number of chips
> from the number of cpus. These two figures are very different.

How so?  It's not totally perfect, but making a single chip correspond
to a "socket" in qemu's (somewhat x86 centric) terminology is still a
pretty good match.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE4fEACgkQbDjKyiDZ
s5K/NQ/5AfYytzk+1LUuOAjWUvJnhEqPkXv9kpPsOEXC4GmIxiq2bSr5zI4xTr74
AahvoWkxGAUYHxK1kWEgu7TbLzIQI7eiBnQSxU69OYMGqh9awALDybRe3TtwZILA
s1DSQYr9EF0wtdr07aHjF3/7auHJ2sJzpuNtHAF/A7pSeAmIIVVMoo8OIL6XZ2LK
ureI5RGUN4uLYqm2CI9S026q71+6NekKq3PYcHg88r2WxkY1utOp4rL1ouGBXu2M
lL9xjl7185kTDGomhtHMIc97riXp4EVT4MLC0y84VI3ksxLN9yb0WjuO4unmtgKe
5YkMa1yKB6HppiLJ6Cn44e2YYWSzjl45Mo6kykCZuOR6NSYhBTYpYKsHPNgt+Wlu
xX1QUObxJaDx/bDhGMT4G33qkgSirUHLwdJhK5zfk9/6H6S+DdkcEFbvCJQ81mW6
+PodwWhR2MsTbeSrGWZYjQFbGf33z8H8YOBoz1KVALN0L4YjP2uuZ6q1yHf+ktvN
SpQaCKiGIwGi+JX3+K6gqltLd/aOUM5Ago8T8tzRSAEX3Ng5TntvJV3GWBSb8bZX
KuHOxGSO9RfeoGdQgDsPLuqGII+e7ICU9zPfa+V7zpW6Nq0n8F1nhK5TMR9SESSe
GSZQPhNeeZrcYO9WFKcUrINnI4dIm6a4W/RR6PBL2EEECXunAhE=
=VbZn
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
