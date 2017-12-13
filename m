Received: from eggs.gnu.org ([2001:4830:134:3::10]:52184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ePEj2-00027k-Q9
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frasse.iglesias@gmail.com>) id 1ePEj1-0003fq-MP
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:38:00 -0500
MIME-Version: 1.0
In-Reply-To: <20171213051736.17755-4-f4bug@amsat.org>
References: <20171213051736.17755-1-f4bug@amsat.org>
	<20171213051736.17755-4-f4bug@amsat.org>
From: francisco iglesias <frasse.iglesias@gmail.com>
Date: Wed, 13 Dec 2017 22:37:55 +0100
Message-ID: <CAAYMZQuQv-yQA2keiq=9p95jQCSz3c=Dzjaygh=co=Q25ZKdxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] hw/registerfields: add 64-bit
 extract/deposit macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, qemu-trivial@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 13 December 2017 at 06:17, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
wrote:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/registerfields.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index ad9d7a82a3..f59e7f47bd 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -35,6 +35,9 @@
>  #define FIELD_EX32(storage, reg, field)
>  \
>      extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,
>  \
>                R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX64(storage, reg, field)
>  \
> +    extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,
>  \
> +              R_ ## reg ## _ ## field ## _LENGTH)
>
>  /* Extract a field from an array of registers */
>  #define ARRAY_FIELD_EX32(regs, reg, field)
> \
> @@ -52,6 +55,14 @@
>      d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,
>  \
>                    R_ ## reg ## _ ## field ## _LENGTH, v.v);
>  \
>      d; })
> +#define FIELD_DP64(storage, reg, field, val) ({
>  \
> +    struct {
> \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;
> \
>

Hi Phiilppe,

I'm just wondering if 'v' above maybe should be uint64_t? The size of
unsigned int seems to be 'implementation defined' but I would guess 32 bits
is not unsual. Basically wouldn't a field length > 32 above be problematic?

Best regards,
Francisco


> +    } v =3D { .v =3D val };
>  \
> +    uint64_t d;
>  \
> +    d =3D deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,
>  \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);
>  \
> +    d; })
>
>  /* Deposit a field to array of registers.  */
>  #define ARRAY_FIELD_DP32(regs, reg, field, val)
>  \
> --
> 2.15.1
>
>
>
