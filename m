Received: from eggs.gnu.org ([2001:4830:134:3::10]:39683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTGs-0002KM-91
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:36:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1elTGq-0000aD-6Z
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 00:36:49 -0500
Date: Tue, 13 Feb 2018 16:09:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180213050929.GK11634@umbus.fritz.box>
References: <20180209081858.27013-1-lvivier@redhat.com>
	<20180209150649.7f557ff9@bahia.lan>
	<20180210092307.GQ11634@umbus.fritz.box>
	<20180212120830.38b1470e@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7BtE0xW96okrVgVt"
Content-Disposition: inline
In-Reply-To: <20180212120830.38b1470e@bahia.lan>
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


--7BtE0xW96okrVgVt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2018 at 12:11:27PM +0100, Greg Kurz wrote:
> On Sat, 10 Feb 2018 20:23:07 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Feb 09, 2018 at 03:06:49PM +0100, Greg Kurz wrote:
> > > On Fri,  9 Feb 2018 09:18:58 +0100
> > > Laurent Vivier <lvivier@redhat.com> wrote:
> > >  =20
> > > > We ignore silently the value of smp_threads when we set
> > > > the default VSMT value, and if smp_threads is greater than VSMT
> > > > kernel is going into trouble later.
> > > >  =20
> > >=20
> > > Hi Laurent,
> > >=20
> > > I've looked a bit more and I'm not sure what kernel troubles you're r=
eferring to,
> > > but several places in QEMU where we use kvm_ppc_smt() later on do ass=
ume that
> > > smp_threads > kvm_ppc_smt(). Basically, everywhere we compute a vCPU =
id:
> > >=20
> > > In spapr_init_cpus() when creating DRC connectors:
> > >=20
> > >         int core_id =3D i * smp_threads;
> > >=20
> > >         if (mc->has_hotpluggable_cpus) {
> > >             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
> > >                                    (core_id / smp_threads) * smt);
> > >         }
> > >=20
> > > or in spapr_cpu_core_realize() when creating vCPUs:
> > >=20
> > >         cpu->vcpu_id =3D (cc->core_id * spapr->vsmt / smp_threads) + =
i;
> > >=20
> > > It is visible by adding some printfs in the current code base. This i=
s what
> > > happens when passing -smp cores=3D2,threads=3D16 without your patch:
> > >=20
> > > DRC connector to vcpu_id 0
> > > CPU vcpu_id 0
> > > CPU vcpu_id 1
> > > CPU vcpu_id 2
> > > CPU vcpu_id 3
> > > CPU vcpu_id 4
> > > CPU vcpu_id 5
> > > CPU vcpu_id 6
> > > CPU vcpu_id 7
> > > CPU vcpu_id 8
> > > CPU vcpu_id 9
> > > CPU vcpu_id 10
> > > CPU vcpu_id 11
> > > CPU vcpu_id 12
> > > CPU vcpu_id 13
> > > CPU vcpu_id 14
> > > CPU vcpu_id 15
> > > DRC connector to vcpu_id 8
> > >                         ^^^
> > >                      should be 16
> > > CPU vcpu_id 8
> > >            ^^^
> > >    should start numbering at 16
> > > CPU vcpu_id 9
> > > CPU vcpu_id 10
> > > CPU vcpu_id 11
> > > CPU vcpu_id 12
> > > CPU vcpu_id 13
> > > CPU vcpu_id 14
> > > CPU vcpu_id 15
> > > CPU vcpu_id 16
> > > CPU vcpu_id 17
> > > CPU vcpu_id 18
> > > CPU vcpu_id 19
> > > CPU vcpu_id 20
> > > CPU vcpu_id 21
> > > CPU vcpu_id 22
> > > CPU vcpu_id 23
> > > qemu-system-ppc64: kvm_init_vcpu failed: File exists
> > >                                               ^^^^
> > >                                  CPU 8 already created by the first c=
ore
> > >=20
> > > I'm not feeling comfortable with the rest of the code silently depend=
ing on
> > > the fact that spapr_set_vsmt_mode() terminates QEMU if it cannot enfo=
rce
> > > smp_threads <=3D kvm_ppc_smt(). =20
> >=20
> > I'm not quite sure what you're suggesting as an alternative, though.
> >=20
>=20
> I haven't suggested anything yet :)
>=20
> But I was thinking of:
> - having a single function to compute the vcpu_id, instead of open-coding
>   the formula in several places like the current code does,

That seems like a good idea.

> - this function should ensure all pre-requisites to compute the vcpu_id a=
re
>   met (including trying to set VSMT) or return an error

I'm much more dubious about this.  Checks that can be performed
passively I'm ok with, but I think something that looks like a simple
calculation helper shouldn't be having side-effects like poking at KVM
state.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7BtE0xW96okrVgVt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqCcwcACgkQbDjKyiDZ
s5J9kBAA3InzzOGQzfVvnfdfNSmsNPce1cXM12JXhI/fkiPX89SRoDrzuqjy2/Gh
PS1h1HU5VeesK/TslOt57JfxW74rm0JpV3BSsSJB6lFO3gOJNXQYWV/x1dEe2jgi
MHhWYCW+K7QPFwh8PqnXC5PkC7PdS3V0lnopB3EHtbPhLWaUpkGajgBACrCmd9cM
SznpohLSssIvX/EoGaPu3cCcKqTUs9e96wyBNxem/t0wJR67hnM6fXC/CjUZqg/R
DsxhSRZAxWKGVdNF+STaOFBs5ezhvZSefAlUUjYIR/WJ9KmmORvTEOJ3IkQi2e/P
LJb3QOWz6kZVrBkBoBOgVpzZkp2DzPthkxP/C45RvHWah4BlaAbOTHxqZ84Hs8VC
dI5J91atBedurdL9TUDAwuKDZ6GIV8oHujQyxSfxieF9zLrXBGD9gbmcGFBtF1qV
UPxc7ZBcr808BNcTWthRvU8NdTp2PhD9fbfGcnZ+lHF8NLzfWQ1F8Yx1yf+ihOsb
rmXO39cI/UYnE6/T/gwJwxui1DMvkOkrk8MwTsTSaDKLzWM7AcoIrSfuxYB4P+St
pzaB32zyjJ6pUHHvtLrzPh4+uolh0Og51h0Y7q5sjnpyVBMCZuT4orBkuOqwpHTN
7xo4orpYEjeca7zzq0yKTQAQpI8j3Qm2t5iOdKBHfDQeBmfmCbs=
=KvkM
-----END PGP SIGNATURE-----

--7BtE0xW96okrVgVt--
