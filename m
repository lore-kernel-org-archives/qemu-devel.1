Received: from eggs.gnu.org ([2001:4830:134:3::10]:50971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e59o9-000338-4l
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e59o5-0006Re-Ow
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:17 -0400
Received: from ozlabs.org ([103.22.144.67]:37401)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e59o4-0006Pg-AV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 08:20:13 -0400
Date: Thu, 19 Oct 2017 22:49:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171019114954.GC13245@umbus>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<20171018202240.GD2942@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Clx92ZfkiYIKRjnr"
Content-Disposition: inline
In-Reply-To: <20171018202240.GD2942@localhost.localdomain>
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com


--Clx92ZfkiYIKRjnr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2017 at 06:22:40PM -0200, Eduardo Habkost wrote:
> On Wed, Oct 18, 2017 at 04:30:10PM +0100, Daniel P. Berrange wrote:
> > On Tue, Oct 17, 2017 at 06:06:35PM +0200, Igor Mammedov wrote:
> > > On Tue, 17 Oct 2017 16:07:59 +0100
> > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > >=20
> > > > On Tue, Oct 17, 2017 at 09:27:02AM +0200, Igor Mammedov wrote:
> > > > > On Mon, 16 Oct 2017 17:36:36 +0100
> > > > > "Daniel P. Berrange" <berrange@redhat.com> wrote:
> > > > >  =20
> > > > > > On Mon, Oct 16, 2017 at 06:22:50PM +0200, Igor Mammedov wrote: =
=20
> > > > > > > Series allows to configure NUMA mapping at runtime using QMP/=
HMP
> > > > > > > interface. For that to happen it introduces a new '-paused' C=
LI option
> > > > > > > which allows to pause QEMU before machine_init() is run and
> > > > > > > adds new set-numa-node HMP/QMP commands which in conjuction w=
ith
> > > > > > > info hotpluggable-cpus/query-hotpluggable-cpus allow to confi=
gure
> > > > > > > NUMA mapping for cpus.   =20
> > > > > >=20
> > > > > > What's the problem we're seeking solve here compared to what we=
 currently
> > > > > > do for NUMA configuration ? =20
> > > > > From RHBZ1382425
> > > > > "
> > > > > Current -numa CLI interface is quite limited in terms that allow =
map
> > > > > CPUs to NUMA nodes as it requires to provide cpu_index values whi=
ch=20
> > > > > are non obvious and depend on machine/arch. As result libvirt has=
 to
> > > > > assume/re-implement cpu_index allocation logic to provide valid=
=20
> > > > > values for -numa cpus=3D... QEMU CLI option. =20
> > > >=20
> > > > In broad terms, this problem applies to every device / object libvi=
rt
> > > > asks QEMU to create. For everything else libvirt is able to assign a
> > > > "id" string, which is can then use to identify the thing later. The
> > > > CPU stuff is different because libvirt isn't able to provide 'id'
> > > > strings for each CPU - QEMU generates a psuedo-id internally which
> > > > libvirt has to infer. The latter is the same problem we had with
> > > > devices before '-device' was introduced allowing 'id' naming.
> > > >=20
> > > > IMHO we should take the same approach with CPUs and start modelling=
=20
> > > > the individual CPUs as something we can explicitly create with -obj=
ect
> > > > or -device. That way libvirt can assign names and does not have to=
=20
> > > > care about CPU index values, and it all works just the same way as
> > > > any other devices / object we create
> > > >=20
> > > > ie instead of:
> > > >=20
> > > >   -smp 8,sockets=3D4,cores=3D2,threads=3D1
> > > >   -numa node,nodeid=3D0,cpus=3D0-3
> > > >   -numa node,nodeid=3D1,cpus=3D4-7
> > > >=20
> > > > we could do:
> > > >=20
> > > >   -object numa-node,id=3Dnuma0
> > > >   -object numa-node,id=3Dnuma1
> > > >   -object cpu,id=3Dcpu0,node=3Dnuma0,socket=3D0,core=3D0,thread=3D0
> > > >   -object cpu,id=3Dcpu1,node=3Dnuma0,socket=3D0,core=3D1,thread=3D0
> > > >   -object cpu,id=3Dcpu2,node=3Dnuma0,socket=3D1,core=3D0,thread=3D0
> > > >   -object cpu,id=3Dcpu3,node=3Dnuma0,socket=3D1,core=3D1,thread=3D0
> > > >   -object cpu,id=3Dcpu4,node=3Dnuma1,socket=3D2,core=3D0,thread=3D0
> > > >   -object cpu,id=3Dcpu5,node=3Dnuma1,socket=3D2,core=3D1,thread=3D0
> > > >   -object cpu,id=3Dcpu6,node=3Dnuma1,socket=3D3,core=3D0,thread=3D0
> > > >   -object cpu,id=3Dcpu7,node=3Dnuma1,socket=3D3,core=3D1,thread=3D0
> > > the follow up question would be where do "socket=3D3,core=3D1,thread=
=3D0"
> > > come from, currently these options are the function of
> > > (-M foo -smp ...) and can be queried vi query-hotpluggble-cpus at
> > > runtime after qemu parses -M and -smp options.
> >=20
> > NB, I realize my example was open to mis-interpretation. The values I'm
> > illustrating here for socket=3D3,core=3D1,thread=3D0 and *not* ID value=
s, they
> > are a plain enumeration of values. ie this is saying the 4th socket, the
> > 2nd core and the 1st thread.  Internally QEMU might have the 2nd core
> > with a core-id of 8, or 7038 or whatever architecture specific numbering
> > scheme makes sense, but that's not what the mgmt app gives at the CLI
> > level
>=20
> I believe we have been trying to avoid index numbers to identify
> entities as a reaction to the bad experience we had with the
> cpu_index/apic_id mess in the past.
>=20
> An interface using arch-independent socket/core/thread indexes
> (not arch-dependent IDs) like you propose in the paragraph above
> could be a solution, as long as it is documented very clearly
> (and we include automated testing for those constraints).  But
> note that this is _not_ how the socket/core/thread IDs on the
> "-device *-cpu" and -numa command-line options work today.
>=20
> Also, this might solve the problem for CPU socket/core/thread
> identification, but might not be enough for the messy device
> address assignment rules that libvirt needs to duplicate in
> src/qemu/qemu_domain_address.c today.

Note that describing socket/core/thread tuples as arch independent (or
even machine independent) is.. debatable.  I mean it's flexible enough
that most platforms can be fit to that scheme without too much
straining.  But, there's no arch independent way of defining what each
level means in terms of its properties.

So, for example, on spapr - being paravirt - there's no real
distinction between cores and sockets, how you divide them up is
completely arbitrary.  I don't think we have any implemented, but it's
easy to imagine modelling a big server type machine with more than 3
natural layers of heirarchy (say, thread, core, chip,
multi-chip-module, big-honkin-drawer-of-processors, ...).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Clx92ZfkiYIKRjnr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnokV8ACgkQbDjKyiDZ
s5J6xQ//Yaipv/wB+sWqShbefMQAQUBpiVUm6iMT5DGJpvIsQWzuyowDSikazJQH
gqSLOiff3MushX9t72qVW/k9/GByLx0KdylVh5CV03og8ZK6GEkvYi37+vhfU9Ei
KTXIHVnHNS/i01SnL9rUu2yywMjaN7dfo8kEYZSm5fpofZ7WPIrNF9JEeQl8mCEU
OiFu0XsPD6K0zwQAaaONAX3vX44Re0GxdoKhs6E4AIv8P8kQWXdCiTfn63D3q5E1
bEKikgMYCWC2/pZo6mrwnAqHkpoHOwWcXBn10g+FkoeI7HFZcmOFv4h/kUmoE93f
tgS5cgamosl1HZBvkVa63F/E7M88B7eG1iyaTBJM9ATW7imvZb+RkKiJn9bpa5XW
1OMNbVnXNDdLQ2VJx8YY6sLqOhlhF6c3WkvLQyp232ziMLFAGqgYEgn3qW45VDcl
tqJ/8GlYY9crflaMqivkpnp0Lgk9I2aE/VaDcL88WuZZTOpD1LqwdITfRiHomrFD
mEgqj7SrIg/jzmv56vVKZ8YTMRgpNtQYDxvPY4nixYv2E5fmcOQ2+zh7VA7AyXQY
zsKOc98dCXEzOmrz/AK/bexRH2TP3X1sDln8vHt12GbxjI0964MiSe0LImp9+rgh
1lYgtpbV85zPqh0KxHWYsUhFuIIzy24KoYpgGt9coU7WEfQirJo=
=HzTh
-----END PGP SIGNATURE-----

--Clx92ZfkiYIKRjnr--
