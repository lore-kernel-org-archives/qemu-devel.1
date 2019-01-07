Received: from eggs.gnu.org ([209.51.188.92]:54249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVav-00035F-0c
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggVau-0000VR-2r
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:09:32 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggVas-0000US-3c
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 09:09:30 -0500
Received: by mail-ot1-x341.google.com with SMTP id w25so358949otm.13
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 06:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20181214052410.11863-1-richard.henderson@linaro.org>
	<20181214052410.11863-24-richard.henderson@linaro.org>
In-Reply-To: <20181214052410.11863-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 14:09:15 +0000
Message-ID: <CAFEAcA-Us3KWaLSEkvpg2uE+yvRFbVB=NVemrdhTFfvKxZt3xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 23/27] target/arm: Implement
 pauth_computepac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 14 Dec 2018 at 05:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is the main crypto routine, an implementation of QARMA.
> This matches, as much as possible, ARM pseudocode.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper-a64.c | 241 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 240 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 19486b9677..1da7867a42 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1057,10 +1057,249 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
>   * Helpers for ARMv8.3-PAuth.
>   */
>
> +static uint64_t pac_cell_shuffle(uint64_t i)
> +{
> +    uint64_t o = 0;
> +
> +    o |= extract64(i, 52, 4);
> +    o |= extract64(i, 24, 4) << 4;
> +    o |= extract64(i, 44, 4) << 8;
> +    o |= extract64(i,  0, 4) << 12;
> +
> +    o |= extract64(i, 28, 4) << 16;
> +    o |= extract64(i, 48, 4) << 20;
> +    o |= extract64(i,  4, 4) << 24;
> +    o |= extract64(i, 40, 4) << 28;
> +
> +    o |= i & MAKE_64BIT_MASK(32, 4);

Can't we just use
       o |= extract64(i, 32, 4) << 32;
to stay parallel with everything else?
Similarly below.

> +    o |= extract64(i, 12, 4) << 36;
> +    o |= extract64(i, 56, 4) << 40;
> +    o |= extract64(i,  8, 4) << 44;

The pseudocode in the DDI0487D.a Arm Arm says that bits
outdata<47:44> are indata<23:20>...

> +
> +    o |= extract64(i, 36, 4) << 48;
> +    o |= extract64(i, 16, 4) << 52;

...and these don't match either...

> +    o |= extract64(i, 40, 4) << 56;

and this definitely looks wrong as we've already used
bits 43:40 earlier.

> +    o |= i & MAKE_64BIT_MASK(60, 4);
> +
> +    return o;
> +}

> +static int rot_cell(int cell, int n)
> +{
> +    cell |= cell << 4;
> +    cell >>= n;
> +    return cell & 0xf;

This doesn't seem to do what the RotCell pseudocode does?
Unless I've made an error, RotCell(ABCD, 1) == BCDA,
but rot_cell(ABCD, 1) == DABC.

> +}
> +
> +static uint64_t pac_mult(uint64_t i)
> +{
> +    uint64_t o = 0;
> +    int b;
> +
> +    for (b = 0; b < 4 * 4; b += 4) {
> +        int i0, i4, i8, ic, t0, t1, t2, t3;
> +
> +        i0 = extract64(i, b, 4);
> +        i4 = extract64(i, b + 4 * 4, 4);
> +        i8 = extract64(i, b + 8 * 4, 4);
> +        ic = extract64(i, b + 12 * 4, 4);
> +
> +        t0 = rot_cell(i8, 1) ^ rot_cell(i4, 2) ^ rot_cell(i0, 1);
> +        t1 = rot_cell(ic, 1) ^ rot_cell(i4, 1) ^ rot_cell(i0, 2);
> +        t2 = rot_cell(ic, 2) ^ rot_cell(i8, 1) ^ rot_cell(i0, 1);
> +        t3 = rot_cell(ic, 2) ^ rot_cell(i8, 2) ^ rot_cell(i4, 1);

Shouldn't the first term for t3 be rot_cell(ic, 1) ?

> +
> +        o |= (uint64_t)t3 << b;
> +        o |= (uint64_t)t2 << (b + 4 * 4);
> +        o |= (uint64_t)t1 << (b + 8 * 4);
> +        o |= (uint64_t)t0 << (b + 12 * 4);
> +    }
> +    return o;
> +}

thanks
-- PMM
