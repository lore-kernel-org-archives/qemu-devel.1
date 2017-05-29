Received: from eggs.gnu.org ([2001:4830:134:3::10]:48303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFTrz-0005JO-Aa
	for qemu-devel@nongnu.org; Mon, 29 May 2017 19:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFTrw-0007Y1-6N
	for qemu-devel@nongnu.org; Mon, 29 May 2017 19:14:39 -0400
Received: from 1.mo5.mail-out.ovh.net ([188.165.57.91]:41569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFTrv-0007XY-V6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 19:14:36 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 0DFA9FF411
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 01:14:34 +0200 (CEST)
Date: Tue, 30 May 2017 01:14:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170530011416.01eea576@bahia.ttt.fr.ibm.com>
In-Reply-To: <20170526052319.28096-1-david@gibson.dropbear.id.au>
References: <20170526052319.28096-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/taCIv7YNeMEAhOPeR0Kexcj";
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

--Sig_/taCIv7YNeMEAhOPeR0Kexcj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 26 May 2017 15:23:14 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

[...]
>=20
>=20
> Changes since v3:
>   * Backwards compatible -cpu handling now removes compat=3D option from
>     options passed on to the cpu, so it doesn't trigger further warnings

This seems to also have another interesting effect.

getset_compat_deprecated() could be called either during CPU realization fr=
om:

object_property_parse()
{
    Visitor *v =3D string_input_visitor_new(string);
    object_property_set(obj, v, name, errp);
    ...
}

or during a QOM set operation from:

void object_property_set_qobject(Object *obj, QObject *value,
                                 const char *name, Error **errp)
{
    Visitor *v;

    v =3D qobject_input_visitor_new(value);
    object_property_set(obj, v, name, errp);
    ...
}

or similarly during a QOM get operation with a QObject output visitor.

The realization path no longer exists with patch 2, so you don't need
to implement a null string input visitor anymore.

This means that patch 1 is no longer needed if I get things right but
you probably want Markus to second that.

>   * Add a migration fix make cpu_synchronize_state() safe in post_load
>     handlers, which in turn fixes a bug in 5/5.
>   * A number of bugfixes and other tweaks suggested by feedback on v2.
>=20
> Changes since RFCv2:
>   * Many patches dropped, since they're already merged
>   * Rebased, fixed conflicts
>   * Restored support for backwards migration (wasn't as complicated as
>     I thought)
>   * Updated final patch's description to more accurately reflect the
>     logic
>=20
> Changes since RFCv1:
>   * Change CAS logic to prefer compatibility modes over raw mode
>   * Simplified by giving up on half-hearted attempts to maintain
>     backwards migration
>   * Folded migration stream changes into a single patch
>   * Removed some preliminary patches which are already merged
>=20
> David Gibson (4):
>   migration: Mark CPU states dirty before incoming migration/loadvm
>   pseries: Move CPU compatibility property to machine
>   pseries: Reset CPU compatibility mode
>   ppc: Rework CPU compatibility testing across migration
>=20
> Greg Kurz (1):
>   qapi: add explicit null to string input and output visitors
>=20
>  cpus.c                       |   9 ++++
>  hw/ppc/spapr.c               |   8 +++-
>  hw/ppc/spapr_cpu_core.c      |  62 +++++++++++++++++++++-----
>  hw/ppc/spapr_hcall.c         |   8 ++--
>  include/hw/ppc/spapr.h       |  12 +++--
>  include/sysemu/cpus.h        |   1 +
>  include/sysemu/hax.h         |   1 +
>  include/sysemu/hw_accel.h    |  10 +++++
>  include/sysemu/kvm.h         |   1 +
>  kvm-all.c                    |  10 +++++
>  migration/savevm.c           |   2 +
>  qapi/string-input-visitor.c  |  11 +++++
>  qapi/string-output-visitor.c |  14 ++++++
>  target/i386/hax-all.c        |  10 +++++
>  target/ppc/compat.c          | 102 +++++++++++++++++++++++++++++++++++++=
++++++
>  target/ppc/cpu.h             |   5 ++-
>  target/ppc/machine.c         |  72 ++++++++++++++++++++++++++++--
>  target/ppc/translate_init.c  |  86 +++++++++++-------------------------
>  18 files changed, 340 insertions(+), 84 deletions(-)
>=20


--Sig_/taCIv7YNeMEAhOPeR0Kexcj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlksq0gACgkQAvw66wEB28ID0gCgnU0ZXp7PrSUBG8bTPqlZpCH+
inEAn0qJE/OHVDFB5WD4N5kT06T1u+Nu
=IQJQ
-----END PGP SIGNATURE-----

--Sig_/taCIv7YNeMEAhOPeR0Kexcj--
