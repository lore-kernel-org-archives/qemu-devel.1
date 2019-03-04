Received: from eggs.gnu.org ([209.51.188.92]:34267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHb-0001uH-Rr
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h0cHZ-0007Xc-UX
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:20:43 -0500
Date: Mon, 4 Mar 2019 11:35:06 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190304003506.GD7792@umbus.fritz.box>
References: <155146874478.147873.5019623412212796259.stgit@bahia.lan>
	<155146875704.147873.10563808578795890265.stgit@bahia.lan>
	<155147961832.30057.4167728683124961502@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <155147961832.30057.4167728683124961502@sif>
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: Simulate CAS for qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2019 at 04:33:38PM -0600, Michael Roth wrote:
> Quoting Greg Kurz (2019-03-01 13:32:37)
> > The RTAS event hotplug code for machine types 2.8 and newer depends on
> > the CAS negotiated ov5 in order to work properly. However, there's no
> > CAS when running under qtest. There has been a tentative to trick the
> > code by faking the OV5_HP_EVT bit, but it turned out to break other
> > assumptions in the code and the change got reverted.
> >=20
> > Go for a more general approach and simulate a CAS when running under
> > qtest. For simplicity, this pseudo CAS simple simulates the case where
> > the guest supports the same features as the machine. It is done at
> > reset time, just before we reset the DRCs, which could potentially
> > exercise the unplug code.
> >=20
> > This allows to test unplug on spapr with both older and newer machine
> > types.
> >=20
> > Suggested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>=20
> Thanks for sending this!
>=20
> Just now realizing we should probably apply the revert after this patch
> however, since the commit we're reverting fixes a `make check` test that
> is run by default, whereas this patch fixes one that only gets run if we
> run the tests with -m=3Dslow specified.
>=20
> Maybe David can do that on his end?

Applied in reverse order as suggested to ppc-for-4.0.  Thanks.

>=20
> > ---
> >  hw/ppc/spapr.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index b6a571b6f184..6da64ef7ee2b 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -29,6 +29,7 @@
> >  #include "qapi/visitor.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/numa.h"
> > +#include "sysemu/qtest.h"
> >  #include "hw/hw.h"
> >  #include "qemu/log.h"
> >  #include "hw/fw-path-provider.h"
> > @@ -1711,6 +1712,16 @@ static void spapr_machine_reset(void)
> >       */
> >      spapr_irq_reset(spapr, &error_fatal);
> >=20
> > +    /*
> > +     * There is no CAS under qtest. Simulate one to please the code th=
at
> > +     * depends on spapr->ov5_cas. This is especially needed to test de=
vice
> > +     * unplug, so we do that before resetting the DRCs.
> > +     */
> > +    if (qtest_enabled()) {
> > +        spapr_ovec_cleanup(spapr->ov5_cas);
> > +        spapr->ov5_cas =3D spapr_ovec_clone(spapr->ov5);
> > +    }
> > +
> >      /* DRC reset may cause a device to be unplugged. This will cause t=
roubles
> >       * if this device is used by another device (eg, a running vhost b=
ackend
> >       * will crash QEMU if the DIMM holding the vring goes away). To av=
oid such
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx8crgACgkQbDjKyiDZ
s5IDpQ//VJl7oOaQ6H8jjuAQ5q+m2ouCZNJJmjCY4vM0C1fe6Jn4lx0/ExplfAT0
VlYYVMSrNsqwKZdnDmr3YVtbC7FkV6a2mXQAx7AGtnLAkU/G8/SGgjz4Iph/Lh6c
VPaDviSyhn3ggglbyqGEr05Cf2TPFBqDTzzDoky5zNXzNd+RYeIOi+4tPl22T3uq
mqGa7IzY/EThlybldBys44H8fuopLCriH4L+piwQCR7L77qiJaDvpmDFV77GPojs
HavLs9J6bKYUfmVJ7+DdQSCHUpGh2aVcevfIybaJudEyJ4f7XDi4KEaaKaV4JewF
FQjYCC70qSOa7HWTFPVEvOpGpsxO1ORJCkog6JKDqk/GaeWW6lS599GaXpmwx3uK
+QPhYn+MpjtocJBxqMKeTqzGeu+JThpr6iolX6iOwTG0meG9f670uo/fGCGnrRkt
6v6QmsZx6spRfmtpAMAA9W/ka94rzACrquC1K81I7jpcyzdNBf+IzstJebzrDfF/
1MWI+OGDMNUBpSmNtvQqeFVS2SW3256OLNcozx9kVMbF8J4O2gF4YeVzJi+Nj+3S
CfSrKs93CgD10ayAwpqEY4kYLpe+N//C2VlYdJvpvzcfePN1fxynTDyFqevZiyHz
DroBENWMVm4qBZE3rLkYdjmMI+mkbohFVDpuXKv19taojIzxX+g=
=fSJ1
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
