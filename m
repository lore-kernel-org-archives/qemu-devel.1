Received: from eggs.gnu.org ([2001:4830:134:3::10]:36644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj23Z-00039R-R8
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fj23Y-0006hB-PZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:17 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:32883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fj23Y-0006go-Hp
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 08:41:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id g6-v6so4936317wrp.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 05:41:16 -0700 (PDT)
Date: Fri, 27 Jul 2018 13:41:11 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180727124111.GB28555@stefanha-x1.localdomain>
References: <20180716104744.11105-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20180716104744.11105-1-contrib@steffen-goertz.de>
Subject: Re: [Qemu-devel] [RFC v2 1/2] arm: Add nRF51 GPIO peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Steffen =?iso-8859-1?Q?G=F6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2018 at 12:47:43PM +0200, Steffen G=F6rtz wrote:
> Signed-off-by: Steffen G=F6rtz <contrib@steffen-goertz.de>
> ---
>  Changes in v2:
>    - Only call QEMU GPIO update handlers if value changes
>    - Code style changes
>    - Removed unused includes
>=20
>  hw/gpio/Makefile.objs        |   1 +
>  hw/gpio/nrf51_gpio.c         | 320 +++++++++++++++++++++++++++++++++++
>  include/hw/gpio/nrf51_gpio.h |  57 +++++++
>  3 files changed, 378 insertions(+)
>  create mode 100644 hw/gpio/nrf51_gpio.c
>  create mode 100644 include/hw/gpio/nrf51_gpio.h

Hi Steffen,
Sorry I didn't see this patch series.  Please email stefanha@redhat.com
in the future.  The way I have GMail set up means qemu-devel threads
with stefanha@gmail.com CCed are not brought to my attention immediately.

I have checked the nRF51 GPIO documentation and your implementation
looks good.

> +static void gpio_write(void *opaque, hwaddr offset,
> +                       uint64_t value, unsigned int size)
> +{
> +    Nrf51GPIOState *s =3D NRF51_GPIO(opaque);
> +    size_t idx;
> +
> +    switch (offset) {
> +    case NRF51_GPIO_REG_OUT:
> +        DPRINTF("write out=3D0x%" PRIx32 "\n", (uint32_t)value);
> +        s->out =3D value;
> +        gpio_update_state(s);
> +        break;
> +    case NRF51_GPIO_REG_OUTSET:
> +        DPRINTF("set out=3D0x%" PRIx32 "\n", (uint32_t)value);
> +        s->out |=3D value;
> +        gpio_update_state(s);
> +        break;
> +    case NRF51_GPIO_REG_OUTCLR:
> +        DPRINTF("clr out=3D0x%" PRIx32 "\n", (uint32_t)value);
> +        s->out &=3D ~value;
> +        gpio_update_state(s);
> +        break;
> +    case NRF51_GPIO_REG_DIR:
> +        DPRINTF("write dir=3D0x%" PRIx32 "\n", (uint32_t)value);
> +        s->dir =3D value;
> +        /* direction is exposed in both the DIR register and the DIR bit
> +         * of each PINs CNF configuration register. */
> +        for (size_t i =3D 0; i < NRF51_GPIO_PINS; i++) {
> +            s->cnf[i] =3D (s->cnf[i] & ~(1UL)) | ((value >> i) & 0x01);
> +        }
> +        gpio_update_state(s);
> +        break;

Missing DIRSET and DIRCLR?

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWxLnAAoJEJykq7OBq3PIzyUIAKpUheESBhZC85N1MJAv4mk1
/npKRBuN+H1WgQDpbzfl2AGbbAB+EkoKZIII3poxgjIKo3T/BIhrKcMVcpZJDwY3
ZVhyGFs3QB0GWqa6IqDr/2k4Y9XW6MMpchuyOnN4V+1KUfbXCpOrwDGZOfh9zIIa
mGodlRDDCkyHqyuNgGHPa20NF9pelJXwzwIU9RojCSWeWAGvvJ8MGZPANEF7cndi
R4rXQFcl2/i1P9SuX71nfgotl6ndbaOwYyqy5jjX/vzy9ieMj+dy/E5rX9crDuqP
ke+2yin7+Revjmpi+ofoDIqHQ0BaiwmSk2vFMvZki2jMeMXt7RInVhDyImxSj9E=
=p1YQ
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
