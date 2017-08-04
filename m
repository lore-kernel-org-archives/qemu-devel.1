Received: from eggs.gnu.org ([2001:4830:134:3::10]:39332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSM5-0005RW-69
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:28:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ddSM2-0004h0-FD
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 22:28:49 -0400
Date: Fri, 4 Aug 2017 12:18:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170804021807.GC6553@umbus.fritz.box>
References: <cover.1501740002.git.sam.bobroff@au1.ibm.com>
	<4646e612ef5efb4f17f07eaec18e940f7ae93382.1501740002.git.sam.bobroff@au1.ibm.com>
	<20170803143715.33d0a62c@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E13BgyNx05feLLmH"
Content-Disposition: inline
In-Reply-To: <20170803143715.33d0a62c@bahia.lan>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/4] spapr: Fix bug in
 h_signal_sys_reset()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--E13BgyNx05feLLmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2017 at 02:37:15PM +0200, Greg Kurz wrote:
> On Thu, 3 Aug 2017 16:28:27 +1000
> Sam Bobroff <sam.bobroff@au1.ibm.com> wrote:
>=20
> > The unicast case in h_signal_sys_reset() seems to be broken:
> > rather than selecting the target CPU, it looks like it will pick
> > either the first CPU or fail to find one at all.
> >=20
> > Fix it by using the search function rather than open coding the
> > search.
> >=20
>=20
> Heh the open coded search is using cpu where it should have been using
> POWERPC_CPU(cs) =3D> it can only succeed if a the vCPU is signalling itse=
lf.
>=20
> > This was found by inspection; the code appears to be unused because
> > the Linux kernel only uses the broadcast target.
> >=20
> > Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

>=20
> > ---
> >  hw/ppc/spapr_hcall.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 72ea5a8247..07b3da8dc4 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1431,11 +1431,10 @@ static target_ulong h_signal_sys_reset(PowerPCC=
PU *cpu,
> > =20
> >      } else {
> >          /* Unicast */
> > -        CPU_FOREACH(cs) {
> > -            if (cpu->cpu_dt_id =3D=3D target) {
> > -                run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CP=
U_NULL);
> > -                return H_SUCCESS;
> > -            }
> > +        cs =3D CPU(ppc_get_vcpu_by_dt_id(target));
> > +        if (cs) {
> > +            run_on_cpu(cs, spapr_do_system_reset_on_cpu, RUN_ON_CPU_NU=
LL);
> > +            return H_SUCCESS;
> >          }
> >          return H_PARAMETER;
> >      }
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--E13BgyNx05feLLmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmD2V8ACgkQbDjKyiDZ
s5JL6Q/7BUW8gusPjciSgzi+DOeVCSa5XDYjJPs7qcScSW2QDa5HspA4T0qOyk4T
j/YShpr0bttFAIVGAhTwTmG/mSS+P3ka49ZdKJqxcDvxF896M8F7X419XjUDRfyr
xKV/pZvBtwthasH8QG6D7pi6OEBg4GI9aMLd/PlJWokS+xyDQHNeFYNOj5AmRhlG
iivEkAxNKeAy/AG92RyvQ0dLTyOFp1smb18Wg1BWzZa116hoFfNuv4qcL2vUkEh0
fhqE5hxEFbfN2jH4JMtmFw+6zDe5NXM+8CiRnjOJxH25/dEDvtReMqJkxdqvn61Y
UrO+VKUST73o7DVHxeGuUXEzRm3Jf6F9GlbZV3MybzZwKIeOPIvtodctVv8H3NuQ
YSc6VTmVCMw4t60iUkNxDrtUPK2THXX9GTERiW5fIMzgc6DrHuc4SCiKup4hFWa4
SeIO+/d/mDWkIsqpHIaZiHkMUGiTBDk23nbm3fZ93s758bfj3GseZz8sA9E9sW0A
ftxgU6F1/J49dRDOXv1SzEV35M6l0OjhQNvv9Z1YQlXVRjuRgVROrnlQCJplS3Dt
wSrI/C75YTvck7txJs6QgSlb/MxKlM/97O2T5o68oYFyPzTs7JUlcmRrWXsM/S2v
DuxUbSrMFwxuA9z9tPZD5YAdBzNpswKuQXFeFQlrMZIF4tOgQI8=
=6hpQ
-----END PGP SIGNATURE-----

--E13BgyNx05feLLmH--
