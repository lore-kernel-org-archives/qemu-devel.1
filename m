Received: from eggs.gnu.org ([2001:4830:134:3::10]:36714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRNQ-0004tV-CL
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:23:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ekRNM-0000Rs-AD
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 04:23:20 -0500
Date: Sat, 10 Feb 2018 20:23:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180210092307.GQ11634@umbus.fritz.box>
References: <20180209081858.27013-1-lvivier@redhat.com>
	<20180209150649.7f557ff9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FmdPcZLZZW6lDAYm"
Content-Disposition: inline
In-Reply-To: <20180209150649.7f557ff9@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: set vsmt to MAX(8, smp_threads)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--FmdPcZLZZW6lDAYm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2018 at 03:06:49PM +0100, Greg Kurz wrote:
> On Fri,  9 Feb 2018 09:18:58 +0100
> Laurent Vivier <lvivier@redhat.com> wrote:
>=20
> > We ignore silently the value of smp_threads when we set
> > the default VSMT value, and if smp_threads is greater than VSMT
> > kernel is going into trouble later.
> >=20
>=20
> Hi Laurent,
>=20
> I've looked a bit more and I'm not sure what kernel troubles you're refer=
ring to,
> but several places in QEMU where we use kvm_ppc_smt() later on do assume =
that
> smp_threads > kvm_ppc_smt(). Basically, everywhere we compute a vCPU id:
>=20
> In spapr_init_cpus() when creating DRC connectors:
>=20
>         int core_id =3D i * smp_threads;
>=20
>         if (mc->has_hotpluggable_cpus) {
>             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
>                                    (core_id / smp_threads) * smt);
>         }
>=20
> or in spapr_cpu_core_realize() when creating vCPUs:
>=20
>         cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) + i;
>=20
> It is visible by adding some printfs in the current code base. This is wh=
at
> happens when passing -smp cores=3D2,threads=3D16 without your patch:
>=20
> DRC connector to vcpu_id 0
> CPU vcpu_id 0
> CPU vcpu_id 1
> CPU vcpu_id 2
> CPU vcpu_id 3
> CPU vcpu_id 4
> CPU vcpu_id 5
> CPU vcpu_id 6
> CPU vcpu_id 7
> CPU vcpu_id 8
> CPU vcpu_id 9
> CPU vcpu_id 10
> CPU vcpu_id 11
> CPU vcpu_id 12
> CPU vcpu_id 13
> CPU vcpu_id 14
> CPU vcpu_id 15
> DRC connector to vcpu_id 8
>                         ^^^
>                      should be 16
> CPU vcpu_id 8
>            ^^^
>    should start numbering at 16
> CPU vcpu_id 9
> CPU vcpu_id 10
> CPU vcpu_id 11
> CPU vcpu_id 12
> CPU vcpu_id 13
> CPU vcpu_id 14
> CPU vcpu_id 15
> CPU vcpu_id 16
> CPU vcpu_id 17
> CPU vcpu_id 18
> CPU vcpu_id 19
> CPU vcpu_id 20
> CPU vcpu_id 21
> CPU vcpu_id 22
> CPU vcpu_id 23
> qemu-system-ppc64: kvm_init_vcpu failed: File exists
>                                               ^^^^
>                                  CPU 8 already created by the first core
>=20
> I'm not feeling comfortable with the rest of the code silently depending =
on
> the fact that spapr_set_vsmt_mode() terminates QEMU if it cannot enforce
> smp_threads <=3D kvm_ppc_smt().

I'm not quite sure what you're suggesting as an alternative, though.

>=20
> Anyway, with your patch, the same command line as above gives:
>=20
> qemu-system-ppc64: Failed to set KVM's VSMT mode to 16 (errno -22)
> On PPC, a VM with 16 threads/core on a host with 8 threads/core requires
>  the use of VSMT mode 16.
> This KVM seems to be too old to support VSMT.
>=20
> This hammer is big enough to fix the vCPU ids miscalculations, so:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
> > Fixes: 8904e5a750
> > ("spapr: Adjust default VSMT value for better migration compatibility")
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >=20
> > Notes:
> >     v3: use MAX(8, smp_threads) and let KVM to return an error
> >         if nb_threads is too big
> >         update subject to reflect the change
> >    =20
> >     v2: display a specific error message when the default VSMT is used
> >         fix subject
> >=20
> >  hw/ppc/spapr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 32a876be56..c8a1eefa17 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2310,7 +2310,7 @@ static void spapr_set_vsmt_mode(sPAPRMachineState=
 *spapr, Error **errp)
> >           * the value that we'd get with KVM on POWER8, the
> >           * overwhelmingly common case in production systems.
> >           */
> > -        spapr->vsmt =3D 8;
> > +        spapr->vsmt =3D MAX(8, smp_threads);
> >      }
> > =20
> >      /* KVM: If necessary, set the SMT mode: */
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FmdPcZLZZW6lDAYm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlp+ufsACgkQbDjKyiDZ
s5IXng/+LJop6d1o3nv4OD17mqF3CGrpLyXsLZeWE1Jx6fy6NteemgghWRziL1Mr
6aNk3jZv9myuEOtLl+jyGTrRMstT/Cx4hiv/uupyPrM8l7DWYBKpvXZAzry2Xj0U
yQBK2lrW68j3XaF7L8qckIKGeyHr94E2oKA6tGfH0hYue2Bk6h1X7p3702jMNB5L
2rPsDOd5pr683sXYat1qkaGBScR0kqs9XXIeknZGrdxJAaRS/NPOl1Jj9/IoRYtD
8sRmCZzAL/NL0lpq4sS1YvPMZGVSaFkxNXY8hk8EooUKve+Mr53YYyMVX1cjryHL
R6/38HhU+Aijghzohj5gfLAcYV4x5WKYyWEijj0VUf3bwFe7lZS8mA7TsltJPTGL
zG9DOVkb4/v5+PqIlNsKWtc90WxQThaBH008MNyITZjJAAG4hlKJ3c64Dfr9cDFl
oGdyV7WhBDpiDc1kGwkQI6rCbq42b3RwQqtnch3eHQvvMii1TkD/hXYVOY4hFa3m
whsphA8qqJ36dl6rYHJVtJ3FKi1E1Dofj4+E8vBIfyEZysmLaINhGf8JYGo34odT
ViscEo2O2JiFXOI36zvoyor1N/qeg7XhgxhQlZPSkA7rxnKGMzSy2zUUEpVYA7JY
m564oCgs++MJK999Eo/SFiPobz58zffM/XvxuM6YhPqrHelpv2E=
=onq1
-----END PGP SIGNATURE-----

--FmdPcZLZZW6lDAYm--
