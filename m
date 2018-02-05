Received: from eggs.gnu.org ([2001:4830:134:3::10]:43670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eijRa-0006ic-Sy
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eijRW-00041b-Ki
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 11:16:34 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205105720.14620-1-peter.maydell@linaro.org>
	<20180205105720.14620-9-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3659e9bc-4b71-4785-22c7-e4cb97d7b241@amsat.org>
Date: Mon, 5 Feb 2018 13:16:21 -0300
MIME-Version: 1.0
In-Reply-To: <20180205105720.14620-9-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="2e2gyX4S7Y1newXgahIgqfrmIvPkXQiWE"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 8/8] hw/intc/armv7m_nvic: Fix
 byte-to-interrupt number conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2e2gyX4S7Y1newXgahIgqfrmIvPkXQiWE
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org
Message-ID: <3659e9bc-4b71-4785-22c7-e4cb97d7b241@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 8/8] hw/intc/armv7m_nvic: Fix byte-to-interrupt
 number conversions
References: <20180205105720.14620-1-peter.maydell@linaro.org>
 <20180205105720.14620-9-peter.maydell@linaro.org>
In-Reply-To: <20180205105720.14620-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 02/05/2018 07:57 AM, Peter Maydell wrote:
> In many of the NVIC registers relating to interrupts, we
> have to convert from a byte offset within a register set
> into the number of the first interrupt which is affected.
> We were getting this wrong for:
>  * reads of NVIC_ISPR<n>, NVIC_ISER<n>, NVIC_ICPR<n>, NVIC_ICER<n>,
>    NVIC_IABR<n> -- in all these cases we were missing the "* 8"
>    needed to convert from the byte offset to the interrupt number
>    (since all these registers use one bit per interrupt)
>  * writes of NVIC_IPR<n> had the opposite problem of a spurious
>    "* 8" (since these registers use one byte per interrupt)

What about using inline function (suggested) with those comments to ease
code review, since this code is kinda confusing at first.

>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

at any rate:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  hw/intc/armv7m_nvic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 8726be796e..9433efd1b8 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1721,7 +1721,7 @@ static MemTxResult nvic_sysreg_read(void *opaque,=
 hwaddr addr,
>          /* fall through */
>      case 0x180 ... 0x1bf: /* NVIC Clear enable */
>          val =3D 0;
> -        startvec =3D offset - 0x180 + NVIC_FIRST_IRQ; /* vector # */
> +        startvec =3D 8 * (offset - 0x180) + NVIC_FIRST_IRQ; /* vector =
# */

static uint32_t off2vec_rd(uint32_t offset, uint32_t base)
{
    return 8 * (offset - base) + NVIC_FIRST_IRQ;
}

> =20
>          for (i =3D 0, end =3D size * 8; i < end && startvec + i < s->n=
um_irq; i++) {
>              if (s->vectors[startvec + i].enabled &&
> @@ -1735,7 +1735,7 @@ static MemTxResult nvic_sysreg_read(void *opaque,=
 hwaddr addr,
>          /* fall through */
>      case 0x280 ... 0x2bf: /* NVIC Clear pend */
>          val =3D 0;
> -        startvec =3D offset - 0x280 + NVIC_FIRST_IRQ; /* vector # */
> +        startvec =3D 8 * (offset - 0x280) + NVIC_FIRST_IRQ; /* vector =
# */
>          for (i =3D 0, end =3D size * 8; i < end && startvec + i < s->n=
um_irq; i++) {
>              if (s->vectors[startvec + i].pending &&
>                  (attrs.secure || s->itns[startvec + i])) {
> @@ -1745,7 +1745,7 @@ static MemTxResult nvic_sysreg_read(void *opaque,=
 hwaddr addr,
>          break;
>      case 0x300 ... 0x33f: /* NVIC Active */
>          val =3D 0;
> -        startvec =3D offset - 0x300 + NVIC_FIRST_IRQ; /* vector # */
> +        startvec =3D 8 * (offset - 0x300) + NVIC_FIRST_IRQ; /* vector =
# */
> =20
>          for (i =3D 0, end =3D size * 8; i < end && startvec + i < s->n=
um_irq; i++) {
>              if (s->vectors[startvec + i].active &&
> @@ -1860,7 +1860,7 @@ static MemTxResult nvic_sysreg_write(void *opaque=
, hwaddr addr,
>      case 0x300 ... 0x33f: /* NVIC Active */
>          return MEMTX_OK; /* R/O */
>      case 0x400 ... 0x5ef: /* NVIC Priority */
> -        startvec =3D 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector =
# */
> +        startvec =3D (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */=


static uint32_t off2vec_wr(uint32_t offset, uint32_t base)
{
    return (offset - base) + NVIC_FIRST_IRQ;
}

> =20
>          for (i =3D 0; i < size && startvec + i < s->num_irq; i++) {
>              if (attrs.secure || s->itns[startvec + i]) {
>=20


--2e2gyX4S7Y1newXgahIgqfrmIvPkXQiWE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4g1UACgkQ4+MsLN6t
wN4+exAArV0Y7Bibg1at6fkDe/7ngIFhZaqtad0kZOhZzm1QLOAcbOAl3jB5pn8Y
o96PA9mg7h2K041nc0xPwATnE8arvb91sB47TuqZemkKbfMDwJa2C21I6lLdKP6x
u2C8BSOf2iK2HunGOq5NqW7kTmVLdilCqmdi/Im4yOP1//bCl2N0sxzr9s7MH4dQ
FUxC5y5vpLPPhsyBSklNvRf00LiQlKBJBHvfPYMKjWe6O0DyGkgdCrSzC41DoEy5
GWMnu3pb9dJzailBnmix+VLNBBWGNOIK0dT9BdFEtyd0sbsscoXUjZ+lCOmThUX9
U2BA+tfQIu2IbqGg0TArgeaqwaNt9+Mx6NESphit8AT/qRCjaQyNmh73D8C53CYH
GZbNKT5yCpMZC77pNnFJL6LflsdnH85bASdy8LeWQVqAqO/hIeKEMTOWV+KrzUPF
xhGJEe4KeQXuJzVuxI+Nem0zkG1teKosgcxTFL301jc7rH8xBRqRxVs9eU7ZjUNv
P0RGgo+WtqcvrdG9p6rQu8y0wGn1XpGPg1z94Hdx3/3ZI0uBKSGbILet6zvwNH8L
NkvIqSyrULxPMv4qlZrUxWBf0Q5CDU5Tsj3yjsI0v9dcQ6EnV2Pvrw12/NJqscCb
u8bg/k/kTT3MtHMVdVnwGBK7MVEYdTADmAQUm/EYPe534kyaDoQ=
=Ai9t
-----END PGP SIGNATURE-----

--2e2gyX4S7Y1newXgahIgqfrmIvPkXQiWE--
