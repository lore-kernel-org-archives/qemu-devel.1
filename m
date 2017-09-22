Received: from eggs.gnu.org ([2001:4830:134:3::10]:42337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dvMPO-000848-TS
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dvMPL-0001wS-QK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:14 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:42937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dvMPL-0001ta-Hy
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 07:46:11 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id CA32273A59
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 13:46:09 +0200 (CEST)
Date: Fri, 22 Sep 2017 13:46:02 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170922134602.0bdfa05e@bahia.lan>
In-Reply-To: <20170922112042.GR4998@umbus.fritz.box>
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
	<20170922112042.GR4998@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/5aaCnQ66/YimPLNaGDkjKkx";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: fix cores per chip for
 multiple cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

--Sig_/5aaCnQ66/YimPLNaGDkjKkx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Sep 2017 21:20:42 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, Sep 22, 2017 at 12:46:58PM +0200, C=C3=A9dric Le Goater wrote:
> > On 09/22/2017 12:12 PM, David Gibson wrote: =20
> > > On Fri, Sep 22, 2017 at 08:07:06AM +0200, C=C3=A9dric Le Goater wrote=
: =20
> > >> On 09/22/2017 08:00 AM, Nikunj A Dadhania wrote: =20
> > >>> David Gibson <david@gibson.dropbear.id.au> writes:
> > >>> =20
> > >>>>>>>
> > >>>>>>> As smp_thread defaults to 1 in vl.c, similarly smp_cores also h=
as the
> > >>>>>>> default value of 1 in vl.c. In powernv, we were setting nr-core=
s like
> > >>>>>>> this:
> > >>>>>>>
> > >>>>>>>         object_property_set_int(chip, smp_cores, "nr-cores", &e=
rror_fatal);
> > >>>>>>>
> > >>>>>>> Even when there were multiple cpus (-smp 4), when the guest boo=
ts up, we
> > >>>>>>> just get one core (i.e. smp_cores was 1) with single thread(smp=
_threads
> > >>>>>>> was 1), which is wrong as per the command-line that was provide=
d. =20
> > >>>>>>
> > >>>>>> Right, so, -smp 4 defaults to 4 sockets, each with 1 core of 1
> > >>>>>> thread.  If you can't supply 4 sockets you should error, but you
> > >>>>>> shouldn't go and change the number of cores per socket. =20
> > >>>>>
> > >>>>> OK, that makes sense now. And I do see that smp_cpus is 4 in the =
above
> > >>>>> case. Now looking more into it, i see that powernv has something =
called
> > >>>>> "num_chips", isnt this same as sockets ? Do we need num_chips sep=
arately? =20
> > >>>>
> > >>>> Ah, yes, I see.  It's probably still reasonable to keep num_chips =
as
> > >>>> an internal variable, rather than using (smp_cpus / smp_cores /
> > >>>> smp_threads) everywhere.  But we shouldn't have it as a direct
> > >>>> user-settable property, instead setting it from the -smp command l=
ine
> > >>>> option. =20
> > >>>
> > >>> Something like the below works till num_chips=3D2, after that guest=
 does
> > >>> not boot up. This might be some limitation within the OS, Cedric mi=
ght
> > >>> have some clue. =20
> > >>
> > >> Some controllers might need some more tweaking, PSI, LPC, to elect a=
=20
> > >> master one. =20
> > >=20
> > > Uh.. why? =20
> >=20
> > that's not true. I managed to boot a pnv machine with 4 chips/sockets=20
> > each having 4 cpus using a 4.4.9-openpower2 skiroot kernel, from an=20
> > openpower firmare 1.10 I think. Recent openpower kernel must be using=20
> > some new features/instructions that we don't manage well in QEMU.
> >=20
> > I would need to build a kernel with more output.
> >  =20
> > >> Anyhow I don't think we want to deduce the number of chips
> > >> from the number of cpus. These two figures are very different. =20
> > >=20
> > > How so?  It's not totally perfect, but making a single chip correspond
> > > to a "socket" in qemu's (somewhat x86 centric) terminology is still a
> > > pretty good match. =20
> >=20
> > well, it would be good to be able to define chips with different
> > numbers of cpus. That is something will we want to do for sure. =20
>=20
> You mean multiple chips in a single system with non-uniform numbers of
> cores?  Are there really such systems in the wild?
>=20

Doesn't it happen when a CPU core gets deconfigured ?

--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.

--Sig_/5aaCnQ66/YimPLNaGDkjKkx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWcT3+gAKCRAC/DrrAQHb
wnX7AJ0QAkEv/nT9li7LeR2C0aXMqtKbwwCfZhieABzyP29TqH4YeojT0zi0/j4=
=Oqe0
-----END PGP SIGNATURE-----

--Sig_/5aaCnQ66/YimPLNaGDkjKkx--
