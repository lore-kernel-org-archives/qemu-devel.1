Received: from eggs.gnu.org ([2001:4830:134:3::10]:47981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cstQh-0006w1-Fk
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cstQb-0000W8-LG
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:53:07 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:35149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cstQb-0000Vz-I5
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 11:53:01 -0400
Received: by mail-qk0-x243.google.com with SMTP id f11so10038159qkb.2
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 08:53:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490630670-15818-1-git-send-email-peter.maydell@linaro.org>
	<1490630670-15818-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3d738f84-7708-0578-0e83-5434f43aa928@amsat.org>
Date: Tue, 28 Mar 2017 12:52:54 -0300
MIME-Version: 1.0
In-Reply-To: <1490630670-15818-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 1/2] tcg/sparc: Zero extend data
 argument to store helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, patches@linaro.org

Hi Peter,

On 03/27/2017 01:04 PM, Peter Maydell wrote:
> The C store helper functions take the data argument as a uint8_t,
> uint16_t, etc depending on the store size. The SPARC calling
> convention requires that data types smaller than the register
> size must be extended by the caller. We weren't doing this,
> which meant that if QEMU was compiled with optimizations enabled
> we could end up storing incorrect values to guest memory.
> (In particular the i386 guest BIOS would crash on startup.)
>
> Add code to the trampolines that call the store helpers to
> do the zero extension as required.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tcg/sparc/tcg-target.inc.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d1f4c0d..548bea2 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -843,6 +843,31 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>  static tcg_insn_unit *qemu_ld_trampoline[16];
>  static tcg_insn_unit *qemu_st_trampoline[16];
>
> +static void emit_extend(TCGContext *s, TCGReg r, int op)
> +{
> +    /* Emit zero extend of 8, 16 or 32 bit data as
> +     * required by the MO_* value op; do nothing for 64 bit.
> +     */
> +    switch (op) {
> +    case MO_UB:
> +        tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
> +        break;
> +    case MO_LEUW:
> +    case MO_BEUW:
> +        tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
> +        tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
> +        break;
> +    case MO_LEUL:
> +    case MO_BEUL:
> +        if (SPARC64) {
> +            tcg_out_arith(s, r, r, 0, SHIFT_SRL);
> +        }
> +        break;
> +    default:
> +        break;
> +    }

it seems to me easier to read masking op:

     switch (op & MO_SIZE) {
     case MO_8:
         tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
         break;
     case MO_16:
         tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
         tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
         break;
     case MO_32:
         if (SPARC64) {
             tcg_out_arith(s, r, r, 0, SHIFT_SRL);
         }
         break;
     case MO_64:
         break;
     }

> +}
> +
>  static void build_trampolines(TCGContext *s)
>  {
>      static void * const qemu_ld_helpers[16] = {
> @@ -910,6 +935,7 @@ static void build_trampolines(TCGContext *s)
>          qemu_st_trampoline[i] = s->code_ptr;
>
>          if (SPARC64) {
> +            emit_extend(s, TCG_REG_O2, i);

shouldn't be inverting args?

                emit_extend(s, i, TCG_REG_O2);

>              ra = TCG_REG_O4;
>          } else {
>              ra = TCG_REG_O1;
> @@ -925,6 +951,7 @@ static void build_trampolines(TCGContext *s)
>                  tcg_out_arithi(s, ra, ra + 1, 32, SHIFT_SRLX);
>                  ra += 2;
>              } else {
> +                emit_extend(s, i, ra);
>                  ra += 1;
>              }
>              /* Skip the oi argument.  */
>

regards,

Phil.
