Received: from eggs.gnu.org ([208.118.235.92]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK2-0001i7-IS
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1geYK1-0007oP-6O
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 23:40:02 -0500
Date: Wed, 2 Jan 2019 15:09:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190102040900.GL27457@umbus.fritz.box>
References: <cover.1546394798.git.balaton@eik.bme.hu>
	<fc40f941cf84750609e1093eca98fd9248a0981e.1546394798.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="umrsQkkrw7viUWFs"
Content-Disposition: inline
In-Reply-To: <fc40f941cf84750609e1093eca98fd9248a0981e.1546394798.git.balaton@eik.bme.hu>
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


--umrsQkkrw7viUWFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 03:06:38AM +0100, BALATON Zoltan wrote:
> There are several boards with SPD EEPROMs that are now using
> duplicated or slightly different hard coded data. Add a helper to
> generate SPD data for a memory module of given type and size that
> could be used by these boards (either as is or with further changes if
> needed) which should help cleaning this up and avoid further duplication.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/i2c/smbus_eeprom.c  | 128 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/i2c/smbus.h |   3 ++
>  2 files changed, 131 insertions(+)
>=20
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index f18aa3de35..a1f51eb921 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -23,6 +23,8 @@
>   */
> =20
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/units.h"
>  #include "hw/hw.h"
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus.h"
> @@ -162,3 +164,129 @@ void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>          smbus_eeprom_init_one(smbus, 0x50 + i, eeprom_buf + (i * 256));
>      }
>  }
> +
> +/* Generate SDRAM SPD EEPROM data describing a module of type and size */
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t ram_size)
> +{
> +    uint8_t *spd;
> +    uint8_t nbanks;
> +    uint16_t density;
> +    uint32_t size;
> +    int min_log2, max_log2, sz_log2;
> +    int i;
> +
> +    switch (type) {
> +    case SDR:
> +        min_log2 =3D 2;
> +        max_log2 =3D 9;
> +        break;
> +    case DDR:
> +        min_log2 =3D 5;
> +        max_log2 =3D 12;
> +        break;
> +    case DDR2:
> +        min_log2 =3D 7;
> +        max_log2 =3D 14;
> +        break;
> +    default:
> +        error_report("Unknown SDRAM type");
> +        abort();

The error handling might work a little cleaner if you give this
function an Error ** parameter, then just pass in &error_abort from
the callers.

> +    }
> +    size =3D ram_size >> 20; /* work in terms of megabytes */
> +    if (size < 4) {
> +        error_report("SDRAM size is too small");
> +        return NULL;
> +    }
> +    sz_log2 =3D 31 - clz32(size);
> +    size =3D 1U << sz_log2;
> +    if (ram_size > size * MiB) {
> +        warn_report("SDRAM size 0x"RAM_ADDR_FMT" is not a power of 2, "
> +                    "truncating to %u MB", ram_size, size);
> +    }
> +    if (sz_log2 < min_log2) {
> +        warn_report("Memory size is too small for SDRAM type, adjusting =
type");
> +        if (size >=3D 32) {
> +            type =3D DDR;
> +            min_log2 =3D 5;
> +            max_log2 =3D 12;
> +        } else {
> +            type =3D SDR;
> +            min_log2 =3D 2;
> +            max_log2 =3D 9;
> +        }

What do these various fall back cases represent?  Are they bugs in the
callers, or a user configuration error?

If the first, we should just assert or abort.  If the second I think
we should still die with a fatal error - allowing broken
configurations to work with just a warning is kind of begging to
maintain nasty compatiliby cruft in the future.

> +    }
> +
> +    nbanks =3D 1;
> +    while (sz_log2 > max_log2 && nbanks < 8) {
> +        sz_log2--;
> +        nbanks++;
> +    }
> +
> +    if (size > (1ULL << sz_log2) * nbanks) {
> +        warn_report("Memory size is too big for SDRAM, truncating");
> +    }
> +
> +    /* split to 2 banks if possible to avoid a bug in MIPS Malta firmwar=
e */
> +    if (nbanks =3D=3D 1 && sz_log2 > min_log2) {
> +        sz_log2--;
> +        nbanks++;
> +    }
> +
> +    density =3D 1ULL << (sz_log2 - 2);
> +    switch (type) {
> +    case DDR2:
> +        density =3D (density & 0xe0) | (density >> 8 & 0x1f);
> +        break;
> +    case DDR:
> +        density =3D (density & 0xf8) | (density >> 8 & 0x07);
> +        break;
> +    case SDR:
> +    default:
> +        density &=3D 0xff;
> +        break;
> +    }
> +
> +    spd =3D g_malloc0(256);
> +    spd[0] =3D 128;   /* data bytes in EEPROM */
> +    spd[1] =3D 8;     /* log2 size of EEPROM */
> +    spd[2] =3D type;
> +    spd[3] =3D 13;    /* row address bits */
> +    spd[4] =3D 10;    /* column address bits */
> +    spd[5] =3D (type =3D=3D DDR2 ? nbanks - 1 : nbanks);
> +    spd[6] =3D 64;    /* module data width */
> +                    /* reserved / data width high */
> +    spd[8] =3D 4;     /* interface voltage level */
> +    spd[9] =3D 0x25;  /* highest CAS latency */
> +    spd[10] =3D 1;    /* access time */
> +                    /* DIMM configuration 0 =3D non-ECC */
> +    spd[12] =3D 0x82; /* refresh requirements */
> +    spd[13] =3D 8;    /* primary SDRAM width */
> +                    /* ECC SDRAM width */
> +    spd[15] =3D (type =3D=3D DDR2 ? 0 : 1); /* reserved / delay for rand=
om col rd */
> +    spd[16] =3D 12;   /* burst lengths supported */
> +    spd[17] =3D 4;    /* banks per SDRAM device */
> +    spd[18] =3D 12;   /* ~CAS latencies supported */
> +    spd[19] =3D (type =3D=3D DDR2 ? 0 : 1); /* reserved / ~CS latencies =
supported */
> +    spd[20] =3D 2;    /* DIMM type / ~WE latencies */
> +                    /* module features */
> +                    /* memory chip features */
> +    spd[23] =3D 0x12; /* clock cycle time @ medium CAS latency */
> +                    /* data access time */
> +                    /* clock cycle time @ short CAS latency */
> +                    /* data access time */
> +    spd[27] =3D 20;   /* min. row precharge time */
> +    spd[28] =3D 15;   /* min. row active row delay */
> +    spd[29] =3D 20;   /* min. ~RAS to ~CAS delay */
> +    spd[30] =3D 45;   /* min. active to precharge time */
> +    spd[31] =3D density;
> +    spd[32] =3D 20;   /* addr/cmd setup time */
> +    spd[33] =3D 8;    /* addr/cmd hold time */
> +    spd[34] =3D 20;   /* data input setup time */
> +    spd[35] =3D 8;    /* data input hold time */
> +
> +    /* checksum */
> +    for (i =3D 0; i < 63; i++) {
> +        spd[63] +=3D spd[i];
> +    }
> +    return spd;
> +}
> diff --git a/include/hw/i2c/smbus.h b/include/hw/i2c/smbus.h
> index d8b1b9ee81..0adc2991b5 100644
> --- a/include/hw/i2c/smbus.h
> +++ b/include/hw/i2c/smbus.h
> @@ -93,4 +93,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t addre=
ss, uint8_t *eeprom_buf);
>  void smbus_eeprom_init(I2CBus *smbus, int nb_eeprom,
>                         const uint8_t *eeprom_spd, int size);
> =20
> +enum sdram_type { SDR =3D 0x4, DDR =3D 0x7, DDR2 =3D 0x8 };
> +uint8_t *spd_data_generate(enum sdram_type type, ram_addr_t size);
> +
>  #endif

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--umrsQkkrw7viUWFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwsOVoACgkQbDjKyiDZ
s5K7yg//ciwBLDkO6sxqKPmTFZ13EstOKF7s41LXHpxo0fyUXGvlqpbgueiNkFLR
lqW52D40j6o72OBr1+n+pN5WOKtU6UPp+8dCoQsKNlxHCEAMH+7y8UbWLJ1fN5G6
iVcwog9w4HePc/ryjuV7O7tOWse4wYq/lQVbhgHpSO7qjnkG10UBBeTpVlOhbz7Q
AFSS3dQ4RiT98IiPZhY04eKCxdZTO5Yl+mu99ilKFb4+1bVFkTkVQHbc+TQe/NnG
DiTVzRzNgeMSleNkEUCX8lqkddUbtteKqvXtpdwSOOLbyzBGQL7e+CKO5Zf6AT9b
jA/uhKlqDwALh7TAK38XbQy1QjQWmurHoryRyS+3bqzynBVf5KGfvB82KWaAq7vD
5JhZYE8yL3siwE7hSTdWjAH8Mki6V222HS9e5ND+ZTwyFgmTo5XJlSH7u84JA1kn
D2AvGGm2VnIOGxgRJOtKdbtZOt2w/xm0dx0wnUbvE0dB5qiSk5Nfd/OEzAYhfY6k
Yi3mDEJ7H2L5XqJqLieYJfbK+ZfwJTt8vPoc5Ww0Fkh0jbscK1YUK125mtPlXrs+
3O7ltk7wsVtvFK4/cE2iMEpvEm6i96BVedhV0f512GobWqf0Qttk1ZZfaRctICVx
c4MUjYnJ24fGMEpHbIcBBtNzWppl0Q6WWT7Q+ZdRrthLkaX0+9s=
=oVno
-----END PGP SIGNATURE-----

--umrsQkkrw7viUWFs--
