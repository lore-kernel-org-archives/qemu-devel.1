Received: from eggs.gnu.org ([2001:4830:134:3::10]:39932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMAB-0001l2-VE
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dvMA8-0002NI-O5
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:30:31 -0400
Date: Fri, 22 Sep 2017 21:20:42 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170922112042.GR4998@umbus.fritz.box>
References: <87vakdhnyn.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920065700.GO5520@umbus.fritz.box>
	<87poalhm74.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170920115342.GQ5520@umbus.fritz.box>
	<87377gpuyh.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<20170921053107.GD4998@umbus.fritz.box>
	<87y3p7nugc.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<e2ad1b05-0e93-5389-92b5-7d9ebdd273f8@kaod.org>
	<20170922101201.GG4998@umbus.fritz.box>
	<8cf3e77a-e397-c082-f1a2-b6b8c6be439f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6nfUOKxk8V1TQsEu"
Content-Disposition: inline
In-Reply-To: <8cf3e77a-e397-c082-f1a2-b6b8c6be439f@kaod.org>
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


--6nfUOKxk8V1TQsEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 12:46:58PM +0200, C=E9dric Le Goater wrote:
> On 09/22/2017 12:12 PM, David Gibson wrote:
> > On Fri, Sep 22, 2017 at 08:07:06AM +0200, C=E9dric Le Goater wrote:
> >> On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote:
> >>> David Gibson <david@gibson.dropbear.id.au> writes:
> >>>
> >>>>>>>
> >>>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also has=
 the
> >>>>>>> default value of 1 in vl.c. In powernv, we were setting nr-cores =
like
> >>>>>>> this:
> >>>>>>>
> >>>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &err=
or_fatal);
> >>>>>>>
> >>>>>>> Even when there were multiple cpus (-smp 4), when the guest boots=
 up, we
> >>>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp_t=
hreads
> >>>>>>> was 1), which is wrong as per the command-line that was provided.
> >>>>>>
> >>>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> >>>>>> thread.  If you can't supply 4 sockets you should error, but you
> >>>>>> shouldn't go and change the number of cores per socket.
> >>>>>
> >>>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the ab=
ove
> >>>>> case. Now looking more into it, i see that powernv has something ca=
lled
> >>>>> "num_chips", isnt this same as sockets ? Do we need num_chips separ=
ately?
> >>>>
> >>>> Ah, yes, I see.  It's probably still reasonable to keep num_chips as
> >>>> an internal variable, rather than using (smp_cpus / smp_cores /
> >>>> smp_threads) everywhere.  But we shouldn't have it as a direct
> >>>> user-settable property, instead setting it from the -smp command line
> >>>> option.
> >>>
> >>> Something like the below works till num_chips=3D2, after that guest d=
oes
> >>> not boot up. This might be some limitation within the OS, Cedric might
> >>> have some clue.
> >>
> >> Some controllers might need some more tweaking, PSI, LPC, to elect a=
=20
> >> master one.
> >=20
> > Uh.. why?
>=20
> that's not true. I managed to boot a pnv machine with 4 chips/sockets=20
> each having 4 cpus using a 4.4.9-openpower2 skiroot kernel, from an=20
> openpower firmare 1.10 I think. Recent openpower kernel must be using=20
> some new features/instructions that we don't manage well in QEMU.
>=20
> I would need to build a kernel with more output.
>=20
> >> Anyhow I don't think we want to deduce the number of chips
> >> from the number of cpus. These two figures are very different.
> >=20
> > How so?  It's not totally perfect, but making a single chip correspond
> > to a "socket" in qemu's (somewhat x86 centric) terminology is still a
> > pretty good match.
>=20
> well, it would be good to be able to define chips with different
> numbers of cpus. That is something will we want to do for sure.

You mean multiple chips in a single system with non-uniform numbers of
cores?  Are there really such systems in the wild?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6nfUOKxk8V1TQsEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE8ggACgkQbDjKyiDZ
s5IDlQ//RofrfmU9Spa6mrhoOfD4eBmFnZtQEVHIO9R58vAX20DYYxtVR1blw7dy
Xz90IyJERe5XEV4Gw9JcE0/k2+HC9SLIkLrSzrBVJ5ypvJUisRjFTybQ+zw8o2gN
jbdum9IRMMhS84hO9+FAXN9M/t32mFunrrTn5eE/j3wFEYOJ1aC0LSiRv/46aBrT
FvDl6a4DNeAchlv8gniy2j9dSVh1EZrS7maFVmxjOZ33X37dKFCZbijM0ZzLKq4L
Q8KEPcWxClvcjU5hEGJFTXpjbL+cq1KgcxDIP67tzSKwWzJfnICHtJW7gDFpA4cW
mxqRK4DGJ8Q+CYICXks1s+xLKT/3rXrnG8UNIx58i5w9bPBdvSxivxUs2cbtmuGl
zAK83Nw7+zXMuk7yzwR5vHA5vt12EZ54g/njJIsGz0ejovQT04bYm4PodCe6GGpN
+Rf5YfyJU38/peYNEp/D8PRDmxw5GTClipcJkhLQNAeDcuzD9OrkSSqCFjpOyFMr
yPw+qNvhhPvHx8z0FswzrTLeMZMoQ25nsFfZ01HvaGzR45VbdUNSQT+Rxj3G2vk+
7bPZrLzkD3llHfvxAPsovo+TDazS7CmI6uotp1ZI+x5q1aVh9o2QEgMPsfxxRbPL
M8hxAoQp4F5ull/SSuTwD9qB/iDfyrj8gWkAEiBAhRMzBYLmtOI=
=ZyMI
-----END PGP SIGNATURE-----

--6nfUOKxk8V1TQsEu--
