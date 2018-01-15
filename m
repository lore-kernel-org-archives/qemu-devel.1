Received: from eggs.gnu.org ([2001:4830:134:3::10]:49464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaubu-0003H7-1k
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaubs-00025P-V6
	for qemu-devel@nongnu.org; Sun, 14 Jan 2018 21:34:54 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7aa6594-c3a3-fb42-9147-de8fcbddc848@amsat.org>
Date: Sun, 14 Jan 2018 23:34:40 -0300
MIME-Version: 1.0
In-Reply-To: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="EBpf3iNK9ynF8R5wab3NgIceFix7oOYvv"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH] hw/intc/armv7m: Support byte
 and halfword accesses to CFSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Andy Gross <andy.gross@linaro.org>, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EBpf3iNK9ynF8R5wab3NgIceFix7oOYvv
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Andy Gross <andy.gross@linaro.org>,
 patches@linaro.org
Message-ID: <f7aa6594-c3a3-fb42-9147-de8fcbddc848@amsat.org>
Subject: Re: [Qemu-arm] [PATCH] hw/intc/armv7m: Support byte and halfword
 accesses to CFSR
References: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512742372-31517-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 12/08/2017 11:12 AM, Peter Maydell wrote:
> The Configurable Fault Status Register for ARMv7M and v8M is
> supposed to be byte and halfword accessible, but we were only

"aligned halfword"

> implementing word accesses. Add support for the other access
> sizes, which are used by the Zephyr RTOS.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reported-by: Andy Gross <andy.gross@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 38 ++++++++++++++++++++++----------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 5d9c883..dc8e2f1 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -896,13 +896,6 @@ static uint32_t nvic_readl(NVICState *s, uint32_t =
offset, MemTxAttrs attrs)
>              val |=3D (1 << 8);
>          }
>          return val;
> -    case 0xd28: /* Configurable Fault Status.  */
> -        /* The BFSR bits [15:8] are shared between security states
> -         * and we store them in the NS copy
> -         */
> -        val =3D cpu->env.v7m.cfsr[attrs.secure];
> -        val |=3D cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK;
> -        return val;
>      case 0xd2c: /* Hard Fault Status.  */
>          return cpu->env.v7m.hfsr;
>      case 0xd30: /* Debug Fault Status.  */
> @@ -1280,15 +1273,6 @@ static void nvic_writel(NVICState *s, uint32_t o=
ffset, uint32_t value,
>          s->vectors[ARMV7M_EXCP_DEBUG].active =3D (value & (1 << 8)) !=3D=
 0;
>          nvic_irq_update(s);
>          break;
> -    case 0xd28: /* Configurable Fault Status.  */
> -        cpu->env.v7m.cfsr[attrs.secure] &=3D ~value; /* W1C */
> -        if (attrs.secure) {
> -            /* The BFSR bits [15:8] are shared between security states=

> -             * and we store them in the NS copy.
> -             */
> -            cpu->env.v7m.cfsr[M_REG_NS] &=3D ~(value & R_V7M_CFSR_BFSR=
_MASK);
> -        }
> -        break;
>      case 0xd2c: /* Hard Fault Status.  */
>          cpu->env.v7m.hfsr &=3D ~value; /* W1C */
>          break;
> @@ -1667,6 +1651,14 @@ static MemTxResult nvic_sysreg_read(void *opaque=
, hwaddr addr,
>              val =3D deposit32(val, i * 8, 8, get_prio(s, hdlidx, sbank=
));
>          }
>          break;
> +    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
> +        /* The BFSR bits [15:8] are shared between security states
> +         * and we store them in the NS copy
> +         */
> +        val =3D s->cpu->env.v7m.cfsr[attrs.secure];
> +        val |=3D s->cpu->env.v7m.cfsr[M_REG_NS] & R_V7M_CFSR_BFSR_MASK=
;
> +        val =3D extract32(val, (offset - 0xd28) * 8, size * 8);
> +        break;

we have:

static const MemoryRegionOps nvic_sysreg_ops =3D {
    .read_with_attrs =3D nvic_sysreg_read,
    .write_with_attrs =3D nvic_sysreg_write,
    .endianness =3D DEVICE_NATIVE_ENDIAN,
};

with:
    /* If true, unaligned accesses are supported.  Otherwise unaligned
     * accesses throw machine checks.
     */
    bool unaligned;

So unaligned halfword should throw excp.

We could add an explicit ".unaligned =3D false,"

>      case 0xfe0 ... 0xfff: /* ID.  */
>          if (offset & 3) {
>              val =3D 0;
> @@ -1765,6 +1757,20 @@ static MemTxResult nvic_sysreg_write(void *opaqu=
e, hwaddr addr,
>          }
>          nvic_irq_update(s);
>          return MEMTX_OK;
> +    case 0xd28 ... 0xd2b: /* Configurable Fault Status (CFSR) */
> +        /* All bits are W1C, so construct 32 bit value with 0s in
> +         * the parts not written by the access size
> +         */

This comment is welcomed :)

> +        value <<=3D ((offset - 0xd28) * 8);
> +
> +        s->cpu->env.v7m.cfsr[attrs.secure] &=3D ~value;
> +        if (attrs.secure) {
> +            /* The BFSR bits [15:8] are shared between security states=

> +             * and we store them in the NS copy.
> +             */
> +            s->cpu->env.v7m.cfsr[M_REG_NS] &=3D ~(value & R_V7M_CFSR_B=
FSR_MASK);
> +        }
> +        return MEMTX_OK;
>      }
>      if (size =3D=3D 4) {
>          nvic_writel(s, offset, value, attrs);

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--EBpf3iNK9ynF8R5wab3NgIceFix7oOYvv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpcE0AACgkQ4+MsLN6t
wN66+Q/+NJp31yn+AZFbouOhpDiAeWBU2Lh4L1vS/yMnbLA0lXlaIU8jfLkok/qP
oGaWAvehZQhNIoKAAfFwRUzNnNQaA5ktaxK6YfABWnjBfFvIesQKkKT5TSB8c0Lf
uR37EY05Eoq7cy2B3+7BqeXRKSIBTCTvzOf/LbPHLOYMLjzAdgPi+42VTvtHHsgE
Ls01tEvlDqoBan0Hu3uQFhZiE+NFJmJ65WqaeHaSSvyLGK+jts6pYjZg8p2r/3z6
bkfZI7ImUsjuy5MSlUYbinA8M0eMVNJvt/eQbosm+0X110d5caD61hphbIi/YF6o
dQj75R98Yjub1cAh6nbq5lc1ZiiVrc6JDaRXKxBdIugN9sI6j3bQ6pCmZVNaKj54
qMCv+JyEBbhwpUV3PBjCe5PK0KvsYMGkqssRP8zX90C1pY/B4N6a8CGLyK47ezNc
4JU6pLMaacxgUYly5OScvSkJSor5yYlvkhWqtRDLbhjRzlDyj+wtcX6Yam2Owi9S
tnIgAEYkDr1CvYNIFT7vaw/JtYxpwaO92rO9SMPw7t1fz/5nGe1CKeqFUdjn8/xU
n6LKoiaDGVk6Ovzbfc+5KrzaWyTyjWU9Rw5IF1EcPP4ucQWRB6tqYOJ0f6SIBnv9
xUWLrANfdVGX2QByTFfecPZqJaU/bOc8no8J/frVmHEOr5FShvc=
=rfbG
-----END PGP SIGNATURE-----

--EBpf3iNK9ynF8R5wab3NgIceFix7oOYvv--
