Received: from eggs.gnu.org ([2001:4830:134:3::10]:57115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFash-0004t4-4v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dFasf-0000sV-PS
	for qemu-devel@nongnu.org; Tue, 30 May 2017 02:43:51 -0400
Date: Tue, 30 May 2017 16:18:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170530061852.GE12163@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kA1LkgxZ0NN7Mz3A"
Content-Disposition: inline
In-Reply-To: <20170530011416.01eea576@bahia.ttt.fr.ibm.com>
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


--kA1LkgxZ0NN7Mz3A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 30, 2017 at 01:14:16AM +0200, Greg Kurz wrote:
> On Fri, 26 May 2017 15:23:14 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> [...]
> >=20
> >=20
> > Changes since v3:
> >   * Backwards compatible -cpu handling now removes compat=3D option from
> >     options passed on to the cpu, so it doesn't trigger further warnings
>=20
> This seems to also have another interesting effect.
>=20
> getset_compat_deprecated() could be called either during CPU realization =
=66rom:
>=20
> object_property_parse()
> {
>     Visitor *v =3D string_input_visitor_new(string);
>     object_property_set(obj, v, name, errp);
>     ...
> }
>=20
> or during a QOM set operation from:
>=20
> void object_property_set_qobject(Object *obj, QObject *value,
>                                  const char *name, Error **errp)
> {
>     Visitor *v;
>=20
>     v =3D qobject_input_visitor_new(value);
>     object_property_set(obj, v, name, errp);
>     ...
> }
>=20
> or similarly during a QOM get operation with a QObject output visitor.
>=20
> The realization path no longer exists with patch 2, so you don't need
> to implement a null string input visitor anymore.

s/patch 2/patch 3/?

Is that true though?  It shouldn't get called through that path in
practice, because we strip the compat property from the cpu object
properties.  But it could get called if either a) the user explicitly
creates a cpu object with -device CPU,compat=3Dwhatever or b) if the
user uses the compat=3D property with a machine type other than pseries.

Of course the user *shouldn't* do either of those things, but
providing a meaningful error if they do is pretty much the whole
purpose of this getter/setter method.

>=20
> This means that patch 1 is no longer needed if I get things right but
> you probably want Markus to second that.
>=20
> >   * Add a migration fix make cpu_synchronize_state() safe in post_load
> >     handlers, which in turn fixes a bug in 5/5.
> >   * A number of bugfixes and other tweaks suggested by feedback on v2.
> >=20
> > Changes since RFCv2:
> >   * Many patches dropped, since they're already merged
> >   * Rebased, fixed conflicts
> >   * Restored support for backwards migration (wasn't as complicated as
> >     I thought)
> >   * Updated final patch's description to more accurately reflect the
> >     logic
> >=20
> > Changes since RFCv1:
> >   * Change CAS logic to prefer compatibility modes over raw mode
> >   * Simplified by giving up on half-hearted attempts to maintain
> >     backwards migration
> >   * Folded migration stream changes into a single patch
> >   * Removed some preliminary patches which are already merged
> >=20
> > David Gibson (4):
> >   migration: Mark CPU states dirty before incoming migration/loadvm
> >   pseries: Move CPU compatibility property to machine
> >   pseries: Reset CPU compatibility mode
> >   ppc: Rework CPU compatibility testing across migration
> >=20
> > Greg Kurz (1):
> >   qapi: add explicit null to string input and output visitors
> >=20
> >  cpus.c                       |   9 ++++
> >  hw/ppc/spapr.c               |   8 +++-
> >  hw/ppc/spapr_cpu_core.c      |  62 +++++++++++++++++++++-----
> >  hw/ppc/spapr_hcall.c         |   8 ++--
> >  include/hw/ppc/spapr.h       |  12 +++--
> >  include/sysemu/cpus.h        |   1 +
> >  include/sysemu/hax.h         |   1 +
> >  include/sysemu/hw_accel.h    |  10 +++++
> >  include/sysemu/kvm.h         |   1 +
> >  kvm-all.c                    |  10 +++++
> >  migration/savevm.c           |   2 +
> >  qapi/string-input-visitor.c  |  11 +++++
> >  qapi/string-output-visitor.c |  14 ++++++
> >  target/i386/hax-all.c        |  10 +++++
> >  target/ppc/compat.c          | 102 +++++++++++++++++++++++++++++++++++=
++++++++
> >  target/ppc/cpu.h             |   5 ++-
> >  target/ppc/machine.c         |  72 ++++++++++++++++++++++++++++--
> >  target/ppc/translate_init.c  |  86 +++++++++++-------------------------
> >  18 files changed, 340 insertions(+), 84 deletions(-)
> >=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kA1LkgxZ0NN7Mz3A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZLQ7MAAoJEGw4ysog2bOS+1cQAMwE6w/FxTaQJtojzkNAvWbf
2rsxaz+LKpwCUAmhfs7avpF/3AJIY5BUesYaAUBJEQZyX+KitlDiqM6z80eRC13P
yCUcrqij2aZ3Rv3Pd4FdZhWoJV/r3iv0VvIBXcvKfwebnkE9KNfcHLN1wVfC5Po8
/SgjECNqlG6LZuSYSmzuimn9BiTtLzujXsrmr87HTXefHf65vBL/pz1yX747ZViX
8p88W3cM/9gC/v6FlUL/pSfTET9wp0h/V4PDDweil5taNF/2/KUiXgzSBGwO3YBp
7E7/ucRBF22EaraMP2vzs+SCo/cytu92KhwUhdoOU3vJR9oMyiN/kPwZn+1TIzjA
Oost8z95nzcQkHEHbxOTJBtxzpgmy5cGfIS04Tjf0/VoPBe6QdW2oyhbLsmUqYHO
K9PIjyTblGnnfJWEkLCUvJDRvmqyt/cWAOgvoJTAtDbKyoS64RPlLtgePS/RKpVA
yh+Lra6rAd0uTfuSRGYSsDDY5J9Zux7FnB4jnOsJhVe4cNSRVwv8uVp/jxPGa0rK
r+HCGZTDeQd60pnK5AviyBTr2+j4EtYiXz0hhrICi64pHd7a5tHzaMjfEv5P8diS
MwI5biO6ebYRPNYfP35ihgjDZua8AAWXWnB6UDF6cr9yLCK6hMJ+3G9DX77TqgAd
cGp+WYSvC88CwUt7KcsO
=TnfN
-----END PGP SIGNATURE-----

--kA1LkgxZ0NN7Mz3A--
