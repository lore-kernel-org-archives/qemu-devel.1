Received: from eggs.gnu.org ([2001:4830:134:3::10]:50421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq6c-0006cu-HN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:06:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fZq6b-00072Z-Ht
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 00:06:26 -0400
Date: Mon, 2 Jul 2018 14:06:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180702040614.GV3422@umbus.fritz.box>
References: <153018086531.336571.17029459443980070626.stgit@bahia.lan>
	<153018091454.336571.7311461748726927045.stgit@bahia>
	<20180629190822.GW7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ln+iIw7POnzHEEo5"
Content-Disposition: inline
In-Reply-To: <20180629190822.GW7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: compute default value of
 "hpt-max-page-size" later
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>


--Ln+iIw7POnzHEEo5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 04:08:22PM -0300, Eduardo Habkost wrote:
> On Thu, Jun 28, 2018 at 12:15:14PM +0200, Greg Kurz wrote:
> [...]
> > @@ -2527,6 +2527,18 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >      QLIST_INIT(&spapr->phbs);
> >      QTAILQ_INIT(&spapr->pending_dimm_unplugs);
> > =20
> > +    /* This is for pseries-2.12 and older machine types */
> > +    if (!smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE]) {
> > +        uint8_t mps;
> > +
> > +        if (kvmppc_hpt_needs_host_contiguous_pages()) {
> > +            mps =3D ctz64(qemu_getrampagesize());
> > +        } else {
> > +            mps =3D 34; /* allow everything up to 16GiB, i.e. everythi=
ng */
> > +        }
> > +        smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
>=20
> Initializing class fields on instance init functions is a sign
> that the information doesn't belong to the class struct.  Can't
> this be handled at default_caps_with_cpu()?

Yeah, doing it inside default_caps_with_cpu() probably makes more
sense.

> > +    }
> > +
> >      /* Determine capabilities to run with */
> >      spapr_caps_init(spapr);
> > =20
> > @@ -4103,17 +4115,16 @@ static void spapr_machine_2_12_instance_options=
(MachineState *machine)
> >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> >  {
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> > -    uint8_t mps;
> > =20
> >      spapr_machine_3_0_class_options(mc);
> >      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> > =20
> > -    if (kvmppc_hpt_needs_host_contiguous_pages()) {
> > -        mps =3D ctz64(qemu_getrampagesize());
> > -    } else {
> > -        mps =3D 34; /* allow everything up to 16GiB, i.e. everything */
> > -    }
> > -    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D mps;
> > +    /* We depend on kvm_enabled() to choose a default value for the
> > +     * hpt-max-page-size capability. Of course we can't do it here
> > +     * because this is too early and the HW accelerator isn't initialz=
ed
> > +     * yet. Postpone this to spapr_machine_init().
> > +     */
> > +    smc->default_caps.caps[SPAPR_CAP_HPT_MAXPAGESIZE] =3D 0;
> >  }
> > =20
> >  DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ln+iIw7POnzHEEo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5pLUACgkQbDjKyiDZ
s5JdmhAA0OJI5iDC8eEFCp2WHAWBc8O8/1aeYP+aL/pKe+YyXb+M7ix4yqtb0622
v6ClCL48/knY4C6UpN6xVHn6PCdvrDNld7qNWZ9DSBFlQMASluu/xYgygAppgznn
nDjYSx340fq8ERncGnTPF9any35lgqz383mK/1hPvGnkBP+A2D/mOxo1j/tTDr1s
CxE9EZGYZvOO1OgOUji8H9wWrv/W0Dbs8kPAwJO4fLazjqxS17N4OoxqGcBdjckj
gxEuHtjHHp0F3Xl/3pHmhzcYbaeykrT6RaTn5zYefxwN1OOrfvHSaHLxaJmwDkwz
Ce/X6y7xPurw6V2uxFTy1fih6QoRUoThDzuhwTPO1GYBNxnX6DY6qPLnYRo4Lvd3
KM+rugj7iYBqlNxpKekkCsCCQxIw4+QC2DeCvbiPMn6MJKIQ8hjntrhg4pZKLUz6
7AQhnd/aFFECqUxGa8tk4OsWKdQPs5QrHxo+ASJ1ytDtv1mO+33q9VEUP1/3KLQR
lieNJWl8E1CUxN0vuo29wFoPGKp+O7YloLmQWACr/vN+gv2QklDosJ23ZXy+WGKr
+Dm41csYFhyXr3Vb0iD5QQ1fxYeajkaYxZRyvea/2Q/YyFQ7WaVQYxZszaTqzYar
mYWZOGWZ2xlOwZfHDy5850UM5QS6DIhqHw51BJb5hw87fsxBM0g=
=1atg
-----END PGP SIGNATURE-----

--Ln+iIw7POnzHEEo5--
