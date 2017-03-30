Received: from eggs.gnu.org ([2001:4830:134:3::10]:36029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cte8O-00066a-Sy
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cte8M-0004uK-2p
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:20 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34993)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cte8L-0004th-VO
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:45:18 -0400
Received: by mail-qt0-x243.google.com with SMTP id r5so7177442qtb.2
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 10:45:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490871151-29029-1-git-send-email-peter.maydell@linaro.org>
	<1490871151-29029-2-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <55744a0d-ab95-a8f6-ac53-f317817d7a3e@amsat.org>
Date: Thu, 30 Mar 2017 14:45:00 -0300
MIME-Version: 1.0
In-Reply-To: <1490871151-29029-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 1/2] tcg/sparc: Zero extend data
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

On 03/30/2017 07:52 AM, Peter Maydell wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> v1->v2: fix incorrect argument order to emit_extend() for
> sparc32 codepath; switch on op & MO_SIZE rather than just op.
> ---
>  tcg/sparc/tcg-target.inc.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/tcg/sparc/tcg-target.inc.c b/tcg/sparc/tcg-target.inc.c
> index d1f4c0d..ab34039 100644
> --- a/tcg/sparc/tcg-target.inc.c
> +++ b/tcg/sparc/tcg-target.inc.c
> @@ -843,6 +843,29 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
>  static tcg_insn_unit *qemu_ld_trampoline[16];
>  static tcg_insn_unit *qemu_st_trampoline[16];
>
> +static void emit_extend(TCGContext *s, TCGReg r, int op)
> +{
> +    /* Emit zero extend of 8, 16 or 32 bit data as
> +     * required by the MO_* value op; do nothing for 64 bit.
> +     */
> +    switch (op & MO_SIZE) {
> +    case MO_8:
> +        tcg_out_arithi(s, r, r, 0xff, ARITH_AND);
> +        break;
> +    case MO_16:
> +        tcg_out_arithi(s, r, r, 16, SHIFT_SLL);
> +        tcg_out_arithi(s, r, r, 16, SHIFT_SRL);
> +        break;
> +    case MO_32:
> +        if (SPARC64) {
> +            tcg_out_arith(s, r, r, 0, SHIFT_SRL);
> +        }
> +        break;
> +    case MO_64:
> +        break;
> +    }
> +}
> +
>  static void build_trampolines(TCGContext *s)
>  {
>      static void * const qemu_ld_helpers[16] = {
> @@ -910,6 +933,7 @@ static void build_trampolines(TCGContext *s)
>          qemu_st_trampoline[i] = s->code_ptr;
>
>          if (SPARC64) {
> +            emit_extend(s, TCG_REG_O2, i);
>              ra = TCG_REG_O4;
>          } else {
>              ra = TCG_REG_O1;
> @@ -925,6 +949,7 @@ static void build_trampolines(TCGContext *s)
>                  tcg_out_arithi(s, ra, ra + 1, 32, SHIFT_SRLX);
>                  ra += 2;
>              } else {
> +                emit_extend(s, ra, i);
>                  ra += 1;
>              }
>              /* Skip the oi argument.  */
>
