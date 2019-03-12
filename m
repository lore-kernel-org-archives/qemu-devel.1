Received: from eggs.gnu.org ([209.51.188.92]:57821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YBB-0002xw-O2
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h3YBA-0005Dj-Iu
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:34:13 -0400
Date: Tue, 12 Mar 2019 12:08:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190312010801.GC3303@umbus.fritz.box>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
	<20190310082703.1245-5-david@gibson.dropbear.id.au>
	<20190311115228.30efc27b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20190311115228.30efc27b@bahia.lan>
Subject: Re: [Qemu-devel] [PULL 04/60] Revert "spapr: support memory unplug
 for qtest"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: peter.maydell@linaro.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 11:52:28AM +0100, Greg Kurz wrote:
> On Sun, 10 Mar 2019 19:26:07 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > From: Greg Kurz <groug@kaod.org>
> >=20
> > Commit b8165118f52c broke CPU hotplug tests for old machine types:
> >=20
> > $ QTEST_QEMU_BINARY=3Dppc64-softmmu/qemu-system-ppc64 ./tests/cpu-plug-=
test -m=3Dslow
> > /ppc64/cpu-plug/pseries-3.1/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.12-sxxm/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-3.0/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.10/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.11/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.12/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.9/device-add/2x3x1&maxcpus=3D6: OK
> > /ppc64/cpu-plug/pseries-2.7/device-add/2x3x1&maxcpus=3D6: **
> > ERROR:/home/thuth/devel/qemu/hw/ppc/spapr_events.c:313:rtas_event_log_t=
o_source: assertion failed: (source->enabled)
> > Broken pipe
> > /home/thuth/devel/qemu/tests/libqtest.c:143: kill_qemu() detected QEMU =
death from signal 6 (Aborted) (core dumped)
> > Aborted (core dumped)
> >=20
> > The approach of faking the availability of OV5_HP_EVT causes the
> > code to assume the hotplug event source is enabled, which is wrong
> > for older machines.
> >=20
> > This reverts commit b8165118f52ce5ee88565d3cec83d30374efdc96.
> >=20
> > A subsequent patch will address the problem of CAS under qtest from
> > a different angle.
> >=20
>=20
> Since the patches got re-ordered, this sentence is wrong. In case
> you re-send this pull request, maybe you can update the changelog
> accordingly ?

Done.

>=20
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Message-Id: <155146875097.147873.1732264036668112686.stgit@bahia.lan>
> > Tested-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/ppc/spapr_ovec.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_ovec.c b/hw/ppc/spapr_ovec.c
> > index 12510b236a..318bf33de4 100644
> > --- a/hw/ppc/spapr_ovec.c
> > +++ b/hw/ppc/spapr_ovec.c
> > @@ -16,7 +16,6 @@
> >  #include "qemu/bitmap.h"
> >  #include "exec/address-spaces.h"
> >  #include "qemu/error-report.h"
> > -#include "sysemu/qtest.h"
> >  #include "trace.h"
> >  #include <libfdt.h>
> > =20
> > @@ -132,11 +131,6 @@ bool spapr_ovec_test(sPAPROptionVector *ov, long b=
itnr)
> >      g_assert(ov);
> >      g_assert(bitnr < OV_MAXBITS);
> > =20
> > -    /* support memory unplug for qtest */
> > -    if (qtest_enabled() && bitnr =3D=3D OV5_HP_EVT) {
> > -        return true;
> > -    }
> > -
> >      return test_bit(bitnr, ov->bitmap) ? true : false;
> >  }
> > =20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyHBm4ACgkQbDjKyiDZ
s5JBhBAAh57tiNhmt31v94qo7u2Gds/8FHdq18TIrREC2CgqPXGzJsPLT7sEeKVn
OjNawuaEvBMN753LM705i3yB33YXrkn4KfO4FK9pjFP27z1ZX8wHOMmukwDDwcmD
OYpXrusscUofsPcgi3ypGKz47lEjcQTv3hwvnfrFIaxUcKHgg78xPqE2WtJUE/FT
0MGz7Hwau3IsjX2jsOqBfEvc/5ppN7sDFqF/hsRxx4gTryEuqRoGekUfN85eBjWf
LEGVut6vbha/ZVksLmWhMiwLCgDFbrpXqcUK83zPpufrI8RK5NqY7lusXF7+wfgN
stHF71QGcgHHusQPYXWRbIa0+33pxksoHSFAELKdUsGs/Zu6oXN1RAQuZs0B4Nym
dqWwpjaterfAliT8XSGYPS4PAkJVa0tph84ICegMxGfUUg7iobABlQMLPiFEQ06k
0p3Ljw2qiUX9sDMj4aweOIZxpYqiyB1gXnmQhNPB4Z6aqAJ+46axJ6vItuN30ps6
lxqDyghdTbAMoprp86BiYntOtIl9CpsAfXkmjy9gXytVsrX87BVU1ylgZuKwgs5Y
ZrD4gZTbHb65hsjhe9FbTJC7U9f3fUCyfifk6o6HpECVlhJWsoaxFD3/kfASfbTL
WSF4SaINnvyEpzqkJrZFFhjXt6LqA7fa0AbcO9BWORjQWKLRevU=
=FyIJ
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
