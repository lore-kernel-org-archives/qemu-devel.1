Received: from eggs.gnu.org ([2001:4830:134:3::10]:37636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXG-0005CU-Q6
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gWsXF-0002fz-Ne
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 19:37:58 -0500
Date: Wed, 12 Dec 2018 11:34:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181212003459.GF2719@umbus.fritz.box>
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-19-clg@kaod.org>
	<39e8edd0-6056-5b51-174b-631dcb267ff5@kaod.org>
	<20181211020620.GG4261@umbus.fritz.box>
	<744ff9f8-6f84-00d4-a2e0-84652658762e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <744ff9f8-6f84-00d4-a2e0-84652658762e@kaod.org>
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


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 11, 2018 at 11:42:03AM +0100, C=E9dric Le Goater wrote:
> On 12/11/18 3:06 AM, David Gibson wrote:
> > On Mon, Dec 10, 2018 at 11:17:33PM +0100, C=E9dric Le Goater wrote:
> >> On 12/9/18 8:46 PM, C=E9dric Le Goater wrote:
> >>> This pseries machine makes use of a new sPAPR IRQ backend supporting
> >>> the XIVE interrupt mode.
> >>>
> >>> The guest OS is required to have support for the XIVE exploitation
> >>> mode of the POWER9 interrupt controller.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>> ---
> >>>  hw/ppc/spapr.c | 15 +++++++++++++++
> >>>  1 file changed, 15 insertions(+)
> >>>
> >>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> >>> index 4012ebd794a4..3cc134a0b673 100644
> >>> --- a/hw/ppc/spapr.c
> >>> +++ b/hw/ppc/spapr.c
> >>> @@ -3985,6 +3985,21 @@ static void spapr_machine_4_0_class_options(Ma=
chineClass *mc)
> >>> =20
> >>>  DEFINE_SPAPR_MACHINE(4_0, "4.0", true);
> >>> =20
> >>> +static void spapr_machine_4_0_xive_instance_options(MachineState *ma=
chine)
> >>> +{
> >>> +    spapr_machine_4_0_instance_options(machine);
> >>> +}
> >>> +
> >>> +static void spapr_machine_4_0_xive_class_options(MachineClass *mc)
> >>> +{
> >>> +    sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >>> +
> >>> +    spapr_machine_4_0_class_options(mc);> +    smc->irq =3D &spapr_i=
rq_xive;
> >>
> >> I have been adding checks on the CPU model to export the XIVE capabili=
ty=20
> >> only on POWER9 processors but it breaks some of the tests.
> >>
> >> I was wondering if we could add a default POWER9 CPU to the -xive mach=
ine :=20
> >>
> >>   + mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
> >>
> >> and if we could change tests/cpu-plug-test.c with :
> >>
> >>   @@ -198,8 +198,13 @@ static void add_pseries_test_case(const
> >>        }
> >>        data =3D g_new(PlugTestData, 1);
> >>        data->machine =3D g_strdup(mname);
> >>   -    data->cpu_model =3D "power8_v2.0";
> >>   -    data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core");
> >>   +    if (g_str_has_suffix(mname, "xive")) {
> >>   +        data->cpu_model =3D "power9_v2.0";
> >>   +        data->device_model =3D g_strdup("power9_v2.0-spapr-cpu-core=
");
> >>   +    } else {
> >>   +        data->cpu_model =3D "power8_v2.0";
> >>   +        data->device_model =3D g_strdup("power8_v2.0-spapr-cpu-core=
");
> >>   +    }
> >>        data->sockets =3D 2;
> >>        data->cores =3D 3;
> >>        data->threads =3D 1;
> >>
> >> or if there is a better way ?
> >=20
> > So, I'd actually prefer a machine option, rather than wholly separate
> > machine types to select xics/xive/dual.  Machine types was fine while
> > prototyping this, but I don't think we want to actually merge new
> > machine types for it.
>=20
> I agree.=20
>=20
> > So, instead I think we want a machine option which can be set to
> > xics/xive/dual, with xics being the default for earlier machine types
> > and dual the default for 4.0 onwards.
>=20
> I will revive an old patch doing just that.=20
>=20
> The question now is how to link the sPAPRMachineState instance to=20
> the selected sPAPR IRQ backend.=20
>=20
> I don't think we can move 'smc->irq' to sPAPRMachineState.

I think you could..

> So we will
> need an helper returning the appropriate backend depending on the machine=
=20
> option and 'smc->irq' should disappear.

=2E.but this approach might be easier.

>=20
> > We can make POWER9 the default cpu for 4.0 onwards as well, if you want.
>=20
> OK.
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwQV7MACgkQbDjKyiDZ
s5I6UhAAw8eJsK1tNGX+6Vm+F3lOMT/KrlhTz3HhNKFfZzpBVSVe+JPPomiazJ0c
snFdhqxj6tz0kPHAFG8IGMDgCXqYvhWHjSAbyxwQ3FSCzutwmOrwN0JNSnbs+5oC
/1IBUhovjNlfmxTg6E3qL/P1OEuI/o6izOivCMW09LAi/ffYd/A+nQ9qWk7CYAmn
whbzgRxX2FBStNfd/KPWWRBjYvFdJDRU3ywx7fbJMS5eV3+iwDmtI9ZQQfGDhp65
0AAjmVluGbzhN/Jy26ZSP0E91S5uGYpLReX99OWSGvm5RatuAWtOnuGMC3c99Y0v
7MiBBVBFfjzsaH5BclenAIda8u9MMr5lf2gpSWmsPIVchWndMopdB9V0M+wivxeK
3x+12QZDJy2YryZ3UnpZAWq/rNuRkz/kD0kqg0P2Q8KPaRTBSxxz17azMbnMVFXj
pUDgizVhNMh1vFfz1KU6mq/DSIPe8bUPZZA53Mw1Beo0SH449nSlT18b8qCwRkuI
EsNtgIJbMqtu80/vM5J+2dWG3PAHX4nhgoxJcjpWWP32VN/C4styJpv4MBa3A6oB
gTQ9xHyRJ4sWdmfLDsYFtteAgkVRVYOQbE4HEZIpuJPqxdTqQItSeyCogD5tNxyr
k33hvUGrTDOQLk3HxDFmjdijK2z/0cfkS8moFN+qSA9l8rFzA0U=
=sG14
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
