Received: from eggs.gnu.org ([2001:4830:134:3::10]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dgyg2-0005hZ-LF
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dgyfx-0001Em-Hc
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:35:58 -0400
Received: from 12.mo6.mail-out.ovh.net ([178.32.125.228]:35079)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dgyfx-0000xU-AD
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 15:35:53 -0400
Received: from player735.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 72592FED2F
	for <qemu-devel@nongnu.org>; Sun, 13 Aug 2017 21:35:42 +0200 (CEST)
Date: Sun, 13 Aug 2017 21:35:34 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170813213534.0d40b745@bahia.lan>
In-Reply-To: <20170812121651.497c6e39@bahia.lan>
References: <1502527090-11473-1-git-send-email-thuth@redhat.com>
	<20170812121651.497c6e39@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/USu84cntsumUzNYKaN=m4x.";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/ppc/spapr_cpu_core: Add a
 proper check for spapr machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

--Sig_/USu84cntsumUzNYKaN=m4x.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Aug 2017 12:16:51 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Sat, 12 Aug 2017 10:38:10 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
> > QEMU currently crashes when the user tries to add a spapr-cpu-core
> > on a non-pseries machine:
> >=20
> > $ qemu-system-ppc64 -S -machine ppce500,accel=3Dtcg \
> >                     -device POWER5+_v2.1-spapr-cpu-core
> > hw/ppc/spapr_cpu_core.c:178:spapr_cpu_core_realize_child:
> > Object 0x55cee1f55160 is not an instance of type spapr-machine
> > Aborted (core dumped)
> >=20
> > So let's add a proper check for the correct machine time with
> > a more friendly error message here.
> >=20
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  hw/ppc/spapr_cpu_core.c   | 9 ++++++++-
> >  scripts/device-crash-test | 1 +
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index ea278ce..0f3d653 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -175,11 +175,18 @@ static void spapr_cpu_core_unrealizefn(DeviceStat=
e *dev, Error **errp)
> >  static void spapr_cpu_core_realize_child(Object *child, Error **errp)
> >  {
> >      Error *local_err =3D NULL;
> > -    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_machine());
> > +    sPAPRMachineState *spapr;
> >      CPUState *cs =3D CPU(child);
> >      PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> >      Object *obj;
> > =20
> > +    spapr =3D (sPAPRMachineState *)object_dynamic_cast(qdev_get_machin=
e(),
> > +                                                     TYPE_SPAPR_MACHIN=
E);
> > +    if (!spapr) {
> > +        error_setg(errp, "spapr-cpu-core needs a pseries machine");
> > +        return;
> > +    }
> > + =20
>=20
> This is the realize function for individual threads. Maybe this sanity ch=
eck
> should be performed earlier at the core level in spapr_cpu_core_realize()=
 ?
>=20
> Also, spapr_cpu_core_realize_child() seem to only have spapr to pass it d=
own
> to spapr_cpu_init()... ie, not even sure spapr_cpu_core_realize_child()
> actually needs a spapr variable.
>=20

And spapr_cpu_init() doesn't even need the spapr machine object itself: it
only needs the TYPE_PPC_VIRTUAL_HYPERVISOR object. I guess the right fix
would be for spapr cpu core to have a "ppc-virtual-hypervisor property set
in spapr_cpu_init() and tested in spapr_cpu_core_realize(). If the change
is considered to be too invasive during hard freeze, I guess a sanity check
in spapr_cpu_core_realize() is enough for now as a temporary bug fix.

> >      object_property_set_bool(child, true, "realized", &local_err);
> >      if (local_err) {
> >          goto error;
> > diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> > index e77b693..8eb2d02 100755
> > --- a/scripts/device-crash-test
> > +++ b/scripts/device-crash-test
> > @@ -200,6 +200,7 @@ ERROR_WHITELIST =3D [
> >      {'log':r"Multiple VT220 operator consoles are not supported"},
> >      {'log':r"core 0 already populated"},
> >      {'log':r"could not find stage1 bootloader"},
> > +    {'log':r"spapr-cpu-core needs a pseries machine"},
> > =20
> >      # other exitcode=3D1 failures not listed above will just generate =
INFO messages:
> >      {'exitcode':1, 'loglevel':logging.INFO}, =20
>=20


--Sig_/USu84cntsumUzNYKaN=m4x.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmQqgYACgkQAvw66wEB28IeVwCeN8zg+qZyf/D/O/gQHeR0Zr/8
WYMAn3kq+AzzXCwfqe0C3QIYkLHnnSDV
=hQPa
-----END PGP SIGNATURE-----

--Sig_/USu84cntsumUzNYKaN=m4x.--
