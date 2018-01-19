Received: from eggs.gnu.org ([2001:4830:134:3::10]:37945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecMiU-0001Rf-0N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 21:47:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ecMiS-0004vo-Sr
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 21:47:42 -0500
Date: Fri, 19 Jan 2018 13:22:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180119022210.GC30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<1516179297.3278.6.camel@redhat.com>
	<20180118042713.GJ30352@umbus.fritz.box>
	<1516290939.3278.22.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WnjMQ0y5QpAQNNgT"
Content-Disposition: inline
In-Reply-To: <1516290939.3278.22.camel@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [QEMU-PPC] [PATCH V3 0/6] target/ppc:
 Rework spapr_caps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, paulus@ozlabs.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--WnjMQ0y5QpAQNNgT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 04:55:39PM +0100, Andrea Bolognani wrote:
> On Thu, 2018-01-18 at 15:27 +1100, David Gibson wrote:
> > > I looked further and device-list-properties looks like it would
> > > do the trick; however it doesn't seem to work for machines:
> > >=20
> > >   {"execute": "device-list-properties",
> > >    "arguments": {"typename": "spapr-2.11-machine"}}
> > >   {"error": {"class": "GenericError",
> > >              "desc": "Parameter 'typename' expects device"}}
> > >=20
> > > It works fine for the likes of virtio-scsi-pci and even
> > > power9_v2.0-powerpc64-cpu, though. Any ideas? :)
> >=20
> > I'm guessing it's because machines aren't descended from TYPE_DEVICE.
> >=20
> > Dammit.  I really can't see a reasonable way of addressing this other
> > than improving qapi in general to have a way of reporting machine
> > class properties.  Adding something ad-hoc for just these properties
> > of this machine seems like madness.
> >=20
> > Nor can I think of a place to put these that would be both sensible
> > and more discoverable with existing mechanisms.
>=20
> The relationship between QOM/QAPI/QMP is not very clear in my mind,

You and me both :/

> as you might have guessed from my messages, so I don't think I can
> offer much useful input. But if the properties are registered using
> the same mechanism both for devices and machines, then maybe there
> should be a QMP command that can list them regardless of the parent
> type? object-list-properties or something like that.

So, it's a bit complicated.  The underlying mechanism is QOM
properties in all cases.  QOM properties can be constructed either on
a QOM class, or on a QOM instance.  I'm pretty sure
device-list-properties will only list those constructed on the class,
since an instance hasn't been created.

Nearly all properties should be created on the class, not the
instance... but in most cases they're not.  The cap properties *are*
created at the class level, so in principle should be listable in the
same way.

Things derived from TYPE_DEVICE can use that same mechanism directly
but more commonly use a table of properties that's brought over from
the older qdev stuff.  It's translated during class initialization, I
believe, into the QOM backend, but is still used because it's usually
less verbose than constructing QOM properties directly.

> I also noticed that the (AFAIK s390-specific) "loadparm" property
> is detected by libvirt through the query-command-line-options QMP
> command. Not sure what kind of trickery they employ to obtain that
> result, though, and I'm not sure it's exactly an example of best
> practices since it shows up on x86 and aarch64 too ;)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WnjMQ0y5QpAQNNgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlphVlAACgkQbDjKyiDZ
s5Lyqw//Supfz8cVjzyn+0qPN0m4f8msu2gIk7yFmi06LZaV+pOaM30DGfppdXX2
oqY45szxiSpljNjIZDp3Ua+C/I++QOfRuucy/jZ1Q0jkzn6/qpcaBEgpwX7M+FZa
QCOC5TXneqy807phpCJTwYVotSHvR49pr55rAVxW7Q85NCRC5QSYMYLOQYJP2Gjk
9sMkXlxqvOyW1Qpj8LckC3/rUeukl/QymqoI2VsFY217ISdn7hWIobeh4HT5Pr3h
LlPD5MY0eQRthzhPo26HOfi6Km7NqZjA/VQ3shaWLyKL0soampeexAxUAY5Uou/e
6UmCmvzfQ0OCldXTFTROk2h2cVYDuufd/0BNVbZfb+ZR8wIc4iXIR/FmyWg/479C
ykeCoMvIz2C5vdVyS4CoM4HwmvgSB8SGx6C18RRmxG7r1D5w431UAQdFoY+AImXB
4JFJUvPiWz4IcSuH0nmVH8LDvqwMY8S9LqIs1+YDigMY28q6MbYNDbODaQbKec4M
xmpOU+Ez3pipe++tALZHMyKvn50LA8nWUb2uE8sSf/oA5x5ZwjZT0irxbDbPR6s6
4otq3ar8kCnow2h+Sbe7i5B8TDQhUZagpjW0SHMusl3IQI9AuZKmLcOxEGGOenY4
B9n0mcfIjmGkPntsmmYgIQJIJjMUrs0ZMCSbj9jCIepHu+YNW+w=
=AS/o
-----END PGP SIGNATURE-----

--WnjMQ0y5QpAQNNgT--
