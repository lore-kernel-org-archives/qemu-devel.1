Received: from eggs.gnu.org ([2001:4830:134:3::10]:57712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFzTU-0002Sr-VZ
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFzTQ-0005yo-2t
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:59:29 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:33993)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFzTP-0005y2-PP
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:59:24 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 169CC10034B
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 10:59:21 +0200 (CEST)
Date: Wed, 31 May 2017 10:58:57 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531105857.62a25a84@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170531025748.GG12163@umbus.fritz.box>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
	<20170530011416.01eea576@bahia.ttt.fr.ibm.com>
	<20170530061852.GE12163@umbus.fritz.box>
	<20170530100136.680ce96f@bahia.ttt.fr.ibm.com>
	<20170531025748.GG12163@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/1kBas2Y+VIPFqlDmRgjPklf";
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

--Sig_/1kBas2Y+VIPFqlDmRgjPklf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 12:57:48 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:
> [...]
> > All old non-pseries machine types already complain when started with
> > a POWER7 or newer CPU. Providing the extra error message looks weird:
> >=20
> > qemu-system-ppc64 -machine ppce500 \
> >                   -cpu POWER7,compat=3Dpower6
> > qemu-system-ppc64: CPU 'compat' property is deprecated and has no effec=
t;
> >  use max-cpu-compat machine property instead
> > MMU model 983043 not supported by this machine.
> >=20
> > but I guess it's better than crashing. :) =20
>=20
> Well, sure POWER7 doesn't make sense for an e500 machine for other
> reasons.  But POWER7 or POWER8 _would_ make sense for powernv, where
> compat=3D doesn't.
>=20

The powernv machine type doesn't even support CPU features at all:

    chip_typename =3D g_strdup_printf(TYPE_PNV_CHIP "-%s", machine->cpu_mod=
el);
    if (!object_class_by_name(chip_typename)) {
        error_report("invalid CPU model '%s' for %s machine",
                     machine->cpu_model, MACHINE_GET_CLASS(machine)->name);
        exit(1);
    }

> >  =20
> > > >=20
> > > > This means that patch 1 is no longer needed if I get things right b=
ut
> > > > you probably want Markus to second that.
> > > >    =20
> > > > >   * Add a migration fix make cpu_synchronize_state() safe in post=
_load
> > > > >     handlers, which in turn fixes a bug in 5/5.
> > > > >   * A number of bugfixes and other tweaks suggested by feedback o=
n v2.
> > > > >=20
> > > > > Changes since RFCv2:
> > > > >   * Many patches dropped, since they're already merged
> > > > >   * Rebased, fixed conflicts
> > > > >   * Restored support for backwards migration (wasn't as complicat=
ed as
> > > > >     I thought)
> > > > >   * Updated final patch's description to more accurately reflect =
the
> > > > >     logic
> > > > >=20
> > > > > Changes since RFCv1:
> > > > >   * Change CAS logic to prefer compatibility modes over raw mode
> > > > >   * Simplified by giving up on half-hearted attempts to maintain
> > > > >     backwards migration
> > > > >   * Folded migration stream changes into a single patch
> > > > >   * Removed some preliminary patches which are already merged
> > > > >=20
> > > > > David Gibson (4):
> > > > >   migration: Mark CPU states dirty before incoming migration/load=
vm
> > > > >   pseries: Move CPU compatibility property to machine
> > > > >   pseries: Reset CPU compatibility mode
> > > > >   ppc: Rework CPU compatibility testing across migration
> > > > >=20
> > > > > Greg Kurz (1):
> > > > >   qapi: add explicit null to string input and output visitors
> > > > >=20
> > > > >  cpus.c                       |   9 ++++
> > > > >  hw/ppc/spapr.c               |   8 +++-
> > > > >  hw/ppc/spapr_cpu_core.c      |  62 +++++++++++++++++++++-----
> > > > >  hw/ppc/spapr_hcall.c         |   8 ++--
> > > > >  include/hw/ppc/spapr.h       |  12 +++--
> > > > >  include/sysemu/cpus.h        |   1 +
> > > > >  include/sysemu/hax.h         |   1 +
> > > > >  include/sysemu/hw_accel.h    |  10 +++++
> > > > >  include/sysemu/kvm.h         |   1 +
> > > > >  kvm-all.c                    |  10 +++++
> > > > >  migration/savevm.c           |   2 +
> > > > >  qapi/string-input-visitor.c  |  11 +++++
> > > > >  qapi/string-output-visitor.c |  14 ++++++
> > > > >  target/i386/hax-all.c        |  10 +++++
> > > > >  target/ppc/compat.c          | 102 +++++++++++++++++++++++++++++=
++++++++++++++
> > > > >  target/ppc/cpu.h             |   5 ++-
> > > > >  target/ppc/machine.c         |  72 ++++++++++++++++++++++++++++--
> > > > >  target/ppc/translate_init.c  |  86 +++++++++++------------------=
-------
> > > > >  18 files changed, 340 insertions(+), 84 deletions(-)
> > > > >    =20
> > > >    =20
> > >=20
> > >=20
> > >  =20
> >  =20
>=20
>=20
>=20


--Sig_/1kBas2Y+VIPFqlDmRgjPklf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkuhdEACgkQAvw66wEB28IAdQCfev5x4sPDjarcV2OL4I++cnqD
DgMAmwWru6Jg+rI5boPJvr6yvzChV+tK
=9whp
-----END PGP SIGNATURE-----

--Sig_/1kBas2Y+VIPFqlDmRgjPklf--
