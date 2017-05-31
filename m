Received: from eggs.gnu.org ([2001:4830:134:3::10]:54525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFuB4-0007SX-9i
	for qemu-devel@nongnu.org; Tue, 30 May 2017 23:20:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFuB2-00087X-P6
	for qemu-devel@nongnu.org; Tue, 30 May 2017 23:20:06 -0400
Date: Wed, 31 May 2017 12:57:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170531025748.GG12163@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 10:01:36AM +0200, Greg Kurz wrote:
> On Tue, 30 May 2017 16:18:52 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, May 30, 2017 at 01:14:16AM +0200, Greg Kurz wrote:
> > > On Fri, 26 May 2017 15:23:14 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >=20
> > > [...] =20
> > > >=20
> > > >=20
> > > > Changes since v3:
> > > >   * Backwards compatible -cpu handling now removes compat=3D option=
 from
> > > >     options passed on to the cpu, so it doesn't trigger further war=
nings =20
> > >=20
> > > This seems to also have another interesting effect.
> > >=20
> > > getset_compat_deprecated() could be called either during CPU realizat=
ion from:
> > >=20
> > > object_property_parse()
> > > {
> > >     Visitor *v =3D string_input_visitor_new(string);
> > >     object_property_set(obj, v, name, errp);
> > >     ...
> > > }
> > >=20
> > > or during a QOM set operation from:
> > >=20
> > > void object_property_set_qobject(Object *obj, QObject *value,
> > >                                  const char *name, Error **errp)
> > > {
> > >     Visitor *v;
> > >=20
> > >     v =3D qobject_input_visitor_new(value);
> > >     object_property_set(obj, v, name, errp);
> > >     ...
> > > }
> > >=20
> > > or similarly during a QOM get operation with a QObject output visitor.
> > >=20
> > > The realization path no longer exists with patch 2, so you don't need
> > > to implement a null string input visitor anymore. =20
> >=20
> > s/patch 2/patch 3/?
> >=20
>=20
> Yes indeed, sorry :)
>=20
> > Is that true though?  It shouldn't get called through that path in
> > practice, because we strip the compat property from the cpu object
> > properties.  But it could get called if either a) the user explicitly
> > creates a cpu object with -device CPU,compat=3Dwhatever or b) if the
>=20
> Unless I'm missing something, properties of the CPU objects aren't
> exposed by CPU devices:
>=20
> qemu-system-ppc64 -machine pseries \
>                   -device POWER8_v2.0-spapr-cpu-core,help
> POWER8_v2.0-spapr-cpu-core.core-id=3Dint
> POWER8_v2.0-spapr-cpu-core.node-id=3Dint32
> POWER8_v2.0-spapr-cpu-core.nr-threads=3Dint
>=20
> and creation of CPU objects with -object isn't possible either since
> they don't inherit from the TYPE_USER_CREATABLE class.

Ah, true, I hadn't considered that.

> > user uses the compat=3D property with a machine type other than pseries.
> >=20
>=20
> But yes, it is still possible to go through the object_property_parse()
> path with another machine type indeed.

> > Of course the user *shouldn't* do either of those things, but
> > providing a meaningful error if they do is pretty much the whole
> > purpose of this getter/setter method.
> >=20
>=20
> All old non-pseries machine types already complain when started with
> a POWER7 or newer CPU. Providing the extra error message looks weird:
>=20
> qemu-system-ppc64 -machine ppce500 \
>                   -cpu POWER7,compat=3Dpower6
> qemu-system-ppc64: CPU 'compat' property is deprecated and has no effect;
>  use max-cpu-compat machine property instead
> MMU model 983043 not supported by this machine.
>=20
> but I guess it's better than crashing. :)

Well, sure POWER7 doesn't make sense for an e500 machine for other
reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
compat=3D doesn't.

>=20
> > >=20
> > > This means that patch 1 is no longer needed if I get things right but
> > > you probably want Markus to second that.
> > >  =20
> > > >   * Add a migration fix make cpu_synchronize_state() safe in post_l=
oad
> > > >     handlers, which in turn fixes a bug in 5/5.
> > > >   * A number of bugfixes and other tweaks suggested by feedback on =
v2.
> > > >=20
> > > > Changes since RFCv2:
> > > >   * Many patches dropped, since they're already merged
> > > >   * Rebased, fixed conflicts
> > > >   * Restored support for backwards migration (wasn't as complicated=
 as
> > > >     I thought)
> > > >   * Updated final patch's description to more accurately reflect the
> > > >     logic
> > > >=20
> > > > Changes since RFCv1:
> > > >   * Change CAS logic to prefer compatibility modes over raw mode
> > > >   * Simplified by giving up on half-hearted attempts to maintain
> > > >     backwards migration
> > > >   * Folded migration stream changes into a single patch
> > > >   * Removed some preliminary patches which are already merged
> > > >=20
> > > > David Gibson (4):
> > > >   migration: Mark CPU states dirty before incoming migration/loadvm
> > > >   pseries: Move CPU compatibility property to machine
> > > >   pseries: Reset CPU compatibility mode
> > > >   ppc: Rework CPU compatibility testing across migration
> > > >=20
> > > > Greg Kurz (1):
> > > >   qapi: add explicit null to string input and output visitors
> > > >=20
> > > >  cpus.c                       |   9 ++++
> > > >  hw/ppc/spapr.c               |   8 +++-
> > > >  hw/ppc/spapr_cpu_core.c      |  62 +++++++++++++++++++++-----
> > > >  hw/ppc/spapr_hcall.c         |   8 ++--
> > > >  include/hw/ppc/spapr.h       |  12 +++--
> > > >  include/sysemu/cpus.h        |   1 +
> > > >  include/sysemu/hax.h         |   1 +
> > > >  include/sysemu/hw_accel.h    |  10 +++++
> > > >  include/sysemu/kvm.h         |   1 +
> > > >  kvm-all.c                    |  10 +++++
> > > >  migration/savevm.c           |   2 +
> > > >  qapi/string-input-visitor.c  |  11 +++++
> > > >  qapi/string-output-visitor.c |  14 ++++++
> > > >  target/i386/hax-all.c        |  10 +++++
> > > >  target/ppc/compat.c          | 102 +++++++++++++++++++++++++++++++=
++++++++++++
> > > >  target/ppc/cpu.h             |   5 ++-
> > > >  target/ppc/machine.c         |  72 ++++++++++++++++++++++++++++--
> > > >  target/ppc/translate_init.c  |  86 +++++++++++--------------------=
-----
> > > >  18 files changed, 340 insertions(+), 84 deletions(-)
> > > >  =20
> > >  =20
> >=20
> >=20
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLjEqAAoJEGw4ysog2bOS+wkP/2q8ETBZtXeoK6Dw51f084qc
r9VlpL1jyHpeig5foPvqqMrCF8GWbg7eyZQOoQll2srkmb8nkTpNAKAhoTWr+FBN
2HaQmRsTU4KyDLmP1wJIXPCHBkrUn8TBb/dpmhy2GINuHLdas+i4Hf+SjRGjPxU1
OQuQ21V8Ug/0vDoiovhWqTbQ/9RV82Zo0058u49w9afT/0D81Iiftjgn97g8rQB+
Y+HI9Isezc7CFAS3ZCPS2fNSO+T4TN+rKFHKJCL+wEAnVLrNNEG1k1OrSE04Nuiy
puDZwRgjvGQegtZbRqloLNm3wx/M5OhAHaRDO47rRefxUS0o+zlueOBu4eN2z7Yt
CMDLYiookv4pZjgxJ9P++qFack3/Tc0rFuLSoqY3kHV4D5/3OD/MJ+eO5D6w/Ek+
9qiCq5r/UpR28PVQdreFHLRy9Wl3uj4yeWBEzGBstV/f84Q3Km+WPEB6gZitmh5b
7DeHoMrqXMzELBrpqNQMed03BNKYOdk6yDZq76Slrit5fvD6pYQ7ZwwCOowSxBmq
BkS4kLILaxZQGH9jKNIkMiPlnNLYQwBujJg53g3XUcVEffCGkLpPNpW13g1oSU2E
zEZIcqol1LWlZRzhQI1yjW4+MSucwOLSwxO41rkGN4U1tBrdwHNW6oWmnsGWuT5R
1KsX+J6yCkD6+JlFpYs0
=SeXo
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
