Received: from eggs.gnu.org ([2001:4830:134:3::10]:44835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFc6N-0006ML-OW
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFc6K-0002jc-KM
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:02:03 -0400
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:37598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFc6K-0002j7-AI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 04:02:00 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B8499FF69F
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 10:01:53 +0200 (CEST)
Date: Tue, 30 May 2017 10:01:36 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170530061852.GE12163@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/.n1Odr257agVsaHIAexpfA2";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv4 0/5] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, sursingh@redhat.com, sbobroff@redhat.com

--Sig_/.n1Odr257agVsaHIAexpfA2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 May 2017 16:18:52 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, May 30, 2017 at 01:14:16AM +0200, Greg Kurz wrote:
> > On Fri, 26 May 2017 15:23:14 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > [...] =20
> > >=20
> > >=20
> > > Changes since v3:
> > >   * Backwards compatible -cpu handling now removes compat=3D option f=
rom
> > >     options passed on to the cpu, so it doesn't trigger further warni=
ngs =20
> >=20
> > This seems to also have another interesting effect.
> >=20
> > getset_compat_deprecated() could be called either during CPU realizatio=
n from:
> >=20
> > object_property_parse()
> > {
> >     Visitor *v =3D string_input_visitor_new(string);
> >     object_property_set(obj, v, name, errp);
> >     ...
> > }
> >=20
> > or during a QOM set operation from:
> >=20
> > void object_property_set_qobject(Object *obj, QObject *value,
> >                                  const char *name, Error **errp)
> > {
> >     Visitor *v;
> >=20
> >     v =3D qobject_input_visitor_new(value);
> >     object_property_set(obj, v, name, errp);
> >     ...
> > }
> >=20
> > or similarly during a QOM get operation with a QObject output visitor.
> >=20
> > The realization path no longer exists with patch 2, so you don't need
> > to implement a null string input visitor anymore. =20
>=20
> s/patch 2/patch 3/?
>=20

Yes indeed, sorry :)

> Is that true though?  It shouldn't get called through that path in
> practice, because we strip the compat property from the cpu object
> properties.  But it could get called if either a) the user explicitly
> creates a cpu object with -device CPU,compat=3Dwhatever or b) if the

Unless I'm missing something, properties of the CPU objects aren't
exposed by CPU devices:

qemu-system-ppc64 -machine pseries \
                  -device POWER8_v2.0-spapr-cpu-core,help
POWER8_v2.0-spapr-cpu-core.core-id=3Dint
POWER8_v2.0-spapr-cpu-core.node-id=3Dint32
POWER8_v2.0-spapr-cpu-core.nr-threads=3Dint

and creation of CPU objects with -object isn't possible either since
they don't inherit from the TYPE_USER_CREATABLE class.

> user uses the compat=3D property with a machine type other than pseries.
>=20

But yes, it is still possible to go through the object_property_parse()
path with another machine type indeed.

> Of course the user *shouldn't* do either of those things, but
> providing a meaningful error if they do is pretty much the whole
> purpose of this getter/setter method.
>=20

All old non-pseries machine types already complain when started with
a POWER7 or newer CPU. Providing the extra error message looks weird:

qemu-system-ppc64 -machine ppce500 \
                  -cpu POWER7,compat=3Dpower6
qemu-system-ppc64: CPU 'compat' property is deprecated and has no effect;
 use max-cpu-compat machine property instead
MMU model 983043 not supported by this machine.

but I guess it's better than crashing. :)

> >=20
> > This means that patch 1 is no longer needed if I get things right but
> > you probably want Markus to second that.
> >  =20
> > >   * Add a migration fix make cpu_synchronize_state() safe in post_load
> > >     handlers, which in turn fixes a bug in 5/5.
> > >   * A number of bugfixes and other tweaks suggested by feedback on v2.
> > >=20
> > > Changes since RFCv2:
> > >   * Many patches dropped, since they're already merged
> > >   * Rebased, fixed conflicts
> > >   * Restored support for backwards migration (wasn't as complicated as
> > >     I thought)
> > >   * Updated final patch's description to more accurately reflect the
> > >     logic
> > >=20
> > > Changes since RFCv1:
> > >   * Change CAS logic to prefer compatibility modes over raw mode
> > >   * Simplified by giving up on half-hearted attempts to maintain
> > >     backwards migration
> > >   * Folded migration stream changes into a single patch
> > >   * Removed some preliminary patches which are already merged
> > >=20
> > > David Gibson (4):
> > >   migration: Mark CPU states dirty before incoming migration/loadvm
> > >   pseries: Move CPU compatibility property to machine
> > >   pseries: Reset CPU compatibility mode
> > >   ppc: Rework CPU compatibility testing across migration
> > >=20
> > > Greg Kurz (1):
> > >   qapi: add explicit null to string input and output visitors
> > >=20
> > >  cpus.c                       |   9 ++++
> > >  hw/ppc/spapr.c               |   8 +++-
> > >  hw/ppc/spapr_cpu_core.c      |  62 +++++++++++++++++++++-----
> > >  hw/ppc/spapr_hcall.c         |   8 ++--
> > >  include/hw/ppc/spapr.h       |  12 +++--
> > >  include/sysemu/cpus.h        |   1 +
> > >  include/sysemu/hax.h         |   1 +
> > >  include/sysemu/hw_accel.h    |  10 +++++
> > >  include/sysemu/kvm.h         |   1 +
> > >  kvm-all.c                    |  10 +++++
> > >  migration/savevm.c           |   2 +
> > >  qapi/string-input-visitor.c  |  11 +++++
> > >  qapi/string-output-visitor.c |  14 ++++++
> > >  target/i386/hax-all.c        |  10 +++++
> > >  target/ppc/compat.c          | 102 +++++++++++++++++++++++++++++++++=
++++++++++
> > >  target/ppc/cpu.h             |   5 ++-
> > >  target/ppc/machine.c         |  72 ++++++++++++++++++++++++++++--
> > >  target/ppc/translate_init.c  |  86 +++++++++++----------------------=
---
> > >  18 files changed, 340 insertions(+), 84 deletions(-)
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/.n1Odr257agVsaHIAexpfA2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlktJuAACgkQAvw66wEB28Lq3ACfQfJeSoQPEpVNx5l9Xb2dXUOr
Y/MAnjxErnw6/nuWuOoSn9oYZUWThLhN
=UUkS
-----END PGP SIGNATURE-----

--Sig_/.n1Odr257agVsaHIAexpfA2--
