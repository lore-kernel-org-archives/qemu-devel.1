Received: from eggs.gnu.org ([208.118.235.92]:38217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZb-0002XZ-4X
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gesZT-0004rI-PM
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 21:17:26 -0500
Date: Thu, 3 Jan 2019 12:54:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190103015412.GH10853@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<fc40f941cf84750609e1093eca98fd9248a0981e.1546394798.git.balaton@eik.bme.hu>
	<20190102040900.GL27457@umbus.fritz.box>
	<alpine.BSF.2.21.9999.1901021306120.78010@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="54u2kuW9sGWg/X+X"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.9999.1901021306120.78010@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH 1/8] smbus: Add a helper to generate SPD
 EEPROM data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>


--54u2kuW9sGWg/X+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 01:36:04PM +0100, BALATON Zoltan wrote:
> On Wed, 2 Jan 2019, David Gibson wrote:
> > On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> > > There are several boards with SPD EEPROMs that are now using
> > > duplicated or slightly different hard coded data. Add a helper to
> > > generate SPD data for a memory module of given type and size that
> > > could be used by these boards (either as is or with further changes if
> > > needed) which should help cleaning this up and avoid further duplicat=
ion.
> > >=20
> > > Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> > > ---
> > >  hw/i2c/smbus_eeprom.c  | 128 +++++++++++++++++++++++++++++++++++++++=
++++++++++
> > >  include/hw/i2c/smbus.h |   3 ++
> > >  2 files changed, 131 insertions(+)
> > >=20
> > > diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> > > index f18aa3de35..a1f51eb921 100644
> > > --- a/hw/i2c/smbus_eeprom.c
> > > +++ b/hw/i2c/smbus_eeprom.c
> > > @@ -23,6 +23,8 @@
> > >   */
> > >=20
> > >  #include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qemu/units.h"
> > >  #include "hw/hw.h"
> > >  #include "hw/i2c/i2c.h"
> > >  #include "hw/i2c/smbus.h"
> > > @@ -162,3 +164,129 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_ee=
prom,
> > >          smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256=
));
> > >      }
> > >  }
> > > +
> > > +/* Generate SDRAM SPD EEPROM data describing a module of type and si=
ze */
> > > +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
> > > +{
> > > +    uint8_t *spd;
> > > +    uint8_t nbanks;
> > > +    uint16_t density;
> > > +    uint32_t size;
> > > +    int min_log2, max_log2, sz_log2;
> > > +    int i;
> > > +
> > > +    switch (type) {
> > > +    case SDR:
> > > +        min_log2 =3D 2;
> > > +        max_log2 =3D 9;
> > > +        break;
> > > +    case DDR:
> > > +        min_log2 =3D 5;
> > > +        max_log2 =3D 12;
> > > +        break;
> > > +    case DDR2:
> > > +        min_log2 =3D 7;
> > > +        max_log2 =3D 14;
> > > +        break;
> > > +    default:
> > > +        error_report("Unknown SDRAM type");
> > > +        abort();
> >=20
> > The error handling might work a little cleaner if you give this
> > function an Error ** parameter, then just pass in &error_abort from
> > the callers.
>=20
> Good idea but I'm not sure it's needed. This is the only fatal error here
> (apart from g_malloc0 failing which should also abort) and in practice th=
is
> could only happen if a caller specifies wrong type which is quite unlikely
> given that it's an enum so value outside of that would fail to compile wi=
th
> a warning (promoted to error by default). So this default case is only
> really here to please the compiler.

Ok.  If the only reason you'd hit the default case is a bug in the
caller, then just use a g_assert_not_reached() rather than
error_report().  As a rule of thumb use asserts or aborts for things
that have to be bugs in the code, error_report() for things that
indicate a user or configuration error.

> > > +    }
> > > +    size =3D ram_size >> 20; /* work in terms of megabytes */
> > > +    if (size < 4) {
> > > +        error_report("SDRAM size is too small");
> > > +        return NULL;
> > > +    }
> > > +    sz_log2 =3D 31 - clz32(size);
> > > +    size =3D 1U << sz_log2;
> > > +    if (ram_size > size * MiB) {
> > > +        warn_report("SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2=
, "
> > > +                    "truncating to %u MB", ram_size, size);
> > > +    }
> > > +    if (sz_log2 < min_log2) {
> > > +        warn_report("Memory size is too small for SDRAM type, adjust=
ing type");
> > > +        if (size >=3D 32) {
> > > +            type =3D DDR;
> > > +            min_log2 =3D 5;
> > > +            max_log2 =3D 12;
> > > +        } else {
> > > +            type =3D SDR;
> > > +            min_log2 =3D 2;
> > > +            max_log2 =3D 9;
> > > +        }
> >=20
> > What do these various fall back cases represent?  Are they bugs in the
> > callers, or a user configuration error?
>=20
> The memory size is given by the user so it can be a config error (like wh=
en
> board has DDR2 but user sets memory size to 64MB).
>=20
> > If the first, we should just assert or abort.  If the second I think
> > we should still die with a fatal error - allowing broken
> > configurations to work with just a warning is kind of begging to
> > maintain nasty compatiliby cruft in the future.
>=20
> I'd leave that to the caller to decide and not abort in this
> function.

Right.  The obvious way to do that is to have this function take an
Error *, and use error_setg() where you have explicit warns now.  The
caller can pass &error_fatal if it just wants to treat that as a user
error, and do something else if it wants to implement a fallback.

> It
> will warn user that config is unexpected for the board but does not preve=
nt
> it and try to give something that might still work (e.g. DDR instead of
> DDR2). Then the caller can check the returned data and abort if it insists
> that only DDR2 will work for the machine. Otherwise we'd make it impossib=
le
> to use non-standard memory sizes for cases when it would still work (like
> when the OS does not check SPD EEPROMs and would happily use whatever mem=
ory
> size). I think it's already possible to start machines with odd memory si=
zes
> so that's not new and I did not want to prevent this if SPD EEPROMs are
> added (just SPD can't describe all memory in that case which may only be a
> problem for firmware but not when directly booting a kernel for example).
>=20
> The idea of this function is to generate some data to start from instead =
of
> the static data some boards now have. which is often sufficient for the
> board as is but it could be checked or modified further to fit the specif=
ic
> needs of the board. As those needs can be widely different I did not atte=
mpt
> to handle all of them in this function to keep it generic.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--54u2kuW9sGWg/X+X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwta0EACgkQbDjKyiDZ
s5L3jw//amH6s2D+TPXdVPwCWgpbN1Adi3+QhQXGu9b/JBfRiQ34jDIF1YSfHtK2
GJhsVAL7IOH7ZfTXaQ0pIv3cP8y+ja76UIM5jLTP2kKKG4obBpAE2+WVB+UmtY3T
iEPEzAAKprqSMvteHNCz4Vpofp6hwn9trrLnKFOAonDKFluoQOFla/p7HOkEcSCN
I0t5rUFhrfTHO8Lb4CTBhLyKMtWmc62EdByuUEw9bJ4rjuRuXdzZAOnzlRj3xKSZ
77jyZOvu2mkF2d5UATJ9MsolNMRwrPTV3iXrNyWBCVdKiIG5ZylpM2fxUSPB1C5i
FiXrxTPoTv2fnHeVphdr9v/ubgHGNjkeNodjoQR4U0xZf8z4mI+T/IhGlb1yO6WI
D0f/Pss2dLff17O+2L/EndStJsacuAHKGqXujWvIbHiXcir5OILAGrDmT5aC5U13
+7etgV9YXnSYVWXp7rJ7iMech6Rxcy+HEXZzfj8jEbzs8tzS7k8YYbIB2/85KYLS
X1ZX2Mc6fUlMWMAKU4uCjPljhns/ZvOQMSO8tlQtqrnm4jowQkMljLuxYJ2RjJkK
nP1c/q9EuPlBMYROBdE/aFsUOU5Cy0dbm9w6qe4ZaGcoOgBm5LuXATNAd79t/0Zk
zc+stHzU9rbYhCzHUrjblRMpujD9Sd0y6jnCf3YeVrZKKTwplY8=
=TIo3
-----END PGP SIGNATURE-----

--54u2kuW9sGWg/X+X--
