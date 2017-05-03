Received: from eggs.gnu.org ([2001:4830:134:3::10]:38587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5ycs-0003NB-8s
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d5ycn-000485-B4
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:03:46 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:55508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d5ycn-00045h-1S
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:03:41 -0400
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 5BE52EAB00
	for <qemu-devel@nongnu.org>; Wed,  3 May 2017 20:03:39 +0200 (CEST)
Date: Wed, 3 May 2017 20:03:25 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170503200325.126e75dc@bahia>
In-Reply-To: <20170427072843.8089-1-david@gibson.dropbear.id.au>
References: <20170427072843.8089-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/oD3AAZnvlsetDRiTECh/aHq";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv3 0/4] Clean up compatibility mode handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: clg@kaod.org, aik@ozlabs.ru, mdroth@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com, agraf@suse.de, abologna@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/oD3AAZnvlsetDRiTECh/aHq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Apr 2017 17:28:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This is a rebased and revised version of my patches revising CPU
> compatiblity mode handling on ppc, last posted in November.  Since
> then, many of the patches have already been merged (some for 2.9, some
> since).  This is what's left.
>=20
>  * There was conceptual confusion about what a compatibility mode
>    means, and how it interacts with the machine type.  This cleans
>    that up, clarifying that a compatibility mode (as an externally set
>    option) only makes sense on machine types that don't permit the
>    guest hypervisor privilege (i.e. 'pseries')
>=20
>  * It was previously the user's (or management layer's) responsibility
>    to determine compatibility of CPUs on either end for migration.
>    This uses the compatibility modes to check that properly during an
>    incoming migration.
>=20
> This hasn't been extensively tested yet.  There are quite a few
> migration cases to consider, for example:
>=20

I tested with the following change squashed into patch 2:

--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8428,7 +8428,7 @@ static void getset_compat_deprecated(Object *obj, Vis=
itor=20
                                      void *opaque, Error **errp)
 {
     error_report("CPU 'compat' property is deprecated and has no effect; u=
se ma
-    visit_type_null(v, name, errp);
+    visit_type_null(v, name, NULL);
 }
=20
 static PropertyInfo ppc_compat_deprecated_propinfo =3D {

> Basic:
>=20
> 1) Boot guest with -cpu host
>         Should go into POWER8 compat mode after CAS
>         Previously would have been raw mode
>=20

=3D=3D QEMU =3D=3D

spapr_cas_pvr current=3D0, explicit_match=3D1, new=3Df000004

=3D=3D guest =3D=3D

cpu             : POWER8 (architected), altivec supported

> 2) Boot guest with -machine pseries,max-cpu-compat=3Dpower7 -cpu host
>         Should go into POWER7 compat mode
>=20

=3D=3D QEMU =3D=3D

spapr_cas_pvr current=3Df000003, explicit_match=3D1, new=3Df000003

=3D=3D guest =3D=3D

cpu             : POWER7 (architected), altivec supported


> 3) Boot guest with -cpu host,compat=3Dpower7
>         Should act as (2), but print a warning
>=20

=3D=3D QEMU =3D=3D

We get the following warning as expected:

CPU 'compat' property is deprecated and has no effect; use max-cpu-compat m=
achine property instead

We actually get one per vcpu. This may means a lot of lines if there are
many of them. But I can't think of any simple way to avoid that... the
user will have a motivation to update its command line :)

spapr_cas_pvr current=3Df000003, explicit_match=3D1, new=3Df000003

=3D=3D guest =3D=3D

cpu             : POWER7 (architected), altivec supported

> 4) Boot guest via libvirt with power7 compat mode specified in XML
>         Should act as (3), (2) once we fix libvirt
>=20

Not tested.

> 5) Hack guest to only advertise power7 compatibility, boot with -cpu host
>         Should go into POWER7 compat mode after CAS
>=20

=3D=3D QEMU =3D=3D

spapr_cas_pvr current=3D0, explicit_match=3D1, new=3Df000003

=3D=3D guest =3D=3D

cpu             : POWER7 (architected), altivec supported

> 6) Hack guest to only advertise real PVRs
>         Should remain in POWER8 raw mode after CAS
>=20

=3D=3D QEMU =3D=3D

spapr_cas_pvr current=3D0, explicit_match=3D1, new=3D0

=3D=3D guest =3D=3D

cpu             : POWER8 (raw), altivec supported


> 7) Hack guest to only advertise real PVRs
>    Boot with -machine pseries,max-cpu-compat=3Dpower8
>         Should fail at CAS time
>=20

Calling ibm,client-architecture-support...
WARNING: ibm,client-architecture-support call FAILED!

But as with your RFCv2, the guest boots anyway in compat
mode, even if the guest didn't advertise it:

cpu             : POWER8 (architected), altivec supported

We had discussed about two possible options at the time:
1) terminate the guest (LoPAPR section B.6.2.3)
or
2) just add an error_report()

You seemed to favor 2) at the time, but Sam Bobroff's recent work to
allow MMU mode selection via CAS (commit 9fb4541f5803) explicitly
has QEMU to "terminate the guest if it requests an unavailable mode,
as required by the architecture." (ie, QEMU exits).

Shouldn't we do the same when we asked for compat mode but the client
doesn't advertise any compat PVR ?

> 8) Hack guest to only advertise power7 compatibility, boot with -cpu host
>    Reboot to normal guest
>         Should go to power7 compat mode after CAS of boot 1
>         Should revert to raw mode on reboot
>         SHould go to power8 compat mode after CAS of boot 2
>=20

=3D=3D QEMU =3D=3D

boot 1: spapr_cas_pvr current=3D0, explicit_match=3D1, new=3Df000003
boot 2: spapr_cas_pvr current=3D0, explicit_match=3D1, new=3Df000004

=3D=3D guest =3D=3D

boot 1: cpu             : POWER7 (architected), altivec supported
boot 2: cpu             : POWER8 (architected), altivec supported

> Migration:
>=20

I'll work on testing migration ASAP.

Cheers,

--
Greg

> 9) Boot guest with qemu-2.6 -machine pseries-2.6 -cpu host
>    Migrate to qemu-2.8 -machine pseries-2.6 -cpu host
>         Should work, end up running in power8 raw mode
>=20
> 10) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host
>     Migrate to qemu-2.8 -machine pseries-2.7 -cpu host
>         Should work, end up running in power8 raw mode
>=20
> 11) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host,compat=3Dpowe=
r7
>     Migrate to qemu-2.8 -machine pseries-2.7 -cpu host,compat=3Dpower7
>         Should work, be running in POWER7 compat after, but give warning =
like
>         (3)
>=20
> 12) Boot guest with qemu-2.7 -machine pseries-2.7 -cpu host,compat=3Dpowe=
r7
>     Migrate to qemu-2.8 -machine pseries-2.7,max-cpu-compat=3Dpower7 -cpu=
 host
>         Should work, be running in POWER7 compat after, no warning
>=20
> 13) Boot to SLOF with qemu-2.6 -machine pseries-2.6 -cpu host
>     Migrate to qemu-2.8 -machine pseries-2.6 -cpu host
>=20
>         ?
>=20
> 14) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host
>     Migrate to qemu-2.8 -machine pseries-2.7 -cpu host
>         ?
>=20
> 15) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host,compat=3Dpo=
wer7
>     Migrate to qemu-2.8 -machine pseries-2.7 -cpu host,compat=3Dpower7
>         ?
>=20
> 16) Boot to SLOF with qemu-2.7 -machine pseries-2.7 -cpu host,compat=3Dpo=
wer7
>     Migrate to qemu-2.8 -machine pseries-2.7,max-cpu-compat=3Dpower7 -cpu=
 host
>         ?
>=20
> 17) Boot guest with qemu-2.6 -machine pseries-2.6 -cpu host
>     Migrate to qemu-2.7.z -machine pseries-2.6 -cpu host
>         Should work
>=20
> 18) Hack guest to only advertise power7 compatibility, boot with -cpu host
>     Boot with qemu-2.8, migrate to qemu-2.8
>         Should be in power7 compat mode after CAS on source, and still
>         in power7 compat mode on destination
>=20
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
>=20
>=20
> David Gibson (3):
>   pseries: Move CPU compatibility property to machine
>   pseries: Reset CPU compatibility mode
>   ppc: Rework CPU compatibility testing across migration
>=20
> Greg Kurz (1):
>   qapi: add explicit null to string input and output visitors
>=20
>  hw/ppc/spapr.c               |  8 ++++-
>  hw/ppc/spapr_cpu_core.c      | 47 +++++++++++++++++++------
>  hw/ppc/spapr_hcall.c         |  2 +-
>  include/hw/ppc/spapr.h       | 12 ++++---
>  qapi/string-input-visitor.c  | 11 ++++++
>  qapi/string-output-visitor.c | 14 ++++++++
>  target/ppc/compat.c          | 65 ++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h             |  6 ++--
>  target/ppc/machine.c         | 71 +++++++++++++++++++++++++++++++++++--
>  target/ppc/translate_init.c  | 84 ++++++++++++--------------------------=
------
>  10 files changed, 238 insertions(+), 82 deletions(-)
>=20


--Sig_/oD3AAZnvlsetDRiTECh/aHq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkKG20ACgkQAvw66wEB28LPugCfcy11X4bBB2PLAo8plh1fH3DI
CUsAn0AEG4NuPteXMXYCPirhlE0VONus
=+J6m
-----END PGP SIGNATURE-----

--Sig_/oD3AAZnvlsetDRiTECh/aHq--
