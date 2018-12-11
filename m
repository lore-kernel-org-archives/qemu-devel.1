Received: from eggs.gnu.org ([2001:4830:134:3::10]:49681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXbo-0008Mn-SD
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWXRQ-0006l0-CF
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 21:06:35 -0500
Date: Tue, 11 Dec 2018 13:06:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181211020620.GG4261@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-19-clg@kaod.org>
	<39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fc3RSXbRKaEj1MFC"
Content-Disposition: inline
In-Reply-To: <39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v7 18/19] spapr: add a 'pseries-4.0-xive'
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--fc3RSXbRKaEj1MFC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 11:17:33PM +0100, C=E9dric Le Goater wrote:
> On 12/9/18 8:46 PM, C=E9dric Le Goater wrote:
> > This pseries machine makes use of a new sPAPR IRQ backend supporting
> > the XIVE interrupt mode.
> >=20
> > The guest OS is required to have support for the XIVE exploitation
> > mode of the POWER9 interrupt controller.
> >=20
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/spapr.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 4012ebd794a4..3cc134a0b673 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3985,6 +3985,21 @@ static void spapr_machine_4_0_class_options(Mach=
ineClass *mc)
> > =20
> >  DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> > =20
> > +static void spapr_machine_4_0_xive_instance_options(MachineState *mach=
ine)
> > +{
> > +    spapr_machine_4_0_instance_options(machine);
> > +}
> > +
> > +static void spapr_machine_4_0_xive_class_options(MachineClass *mc)
> > +{
> > +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > +
> > +    spapr_machine_4_0_class_options(mc);> +    smc->irq =3D &spapr_irq=
_xive;
>=20
> I have been adding checks on the CPU model to export the XIVE capability=
=20
> only on POWER9 processors but it breaks some of the tests.
>=20
> I was wondering if we could add a default POWER9 CPU to the -xive machine=
 :=20
>=20
>   + mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
>=20
> and if we could change tests/cpu-plug-test.c with :
>=20
>   @@ -198,8 +198,13 @@ static void add_pseries_test_case(const
>        }
>        data =3D g_new(PlugTestData, 1);
>        data->machine =3D g_strdup(mname);
>   -    data->cpu_model =3D "power8_v2.0";
>   -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
>   +    if (g_str_has_suffix(mname, "xive")) {
>   +        data->cpu_model =3D "power9_v2.0";
>   +        data->device_model =3D g_strdup("power9_v2.0-spapr-cpu-core");
>   +    } else {
>   +        data->cpu_model =3D "power8_v2.0";
>   +        data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
>   +    }
>        data->sockets =3D 2;
>        data->cores =3D 3;
>        data->threads =3D 1;
>=20
> or if there is a better way ?

So, I'd actually prefer a machine option, rather than wholly separate
machine types to select xics/xive/dual.  Machine types was fine while
prototyping this, but I don't think we want to actually merge new
machine types for it.

So, instead I think we want a machine option which can be set to
xics/xive/dual, with xics being the default for earlier machine types
and dual the default for 4.0 onwards.  We can make POWER9 the default
cpu for 4.0 onwards as well, if you want.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fc3RSXbRKaEj1MFC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwPG5wACgkQbDjKyiDZ
s5KumRAA27S7RBP7KS2Plel9ii5EXpWtSrc8kOg1Jb2OOEUGPDGXk+Obdyt/hU01
m8TeSUF1bV8mhywIG7hkY23MrIFJVvVehhSiu4DGzBEDPnoZdYiSPeUpW5JDSnNQ
LewAbRQFGRcwcNIZBxI7dK7p78DEwS+n58uoNPf1K/MrTGZngXNOs7e2HXz84HGG
p/vwRX1rAxKKMlIfHW8AYEAoGwJfQ2db7E7Ql7SndB8YkXAZ/oBPeU0Qh6Wkvlf1
nn6h6lLPd9maEeigppkJutZIPzn932MeexgzKXNdBgFEWFPXvZBluFyYJIU/I9ZG
jVzlmzb5A/7DfKpuklHgPzxPWkEfogYC61r5/xsjRVmt92F8yRVienMldJphcojQ
316ijE4HTHLmEo9qT3TdBtyP68QuTdELSTUsWHbKbtBKjMUlqcRbMZtmov7wIrj8
F2WZHog4C4CI6VC1c5xeSE9d8eY8LkGKbyzc0vcdFJhBqZH5VtaUN4UDo743TcGX
XylzLGPyAvot5b9QqANdBZDx9Njf4MpMw1ZnX9cCrKideITihxp5Tvlv7LSo8lXr
FJQOkSotdWgXjhWPGtMzzLBEEs2zDlkrv0qjo/j5nzHQx37IEU6H5fSMs3zgEpPG
psN1RybzdaP0bZ8xo7aBsOuTTua2HCi8yXPWW6IpW2xX1q11zPw=
=M+UU
-----END PGP SIGNATURE-----

--fc3RSXbRKaEj1MFC--
