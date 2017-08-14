Received: from eggs.gnu.org ([2001:4830:134:3::10]:45036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78m-0001qc-Rs
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dh78j-0006MO-OT
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 00:38:12 -0400
Date: Mon, 14 Aug 2017 13:24:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170814032456.GA3452@umbus.fritz.box>
References: <1502527090-11473-1-git-send-email-thuth@redhat.com>
	<20170812121651.497c6e39@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <20170812121651.497c6e39@bahia.lan>
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
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2017 at 12:16:51PM +0200, Greg Kurz wrote:
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
> > +
>=20
> This is the realize function for individual threads. Maybe this sanity ch=
eck
> should be performed earlier at the core level in spapr_cpu_core_realize()=
 ?

Ah, yes, that would be a better way of doing it.

I'm also not clear if you're proposing this for 2.10 or 2.11.

> Also, spapr_cpu_core_realize_child() seem to only have spapr to pass it d=
own
> to spapr_cpu_init()... ie, not even sure spapr_cpu_core_realize_child()
> actually needs a spapr variable.



>=20
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
> >      {'exitcode':1, 'loglevel':logging.INFO},
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmRGAYACgkQbDjKyiDZ
s5KeRQ/9HBrOrs1WLDN1ycASd9NJ7zZWk5uWebah7EBy8LfxsVdWNYvigdQ5fFzz
MfRdDhJuL1NJxswPwvIw45aCK8yBnirpbCyH9xT4g9pCyP09Zzk20eVmIkWYAcbk
w6CRcM2MZL5R5jJOShIEqREt/Uc5tALzCSbOpafn8mw0LjTm5b0HBZpNa4GP2s2M
2GrXlVn0MG3b+suA/0vq8WAUFp4RhdkAiArsEjvXr3DME/BsqWiBkdDwINBpHtLh
Ji3Z9dOO+iZI549fhQ1nbhpaPvdHzP4YWHX1kjWAzLXwfsoj91lXyUJkSGrJ0+qR
s5BJyddIBj7RiwwbDwJvQJejdPrxxOgYDCuleXHjCI7/TFCaKz3qYfZXMK4+mJQg
P4vf1Y1pwjgil6dGmuxzqYGi7kRd/BYDODhtArLkdGAbYGW7Id+opv5A39jxxjkH
8LcrFmzN0gLL6RuQrpkLSVwJlGxkTEkHxecOTaphr/JNAlIkLhH4QsB+H4X4e8g+
nmoUi1JLuh/cmINOqYK42hmPXEg2vpk2JwsyRxCQTmSXwGMLAOml7WF+KwBuXzAw
MdSz47cAPQJBLskvNTyqJ5wYTmZKzTimTnoYiB6/2br9OjuJC8rwoC45gRCteSQJ
SoqOx12jexyebcu8Hp0WJ27k2gk5K1HBKHnjlRRY6V1XVDhgJh0=
=kKkI
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
