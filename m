Received: from eggs.gnu.org ([209.51.188.92]:60429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMa62-0000RA-Dk
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hMa60-0006oz-Tu
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:27:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hMa60-0006m1-LE
	for qemu-devel@nongnu.org; Fri, 03 May 2019 11:27:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id c12so8384426wrt.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 08:27:31 -0700 (PDT)
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
	<20190502143409.59600-13-ysato@users.sourceforge.jp>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190502143409.59600-13-ysato@users.sourceforge.jp>
Date: Fri, 03 May 2019 16:27:29 +0100
Message-ID: <87muk34kym.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit
 and 16bit register macros.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>


Yoshinori Sato <ysato@users.sourceforge.jp> writes:

> Some RX peripheral using 8bit and 16bit registers.
> Added 8bit and 16bit APIs.

Doesn't this mean the build breaks at some point? Features used by other
patches should be introduced first so the build remains bisectable.

>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/hw/registerfields.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
> index 2659a58737..51bfd0cf67 100644
> --- a/include/hw/registerfields.h
> +++ b/include/hw/registerfields.h
> @@ -22,6 +22,14 @@
>      enum { A_ ## reg =3D (addr) };                                      =
    \
>      enum { R_ ## reg =3D (addr) / 4 };
>
> +#define REG8(reg, addr)                                                 =
 \
> +    enum { A_ ## reg =3D (addr) };                                      =
    \
> +    enum { R_ ## reg =3D (addr) };
> +
> +#define REG16(reg, addr)                                                =
  \
> +    enum { A_ ## reg =3D (addr) };                                      =
    \
> +    enum { R_ ## reg =3D (addr) / 2 };
> +
>  /* Define SHIFT, LENGTH and MASK constants for a field within a register=
 */
>
>  /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_=
LENGTH
> @@ -40,6 +48,8 @@
>  #define FIELD_EX64(storage, reg, field)                                 =
  \
>      extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
>                R_ ## reg ## _ ## field ## _LENGTH)
> +#define FIELD_EX8  FIELD_EX32
> +#define FIELD_EX16 FIELD_EX32

Hmm maybe we should be defining extract16/extract8 in bitops so things
are a) properly types and b) bounds checked to catch errors.

>
>  /* Extract a field from an array of registers */
>  #define ARRAY_FIELD_EX32(regs, reg, field)                              =
  \
> @@ -49,6 +59,22 @@
>   * Assigning values larger then the target field will result in
>   * compilation warnings.
>   */
> +#define FIELD_DP8(storage, reg, field, val) ({                          =
  \
> +    struct {                                                            =
  \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> +    } v =3D { .v =3D val };                                             =
      \
> +    uint8_t d;                                                          =
  \
> +    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> +    d; })
> +#define FIELD_DP16(storage, reg, field, val) ({                         =
  \
> +    struct {                                                            =
  \
> +        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> +    } v =3D { .v =3D val };                                             =
      \
> +    uint16_t d;                                                         =
  \
> +    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
> +                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
> +    d; })
>  #define FIELD_DP32(storage, reg, field, val) ({                         =
  \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
> @@ -57,7 +83,7 @@
>      d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
>                    R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
>      d; })
> -#define FIELD_DP64(storage, reg, field, val) ({                         =
  \
> +#define FIELD_DP64(storage, reg, field, val) ({                         \
>      struct {                                                            =
  \
>          unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
>      } v =3D { .v =3D val };                                             =
      \


--
Alex Benn=C3=A9e
