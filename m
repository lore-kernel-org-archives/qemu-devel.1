Received: from eggs.gnu.org ([2001:4830:134:3::10]:44257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec1vO-0002ja-Sn
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:35:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ec1vN-0007WC-PS
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 23:35:38 -0500
Date: Thu, 18 Jan 2018 15:27:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180118042713.GJ30352@umbus.fritz.box>
References: <20180115063235.7518-1-sjitindarsingh@gmail.com>
	<1516110433.10494.5.camel@redhat.com>
	<20180116135459.GN30352@umbus.fritz.box>
	<1516113980.3278.1.camel@redhat.com>
	<20180116223413.GQ30352@umbus.fritz.box>
	<62449abf-fdd1-44f3-4a5c-0695e8607cea@ozlabs.ru>
	<1516179297.3278.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3qYtBtpdm1/OJWPn"
Content-Disposition: inline
In-Reply-To: <1516179297.3278.6.camel@redhat.com>
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


--3qYtBtpdm1/OJWPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2018 at 09:54:57AM +0100, Andrea Bolognani wrote:
> On Wed, 2018-01-17 at 10:26 +1100, Alexey Kardashevskiy wrote:
> > On 17/01/18 09:34, David Gibson wrote:
> > > On Tue, Jan 16, 2018 at 03:46:20PM +0100, Andrea Bolognani wrote:
> > > > On Wed, 2018-01-17 at 00:54 +1100, David Gibson wrote:
> > > > > > Correct me if I'm wrong, but it seems to me like there's no way
> > > > > > to figure out through QMP whether these new machine options can=
 be
> > > > > > used for a given QEMU binary.
> > > > >=20
> > > > > Uh, I don't think so.  These are machine options like any other (=
just
> > > > > constructed a bit differently).  So they'll appear in qemu -machi=
ne
> > > > > pseries,? and I believe that info can also be retrieved with QMP.
> > > >=20
> > > > Yes, they will indeed show up in the output of -machine pseries,?
> > > > but there's AFAICT no way to retrieve them via QMP.
> > >=20
> > > Really!?  I thought introspecting object properties was QMP's bread
> > > and butter.
> >=20
> > On a guest started with '-S':
> > {"execute": "qom-list", "arguments": {"path": "/machine"}}
> >=20
> > returns:
> > {   'return': [   {'name': 'graphics', 'type': 'bool'},
> [...]
> >                   {'name': 'cap-dfp', 'type': 'bool'},
> >                   {'name': 'cap-htm', 'type': 'bool'},
> >                   {'name': 'cap-vsx', 'type': 'bool'},
> >                   {'name': 'vfio-no-msix-emulation', 'type': 'bool'},
> >                   {'name': 'kvm-type', 'type': 'string'},
> >                   {'name': 'max-cpu-compat', 'type': 'string'},
> [...]
> >                   {'name': 'resize-hpt', 'type': 'string'}]}
> >=20
> > but still requires a running qemu, yes.
>=20
> That's not a problem in itself; however, AFAICT the guest in
> question also needs to be started with -machine pseries in order
> for the above to work, which means it's not usable due to the
> scalability issues mentioned earlier in the thread. We run QEMU
> with -machine none, a single time, to probe for capabilities.
>=20
> I looked further and device-list-properties looks like it would
> do the trick; however it doesn't seem to work for machines:
>=20
>   {"execute": "device-list-properties",
>    "arguments": {"typename": "spapr-2.11-machine"}}
>   {"error": {"class": "GenericError",
>              "desc": "Parameter 'typename' expects device"}}
>=20
> It works fine for the likes of virtio-scsi-pci and even
> power9_v2.0-powerpc64-cpu, though. Any ideas? :)

I'm guessing it's because machines aren't descended from TYPE_DEVICE.

Dammit.  I really can't see a reasonable way of addressing this other
than improving qapi in general to have a way of reporting machine
class properties.  Adding something ad-hoc for just these properties
of this machine seems like madness.

Nor can I think of a place to put these that would be both sensible
and more discoverable with existing mechanisms.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3qYtBtpdm1/OJWPn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpgIiEACgkQbDjKyiDZ
s5Jj6g/+MC0LaZYqiCfhDE0VqSJ2SKHhqzC1Wu0mMQVgWRbJsk1Za4jcFxCFIRJz
Q4s80KLivbey9LAzV9PrpCP3elEbGVMsJAl3O3tCeFMRH/BKYiU9zvzGDS94qHOn
F8l87ukSCidmcmnE7ZVSBB3LVU+SfJ32CvK1ylzg9dqJm0Zfk/13C8wZD+bhxBnY
KrLFVLoXHK/31olhSdjr7L7Wko1qIWQqAGf3or5yXZAsXKHU4vClaF6QH+60lnfW
dg+9Lx+vhWel7oe66UMGCqUj5Zw4a164Qp8LWMIMlYDQG2woRze6GurTK5KFyDpe
TpITEUrmFWNCgLr3CfQHnmOpVFpi0PTS+peSWIcGYbWhkr1IvVd30VQ9I3sr4r7p
DKJoeuTKfWD/Rch/g9sbwwc4Ex6L0kdn4OVKm5YSBy3sCJVDYNsVCOKzcL+IXlnt
I6HAwt3GkN1WQdA/TsgPmq53VyUX5vOnssaj19BsSgDHw2US367bBDwSVXjuB0Ra
3T82AuSE+cO0IqKyHYxwxzH41TG9er2SYEKQa0Mh+JyE/XzBFiKJ/nEzEy59a8zl
9cO202L+1RD/+nB5ao0XabZ4yFYQmDkshnQVt0mOwszvdHBJPKrzGOfEoUandhGP
RFvu0dfqYseb6emaw46NJUYFHM5VQ5+wJA69LWtEdfrF6UVuRJU=
=Ei/U
-----END PGP SIGNATURE-----

--3qYtBtpdm1/OJWPn--
