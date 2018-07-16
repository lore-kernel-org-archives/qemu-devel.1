Received: from eggs.gnu.org ([2001:4830:134:3::10]:48401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fezfL-0000Jq-4L
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:19:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fezfG-0003Kv-QA
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:19:35 -0400
Received: from ozlabs.org ([203.11.71.1]:57495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fezfF-0003Fz-LR
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 05:19:30 -0400
Date: Mon, 16 Jul 2018 19:19:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180716091917.GK2599@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-12-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <20180705182001.16537-12-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 11/14] timer: generalize ds1338
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 11:19:58AM -0700, Michael Davidsaver wrote:
> Add class level handling for address space size
> and control register.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Although I don't love the name "addr_size" - just "nvram_size" seems
clearer.

> ---
>  hw/timer/ds-rtc.c | 62 +++++++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 49 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
> index 126566ce1f..6d3a8b5586 100644
> --- a/hw/timer/ds-rtc.c
> +++ b/hw/timer/ds-rtc.c
> @@ -21,8 +21,10 @@
>   */
>  #define NVRAM_SIZE 64
> =20
> -#define TYPE_DSRTC "ds1338"
> +#define TYPE_DSRTC "dsrtc"
>  #define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
> +#define DSRTC_CLASS(klass) OBJECT_CLASS_CHECK(DSRTCClass, (klass), TYPE_=
DSRTC)
> +#define DSRTC_GET_CLASS(obj) OBJECT_GET_CLASS(DSRTCClass, (obj), TYPE_DS=
RTC)
> =20
>  /* values stored in BCD */
>  /* 00-59 */
> @@ -38,7 +40,7 @@
>  /* 0-99 */
>  #define R_YEAR  (0x6)
> =20
> -#define R_CTRL  (0x7)
> +#define R_DS1338_CTRL (0x7)
> =20
>  /* use 12 hour mode when set */
>  FIELD(HOUR, SET12, 6, 1)
> @@ -65,6 +67,15 @@ typedef struct DSRTCState {
>      bool addr_byte;
>  } DSRTCState;
> =20
> +typedef struct DSRTCClass {
> +    I2CSlaveClass parent_obj;
> +
> +    /* actual address space size must be <=3D NVRAM_SIZE */
> +    unsigned addr_size;
> +    unsigned ctrl_offset;
> +    void (*ctrl_write)(DSRTCState *s, uint8_t);
> +} DSRTCClass;
> +
>  static const VMStateDescription vmstate_dsrtc =3D {
>      .name =3D "ds1338",
>      .version_id =3D 2,
> @@ -119,11 +130,12 @@ static void capture_current_time(DSRTCState *s)
> =20
>  static void inc_regptr(DSRTCState *s)
>  {
> -    /* The register pointer wraps around after 0x3F; wraparound
> +    DSRTCClass *k =3D DSRTC_GET_CLASS(s);
> +    /* The register pointer wraps around after k->addr_size-1; wraparound
>       * causes the current time/date to be retransferred into
>       * the secondary registers.
>       */
> -    s->ptr =3D (s->ptr + 1) & (NVRAM_SIZE - 1);
> +    s->ptr =3D (s->ptr + 1) % k->addr_size;
>      if (!s->ptr) {
>          capture_current_time(s);
>      }
> @@ -205,20 +217,15 @@ static void dsrtc_update(DSRTCState *s)
>  static int dsrtc_send(I2CSlave *i2c, uint8_t data)
>  {
>      DSRTCState *s =3D DSRTC(i2c);
> +    DSRTCClass *k =3D DSRTC_GET_CLASS(s);
> =20
>      if (s->addr_byte) {
> -        s->ptr =3D data & (NVRAM_SIZE - 1);
> +        s->ptr =3D data % k->addr_size;
>          s->addr_byte =3D false;
>          return 0;
>      }
> -    if (s->ptr =3D=3D R_CTRL) {
> -        /* Control register. */
> -
> -        /* Allow guest to set no-op controls for clock out pin and
> -         * rate select.  Ignore write 1 to clear OSF.  We don't model
> -         * oscillator stop, so it is never set.
> -         */
> -        data =3D data & 0x93;
> +    if (s->ptr =3D=3D k->ctrl_offset) {
> +        (k->ctrl_write)(s, data);
>      }
>      s->nvram[s->ptr] =3D data;
>      if (s->ptr <=3D R_YEAR) {
> @@ -253,15 +260,44 @@ static void dsrtc_class_init(ObjectClass *klass, vo=
id *data)
>  }
> =20
>  static const TypeInfo dsrtc_info =3D {
> +    .abstract      =3D true,
>      .name          =3D TYPE_DSRTC,
>      .parent        =3D TYPE_I2C_SLAVE,
>      .instance_size =3D sizeof(DSRTCState),
>      .class_init    =3D dsrtc_class_init,
>  };
> =20
> +static void ds1338_control_write(DSRTCState *s, uint8_t data)
> +{
> +    /* Control register. */
> +
> +    /* Allow guest to set no-op controls for clock out pin and
> +     * rate select.  Ignore write 1 to clear OSF.  We don't model
> +     * oscillator stop, so it is never set.
> +     */
> +    s->nvram[R_DS1338_CTRL] =3D data & 0x93;
> +}
> +
> +static void ds1338_class_init(ObjectClass *klass, void *data)
> +{
> +    DSRTCClass *k =3D DSRTC_CLASS(klass);
> +
> +    k->addr_size =3D 0x40;
> +    k->ctrl_offset =3D R_DS1338_CTRL;
> +    k->ctrl_write =3D ds1338_control_write;
> +}
> +
> +static const TypeInfo ds1338_info =3D {
> +    .name          =3D "ds1338",
> +    .parent        =3D TYPE_DSRTC,
> +    .class_size    =3D sizeof(DSRTCClass),
> +    .class_init    =3D ds1338_class_init,
> +};
> +
>  static void dsrtc_register_types(void)
>  {
>      type_register_static(&dsrtc_info);
> +    type_register_static(&ds1338_info);
>  }
> =20
>  type_init(dsrtc_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltMYxMACgkQbDjKyiDZ
s5IRZhAApzmCnye5NfQgoDUToHF31dDGoXlNkXSs+megpN7c+ZOJF2NE69Tas2t0
F3W7GmWaaZC0AB2nTSp5T2T6PrZMa9DWw7llnXcSOk/L5IR67b0mKn+KzDsgIejx
YvIIQXtDq59nyjREepV0gADmesMd7X5BuTGaq9hIYWmF+wLLT696xsLcCjGvfYNK
FGiQHJ9pc/Pr/ZurPgVGDElW/Cv6lbu9YX9YDJ59VdBOr3iiHF8LLLy+bA5gz6Ub
/ZlN8zV3CYNXd4vIgOn66C8gJumfQjVdaTNSDbJgWlqdhaVI5eYlBjBrCJLpITtQ
MDLGM55wLinKF4AfAZ7Q9uK8wbk+9gLsAr3/YkJN2pThG8LHBtv886e8S+LWeSW+
EBeJgeWu7CJNGr39qV9GBxXhKtevpmph+xHsxDsvbKFDK9Lgj4JpgmGEZjx1aTQ2
vcv2ydZvPL9X0cjHwc611JydYy0TzPWHZGcilAsmDeinNufJlDie/FvWGvsDPhZ3
u4zIcb/tdH5l37OhsjBprCyeCWKw6LOXryRCBO27zFHg/uF0snIcBd9mY/j26Okr
BWke427hxeEPRvn/kz/0bRl8KkxIT7fPy9P6IzMD4IAC/wS5ZO7Pppld3LycVzA5
LDqSFTWhIa5kYvvWvrSRuhKerbKToQBSh9ZJdw76s0drOzSv+T0=
=hXmS
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
