Received: from eggs.gnu.org ([209.51.188.92]:49698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcn-0004Ak-1t
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvvcl-0001X1-Be
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 21:59:12 -0500
Date: Tue, 19 Feb 2019 12:21:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190219012104.GG9345@umbus.fritz.box>
References: <20190218101218.4177-1-ppandit@redhat.com>
	<20190218123811.5b7a1d61@bahia.lan>
	<20190218115218.GF32287@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lQSB8Tqijvu1+4Ba"
Content-Disposition: inline
In-Reply-To: <20190218115218.GF32287@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3] ppc: add host-serial and
 host-model machine attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, P J P <ppandit@redhat.com>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>


--lQSB8Tqijvu1+4Ba
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 11:52:18AM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Feb 18, 2019 at 12:38:11PM +0100, Greg Kurz wrote:
> > On Mon, 18 Feb 2019 15:42:18 +0530
> > P J P <ppandit@redhat.com> wrote:
> >=20
> > > From: Prasad J Pandit <pjp@fedoraproject.org>
> > >=20
> > > On ppc hosts, hypervisor shares following system attributes
> > >=20
> > >   - /proc/device-tree/system-id
> > >   - /proc/device-tree/model
> > >=20
> > > with a guest. This could lead to information leakage and misuse.[*]
> > > Add machine attributes to control such system information exposure
> > > to a guest.
> > >=20
> > > [*] https://wiki.openstack.org/wiki/OSSN/OSSN-0028
> > >=20
> > > Reported-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Fix-suggested-by: Daniel P. Berrang=E9 <berrange@redhat.com>
> > > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> > > ---
> > >  hw/ppc/spapr.c         | 79 ++++++++++++++++++++++++++++++++++++++--=
--
> > >  include/hw/ppc/spapr.h |  2 ++
> > >  2 files changed, 75 insertions(+), 6 deletions(-)
> > >=20
> > > Update v3: move host-serial,host-model options to ppc sPAPR machine
> > >   -> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03182.h=
tml =20
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 0942f35bf8..666e500376 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1249,13 +1249,30 @@ static void *spapr_build_fdt(sPAPRMachineStat=
e *spapr,
> > >       * Add info to guest to indentify which host is it being run on
> > >       * and what is the uuid of the guest
> > >       */
> > > -    if (kvmppc_get_host_model(&buf)) {
> > > -        _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> > > -        g_free(buf);
> > > +    if (spapr->host_model && !g_str_equal(spapr->host_model, "none")=
) {
> > > +        if (g_str_equal(spapr->host_model, "passthrough")) {
> > > +            /* -M host-model=3Dpassthrough */
> > > +            if (kvmppc_get_host_model(&buf)) {
> > > +                _FDT(fdt_setprop_string(fdt, 0, "host-model", buf));
> > > +                g_free(buf);
> > > +            }
> > > +        } else {
> > > +            /* -M host-model=3D<user-string> */
> > > +            _FDT(fdt_setprop_string(fdt, 0, "host-model", spapr->hos=
t_model));
> > > +        }
> > >      }
> > > -    if (kvmppc_get_host_serial(&buf)) {
> > > -        _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> > > -        g_free(buf);
> > > +
> > > +    if (spapr->host_serial && !g_str_equal(spapr->host_serial, "none=
")) {
> > > +        if (g_str_equal(spapr->host_serial, "passthrough")) {
> > > +            /* -M host-serial=3Dpassthrough */
> > > +            if (kvmppc_get_host_serial(&buf)) {
> > > +                _FDT(fdt_setprop_string(fdt, 0, "host-serial", buf));
> > > +                g_free(buf);
> > > +            }
> > > +        } else {
> > > +            /* -M host-serial=3D<user-string> */
> > > +            _FDT(fdt_setprop_string(fdt, 0, "host-serial", spapr->ho=
st_serial));
> > > +        }
> > >      }
> > > =20
> > >      buf =3D qemu_uuid_unparse_strdup(&qemu_uuid);
> > > @@ -3138,6 +3155,36 @@ static void spapr_set_ic_mode(Object *obj, con=
st char *value, Error **errp)
> > >      }
> > >  }
> > > =20
> > > +static char *spapr_get_host_model(Object *obj, Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    return g_strdup(spapr->host_model);
> > > +}
> > > +
> > > +static void spapr_set_host_model(Object *obj, const char *value, Err=
or **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    g_free(spapr->host_model);
> > > +    spapr->host_model =3D g_strdup(value);
> > > +}
> > > +
> > > +static char *spapr_get_host_serial(Object *obj, Error **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    return g_strdup(spapr->host_serial);
> > > +}
> > > +
> > > +static void spapr_set_host_serial(Object *obj, const char *value, Er=
ror **errp)
> > > +{
> > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    g_free(spapr->host_serial);
> > > +    spapr->host_serial =3D g_strdup(value);
> > > +}
> > > +
> > >  static void spapr_instance_init(Object *obj)
> > >  {
> > >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > @@ -3183,6 +3230,20 @@ static void spapr_instance_init(Object *obj)
> > >      object_property_set_description(obj, "ic-mode",
> > >                   "Specifies the interrupt controller mode (xics, xiv=
e, dual)",
> > >                   NULL);
> > > +
> > > +    spapr->host_model =3D NULL;
> >=20
> > This isn't needed since object_initialize_with_type() already takes care
> > of zeroing the instance for us.
> >=20
> > > +    object_property_add_str(obj, "host-model",
> > > +        spapr_get_host_model, spapr_set_host_model,
> > > +        &error_abort);
> > > +    object_property_set_description(obj, "host-model",
> > > +        "Set host's model-id to use - none|passthrough|string", &err=
or_abort);
> > > +
> > > +    spapr->host_serial =3D NULL;
> >=20
> > Same here.
> >=20
> > > +    object_property_add_str(obj, "host-serial",
> > > +        spapr_get_host_serial, spapr_set_host_serial,
> > > +        &error_abort);
> > > +    object_property_set_description(obj, "host-serial",
> > > +        "Set host's system-id to use - none|passthrough|string", &er=
ror_abort);
> > >  }
> > > =20
> > >  static void spapr_machine_finalizefn(Object *obj)
> > > @@ -4080,9 +4141,15 @@ DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> > >  static void spapr_machine_3_1_class_options(MachineClass *mc)
> > >  {
> > >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > > +    static GlobalProperty compat[] =3D {
> > > +        { TYPE_SPAPR_MACHINE, "host-model", "passthrough" },
> > > +        { TYPE_SPAPR_MACHINE, "host-serial", "passthrough" },
> > > +    };
> > > =20
> >=20
> > So... we don't fix the information leak for older machines by default ?=
 From
> > previous discussions, I understand it is for the sake of compatibility,=
 but
> > leaving the burden of securing the host to downstream or to the user st=
ill
> > looks unsecure to me FWIW.
>=20
> Maintaining guest ABI compatibility has to take priority, even over
> fixing security issues, because we must never intentionally break
> guest OS/applications by silently altering guest ABI. This is one of
> the two reasons why machine type versioning exists (the other reason
> being live migration data stream).
>=20
> This is nothing new - we've done it before for security flaws where
> a fix would involve changing guest ABI. This particular security flaw
> is pretty minor compared to other cases that we've left unfixed by
> default eg Meltdown / Spectre and is easily addressed by the user if
> needed.

So, Markus was saying at the last KVM Forum - and I agree with him -
that using "must maintain compatibility" as if its holy writ isn't
actually very sensible.  It's always a tradeoff, and we need to engage
with that tradeoff on a case by case basis.

In this case the security hole it fixes is pretty small - but the
chances of realistically breaking the guests is also very small.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--lQSB8Tqijvu1+4Ba
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxrWf0ACgkQbDjKyiDZ
s5LWEg/9GcnSf0ocqitrSnrVwlQacIhzzB4AQSJY84FiZ5YSu79Bf5rFfsQZIzyj
a9YR+TFkXPyLnMfl0pHr1FWwuEehEW9LXIO+SDvzHcbcrZhTbqUNqasfKOk5j76N
oAWVQ/eRwXYz6v3Q7uBtQO4nkrLsi5d84ENW+3t0EwULzmwFsbCM4geLr3ZkplRU
ZEnSNp/l/ZcZeChRiBX/zST0Ar4239yw17cln1SQyLZd9nkPUjG4RG4pqD/Pv/zL
JYbDHs468wnmzLELLK3N6Rb0xXEvhGZvbIZ9O415xCdTk68gMRGr8OAHXadU3Rez
woVtIqLUmRgQ9faUXaht2euIt7a4vQeen3Hg7IlzJi2zLMRTZ6FguXHuqyIgHRuh
/0QFsxX1RciNC32BZNl/JrCm2QK1VEmwm3tSfLsUedsKnra+/RlEHH8XCKn1MOLK
UpjA0tBDrMC71tY3LkVgdhxsapgoOJU7ssYdpVpHSzqibsrV4U83pYj+hV6O7y8h
7DfDrSGwtjO+GBberNIDjG3n58H8tfxResQi1hL1yPWTX0VfKJl1RfHkX51PSzl2
CtedAH+CoPTbWt91yW3CwQssSaK+CMJ3v/nuDCOE4hvUsNi5cWAz/Z6jMlFGFVrW
nE4VzW7hQEX0KH7+GmKw0D5zYEqZn6tGC2xl9nKncBLsCcpG+p0=
=lWKK
-----END PGP SIGNATURE-----

--lQSB8Tqijvu1+4Ba--
